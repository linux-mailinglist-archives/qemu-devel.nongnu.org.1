Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C97378EFEE
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 17:06:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbjEh-0000c1-9E; Thu, 31 Aug 2023 11:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbjEM-0000ae-Sf
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 11:05:11 -0400
Received: from mail-dm6nam11on2089.outbound.protection.outlook.com
 ([40.107.223.89] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qbjEG-0004FL-A8
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 11:05:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TndKPJES2B4NM5D8jBLZprGm2V11gVFjWT+3uU/JE9aBkOHuL4zV6K21cMUA+yzagaJonnGrQ4kz7JpOW3P1V2jilwaI+YqjDpOqRRbp5cPc6MD3gvFOe0K09GZSQFhZsN/c66bfWpiC9+d+qAZb+rtsVSRmCJ4oFSsQCxri4Swhx1RL+a0afgKfKOxwyin0qWofwA9fjuxvglWJs9u7/63mOzDjkTK9+/r7aJOewyG0JV/HyAyuqQPSXzvc7zrsBfmrB9KkHLntHRv2D/592OZGEoR2mZto4PW5vC9prq9BLkotJfatcy/P8lHObFfC9dpS3xn6MY/791R/BXPFXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTV4HvNnfOnbETCYiVOb1BPJ/JbZKeZsbs+2Qdn5i/Y=;
 b=D3d1l9OiwKxNbeHepT31t1C1wLBfO1O3aMVZJkezcIkdEOOV4YpOMr5tNN9Q33V16Sif/nUPTlIjCRYD7poOcnIpX0mGVG9c6UeToaDbJgrZo4yq4PXwCTKW6B4B6Spn+0x/lKZtF0AQVIFcIFnBDFk74BhZevOUX/0/uZpVn6m4SBLIjsb6npI04wH75qHUweisnYdjGOULEvdTMJaJa+D9MCFTRmtUwGygFQbqSBplW9z/zEKm3l3PaZmzdsfUR3o6a1p+Ws7/oyWjgknpmfcg1WrCGxVkFmc6LoBxVhf3el3mPlG3PzRfY7DFMtQDoqREKU/Km/fdIZax53uDSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTV4HvNnfOnbETCYiVOb1BPJ/JbZKeZsbs+2Qdn5i/Y=;
 b=PqHQImeecurGdvjhat3BW5/gUcDMXa7WpL+KtBOH42XF+4t+aTYuoJj6O39NwCS1iptpPIr6AIXqazJL460AxNLVUAf1rFiO2uShY1lX3+nqOXgnI6tCkH/Wa2BadJbAmxLnQrhsCOprutctBC/DnOehjv2cUzCmNMD49rgAW+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by SA0PR12MB7092.namprd12.prod.outlook.com (2603:10b6:806:2d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Thu, 31 Aug
 2023 14:59:57 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::b076:fed:d7bc:d89e]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::b076:fed:d7bc:d89e%6]) with mapi id 15.20.6699.027; Thu, 31 Aug 2023
 14:59:57 +0000
Message-ID: <49408ea1-c837-76b8-7a43-de6ac5c682e9@amd.com>
Date: Thu, 31 Aug 2023 16:59:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 5/8] hw/misc: Introduce a model of Xilinx Versal's
 CFRAME_REG
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, fkonrad@amd.com, sai.pavan.boddu@amd.com,
 tong.ho@amd.com, vikram.garhwal@amd.com
References: <20230824183448.151738-1-francisco.iglesias@amd.com>
 <20230824183448.151738-6-francisco.iglesias@amd.com>
 <CAFEAcA_Es_sX4O-oqX9E49LTWUMDzv6sao2i3Fb-YCqg9M8WXA@mail.gmail.com>
