Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BBF7EE5BE
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 18:14:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3fvb-0000NJ-N4; Thu, 16 Nov 2023 12:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1r3fvZ-0000LC-C0
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 12:13:17 -0500
Received: from mail-bn7nam10on20604.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::604]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1r3fvW-0000O9-J7
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 12:13:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSUvfAyvp6EapEFEIfsThxwiFB1OWD3LOOeU4nYI4/99HygbqRn+q4Maq/G2QTDFXocutmQllxX8+Z/XOZZGcSXMa8k240GbZSsfu1nWQqJDeOI+et6oWMTlG1QBgE2ghFsF9AaTmj6cFDV2m8yWyuOPUMJOJZRLEgrEhGeMbvv+5D92U2BtWw9X5XLQPqG03ymdEvS2Ygkyyj0L0Z37BeohYT9tCPtzWJA0WVFtiFUjFji1XJiQMBk55fl72HtKxJVQgnKjMmgrr2ydJNK4R18bhinANF9zKmdtmJdtGj2kiYOnKIDDAddyso7+TCeSmWZy/uWwnSWEqlBF5ijmEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJustPZP0/WhlJV1HgAHi+K9OUZ1H9qpcvY4wVcOiwo=;
 b=QA49Mr3cjzG34+qXP09DQSIIlIZEaik2vvc0Ocuctike61n3RympYuzym7sXpiCs4mpXPEc3J4NvFeQFdQHZc2wDS21u8yf58YtmgSvbEM5b8/gS2SJ70eoS3ls28Pusas5tViajsX18YoGXCfEynGsUwC9w56gPl7soW6FXW2CFA64YV+gmfna0ubOyY/Ku3rZC3f+0kr+BpiJI9WQKvf1FMfTZtPMTthsRpCw/cRh1L9ugiFkxP4Mj9Mv6heHjFKQTmKcTCiv82ewHzwCQNBl3nYmsWJJ3DLck6NNMxi/qESFZvciPA2Aq7dvl7ejpzucoSL+fF1F2ASkDQZo+ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJustPZP0/WhlJV1HgAHi+K9OUZ1H9qpcvY4wVcOiwo=;
 b=mp2cR7wMdAOAlJg65aZi/Awy4R11IWTQ3n2a6acdIWlvsly8o15/KwR3pj6rH8SotODppP3O0EPRL3c6qX6Hx0A+4Hi2wDSshndqmHxapQK0hgZkR6Rzwz71/08SniQYEe9rUP6veM2u2hhG7SnNQeLRbK/FvSSkLViwy/WiD4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Thu, 16 Nov
 2023 17:13:04 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::5f66:ae33:b947:c68b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::5f66:ae33:b947:c68b%7]) with mapi id 15.20.6977.029; Thu, 16 Nov 2023
 17:13:04 +0000
Message-ID: <c07f23dd-9227-4c9a-9293-83eb864a2cf2@amd.com>
Date: Thu, 16 Nov 2023 18:12:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2] hw/net/can/xlnx-zynqmp: Avoid underflow while
 popping TX FIFO
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>,
 Vikram Garhwal <fnu.vikram@xilinx.com>,
 Anton Kochkov <anton.kochkov@proton.me>, Qiang Liu <cyruscyliu@gmail.com>
References: <20231115151711.89170-1-philmd@linaro.org>
 <9282e81c-51a6-46be-bcfa-dfec2f04a817@amd.com>
 <89ee4de6-db99-4434-8422-77b1923296b0@linaro.org>
