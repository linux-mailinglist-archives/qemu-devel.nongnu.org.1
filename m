Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B97B7F52E1
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 22:56:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5vBy-0004eu-Rw; Wed, 22 Nov 2023 16:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1r5vBt-0004eN-OG
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 16:55:26 -0500
Received: from mail-bn8nam04on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::601]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1r5vBp-0001Pi-Ux
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 16:55:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVNEUwQcCHChZitDSBkyJdKwyx//O/ka9Yl34mm4GpNyKBBJlbwPyvy95NZaDv2WEBlhk/tdiz8DMcar6MJSav7HcTjS213AsyIdlYUBnZycZw8v6a/GddjxU+1gcOtMQB58B1VRC95UBMUL1dLjRu1bD3l6eWRqLKDEoyt1ZnBT0s+a5Yp8w28qIxBZ4xh3Rlugl/FvfqbbFFyJcBA9tBel3ymRSgNOkXH6uj9JN3rVOXZSt+vytXwNs8OqCJkuRTOLPdSRVeqGIStbtBCWri6mIhJrDHYu6UgcmtndgkOP90JfOOPR0n9nRo7G2/KBCenuR8kdcU4lQ1GIJXIlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETJ9VvqA/GqOWT8XOgx7kobRvSAN3E1BhdOw1DqRvr8=;
 b=aU8uDl+s1TQ8FNaURdDGO5YCi7fGY4iofXoXyXukHafw5TdXrtig53qB4TCyUAvn2rROKD34EF2FY9JV4pf3S8fI24glqPGOfwcWJh5NXtYhw+FRLG6f7RNGaLHhpn0Hl/hDkGF54mq6cmh/oYFNwLvtKI+1GR8DaO8wXniKv5i2ZsXLHyY544EihhjqCCIJxW7HFlX6TVbrV8Q53NLEvvL18iJQrYnm49VMF563KYc8nJo5XrHJTbdM3CeNfCWfct04bBIqzI5fgKCjMyUHIoDCnyHz0+zQlNsvO4FDTvK1cvi4tQ6sFRjsiEoa8AhcgaUqmyGiFSua2xWkqaysjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETJ9VvqA/GqOWT8XOgx7kobRvSAN3E1BhdOw1DqRvr8=;
 b=SxoIQfffBzp1N20dIAQZxO7OH10RFFVLPlmCz+TO7sRQkYFh4O/86nzsxmUtt/zuWYerBXA30no/OjyQ5XfjVdPYw179ZVsXCMj5pfUk3sNdL/sPrwtGMjlNPejvMY5KD2Mo27dMkzw7I1YKCZSxN2H8Ug6nDnxu4mNmNQBZc3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 21:55:14 +0000
Received: from MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::5aa3:9748:d8d0:87e1]) by MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::5aa3:9748:d8d0:87e1%5]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 21:55:13 +0000
Date: Wed, 22 Nov 2023 13:55:06 -0800
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Kochkov <anton.kochkov@proton.me>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowang@redhat.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Vikram Garhwal <fnu.vikram@xilinx.com>, Qiang Liu <cyruscyliu@gmail.com>
Subject: Re: [PATCH-for-8.2 v2 1/2] hw/net/can/xlnx-zynqmp: Avoid underflow
 while popping TX FIFOs
Message-ID: <ZV54uiGoYVd2Y-5H@amd.com>
References: <20231119225102.49227-1-philmd@linaro.org>
 <20231119225102.49227-2-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231119225102.49227-2-philmd@linaro.org>
