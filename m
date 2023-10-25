Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E160F7D71FE
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 19:02:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvhHD-0001or-Ni; Wed, 25 Oct 2023 13:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qvhGx-0001WP-Qo; Wed, 25 Oct 2023 13:02:24 -0400
Received: from mail-co1nam11on20611.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::611]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qvhGv-00079Z-VL; Wed, 25 Oct 2023 13:02:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q56lxoUndx2Y/50hLxV2w36DsBbPvgoJFoS8E1F/+6vp5ojdt5En821Vyl8B/F1gXSUvQ7IRfT7GY7/tdDj2XEcCoU9nnkFqYVAz8JBYMjwPGHIQVp/4Cu/qPPfwbumChItxRcr27Rpkj1TaQb0YP2E9WVxKWHsPd4ZeZnUQGpQsljednfruw/X+wEgdpMMaxb+oO4Qt8YdS4TIKvh6kzvjlx6w4Af1IkdsGvtvP1adIldjU4Ugf96OpSuxk3EgO4UQ6JgKCU82+C1d6T2fJpAm1zUHOzFDJ1AyUuzql3Cwn+zMrLzunhgn7LGYL7Gue1h3wr9KqojxuZ3VJgDw9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bo7PMRuy9RG0jg/Jc6rnNzLLpOfQG7/8n8+CWaVpUb0=;
 b=l/i3OYDQ7sQf+SFiewLYSz+XsJuSW6Z4qyUdUsg0v08DqugHSFejt+CeW1gUSARMf+qGZC1gKtkurcZoIGPHNU4x8ZirzMSuIsbQeOaERceHfKNjCIxUwgkaYcOsZC13Nt8N9SwA0JPuLxg5TTZ7bIV42Z1vr/ipPfge7NcmfRLJtIqvxE0Y/+ux8Mzx0mSZhpIeEqNHh3rbv+Zat3+rlYpmK9a63PHOQeyXIsHoaABq0gJUNwqRwjHRvxAboQ07WE+XeBu0reiU0tImI3kASLKPf+LHHj2q56XL36Lh3Wwm3Z9Yzt70hM4jWrRklsFG6TnykMnsP04jt8qfCb6o0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bo7PMRuy9RG0jg/Jc6rnNzLLpOfQG7/8n8+CWaVpUb0=;
 b=JJSBAUFzAlqVyM3lDxlGGiW5y4Tf057cieo5tyJYBEh5eHgAtBSd4n6oOpAQ0TfthjZ6mpcp+wcqJvIsGQItdG963ZHbHSB6Dw6r51koVX/SVc1Q0dF5OBlj4q67n2OuKwKVRbY6LfqofELw6j40PO178UStvt1gdhq/aBii+ag=
Received: from DM6PR17CA0006.namprd17.prod.outlook.com (2603:10b6:5:1b3::19)
 by SA1PR12MB7151.namprd12.prod.outlook.com (2603:10b6:806:2b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 17:02:17 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::7a) by DM6PR17CA0006.outlook.office365.com
 (2603:10b6:5:1b3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 17:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 17:02:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 12:02:16 -0500
Received: from luc-work-vm (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32 via Frontend
 Transport; Wed, 25 Oct 2023 12:02:15 -0500
Date: Wed, 25 Oct 2023 19:02:12 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 <qemu-trivial@nongnu.org>, <qemu-arm@nongnu.org>, Markus Armbruster
 <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov
 <andrew.smirnov@gmail.com>
Subject: Re: [PATCH 08/10] hw/arm/fsl-imx7: Remove 'hw/arm/boot.h' from header
Message-ID: <ZTlKFE1Km8IL8Wbu@luc-work-vm>
References: <20231025065316.56817-1-philmd@linaro.org>
 <20231025065316.56817-9-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231025065316.56817-9-philmd@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|SA1PR12MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b027f7-fcab-493d-1c23-08dbd57c24a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2saB2ulz4s3HPvwq1KgQSKWqz83WoVzJ+I/kJww5TaeRdUG9sYUPAJX0t+3CwqFMNksdls9smAO0I0Ytmrv3yDRTVSUj+02vh/bXEMfHt56N1lAf+KDQ98iSUF9scyeDFaKjHiJYdUlOChSyRzoXaNZ9SE25tB648A7bZbYffeQEdhliElwGnS4cpHKPB81ciCjMyTIgZNG9u08u392T4Arc4UVH3lfWaHMIEFAeWM/Je0MFMRXd+oX47QDg0sGu8O1JM2EJkELzzhV3pelQ4nt2yndSm+esTVWqpTvqhscuFMrq7GxrK+25F+8doA/a4o7f5KGnBuQn+Ch9YlqE9JCTAaAFGvhIRete1uucosLTGJbE6ichmO3sEkQwNAXAUt8CnF0guUU9LJJ5YcNyGiguweiprI06TK5wBYTk0lqPgsDQdz4kdXGHoZkvhOxIXXBuV17Fo0tFmgKAXKCPx0XIdunjUDXRALGmMvuTiWxMlS8L2MEo9Jyltufv3KjZD7m/sVmy+oM3veE/21apJRltcU/hunrjgVXaVUge7A5h2/8p52iA7edcEFZuz3TDrghDOTSruPtcIheKfPCvjnojcorpnD0m6rLfPfanAepX8+Se4FhK23ErrIBNyMOKFAJXY3sEGC8MVy6HGrScj9IUh9ci2QpBy4WgMoBiSGCXviq49IIqMCUCwav3jxcZAmaeoX4QGhbcd9eE5qMjTj7OSAvVCLNi3NfN9WbDmK6IeS9yDNknNoZdxL9De2Hk1C0V9KwLJx6bwI3/nC/Cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(33716001)(55016003)(40460700003)(83380400001)(8936002)(36860700001)(2906002)(26005)(44832011)(8676002)(82740400003)(47076005)(81166007)(426003)(336012)(356005)(40480700001)(9686003)(4326008)(478600001)(316002)(6916009)(5660300002)(6666004)(41300700001)(70206006)(54906003)(86362001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 17:02:16.9162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b027f7-fcab-493d-1c23-08dbd57c24a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7151
Received-SPF: softfail client-ip=2a01:111:f400:7eab::611;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 08:53 Wed 25 Oct     , Philippe Mathieu-Daudé wrote:
> "hw/arm/boot.h" is only required on the source file.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Luc Michel <luc.michel@amd.com>

> ---
>  include/hw/arm/fsl-imx7.h | 1 -
>  hw/arm/mcimx7d-sabre.c    | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
> index 2cbfc6b2b2..411fa1c2e3 100644
> --- a/include/hw/arm/fsl-imx7.h
> +++ b/include/hw/arm/fsl-imx7.h
> @@ -19,7 +19,6 @@
>  #ifndef FSL_IMX7_H
>  #define FSL_IMX7_H
> 
> -#include "hw/arm/boot.h"
>  #include "hw/cpu/a15mpcore.h"
>  #include "hw/intc/imx_gpcv2.h"
>  #include "hw/misc/imx7_ccm.h"
> diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
> index d1778122b6..693a1023b6 100644
> --- a/hw/arm/mcimx7d-sabre.c
> +++ b/hw/arm/mcimx7d-sabre.c
> @@ -15,6 +15,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/arm/fsl-imx7.h"
> +#include "hw/arm/boot.h"
>  #include "hw/boards.h"
>  #include "hw/qdev-properties.h"
>  #include "qemu/error-report.h"
> --
> 2.41.0
> 
> 

-- 

