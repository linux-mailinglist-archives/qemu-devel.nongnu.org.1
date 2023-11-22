Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 601F27F50ED
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 20:51:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5tFh-0004Fa-UP; Wed, 22 Nov 2023 14:51:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1r5tFe-0004FM-NY
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 14:51:11 -0500
Received: from mail-dm6nam12on2087.outbound.protection.outlook.com
 ([40.107.243.87] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1r5tFc-0003zs-VC
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 14:51:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNZ9LwxiGvhw225C4cUbWJZzTY2WwmP+sJOZhF37CjDYccagKqxsiSwNpUhS6mwjS+Pn8pUOWJkvoml9C+mh6v8hCbGIAIw8lpe4zxWux3L2fycu61Z/eId0Lm/Idw3ptDwGl1jLiimCjsZ4yIjlZIaDPiP2cjbftMKi37Pt91G24i1qDWx0LQxcu370kLaWswXbI42abD8XMSF2vOma4sQU5K+wKabbcMJJMgHOrzsEEHaoG0kFviBE9klvVs3x8Njs/IVmptX/Y3q5UdDBN0hHVoWmIvrixaKc4v/MOH/0lLT40LJOQK6HIO/eDLFpvttPvAr2W5q/dboo8oRubA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHRYc85R2ecQBIwGGFz3wueKOD9PfvAaTN+elDpycSI=;
 b=nOeC/FdEBgW2RFcppV6Opw9mOQnD3Dz61LP62+VYMdKzcEyrx00wDoxfi72VBeEfVcYexzBZbMnOv4ZEPfxZPEHqtf+BYr/XKtiBQL2KVw2GbtvtwcK8HhhwScQuDiVwZUbl2zAnM8XrnCttc4efZJOQ1FjJbYqlsW28dth36e/26NQcAT+nyN/6brg48bEZf4qFx9U33waVgfZsAFgas2nNX/X48LVdSdlFOtmzZwSjlJkmYO6oZNsOHieRxCjnteHl0AU6E8IDa3cd+M4Q1MRGKRqvCy65+LwtOiDNU0EF0jyMplm6Mc3pYkWaFQOqTCIW58rG1pN8SqjX5YvD6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHRYc85R2ecQBIwGGFz3wueKOD9PfvAaTN+elDpycSI=;
 b=AuE9wT7BqVcAqU0bx6Xm0Apl/MWY04CPiCRNFso2SXc0EpLf7S+eZkly22GVOw8zQRp+9HsjCnYgfZCYKSp41BdQaSL4FU/e2WBB98/qNS+gKwnd4z+yNbxPJ0dGgLplqxkjhd8Cs5j5BjVZMXVL6pGqFWBKpu5uRiq29E+W/2c=
Received: from CY8P220CA0047.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::6) by
 DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.19; Wed, 22 Nov 2023 19:46:03 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:47:cafe::16) by CY8P220CA0047.outlook.office365.com
 (2603:10b6:930:47::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34 via Frontend
 Transport; Wed, 22 Nov 2023 19:46:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 19:46:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 13:46:00 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 13:46:00 -0600
Received: from figlesia-VirtualBox (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 22 Nov 2023 13:45:59 -0600
Date: Wed, 22 Nov 2023 20:45:56 +0100
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Anton Kochkov <anton.kochkov@proton.me>, "Vikram
 Garhwal" <vikram.garhwal@amd.com>, Jason Wang <jasowang@redhat.com>, "Pavel
 Pisa" <pisa@cmp.felk.cvut.cz>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 "Qiang Liu" <cyruscyliu@gmail.com>
Subject: Re: [PATCH-for-8.2 v2 2/2] hw/net/can/xlnx-zynqmp: Avoid underflow
 while popping RX FIFO
Message-ID: <ZV5adH5HXp9o+dsr@figlesia-VirtualBox>
References: <20231119225102.49227-1-philmd@linaro.org>
 <20231119225102.49227-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231119225102.49227-3-philmd@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: d6248bce-081f-4650-ce55-08dbeb93a80e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJb1FaqlAvk9nC4yC3YVgD4wkN3fTXtKEUuRC3xFZmfSKSkjKVWxvIS6iLyE+FhY4gMUUqK/UEw6OswwsMmXvBl0a+7LhFqS2DZGm3ZocDqGfqetBQ0Ftr3WdGEpvCoLATWh5m7bZTdhis5KK25d/XDnIqk0DJuzeyoWAIr7bSyW7PnOBQadBWqcUwr0I5+QM3ykc/UguX85o2sar0Q1beKc4qCH+L0SRueXw2L4XptG9sEK5drpHJohAeeQOT/Iltj+myeRIJIIQZxBg3mEE1GtaE28Qf8bt3bg4oubn4r2vALEFXeyaClsDS2xBYe9q4IPc8vIjMLwMWcNcpUNfHPNAnri0pP/uTslaZVGR0+kKx0NDVHKF8j8vVtB0o7lZgj7FAQUgVqRUudd15nSW3AUCrNUMFBQ2CLAnTxHw7HnWD3ss/gKZAekjbCMqApB78Ag/lBNhfywglhAWzCzlxgnKBEdgtTXYpGySg6Q1EFgfBz6+wfG5mgQS8+Fqbtycc71/Qj47R9JbXzahP8P7YRui7JQYZloD/s6sltIyZL2NmWxFe2Q+sz7ay8lQ1BPwcJVGYJaf62gNxTPCJ5IiBPZDcya0H7qVWKPRnOfCuLlogY4bHYjTWBc3Vr/D2yTzkjCyiohStJtWvAhbFjJhXKuHm+SK2z04viVaEA9nHGLoWe7z//bmZ5hPupSkv1oW+bp6/W/NxooLqblbeQuHdXeoigcWVbZtSE7UGKAKQobVlhO9CvWu32BGgd0AA5I7XS8B2jHJ6Bvmw3ryd2/dVd1YtCZm0t/P7yvqKdcT6EezEDGYXMu/lLUcB12vVJhxGabRiZcF++QIAeyzZNLGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(40470700004)(46966006)(36840700001)(478600001)(83380400001)(70206006)(33716001)(70586007)(9686003)(40460700003)(426003)(336012)(6916009)(54906003)(316002)(82740400003)(966005)(356005)(40480700001)(81166007)(4326008)(36860700001)(8676002)(8936002)(5660300002)(6666004)(44832011)(47076005)(55016003)(26005)(86362001)(2906002)(41300700001)(67856001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 19:46:01.4225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6248bce-081f-4650-ce55-08dbeb93a80e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134
Received-SPF: softfail client-ip=40.107.243.87;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, Nov 19, 2023 at 11:51:02PM +0100, Philippe Mathieu-Daudé wrote:
> Per https://docs.xilinx.com/r/en-US/ug1085-zynq-ultrascale-trm/Message-Format
> 
>   Message Format
> 
>   The same message format is used for RXFIFO, TXFIFO, and TXHPB.
>   Each message includes four words (16 bytes). Software must read
>   and write all four words regardless of the actual number of data
>   bytes and valid fields in the message.
> 
> There is no mention in this reference manual about what the
> hardware does when not all four words are read. To fix the
> reported underflow behavior, I choose to fill the 4 frame data
> registers when the first register (ID) is accessed, which is how
> I expect hardware would do.
> 
> Reported-by: Qiang Liu <cyruscyliu@gmail.com>
> Fixes: 98e5d7a2b7 ("hw/net/can: Introduce Xilinx ZynqMP CAN controller")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1427
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


> ---
>  hw/net/can/xlnx-zynqmp-can.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
> index 58938b574e..c63fb4a83c 100644
> --- a/hw/net/can/xlnx-zynqmp-can.c
> +++ b/hw/net/can/xlnx-zynqmp-can.c
> @@ -777,14 +777,18 @@ static void update_rx_fifo(XlnxZynqMPCANState *s, const qemu_can_frame *frame)
>      }
>  }
>  
> -static uint64_t can_rxfifo_pre_read(RegisterInfo *reg, uint64_t val)
> +static uint64_t can_rxfifo_post_read_id(RegisterInfo *reg, uint64_t val)
>  {
>      XlnxZynqMPCANState *s = XLNX_ZYNQMP_CAN(reg->opaque);
> +    unsigned used = fifo32_num_used(&s->rx_fifo);
>  
> -    if (!fifo32_is_empty(&s->rx_fifo)) {
> -        val = fifo32_pop(&s->rx_fifo);
> -    } else {
> +    if (used < CAN_FRAME_SIZE) {
>          ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, RXUFLW, 1);
> +    } else {
> +        val = s->regs[R_RXFIFO_ID] = fifo32_pop(&s->rx_fifo);
> +        s->regs[R_RXFIFO_DLC] = fifo32_pop(&s->rx_fifo);
> +        s->regs[R_RXFIFO_DATA1] = fifo32_pop(&s->rx_fifo);
> +        s->regs[R_RXFIFO_DATA2] = fifo32_pop(&s->rx_fifo);
>      }
>  
>      can_update_irq(s);
> @@ -945,14 +949,11 @@ static const RegisterAccessInfo can_regs_info[] = {
>          .post_write = can_tx_post_write,
>      },{ .name = "RXFIFO_ID",  .addr = A_RXFIFO_ID,
>          .ro = 0xffffffff,
> -        .post_read = can_rxfifo_pre_read,
> +        .post_read = can_rxfifo_post_read_id,
>      },{ .name = "RXFIFO_DLC",  .addr = A_RXFIFO_DLC,
>          .rsvd = 0xfff0000,
> -        .post_read = can_rxfifo_pre_read,
>      },{ .name = "RXFIFO_DATA1",  .addr = A_RXFIFO_DATA1,
> -        .post_read = can_rxfifo_pre_read,
>      },{ .name = "RXFIFO_DATA2",  .addr = A_RXFIFO_DATA2,
> -        .post_read = can_rxfifo_pre_read,
>      },{ .name = "AFR",  .addr = A_AFR,
>          .rsvd = 0xfffffff0,
>          .post_write = can_filter_enable_post_write,
> -- 
> 2.41.0
> 

