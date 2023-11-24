Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFDC7F7966
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 17:39:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6ZBb-0001km-TG; Fri, 24 Nov 2023 11:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1r6ZBY-0001kW-8y; Fri, 24 Nov 2023 11:37:44 -0500
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1r6ZBT-0007EG-GK; Fri, 24 Nov 2023 11:37:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBCGo9YWpijFihPfZcpjHoL4t2HfcqwA84+HfuK29SDVyf5LMgIhESUHgK1KbLurhmgzzBbVW/bUjbfG3Hr2TlWbjVao5cbqViAdUBobm1QmChsrLoQMBOXOh5FeZyxN0b9kidg+6HmcH396779s9ZLV4UxsDB7ymqtCHA7fAhl9aZEIeQxIDBwRCxuvHhRm9AxVelE8HQNedVXqBehQDjV2Z5FYfkHwhvPT29iHB61Vc4frEzGCRqCsa4PAY6MRQHbEOqTJYj0AjSD87z2u/eEBVHViOaYyiEx9AvcQk5Byo5gQzUqmHe9wTT752EkmxZ4d1chA14y4Sh5rXxKv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gybCqxcMj1w0CGV0TiomsyFaNTZPfx0JGBDrTdIIyk=;
 b=MNwkHW2KZmLBhNlFUa+P8c30LlQNqtAYrovF4SHO3arHNW5dTUTb8K+kRNMwWMgaN7worA07c4mzZDdszNMIPt0U/KoRMSzeIHiRi/omUbeMk8JTR7m5tTEU0xIJkwKe1OYl89ddepnD4ixH/22zXqy/D0pSoDD7c4M7o2sVM4MhfVIw1gbf4WMgkM0T/dS5ddI8ePRDyCFtLYQkS1GCrwuqznbw4krmXSaBYxqqvQSe3hiqjxGgE1DQr6ffWJe3WprSx/B5ryPNG0lsI8zY59/inARmUV++9EzvcQPHUs+XuvMRKPaGxA2L/HSBbIt3TqC/nu2ruRuFRoH+mA8/IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gybCqxcMj1w0CGV0TiomsyFaNTZPfx0JGBDrTdIIyk=;
 b=M7AAtZk0DyPuRxg+NepjYOebuhzBiFbZvYSczRw571MCESl8O9Qs05VE7ZRiEKzt491vmgcKOlFFica3S9dcfUM5hUFKHdC+4Z99QL2S8CgdneAtb3R0I0BC3haUXxzvC5Qoq6SqcmJoStWcG25Iq4yiD42/cglJIXBnZ+puJcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by SJ0PR12MB8091.namprd12.prod.outlook.com (2603:10b6:a03:4d5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 16:37:33 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::5f66:ae33:b947:c68b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::5f66:ae33:b947:c68b%7]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 16:37:33 +0000
Message-ID: <3adbe20a-f871-48a8-8d4c-b9f0965b459f@amd.com>
Date: Fri, 24 Nov 2023 17:37:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] hw/dma/xlnx_csu_dma: don't throw guest errors when
 stopping the SRC DMA
Content-Language: en-US
To: Frederic Konrad <fkonrad@amd.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me, luc.michel@amd.com
References: <20231124143505.1493184-1-fkonrad@amd.com>
 <20231124143505.1493184-4-fkonrad@amd.com>