From: Francisco Iglesias <francisco.iglesias@amd.com>
In-Reply-To: <89ee4de6-db99-4434-8422-77b1923296b0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P193CA0049.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:51::24) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 313d9baf-c37d-46db-9c57-08dbe6c74b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: otuJHbQw5bswmthXF/jGMb+xNQic4qPEtZeyfcondn3B5x/wKq0J9ASabMtPDuLZM/J0HSr6QCVy3mjUXMqZ3DRfsDk0NZJzRYmVDaxW4KiVky6c12r5DUCzf2dinXdmwphGvxnbbsI3CqIClwJWNHlEe1uBwkxaicO7DtDjgOGd35puk9Yy+vVktv2yijHI00gbSlXrp0bSFuzgxoZ4XwdyJXiXvkZgw02+HtGcmUy7eH0SQPGWY1MQHzYht0Z9RCIsQCcGfWX+JP8RqP7E19zYJL7fuJk+dZSnkbEZH1xLFbBiHYaTjpO6fl/lWKgszQ8ZBubePQDvOrhdWMHW7jlpVtZCtUycQjJzkyn2HgRy/Wd1GM3cu/TISoPYXXMZl8LJXHQAqU1+1vVGo0uov882BcYGHkDtq8SM5Qvwy0pAP6Tsv7bIUhiafchKTMCiF6SXtHF2/kRlcxjwRhO7AcvfXPm5tgqiodcmZEg1aCmsl09dYUcFkrBbcsKTNWsC4j8QdZPegFvx/pzAIxAeXpKHmIkFwsOaFnSy8NlF7dlBFAMa99i89zKBNGlhZU59TcNuXllHZMmscpTPESThFVm99ZXfhup6VQIo5XQjjHsej+9jOWTeoPDQrVXrYrbVrnBLLvps+A8WCwrcB4XVNtWyPqRh2/dWgS8eueBWr0FG6CT4bwG3J0z+/Q4x1JC3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(26005)(83380400001)(2616005)(6666004)(478600001)(6506007)(53546011)(6486002)(966005)(6512007)(31696002)(86362001)(5660300002)(44832011)(31686004)(41300700001)(38100700002)(4001150100001)(2906002)(36756003)(316002)(54906003)(4326008)(8936002)(8676002)(66946007)(66476007)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk4wQktDWDdieGFVVmZZUFAyUUdmQkxJNXFick9IK05SOEV1OVdUQXpEU2t1?=
 =?utf-8?B?b1NYZUJtSTVBNU1vR2VOajFBeEZjZ0l6NzVVZk91ZHAyTWh3WTB4SStiYW81?=
 =?utf-8?B?Zk9tQ3pxbnJPUXRCNlRuUnlNejRYMXBSeGtGVHkwOHJEcEtsMG5RWjRzMEFP?=
 =?utf-8?B?Y1ZyeTVjRkdiaDVxNlFTMFlwR1VIS040elJySkx0L1VJU3ZpVnppa3c2UmxT?=
 =?utf-8?B?VGNGNHQxL1JTREJ4aUlkTGxpTWNxeWdIc0hWQ1B5cXU1RmpQRDFVTGwvOFBi?=
 =?utf-8?B?RWlZUk5RaXI1eW96anJrWVZXaWtLU0tTS1crenVub24rWWZJL0FIay9jT2Nh?=
 =?utf-8?B?OUQ1QWN5OFJyQ240em51UnBuR21Ea0ZINWRuRjRGZll6Mm12YUJnR1Znbm1J?=
 =?utf-8?B?aEhXejh4Zll1WWs2eDU3d1U2dnp3VENycTNmV1p2QzZ1a2JJbTlaK3lQU3l4?=
 =?utf-8?B?a2hWYWZTOXNSbVYrTERwd0VJc056c0JjUzFIWVJVdnZnNjFYZUVoK08xellP?=
 =?utf-8?B?d1lDbmU1b0o2aDVsS3JXUUczeCtwOVBWL3JzbWZ6bDZGbFB1Um1OUlF0RzFl?=
 =?utf-8?B?RnJFTm12WjB2a0IveFpXb2lBYUZMeFY1eEFGYVF5M0pSZktCdnF6a3ltdU8w?=
 =?utf-8?B?SUdyMWlpd00xSUJBZi9wUnU5UnZrTGNCK2Z5cjdkakdKcHQxaTM3SjVQWm1F?=
 =?utf-8?B?WmF0NTBYTzlZWVM3Y3Zvb0lHZnlQdHpxY0cyakMxblcvNC9OdEd1OGh1RFNH?=
 =?utf-8?B?ck1oWElpcm5FeGhYeDR2M2xGczhIU1BxQjE3ZnBWMXIranYzZHR1aS9SMnF5?=
 =?utf-8?B?aVE0SytFck5CSkJxdmppcjNGTXJtVDBrRUN4Z3FpUXRZdlBsWEpNMi81YzhK?=
 =?utf-8?B?NTJ0RGdrWGs5NGZiT1pybkZPT0s4QVZlYkxXQVpFbHdZZTFkZy9mSTAvZTJE?=
 =?utf-8?B?SkR4Y2tYMVVncFRqT1Yxb2RlVW5OK0h5cTdSRVJjWjZMSlJ6eU16RGVNSTMv?=
 =?utf-8?B?MUQ5ekhTMzhnRldNU05RYlFKMFM4aUxQOUtxWVpzWlQ5RDV2MUtoNys1bFo2?=
 =?utf-8?B?ckRUWHlVTGtGVHVUci9MakQxZDd5d2F0c2UydGVSWEZiYUVvUEhhZk5Ma0p1?=
 =?utf-8?B?aVVXME5JRVJ6Tm5zT0N0WlcxTVRoUnNzeHhFOFFmRXR1WGlSM0pUWFZFd3NH?=
 =?utf-8?B?ZzhXUi9TL3RJWUJralNIemdTeHlmYTk4RFdQc25QbDA4QmhUK3pyeU0vdDFP?=
 =?utf-8?B?UUNSeDRiNTYrQzhJSFQ1MjU5YWhFUElsbkpsUm5ZUERsMlprblJvR3MrajB6?=
 =?utf-8?B?SlRMa3VqZlBXUVVXc1JDRXU0NFpTK3MwdzMwaW02cGFJVGFqQkgyUFNnazUw?=
 =?utf-8?B?cmttaVJua29DcXZOalJUekJ0ZzZPdWJJWm8zOXVvVUp0K0xtNTVGVFF1L2ZT?=
 =?utf-8?B?ckpwS0JLeEI2RDZicFR2RE1aSEYxOTBMaWdMaE5nbnQ3NUhWd0NTUlZwUVlC?=
 =?utf-8?B?OU42UkpWM01zR2FqYkVPcDBtYjVlazNKTm1iK1Fac0JkYkR1WGRyd3lZcGx5?=
 =?utf-8?B?OXJDbHZZYTM2bFlSVmZrWDZ0dFBvekNLclJxNCtpTGNRMWcvRkJlbHVCTmZh?=
 =?utf-8?B?SHhlRVpEYmRKSytyRHlRazF5V3R2bGZYZkJrT1JyenZHK3ZMWUk4NUR6T2hK?=
 =?utf-8?B?dmNlaFhQWXdlWWtUK2YyM0o0c3A5WVlSVWQreVRSMEJMZkZCYzdpZS9EUVNH?=
 =?utf-8?B?elUrb2szZk01aHdWcGtzV3dlM0pXRHlLZEZ0czgxMFBvalVFZXhoV09BY3Jn?=
 =?utf-8?B?M0ZOdzVCb0pHbWplb0pWQnFQRkFsbXVIYXdVRXYreVV0Y3dUV0dvaFFXWlZw?=
 =?utf-8?B?YXpJbjRKakhmdTZGWEVkekVacmwzUnlSMGUxYzhjRnoyMWZMdlFpclFOVHZQ?=
 =?utf-8?B?OVZDRDNybi9PWWpvT0VRajRxUmVaQUJidWRneHd3eTkwdVVFNHNRZStET1Jt?=
 =?utf-8?B?bFhoUitwVU4zeHJ5TGhSaktpSmVXV0RXdmtxRHE2RGZWMUM3MUFGSlVTWDNv?=
 =?utf-8?B?QkJ1VG5BRS83VWoySUw1eTc1WVdLRlpOM2NTbEpRTVFoQzBSZjhycUxnNGF3?=
 =?utf-8?Q?LcpmQAvSLnnHRhrE5HnGlSDk4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313d9baf-c37d-46db-9c57-08dbe6c74b2e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 17:13:04.2562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3fEXsVJ+bXflrGYs71krw58l7cKQEjQo83mZoych8YB5EcxqYELAdyAh3KY4YRMA/rgOSeVusETodh5VRJLpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::604;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
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

