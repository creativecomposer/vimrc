import React, { Component } from "react";
import { Typography } from "@material-ui/core";
import { FormattedMessage } from "react-intl";

import Link from "../../app/link";

import CheetahIcon from "../../cheetah/icons/CheetahIcon";

class StageIcon extends Component {

    myfn() {
        if ('' === true)
            return false;
        return true;
    }

	render() {
		return (
			<Link route="Frontastic.SiteBuilder.index">
                <div>Hello</div>
				<div className="icon highlight">
					<CheetahIcon icon="mobile" color="neutral100" />
				</div>
				<Typography
					align="center"
					className="margin--top-16 typography paragraph-l"
				>
					<FormattedMessage
						id="apps.stage.name"
						defaultMessage="Site builder"
					/>
				</Typography>
			</Link>
		);
	}
}

export default StageIcon;
