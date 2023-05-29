Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0E6714594
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 09:37:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3XQg-0008Rq-37; Mon, 29 May 2023 03:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q3XQe-0008RK-0S
 for qemu-devel@nongnu.org; Mon, 29 May 2023 03:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q3XQb-00016U-FQ
 for qemu-devel@nongnu.org; Mon, 29 May 2023 03:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685345788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=se1jIDDwnJb82RjKg3vTJIFViYR3qAGDdn7Pzw8EWwY=;
 b=CTZzAqcwBMXY3x+ajQ2eJ38f83PeMVq66mUfm3M2idcllBgUXMTarT9Wo171LEjDMbSUXf
 StzlBrwuVpTx4XohX8zINTed9SzgB7X9zU1rhPbtkjLd0M0pD/mSlfVkjgrwXEqEzOU6Ni
 6swaYD4sqxyj3X6OdunieaSsmXfgq5U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-GEwcRYmqP8iOTAYHzioGdw-1; Mon, 29 May 2023 03:36:27 -0400
X-MC-Unique: GEwcRYmqP8iOTAYHzioGdw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f5fc8581a9so12085645e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 00:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685345786; x=1687937786;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=se1jIDDwnJb82RjKg3vTJIFViYR3qAGDdn7Pzw8EWwY=;
 b=USuo+GocoHFISCVmtJv9lfZbxUx/VFYDKxeudo/lRtxVaxyBtFPZt6rGOcYCgsNKbz
 WB8aJY9Jl3DFf42rl6ZaXCM8CPyDWkEtQUjAcj65coek7EUoTQohLntsPJyQSEayZW6O
 Q0svxBqZw5NojEDICNDV4P7AieDJEXddLwFkue8qjgL1SYW6t40z4OHJMjTPboSjkKqm
 XorVNjHBDLvklNl5DE+nU40gKgkXHp4QgLi6hyJ432Rep697GK3z6MOuWgzz0+K/ktYW
 E6J3RKdYokDJ1VMuCNtbh16LUKpsE9ZV7pygsE01noGlFgOuZcHyQdxs57++F9lQVUAH
 8DlA==
X-Gm-Message-State: AC+VfDyYqne0R+C5kiU6plpQFBmiA1JvwpWn/8T6Y9yRsJtXDyjsVW81
 sVxwbi4yHwxI/2/uMZXCAK+EFGh0iJPpfxcpoIlxk0S2e7fpkmGDRfL/PtlYtCnFszC0JMd9DSL
 DblcH1mxDX1jo9x4=
X-Received: by 2002:a05:600c:293:b0:3f0:b1c9:25d4 with SMTP id
 19-20020a05600c029300b003f0b1c925d4mr7346700wmk.21.1685345785965; 
 Mon, 29 May 2023 00:36:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ojvUs8Hy8c9sCMKxkZjlsTpqJa7IDm1eZWA4FZVJ8admyEtNUOvf75X7Hn6ba0urFVS9YOg==
X-Received: by 2002:a05:600c:293:b0:3f0:b1c9:25d4 with SMTP id
 19-20020a05600c029300b003f0b1c925d4mr7346680wmk.21.1685345785675; 
 Mon, 29 May 2023 00:36:25 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 m8-20020a7bce08000000b003f17af4c4e0sm16934582wmc.9.2023.05.29.00.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 May 2023 00:36:25 -0700 (PDT)
Date: Mon, 29 May 2023 09:36:20 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jonathon Jongsma <jjongsma@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 2/2] qapi: add '@fdset' feature for
 BlockdevOptionsVirtioBlkVhostVdpa
Message-ID: <igbvuv35h2xfcsozeefsauaxf3iudv75hejc6rrnunx4jfxfgt@otkhmxnupgrl>
References: <20230526150304.158206-1-sgarzare@redhat.com>
 <20230526150304.158206-3-sgarzare@redhat.com>
 <87o7m648si.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87o7m648si.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sat, May 27, 2023 at 07:56:13AM +0200, Markus Armbruster wrote:
>Stefano Garzarella <sgarzare@redhat.com> writes:
>
>> The virtio-blk-vhost-vdpa driver in libblkio 1.3.0 supports the fd
>> passing through the new 'fd' property.
>>
>> Since now we are using qemu_open() on '@path' if the virtio-blk driver
>> supports the fd passing, let's announce it.
>> In this way, the management layer can pass the file descriptor of an
>> already opened vhost-vdpa character device. This is useful especially
>> when the device can only be accessed with certain privileges.
>>
>> Add the '@fdset' feature only when the virtio-blk-vhost-vdpa driver
>> in libblkio supports it.
>>
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>
>> Notes:
>>     v4:
>>     - added this patch to allow libvirt to discover we support fdset [Markus]
>>
>>  meson.build          | 4 ++++
>>  qapi/block-core.json | 8 +++++++-
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/meson.build b/meson.build
>> index 78890f0155..8ea911f7b4 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -2108,6 +2108,10 @@ config_host_data.set('CONFIG_LZO', lzo.found())
>>  config_host_data.set('CONFIG_MPATH', mpathpersist.found())
>>  config_host_data.set('CONFIG_MPATH_NEW_API', mpathpersist_new_api)
>>  config_host_data.set('CONFIG_BLKIO', blkio.found())
>> +if blkio.found()
>> +  config_host_data.set('CONFIG_BLKIO_VHOST_VDPA_FD',
>> +                       blkio.version().version_compare('>=1.3.0'))
>> +endif
>>  config_host_data.set('CONFIG_CURL', curl.found())
>>  config_host_data.set('CONFIG_CURSES', curses.found())
>>  config_host_data.set('CONFIG_GBM', gbm.found())
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 98d9116dae..1538d84ef4 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -3955,10 +3955,16 @@
>>  #
>>  # @path: path to the vhost-vdpa character device.
>>  #
>> +# Features:
>> +# @fdset: Member @path supports the special "/dev/fdset/N" path (since 8.1)
>
>Slightly long line, break it like this:
>
>   # @fdset: Member @path supports the special "/dev/fdset/N" path
>   #     since 8.1)
>

Sure, I'll fix it!
For the future, what is the maximum column?

>> +#
>>  # Since: 7.2
>>  ##
>>  { 'struct': 'BlockdevOptionsVirtioBlkVhostVdpa',
>> -  'data': { 'path': 'str' },
>> +  'data': { 'path': { 'type': 'str',
>> +                      'features': [ { 'name' :'fdset',
>> +                                      'if': 'CONFIG_BLKIO_VHOST_VDPA_FD' } ]
>> +            } },
>>    'if': 'CONFIG_BLKIO' }
>>
>>  ##
>
>Tacking the feature to the member works.
>
>For what it's worth, the existing features serving similar purposes are
>all tacked to the command or type.
>
>Do libvirt developers have a preference?
>

Yep, Jonathon pointed out that for libvirt it's better to move it to the
object level, so I'll do that in the next version.

Thanks,
Stefano