X-ClientProxiedBy: BYAPR21CA0006.namprd21.prod.outlook.com
 (2603:10b6:a03:114::16) To MW3PR12MB4409.namprd12.prod.outlook.com
 (2603:10b6:303:2d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4409:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: 05236b69-02df-4ec3-eaff-08dbeba5b496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQ8bDHhQB0K9eTRxT0FMcsCVl/FwXyM2Z9b1lN53nHUHAhQCA/EQYii2ETJ6YcTK75xWoZRlvPWs/umEepx0NluR3/redM3PhK/Nnf3X0G1ppJvs8Ifi8WK7+5DXEuxP9tLQFDclVm2u9Q00VbrZJ7giWi1ygtLvq8L/Ef62+bNtUEx5itUlLJaQ19LsfK9UHP1rqriW2N5zl0ptkk8aq1WqJ2nNkajItrWM8AAC0bEy1zIPuYKCOAl2CUFW1TQ1fDL/1tGKowuH/losOH5MxKh8y4WDs+FnTBCRR4IMmuJkuR4BPqzMg/HEB3PYJ0pMVkI3o2aY2jldRzNMNqgMsr0YS2fV+gAUA2pKaIaM4JtOYhqggoIKUV22VpjNM4fmETdDpb++MSQS7izKQNJOv0HtWSXRvzXMsdczlxxNqHPMcvL3r5a0Zva1pId6WLpr9urLzoCl4dL+hox5DHbFRVmoqEXOPVOP696Zytj5wTtwX2etFxPhS+KHi3IRRwD06UvVTQhNBctEfq1Zk9u0kpuQimP+tx9NoG2vYQ0RPX4juHsLbnkS+EQdVO1ekPbc13e0WJ6vf+MOqi5eCyoQ2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4409.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(39860400002)(376002)(346002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(6506007)(6666004)(83380400001)(2616005)(6512007)(44832011)(8936002)(5660300002)(8676002)(4326008)(41300700001)(6486002)(966005)(2906002)(478600001)(316002)(6916009)(54906003)(66476007)(66946007)(66556008)(86362001)(36756003)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEhUVVdFbEhJeEtZS1c0NnZydnNYTVRQdjJrU0lsZEhaaTZMcGtCTTU0Z1Vo?=
 =?utf-8?B?REpkNlQ1d001eTFKbXNTZDdzNUxsajRyNk56ZDY3VU8rYVZtQzVGL0w2SjJh?=
 =?utf-8?B?dU92NjJpZTlpQnVuY2dXSEZmcEU0ck9wUmErUlRLUTZQdkFCN3F4ZURtaG9J?=
 =?utf-8?B?WG42R3hmemNrc3UrcHZqSjcxT3NPWmNUbnQ2SlBMZHByd3Fmbkd2bG5pSlJn?=
 =?utf-8?B?YWIwT01VNktORWxCL3YrZno5RVhEZytGai9wR25oSHhrU3p0WndlNUcyOUpt?=
 =?utf-8?B?alQwSmhKMjhUemdEajAybUgrV3VlL2lEVlFOUUJUcENaVkZnZVRkV0NTaExI?=
 =?utf-8?B?WGZlNFVOZEpkbWlwSHlvRERxeW9rbUE4dUV1S0tCbVkxbWpZSzhYVDAvVXMv?=
 =?utf-8?B?RGdVZ2dOTkZqVU1BQTd5Y042enMxTE5yWVNkc0J5T2cwa3lDRFdBRElPTjhy?=
 =?utf-8?B?YmJOVHp0Zlo2Y25OSStOaHlTMXQ4WUF0Tk5md05yekFmQnlDM2ZINmJOTU5Y?=
 =?utf-8?B?TzRkaHRBK21sL3pBU0wrekNTOThQb0VaczBqbS9ST3dxTk1KSEgybDhRT1Q4?=
 =?utf-8?B?YngyTlJjQ0FxWXNYK0VOQTZxMkJrdGk3dzlpeW9pQldBa0ZXVDYwRE5qK2t5?=
 =?utf-8?B?U2h5aTkxdVAvNmd6NWx2dmU1VDdwYkp5VlBlS3NJSmNUY3I1WlRFenVPUjRV?=
 =?utf-8?B?SWVWV1pHZCswSUc5OEh5ak1kWS8yL0VBV08xSms0WWdIQVdpcEFZZkxjcGQw?=
 =?utf-8?B?aDZvU1ZoZXF1MkRmcEwxSXd5OVVkaWpPSXV1UDFpWFRXRS9KYi9HWDRVSlZq?=
 =?utf-8?B?aW9Jak5MWmV4Z1hOZUNoNEhOVmRUY2ZRMnRveEs1eXA2dnplcDVJV3kvS0xw?=
 =?utf-8?B?L3FXbmFpa3EvN0poSFc3Z1JXMUhBLzVHb3RCRGhqVmhlMGkxVVR5Y3U5a3VC?=
 =?utf-8?B?WHJhZlAyeG1zSW9VVzdtZ25nWHhJTjUxd2pNaGRUbEFuUlFWekgvRE9hNVpD?=
 =?utf-8?B?NW0zME4rV20xVGFOZnVFcGc1ZDBxREFjb2ZCRC9TQ0Vrc2xxcFA2bFBoc2Ry?=
 =?utf-8?B?SC80eUFaTGJhMjdveUJxQUJPQ0twbkQwQjBTMUZUS0g1Tit0RlRxYW5pVVBu?=
 =?utf-8?B?eTVFcTZUQmFPNFZWTSs0Rm1IaDZINmFaelRuaXBtU1YrZDFhK1JRU0NiTWN3?=
 =?utf-8?B?R0hmbmF4VFZOSEY2a0NwZWNSN2VnZURtVVlBaHhRcTVuSFpnQ05lajRUWFpM?=
 =?utf-8?B?L2owTEtUWUxkYnlmSXhSZi9nSkdSNmk5MEZ5U3NpK1VHUHJDbTY2M2NLMWJG?=
 =?utf-8?B?K2p4TlY4YThoMGJtWmJLeW9NR3hUbW0xOGUzZ05nRXpldnQrcmFVOGJDelBZ?=
 =?utf-8?B?S1p3eGZqd05qV3oxMEtCUmJQbnIxWnVSZldPZjBZZDNyZklYWFY3eVdRWldI?=
 =?utf-8?B?cFllSHBRR2w0ZEFzNEtxdlRreVh1YU44WFU5Y3ZBUkhNMEFXSmowd09HemdS?=
 =?utf-8?B?YlJQR1B4RGhWYXdMNHJzYjZTbW83VFIxQjcwdzlOb2tUZ0J6V3ZHYUJ3N0k5?=
 =?utf-8?B?YW80akgrZ2FwMjZmTm1SVklZZWJQM2VvWGRpUjIvVys5UUErai83QzFFVTlt?=
 =?utf-8?B?MVVVNzl0UXhoWjFzV2hmSUZKNTExcnBndUNqako4M01kTWFUUDZ1YmdGUzgx?=
 =?utf-8?B?VTRSWUphTHk3dW5VajE2UjFwZkZZVDNtRE5PWW80QWFPYWdyNE16OHN3U1U4?=
 =?utf-8?B?dVRYSklOTXJhckJGSkNGM0RaSjhyMWg2ellaTG5DSUZ6RVNicnh4amxjL3A4?=
 =?utf-8?B?cXVoUGVwYXA1eE01K0ZpSzkrVURiMTJOQW8wNDQ2dEREY25FSW9DSERIS0ZX?=
 =?utf-8?B?ZVZFamxmMkQzOEY0MUU5RGZhK3I2NGxwTmFGbHpVeE9INVV3MmFHY1VNUlk2?=
 =?utf-8?B?SmF6bEVCb0F4Y2liVWJRSHdhS3o3bWREYWVFTHg0TmlZZDdTWWFIeWpKMmtI?=
 =?utf-8?B?MWJBYWhvTGhYYWJLMzZENWdmVThRay9jaTlScWhsS2I0bi9SeHBsUk1RVzUz?=
 =?utf-8?B?bHZyNS9BeVR6Rm9iZVBubVA1Vmp5YmZFS0d0VWNjQ1Q3eVhKYnNTMDFITXZ6?=
 =?utf-8?Q?3BWjIlavAK+209niZhxih5BgK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05236b69-02df-4ec3-eaff-08dbeba5b496
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4409.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 21:55:13.6224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vM45xlk9tF6CXbIN/MtnQxWc1OVDxfm8A8aUUM+ZsPj6P7TTEM4RezSHvTpgF83XIUI6cvS8hg26FTPDlCZOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765
Received-SPF: softfail client-ip=2a01:111:f400:7e8d::601;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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

Hi,
On Sun, Nov 19, 2023 at 11:51:01PM +0100, Philippe Mathieu-Daudé wrote:
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
> hardware does when not all four words are written. To fix the
> reported underflow behavior when DATA2 register is written,
> I choose to fill the data with the previous content of the
> ID / DLC / DATA1 registers, which is how I expect hardware
> would do.
> 
> Note there is no hardware flag raised under such condition.
> 
> Reported-by: Qiang Liu <cyruscyliu@gmail.com>
> Fixes: 98e5d7a2b7 ("hw/net/can: Introduce Xilinx ZynqMP CAN controller")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1425
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Francisco Iglesias <francisco.iglesias@amd.com>
> ---
>  hw/net/can/xlnx-zynqmp-can.c | 49 +++++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
> index e93e6c5e19..58938b574e 100644
> --- a/hw/net/can/xlnx-zynqmp-can.c
> +++ b/hw/net/can/xlnx-zynqmp-can.c
> @@ -434,6 +434,51 @@ static bool tx_ready_check(XlnxZynqMPCANState *s)
>      return true;
>  }
>  
> +static void read_tx_frame(XlnxZynqMPCANState *s, Fifo32 *fifo, uint32_t *data)
> +{
> +    unsigned used = fifo32_num_used(fifo);
> +    bool is_txhpb = fifo == &s->txhpb_fifo;
> +
> +    assert(used > 0);
> +    used %= CAN_FRAME_SIZE;
> +
> +    /*
> +     * Frame Message Format
> +     *
> +     * Each frame includes four words (16 bytes). Software must read and write
> +     * all four words regardless of the actual number of data bytes and valid
> +     * fields in the message.
> +     * If software misbehave (not writting all four words), we use the previous
%s/writting/writing
> +     * registers content to initialize each missing word.
> +     */
> +    if (used > 0) {
> +        /* ID, DLC, DATA1 missing */
Code is correct but i feel This comment is confusing. ID is missing for sure
if user > 0 but same is not the case for DLC and DATA1.

> +        data[0] = s->regs[is_txhpb ? R_TXHPB_ID : R_TXFIFO_ID];
> +    } else {
> +        data[0] = fifo32_pop(fifo);
> +    }
> +    if (used == 1 || used == 2) {
> +        /* DLC, DATA1 missing */
Same here DLC is missing for sure but DATA1 is not for used == 2.
> +        data[1] = s->regs[is_txhpb ? R_TXHPB_DLC : R_TXFIFO_DLC];
> +    } else {
> +        data[1] = fifo32_pop(fifo);
> +    }
> +    if (used == 1) {
> +        /* DATA1 missing */
May be we remove all these individual comments and write a common comment before
the first check(if(used > 0)). Something like this:
/*
 * If used is 1 then ID, DLC and DATA1 are missing.
 *
 * if used is 2 then ID and DLC are missing.
 *
 * if used is 3 then only ID is missing.
 */

Code looks correct to me. So, With above minor changes in code comments:

Reviewed-by: Vikram Garhwal <vikram.garhwal@amd.com>

> +        data[2] = s->regs[is_txhpb ? R_TXHPB_DATA1 : R_TXFIFO_DATA1];
> +    } else {
> +        data[2] = fifo32_pop(fifo);
> +    }
> +    /* DATA2 triggered the transfer thus is always available */
> +    data[3] = fifo32_pop(fifo);
> +
> +    if (used) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Incomplete CAN frame (only %u/%u slots used)\n",
> +                      TYPE_XLNX_ZYNQMP_CAN, used, CAN_FRAME_SIZE);
> +    }
> +}
> +
>  static void transfer_fifo(XlnxZynqMPCANState *s, Fifo32 *fifo)
>  {
>      qemu_can_frame frame;
> @@ -451,9 +496,7 @@ static void transfer_fifo(XlnxZynqMPCANState *s, Fifo32 *fifo)
>      }
>  
>      while (!fifo32_is_empty(fifo)) {
> -        for (i = 0; i < CAN_FRAME_SIZE; i++) {
> -            data[i] = fifo32_pop(fifo);
> -        }
> +        read_tx_frame(s, fifo, data);
>  
>          if (ARRAY_FIELD_EX32(s->regs, STATUS_REGISTER, LBACK)) {
>              /*
> -- 
> 2.41.0
> 

