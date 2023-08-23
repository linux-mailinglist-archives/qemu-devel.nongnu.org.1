Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB85E785800
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 14:45:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYnDK-0002Cm-Fk; Wed, 23 Aug 2023 08:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYnDI-0002CG-8t
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 08:43:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYnDG-000601-44
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 08:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692794633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G7lBOr7Z9ztssPGrJXGWNMWDnIWX7JELVGTIhaGVRwY=;
 b=ebDFEr+GD5XKJRRR52jONZ0w4B/2bkhSYJ1aWxk8RnnNXXFHUGeobPROWEMOAoa6MQQR0i
 whCf05IgXwEyPaxJBzbW5IgYGvRK3r0aF/83zLKxFkPfT3MNz/X5yT5/+4Cbk3OmhKaFtg
 a8H+r8W6XU/Mzmd/Yi8DNUQ10czayfo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-nidIQvHFOwqQvk0Lsx8bUw-1; Wed, 23 Aug 2023 08:43:51 -0400
X-MC-Unique: nidIQvHFOwqQvk0Lsx8bUw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fe517ca810so37745095e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 05:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692794630; x=1693399430;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G7lBOr7Z9ztssPGrJXGWNMWDnIWX7JELVGTIhaGVRwY=;
 b=JJkoT7WwtRrL9Dl3176zcNA5clZrrp7TaQy8ftO+0oJ4ZPk7kS4s1YRSyRV9Q5dXQU
 Pt2aN69Y9DuI+Cp3wGno9Vlk6VQN4WRHGvxabPgfZhh2d2vcVVtR0xs2weu4S/U9J84q
 2wwJau4qtQLdu8dUdubyBEFkslFYio5w9IrR1d/1YeFrLF0tTv9rARSZQpsGpldLyUF8
 6DXyCT+sOg7qcyLOju/WXt236KXNLXhssu3F/aFx9Pfu3eMZ0zLCaRrAxZInjJ5whOfB
 h9yo0m78ICAeGdaVezDcTrNb8d7dj7uvQia6JR/pCZxvciD0WOtMmMgkgiYSciUNp+BT
 w4yQ==
X-Gm-Message-State: AOJu0Yz3wpizeqxyMuufosqCAyiGhzunqnURjT2kTz8CX9haL2KB8UZj
 NXQUap/XKrfQZCEcLD1qotv7K8TcXV5ODu3Moda5oteAmYIKs6hwi0AiyhPo/YafxfaSUtsfQUy
 bVV4tCy5pCaaf//c=
X-Received: by 2002:a5d:42ca:0:b0:319:6d03:13ae with SMTP id
 t10-20020a5d42ca000000b003196d0313aemr10183074wrr.55.1692794630375; 
 Wed, 23 Aug 2023 05:43:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOBBW5xDKG5cVlkHwKJtZIGQO0x0QhaA98Jw2TPsQssHhDYBFJcdZ1XKjM1kMzrgP/JZpx0w==
X-Received: by 2002:a5d:42ca:0:b0:319:6d03:13ae with SMTP id
 t10-20020a5d42ca000000b003196d0313aemr10183040wrr.55.1692794629884; 
 Wed, 23 Aug 2023 05:43:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:e700:4d5c:81e2:253e:e397?
 (p200300cbc70ce7004d5c81e2253ee397.dip0.t-ipconnect.de.
 [2003:cb:c70c:e700:4d5c:81e2:253e:e397])
 by smtp.gmail.com with ESMTPSA id
 n16-20020a5d4850000000b003179b3fd837sm18992374wrs.33.2023.08.23.05.43.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 05:43:49 -0700 (PDT)
Message-ID: <049b3601-5d57-d772-8365-a3e9bf9f03bc@redhat.com>
Date: Wed, 23 Aug 2023 14:43:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: ThinerLogoer <logoerthiner1@163.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Greg Kurz <groug@kaod.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230822114504.239505-1-david@redhat.com>
 <20230822114504.239505-4-david@redhat.com>
 <5537a603.478c.18a1da37f4a.Coremail.logoerthiner1@163.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 3/9] backends/hostmem-file: Add "rom" property to
 support VM templating with R/O files
