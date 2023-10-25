Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE017D71EE
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 18:52:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvh5w-0002j9-UP; Wed, 25 Oct 2023 12:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qvh5a-0002i8-Po; Wed, 25 Oct 2023 12:50:39 -0400
Received: from mail-co1nam11on20625.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::625]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qvh5W-00058Q-Ll; Wed, 25 Oct 2023 12:50:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRl4jLf/6EpNq/y1j2wZRyCxCp/ZW21Dr4dtggknIBXoxyZQNTg5H2Ts1Q6/yvofthAwuRO3dMcVXURFCMUMrOpUXtfL3k7nFDVDdo/vDRWYE708o3QPVGtkuaQzMGOVOsC96CNXAaW0j9CWYR6jofv5Cenw+ZIAmCI7LWrFVZyTmogIu+j3r+Q8dW97Ob6dApOxPI9xHOmj/faDS1mGMbYOvURpPTn5fHDH6irzSR17w3ieZwaTIi1W1e8e15EKT0ye3coY8CJDh1u3qZeHIy2xN5EvWrEzotGIVHtxxbNWg4F1UFFy7G1FOzXy9NniKlQEwMZEnKHOmGSjyTykiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pe/a7LnkWp3xH/Csq8f7IrzhksEz6jUxWEM5HrtyR/U=;
 b=gvbdGIEqwDUbLoEd1RUzqjSrjbgH0Ez1byDKML9m3pdCZFQi9Rqot7JPaTL6MSftGvgywBqJFg0IqJ2/rSuDPLiyKTmUZwSJHVtUSm6jEewHijg5BpAjwWQVO/9S4u2PwnrZJo7CXGQS/ZUF0z7m5ZPwJvxcr+xWNb/gPENtGKogySQH8bWwRef0/n1KcMHj6PfzsCFGqUTiUhcrzKuIN6TEwMdtJ//Cspfa5OmdWxlCc6y6qNkDzK2EghIloENoWuMqX05eMXU3dygjkaz+M4IjxsmN2n7YZsglcWKY6gtC94txovmKYmNPPygIqoVrsrIy7BAmAnozbId6j35Tpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pe/a7LnkWp3xH/Csq8f7IrzhksEz6jUxWEM5HrtyR/U=;
 b=4qE4VNzKaZO1dYzoyl81kBNkyW1JQXUnx3jp7gJSDuVeBDf2MiNXd5upSTXQQUqs44VtNWOiiC4bmO2aHi+AlipsgoqaEgDmHFPxFit/PvITg6sXq+1w0mqI86TX+fOuERPOznbS58nL1C7/AQ47U/lAtHRMRDSoQO/SmcIRIRM=
Received: from BY3PR05CA0018.namprd05.prod.outlook.com (2603:10b6:a03:254::23)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 16:50:28 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::63) by BY3PR05CA0018.outlook.office365.com
 (2603:10b6:a03:254::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8 via Frontend
 Transport; Wed, 25 Oct 2023 16:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 16:50:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 11:50:14 -0500
Received: from luc-work-vm (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32 via Frontend
 Transport; Wed, 25 Oct 2023 11:50:13 -0500
Date: Wed, 25 Oct 2023 18:50:11 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 <qemu-trivial@nongnu.org>, <qemu-arm@nongnu.org>, Markus Armbruster
 <armbru@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Strahinja Jankovic
 <strahinja.p.jankovic@gmail.com>
Subject: Re: [PATCH 01/10] hw/arm/allwinner-a10: Remove 'hw/arm/boot.h' from
 header
Message-ID: <ZTlD1E8lLc3ohC4G@luc-work-vm>
References: <20231025065316.56817-1-philmd@linaro.org>
 <20231025065316.56817-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231025065316.56817-2-philmd@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: 943bdf04-2e70-4031-16e8-08dbd57a7e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zVqpu6+d6QRiDQuC2JqeX956ANIZd2+fumvPcEGlL3MxBgBkDblf4OKF5dqo1nD5nszCUFJl6L1h5xdYFx1PL2Zi7paE3orEIQ+0mJL/mEXpn0L2cKrqbNO0szJnjlqfnZ47X54CTkrPKm3MbOe9ktjV1SZUkfSdjUwKdGW5G11waNAIz8mjEntpRS7xm4N8vF7DH3IzbbR8VHHHjHtMARw68bXtoTaE7DpRRPlCqgKZWb9Sd6ySdNfynB6iA5MavHNE2iFmX0MpR6Tg/84a0LnXoaoqYkfqrRCqEyRRPoLCsBkxXDFicoUDiDbIgkSdmaRitnJVoExu75CLYpJjJ92M9M9ziT62UgdHylm+xhXlFbCsmTAjwC1KrVUh4KQfcMt7Kojg/OcXDU0fP/2rvkCWMC2NXDrZWWWcrnFgPDvOjduoMoKRcX5xAZ8wQYPxNHtICghNo0ucdBpULbTRxNI9UjLL6q8IKsNoC2MNoI15igegstkAfF1szm8sH+ykFjgJGDIcRMXIAytkdGA5DoHuyhJ3grRNQfjzziGaXtAv1Em1a7wV1HBtROc1/l50Zv7Kq3Xy9z+R8a7KnzyYnXx1ITK6b0xujgBiFfCN8QUmYhlfG16VafPndWZXUey8UywJ7YorgoEHNoadlIJVafds1Rm+1VogM4azu0vsa2EXOFSGqZpkLsMn9y1tCUKTYBy70K9CV42ErerlJ4ojla0lbaFsbD/rT3TEtp/K/QHwTjUhm2c/UWzpD++5LkNWxntHdeSBZh57YkV9SfGsKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(55016003)(81166007)(2906002)(44832011)(6916009)(41300700001)(82740400003)(70586007)(70206006)(54906003)(316002)(426003)(9686003)(47076005)(478600001)(83380400001)(356005)(40480700001)(336012)(36860700001)(4326008)(40460700003)(86362001)(5660300002)(8676002)(8936002)(26005)(33716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 16:50:27.9507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 943bdf04-2e70-4031-16e8-08dbd57a7e17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
Received-SPF: softfail client-ip=2a01:111:f400:7eab::625;
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
>  include/hw/arm/allwinner-a10.h | 1 -
>  hw/arm/cubieboard.c            | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
> index cd1465c613..2eb83a17ea 100644
> --- a/include/hw/arm/allwinner-a10.h
> +++ b/include/hw/arm/allwinner-a10.h
> @@ -1,7 +1,6 @@
>  #ifndef HW_ARM_ALLWINNER_A10_H
>  #define HW_ARM_ALLWINNER_A10_H
> 
> -#include "hw/arm/boot.h"
>  #include "hw/timer/allwinner-a10-pit.h"
>  #include "hw/intc/allwinner-a10-pic.h"
>  #include "hw/net/allwinner_emac.h"
> diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
> index 8c7fa91529..29146f5018 100644
> --- a/hw/arm/cubieboard.c
> +++ b/hw/arm/cubieboard.c
> @@ -21,6 +21,7 @@
>  #include "hw/boards.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/arm/allwinner-a10.h"
> +#include "hw/arm/boot.h"
>  #include "hw/i2c/i2c.h"
> 
>  static struct arm_boot_info cubieboard_binfo = {
> --
> 2.41.0
> 
> 

-- 

