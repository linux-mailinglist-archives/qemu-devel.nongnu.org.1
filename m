Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1A27EBEB3
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 09:40:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3BRo-0005uK-LG; Wed, 15 Nov 2023 03:40:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1r3BRk-0005ky-TP; Wed, 15 Nov 2023 03:40:29 -0500
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1r3BRh-0005HI-9f; Wed, 15 Nov 2023 03:40:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvuH2njQ0+zfmoh2X+w3Nzn3xdowR33ZsXUWT/zj85Q8r98uOjXcE7mXcgC+2qrdd0P4yx+Q2ZRUMOjvN8T3JUUH4Ui5cyIUQ7Ih5Sz3Azv9CGSjSa1WqD8KGczSLBykGa6L9XyY5x5UYY0SJjCCf61fUIDwxAb5hRVdB4mdxRUiJZpZn9qldSaqoFfZI2lLXJdYYW3tJufaQ4J/JCvATUtfpO0VzQXsdLu3mHD3MiLNH7AkHswPHzVQLRqfS1eF6EtleJMZsAFafp1t47YNR0qrgIUVYcokieFz6/qQQoPk2TGKRqDckUvvj9EPol4ojlcauvRiMoGw4UHv1/Cn8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CE3PQmkF4nGQZcDZDL1Z2CNDNOL9IDb9jheaYBS1GH0=;
 b=Jv0i2hJZ7tVQRAtQhD48nWH4HILpyEMzBXIXI4h9uyMkWzwoe7qSxEyAKhHI/7q3AxYbmVwbk6bKYY3lHy5FVuSjXS1xulE6yH4cqEPd5un/FXKhLfJKeOHBrFgx7JMagWLjSU3M49lPyP9NCS7dqpL7jS08tIbwVRHcg84IejWKt/Cm62Ehp9oRDr4xSw15MxcrDToVMfK7R1oe0UKcjN5YrQiTgQQoxfOnS9otpjk5X3Od6bbZ50debdWUytUfSZPs8Z8SuDV+oIRVlt9dASx7uhcWQJE5e+jQx7x1V6flbeKiH+J0kd/yQysI0FeWqZGZQ4gfIRIu+FGhykKQUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=tls.msk.ru smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CE3PQmkF4nGQZcDZDL1Z2CNDNOL9IDb9jheaYBS1GH0=;
 b=jt3xBL8YYT3EZGIZSHlW5YLCIX9fZBfxyqcJ2e85cPqL2pEf4OJhMmeRPa5OM/zko5mnvdG6QjgyUOTA2T0ljd9E+dWgLxCxRDoSG0k/bNhZRCrH5+sAvU4nWFYyOQvZ4NCbGCu2iwCeDdDDHnMoIJIMAMfjFhishDbvcEEZ9Hk=
