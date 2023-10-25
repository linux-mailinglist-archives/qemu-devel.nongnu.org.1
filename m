Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC507D71F9
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 19:01:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvhEr-0005sj-TX; Wed, 25 Oct 2023 13:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qvhEn-0005s2-Eb; Wed, 25 Oct 2023 13:00:09 -0400
Received: from mail-co1nam11on20611.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::611]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qvhEk-0006dH-0A; Wed, 25 Oct 2023 13:00:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/CNBO45BQNgGVb2kYRyVT6KGY7sUj+UVM6p3AQN0Gd2qXE182eni7H5ow9QDEAEFB0HmPyNHYD+PGh39ZX2PoTmUEV0vXugLAvpEskc2T2Q2JIeiUWSjme/0lFpMo8LeGtFZ4b+H9KWf7ZxXqJtx0WeTuQC95Hilb1nm7SHaMfSoQdHei247pFHgtHirkt5NTq+jPLyZtM9OzuH2DUGDJWxU0+yUxGdiqSwSn9qvsaPHZ2cefjeEu2ms88A5wpyEsrqQN9crBfX66CnfvF+MxzJ5hP8xXm8ZiGLM+igKElYFF5h+SvAwEvCO0U0eCgP01Yl3bklcIDMg7L7BHNWEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inezvdS3qp40pfvZlKMFKproKbv5wuHkwgGfz25fuQc=;
 b=T5Fe+oGwwBsVivQJzoqpYHEaAk6H7KtoJq4Hl7Ew64/8qlKHRyy68A9A6X/UM5HLaIpUsK9qdZ65vna5lgz02GE9G5k3FuguTQMcexplW+Lg6sECWiE1p3KILnlSyioCFs3lLdavG7uiSEhgw0sFrhD31eN8xiHKDBMT2TegJH3wlnpm+Gp1qX4U0tfK110lricD0pA74wGcQE/o5j64QNMSzr1sWiqoWo+/U+zb5cvNJNlZ4UYyxrPPZwONkgXtYPvkkziBOruP6YH0bSLrUUsSB1cQ80iYUitOGeLhRErANgn/HJDhtfAD2GUOPiOJ5k9XjFb9VyDKX7da1wsWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inezvdS3qp40pfvZlKMFKproKbv5wuHkwgGfz25fuQc=;
 b=TA8cIcU4ebTA9MwJAq4pZy56Cdhg0YdQy7OA3bEZ9ySNMOtB5zbKnfLEnd5jdsW8Z2FBYW2cCeMSALZpgtmv6n/oikDqF1cPQtVbtR9jKKP+tejUXN2fFJx2E9eNrglt1U14PdljYpKnl6VkcVB/vcP+Epjo2jFX/zjpCILODko=
Received: from DM6PR14CA0043.namprd14.prod.outlook.com (2603:10b6:5:18f::20)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Wed, 25 Oct
 2023 17:00:00 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:5:18f:cafe::92) by DM6PR14CA0043.outlook.office365.com
 (2603:10b6:5:18f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.35 via Frontend
 Transport; Wed, 25 Oct 2023 17:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 16:59:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 11:59:59 -0500
Received: from luc-work-vm (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32 via Frontend
 Transport; Wed, 25 Oct 2023 11:59:57 -0500
Date: Wed, 25 Oct 2023 18:59:55 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 <qemu-trivial@nongnu.org>, <qemu-arm@nongnu.org>, Markus Armbruster
 <armbru@redhat.com>, Niek Linnenbank <nieklinnenbank@gmail.com>, Peter
 Maydell <peter.maydell@linaro.org>, Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Subject: Re: [PATCH 02/10] hw/arm/allwinner-h3: Remove 'hw/arm/boot.h' from
 header
Message-ID: <ZTlJi6BfkpK3pTc4@luc-work-vm>
References: <20231025065316.56817-1-philmd@linaro.org>
 <20231025065316.56817-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231025065316.56817-3-philmd@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 3511055a-9a3d-4f71-3783-08dbd57bd2ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pg/axBrGd7BEb5dUo/JEGRRH6GeeSbQZwAyeFrIYUWHh9yhLGpnM4hZw+61If8lJy8YDf7hMXtjo1u1RJ73zZoUPCbxLQ2ZhP0jyCrBoOllRYmpaF4+Gs2k6XqyacyfyTQG3dVtC00ZALjhhHcS/IjooJPX3nIoZOP4AoavULIDW/pB0ES5gGypFxn2bI3A5ChHqP2qdKnveCv6O1FYm5GkeODFVS7gvduUbo47c6y4hVBOTFP9+JLkB6nJR5SeMq2+aMLq01OpnDkuRp3b4bXohD03W7ThUX+uoRo+RtVdbZ1yqpLTM0frS7bXzRs9FC3B010lWs+NIEk8vrJjltx/VnMBtKgvX3Mimwrq9KbhioMTG6fcGjnH2xe/wy/CaUd61mH96TvankEliD0EGyY0iGJfSHIHMfWLYsm8hPpG1S+RojdpRmyVghBaRc1o0767H/gfqfz8OgUhSoSDDyZT2o1K9EfLIsBweJd0al1ZJsS24Xq3ekNzIQLGuXwxCzqIxGCuHeu7cThp3uok5tmN4DxcmguBJAbNtWF5ERbVVLJeA5MJeLunFiYpAJXLLNS1wMR77BCniH4mwWRzc6qEy/6NxzI4O9Mks1Rlpj/9OGLg8C1+7VO2BGq/CHF5dvlOndkKtKNe74lMdcpk8JfaNdA9IAGx2AarEU6l3vE3SJdPwXH6CEeiTNgDIJEHbwZKFDF0o2TRstuY4olHQrCsoeJtPmxUgCSiQpNKN/b39cqKozWiSjXWFuKnD9vNKw4D3TAr6VbJQ+s8+tPcOow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(33716001)(26005)(2906002)(55016003)(36860700001)(70206006)(41300700001)(44832011)(5660300002)(86362001)(40460700003)(7416002)(4326008)(8936002)(8676002)(82740400003)(70586007)(478600001)(6916009)(54906003)(81166007)(356005)(316002)(83380400001)(9686003)(336012)(40480700001)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 16:59:59.8574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3511055a-9a3d-4f71-3783-08dbd57bd2ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248
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
>  include/hw/arm/allwinner-h3.h | 1 -
>  hw/arm/orangepi.c             | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
> index f15d6d7cc7..24ba4e1bf4 100644
> --- a/include/hw/arm/allwinner-h3.h
> +++ b/include/hw/arm/allwinner-h3.h
> @@ -36,7 +36,6 @@
>  #define HW_ARM_ALLWINNER_H3_H
> 
>  #include "qom/object.h"
> -#include "hw/arm/boot.h"
>  #include "hw/timer/allwinner-a10-pit.h"
>  #include "hw/intc/arm_gic.h"
>  #include "hw/misc/allwinner-h3-ccu.h"
> diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> index 10653361ed..d0eca54cd9 100644
> --- a/hw/arm/orangepi.c
> +++ b/hw/arm/orangepi.c
> @@ -25,6 +25,7 @@
>  #include "hw/boards.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/arm/allwinner-h3.h"
> +#include "hw/arm/boot.h"
> 
>  static struct arm_boot_info orangepi_binfo;
> 
> --
> 2.41.0
> 
> 

-- 

