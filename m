Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0747D71FF
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 19:02:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvhHG-00025I-6r; Wed, 25 Oct 2023 13:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qvhHC-0001ov-EV; Wed, 25 Oct 2023 13:02:38 -0400
Received: from mail-dm6nam10on20608.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::608]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qvhHA-0007BT-Hw; Wed, 25 Oct 2023 13:02:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TllV78PvG942nfgQrblEAehi309ejEDik4mCeiP+nalI/xaO7lVE0O9IMyLWzU+r9d1O3UtPpnHlRF1Y3pvtz7po4BJQUPyVNFbrN8kfBsMAbotgn47R5F2m1xMDxnMsm4ZiavMExYhqmSQY+qZItNfohFDo7QrmRJk6i7w6kf/K8SjlNaz5ZmY22aUEcoEtQlRlCgqHKobTfrWTG4LwLHfyP0NTwdk1+56tgUgtToinXM/MbR+mgTF8bAsCR7JqvL2EKm5p3ZrMNO4bD+YcG9/rMcZw8f9NwAn1Rq43qfrdVc+CMfvCuhVRDJyg9XDzXVDMracGIXKPvG+DiwWAOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rVywNPwsTf4utxKJTssC/2xLcblsVNc5VHQ+R/M3XQ=;
 b=VvLE31W/JVrhNwR6y86qrkBzTlTFLTlz/2QgDtXzTQPfjbcnZZs1vTfTugJfjXvBuwV1xMWBUklV9TXEAMBOXOcdXVi/dxVBw6y+AagsoOlTm0mkpU4jqAO1biOjj7HpG6tws3UvR7zQp5HN4lqL8Ruzn5juUq5y1F8WqU90JT1ICBuc3kySR8tCE0b51VQ/U2dDUJlgVvmKbanWrw34LNlTd6ONM1jLngH5ue33FH0CChuTjmhb12N3o04Lfqg6j1qmPA+yBmHeaDQ2r/GNENvrAkeB6JUockL3eJWbcG+cYCbguuSa2zV9OVtFgwGdvzGgd1ecyDQD61QIVFVdOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rVywNPwsTf4utxKJTssC/2xLcblsVNc5VHQ+R/M3XQ=;
 b=sEUtHIFKWJ2qhzk1r9QTJTMaQh/EVG1V5VIX+fSte0xy0WNYtxhDMt8S0tsEykBE6xFxhpAy+S6w6MkkYD0E+p7X1btEivOvZkAzs/JxxsU7QgxAAIqNdPiWwF8ipdlHuTBi07Xe0hUUO2zxGb6FplyQbhGimzXh7SmOtDJFZD0=
Received: from DM6PR17CA0013.namprd17.prod.outlook.com (2603:10b6:5:1b3::26)
 by SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 17:02:32 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::a1) by DM6PR17CA0013.outlook.office365.com
 (2603:10b6:5:1b3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Wed, 25 Oct 2023 17:02:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 17:02:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 12:02:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 12:02:30 -0500
Received: from luc-work-vm (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32 via Frontend
 Transport; Wed, 25 Oct 2023 12:02:29 -0500
Date: Wed, 25 Oct 2023 19:02:27 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 <qemu-trivial@nongnu.org>, <qemu-arm@nongnu.org>, Markus Armbruster
 <armbru@redhat.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH 09/10] hw/arm/xlnx-versal: Remove 'hw/arm/boot.h' from
 header
Message-ID: <ZTlKI+p2FJLi4pYC@luc-work-vm>
References: <20231025065316.56817-1-philmd@linaro.org>
 <20231025065316.56817-10-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231025065316.56817-10-philmd@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|SJ0PR12MB5469:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ccbe062-a31f-4d62-c983-08dbd57c2d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: srH3/59aJB/fKrhOKKgMXX++r4cO4f2Vwtcqx6fqcdRlSZECrlhSBa3vUSUQJp0uh2UpoK83jCdmuWaLJxJnQtNFpV5YsIXogPbchLD22zb0PU9jRco8pVZyVi4WMNmh6t+qm9tExy7GTLXy9S01bkoYij8uukSXPkVZgXIBvHx/7DiHKpyITpG0S0YMhY2mysQO+hzD43kE14os8FhyGdgez7XaopZnPWopzs3LX2E1+81L+Oc+Ki2t4UhtP9M3JRzlIycc5VCiBVXGKM0Ovl5gZZo9zmNM0pcN5sEMHq+ymMIO1cCSOkfNsjR67ZCDffBmpCr04QMVH40kMbrgNwJDT5hrLzoB0Zlo407j1EOwRU5yiwYNLg7q7zsHdjost5DwWvABr0g/8L0oSvqoGKiMRfHJskTJRYUhJi5mpt+rx6TUo+v/B7aAcu3bvZrE6ZqOr8yvk7+GyIydRwen4TOwDFJ4XlTqhoQr1FaEH6ASng4Gdt9bVoB326DCMm/oI64MoQkcFhxQpjuWSiOLaDvX5OuwnuJi0pGpGyAgMaEhYyg4xmPDss3iMBUX3L5JYv9LPKKGceA1Sdy87bXErmTmcNpV0onhnCSdzkXDVTEH2DVmP/biXFrxkhqRHolm2QPt6b+oe+SX8YnWLu28UkHizPfs4yr+K80usnz0YmgQU6T7oAbUsD7kzCQFrSqzS23Du31PM57wthk8enkEDrJIIQZOy9BJCx8S3sOIeA+W/RTGeqB4m9CsYQOLTbpz+AG6pcdG7eoPJSXHcZSAKYbWVTN+vYrxep5e9+/zCxk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(82310400011)(1800799009)(451199024)(64100799003)(186009)(46966006)(40470700004)(36840700001)(2906002)(5660300002)(41300700001)(44832011)(55016003)(40480700001)(40460700003)(8936002)(8676002)(4326008)(82740400003)(336012)(426003)(83380400001)(54906003)(70586007)(316002)(70206006)(6916009)(9686003)(26005)(86362001)(33716001)(356005)(36860700001)(81166007)(47076005)(478600001)(67856001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 17:02:31.4787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccbe062-a31f-4d62-c983-08dbd57c2d4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5469
Received-SPF: softfail client-ip=2a01:111:f400:7e88::608;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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
>  include/hw/arm/xlnx-versal.h | 1 -
>  hw/arm/xlnx-versal-virt.c    | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 7b419f88c2..b710d71fb0 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -13,7 +13,6 @@
>  #define XLNX_VERSAL_H
> 
>  #include "hw/sysbus.h"
> -#include "hw/arm/boot.h"
>  #include "hw/cpu/cluster.h"
>  #include "hw/or-irq.h"
>  #include "hw/sd/sdhci.h"
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 88c561ff63..537118224f 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -19,6 +19,7 @@
>  #include "cpu.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/arm/xlnx-versal.h"
> +#include "hw/arm/boot.h"
>  #include "qom/object.h"
> 
>  #define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("xlnx-versal-virt")
> --
> 2.41.0
> 
> 

-- 

