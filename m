Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 649C17D71FD
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 19:02:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvhGX-0000n6-Oe; Wed, 25 Oct 2023 13:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qvhGS-0000eT-Hy; Wed, 25 Oct 2023 13:01:53 -0400
Received: from mail-dm6nam10on2060b.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::60b]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qvhGQ-00075d-MZ; Wed, 25 Oct 2023 13:01:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6noV8tJ5N6+u/JRy3pyOuhJ76bAEpGyZ2U1NN5OYV33Q+JWAQTEpbnAwFebFi/Z8BumrEa4eQbNmsnuW5llIITDEX9W4za5FGqfFgotOH0HB43WzTSgQs3n5Gdz9P5OQzw3kAmVmLFR4yCn/aEV49mx3/Q96u9k+LDLW6gURoj0ZrN1Ucgvv/r1jwYDSZ/kdx+XHOf4D9Y2Yy3jtlTRG7PmGi2d+kMoAqZdBt4zIFcPs+5V6pdYM8I5a23kivQxs1o693mymmMclyTFRmXCmKGZuGkbt1yEDhxtLKNhO38wei5aQMVDjRX1OrUr/jpC/w6CTvPttaIiPnW3awxSwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fk98QJ3khTqUYpEaVWUgeFR23YEP9NMsGmbDzDqRTo4=;
 b=aZOiWps3HjqrFQQ8lrCP/NuT4+OioUR9u2R+WP6xYNPui4zH/SrAJE5lyyKNyAhtWOJVWD8OLE0NjbMskOvRPOCa5YrIn27S+XKn4haeQCxBgtlxX4mefv8ybwdUs2c/FV9iPcAO9kRj5zoo//90iPsL3rtHiuKybAEkNzp2YIUyy2/SyForJAWNqOhfAjCmnWqZiQaCSI9IrHYwpAw5HNvY8xJgAS7Lqvf/5glyx+qjkx7u0GLKWakwpHUehk3qjfpqvOj87qD82AFz9Bp/mYtpzOXOHO5KQT6wfDLHpi/Im8CS6Fr/83BihLvKGqiU6iyGybfeW1Jseu27HK0zBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fk98QJ3khTqUYpEaVWUgeFR23YEP9NMsGmbDzDqRTo4=;
 b=LJF6pO6DBkPPBDmFr2cMSbJ+a8tYoBiu8LV4srcNCIwRgGDAKRCFEO91J+3lSWePC4Ose7S1aY3HEIlo1PIKtlpvoTBM60aOqd1P4SOK3OJQCs8W7Yb5xf40UREqmbKqh2yfFwyxbjnCSqzuxPzT31kJ2a7UEfAmEAdx3GUxZ0k=
Received: from BL0PR05CA0008.namprd05.prod.outlook.com (2603:10b6:208:91::18)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 17:01:45 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::62) by BL0PR05CA0008.outlook.office365.com
 (2603:10b6:208:91::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 17:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 17:01:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 12:01:44 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 12:01:44 -0500
Received: from luc-work-vm (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32 via Frontend
 Transport; Wed, 25 Oct 2023 12:01:43 -0500
Date: Wed, 25 Oct 2023 19:01:35 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 <qemu-trivial@nongnu.org>, <qemu-arm@nongnu.org>, Markus Armbruster
 <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Subject: Re: [PATCH 06/10] hw/arm/fsl-imx6: Remove 'hw/arm/boot.h' from header
Message-ID: <ZTlJ7/oHoN829rdE@luc-work-vm>
References: <20231025065316.56817-1-philmd@linaro.org>
 <20231025065316.56817-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231025065316.56817-7-philmd@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: 0badf4df-2f91-4305-50d9-08dbd57c119f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yptZCmpZSdUGIH2LJf8zo0HxYkVgwoeorvfiYqqtBptnoXdFlz1WzSlFZSvgEDZV1u9iL4zxCIU1P0Ds1JmzOHFh47jnMWQxNHaxhIV/rLh267gm8DwCLRm8ETJ32cWZpg5iKF6OnrBLK76cNb9UvTIy1NCM4mUwFjV7oUFqtRTZmCN66nms3FDL0rLZneVVtDHs/bPwSGY4XWYDqOWgGfVjIgC/3QtA8L2URGRblh0LdL5BBxGDgYVF7JLRduDXbUASIPrJlmclb7lbXHd9t55C7L0aq9+W27hkxRwFASogmfkCSBXXCjiMhH9aNNv8bxaPpwIaJfvCrWTG8ET+yqvzeLVZM023FP+NcU/lYpGvTBo2KVLyGmMI3A6994hcUzLmDQptwglYWuRQgFIo6NZ2S744Y2rs1KnZ2zx9qLmtgqxbbN+LN62envH+1l+pHOlq/IWCXh0pwE9FeVv6JLhhboInH4xF3ORCri8WmObg1PqhQIAH7enOmyqkEGq6vgur2bl+mnUGdnHkqHFdOaE0gt5tlUnpXUnhE4aIlaWaR1qS8/dbhjdcs0aU9nYf/ToKMOnDlX0UVjMyPC4SrWEx2mCGZQnpfbZz6nb1ZBz5Yoqe3nnpegblJAWtwRZwsLJrkUR6b4kIcQF1LidNKPoC7cv6BDvaAlqCRpWmu4DmtqgcsAFWjDGlbjKCxfADIoyhYYsxfvcRlIpyAp6d2lzE9UZutIbjM3Q4t5Ij+qgJUShBVO4fEio+z3opvd0WnTzcqL3tgsETta3smBiCJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(478600001)(2906002)(55016003)(40460700003)(9686003)(5660300002)(4326008)(8676002)(8936002)(44832011)(40480700001)(41300700001)(316002)(70586007)(33716001)(70206006)(426003)(86362001)(6916009)(6666004)(54906003)(26005)(82740400003)(336012)(356005)(36860700001)(83380400001)(47076005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 17:01:45.0902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0badf4df-2f91-4305-50d9-08dbd57c119f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
Received-SPF: softfail client-ip=2a01:111:f400:7e88::60b;
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
>  include/hw/arm/fsl-imx6.h | 1 -
>  hw/arm/sabrelite.c        | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
> index 5b4d48da08..519b871014 100644
> --- a/include/hw/arm/fsl-imx6.h
> +++ b/include/hw/arm/fsl-imx6.h
> @@ -17,7 +17,6 @@
>  #ifndef FSL_IMX6_H
>  #define FSL_IMX6_H
> 
> -#include "hw/arm/boot.h"
>  #include "hw/cpu/a9mpcore.h"
>  #include "hw/misc/imx6_ccm.h"
>  #include "hw/misc/imx6_src.h"
> diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
> index 41191245b8..56f184b9ae 100644
> --- a/hw/arm/sabrelite.c
> +++ b/hw/arm/sabrelite.c
> @@ -13,6 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/arm/fsl-imx6.h"
> +#include "hw/arm/boot.h"
>  #include "hw/boards.h"
>  #include "hw/qdev-properties.h"
>  #include "qemu/error-report.h"
> --
> 2.41.0
> 
> 

-- 