Hi Philippe,

On 2023-11-16 16:44, Philippe Mathieu-Daudé wrote:
> Hi Francisco,
> 
> On 16/11/23 15:17, Francisco Iglesias wrote:
>> Hi Philippe, good catch!
> 
> Well this was fuzzed by Qiang Liu.
> 
>> On 2023-11-15 16:17, Philippe Mathieu-Daudé wrote:
>>> Per 
>>> https://docs.xilinx.com/r/en-US/ug1085-zynq-ultrascale-trm/Message-Format
>>>
>>>    Message Format
>>>
>>>    The same message format is used for RXFIFO, TXFIFO, and TXHPB.
>>>    Each message includes four words (16 bytes). Software must read
>>>    and write all four words regardless of the actual number of data
>>>    bytes and valid fields in the message.
>>>
>>> There is no mention in this reference manual about what the
>>> hardware does when not all four words are written. To fix the
>>> reported underflow behavior when DATA2 register is written,
>>> I choose to fill the data with the previous content of the
>>> ID / DLC / DATA1 registers, which is how I expect hardware
>>> would do.
>>>
>>> Note there is no hardware flag raised under such condition.
>>>
>>> Reported-by: Qiang Liu <cyruscyliu@gmail.com>
>>> Fixes: 98e5d7a2b7 ("hw/net/can: Introduce Xilinx ZynqMP CAN controller")
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1425
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> Tested with the CAN tests from 'make check-qtest-aarch64'
>>> ---
>>>   hw/net/can/xlnx-zynqmp-can.c | 49 +++++++++++++++++++++++++++++++++---
>>>   1 file changed, 46 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
>>> index e93e6c5e19..58938b574e 100644
>>> --- a/hw/net/can/xlnx-zynqmp-can.c
>>> +++ b/hw/net/can/xlnx-zynqmp-can.c
>>> @@ -434,6 +434,51 @@ static bool tx_ready_check(XlnxZynqMPCANState *s)
>>>       return true;
>>>   }
>>> +static void read_tx_frame(XlnxZynqMPCANState *s, Fifo32 *fifo, 
>>> uint32_t *data)
>>> +{
>>> +    unsigned used = fifo32_num_used(fifo);
>>
>> For the case when there are multiple frames in the fifo we need to 
>> swap above to:
>>
>> unsigned used = fifo32_num_used(fifo) > CAN_FRAME_SIZE ? 0 : 
>> fifo32_num_used(fifo);
> 
> Isn't this ...
> 
>> With above minor modification:
>>
>> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
>>
>> Best regards,
>> Francisco
>>
>>> +    bool is_txhpb = fifo == &s->txhpb_fifo;
>>> +
>>> +    assert(used > 0);
>>> +    used %= CAN_FRAME_SIZE;
> 
> ... done here?

Ah yes, I was thinking that the first frame would be correct if for 
example used == 6, but yes that is not possible to know (can be the 
second frame that is ok). Feel free to add my reviewed-by to patch.

Thanks,
Best regards,
Francisco

> 
>>> +    /*
>>> +     * Frame Message Format
>>> +     *
>>> +     * Each frame includes four words (16 bytes). Software must read 
>>> and write
>>> +     * all four words regardless of the actual number of data bytes 
>>> and valid
>>> +     * fields in the message.
>>> +     * If software misbehave (not writting all four words), we use 
>>> the previous
>>> +     * registers content to initialize each missing word.
>>> +     */
>>> +    if (used > 0) {
>>> +        /* ID, DLC, DATA1 missing */
>>> +        data[0] = s->regs[is_txhpb ? R_TXHPB_ID : R_TXFIFO_ID];
>>> +    } else {
>>> +        data[0] = fifo32_pop(fifo);
>>> +    }
>>> +    if (used == 1 || used == 2) {
>>> +        /* DLC, DATA1 missing */
>>> +        data[1] = s->regs[is_txhpb ? R_TXHPB_DLC : R_TXFIFO_DLC];
>>> +    } else {
>>> +        data[1] = fifo32_pop(fifo);
>>> +    }
>>> +    if (used == 1) {
>>> +        /* DATA1 missing */
>>> +        data[2] = s->regs[is_txhpb ? R_TXHPB_DATA1 : R_TXFIFO_DATA1];
>>> +    } else {
>>> +        data[2] = fifo32_pop(fifo);
>>> +    }
>>> +    /* DATA2 triggered the transfer thus is always available */
>>> +    data[3] = fifo32_pop(fifo);
>>> +
>>> +    if (used) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "%s: Incomplete CAN frame (only %u/%u slots 
>>> used)\n",
>>> +                      TYPE_XLNX_ZYNQMP_CAN, used, CAN_FRAME_SIZE);
>>> +    }
>>> +}
> 