In-Reply-To: <5537a603.478c.18a1da37f4a.Coremail.logoerthiner1@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.684, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 22.08.23 16:26, ThinerLogoer wrote:
> Hello,
> 
> At 2023-08-22 19:44:51, "David Hildenbrand" <david@redhat.com> wrote:
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
>>     -object memory-backend-file,share=off,readonly=on,rom=off,...
>>
>> But we'll disallow:
>>     -object memory-backend-file,share=on,readonly=on,rom=off,...
>> because we would otherwise get an error when trying to mmap the R/O file
>> shared and writable. An explicit error message is cleaner.
>>
>> We will also disallow for now:
>>     -object memory-backend-file,share=off,readonly=off,rom=on,...
>>     -object memory-backend-file,share=on,readonly=off,rom=on,...
>> It's not harmful, but also not really required for now.
>>
>> Alternatives that were abandoned:
>> * Make "unarmed=on" for the NVDIMM set the memory region container
>>   readonly. We would still see a change of ROM->RAM and possibly run
>>   into memslot limits with vhost-user. Further, there might be use cases
>>   for "unarmed=on" that should still allow writing to that memory
>>   (temporary files, system RAM, ...).
>> * Add a new "readonly=on/off/auto" parameter for NVDIMMs. Similar issues
>>   as with "unarmed=on".
>> * Make "readonly" consume "on/off/file" instead of being a 'bool' type.
>>   This would slightly changes the behavior of the "readonly" parameter:
>>   values like true/false (as accepted by a 'bool'type) would no longer be
>>   accepted.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>> backends/hostmem-file.c | 59 ++++++++++++++++++++++++++++++++++++++++-
>> qapi/qom.json           |  6 ++++-
>> qemu-options.hx         | 10 ++++++-
>> 3 files changed, 72 insertions(+), 3 deletions(-)
>>
>> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
>> index ef2d5533af..361d4a8103 100644
>> --- a/backends/hostmem-file.c
>> +++ b/backends/hostmem-file.c
>> @@ -18,6 +18,8 @@
>> #include "sysemu/hostmem.h"
>> #include "qom/object_interfaces.h"
>> #include "qom/object.h"
>> +#include "qapi/visitor.h"
>> +#include "qapi/qapi-visit-common.h"
>>
>> OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendFile, MEMORY_BACKEND_FILE)
>>
>> @@ -31,6 +33,7 @@ struct HostMemoryBackendFile {
>>      bool discard_data;
>>      bool is_pmem;
>>      bool readonly;
>> +    OnOffAuto rom;
>> };
>>
>> static void
>> @@ -53,9 +56,33 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>>          return;
>>      }
>>
>> +    switch (fb->rom) {
>> +    case ON_OFF_AUTO_AUTO:
>> +        /* Traditionally, opening the file readonly always resulted in ROM. */
>> +        fb->rom = fb->readonly ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>> +        break;
>> +    case ON_OFF_AUTO_ON:
>> +        if (!fb->readonly) {
>> +            error_setg(errp, "property 'rom' = 'on' is not supported with"
>> +                       " 'readonly' = 'off'");
>> +            return;
>> +        }
>> +        break;
>> +    case ON_OFF_AUTO_OFF:
>> +        if (fb->readonly && backend->share) {
>> +            error_setg(errp, "property 'rom' = 'off' is incompatible with"
>> +                       " 'readonly' = 'on' and 'share' = 'on'");
>> +            return;
>> +        }
>> +        break;
>> +    default:
>> +        assert(false);
>> +    }
>> +
>>      name = host_memory_backend_get_name(backend);
>>      ram_flags = backend->share ? RAM_SHARED : 0;
>> -    ram_flags |= fb->readonly ? RAM_READONLY | RAM_READONLY_FD : 0;
>> +    ram_flags |= fb->readonly ? RAM_READONLY_FD : 0;
>> +    ram_flags |= fb->rom == ON_OFF_AUTO_ON ? RAM_READONLY : 0;
>>      ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
>>      ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
>>      ram_flags |= RAM_NAMED_FILE;
>> @@ -201,6 +228,32 @@ static void file_memory_backend_set_readonly(Object *obj, bool value,
>>      fb->readonly = value;
>> }
>>
>> +static void file_memory_backend_get_rom(Object *obj, Visitor *v,
>> +                                        const char *name, void *opaque,
>> +                                        Error **errp)
>> +{
>> +    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(obj);
>> +    OnOffAuto rom = fb->rom;
>> +
>> +    visit_type_OnOffAuto(v, name, &rom, errp);
>> +}
>> +
>> +static void file_memory_backend_set_rom(Object *obj, Visitor *v,
>> +                                        const char *name, void *opaque,
>> +                                        Error **errp)
>> +{
>> +    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
>> +    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(obj);
>> +
>> +    if (host_memory_backend_mr_inited(backend)) {
>> +        error_setg(errp, "cannot change property '%s' of %s.", name,
>> +                   object_get_typename(obj));
>> +        return;
>> +    }
>> +
>> +    visit_type_OnOffAuto(v, name, &fb->rom, errp);
>> +}
>> +
>> static void file_backend_unparent(Object *obj)
>> {
>>      HostMemoryBackend *backend = MEMORY_BACKEND(obj);
>> @@ -243,6 +296,10 @@ file_backend_class_init(ObjectClass *oc, void *data)
>>      object_class_property_add_bool(oc, "readonly",
>>          file_memory_backend_get_readonly,
>>          file_memory_backend_set_readonly);
>> +    object_class_property_add(oc, "rom", "OnOffAuto",
>> +        file_memory_backend_get_rom, file_memory_backend_set_rom, NULL, NULL);
>> +    object_class_property_set_description(oc, "rom",
>> +        "Whether to create Read Only Memory (ROM)");
>> }
>>
>> static void file_backend_instance_finalize(Object *o)
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index fa3e88c8e6..0cf83c6f39 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -668,6 +668,9 @@
>> # @readonly: if true, the backing file is opened read-only; if false,
>> #     it is opened read-write.  (default: false)
>> #
>> +# @rom: whether to create Read Only Memory (ROM).  If set to 'auto', it
>> +#       defaults to the value of @readonly.  (default: auto, since 8.2)
>> +#
>> # Since: 2.1
>> ##
>> { 'struct': 'MemoryBackendFileProperties',
>> @@ -677,7 +680,8 @@
>>              '*discard-data': 'bool',
>>              'mem-path': 'str',
>>              '*pmem': { 'type': 'bool', 'if': 'CONFIG_LIBPMEM' },
>> -            '*readonly': 'bool' } }
>> +            '*readonly': 'bool',
>> +            '*rom': 'OnOffAuto' } }
>>
>> ##
>> # @MemoryBackendMemfdProperties:
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 29b98c3d4c..03ce0b0a30 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -4976,7 +4976,7 @@ SRST
>>      they are specified. Note that the 'id' property must be set. These
>>      objects are placed in the '/objects' path.
>>
>> -    ``-object memory-backend-file,id=id,size=size,mem-path=dir,share=on|off,discard-data=on|off,merge=on|off,dump=on|off,prealloc=on|off,host-nodes=host-nodes,policy=default|preferred|bind|interleave,align=align,offset=offset,readonly=on|off``
>> +    ``-object memory-backend-file,id=id,size=size,mem-path=dir,share=on|off,discard-data=on|off,merge=on|off,dump=on|off,prealloc=on|off,host-nodes=host-nodes,policy=default|preferred|bind|interleave,align=align,offset=offset,readonly=on|off,rom=on|off|auto``
>>          Creates a memory file backend object, which can be used to back
>>          the guest RAM with huge pages.
>>
>> @@ -5066,6 +5066,14 @@ SRST
>>          The ``readonly`` option specifies whether the backing file is opened
>>          read-only or read-write (default).
>>
>> +        The ``rom`` option specifies whether to create Read Only Memory (ROM)
>> +        that cannot be modified by the VM. If set to ``on``, the VM cannot
>> +        modify the memory. If set to ``off``, the VM can modify the memory.
>> +        If set to ``auto`` (default), the value of the ``readonly`` property
>> +        is used. This option is primarily helpful for VM templating, where we
>> +        want to open a file readonly (``readonly=on``) and allow private
>> +        modifications of the memory by the VM (``share=off``, ``rom=off``).
>> +
>>      ``-object memory-backend-ram,id=id,merge=on|off,dump=on|off,share=on|off,prealloc=on|off,size=size,host-nodes=host-nodes,policy=default|preferred|bind|interleave``
>>          Creates a memory backend object, which can be used to back the
>>          guest RAM. Memory backend objects offer more control than the
> 
> In one word, I'd suggest advertising the existence of "rom" option more invasively, whenever
> private file mapping is used.
> 
> IMHO you should probably be more invasive here to warn unconditionally when
> the memory backend file is going to be opened readwrite but is mapped non shared.

