Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E552D75FA11
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 16:43:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNwlg-0006Sq-Se; Mon, 24 Jul 2023 10:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qNwlf-0006S1-QO
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 10:42:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qNwld-0000ns-Aq
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 10:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690209752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3qoA8dWi6l6BiWJ3O1+wd/pEt8HLLZ9pAPoOUll9qs=;
 b=aGLDsCSpVpt2ArEJEaYXcf/jFpIiWH1PPgL3NdbrPc+bePA7EmdZbDvEld1rOmHQJb2hkI
 +UhtUATxPg+Q0mOMjCJNYy6lRjhJEriO8IUJE5Yt5HQC4J+yUgVlYjLuo1xE2i+RsmXNnp
 F1wrI3MHzGVGDFMSWYytjKk2YOYy/cI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-ETXWBbz1MuS2z-KABop5nQ-1; Mon, 24 Jul 2023 10:42:31 -0400
X-MC-Unique: ETXWBbz1MuS2z-KABop5nQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fc00d7d62cso27522455e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 07:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690209750; x=1690814550;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X3qoA8dWi6l6BiWJ3O1+wd/pEt8HLLZ9pAPoOUll9qs=;
 b=YBILjNQmFLg/RyFLTvGEtHF/Q4fgJlwqBFD3ejpVI5xpO9aw4KPXIiuQWmJWcedkBB
 gGlaH5CDLrtVomtueZw9HbWQR1hyLe29jToPcCPqxW3AoQWGlzBPh654hvmDbWObfs/t
 YuHejGptbysp0nHAh8l+eLNzsEELtOTaGq34QOyvv3CbkUD3nWlLsi4EWLehEFqwYoLw
 MDlU4z1a+NlMI169u8ZY0Ns+3vniNG4admPSFSG+6XnacZufl4hwuIstC9K/1DR2wtOk
 9uS91KFrbFXL2YB0/0EPmHw3d8SU6/c2b/6YBzl9O75ah2Z1x7gYd/pm5IOICE6ZCIZz
 l/NA==
X-Gm-Message-State: ABy/qLYfMOtDKZxIYAArYcRlnhiNPo6Lat9shcDybEJtXyOY5aYL4Ubz
 uQQ9wT70AUI2WskkN3Wv52jnapEya+OxFU+1M/xWoHG2Nf2ZKKWgzR064UKU3UgO2auqcNTtqCP
 hPsHFFH9HC6OQFJw=
X-Received: by 2002:adf:f5ce:0:b0:314:11f3:ca94 with SMTP id
 k14-20020adff5ce000000b0031411f3ca94mr7937477wrp.41.1690209750031; 
 Mon, 24 Jul 2023 07:42:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHqf2TD/6p6tihNvLWvqVNr3SfPQLd/Bedmux89flKEerMe0UI0F/zwkyXSDDAZKZ3WrG39Bg==
X-Received: by 2002:adf:f5ce:0:b0:314:11f3:ca94 with SMTP id
 k14-20020adff5ce000000b0031411f3ca94mr7937463wrp.41.1690209749550; 
 Mon, 24 Jul 2023 07:42:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73d:bb00:91a5:d1c:3a7e:4c77?
 (p200300cbc73dbb0091a50d1c3a7e4c77.dip0.t-ipconnect.de.
 [2003:cb:c73d:bb00:91a5:d1c:3a7e:4c77])
 by smtp.gmail.com with ESMTPSA id
 a15-20020adfeecf000000b00311d8c2561bsm13087030wrp.60.2023.07.24.07.42.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jul 2023 07:42:29 -0700 (PDT)
Message-ID: <7b39c541-6aeb-3dc4-2451-67a6b2ff34c6@redhat.com>
Date: Mon, 24 Jul 2023 16:42:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v6_0/6=5d_Hyper-V_Dynamic_Memory_Protocol_?=
 =?UTF-8?B?ZHJpdmVyIChodi1iYWxsb29uIPCfjojvuI8p?=
Content-Language: en-US
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
References: <cover.1689786474.git.maciej.szmigiero@oracle.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <cover.1689786474.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 20.07.23 12:12, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This is a continuation of the v5 of the patch series located here:
> https://lore.kernel.org/qemu-devel/cover.1686577753.git.maciej.szmigiero@oracle.com/
> 

We're now in QEMU soft-freeze, which means the memslot series might take 
a bit to land. I'm going to follow-up on that soonish.

> 
> Changes from v5:
> * Incorporate David's rework of the driver on top of his virtio-mem-memslots
> patches (specifically, commit 6769107d1a4f), making use of a memory region
> container created upfront to avoid calling memory_device{,_pre}_plug()
> functions from the driver and introducing a driver-specific MemoryDeviceInfo
> sub-type.
> 
> * Include two additional David's memory-device patches necessary for the
> aforementioned conversion in this patch set.
> 
> * Use multiple memslots to cover the hot-add memory backend in order to
> reduce metadata size for the not-yet-hot-added part of the memory backend.
> 
> * Add David's "Co-developed-by:" to patches where he contributed some changes.
> 
> * Use OBJECT_DEFINE_TYPE_WITH_INTERFACES() and OBJECT_DECLARE_SIMPLE_TYPE()
> macros instead of open-coding the equivalent functionality.
> 
> * Drop no longer necessary patch adding g_autoptr() cleanup function for the
> Error type.
> 
> 
> David Hildenbrand (2):
>    memory-device: Support empty memory devices
>    memory-device: Drop size alignment check
> 
> Maciej S. Szmigiero (4):
>    Add Hyper-V Dynamic Memory Protocol definitions
>    qapi: Add HvBalloonDeviceInfo sub-type to MemoryDeviceInfo
>    qapi: Add HV_BALLOON_STATUS_REPORT event
>    Add a Hyper-V Dynamic Memory Protocol driver (hv-balloon)

That is still a gigantic patch. Is there any way to split that into 
reasonable chunks? For example, move the whole hotplug/memslot part into
a dedicated patch?

See below on splitting off the PC changes.

> 
>   Kconfig.host                     |    3 +
>   hw/core/machine-hmp-cmds.c       |   15 +
>   hw/hyperv/Kconfig                |    5 +
>   hw/hyperv/hv-balloon.c           | 2246 ++++++++++++++++++++++++++++++
>   hw/hyperv/meson.build            |    1 +
>   hw/hyperv/trace-events           |   18 +
>   hw/i386/pc.c                     |   22 +
>   hw/mem/memory-device.c           |   45 +-
>   include/hw/hyperv/dynmem-proto.h |  423 ++++++
>   include/hw/hyperv/hv-balloon.h   |   18 +
>   include/hw/mem/memory-device.h   |    7 +-
>   meson.build                      |   28 +-
>   meson_options.txt                |    2 +
>   qapi/machine.json                |   64 +-
>   scripts/meson-buildoptions.sh    |    3 +

It's probably best to separate the actual device implementation from 
wiring up the machine. That is, have a HV_BALLOON_SUPPORTED kconfig
(like VIRTIO_MEM_SUPPORTED), and activate that in a single commit for
PC, where you also modify hw/i386/pc.c.

That commit would be called something like "pc: Support hv-balloon".

-- 
Cheers,

David / dhildenb


