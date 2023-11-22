Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 810027F52CA
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 22:45:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5v0Z-0000Bi-SP; Wed, 22 Nov 2023 16:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1r5v0V-0000BU-4i
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 16:43:40 -0500
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com
 ([40.107.92.89] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1r5v0P-0007lP-No
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 16:43:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xnp11x/GPewO/kPyiq0nkl7xZlTiwGonBFywhL2smSEkukuvdkic9noMFeRlN/bS+5udcJTsHkLGn0MWY1wF1CNctEP3ElNyKSUZQmp7nu/NR+KkIuoandfyfHonozsmXBEBEsg+7scwYe2huXhHLFifKIkvhaAYsQDco9ZXYU7CXRcfZaA7t9jSgMQRlBYEvEMFJo5t5P6KWvhrDsr4WO1b0JrTMrub2EKfwcz4BK8VIsiXF04KTdWQrv/aA7JePAzxtajBn/4jm+U6ugvCRQX3V8bYUTXiVYuB53zbajdfsmmoyHPgjmX2sgLBZPPKv25aQXfD1Rc6ANVWfp8myw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5GPuWymHpN14CLVr63IveLTMtrCpEwFuAOksqzQG74=;
 b=mXjUVOxqyeIp7F3CNFkMFGRNhvlWUmXmAsu7UW6JD5504/xCkUCws9QvqqJQAC6S8FCt5VD10ijMpwH1C/2L4JXnqXr4v2iW8xoU4tqSfUGodQHhNQ6lR1nH43LH1J8nxbLbTkXfaphMOXBUcMsvjBWSGCpc+ffyjXZOOUCua233stQngPRf8J6NCa56WppvQEAjWtZ2tSibB3t5WxF2vck5MEZNNyPvVmAXG+2G5yZR3bV4OQwn1ZPykTbQAl0dEnBdsEBPrY4ZIn6jJFIsEYVtygxXQrnzORea2swGTqrMleI584IKTqRjkJT7agIaQ/SGDgXe+kc7l0FEo3+gWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5GPuWymHpN14CLVr63IveLTMtrCpEwFuAOksqzQG74=;
 b=GYDk9EaqP7ezeGDnnjdN8gq74TdEXrBxGo7UDQsEZbAXEICBaVqA+wAja5A7G76Pueimliha1dmqcR3g75XjTElGHJePhpAKbbFz9k/5zOtCfQoZoLVtQub3XpNF4apzcqc5guMez9qWLK04tinxF7a7SCwzLJs3LQadJVud7dA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 by SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 21:38:25 +0000
Received: from MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::5aa3:9748:d8d0:87e1]) by MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::5aa3:9748:d8d0:87e1%5]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 21:38:25 +0000
Date: Wed, 22 Nov 2023 13:38:21 -0800
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: Francisco Iglesias <francisco.iglesias@amd.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Anton Kochkov <anton.kochkov@proton.me>,
 Jason Wang <jasowang@redhat.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Vikram Garhwal <fnu.vikram@xilinx.com>, Qiang Liu <cyruscyliu@gmail.com>
Subject: Re: [PATCH-for-8.2 v2 2/2] hw/net/can/xlnx-zynqmp: Avoid underflow
 while popping RX FIFO
Message-ID: <ZV50zcExK-fGhnTV@amd.com>
References: <20231119225102.49227-1-philmd@linaro.org>
 <20231119225102.49227-3-philmd@linaro.org>
 <ZV5adH5HXp9o+dsr@figlesia-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZV5adH5HXp9o+dsr@figlesia-VirtualBox>
