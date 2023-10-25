Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 303707D71F7
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 19:01:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvhFL-0006Of-3o; Wed, 25 Oct 2023 13:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qvhFH-0006A0-6o; Wed, 25 Oct 2023 13:00:40 -0400
Received: from mail-bn7nam10on20615.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::615]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qvhF9-0006rt-OS; Wed, 25 Oct 2023 13:00:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekwSYsNgI7Xctr5wDMHYHCDv8PSS9vxOYpckwa8oLinFaOpOrGwDoZZV/y+NsyC0wOiwNe5n03KDgNSpUI8VLdWsroo1cMy2DobZg99yivTj3jD1hjDn35nkVB468WWzCFjLNU/82OAapPmfKNjqhzypRg0ukUmPIGDE77ubxByCw417dCS3MeL/LEwZ0guNktbOCZqjP1eE8R2/CU5a/EZcwj4Xa9nwW6mkkvcyAnaaBFqnIHoCBh2xLlbrGE4Ir2qbnsxeMeWG2WttIgCqmvnRw5LVcptIdW1/LlTAJMgKQA215ZUHV4KfABYboy+h4THFai7lV1fK/TeuhWnBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KL+NpqIC0D+lu7oEK+3YuD6AYRHMTO1zzsS4lAvkFY=;
 b=YTfTSevDZmkbCx7t/ITjLOaONAWqA6wCmj5HKNzr748YNcS4S0LJS8hjJA2f+dQI9IG27TfAQBeVA1QBos9QZfjhSdsmCVRUM/QKQVMCiXbm9yt/lhmD9GaYo85IklxgQBjxNt5SR2K4TNqryN6A5oaYgHkm1RPBAjf/PszgWk3t5ZeX5UkbIe2rkleCqEtD4vpby0pLViD8V37OWgiY1tnimIojbHb5en+Edj6W3StUfdAJZV4GKCBjJpnNcq4mE3Gc/oyHzKKRqoamRgiBEAIEBI8ufM8yiF3CP2zm+/ctMB/pP5E9VDYIIB0x9za2cyzXFF9u4Oiz6km5oY/Eug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KL+NpqIC0D+lu7oEK+3YuD6AYRHMTO1zzsS4lAvkFY=;
 b=MUVyQh3q+3Od7ATgJcrTRZ2ktbRLZe/IpiV0hVLEqkpNs4sTVmrZfAj6Fw2VqDGNtvPxq8+V8/pD/FeDKOT4Ci7v/E6IsiTDeTG3PdDIIjcymFwg0DC0eIPhSMs09C6DXlRc7S10ka8jIKyaOZ32EEsnTI8uqlpuMV3pfIGBSOs=
Received: from CY5PR15CA0182.namprd15.prod.outlook.com (2603:10b6:930:81::26)
 by DS7PR12MB6023.namprd12.prod.outlook.com (2603:10b6:8:85::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Wed, 25 Oct 2023 17:00:21 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::b6) by CY5PR15CA0182.outlook.office365.com
 (2603:10b6:930:81::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 17:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 17:00:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 12:00:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 12:00:17 -0500
Received: from luc-work-vm (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32 via Frontend
 Transport; Wed, 25 Oct 2023 12:00:15 -0500
Date: Wed, 25 Oct 2023 19:00:13 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 <qemu-trivial@nongnu.org>, <qemu-arm@nongnu.org>, Markus Armbruster
 <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Beniamino
 Galvani" <b.galvani@gmail.com>, Strahinja Jankovic
 <strahinja.p.jankovic@gmail.com>
Subject: Re: [PATCH 03/10] hw/arm/allwinner-r40: Remove 'hw/arm/boot.h' from
 header
Message-ID: <ZTlJnWLbreOf6UOU@luc-work-vm>
References: <20231025065316.56817-1-philmd@linaro.org>
 <20231025065316.56817-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231025065316.56817-4-philmd@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DS7PR12MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: e6306334-4b6a-4e8e-f4ae-08dbd57bdfaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gWke6kUIKEBYLwg8FY+WTsHs60j3dWkEL2AEOZSRTnuR9LtHRIpqzB+oZOydRTaCNbCk653Ksg0/7ppXK1KvPf98jxrkI7uv1tNVguJyETsw2m+/8q1VivqyeuHWCoASS5Ow1eEsTNQvNm5WsyKIsmdsCitm0Ef1wB4ChxPiVivIjMg056dWazxm8zvCDNsP1wNVmgaEMgzUnE0Zfo7FsvE2ZyTKCl/KjWxNbrOwz2gLmAKijJwzGuudaz9s2bDYCYVzM/poYYaqs47n3xWo16SGe21GGWdnjwaiCCjiljl49rfobRgp/pC4AVrWZnxWMhQaPgjPztkMw+jxhQlwIjx/bK+HI1NTI6CB+pSO/Lqr5fu0lMAvJhhOXAauOidUQELadPO8Yv5OjD68BR8LTVla3R7MhYH3+G4bEtJqcaTb8+2Zp2oGSOiMw9yfmwCPPliTnF225Xb1kIGNOAvNnjl6dabVtb6596GTFkw/o0XUbqHXgyGqIwieYZSqM1xY/CMi0AgmhuiKn7oHC7FDQOIM7OofiIX5amfzEFeyMEtmnW3EJqsKDYnCqTc8/337rMvmfpE97/cJ5Rkvn3WQiZ9f76MrFlRk3j3SLRyWW7iXzZysaFYcBBfmFD+SMF/ft3TCn8+Oays0oEgtOQk2MRIxHDpBl5KL7P+/KpFd44fflGLeZse97sXk3o2po3HLL9Sel47mHBSAntd4e6q4AsSZ9ABcoFugv26+s3X9TbHEj9i18vaLA+0WzIT7VHHewObfU3Zvb7IH7TsL0+rSkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(478600001)(86362001)(36860700001)(2906002)(44832011)(6916009)(54906003)(356005)(70206006)(81166007)(70586007)(316002)(55016003)(40480700001)(47076005)(9686003)(336012)(426003)(83380400001)(4326008)(8676002)(40460700003)(5660300002)(41300700001)(8936002)(82740400003)(26005)(33716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 17:00:21.2336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6306334-4b6a-4e8e-f4ae-08dbd57bdfaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::615;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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
>  include/hw/arm/allwinner-r40.h | 1 -
>  hw/arm/bananapi_m2u.c          | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
> index 72710d3edc..6e1ac9d4c1 100644
> --- a/include/hw/arm/allwinner-r40.h
> +++ b/include/hw/arm/allwinner-r40.h
> @@ -21,7 +21,6 @@
>  #define HW_ARM_ALLWINNER_R40_H
> 
>  #include "qom/object.h"
> -#include "hw/arm/boot.h"
>  #include "hw/timer/allwinner-a10-pit.h"
>  #include "hw/intc/arm_gic.h"
>  #include "hw/sd/allwinner-sdhost.h"
> diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
> index 74121d8966..a7c7a9f96d 100644
> --- a/hw/arm/bananapi_m2u.c
> +++ b/hw/arm/bananapi_m2u.c
> @@ -26,6 +26,7 @@
>  #include "hw/i2c/i2c.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/arm/allwinner-r40.h"
> +#include "hw/arm/boot.h"
> 
>  static struct arm_boot_info bpim2u_binfo;
> 
> --
> 2.41.0
> 
> 

-- 

