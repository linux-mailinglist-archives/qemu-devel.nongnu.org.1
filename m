Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC29784213
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 15:30:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYRSI-0000c5-Am; Tue, 22 Aug 2023 09:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYRSG-0000bn-AE
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYRSD-0004Bg-T7
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692710993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ETqigHrPobwC36LTLfcQpHix9M0C2l3OvF6l1f5e9rk=;
 b=cB4zMnM3RNELYtMMFSHGRPDeSFBxnhfHd6gO5K3ug/HJC4wuVAqgoQhs8IzclIyVJGjGwz
 4wP5yefh8lp8fheg2cpy7zjdD7MKkShTHdx+uh1uLBp4ncmabSt929eSy7KOFJ93W7BqTd
 ED6OrrkOQaUSY+DT4l340+xm+1mU5xs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-BCHfmeUgNXeimMctu4IZtw-1; Tue, 22 Aug 2023 09:29:51 -0400
X-MC-Unique: BCHfmeUgNXeimMctu4IZtw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31aca0c0d63so2665175f8f.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 06:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692710990; x=1693315790;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ETqigHrPobwC36LTLfcQpHix9M0C2l3OvF6l1f5e9rk=;
 b=abH7qj4ZOvwctlTiILdOIHe5jCcybU7/0bzzmnYv2Dhf0/ecc+dRQl/g3/mKUOGzKl
 xB31ose7pcwyHWJe5YxUyGBB/WnwfOQv3vi6w+jOw3qyJZHlpYvr4BUMkJdM0l1sCipy
 0NnCujwn91RtsuK84+ZA5Y73Ov3tXWu74KbTHVD0r5GNr8deERz8cmrGWqqjtuHafy4n
 wJNRx8mmLpk0u7TrGkuCTElhYS6V8dOREZY05BLoYceV58qP8skAYaDnGcp839WP0tUh
 Z0sLgMZjxTrTckf49dlYEKYQqZm2hl0csWTnVia9MzReVgI3y5EOVQj+DdNmo9IDsYEf
 CMJA==
X-Gm-Message-State: AOJu0Yw7m6JfX69DvlGCe7tTcx776y75io1ejploxLnLnseo1wvfENo5
 7RWNDx7rauScb8tmQzmzNxGNZGWPa3+i+EYnBdtHdQ/VqFamfeikI0TuPFsHLlvyI2MJzABq6AU
 ORzLY02U3lkZZb7CUlbLpsEM=
X-Received: by 2002:a5d:4ccc:0:b0:314:1230:29b0 with SMTP id
 c12-20020a5d4ccc000000b00314123029b0mr6661731wrt.52.1692710990227; 
 Tue, 22 Aug 2023 06:29:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPAbQ49w02MT5BYQ+m4Pql166lvNlAjbkoAIDItiEGLAGZnKbil/LMp2k3pAgxPdMj0lf35A==
X-Received: by 2002:a5d:4ccc:0:b0:314:1230:29b0 with SMTP id
 c12-20020a5d4ccc000000b00314123029b0mr6661706wrt.52.1692710989749; 
 Tue, 22 Aug 2023 06:29:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:7400:83da:ebad:ba7f:c97c?
 (p200300cbc706740083daebadba7fc97c.dip0.t-ipconnect.de.
 [2003:cb:c706:7400:83da:ebad:ba7f:c97c])
 by smtp.gmail.com with ESMTPSA id
 o3-20020a5d4743000000b0031912c0ffebsm15896579wrs.23.2023.08.22.06.29.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 06:29:49 -0700 (PDT)
Message-ID: <1b5d82d1-166b-d4c3-f44b-54176892c4d2@redhat.com>
Date: Tue, 22 Aug 2023 15:29:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/9] backends/hostmem-file: Add "rom" property to
 support VM templating with R/O files
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Thiner Logoer <logoerthiner1@163.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2eBerrang=c3=a9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Greg Kurz <groug@kaod.org>,
 Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20230822114504.239505-1-david@redhat.com>
 <20230822114504.239505-4-david@redhat.com> <87v8d72omm.fsf@pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <87v8d72omm.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.767, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22.08.23 15:27, Markus Armbruster wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> For now, "share=off,readonly=on" would always result in us opening the