From: Francisco Iglesias <francisco.iglesias@amd.com>
In-Reply-To: <20231124143505.1493184-4-fkonrad@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0408.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39b::23) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|SJ0PR12MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7317db-2691-469e-1539-08dbed0ba84b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9zf8/rgtHhwULww1/mqAyaQpy92On9LmjByD8C58FgZpYcBPyjFTdykwmwluspu3VnIoAOUYg36AUxL2HYiZ6X9nAo2rnT4gnj3LaNsmR1RgUpSl5GFiMPmgiiPVl1rgrdOcI+sA4uVqE8yMB90B8YQgPUarNedVRokv8TU0hca2l1kX306/mo4/nzdvfUZ1gDsajihFkyjV8rTsq+k4tlHY0Pc5/28thrMVFgjwXyl//35xkhqSeYOmMRe7TRS3XVe6KlCCs5bJ42iN7yC0I8WvPuUvgQkkmwsUqCSkKDC34vDpWm1TRknZ23HqcpMebg3w5gz+CsaOJpWFaWXeU+/rCxlJc6fCJn1O7URgUhPDpfxn0NqAlijrEWE4FTCgU5X8TCxVwQBfEArsaOvz+K0/wC+lW3Dhf9LeNAPPcZLlnFS8soQA0gzP99Y+UB60gPeRy5umY3bXpfw0XHBIcwirFN5fyOGknYZdrBRqt/FvUKDu6vRdFz7P3tf5Dtv3px8yQUThL6SBiLQ8GFC4pG3FyZVaKCYmW+SHLhCL13lkifGb/idQksr71qM4iy79o4UqfFjw7t87JhOQ8vF+RAxWy3wbmdbMmfShJL+6j7pwh5f4nfFkMwQDuVI66owARnxhj+1uSLhPHM3r9Mxvsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(366004)(136003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2906002)(31686004)(4001150100001)(44832011)(4326008)(41300700001)(8676002)(8936002)(5660300002)(66556008)(316002)(66476007)(966005)(6486002)(6666004)(2616005)(478600001)(6506007)(36756003)(66946007)(6512007)(83380400001)(53546011)(26005)(86362001)(38100700002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2JJalNpeURNSG44cit5NTVkTkw0cm9aYll1c3loTTl2TE9yN1EwWkpRQjFE?=
 =?utf-8?B?RExzTmZjNHVRN01SYklEVU9oV3JKM0lRd0hHNlo2N3ZTajIyTjdGdjhpb3dW?=
 =?utf-8?B?RndZcjRRVXF6MC9RSGhIbkFOeHhYeVlmUkRhS0RXYmlvb1ZrdzdnakF4b2w3?=
 =?utf-8?B?anBOSzRjbk5PQ1hqdHdyZVRaeTRGeDFJTDJ6STlRck5aNU5aMzBrK210c2I3?=
 =?utf-8?B?bklaRWNyT3ppMk05dmJyMlE4U25nRmQwc0JTRk1raFFxV01rS2dXMzNMWUdE?=
 =?utf-8?B?ZXlVYk80MXpjNkVaSXFMZ1NiQi94Rm51Z1IxOU01REN3YmU0YncxUEI1aXN1?=
 =?utf-8?B?cGpDY21aVjJ0SzBmeVJ2TjdUYkJBUndhZktLMGdZM21RS01CWUFrVThQcjVE?=
 =?utf-8?B?dEdKQ2thaW5MV3YzQmZCQlo4bkZmOEg0WkhDV0ZBTVZwZ2dtVnczcXN0Smkv?=
 =?utf-8?B?ZzRBQ0Q1dERzYUFoUm5xcklCR1lldVBFQ3RYTzhNNmtXajB5cVRvRk1mbFM5?=
 =?utf-8?B?R0tvRllFMnNKZFpmaHB4bkt6TzJiSzZMb1JEUDZvQ0NDelBkS0NBaWNPdUxQ?=
 =?utf-8?B?dUJEckttV0hTTTU4eG4vN2h6b25Da1o5UEhnT25ZZnR3WldoL3VaOU4vYlNh?=
 =?utf-8?B?NEkyeG4zblFWS1BtTGxVc25oQng2OWMyUnB6MnE3QWJpTFZoZVNLMHlvdmtX?=
 =?utf-8?B?TXIvbXdIMHlmWEhOMk9vVld4dDdFbzlVZzdCSUVEZ055T0xIcjVpQWw2dUM1?=
 =?utf-8?B?bkdsZGtvWDVhNlFHMzY4eUFxZkRON1RSVHlkZFJFQ0pYdWNLd0g4eUh0UTlk?=
 =?utf-8?B?Wmdzb1pHa1VvUVhUZTlSQnA5OXQzL1lWckNVdDdoa3NRSlpPWFZqanhGRTNP?=
 =?utf-8?B?UjJTbEtmem4rZEJyVitVK0pXYXpORjVNTjM2ZC9NaDI2dmFwa0xWRU9FMysw?=
 =?utf-8?B?WWRoZ01yWjloUldVbndOQXRRVDZsVmhBdEgwRnpVcWE1VU9hUXZleHhROGpW?=
 =?utf-8?B?bEpvSk1oYUM1alZ3S2tZbjhQdldGQWQvMnljanQxRGdiQUptMkt3K1M2ZE1D?=
 =?utf-8?B?cndJU2F2TjJnT0dRUjdwUFkzVm9ZTmlDZHFIbzBjQk9Gak1OenNMbk1STzJl?=
 =?utf-8?B?OWVWNjdvYXIvNWF0K2NsWDJGZ051VndIL20vM3FoNW9DbExBcEUwTGFNdmNy?=
 =?utf-8?B?TnRnb0FiSVNEQXpCR3AxWlNkS2RLUWE3MmRxMmVmVWR3c1JWWmZpbnV4bVRh?=
 =?utf-8?B?OGNweWdEZjV6cWxYdzI3MFdDQWhYU1VjcEdLVkMzMzdNSFFPM2JJMGZTT3l6?=
 =?utf-8?B?VlJtVXhuTGlVNlBXVGppZTNWRWRlNGExUEd5UFVld1pUS2RFYWFwRFlYa0lO?=
 =?utf-8?B?Q1FSaXM5ejk5YjQ3ajlzb2h6dDk5Y0JTblBWU0tPSDRra1pGS21rSDVUdGpw?=
 =?utf-8?B?a2loRXdmZGdncDFETGswbnRhenU4YTh6VklNT2VSODFXWkJ4c1BCM2FJTXls?=
 =?utf-8?B?MHdtNHBZU1F2bEJybUlMY1NlbW5jSDI1UUdVZUFOblphZnpCMFVLVWZXRW1O?=
 =?utf-8?B?TFh3MEh0UERlUU0wazl3SGlqbnhzaVVqQTM2ZnBDNDlMeFZqeXNOQ2VaR0pK?=
 =?utf-8?B?VmowNDl6dEgyMjE1VlhvKzFCUjgyVzVxbk9IeENKVkJiQWZtOFlRTHFvbWVq?=
 =?utf-8?B?S2VyUmt2Sm4rOTJFcTNGaG9Vc3VPZm96ampxYW1ONEZaRUN1SW9SQWhjWW5s?=
 =?utf-8?B?a1B0cVcweFlBTmhuT1cwdTZXVmFJZ1BETEQyVXBDYk5Kb3NtTjFIVkpyaDBF?=
 =?utf-8?B?WXd2c05aVnZXRUFuNXBFWEJ1bDVrdkVUVk5oTUNFYkZGMFFoNmxsQzZqV3p4?=
 =?utf-8?B?VzhGT1NZWWZ5UDczRFhoSWppYzBCbHBxRm9UeWYwaHlVc1dMaUJHcTB1NnF4?=
 =?utf-8?B?N2V2cWxwQ3I4bWpiYWVvTVZwTmtQTXJySEJFcmJUbE9EZzI3QndtWjEzN0tU?=
 =?utf-8?B?VDZQL2hDbGhEdlZSS3h0YUVQeEZ0U3ErNk5nYkVFZWZxTmRYR01VbTNnZUNC?=
 =?utf-8?B?SW1hSHc1ang3L3RQa1I1bDlGazZZM2lkUnllblFhM2h5Y3hlL3V3bk5VbUZy?=
 =?utf-8?Q?ux/1HOXlddavMnEB9zDgXe64V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7317db-2691-469e-1539-08dbed0ba84b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 16:37:32.9586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywVrgD3va0vGuFfO0xNz3k39JFRaJNETUnh0Yyh4jkXJ8o+7IC7XePX/XEsFDrCKRwEgnMBlFr3oLk7Hc4+Qhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8091
