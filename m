Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A32709BD8
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:58:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q02U6-0003Rq-W3; Fri, 19 May 2023 11:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q02U5-0003RV-Mb
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:57:37 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q02U3-0003HN-Ss
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:57:37 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f4449fa085so21636855e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 08:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684511854; x=1687103854;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yRnUqNHlL4vvXFFu38W8sO7cIUqDAJNRsqtDH6OXVSk=;
 b=mnS3NKNYTA797Z/NaHfJ37SOs33DHAayAOpozBl2931iV7igxiGH9ENyDGZR0HYfOB
 lNluQLQndIpOFgQ2SfARYU12Ja7WtK7HuIc1nN24iiSN0G+2eyomlONwhaPWxAvUrFVi
 d9imQWRdnvutzaSwXbBLuB3Qx1m3N249IPoPcCI0Hpn1AqfsWje/u78Pv0iDViz6Z2Kb
 1KBrZQr8/k3kxlMuHizTj2TIT3Pg937gSI+jiPkU0flPyLZgY6L4dYu1gByGgE+SPFlG
 E6CBcU12sIMd+VVqYiCL/CmNnSSWIcdarFOIyBaj++1RABfjgFgV/FvVrkQ7uv83Gny/
 RgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684511854; x=1687103854;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yRnUqNHlL4vvXFFu38W8sO7cIUqDAJNRsqtDH6OXVSk=;
 b=DcCiuTK5dx0nzkovuFZuduhPzH7zaejaQpVbyTB3+dArl2erJPlueRT6L+LNx96zTz
 l/k4HnzLA67bz3CqGFr15HxCTiSOcZIoiHnCuiJ6+XpMSb1d4jg5cSHrFvukUzN7zj+Y
 HnqDbGSP2Qzvy6h/p+sG1FDEyyxHRBzGHt9sKH02IJmZU98HUV+mDnke6ucuRSjohmt9
 iIiLAFoVlu8AiMw7Da7pkIuUeEgPE6TX1Vh5w7DnCs/JL9Qc2nxgkMht32/iUUmTgnyO
 ZNo8KGDma3jUONnvc6Hyb0ma9y4DAymwc+Gtz3XuAdt9Jp9JVnU/5dAF83vyXTnFpViO
 s6GQ==
X-Gm-Message-State: AC+VfDxeW2J+waI3KDbeoTLIWVK4P12bQ7WbzP8zIkeoG7kHXv80GTbC
 VwR5jfAnh1dIIF5J7DSqa4DVBA==
X-Google-Smtp-Source: ACHHUZ6SfcrcFIc1c4107FDZSSyO6Pk4nbjMhkTLabkvZ9fjDDJ+tdQk0VxKLnTPyrG+iON399vaOA==
X-Received: by 2002:a05:600c:2285:b0:3f1:662a:93d0 with SMTP id
 5-20020a05600c228500b003f1662a93d0mr1884634wmf.15.1684511854209; 
 Fri, 19 May 2023 08:57:34 -0700 (PDT)
Received: from [192.168.69.115] (mau49-h01-176-184-41-228.dsl.sta.abo.bbox.fr.
 [176.184.41.228]) by smtp.gmail.com with ESMTPSA id
 m13-20020a7bca4d000000b003f4dde07956sm2769753wml.42.2023.05.19.08.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 08:57:33 -0700 (PDT)
Message-ID: <b06ee1dc-6ddb-327d-1180-d139862f9173@linaro.org>
Date: Fri, 19 May 2023 17:57:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v6 6/7] hw/cxl/events: Add injection of DRAM events
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
 Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org, linuxarm@huawei.com,
 Ira Weiny <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>,
 Dave Jiang <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20230519143043.30191-1-Jonathan.Cameron@huawei.com>
 <20230519143043.30191-7-Jonathan.Cameron@huawei.com>
 <6dc139cc-ec19-196f-017a-cb0a415af3e5@linaro.org>
 <20230519164533.0000436d@Huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230519164533.0000436d@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.527,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 19/5/23 17:45, Jonathan Cameron wrote:
