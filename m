Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 145BB7D71FA
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 19:02:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvhGR-0000RT-Oy; Wed, 25 Oct 2023 13:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qvhGE-0000J3-Po; Wed, 25 Oct 2023 13:01:42 -0400
Received: from mail-dm6nam11on20625.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::625]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qvhGA-000734-Kf; Wed, 25 Oct 2023 13:01:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3Xh4s4Iv2E8lijVhy2R9LKY2r/L0SIZSBjmd351N2ryEOnMEAUG+s8+Kzq/VpadKJ1lO9njiy5y39cfCW4KLzlGdo8aF3YDMg9sRaiBonvmcLnDU+AUuRiq2UO7hpFFhln/LTkL0pMg3K1GChUpch1BTnRTL3R4rkN5mCQUwcxGqoyr3cGnoinKFmbCvYaXmBKzezQV44C7cMj5NhuPqil5CvIVxbcmZyZxIdvCS4fEZoiAKqWSjnhD7B/yR0NVfYT9JdSQ+XYNCAhUpXrluJ3Q2jJwSFSbh3p2Z5vN2zHXzhxKaB7aU1MwMmiLgkmZELnnxp9IneBZZaVOtXhEfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXNEahsAmZzj6JNGjhJxvTleztRGE+5kR7B0BkI4Lk0=;
 b=a1fcJIUMGqXJ4B58lVo8p1MCkbCQjrGTD44kgW76iih1CU62YxKR4XRGSZR8Rw8ve2A7lD/5nZoXjJjG0G6gl0Fr5n4hLohutMg+Y9i0SP0VHgUGHghM+wP49708tzobnMAnWAVz1KnN6u+uDkgVM23YcMgVllPOXPjyCFbJn+WrfaYLhsOTdTbuGGkhsu40NyV2NsGzVTtE3pwBsSbbNftA0PS5Cu46a7eZ6tEDkqPniVaoaVpwUbO+F0QAAk5m3ymqGkCa3kjj6ufTZzdSgpBOx5fX4yiFtd7zEmfffP3QW0OR+8paR5Pt3OlH/BZgNR4sxrZsAvF9C855duYAQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXNEahsAmZzj6JNGjhJxvTleztRGE+5kR7B0BkI4Lk0=;
 b=pGNr4k7uSg5O2p1EpDAKj/gOUGCx+F2dBPt0uynlaGCfrBmElWrlbNmEl64+1k7z3MF2V1LFsOuudWyg/gbOBxuLjyOYRgs4xXFMtYn2bmnSq5of2yWWCfNhtT5tS75UuK7CyzXaC/s7BcBKUx8oo1u5Br3z3FNc5rHHNwTTCAQ=
Received: from DM6PR14CA0054.namprd14.prod.outlook.com (2603:10b6:5:18f::31)
 by SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 25 Oct
 2023 17:01:21 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:5:18f:cafe::22) by DM6PR14CA0054.outlook.office365.com
 (2603:10b6:5:18f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 17:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 17:01:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 12:01:20 -0500
Received: from luc-work-vm (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32 via Frontend
 Transport; Wed, 25 Oct 2023 12:01:18 -0500
Date: Wed, 25 Oct 2023 19:01:11 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 <qemu-trivial@nongnu.org>, <qemu-arm@nongnu.org>, Markus Armbruster
 <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 05/10] hw/arm/fsl-imx31: Remove 'hw/arm/boot.h' from header
Message-ID: <ZTlJ1xHSPXLy2ity@luc-work-vm>
References: <20231025065316.56817-1-philmd@linaro.org>
 <20231025065316.56817-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231025065316.56817-6-philmd@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|SN7PR12MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: cd46d3b5-d0d8-4d34-c7be-08dbd57c032d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YwuYrhaLiA2qpz6wHT8vyRJuIBM08C6uLfldJ1pcoaf4SSXyXolC/RbBp19zE6BSleeWh/FRmn2vuSz7oAnJjITNXp083aXhz2a32XNrPb4Jf67tGSmmkZ0SwcHNFWKDlPJEltqTgIPufhmEVi3YpWj4tIFuxhIwPDkElo5ej1pKX22hISvRs5bGXIT7UOwDmRaXKL6/QzNYYEuQjgWK3sO5VM0/eN9e7IV3hmL3OV5d6jmeoATx6hua4R68UdXIGybnXhdd4wsoDyeflhjOr0vLlW2yBxTLRiQBz8qPbVHVG4fpMvBzQLkRaahbOKIWJWqcFr5/1WK1ACrRppl6VTmhnsp2UBRm7+6L8hwnCvYeJNZmnvAYgCYcVNSlHkJxJxl8U0fKu+y86UVdLVnPYnalhOeX1QUVDeneo++jcyyZBzciX4dHI8UXQfUfE34h91eV1ANc+6YOunm/RP5pmNJZyhzJBXjfIJwyhkC3IBqUIMGFZIlaLvolABdC2VZCeGUvUOAseNhqLU30jUj3duQ3lIXENu7k4Vqasz0JGQ2tq2sVuAtOEUUjG+Obhwh79yXebf+K3xln4mrEpoOr4bHSjtO7sEf02ZJrtXaptJK1JR40zib2iyQV5iaO2IeDn15sBEgahb8kUc7NRfpaszRYitfEUjpzbvBQxfVILHVcWVhq1/7TWQCUL8nk7noyD+xU1h0mHLEJMZ/6mFIlzIDCNOeGyYtuNsADL1ZoJO/escS3O6yYt29JApegBpMwglWapB5ODVmM97IVmdmPRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(82310400011)(64100799003)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(316002)(26005)(40460700003)(55016003)(9686003)(2906002)(36860700001)(70206006)(426003)(6666004)(83380400001)(8936002)(82740400003)(8676002)(41300700001)(47076005)(4326008)(33716001)(5660300002)(54906003)(44832011)(478600001)(81166007)(356005)(6916009)(70586007)(336012)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 17:01:20.8112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd46d3b5-d0d8-4d34-c7be-08dbd57c032d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6767
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::625;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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
>  include/hw/arm/fsl-imx31.h | 1 -
>  hw/arm/kzm.c               | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/arm/fsl-imx31.h b/include/hw/arm/fsl-imx31.h
> index c116a73e0b..40c593a5cf 100644
> --- a/include/hw/arm/fsl-imx31.h
> +++ b/include/hw/arm/fsl-imx31.h
> @@ -17,7 +17,6 @@
>  #ifndef FSL_IMX31_H
>  #define FSL_IMX31_H
> 
> -#include "hw/arm/boot.h"
>  #include "hw/intc/imx_avic.h"
>  #include "hw/misc/imx31_ccm.h"
>  #include "hw/char/imx_serial.h"
> diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
> index b1b281c9ac..9be91ebeaa 100644
> --- a/hw/arm/kzm.c
> +++ b/hw/arm/kzm.c
> @@ -16,6 +16,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/arm/fsl-imx31.h"
> +#include "hw/arm/boot.h"
>  #include "hw/boards.h"
>  #include "qemu/error-report.h"
>  #include "exec/address-spaces.h"
> --
> 2.41.0
> 
> 

-- 

