Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B28D7D71FB
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 19:02:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvhGn-00015i-Lv; Wed, 25 Oct 2023 13:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qvhGg-00013S-Jj; Wed, 25 Oct 2023 13:02:07 -0400
Received: from mail-bn8nam12on2062e.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::62e]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qvhGe-00076U-Q5; Wed, 25 Oct 2023 13:02:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4OcPqFyb9QuigvuuHKd3rTcxC6Ajf35yA4IDj9kcWZ0XFdleCUrW+6oFQfCjFaXMNZ9Qi4pnHZhG/2JtcgIyCVYxuH8oRg+dpaydl57XIGLTigmfhbhBNmFXGAgwJxnmkX4SEHs5AIGF66xfmgR42Gz8QDxUdgyajQTJ8AzjZ7NfsvOFm7hEREdC56UnUfBPD5NHeKR74g8C6QCaRPqDALc9zv4zkv0Zd7KjCLnNrkM4PyR4J+bvfgSMky1LMFst0iFz0e0jxq+WgbGWpluf4HkLNNnfEs47E95x4pSk7lOOH02sKs5l098yGz1P6fJ6zTO033GlkiWJNqYEW++pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9x6MUq7MeiXB+77tE/cf4Xf6ZPC3iryRRA2E4KKXJ/w=;
 b=LOXFCgYeh652OkPBe/UiUCXTcm7p1Z6YmPoJ4BoYPZbywv8BDqOFxTEZ10xw1RFlKyTQHuEZCYtHlOj76+JBhnp71+EbKDpXbMwLffNGvcyu8vEezT5GDayxGesdV6ZAb4GOA0m36B7AK/visAEnHcAUj413W2VH8LXq9+hLGlSxi1yOvy/KvNssJyIMAL/eQ8hG+cgnptkzJRB1m6tbzA4YVcocj9402WGPdTd+Te9+Fpe2JUlcZd5maLq57Nyq3VAngsCSkDJ8OVmZpypwAesrRAdpGG5tyUkcbzdcKnA0OhM+f6FcFl3t+40DvoE3K51E8Xa1w1BlXSuLc/1vlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9x6MUq7MeiXB+77tE/cf4Xf6ZPC3iryRRA2E4KKXJ/w=;
 b=HNHtSOQo9m+vMSzz9JykKjCszdgq169yufrCJx3b4Le/c7TXMo4MNtyjrMwZquyY9PK4ycWw6KtjxhTSvXkt4lrqxDD9TmEqeixavevUyzF2PCHI1dJHFo22EQ2b9kzT2GldzwSoU1dbud/poh/DSHT3ofUZ/jwADHOeqLFkd8g=
Received: from BL0PR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:2d::34)
 by PH0PR12MB7469.namprd12.prod.outlook.com (2603:10b6:510:1e9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 17:02:01 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2d:cafe::5c) by BL0PR03CA0021.outlook.office365.com
 (2603:10b6:208:2d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 17:02:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 17:02:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 12:02:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 12:02:00 -0500
Received: from luc-work-vm (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32 via Frontend
 Transport; Wed, 25 Oct 2023 12:01:58 -0500
Date: Wed, 25 Oct 2023 19:01:56 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 <qemu-trivial@nongnu.org>, <qemu-arm@nongnu.org>, Markus Armbruster
 <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Subject: Re: [PATCH 07/10] hw/arm/fsl-imx6ul: Remove 'hw/arm/boot.h' from
 header
Message-ID: <ZTlKBCKjvmYw6i5e@luc-work-vm>
References: <20231025065316.56817-1-philmd@linaro.org>
 <20231025065316.56817-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231025065316.56817-8-philmd@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|PH0PR12MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d11bd3-daa1-42e2-a2c5-08dbd57c1af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wumDeEwzOHW3fxBfAiOklqW5hhFkZQTrFiX37BiG1S6fYMhgMAZTfwMBfp7u1obg8cJJb1qAwQdQr9zWnse/4dapcJ4qo8GzVENvjsyxx3OYUQry7Ri2Nz+2L9J6S4CLZHyDKKcTr9Ha1dwJRCnDLgnno0/+Dso6mPV1K3Xs1dQtmNxXcVvXG2NwfrCl3vg+8nPFdfQAL5i4y0KuMzc+Yf8Ld3pwT8pRn4DKmQM8SDfz3j/5+iWl8Yp6dkJInjMBk7BmYRj8likbotSJ0pbZLXTEN7qq86kgTMbAB0E1JlarGj3N3ocbZe0UnXGfI+cF0xscpCpesP4nG2aTFKyqVDnpIyrapwkoulCQg9nufc6QQ2uM48i96uIK+z6QF6w3BfuLhAGygwBOl6jPBIPJlKdKau91fTQ8nt3IFMaRQe1Nzzgt/XQqd+AIgHaU2imnvE8eTfl/ft2aJYy2UrelrOnLjx1Byby9w9HB/HmFABBfYGMhcS1ozv+uSn14TyIgjt6YK4IukgWvPVON25u2uubN7It/H50zPaI9nwzzGWR+08m2fxaa+vi5uGy91UF8rJYNT+eONAUbmIA19FKx9+wZCVssKeFNAvdQT5LdLJDCYt2a80M7Nx1KOOLhndtQDsX39FqWPssTCKWrr5Zgpy0+106BpzBxHMUWUfI2wpV8xxDC4qnv8J2FDyhEK3IpUDCcORnc5aEW9jwWSul8vSJc8N/2I9EnvGUmPb54hXFLTYLrPmJc+EolJOAV6idCN9sy6yjiCEijsgU1y9Rppg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(9686003)(83380400001)(47076005)(36860700001)(26005)(316002)(478600001)(54906003)(55016003)(70206006)(6916009)(70586007)(336012)(426003)(82740400003)(86362001)(81166007)(356005)(4326008)(8936002)(41300700001)(8676002)(40460700003)(40480700001)(44832011)(2906002)(5660300002)(33716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 17:02:00.7423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d11bd3-daa1-42e2-a2c5-08dbd57c1af3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::62e;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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
>  include/hw/arm/fsl-imx6ul.h | 1 -
>  hw/arm/mcimx6ul-evk.c       | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
> index 63012628ff..14390f6014 100644
> --- a/include/hw/arm/fsl-imx6ul.h
> +++ b/include/hw/arm/fsl-imx6ul.h
> @@ -17,7 +17,6 @@
>  #ifndef FSL_IMX6UL_H
>  #define FSL_IMX6UL_H
> 
> -#include "hw/arm/boot.h"
>  #include "hw/cpu/a15mpcore.h"
>  #include "hw/misc/imx6ul_ccm.h"
>  #include "hw/misc/imx6_src.h"
> diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
> index 3ac1e2ea9b..500427e94b 100644
> --- a/hw/arm/mcimx6ul-evk.c
> +++ b/hw/arm/mcimx6ul-evk.c
> @@ -13,6 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/arm/fsl-imx6ul.h"
> +#include "hw/arm/boot.h"
>  #include "hw/boards.h"
>  #include "hw/qdev-properties.h"
>  #include "qemu/error-report.h"
> --
> 2.41.0
> 
> 

-- 