> On Fri, 19 May 2023 17:34:20 +0200
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>> Hi Jonathan,
>>
>> On 19/5/23 16:30, Jonathan Cameron wrote:
>>> Defined in CXL r3.0 8.2.9.2.1.2 DRAM Event Record, this event
>>> provides information related to DRAM devices.
>>>
>>> Example injection command in QMP:
>>>
>>> { "execute": "cxl-inject-dram-event",
>>>       "arguments": {
>>>           "path": "/machine/peripheral/cxl-mem0",
>>>           "log": "informational",
>>>           "flags": 1,
>>>           "physaddr": 1000,
>>>           "descriptor": 3,
>>>           "type": 3,
>>>           "transaction-type": 192,
>>>           "channel": 3,
>>>           "rank": 17,
>>>           "nibble-mask": 37421234,
>>>           "bank-group": 7,
>>>           "bank": 11,
>>>           "row": 2,
>>>           "column": 77,
>>>           "correction-mask": [33, 44, 55,66]
>>>       }}
>>>
>>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>>    hw/mem/cxl_type3.c          | 116 ++++++++++++++++++++++++++++++++++++
>>>    hw/mem/cxl_type3_stubs.c    |  13 ++++
>>>    include/hw/cxl/cxl_events.h |  23 +++++++
>>>    qapi/cxl.json               |  35 +++++++++++
>>>    4 files changed, 187 insertions(+)
>>
>>
>>> diff --git a/qapi/cxl.json b/qapi/cxl.json
>>> index 7e1e6257ce..5e82097e76 100644
>>> --- a/qapi/cxl.json
>>> +++ b/qapi/cxl.json
>>> @@ -55,6 +55,41 @@
>>>                '*device': 'uint32', '*component-id': 'str'
>>>                }}
>>>    
>>> +##
>>> +# @cxl-inject-dram-event:
>>> +#
>>> +# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2)
>>> +# This event type is reported via one of the event logs specified via
>>> +# the log parameter.
>>> +#
>>> +# @path: CXL type 3 device canonical QOM path
>>> +# @log: Event Log to add the event to
>>> +# @flags: header flags
>>> +# @physaddr: Physical Address
>>
>> Could this be a clearer description?
>>
>> "Physical Address (relative to @path device)"
> 
> Makes sense.
> 
>>
>>> +# @descriptor: Descriptor
>>> +# @type: Type
>>> +# @transaction-type: Transaction Type
>>> +# @channel: Channel
>>> +# @rank: Rank
>>> +# @nibble-mask: Identify one or more nibbles that the error affects
>>
>>> +# @bank-group: Bank group
>>> +# @bank: Bank
>>> +# @row: Row
>>> +# @column: Column
>>
>> Why do we need bank/raw/col if we have physaddr?
> 
> Yes we need them. We don't know the device geometry / internal interleaving
> / address hashing applied to smooth out access patterns etc.
> 
> I really don't want to put that level of complexity into the command
> line for a device - so just left it to the test tools to squirt in
> something valid.
> 
>>
>> These are optional. Shouldn't we check they are valid
>> in qmp_cxl_inject_dram_event()? (No clue, just wondering
>> if there is some duplication here).
> 
> Validation is really hard for these as depends on the above
> device implementation complexity.  There is a note on trying to
> strike the balance in the cover letter. I'm not sure I have it
> right! They are optional in records coming from the device, so
> we set validity flags for them in the device record.
> 
> Aim here is to be able to inject whatever might be seen on a real device
> without having to have QEMU emulate a bunch of device internals
> such as mappings to particular DRAM FRU, chip, column, row etc.

I was expecting some check like:

   ROUND_DOWN(physaddr, 8) == bank * row * column * 8

But indeed this isn't really useful for your tests, since we want to
check sanity for values from the guest, not from human via QMP.
So FWIW overall LGTM.

> 
> 
>>
>>> +# @correction-mask: Bits within each nibble. Used in order of bits set
>>> +#                   in the nibble-mask.  Up to 4 nibbles may be covered.
>>> +#
>>> +# Since: 8.1
>>> +##
>>> +{ 'command': 'cxl-inject-dram-event',
>>> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
>>> +            'physaddr': 'uint64', 'descriptor': 'uint8',
>>> +            'type': 'uint8', 'transaction-type': 'uint8',
>>> +            '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
>>> +            '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
>>> +            '*column': 'uint16', '*correction-mask': [ 'uint64' ]
>>> +           }}
>>> +
>>>    ##
>>>    # @cxl-inject-poison:
>>>    #
>>
> 