Content-Language: en-US
From: Francisco Iglesias <francisco.iglesias@amd.com>
In-Reply-To: <CAFEAcA_Es_sX4O-oqX9E49LTWUMDzv6sao2i3Fb-YCqg9M8WXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0072.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::21) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|SA0PR12MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d04b179-0b31-4976-2708-08dbaa32f0ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1RWioudBQsmwC42XcD113g93gHcqE4PQ90+GadvMNHG9czIA5iXrZSDn/ykAmKHQ3fdh6VbQ7ljrEouw7LThGa+CJxjC+/wr9KqE27lH1Frs6MIaY30wPZ9S/QLaDATnDoIVkDxKCyvTrm2GMEzpeNGXZw8F+CilnE8zXqECvXlXXkd1oZeFlzf1HczC5zn4JHKRXytLl/9EnK0zy92MGu3pg5n5TX1fpfrKpKgRLnYk2LK7yPBr9BsA4CT+9Ntp9+r/f4qNM5ZJzLtUt9tQYnXTm9ovvHmsCRwqkROpOKH8Y01bPQR4KqIX74kZyIlGOpMVkT0KHJAzjdMvkjNpgLo681j7a3203VeO3ls3ILVReUFOQHMX96t9oORtw6uZ1qM+6HOUREg8dYTY4LmCTzmy3z9q6e8rnPH+qOpUuTWgqDMzyJr8NfvItu2kHxbU4RyPVJso7uFKUjDeoRRj2np+o/zclgHDP/IdfweIQWjMCo5asomMHUa1f7vh04A59G9sN17om6A6KuMnFQ2dBEsJFjXdgoHIAehIAVdudvRlvuBYW2AzotQpFRmFw+K9lRpYF/gh8oqv44k0uqnr50fWK7HCq9BrUxNuvcs5yic6qzaMsqkOAOQa8Rwy6czQUe1Jm00IeGrKtE270m5Lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199024)(1800799009)(186009)(6512007)(38100700002)(41300700001)(316002)(4326008)(2616005)(2906002)(31696002)(86362001)(44832011)(5660300002)(83380400001)(36756003)(26005)(6916009)(8676002)(8936002)(6666004)(66476007)(6486002)(66556008)(66946007)(6506007)(53546011)(478600001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2dqN3ZJS242bXVMaWFEbzJub2ZLSTRKb05rWlFuaEJ5N3VITXZrSkRxV1Fq?=
 =?utf-8?B?YjdlMmdFWkRGcmh1ZnVBUFZHeElMMk1WZWRGbFVLSDJKT2p1TXh6QnRER2dX?=
 =?utf-8?B?Um5vcStibktVaWRxOXUxb2ppNG9ha1ViWHJlb0ljQ0VWYVc1MVpzVXlWOEx1?=
 =?utf-8?B?TWhVYkd2MGNmckVYbWUzRDUrMTRpbHJRK0t0MjlNalhSQ3Izb2lXbVpHZmNx?=
 =?utf-8?B?UzFxSmZuM3pHTXM0enR5VDRrVHVCamh4YThwSXdxdGFHblljSUxrWEZVbFFs?=
 =?utf-8?B?YXFCSTZ4eDNnTGFKZ0xURTRqR2dmTGFjSksvd0krT3JHS1VsOGFHWDBHSGU4?=
 =?utf-8?B?WDI4VGFqaE9yWElwTU9kL0p1T21nbFl1UlEvVmtXeTZJcDlTOFpvK3BiRkVh?=
 =?utf-8?B?eDZnelpERmR1Z2UxbTYxT2JETkxVOFlScmJmRklNendTMmZaeG1xT1JxK09m?=
 =?utf-8?B?S2w0dlNkalRRN3l0WFFRRmcyV2FUZXBuQ2c2Q21LWnFWUkY2ZytDdi9tN1hw?=
 =?utf-8?B?OWR3d1B3emZGMmJaei93TFdoRFk1a1RhK2pjbkxOL0QvNGhKQTFLaHZzbnFK?=
 =?utf-8?B?QjVvK0dVYW5YMC9HMVdreEZzR3piNm1wZ0tsWmpqNTRyVlZOcEVkYzFLaCtP?=
 =?utf-8?B?MngvaHVFVWZBcVNWZ0JQajUxM0FuWDUrUnNTa0NLeTRqaEV2RFowT0cvMTFN?=
 =?utf-8?B?ZFpJOWxaVUdHZlFBejJiWG56c2JSL01tamh4TnAwbWhneHZRd2JtdDFjMm9r?=
 =?utf-8?B?VXFweDNiNDdKMXJwMlRzWThkWFhzazVYeitxd3NrYk94b2x2Sm5tTWVLNmFy?=
 =?utf-8?B?Ry9rVlFyamRpamtFU1pqRmRzL1h3RE4zSVJyckkwMGRTcjBaT3V1dUdmcTZq?=
 =?utf-8?B?UXlEbVhHTWtpUWZleGhENUxRc3YxaDlQcDVnRlFSaEVneUdzempNa2FmRE1C?=
 =?utf-8?B?T0VNaElEeFpYdVorRVdVTW8wcjlMY3ZCNW9PL2dEcEhtd3l1WVBxdndQWkVJ?=
 =?utf-8?B?eWJ3aGVJOFRSTU5yT3laN2I3VFJHczUyQXlNVVBLb1lFL04wS29QRVZxMDBE?=
 =?utf-8?B?SVFZSTdJUzlSZUN0V3lmTUlCd2pqSlJvcldsRys3L0RHcVg3alRIREpaNkt3?=
 =?utf-8?B?aE4zZTB0MWZqWWkzRi94SEMzMEMwUDI1dG5NWDhNckVQUXZDTmhEMW1FSmkr?=
 =?utf-8?B?YlJTaVQrak9kK2txcjVSWWJzdURBUzNQb0RHeUJwZDl5MUF3ZUtYRjVkVHBl?=
 =?utf-8?B?QTlGRFhIVUR2eUR4Q1I5Y1BlNXJzRUM1UzJFaXU5b2dOd2t5bmVZWk9wRFkv?=
 =?utf-8?B?bUY3K0R5ektiWFk2VUdBNm5yZXVRQ2xwcE1WWnpuTTloSHlLdWM2a0phWmY5?=
 =?utf-8?B?NU1vWEhHVjQyWFkvbjNiM3ZHR096Q2ZoRkVTMGRGaGlhdjllZXRjelVkcVBX?=
 =?utf-8?B?TWd6KzdGWFhIYzRYaE5pRGw4MFdLRnVUMktqb2pobVFCMUNVMGdaZlFJL0lq?=
 =?utf-8?B?UmhtdngzbGthZUhqNzZKb0ZUU3BMa3NlSVJwd0M2TjMwRnVGQ2prRWhlWFpK?=
 =?utf-8?B?K3JSQzltc0prZjEyZ2YxK2pKZzg2UlFHaXhPZHAzMThzWFdsNDczNEd0MURx?=
 =?utf-8?B?VDBzRmxrVEZ5Q1M2cGRHWW5tYjE5aXFXN2J2YThTdnFuWE53R01FZ3YyaGRQ?=
 =?utf-8?B?ZDgyUEh3QmVZdCtOQm5wSFBONWZzUFh4NzYwZHhaOThEa2VqWUR0NUZBOEli?=
 =?utf-8?B?QzhETlNoYTJ3WjZSeDEyZzhic1VETG1QZmtkNnIvWHU5ZEZ5R0RUT3ZzRXA4?=
 =?utf-8?B?YlZCNTFSaWpzdStzMTRUdzN1bGxvbklmckloUFYybEcxQm1pSU96Y0JHSTJy?=
 =?utf-8?B?b0VMd0VKc1VGRFFKaGU5Rnc4QXFFc21aeW9zTndtdUNZR0NzQy84ZVFBcWJZ?=
 =?utf-8?B?OE5ic0lVdElIWlpxZ09yRlZmVThsZnpXVEVHWFZSYUVwbjEvTHZSRC9QVTZj?=
 =?utf-8?B?UE5sKzJYdVMzTGpuMGg2T0V6TGJpd201MFdXdWxUTnFFSzFvRXhzdHJiWEpx?=
 =?utf-8?B?L2t0amVSVDQ0V1VZaGxPT3VkZWNzTTNma09nYzRpT2FwZXczWTNwc29iU3ZC?=
 =?utf-8?Q?1sYuexuuLWqcoGXGr82kCT4Qw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d04b179-0b31-4976-2708-08dbaa32f0ed
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 14:59:57.2017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWwZVGW7KPYQYwVgTLOyv4FLVxQ6DBIsZkpJGfcEmmJjZllIWwyfAKWmMGTV8aG4m24ZeJsevEzlfkTIktBKvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7092
Received-SPF: softfail client-ip=40.107.223.89;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.478, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Hi Peter,

On 2023-08-29 18:44, Peter Maydell wrote:
> On Thu, 24 Aug 2023 at 19:35, Francisco Iglesias
> <francisco.iglesias@amd.com> wrote:
>>
>> Introduce a model of Xilinx Versal's Configuration Frame controller
>> (CFRAME_REG).
>>
>> Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
> 
>> +static void cfrm_fdri_post_write(RegisterInfo *reg, uint64_t val)
>> +{
>> +    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
>> +
>> +    if (s->row_configured && s->rowon && s->wcfg) {
>> +
>> +        if (fifo32_num_free(&s->new_f_data) >= N_WORDS_128BIT) {
>> +            fifo32_push(&s->new_f_data, s->regs[R_FDRI0]);
>> +            fifo32_push(&s->new_f_data, s->regs[R_FDRI1]);
>> +            fifo32_push(&s->new_f_data, s->regs[R_FDRI2]);
>> +            fifo32_push(&s->new_f_data, s->regs[R_FDRI3]);
>> +        }
>> +
>> +        if (fifo32_is_full(&s->new_f_data)) {
>> +            uint32_t addr = extract32(s->regs[R_FAR0], 0, 23);
>> +            XlnxCFrame *f = g_new(XlnxCFrame, 1);
>> +
>> +            memcpy(f->data, s->new_f_data.fifo.data, sizeof(f->data));
> 
> This works, but it's going under the hood of the Fifo32 abstraction
> and makes the assumptions that (a) if you only push to the fifo
> and never pop then the data is going to be contiguous from the
> start of the fifo internal buffer and (b) that fifo32_push()
> pushes the bytes of the 32 bit value in little endian order.
> Those are both true at the moment, but fifo32 doesn't explicitly
> guarantee either of them...
> 

Undestood, to be safe I changed to pop the values from the fifo instead 
of using memcpy.

>> +
>> +            g_tree_replace(s->cframes, GUINT_TO_POINTER(addr), f);
>> +
>> +            cframe_incr_far(s);
>> +
>> +            fifo32_reset(&s->new_f_data);
>> +        }
>> +    }
>> +}
>> +
>> +static void cfrm_readout_frames(XlnxVersalCFrameReg *s, uint32_t start_addr,
>> +                                uint32_t end_addr)
>> +{
>> +    for (uint32_t addr = start_addr; addr < end_addr; addr++) {
>> +        XlnxCFrame *f = g_tree_lookup(s->cframes, GUINT_TO_POINTER(addr));
> 
> You don't need to g_tree_lookup() for every address. If
> you use g_tree_lookup_node() you get a GTreeNode* back,
> and you can then iterate through the tree from that point using
> g_tree_node_next(), something like this:
> 
>       for (node = g_tree_lookup_node(s->cframes, GUINT_TO_POINTER(addr));
>            node && GPOINTER_TO_UINT(g_tree_node_key(node)) < end_addr;
>            node = g_tree_node_next(node)) {
>           XlnxCFrame *f = g_tree_node_value(node);  // definitely not NULL
>           /* Transmit the data */
>           for (int i = 0; i < FRAME_NUM_WORDS; i += 4) {
>               ... etc ...
>           }
>       }
> 

I tried above but it looks to require glib 2.68 so added a comment 
instead (didn't compile on my machine with glib-2.64 :/, if I understand 
meson.build correctly the min glib version supported is 2.56). Let me 
know if some other solution would be preferred.

/*
  * NB: when our minimum glib version is at least 2.68 we can improve the
  * performance of the cframe traversal by using g_tree_lookup_node and
  * g_tree_node_next (instead of calling g_tree_lookup for finding each
  * cframe).
  */


I also added in the other improvements and correction below!

Thank you for the help again!

Best regards,
Francisco

> 
> 
>> +
>> +        /* Transmit the data if a frame was found */
>> +        if (f) {
>> +            for (int i = 0; i < FRAME_NUM_WORDS; i += 4) {
>> +                XlnxCfiPacket pkt = {};
>> +
>> +                pkt.data[0] = f->data[i];
>> +                pkt.data[1] = f->data[i + 1];
>> +                pkt.data[2] = f->data[i + 2];
>> +                pkt.data[3] = f->data[i + 3];
>> +
>> +                if (s->cfg.cfu_fdro) {
>> +                    xlnx_cfi_transfer_packet(s->cfg.cfu_fdro, &pkt);
>> +                }
>> +            }
>> +        }
>> +    }
>> +}
> 
> 
>> +static void cframe_reg_reset_enter(Object *obj, ResetType type)
>> +{
>> +    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(obj);
>> +    unsigned int i;
>> +
j>> +    for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
>> +        register_reset(&s->regs_info[i]);
>> +    }
>> +    memset(s->wfifo, 0, WFIFO_SZ * sizeof(uint32_t));
>> +    fifo32_reset(&s->new_f_data);
>> +
>> +    if (g_tree_height(s->cframes)) {
> 
> Calculating g_tree_height() requires walking the tree.
> Using g_tree_nnodes() is faster because that's just a field
> in the GTree struct.
> 
>> +        g_tree_destroy(s->cframes);
>> +        s->cframes = g_tree_new_full((GCompareDataFunc)int_cmp, NULL,
>> +                                      NULL, (GDestroyNotify) g_free);
> 
> Faster to do
>      /*
>       * Take a reference so when g_tree_destroy() unrefs it we keep the
>       * GTree and only destroy its contents. NB: when our minimum
>       * glib version is at least 2.70 we could use g_tree_remove_all().
>       */
>      g_tree_ref(s->cframes);
>      g_tree_destroy(s->cframes);
> 
>> +    }
>> +}
> 
>> +
>> +static void cframe_reg_init(Object *obj)
>> +{
>> +    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(obj);
>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>> +    RegisterInfoArray *reg_array;
>> +
>> +    memory_region_init(&s->iomem, obj, TYPE_XLNX_VERSAL_CFRAME_REG,
>> +                       CFRAME_REG_R_MAX * 4);
>> +    reg_array =
>> +        register_init_block32(DEVICE(obj), cframe_reg_regs_info,
>> +                              ARRAY_SIZE(cframe_reg_regs_info),
>> +                              s->regs_info, s->regs,
>> +                              &cframe_reg_ops,
>> +                              XLNX_VERSAL_CFRAME_REG_ERR_DEBUG,
>> +                              CFRAME_REG_R_MAX * 4);
>> +    memory_region_add_subregion(&s->iomem,
>> +                                0x0,
>> +                                &reg_array->mem);
>> +    sysbus_init_mmio(sbd, &s->iomem);
>> +    memory_region_init_io(&s->iomem_fdri, obj, &cframe_reg_fdri_ops, s,
>> +                          TYPE_XLNX_VERSAL_CFRAME_REG "-fdri",
>> +                          KEYHOLE_STREAM_4K);
>> +    sysbus_init_mmio(sbd, &s->iomem_fdri);
>> +    sysbus_init_irq(sbd, &s->irq_cfrm_imr);
>> +
>> +    s->cframes = g_tree_new_full((GCompareDataFunc)int_cmp, NULL,
>> +                                  NULL, (GDestroyNotify) g_free);
> 
> Stray space before 'g_free'.
> 
>> +    fifo32_create(&s->new_f_data, FRAME_NUM_WORDS);
>> +}
> 
> thanks
> -- PMM