Received: from MN2PR14CA0019.namprd14.prod.outlook.com (2603:10b6:208:23e::24)
 by DM4PR12MB6663.namprd12.prod.outlook.com (2603:10b6:8:8f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 08:40:17 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::45) by MN2PR14CA0019.outlook.office365.com
 (2603:10b6:208:23e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Wed, 15 Nov 2023 08:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.14 via Frontend Transport; Wed, 15 Nov 2023 08:40:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 02:40:14 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 02:40:07 -0600
Received: from luc-work-vm (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32 via Frontend
 Transport; Wed, 15 Nov 2023 02:40:06 -0600
Date: Wed, 15 Nov 2023 09:40:04 +0100
From: Luc Michel <luc.michel@amd.com>
To: Michael Tokarev <mjt@tls.msk.ru>
CC: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH trivial 13/21] hw/net/cadence_gem.c: spelling fixes:
 Octects
Message-ID: <ZVPHpE6wofkn1UMT@luc-work-vm>
References: <20231114165834.2949011-1-mjt@tls.msk.ru>
 <20231114165834.2949011-14-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231114165834.2949011-14-mjt@tls.msk.ru>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DM4PR12MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec3a6c0-78ec-4c60-2d82-08dbe5b67e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0LX0elu9O9sYrD5f/r8IwcUt0nzV/wFouPLN2wsPTp5sRGpREzmBn2WFSowwIuDGlUHXXjiAqpBmEDCWAqX5fR16UTxBKBpg5JctIDZN1InhlURdIjfbFzZmIK64OJIj3v+SZPRD0Q8bpbPVXixe9E3rNdbfKJKCTvF4pSWjqPCy5bocAhZcgOUUWTQY+DblfrxOhnUBAz4UBixWmSAnHDppkGVCD6X7fM2vetbFNtHtqIfTkf9WULs4NWtWOf3RbRH1dAsJWnkAgKZfeq9CXsEzbi6zYBuMEw+5mtvptfKyJFCOMjKmBZDbGgYo7A1dg+LRBTevdXPLydWOAhf6oKZzyg++Rv1ZiF8SzmEp33PLlo7T9gynmP8br5pm8j6PaNAc/mm4aX2MLWywihPpLZ3nZaM44IDaD9RzB4DOTJF1fvmY7p8MRXMI3tOH/zaaI98fAuEezLxHShOa6J4WulOD3ODec64cfnI2NPF+3xY4Y00Bif64CgSB3cVGHs/P8ux/0xVtjfY7lOx/E3q7aC7eEdyfwoF4AecW72f8fBetiPJZx8SfAVpVmc8ezOF5/lgQX7tW893QV00gvun95tjHK8lp/o5y9oURaOd/svJaBMLVJjooVQ//vtUnV9DK8nOv1mMb6s13JEVYWYgtZwfrOGrH3MElA3ZGYT8qoSDnV2Bq/PCDamHVPfXPvZ3eUljBvi1kcRBZPVnejoNhT3VN7EQyFoEJlzZi1TzTNv66KhiHok3xjs7qPm5pBwYSplC/WfurD85DBvlBzjN2Bg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(40470700004)(46966006)(36840700001)(40460700003)(36860700001)(426003)(26005)(33716001)(336012)(9686003)(83380400001)(8936002)(8676002)(44832011)(5660300002)(4326008)(2906002)(41300700001)(47076005)(478600001)(316002)(54906003)(70586007)(70206006)(6916009)(86362001)(82740400003)(81166007)(356005)(55016003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 08:40:16.5959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec3a6c0-78ec-4c60-2d82-08dbe5b67e28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6663
Received-SPF: softfail client-ip=2a01:111:f400:7eae::600;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 19:58 Tue 14 Nov     , Michael Tokarev wrote:
> Fixes: c755c943aa2e "hw/net/cadence_gem: use REG32 macro for register definitions"
> Cc: Luc Michel <luc.michel@amd.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Reviewed-by: Luc Michel <luc.michel@amd.com>

> ---
>  hw/net/cadence_gem.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 5b989f5b52..19adbc0e19 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -225,8 +225,8 @@ REG32(WOLAN, 0xb8) /* Wake on LAN reg */
>  REG32(IPGSTRETCH, 0xbc) /* IPG Stretch reg */
>  REG32(SVLAN, 0xc0) /* Stacked VLAN reg */
>  REG32(MODID, 0xfc) /* Module ID reg */
> -REG32(OCTTXLO, 0x100) /* Octects transmitted Low reg */
> -REG32(OCTTXHI, 0x104) /* Octects transmitted High reg */
> +REG32(OCTTXLO, 0x100) /* Octets transmitted Low reg */
> +REG32(OCTTXHI, 0x104) /* Octets transmitted High reg */
>  REG32(TXCNT, 0x108) /* Error-free Frames transmitted */
>  REG32(TXBCNT, 0x10c) /* Error-free Broadcast Frames */
>  REG32(TXMCNT, 0x110) /* Error-free Multicast Frame */
> @@ -245,8 +245,8 @@ REG32(EXCESSCOLLCNT, 0x140) /* Excessive Collision Frames */
>  REG32(LATECOLLCNT, 0x144) /* Late Collision Frames */
>  REG32(DEFERTXCNT, 0x148) /* Deferred Transmission Frames */
>  REG32(CSENSECNT, 0x14c) /* Carrier Sense Error Counter */
> -REG32(OCTRXLO, 0x150) /* Octects Received register Low */
> -REG32(OCTRXHI, 0x154) /* Octects Received register High */
> +REG32(OCTRXLO, 0x150) /* Octets Received register Low */
> +REG32(OCTRXHI, 0x154) /* Octets Received register High */
>  REG32(RXCNT, 0x158) /* Error-free Frames Received */
>  REG32(RXBROADCNT, 0x15c) /* Error-free Broadcast Frames RX */
>  REG32(RXMULTICNT, 0x160) /* Error-free Multicast Frames RX */
> --
> 2.39.2
> 

-- 