X-ClientProxiedBy: BYAPR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::32) To MW3PR12MB4409.namprd12.prod.outlook.com
 (2603:10b6:303:2d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4409:EE_|SJ0PR12MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ebe2579-c4fe-4f25-39d1-08dbeba35ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFQqRcM8z/vUeul2eAC8tCdLfkpe2T54JGEEa6/lzhwppvs7MNmjaqzGstsEKmQFgouks8sgNkyjIWvUVlrjJDArirkQx1a9/f2AqoQ4YxC+lfbJwMQW2mhFVp/yhxOTMQTnW98iftTgcNOoQLX2XVHrsLuXbbKO5e5JtBnqI2XMEza8HRCFHU+1UEKzRO4XPxchf4UaDxM81U4PsgeFeiiiME3m15kWuRYwzUcCRAWo8381WvrRUm1PN2CL/3IqZkOcUCg6GBhF22KIfpy8VuFNj/5kbd6Zb9wUGmLGywDfxF/jAU5kL/+tgXyN4R0zrEH1bHNiMvhyo7LJv12iO7YKWP6DKmIT0ujcx6kgwCDndhBvP9IJlFYc2Wr4vj7cmecODRFbTi/gYSZ5GBcV6P9ZnLxtyBr/eOocnC3eLoxSE0V7zC/MVoShjh+D+AmAIaAHd9nfIG+ccVyWl3CUBPjkBrgicoUvsNvW+U/04Bn0LBGg8a4xTiePV6HommFESryuvpOW50DSP7i5B3rKZw/KjjxP22UU1BiLaJADyYEj1UUAOog3AIEhreCJamqEVDgdaERirPwa9kUCDByJVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4409.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(8936002)(8676002)(5660300002)(6506007)(6666004)(44832011)(6862004)(4326008)(41300700001)(2906002)(86362001)(66946007)(66556008)(6512007)(37006003)(6636002)(2616005)(66476007)(38100700002)(478600001)(83380400001)(36756003)(966005)(6486002)(316002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0pOK1FlamhyRXNncm9XQTA3a2w2QTR6MzZ2OUpGSVk5eTllSWpEME1KOU1w?=
 =?utf-8?B?b3cvYzFNRTJxeHNhVW5EUVdhNTUzN0JZcVNNeFdWMS9Zelpya1ZnTjJvQUlp?=
 =?utf-8?B?T0VtUExxTU5zYWp5NmQvMFhlbXV2UjJiSE5VcmlEa09qdU00djkxK25qblZV?=
 =?utf-8?B?NmMxZ2JDQzZYVVhDWXY4UDUzS1BXZVFJdjQ4c2UwZ1p0UlpiVnhUZDZ0UUEr?=
 =?utf-8?B?cXRNalpwenNGSG1MbncvVHFYNGlFZkVLRVNxNmo1a1c3R0VOQ1FzUGg3SHkv?=
 =?utf-8?B?cFV0MEh4ekFNbVdZK04vY0Rqc0RUUks4aXNsWDZTbUdpS3lwU3lCbGFMbWZB?=
 =?utf-8?B?MVB3SWM1RTJrUVNGb0FZSjlOQ2F6Rkp6blVrVUlteDVrdWR5V1RaWHVBYkRH?=
 =?utf-8?B?Vy93dWN3VE40VkQ3aEdqbFFDeDVMRVRVVGZFbkVDams3MnNncmh3MUtCQlpj?=
 =?utf-8?B?RVMvUG9kSlJaVG9SYmMydWV0QTV1a21scnNnd2Rqdk1aZVdlU0hPYjZaMjUx?=
 =?utf-8?B?MkN3SnNBazVGZ1NjdmcySmc1RFdTTjN0RDNkWGNMNlJoMWwyVEdkUzRxYnZJ?=
 =?utf-8?B?Yzh4T2VyRWFtWkpseVJjbm9SNUVCZEVWNjJXNklBWHVPeHFJNzYreWZ2cHdJ?=
 =?utf-8?B?d1d1RFFzTG5qV2svaU82QWFNbW5HV0dFbWFHa1NSN2wrMmtGcEhhOUM2T0dW?=
 =?utf-8?B?U0pFeTk2akxBelAxL2ZERVF1OFlKMHpUSC9sWTZFQW5OQ1gzaDk3aURhQ2Zi?=
 =?utf-8?B?WHpkYTZvOS9ZeGFCdzBFTHVsdDFFNnJvSVJKWmtiN1F2cVdkaDJyUzVZb0VC?=
 =?utf-8?B?SXB1SWhJS2h0SHBPTFltLyt0ZDlTTEVZSnpaSkQ1RnN3Q1lMeHpnSUN5dXlZ?=
 =?utf-8?B?cms4UFFuV0NhSkZMZnBRKzNtNndiQ0JIMWRoVEJ0a3VOYlAvemZCRUdFT3FT?=
 =?utf-8?B?ckhJZ2tNYmR6eUQzMVhPWnQ1SzRyY0FjSnpHTVR2TFBXU29qUlpYYS9RYmMy?=
 =?utf-8?B?Q0hNUVNrQzFPVUJCa20xWEhUWTB5QVIrU1VBQXZzNTU5WFREamh4bGtRVy9t?=
 =?utf-8?B?YzdTMHBCRTVPNUZ0REgvcG15dlBGc0l4eUJKN09DaHNPeWt1Q3g4U25GNC9U?=
 =?utf-8?B?MVQ0MStkdDhLbnNqVzRscitLUDFKRDMweTQ1dGV3OHdJalF0dVBVN3RVc1pD?=
 =?utf-8?B?eFo4d3lEcXRHdzZtZCtuK0hlM1AyU1JDTVFOZ0Z5SGd5WXhBT1hNT2h1Nk83?=
 =?utf-8?B?RWZWVHh4R1VFUVdodEppNEZrbWtXWUxtRVJjK3UxWC9XNzBMeTdaeGpOcnpv?=
 =?utf-8?B?Vy9Hc1lEcksxT0t6U014YXArRG9DbS95S043bGg2Ujc0Mm1TY3dNbVh6UU9I?=
 =?utf-8?B?YWhMWnJpUTN6OGV3UkxCSmNnV3MyaHBOeXI0bllyM1lNSWlaZ1lXTkhPTlMx?=
 =?utf-8?B?VEVoTU5BakJYenl4SUgrVXFmTGpqSkFOTFVFbEdpYzFuNGRjcjI0TnJudFlD?=
 =?utf-8?B?SC90MjV4K043UlVKUmY0bHAxRVV4aGFRWjJ6SGZ6bmE2T2FTWUwrSUFGMVlw?=
 =?utf-8?B?MWhOK3ZldzR2VXpZVjdaMHZpeHZJT056RGxxbDJKZUd0VmZydjBHUXQ4UHQ4?=
 =?utf-8?B?eXUvd0l0ZTVqdkVTTmZLNmY1MlhqOWtDbEhLaWhKdlRXN1V6Tkk4YnNsTGtu?=
 =?utf-8?B?OGYrUmhxZ3ZGT3N1NGx2WVB3L2JES084YXdVbENyemVkbXBVVU5ZZzN6RzI5?=
 =?utf-8?B?K1pEVW56c1lVZzFKSlFSVHJsUWtEMzd5dXZXY3h3QU9jNUdPejFDVW9MU1or?=
 =?utf-8?B?U0Q5NmZxMGtQUk5VTno3RHVha0VmMFJZMG9hdHU4bUhJelNBUS94VkpxQjl0?=
 =?utf-8?B?RHpnS1FNaGhZM1dCVGppK2F6cC9ZeTIxblF2amY1L2ZWbVArUDZuai9rSzRt?=
 =?utf-8?B?LzFJbjlZYU9lZlpHOUhWK0JoM1NpQS95SzNqd3V4bDE0cGdINzFmMTdaN3Qz?=
 =?utf-8?B?QjErY0JsdzZZekJMZ2FvZUU0RVA4cDg1UXVYbEgrU3g3d2NrWS9Tc2o5b2RL?=
 =?utf-8?B?amhYSzkzVUVTMkVhQkhlOTVvR3FWMkpqbzIwWVl2c1VQTHRxM0ZIdWtoQm1z?=
 =?utf-8?Q?oLwRGnaGHfKUoGH7O5Wk5ErWX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebe2579-c4fe-4f25-39d1-08dbeba35ba6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4409.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 21:38:25.4496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qLBpU61SfoESGZ7iyGG+nJogg3i6MuHBUaf9F5lAyb17WMHRa3a1WrgKxXgXeuQyuBx2RVsXVAKpoUgnVqQvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685
Received-SPF: softfail client-ip=40.107.92.89;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

On Wed, Nov 22, 2023 at 08:45:56PM +0100, Francisco Iglesias wrote:
> On Sun, Nov 19, 2023 at 11:51:02PM +0100, Philippe Mathieu-Daudé wrote:
> > Per https://docs.xilinx.com/r/en-US/ug1085-zynq-ultrascale-trm/Message-Format
> > 
> >   Message Format
> > 
> >   The same message format is used for RXFIFO, TXFIFO, and TXHPB.
> >   Each message includes four words (16 bytes). Software must read
> >   and write all four words regardless of the actual number of data
> >   bytes and valid fields in the message.
> > 
> > There is no mention in this reference manual about what the
> > hardware does when not all four words are read. To fix the
> > reported underflow behavior, I choose to fill the 4 frame data
> > registers when the first register (ID) is accessed, which is how
> > I expect hardware would do.
> > 
> > Reported-by: Qiang Liu <cyruscyliu@gmail.com>
> > Fixes: 98e5d7a2b7 ("hw/net/can: Introduce Xilinx ZynqMP CAN controller")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1427
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Vikram Garhwal <vikram.garhwal@amd.com>

> 
> 
> > ---
> >  hw/net/can/xlnx-zynqmp-can.c | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> > 
> > diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
> > index 58938b574e..c63fb4a83c 100644
> > --- a/hw/net/can/xlnx-zynqmp-can.c
> > +++ b/hw/net/can/xlnx-zynqmp-can.c
> > @@ -777,14 +777,18 @@ static void update_rx_fifo(XlnxZynqMPCANState *s, const qemu_can_frame *frame)
> >      }
> >  }
> >  
> > -static uint64_t can_rxfifo_pre_read(RegisterInfo *reg, uint64_t val)
> > +static uint64_t can_rxfifo_post_read_id(RegisterInfo *reg, uint64_t val)
> >  {
> >      XlnxZynqMPCANState *s = XLNX_ZYNQMP_CAN(reg->opaque);
> > +    unsigned used = fifo32_num_used(&s->rx_fifo);
> >  
> > -    if (!fifo32_is_empty(&s->rx_fifo)) {
> > -        val = fifo32_pop(&s->rx_fifo);
> > -    } else {
> > +    if (used < CAN_FRAME_SIZE) {
> >          ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, RXUFLW, 1);
> > +    } else {
> > +        val = s->regs[R_RXFIFO_ID] = fifo32_pop(&s->rx_fifo);
> > +        s->regs[R_RXFIFO_DLC] = fifo32_pop(&s->rx_fifo);
> > +        s->regs[R_RXFIFO_DATA1] = fifo32_pop(&s->rx_fifo);
> > +        s->regs[R_RXFIFO_DATA2] = fifo32_pop(&s->rx_fifo);
> >      }
> >  
> >      can_update_irq(s);
> > @@ -945,14 +949,11 @@ static const RegisterAccessInfo can_regs_info[] = {
> >          .post_write = can_tx_post_write,
> >      },{ .name = "RXFIFO_ID",  .addr = A_RXFIFO_ID,
> >          .ro = 0xffffffff,
> > -        .post_read = can_rxfifo_pre_read,
> > +        .post_read = can_rxfifo_post_read_id,
> >      },{ .name = "RXFIFO_DLC",  .addr = A_RXFIFO_DLC,
> >          .rsvd = 0xfff0000,
> > -        .post_read = can_rxfifo_pre_read,
> >      },{ .name = "RXFIFO_DATA1",  .addr = A_RXFIFO_DATA1,
> > -        .post_read = can_rxfifo_pre_read,
> >      },{ .name = "RXFIFO_DATA2",  .addr = A_RXFIFO_DATA2,
> > -        .post_read = can_rxfifo_pre_read,
> >      },{ .name = "AFR",  .addr = A_AFR,
> >          .rsvd = 0xfffffff0,
> >          .post_write = can_filter_enable_post_write,
> > -- 
> > 2.41.0
> > 

