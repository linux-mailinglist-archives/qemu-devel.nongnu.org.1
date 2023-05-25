Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B556971161C
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 21:00:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2GBH-0004VL-Gc; Thu, 25 May 2023 14:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjongsma@redhat.com>)
 id 1q2GBF-0004UJ-Ep
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjongsma@redhat.com>)
 id 1q2GBC-0008Bv-I4
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685041157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kvGeojBSZaBmWuh5uZrNoINOrr1VgLQ9OyE8iEk7crA=;
 b=DYLeNPnywCKKCt7MlHXmbi1eJb0sgKoby7xF4ld3hre8dIWxkxAsMklaIFCPBw9lMQCqoT
 6hu/uBh/rTq8CS0iiGNxJhoqDe2iYAavvUPBHZlGUuFmCBrmvrNgn/SWGePH14vkjcqYId
 JDqiGXHSKX10U5doNKM5gkrL1xECVk4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-8bRi4ZS9NV6nLnsPpbm-zA-1; Thu, 25 May 2023 14:59:16 -0400
X-MC-Unique: 8bRi4ZS9NV6nLnsPpbm-zA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-3f687fcbf8bso12446871cf.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685041156; x=1687633156;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kvGeojBSZaBmWuh5uZrNoINOrr1VgLQ9OyE8iEk7crA=;
 b=RN0JCPUgJLlv15GahbUEB9TbojYJUpXAD6JLJ/Ref+p+o/K8SbYel1DjLTOsSb6LNT
 6IEbE4xsOwRB7KR8RnQBI603ir2BJJ/F8MkhDSgqW62qgrApXaJHojh7MJuzgBWyNPfL
 Npqas8EemIhSEafxQFsMKHVwsGazbY7WMgo+Z+8l+Ym612ukSUvNW8KJUQR5KFloD0ny
 IRpo1syqDwsaawQc2sfSNZ+tS/VifgiH5xg5CGfXbzOgDPJW7Aka5CIIQJXzuzVGuCyk
 ACaTEZjoLfz/KqqgYhCTVLo2BM+5GYIgtUh3wG/rXkHU5NGGOil1h2fhkSY7lWzgFNa6
 4Eiw==
X-Gm-Message-State: AC+VfDyNjSlQaPkKAyQxUrVutzXnIeSZ9VY8PRXjGtj1pvcut3Ji+NT+
 QxiOGs2MIUTYuF/17xOYkKkj86v5QCnQEAv0HXs2jmixGnkxKxGagD2WDRYPjZj+fffgvXlKIY8
 +ExQoPQi7aHO486o=
X-Received: by 2002:ac8:5cc2:0:b0:3ef:40d2:60f1 with SMTP id
 s2-20020ac85cc2000000b003ef40d260f1mr748591qta.36.1685041155845; 
 Thu, 25 May 2023 11:59:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ51Wk/OJYKfgivBjE4Hd+LhQ1I2u/k/UVULtvhdp+KqFEbNMzV+JnMsPgJRxVWuHTVVrMOPqg==
X-Received: by 2002:ac8:5cc2:0:b0:3ef:40d2:60f1 with SMTP id
 s2-20020ac85cc2000000b003ef40d260f1mr748577qta.36.1685041155561; 
 Thu, 25 May 2023 11:59:15 -0700 (PDT)
Received: from [192.168.0.245] (207-153-48-138.fttp.usinternet.com.
 [207.153.48.138]) by smtp.gmail.com with ESMTPSA id
 gd22-20020a05622a5c1600b003f0af201a2dsm620204qtb.81.2023.05.25.11.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 11:59:14 -0700 (PDT)
Message-ID: <ce1b4fc7-0e8e-55e0-c8c3-99a69296a3ec@redhat.com>
Date: Thu, 25 May 2023 13:59:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/1] block/blkio: use qemu_open() to support fd passing
 for virtio-blk
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>, sgarzare@redhat.com
References: <20230511091527.46620-1-sgarzare@redhat.com>
 <20230511091527.46620-2-sgarzare@redhat.com>
 <1a89ee2e-2368-4051-f9ec-018641721484@redhat.com>
 <q2odwrndg3gt6z25hdxb3t2xxavd64hkp4b23zhzycevhrwx64@25r5r6sidyok>
 <e8fcb4cf-3667-2bdf-a163-d81bdfb71bfa@redhat.com>
 <vcinivshe3tf4iod7ys236fq5ovzhyhei5zvo2uf636fpb2vtr@swcn25px5h5z>
 <20230517143023.GA65838@fedora> <87edn4i7ro.fsf@pond.sub.org>
