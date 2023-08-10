Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F5D778158
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 21:22:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUBDM-0006rt-6v; Thu, 10 Aug 2023 15:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qUBDK-0006ra-BR
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 15:20:54 -0400
Received: from mail-bn8nam12on2059.outbound.protection.outlook.com
 ([40.107.237.59] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1qUBDH-0007t8-UC
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 15:20:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIYsF/3Ec0JRnpubdVl7FpbS20/yOOlx5NwEdxBAZfk15BcVdJYsw8KHEJp7m4I/eM2FMDO4wNURGbM7Nar//jz3j7U6bQCml7uGBnWbl1Ucj5J0dt1UdE2fobRUH6hSqvsw16DUHSc8ZVgtDLzwnXSiTfOGQrEesZ0l+RpVnLFm8ojaBVcciWefZBl23Z2eXmOzLEKxOdbiCEgDwt+kfX9IxdkFwUdWOF1aOTWAapnQkcI0ZYMHwlGh3JkwgU9bMzRTiospXMLAZypAp6n3gqa2zZRbTv+ICcNvf6urbVnk6CK8pHoODuBgCQmAT2BEt+Jy+Pl997HSbLHG5IcuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3fjaGgZipdS0A1ncK6C3NFxol0AisYdqcBSlQup3ks=;
 b=KXBFghLWYYk1K68DYsaSOrZrImbJUEMwiS4a2TMVv6ZVmFBTb9o8uCF0RevvVJn70yHYr9ksNYmlI3xGoilYF9u4URFBiP8coBya8eL6uTLmbztTRW+WSrtKjYCxVqCjUPuJBfMMK4n08eF6LxrRl3+uyCaOQ3UFnMbOkSkNPqFjKCC76WdNn49NoHhCNhIRxIEwtFQIQSdWXBDA4z5gtg9wt3l315cCKWx+yAyE7oTXjMsg2shkDwY9Y1amtkKmRlHewjCtudYpdRCLP7+BhGV9wVC9L9hOrmDAa0OFsqgu0tQY3to841mfk3mV1sa+RWoDw16inRsOIk/7SH8aMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3fjaGgZipdS0A1ncK6C3NFxol0AisYdqcBSlQup3ks=;
 b=gem2v4R9pASxCulEin1J9aEYzjNmAAiAMzpk46YBNhVeOM3hdoY5jIFpWYlwWq1yd5F6O3ooJTnuy3JSMBWgIQg/281ZbfqYwkk4Jwfl5iF5ihguv0tN6twTMpWuzpQEegd8fpUMFjB6aQj1zDLEKLphfGGNjxfbsZZivZTfxsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8746.namprd12.prod.outlook.com (2603:10b6:208:490::7)
 by DM8PR12MB5448.namprd12.prod.outlook.com (2603:10b6:8:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 19:15:44 +0000
Received: from IA0PR12MB8746.namprd12.prod.outlook.com
 ([fe80::5398:c197:3f4e:7352]) by IA0PR12MB8746.namprd12.prod.outlook.com
 ([fe80::5398:c197:3f4e:7352%2]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 19:15:43 +0000
Message-ID: <3a9bacc5-da53-8164-71ff-2e6e20561155@amd.com>
Date: Thu, 10 Aug 2023 21:15:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 3/8] hw/misc/xlnx-versal-cfu: Introduce a model of
 Xilinx Versal CFU_FDRO
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, fkonrad@amd.com, sai.pavan.boddu@amd.com,
 tong.ho@amd.com, vikram.garhwal@amd.com
References: <20230710140249.56324-1-francisco.iglesias@amd.com>
 <20230710140249.56324-4-francisco.iglesias@amd.com>
 <CAFEAcA9Qpeh4anC64FBDdqry=H4-sNTZpRfuwqog51LnADtiCQ@mail.gmail.com>
Content-Language: en-US
From: Francisco Iglesias <francisco.iglesias@amd.com>
In-Reply-To: <CAFEAcA9Qpeh4anC64FBDdqry=H4-sNTZpRfuwqog51LnADtiCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::22) To IA0PR12MB8746.namprd12.prod.outlook.com
 (2603:10b6:208:490::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8746:EE_|DM8PR12MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: da38549f-77a4-4dbf-b1c2-08db99d63185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3WYIrO1X7EH3MW0jr5d1Z/N4/ycLQyuzZr24raeKUthSIO2TQkXXR70TXH7pfw1cYB9sTfLxlgW5izvJwWw7TIbdq/owV+AKXjtJ2uWgzCbK9jSbPzqtUzW8soIV1sfefpgV1GKVraSk+5lZlu2nxpHZfmjSay5PCEPaXwFOBiYjjr2e1W43RzacoqwUNJvMxdObMY/jkiUbnvbi7/xfnKHT07iCGEdkr6J42jHTMH4SiRmyQp71BmPND4LciPyBFZdCEKUfWLj/LQ6/r6J5V8SFCbyv4gJTDnZcqaFIureLUweD+/THsEV4jjvyfxoUiQJJeHbsDL2glqKJntX0/8/fC5bGYtrQIsEcFVeXo+RLT8ZnexZ4o36zNst+x8778ilpa4T2qvwSlz5IgNDB/fCGAISvai8aTJDlIUURBG7UREhBN6XeIL1ewmSRFa8NWUwiRxDqH9/FfJOuHoUBn+adK9c+e2E6LYzNpIMa3+tFXYaXKEaN/YS0pm5DO13Tjk/Qdo2F0ZN+8ZVfiR+7T00MRXQP8gJ/4tmGv5GLlWOnLovkMwhGbCzS9N460kbTPcmiaTwHI7p/YA0++mvSh2qj68lS1U8hkUV0yrA2HoZCw8bkg3QYWO8AlkOOaG6jiwzVA1+M4ob0pNN6WdkvTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8746.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199021)(186006)(1800799006)(31696002)(36756003)(53546011)(26005)(6506007)(8936002)(8676002)(316002)(86362001)(2616005)(478600001)(83380400001)(41300700001)(5660300002)(6486002)(44832011)(66476007)(66556008)(6512007)(66946007)(6916009)(2906002)(4326008)(31686004)(6666004)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekhENE92OGRpOVk0d3h0cTUvVkkraHJscXFuRU95YXRDNkZQZkRiVERNSDFx?=
 =?utf-8?B?djVWQngrWkpyU0pmUGZObkxWdGNVRmEwN3ozckIzcXNGTnhWNFdhZ29DYnlL?=
 =?utf-8?B?MVpXSUdkeC91cmVOTDlKMUlRQ3FXNVN6NXpzaGpZd2ZtNUw2RXo3eUlkaDBs?=
 =?utf-8?B?UzY3MnNtRzJ3K3lJVmR1dlVyMmZnRU9seW1lVEVUWTVHMzBaZ2FMVER5T2Fq?=
 =?utf-8?B?SG5hVUFZWWxMRDE3ZDl6Q1ArOWJTUEc3YUNaT0Z3VFdQOVZiNktHZy9FMHFR?=
 =?utf-8?B?L1B0WEZ0VWJWemdHK1JERHdyVDVKRllOcHhXME5SQ3hMdDVPN0d6Qmt6YjNi?=
 =?utf-8?B?THYvdXNZZzJkWXdnQkZTd2F5UW5Md2FKRFZzN3F3ZWVBcVZGcE5zTjYrZzFj?=
 =?utf-8?B?NFVhS0ErRkd2YWNCdTkzQk5XU2V4WC9WTzlPb0ZOeDFCUWs1RWpmNDIrRGd5?=
 =?utf-8?B?UUxXTVE2YWNqWTQvVXU4dVFoZDdQK1NTYkJIYkwwZ1dyUG5WOVA1WFA5aFcx?=
 =?utf-8?B?RFJMVkZVMWlDdXRORm9YVzd0NytMQTEwQXh1VTdFa3ZHS0VSY0Zqd0twS204?=
 =?utf-8?B?VXBrWDBDbko5Z0tsdU51VXg3Vk1zQkQzdzgxcllRQ0VtQ0xqREhxTXg1dUxV?=
 =?utf-8?B?SmRqdFZqbEdmbUp6eDNEYW90WWlFYUdqUm0yR2EwNkRCUmRDcmxITy9VNm9L?=
 =?utf-8?B?ditkNFRVcXJuTmN5YkdReFRnRzlZdzc4U0FnVTVtWllBR0krdXlUUys0TjU1?=
 =?utf-8?B?V2crTXRZeEU3bzNFbzhUYjlhdndWYWNxMHFKRnluUXYwZDNyRWNWMTNYNHdn?=
 =?utf-8?B?VU50K1BjSFNtVUVwQ3gxRU5KSE5xdkJwK1VlL3pYVzRwVkZsTERUU0JON0dX?=
 =?utf-8?B?RDJqaVlZc05KeGQxNHpNdndTb0l2dkUySFlEeTV6bmFqU09hcmRUNkNWY3FG?=
 =?utf-8?B?THdzbzh1b21LeXRvazZpQkhkc25pbCtmMVlBY0dFcjBUU1Z3Q3RGZUhIVzgv?=
 =?utf-8?B?R3pYdVhOQm51SFI1ZWU1em1SVUtacGphSStwYlQra0JxVVptcFh0VlNmYW03?=
 =?utf-8?B?eWhFN295YVBpSERNTHlEWUhiSWkwRlFSUDlOQzlxT3NVNmd2RmwxbVZtRUV6?=
 =?utf-8?B?a1ZOc2YrNm1LQWlvUE5FUUtCY1JPekFjWUNSWldKVmo0Tjk0T3l6N2I3eEZy?=
 =?utf-8?B?TzJMWUVuZzFtTGhnNWpJRGJoUzAzZ1VUVmt5WHhzK1FabWV1Z0RBb0pTME12?=
 =?utf-8?B?dURJWTQ5bzk3eE9kUGRrSDZZY1NTVkRhUWN2NWJsWUYrdVQ1MVV5Zm9uTXdn?=
 =?utf-8?B?VWZTcUVpeEovd1N1YVpCWXYxVDhHM1VHT3h3ZlFKY2tuUEMxQ1BpODhsOFRR?=
 =?utf-8?B?Tk9jd0VSRkRaa1pDamUrVkluYWdTUWRLaytyTERqM20xVERNc09KcjV3Vk5C?=
 =?utf-8?B?Ziszd0pUanhSdG5IT1FpZy9LbjRUemlsNVp1SytmVkFQUnR6eTNjczExMnUx?=
 =?utf-8?B?dml6Y1pUM2Fya0hPR2Q4ZHBwcjd5dWtVMkNPRlJBVzc1NkFNRHZRZ1krRk52?=
 =?utf-8?B?TXoyMW5RTy9FM0FRSm0zZjM3NFA5eUFDQlBOcmJoTnBEelgwTm9tTDQzb2Vj?=
 =?utf-8?B?a0U1N3ZiMEZmNVA5bHFXMHkvaGxUK0Q3aFhDcWkrUmtoUmZydkU4SWs2VFlX?=
 =?utf-8?B?enpDRStyTEI2YmN2djdvdUE3YkI5a3hzTmFEK01haW9WL295S1dDb0FBL1NP?=
 =?utf-8?B?ZWJwdnkrZXJPNGM0NGRnb3lCUXJGN3hmckFMb3NndnRhZHZwM1hnYW8rUWo1?=
 =?utf-8?B?QXBrbEdtc09Gekg1K3Q4OS9BWlFqR2FaeElMSjlMdFhwRzh2UE1GUDZsd0xx?=
 =?utf-8?B?Y051Sk1nQ3hiY0tyb0xleVN4VHg3UUxVN0FiV3pTSWtMeEZ5Tk5xTlM0ZTdX?=
 =?utf-8?B?bGh5a0lrQS81SzlqVFNkUmo2YThxVUZNN29TMWRNU204STZRS0VIY294VGI0?=
 =?utf-8?B?bFNzaitRK2EvV29hdmE3Vzg5V3hqMjBXeXNleHU1NTV6UHlQL2Ntcjd2MHBO?=
 =?utf-8?B?UUpPK1JjR2huVGpEaDlxYVR6RVphTEFYdytIYytDZEV1WXk4TUZZbXNLekd4?=
 =?utf-8?Q?03GIgJgmCBeNsnsuQm8iV0aj2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da38549f-77a4-4dbf-b1c2-08db99d63185
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8746.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 19:15:43.8003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pACjgofStb7pwNOHQjs7fW1On1pat5R1ZzVfwd0Ktk68akf2CdbuZz4Oplo5sIh2pKcUaEShxTWnnqoiRyn9Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5448
Received-SPF: softfail client-ip=40.107.237.59;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.156, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 2023-08-03 15:48, Peter Maydell wrote:
> On Mon, 10 Jul 2023 at 15:03, Francisco Iglesias
> <francisco.iglesias@amd.com> wrote:
>>
>> Introduce a model of Xilinx Versal's Configuration Frame Unit's data out
>> port (CFU_FDRO).
>>
>> Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
>> ---
>>   hw/misc/xlnx-versal-cfu.c         | 105 ++++++++++++++++++++++++++++++
>>   include/hw/misc/xlnx-versal-cfu.h |  11 ++++
>>   2 files changed, 116 insertions(+)
>>
>> diff --git a/hw/misc/xlnx-versal-cfu.c b/hw/misc/xlnx-versal-cfu.c
>> index cbd17d2351..528090ef1b 100644
>> --- a/hw/misc/xlnx-versal-cfu.c
>> +++ b/hw/misc/xlnx-versal-cfu.c
>> @@ -257,6 +257,26 @@ static void cfu_stream_write(void *opaque, hwaddr addr, uint64_t value,
>>       }
>>   }
>>
>> +static uint64_t cfu_fdro_read(void *opaque, hwaddr addr, unsigned size)
>> +{
>> +    XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(opaque);
>> +    uint64_t ret = 0;
>> +
>> +    if (s->fdro_data->len) {
>> +        ret = g_array_index(s->fdro_data, uint32_t, 0);
>> +        g_array_remove_index(s->fdro_data, 0);
> 
> This is pretty expensive because everything in the GArray
> after element 0 must be copied downwards. Are you sure you
> don't want a different data structure ?
> 
> What actually is this, and what are the operations we want
> to do on it ?

Thank you very much for reviewing! Regarding above, it is a fifo so 
changed to use a Fifo32 in v2 and I also tried to update according to 
all other comments!

Best regards,
Francisco Iglesias

> 
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static void cfu_fdro_write(void *opaque, hwaddr addr, uint64_t value,
>> +                           unsigned size)
>> +{
>> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported write from addr=%"
>> +                  HWADDR_PRIx "\n", __func__, addr);
>> +}
>> +
>>   static const MemoryRegionOps cfu_stream_ops = {
>>       .read = cfu_stream_read,
>>       .write = cfu_stream_write,
>> @@ -267,6 +287,16 @@ static const MemoryRegionOps cfu_stream_ops = {
>>       },
>>   };
>>
>> +static const MemoryRegionOps cfu_fdro_ops = {
>> +    .read = cfu_fdro_read,
>> +    .write = cfu_fdro_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 4,
>> +    },
>> +};
>> +
>>   static void cfu_apb_init(Object *obj)
>>   {
>>       XlnxVersalCFUAPB *s = XLNX_VERSAL_CFU_APB(obj);
>> @@ -298,6 +328,24 @@ static void cfu_apb_init(Object *obj)
>>       sysbus_init_irq(sbd, &s->irq_cfu_imr);
>>   }
>>
>> +static void cfu_fdro_init(Object *obj)
>> +{
>> +    XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(obj);
>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>> +
>> +    memory_region_init_io(&s->iomem_fdro, obj, &cfu_fdro_ops, s,
>> +                          TYPE_XLNX_VERSAL_CFU_FDRO, KEYHOLE_STREAM_4K);
>> +    sysbus_init_mmio(sbd, &s->iomem_fdro);
>> +    s->fdro_data = g_array_new(FALSE, FALSE, sizeof(uint32_t));
>> +}
>> +
>> +static void cfu_fdro_cfi_transfer_packet(XlnxCfiIf *cfi_if, XlnxCfiPacket *pkt)
>> +{
>> +    XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(cfi_if);
>> +
>> +    g_array_append_vals(s->fdro_data, &pkt->data[0], 4);
>> +}
>> +
>>   static Property cfu_props[] = {
>>           DEFINE_PROP_LINK("cframe0", XlnxVersalCFUAPB, cfg.cframe[0],
>>                            TYPE_XLNX_CFI_IF, XlnxCfiIf *),
>> @@ -344,6 +392,41 @@ static const VMStateDescription vmstate_cfu_apb = {
>>       }
>>   };
>>
>> +static int cfdro_reg_pre_save(void *opaque)
>> +{
>> +    XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(opaque);
>> +
>> +    if (s->fdro_data->len) {
>> +        s->ro_data = (uint32_t *) s->fdro_data->data;
>> +        s->ro_dlen = s->fdro_data->len;
>> +    }
> 
> I think we need to initialise ro_data and ro_dlen in
> the else case here as well. Otherwise they might have old
> stale stuff in them that then goes into the migration stream.
> 
>> +
>> +    return 0;
>> +}
>> +
>> +static int cfdro_reg_post_load(void *opaque, int version_id)
>> +{
>> +    XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(opaque);
>> +
>> +    if (s->ro_dlen) {
>> +        g_array_append_vals(s->fdro_data, s->ro_data, s->ro_dlen);
>> +    }
>> +    return 0;
>> +}
>> +
>> +static const VMStateDescription vmstate_cfu_fdro = {
>> +    .name = TYPE_XLNX_VERSAL_CFU_FDRO,
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .pre_save = cfdro_reg_pre_save,
>> +    .post_load = cfdro_reg_post_load,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_VARRAY_UINT32_ALLOC(ro_data, XlnxVersalCFUFDRO, ro_dlen,
>> +                                    0, vmstate_info_uint32, uint32_t),
> 
> This kind of _ALLOC vmstate will cause the migration core
> code to g_malloc() you a buffer for the data. We don't
> free that anywhere (and if we have a subsequent vmsave
> then we will overwrite the ro-data pointer, and leak the
> memory).
> 
> It might be better to avoid the GArray and just directly
> work with a g_malloc()'d buffer of our own, to fit better
> with how the _ALLOC vmstate wants to work.
> 
>> +        VMSTATE_END_OF_LIST(),
>> +    }
>> +};
>> +
>>   static void cfu_apb_class_init(ObjectClass *klass, void *data)
>>   {
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>> @@ -353,6 +436,15 @@ static void cfu_apb_class_init(ObjectClass *klass, void *data)
>>       device_class_set_props(dc, cfu_props);
>>   }
>>
>> +static void cfu_fdro_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    XlnxCfiIfClass *xcic = XLNX_CFI_IF_CLASS(klass);
>> +
>> +    dc->vmsd = &vmstate_cfu_fdro;
>> +    xcic->cfi_transfer_packet = cfu_fdro_cfi_transfer_packet;
>> +}
> 
> Missing reset method ?
> 
> thanks
> -- PMM