As Daniel said, we should not add new warnings for sane use cases. But we can indeed give a hint when opening the file failed, see below.

> 
> I as a user find the patch series indeed work functionally when I am aware of the "rom"
> option - but what if I am not aware, the outcome is still that qemu tried
> to open the file readwrite even when it is going to be mapped private.

Yes, the implicit "readonly=off" is active in any case, and we cannot change that due to existing users unfortunately.

> 
> When the file is readonly, the error message is:
> ```
> qemu-system-x86_64: can't open backing store pc.ram for guest RAM: Permission denied
> ```
> 
> This should be probably helpful if qemu found that the file exists as a regular file and
> is mapped private, to say something like
> 
> ```
> qemu-system-x86_64: can't open backing store pc.ram for guest RAM: Permission denied
> tip: mapping is private and ram file is probably readonly, maybe you should append "readonly=on,rom=off"
> to "-object memory-backend-file,..." option list. see documentation xxx for details
> ```

What about the following, if we can indeed open the file R/O and we're dealing witha  private mapping:

qemu-system-x86_64: can't open backing store tmp-file for guest RAM: Permission denied
Consider opening the backing store read-only using '-object memory-backend-file,readonly=on,rom=off,...' (see "VM templating" documentation)

?

-- 
Cheers,

David / dhildenb