From: Jonathon Jongsma <jjongsma@redhat.com>
In-Reply-To: <87edn4i7ro.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jjongsma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/25/23 1:30 PM, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
> 
>> On Wed, May 17, 2023 at 09:19:26AM +0200, Stefano Garzarella wrote:
>>> CCing Markus for some advice.
>>>
>>> On Tue, May 16, 2023 at 11:04:21AM -0500, Jonathon Jongsma wrote:
> 
> [...]
> 
>>>> I need some way to determine that the particular qemu binary can accept
>>>> a /dev/fdset/ path for vdpa block devices. libvirt uses a variety of
>>>> methods to determine capabilities for a given qemu binary, including
>>>> querying the qmp schema, commands, object types, specific device/object
>>>> properties, etc. For example, right now I can determine (via querying
>>>> the qmp schema) whether virtio-blk-vhost-vdpa is a valid type for the
>>>> blockdev-add command by querying the qmp schema. I need something more
>>>> than that but I'm not sure how to do it without introducing a separate
>>>> 'fd' parameter. Any ideas?
>>>
>>> The only thing I can think of is to make a mix between v2 and v3. I mean add
>>> both the new `fd` parameter, and support qemu_open() on `path`.
>>>
>>> That way libvirt (or other users) can check that fd passing is supported and
>>> use `fd` or fdset with `path`.
>>>
>>> Obviously I would have liked to implement only one of the two methods, but
>>> if this helps, maybe it makes sense to support both.
>>>
>>> What do you think?
>>
>> Markus: Is a preferred way to make this new path handling behavior
>> introspectable? I vaguely remember a way for QMP clients to query
>> strings that describe QMP behavior that's not otherwise
>> introspectable...
> 
> Let me try to answer this without first reading the entire thread.
> 
> QMP introspection lets you find out things like whether a command is
> there, or whether an an argument is there, and what its type is.
> Suffices most of the time.
> 
> However, behavior can certainly change while the introspection data
> remains the same.  When a management application needs to know about the
> change, we better expose the change in introspection somehow.
> 
> The "obvious" way to do that would be some arbitrary change that *is*
> visible in introspection.  Meh.
> 
> The modern way is to add a suitable "feature".
> docs/devel/qapi-code-gen.rst:
> 
>      Features
>      --------
> 
>      Syntax::
> 
>          FEATURES = [ FEATURE, ... ]
>          FEATURE = STRING
>                  | { 'name': STRING, '*if': COND }
> 
>      Sometimes, the behaviour of QEMU changes compatibly, but without a
>      change in the QMP syntax (usually by allowing values or operations
>      that previously resulted in an error).  QMP clients may still need to
>      know whether the extension is available.
> 
>      For this purpose, a list of features can be specified for definitions,
>      enumeration values, and struct members.  Each feature list member can
>      either be ``{ 'name': STRING, '*if': COND }``, or STRING, which is
>      shorthand for ``{ 'name': STRING }``.
> 
>      The optional 'if' member specifies a conditional.  See `Configuring
>      the schema`_ below for more on this.
> 
>      Example::
> 
>       { 'struct': 'TestType',
>         'data': { 'number': 'int' },
>         'features': [ 'allow-negative-numbers' ] }
> 
>      The feature strings are exposed to clients in introspection, as
>      explained in section `Client JSON Protocol introspection`_.
> 
>      Intended use is to have each feature string signal that this build of
>      QEMU shows a certain behaviour.
> 
> For a real example, see commit c6bdc312f30 (qapi: Add
> '@allow-write-only-overlay' feature for 'blockdev-snapshot').
> 
> Does this answer your question?
> 

That sounds perfect for libvirt's needs.

Jonathon