>> file R/O and mmap'ing the opened file MAP_PRIVATE R/O -- effectively
>> turning it into ROM.
>>
>> Especially for VM templating, "share=off" is a common use case. However,
>> that use case is impossible with files that lack write permissions,
>> because "share=off,readonly=on" will not give us writable RAM.
>>
>> The sole user of ROM via memory-backend-file are R/O NVDIMMs, but as we
>> have users (Kata Containers) that rely on the existing behavior --
>> malicious VMs should not be able to consume COW memory for R/O NVDIMMs --
>> we cannot change the semantics of "share=off,readonly=on"
>>
>> So let's add a new "rom" property with on/off/auto values. "auto" is
>> the default and what most people will use: for historical reasons, to not
>> change the old semantics, it defaults to the value of the "readonly"
>> property.
>>
>> For VM templating, one can now use:
>>      -object memory-backend-file,share=off,readonly=on,rom=off,...
>>
>> But we'll disallow:
>>      -object memory-backend-file,share=on,readonly=on,rom=off,...
>> because we would otherwise get an error when trying to mmap the R/O file
>> shared and writable. An explicit error message is cleaner.
>>
>> We will also disallow for now:
>>      -object memory-backend-file,share=off,readonly=off,rom=on,...
>>      -object memory-backend-file,share=on,readonly=off,rom=on,...
>> It's not harmful, but also not really required for now.
>>
>> Alternatives that were abandoned:
>> * Make "unarmed=on" for the NVDIMM set the memory region container
>>    readonly. We would still see a change of ROM->RAM and possibly run
>>    into memslot limits with vhost-user. Further, there might be use cases
>>    for "unarmed=on" that should still allow writing to that memory
>>    (temporary files, system RAM, ...).
>> * Add a new "readonly=on/off/auto" parameter for NVDIMMs. Similar issues
>>    as with "unarmed=on".
>> * Make "readonly" consume "on/off/file" instead of being a 'bool' type.
>>    This would slightly changes the behavior of the "readonly" parameter:
>>    values like true/false (as accepted by a 'bool'type) would no longer be
>>    accepted.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> [...]
> 
>>   static void file_backend_instance_finalize(Object *o)
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index fa3e88c8e6..0cf83c6f39 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -668,6 +668,9 @@
>>   # @readonly: if true, the backing file is opened read-only; if false,
>>   #     it is opened read-write.  (default: false)
>>   #
>> +# @rom: whether to create Read Only Memory (ROM).  If set to 'auto', it
>> +#       defaults to the value of @readonly.  (default: auto, since 8.2)
>> +#
>>   # Since: 2.1
>>   ##
> 
> The commit message discusses how @readonly, @rom and @share interact.
> The doc comments don't, and users have to guess.
> 
> I can see two ways to help users:
> 
> 1. Describe their interaction in full, so users can understand how to
> get from them what they need.
> 
> 2. Provide suitable guidance on how to use them.
> 
>>   { 'struct': 'MemoryBackendFileProperties',
>> @@ -677,7 +680,8 @@
>>               '*discard-data': 'bool',
>>               'mem-path': 'str',
>>               '*pmem': { 'type': 'bool', 'if': 'CONFIG_LIBPMEM' },
>> -            '*readonly': 'bool' } }
>> +            '*readonly': 'bool',
>> +            '*rom': 'OnOffAuto' } }
>>   ##
>>   # @MemoryBackendMemfdProperties:
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 29b98c3d4c..03ce0b0a30 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -4976,7 +4976,7 @@ SRST
>>       they are specified. Note that the 'id' property must be set. These
>>       objects are placed in the '/objects' path.
>>   
>> -    ``-object memory-backend-file,id=id,size=size,mem-path=dir,share=on|off,discard-data=on|off,merge=on|off,dump=on|off,prealloc=on|off,host-nodes=host-nodes,policy=default|preferred|bind|interleave,align=align,offset=offset,readonly=on|off``
>> +    ``-object memory-backend-file,id=id,size=size,mem-path=dir,share=on|off,discard-data=on|off,merge=on|off,dump=on|off,prealloc=on|off,host-nodes=host-nodes,policy=default|preferred|bind|interleave,align=align,offset=offset,readonly=on|off,rom=on|off|auto``
>>           Creates a memory file backend object, which can be used to back
>>           the guest RAM with huge pages.
>>   
>> @@ -5066,6 +5066,14 @@ SRST
>>           The ``readonly`` option specifies whether the backing file is opened
>>           read-only or read-write (default).
>>   
>> +        The ``rom`` option specifies whether to create Read Only Memory (ROM)
>> +        that cannot be modified by the VM. If set to ``on``, the VM cannot
>> +        modify the memory. If set to ``off``, the VM can modify the memory.
>> +        If set to ``auto`` (default), the value of the ``readonly`` property
>> +        is used. This option is primarily helpful for VM templating, where we
>> +        want to open a file readonly (``readonly=on``) and allow private
>> +        modifications of the memory by the VM (``share=off``, ``rom=off``).
>> +
> 
> Here, you provide some guidance.

Is that sufficient in your opinion? Then I could similarly replicate 
(unfortunately) it in the qapi/qom.json doc?

Thanks Markus!

-- 
Cheers,

David / dhildenb