Received-SPF: softfail client-ip=2a01:111:f400:7eae::600;
 envelope-from=francisco.iglesias@amd.com;
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



On 2023-11-24 15:35, Frederic Konrad wrote:
> UG1087 states for the source channel that: if SIZE is programmed to 0, and the
> DMA is started, the interrupts DONE and MEM_DONE will be asserted.
> 
> This implies that it is allowed for the guest to stop the source DMA by writing
> a size of 0 to the SIZE register, so remove the LOG_GUEST_ERROR in that case.
> 
> While at it remove the comment marking the SIZE register as write-only.
> 
> See: https://docs.xilinx.com/r/en-US/ug1087-zynq-ultrascale-registers/CSUDMA_SRC_SIZE-CSUDMA-Register
> 
> Signed-off-by: Frederic Konrad <fkonrad@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>   hw/dma/xlnx_csu_dma.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
> index 531013f35a..bc1505aade 100644
> --- a/hw/dma/xlnx_csu_dma.c
> +++ b/hw/dma/xlnx_csu_dma.c
> @@ -39,7 +39,7 @@
>   REG32(ADDR, 0x0)
>       FIELD(ADDR, ADDR, 2, 30) /* wo */
>   REG32(SIZE, 0x4)
> -    FIELD(SIZE, SIZE, 2, 27) /* wo */
> +    FIELD(SIZE, SIZE, 2, 27)
>       FIELD(SIZE, LAST_WORD, 0, 1) /* rw, only exists in SRC */
>   REG32(STATUS, 0x8)
>       FIELD(STATUS, DONE_CNT, 13, 3) /* wtc */
> @@ -335,10 +335,14 @@ static uint64_t addr_pre_write(RegisterInfo *reg, uint64_t val)
>   static uint64_t size_pre_write(RegisterInfo *reg, uint64_t val)
>   {
>       XlnxCSUDMA *s = XLNX_CSU_DMA(reg->opaque);
> +    uint64_t size = val & R_SIZE_SIZE_MASK;
>   
>       if (s->regs[R_SIZE] != 0) {
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: Starting DMA while already running.\n", __func__);
> +        if (size || s->is_dst) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Starting DMA while already running.\n",
> +                          __func__);
> +        }
>       }
>   
>       if (!s->is_dst) {
> @@ -346,7 +350,7 @@ static uint64_t size_pre_write(RegisterInfo *reg, uint64_t val)
>       }
>   
>       /* Size is word aligned */
> -    return val & R_SIZE_SIZE_MASK;
> +    return size;
>   }
>   
>   static uint64_t size_post_read(RegisterInfo *reg, uint64_t val)

