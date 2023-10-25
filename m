Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C207D7200
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 19:03:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvhHy-00048J-DD; Wed, 25 Oct 2023 13:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qvhHW-0003x7-Ay; Wed, 25 Oct 2023 13:02:58 -0400
Received: from mail-bn8nam12on20608.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::608]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qvhHU-0007F1-AH; Wed, 25 Oct 2023 13:02:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSfSx88CdRg9116Q41dBkZHVPjdSeTvqx0wwqVaRsA8czZmKU294QLtmtl2u0elWYmofz8dtaQl4MOfaYWB1CffdXCpj8raX4Xy5/8TN/+UU9mP62sCF5AVXpVVVJpCytV51h15kyVI0vLx5OLTmH68GcyUIggeZfg4ucp5bFEUnuApUHPghv4go6P6OUxIVskgBYJHSaFW8tony3IKblwsD4LqQB68GVYBPpWxCPBKIC3WLKLweSWXbDzKzKoK07llH7tIz4TZw7gSmIPNQPviq6CC0mrlWCUpLOFWaBema+E2Q9uBYvDEmmXy6yxO2VyncJM07nIK7BveK55nuZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqBfEFaqU0hnz0zkA8lP6hpyQSQ8YKkFCmxA04Mayrc=;
 b=g8A5gfYUO9mq8ltyBJeiO96LIprz9cj+tfthIzI1hd7FH/fai9XNbw6mXxLY25JhneNO0/dGMelZvbV5IBNkyEpop4YhcXpUIwNqQPhYU22cSLGlCj+h5w6FAc7Y07Kh1KWttITdZRFN0Zi2xljTzMp8X/t3nl0S4QV/wjbCNH8OM2zDfiAQuUqmM0DxwwkTD1h9QvS34YAQo50WXwyG3cR5bAxUivZS71NSM7PT4EqDooRr2YZus+7NmeQ11vnlRhYbswqG+x42SsDNDkLN6fanclzY/3zRsq8FTb/q3mRrfIyS+C+YdSui0EAhkqLyDeMZjjPme2tFl9mBLqOGcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqBfEFaqU0hnz0zkA8lP6hpyQSQ8YKkFCmxA04Mayrc=;
 b=bTRnvO6kzE6lcVtUhkmRTJyICfNUACHcYRrKvw5w3xs4ySdRwoH3oTfDnXP2h4Xs0zyrtcEAES1wTa0zV3ohXxEgMjZDwcwbZosr6s5ac8LZ+RnZD6Lca11on4vnRUGHrgiqpeJG2YYhCoi7P26gAeLJ4Hs1cjVVQPY9iwJvrG0=
Received: from CY5PR22CA0032.namprd22.prod.outlook.com (2603:10b6:930:1d::20)
 by IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 17:02:50 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:1d:cafe::a7) by CY5PR22CA0032.outlook.office365.com
 (2603:10b6:930:1d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 17:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 17:02:50 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 12:02:49 -0500
Received: from luc-work-vm (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32 via Frontend
 Transport; Wed, 25 Oct 2023 12:02:48 -0500
Date: Wed, 25 Oct 2023 19:02:40 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 <qemu-trivial@nongnu.org>, <qemu-arm@nongnu.org>, Markus Armbruster
 <armbru@redhat.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH 10/10] hw/arm/xlnx-zynqmp: Remove 'hw/arm/boot.h' from
 header
Message-ID: <ZTlKMKBpl+1HbOCa@luc-work-vm>
References: <20231025065316.56817-1-philmd@linaro.org>
 <20231025065316.56817-11-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231025065316.56817-11-philmd@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|IA1PR12MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fcf4cb3-c18e-4fa7-6ffa-08dbd57c3876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wt1fEA8EjSdcnilLRQTQ4iR36FTGIpceL81k+qcsGZrWhVdNtuFe0VfJCqe6qDGHAzwAh4CVz0nkapuEPuoTr11rVboAdhMlcbyFkWyLa+IyniRhAIOWXamwsiB7ncginWLjmuJt3OVz1PTNu0mqTXGRSLPv8hxxH07Mf8Quw5vXkNw4dFhSB8qGulbkGSFBCxBkjzYJiig8T5NgFogA9pqe5TXcVdoqsQveaq2/dq1/XkC0ZReKt66GjO9GLno29xMzSFuqo9T6Nzh53O27dw4iEC2FJM8E68lIhii6TMwYgYfuFvd4bU66nqCL+GOzCKpvGfjZi9/SJgKf1Ubk3R+kQsjxAgpsCqom0UvxtHpJ9byTRSF4H2HF3W9wgsjGh+v+LcjVVCVVZDla3/OhTs/1iS37n+iLB48NWhTBewi5UGLEGe1djmf28l4NqW27ia0/VOK3PvsYpLwJAMLN8luPoS40QJnJYaRTTDbHH/5h1Ypn4nCoUxRnWPqC4eGVCTGi58lVfNppBpJ5HW5HMgrEyHyD6TXeYt9a+W25GZl92PykjOUTk9hfKAYLjEwexIV3RWjeVtE11gGLx2VHcYL8G26ygXk7BOR9az2NrySxbCq2CrQhA2K18EwtuTXC03bRMSUUW77Yx1R7e+VNti0cxu0XXoI36kkCRnbsHeEC4seADqNrqZSc5QiFFjSARZK/+22X1E6l1AvI64amRulWOpk2zeay00nR/f67qWtNY0pG4ZF7ZD8XJlrjmbxTrM66wPzhdpny3gNojQLzdIGKPNBJ+DHTN1ogUrquHJk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(9686003)(55016003)(478600001)(40460700003)(26005)(6666004)(47076005)(336012)(2906002)(83380400001)(5660300002)(70586007)(41300700001)(33716001)(44832011)(70206006)(4326008)(8676002)(8936002)(54906003)(36860700001)(316002)(6916009)(82740400003)(426003)(356005)(81166007)(86362001)(40480700001)(36900700001)(67856001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 17:02:50.2066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcf4cb3-c18e-4fa7-6ffa-08dbd57c3876
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9063
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::608;
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
>  include/hw/arm/xlnx-zynqmp.h | 1 -
>  hw/arm/xlnx-zcu102.c         | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
> index 687c75e3b0..96358d51eb 100644
> --- a/include/hw/arm/xlnx-zynqmp.h
> +++ b/include/hw/arm/xlnx-zynqmp.h
> @@ -18,7 +18,6 @@
>  #ifndef XLNX_ZYNQMP_H
>  #define XLNX_ZYNQMP_H
> 
> -#include "hw/arm/boot.h"
>  #include "hw/intc/arm_gic.h"
>  #include "hw/net/cadence_gem.h"
>  #include "hw/char/cadence_uart.h"
> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> index c5a07cfe19..4667cb333c 100644
> --- a/hw/arm/xlnx-zcu102.c
> +++ b/hw/arm/xlnx-zcu102.c
> @@ -18,6 +18,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/arm/xlnx-zynqmp.h"
> +#include "hw/arm/boot.h"
>  #include "hw/boards.h"
>  #include "qemu/error-report.h"
>  #include "qemu/log.h"
> --
> 2.41.0
> 
> 

-- 

