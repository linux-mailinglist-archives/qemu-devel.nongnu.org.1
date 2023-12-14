Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 454A18129C0
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 08:52:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDgV2-0004JU-4K; Thu, 14 Dec 2023 02:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rDgV0-0004J7-89
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 02:51:14 -0500
Received: from mail-dm6nam10on2043.outbound.protection.outlook.com
 ([40.107.93.43] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rDgUk-0006cO-Pw
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 02:51:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVR6Wib2KPdS6LuNjwtA5xMGjV1mVDvuNAac487AVQbeZc8/ZI9vqpku6b9famKKQ6hxuLZiXy0eckB8hJLq2OWFBh4kZerLe0xuJ6c2FPoya1ALA/1vG5NDYl0k9D/hZqIrVVX2QrbaZJ1nQgJotG62rFzAONmRy/9eEax4I1BcKLjbLH8WndaJK09meFPZ1mJn4Bf2wJqwxN1VclqLz3vOmHj9Q+aZV+6FaFwvcHWdQQHYasiwOeopQdg7L5gFrPB1A3AxI6TuNSxB2ONXoCmBAahKC6/LeOMy+96ipeve3chpUoKhdDg57ZqNbtIjSQ1BUBUyWuWXgR8PwMQuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M15jMlWOuAiEonUH23R3C3uDv2z2xgzBfOoY+TgKreI=;
 b=bNs38hFrAOcX5DxMvWT/YTDirfyMRYbj1oHMppX2JjY0/eD+deLJtpRTyTVLsPrsPWuHi7ULUnqGrLGTu/OJqhjqXL8W1C03EA5w21PNFBZBEHM8pMNM2vtzfm/5vKilitmIe8OQikKSiizgwYcwpTQE7dknhjtuTp7YFRy9mkhlAnZ+U9VzjfaRIf/GmPouPQX1RXinyZ9CI4QGhBLcV46YycAx6WirPQTbelJLeM420BW8qRzZW3kEiWhLSB537puJCylLG825iWg6POXPQnoeNidYP3t09WDQ9UBLIfL0eWOZQ+6RuTDUUpDAu8HQHwakup/cyox9/hDmK7hi1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M15jMlWOuAiEonUH23R3C3uDv2z2xgzBfOoY+TgKreI=;
 b=EqNu/lyhyr0u3vDodGNWBmaqvaJcszLrQVKTGjWKmezQU56YdYUugXBql3QxlJlSjylLpa8C1oq8e84XtlgDmP2n+utpKRhQiZakV0CQKtcaYx6PEEsIlPwbucG1epllNuLPTXiV6+JqmqkElnYaiXw4+VU64k0FQQAt0jM5DnM=
Received: from SN7PR04CA0200.namprd04.prod.outlook.com (2603:10b6:806:126::25)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 07:45:43 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:126:cafe::e7) by SN7PR04CA0200.outlook.office365.com
 (2603:10b6:806:126::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.29 via Frontend
 Transport; Thu, 14 Dec 2023 07:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 07:45:43 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 01:45:42 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 13 Dec
 2023 23:45:42 -0800
Received: from luc-work-vm (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Thu, 14 Dec 2023 01:45:41 -0600
Date: Thu, 14 Dec 2023 08:45:39 +0100
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: Arnaud Minier <arnaud.minier@telecom-paris.fr>, <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Questions about clocks emulation
Message-ID: <ZXqyo7UJcNwgVtej@luc-work-vm>
References: <1001572703.6422667.1702386300513.JavaMail.zimbra@enst.fr>
 <9078f5a2-648b-4f83-b2e9-8c9b16b8e0ad@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9078f5a2-648b-4f83-b2e9-8c9b16b8e0ad@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b72396a-da47-41a9-b07b-08dbfc78ad15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERdr7JP1hJd0Hq/ET6NOhsDVgiGmqvxLvldqUFlqF/fJSFxAxQgBNIvUiJQTgFpTJq5YxDrX4bHC0PCHZYejLuvtgnR62vpbtmE8Ve6GTfZmlQrq6SsBv2a87Bh3dEJYlpDfDL3Q0Bloz2hNEm/StxJRYa6a2+k5Atz0yUW5plQI4n9lCW+J9kjER3PHTLODq0NeKtePLoEZpCf8x/yjBTRoHF2VnTEvvDmMV7SXyIyyMWER1yjYsNO/j3Q/u3BnTmuhdlmeBhOhPEq1Ka6sRb5rXRHQB9xCXfvIBsQRvAARpmjHV9w9QJg6cq8I/QrOH7r5aIPqVJ3L0zqFR83h+mYcVUOamRbu/moB1IpaYA5TOQPhh5SBuTlCiH/XZBAwk8Tl4esR8/TpSthO7MkBHClSdQGEa2Q8QhcHuJo2QzFIfL7/7ldgx0jZcJCXUiNRlD9GXZuQhWMzlHcYIFogW8yqAx2lI+tHUbYB7/tBDC1NmwpRldmJxaUh5fIe+kfe0uV0fYm2RForkXye51r6by69TA2dPqe52HrSRw1XttpzbFlkMcOGs2km2lQACN724Jlm8S4EGkZjDj7sk2YR6crdtwmPWnDW/XpBLjEZN6sC/C+5905IRgUfpDM6hboV6sTRtD5wAHbse9Qx3ULlv3PER8vo09q76NF+yf9FTDsC6Qmxospsk/sZkEf7s+62Lc3CBs1FMoE6WD4WLUZ+VRbQjKUx+TIt/+axh+O/uecCPYucVPfixhj4QjzSkfbTjL45Ef+WsrIdl3iVhaU9vImolgjTumCWnTRJabFOOq6AuV27foF12V4EoQiAIMfJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230173577357003)(230922051799003)(230273577357003)(186009)(451199024)(82310400011)(1800799012)(64100799003)(40470700004)(46966006)(36840700001)(55016003)(40480700001)(426003)(336012)(26005)(40460700003)(82740400003)(81166007)(86362001)(356005)(47076005)(83380400001)(3480700007)(44832011)(5660300002)(9686003)(53546011)(36860700001)(8936002)(8676002)(70586007)(70206006)(54906003)(6916009)(316002)(33716001)(4326008)(2906002)(41300700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 07:45:43.2743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b72396a-da47-41a9-b07b-08dbfc78ad15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916
Received-SPF: softfail client-ip=40.107.93.43; envelope-from=Luc.Michel@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hi,

On 20:13 Wed 13 Dec     , Philippe Mathieu-Daudé wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Hi Arnaud,
> 
> (Cc'ing Peter and Luc)
> 
> On 12/12/23 14:05, Arnaud Minier wrote:
> > Hi all,
> > 
> > I tried to implement the RCC (Reset and Clock Control) for the STM32L4x5_SoC but ran into some problems regarding clock emulation in Qemu.
> > In this SoC, it is possible to change the source of several clocks used for devices like the CPU, the USART, and approximately every other device on the SoC.
> > This change can be made at runtime by writing into a specific register.
> > I tried to model this by using the clocks in hw/core/clock.c by I noticed that it is not possible to change a clock's source once it has been assigned (see clock_set_source()).
> 
> Ouch.
> 
> I thought this was what connect_mux_sources() what doing (see
> hw/misc/bcm2835_cprman.c) but it is only called (along the
> clock_set_source() calls) from the realize() handler.

From a clock user API standpoint, we made the choice to hardwire the
clock tree, as it is in fact hardwired in the chip you are trying to
model (physical connections insides the chip do not "change" when you
write to a register). Things are usually implemented using muxes, clock
dividers and such between PLLs and devices. This is the approach you
should adopt when implementing your clock tree. As Philippe mentioned
you can have a look at hw/misc/bcm2835_cprman.c which is a real world
example of a clock tree implementation (in the Raspberry PI SoC).

> 
> > It prevents me from implementing a clock tree similar to the one on the hardware.
> > 
> > Is this limitation there for some reason or has it simply not been implemented?
> 
> There is a /* changing clock source is not supported */ comment in
> clock_set_source(), so likely not implemented :)
> 
> IIUC the only issue is how to update the src->children qlist.

IIRC from a clock API implementation standpoint, there were some serious
questions about dynamic reconfiguration of the clock tree. But I can't
remember the details (maybe some issues about migration?). But again,
the API in its current form should be enough to catch your need. If you
have a specific pattern you think is not expressible with the current
API, please expose it precisely so we can see how to fix that.

Thanks

-- 
Luc

> 
> > Thanks,
> > Arnaud Minier
> > 
> 

-- 

