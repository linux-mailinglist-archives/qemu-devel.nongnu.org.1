Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 387EC7D71F8
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 19:01:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvhFs-0006oT-Br; Wed, 25 Oct 2023 13:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qvhFO-0006VW-Og; Wed, 25 Oct 2023 13:00:48 -0400
Received: from mail-co1nam11on20627.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::627]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qvhFM-0006tG-OY; Wed, 25 Oct 2023 13:00:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkxCc/yu4U9O2LS/ivIIABmIaQoMvksMD4aSnyWhWRnJnhyBWSCfwukkiaa+arFfCQ96uIGHaH1PAYpj6HSQQJyl6yo/xWgIVEtd4/pz6POiFd4tgkjFX3y0KPbDU/+9aM760dFtQIP28DjIgqk974q0RttMfg2ktOOh30Wu651BvjxYFIRsAkt7f67xOXnFsQKPBgJFwbPv2hF8jOJaS6ho86eKC+bEUvq9MaECQXAhuZEI7/LEWnSCu9IVVqXI8tL+QgGQ0q0Y3jBVPGf+l0Y4t6buoH8oQ64pWzs3XXM16TmkMMpZdfKiCFegNb25ErgVJ3nG+OsMkZ03y89brA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQNTs9efJ4tpvuyuYTkf0bAvDZawGUcxwp/7Xpms6N8=;
 b=mTp+Qn8rH5sDyckxLUTsRQcRZU6bsGgn6jS6L+4R3TQXqzECoJ89mLOIgVQabtuQXcSvJpYfPeSgiU40s+4mpf/F39ho64S7jPEJiaAjpzwHpor6TPrX5AhjoY6F400KQU8q/g/is771tZZLhWrb2Pn9H9JIAFLYLO2RXw43m8/i3N4VCxxrbnty3fJQXMMciQ9ydtPENanDVhAnw+tVZBoqqlJou1iMNK24qqahbgAS2d37NivOK9NgMMgjYYaxJR9KcZGDuM5x6l7QZ+QzMeMOB9DaKd7ge5M22WLTA/zFxzVL97hVvQ8jKHdv5c2E2wHF4q173l93zfP4WyxPyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQNTs9efJ4tpvuyuYTkf0bAvDZawGUcxwp/7Xpms6N8=;
 b=BzDAGdXRdnPPsOXkkbRei/VsPT4V+pJCyQqa9P6uAjO7loUQtVv1qp6/pfyvH8nwaX4eoMeWpZ4MX7PQYEcF8lkZSPthKRjPw3vEA/RRshCJQnntahHDMGhxD65VWL4p99Jv9GPy9XtUZx4S1un2wgrK/w5xFiSX2fLLdeJpjDY=
Received: from CY5PR22CA0032.namprd22.prod.outlook.com (2603:10b6:930:1d::20)
 by DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 17:00:40 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:1d:cafe::6) by CY5PR22CA0032.outlook.office365.com
 (2603:10b6:930:1d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 17:00:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 17:00:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 12:00:39 -0500
Received: from luc-work-vm (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32 via Frontend
 Transport; Wed, 25 Oct 2023 12:00:37 -0500
Date: Wed, 25 Oct 2023 19:00:35 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 <qemu-trivial@nongnu.org>, <qemu-arm@nongnu.org>, Markus Armbruster
 <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Subject: Re: [PATCH 04/10] hw/arm/fsl-imx25: Remove 'hw/arm/boot.h' from header
Message-ID: <ZTlJs3zoXqtrmaAh@luc-work-vm>
References: <20231025065316.56817-1-philmd@linaro.org>
 <20231025065316.56817-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231025065316.56817-5-philmd@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: 442a544c-5e83-4aef-0eda-08dbd57beac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: soxlEPOn4gNoQmZCe6PQ3qK7Tg3Bda3S1YVQTj1mW+8FajMuAKFM+5p7YPNpjeYOeLhb+hrw4dk8UE04pSIz5Z5AtlwH5ap+GUhk8P6RubAErHBl/72uvuXjrSEt49VVyXpzsNrMiPveamjVIizgpAeLHo1ATSiuhR28bfIf4qxiB2vkHnJGubUegL6kQhQGMe+d4+Sd1b1snMFlCSG9zBqeCqsbVDiVL6sieRWcDIzHdAtgVZ+Z67LuxNAleGjIbT/O2+8j89KdFb4+AGbGiFJiVMmp3irZvBTU+sn+js6U3us69p5hB9m8OJQ5izFFvViBJCusc018kdqRpTb/8SUheiWBILGx1AR5zpStPx0RiLgJUdUIxjZvkZKDXQrcSXk8C2DO5I5gQesoo0tvQKpfDlUAC978g5Xppj5iSCji7rnIjygufgoixu3th5+bcddEGAGN3/cMgyDXqAomhJ1sQskH5S41eVTWq2bh6glkOybXnY13zJ5o/7KyLkBVTxM5FIafwzUM3r4Rgn2f2ul5f7G1gGow1rgHP1omXrwgVIw3opH3b7kTx1OZgO9VuIzLL46GEikxXaQVrbW3PqcxNLQoAiyUK5uv7YJzlbBt84IctcGGP+hsMuPcyP64S4GJ8GusUP6mLdxA3dfTQ10OrxTkMyMK8JDqu3yJINrMGtgGWYL3Yn0Q1vz4/eyR68yhtvBEhzYO8nqom9F7LOIMV+gfDhh8vRiEYdNU/cpprWbHAODVNsRkVWpEpAEnvVjksULaNQH8bdwhcFCNWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(1800799009)(64100799003)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(55016003)(44832011)(2906002)(86362001)(41300700001)(54906003)(6916009)(82740400003)(81166007)(316002)(70586007)(478600001)(70206006)(426003)(9686003)(47076005)(83380400001)(356005)(336012)(40480700001)(36860700001)(40460700003)(5660300002)(4326008)(8676002)(8936002)(26005)(33716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 17:00:39.8636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 442a544c-5e83-4aef-0eda-08dbd57beac8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646
Received-SPF: softfail client-ip=2a01:111:f400:7eab::627;
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
>  include/hw/arm/fsl-imx25.h | 1 -
>  hw/arm/imx25_pdk.c         | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
> index 1b1086e945..df2f83980f 100644
> --- a/include/hw/arm/fsl-imx25.h
> +++ b/include/hw/arm/fsl-imx25.h
> @@ -17,7 +17,6 @@
>  #ifndef FSL_IMX25_H
>  #define FSL_IMX25_H
> 
> -#include "hw/arm/boot.h"
>  #include "hw/intc/imx_avic.h"
>  #include "hw/misc/imx25_ccm.h"
>  #include "hw/char/imx_serial.h"
> diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
> index b4f7f4e8a7..7dfddd49e2 100644
> --- a/hw/arm/imx25_pdk.c
> +++ b/hw/arm/imx25_pdk.c
> @@ -27,6 +27,7 @@
>  #include "qapi/error.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/arm/fsl-imx25.h"
> +#include "hw/arm/boot.h"
>  #include "hw/boards.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/qtest.h"
> --
> 2.41.0
> 
> 

-- 

