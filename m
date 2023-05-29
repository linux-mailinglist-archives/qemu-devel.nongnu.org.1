Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAED5714585
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 09:31:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3XKM-0006zw-U3; Mon, 29 May 2023 03:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q3XKJ-0006zB-TN
 for qemu-devel@nongnu.org; Mon, 29 May 2023 03:29:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q3XKI-0007UT-47
 for qemu-devel@nongnu.org; Mon, 29 May 2023 03:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685345396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DHjqh8llwBaoxMwZHs8cm6eGqUObNr/2SbmnsvJ7iJQ=;
 b=ecFQY4e+qQTzB/89Yf+Pw1Of3YBqsYo14neVIj2JLzJIPxbSkM0NoljKmzk3ahOawL4m0e
 NAWsHF5HNyn3kNwWXGR9TV8U6Kfa60NpN/3mKkafaXG5IKUPddmtI/V7hJSKCjW99Otm3q
 3iL4SFoaJbIB0RwIHj90DW7HSerj/L8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-8b36NOLhN82XtROkVtJQXQ-1; Mon, 29 May 2023 03:29:54 -0400
X-MC-Unique: 8b36NOLhN82XtROkVtJQXQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f60481749eso15767815e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 00:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685345393; x=1687937393;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DHjqh8llwBaoxMwZHs8cm6eGqUObNr/2SbmnsvJ7iJQ=;
 b=GntoRXzn7vYYofAN930+WFGUW6LdPSNUYIV7sDhEXHZoPg2V2Kx83ziHhRbQreu2Up
 J21o27pFPUBW5svK6ZzSowBWLK3Z+x68be/lMMRE4IJzP5BbCw8vnvgmx4wWYY12iYtr
 5B2MuR27a8UhfKw3txoWW3ZbLH3sUcEYj09znPn8PGk5yBVVNKFaMgjRS1yf3jhaeZSW
 gcMGX2gD6FNyjvzGNoH7UqrJOO3WXRd0s+2vEWgvoitdDwyZaHPlVnN3ILslkW0WU7xr
 M4me2QGhspf0MO2Oyya4AgF3Lgk5G1OxAjWwILhSvtE+sxVRbdTbWxLH2hvZZmhaIlmx
 65aA==
X-Gm-Message-State: AC+VfDyZqfoS6jFFAR7dvP5rMsQxOARQa8DzHcALM4owJ0L24dX3msiW
 TH0toOweZ+g20w0p4rEEj1/ES15Mj4345jcTgzInabcbJU6gJsM7a2SYN5AnLLiYDy2i2t7Dsmu
 tSUBj06YCYeTLySE=
X-Received: by 2002:a05:600c:2e0c:b0:3f4:255e:e375 with SMTP id
 o12-20020a05600c2e0c00b003f4255ee375mr5852899wmf.9.1685345393081; 
 Mon, 29 May 2023 00:29:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4N8qMLWNrHbH3uXQKZ4p3M9Q+1iY0XThjmNoIyoyld6HpRojyj/g4R2TBVJIffbqW27ToIFg==
X-Received: by 2002:a05:600c:2e0c:b0:3f4:255e:e375 with SMTP id
 o12-20020a05600c2e0c00b003f4255ee375mr5852885wmf.9.1685345392743; 
 Mon, 29 May 2023 00:29:52 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 f9-20020a1c6a09000000b003f4272c2d0csm13188942wmc.36.2023.05.29.00.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 May 2023 00:29:51 -0700 (PDT)
Date: Mon, 29 May 2023 09:29:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jonathon Jongsma <jjongsma@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 2/2] qapi: add '@fdset' feature for
 BlockdevOptionsVirtioBlkVhostVdpa
Message-ID: <fkwshw6kunoqgzb25sjxpr6b5dtoknuombf5mqzgrwd6446xd4@hqfoz6rbukyt>
References: <20230526150304.158206-1-sgarzare@redhat.com>
 <20230526150304.158206-3-sgarzare@redhat.com>
 <d3af616d-166f-51e3-b24b-ae36e82c48d4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d3af616d-166f-51e3-b24b-ae36e82c48d4@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, May 26, 2023 at 04:20:14PM -0500, Jonathon Jongsma wrote:
>On 5/26/23 10:03 AM, Stefano Garzarella wrote:
>>The virtio-blk-vhost-vdpa driver in libblkio 1.3.0 supports the fd
>>passing through the new 'fd' property.
>>
>>Since now we are using qemu_open() on '@path' if the virtio-blk driver
>>supports the fd passing, let's announce it.
>>In this way, the management layer can pass the file descriptor of an
>>already opened vhost-vdpa character device. This is useful especially
>>when the device can only be accessed with certain privileges.
>>
>>Add the '@fdset' feature only when the virtio-blk-vhost-vdpa driver
>>in libblkio supports it.
>>
>>Suggested-by: Markus Armbruster <armbru@redhat.com>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>
>>Notes:
>>     v4:
>>     - added this patch to allow libvirt to discover we support fdset [Markus]
>>
>>  meson.build          | 4 ++++
>>  qapi/block-core.json | 8 +++++++-
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>
>>diff --git a/meson.build b/meson.build
>>index 78890f0155..8ea911f7b4 100644
>>--- a/meson.build
>>+++ b/meson.build
>>@@ -2108,6 +2108,10 @@ config_host_data.set('CONFIG_LZO', lzo.found())
>>  config_host_data.set('CONFIG_MPATH', mpathpersist.found())
>>  config_host_data.set('CONFIG_MPATH_NEW_API', mpathpersist_new_api)
>>  config_host_data.set('CONFIG_BLKIO', blkio.found())
>>+if blkio.found()
>>+  config_host_data.set('CONFIG_BLKIO_VHOST_VDPA_FD',
>>+                       blkio.version().version_compare('>=1.3.0'))
>>+endif
>>  config_host_data.set('CONFIG_CURL', curl.found())
>>  config_host_data.set('CONFIG_CURSES', curses.found())
>>  config_host_data.set('CONFIG_GBM', gbm.found())
>>diff --git a/qapi/block-core.json b/qapi/block-core.json
>>index 98d9116dae..1538d84ef4 100644
>>--- a/qapi/block-core.json
>>+++ b/qapi/block-core.json
>>@@ -3955,10 +3955,16 @@
>>  #
>>  # @path: path to the vhost-vdpa character device.
>>  #
>>+# Features:
>>+# @fdset: Member @path supports the special "/dev/fdset/N" path (since 8.1)
>>+#
>>  # Since: 7.2
>>  ##
>>  { 'struct': 'BlockdevOptionsVirtioBlkVhostVdpa',
>>-  'data': { 'path': 'str' },
>>+  'data': { 'path': { 'type': 'str',
>>+                      'features': [ { 'name' :'fdset',
>>+                                      'if': 'CONFIG_BLKIO_VHOST_VDPA_FD' } ]
>>+            } },
>>    'if': 'CONFIG_BLKIO' }
>>  ##
>
>
>Take this for what it's worth and do what's best for qemu, but... It's 
>easier for libvirt if the 'features' are on the object rather than on 
>the 'path' member. Our schema parsing code already supports object 
>features but does not yet support features on builtin types.

I had done it that way in the first instance :-), then I saw that the 
members themselves could have their own functionality, and it seemed 
better.

However I agree that if it's easier for libvirt, then better to move the 
feature to the whole object.

I'll change that in v5.

Thanks,
Stefano

>
>i.e. something like this just works without any refactoring in libvirt:
>
>diff --git a/qapi/block-core.json b/qapi/block-core.json
>index 1538d84ef4..78cfd10cdb 100644
>--- a/qapi/block-core.json
>+++ b/qapi/block-core.json
>@@ -3961,11 +3961,11 @@
> # Since: 7.2
> ##
> { 'struct': 'BlockdevOptionsVirtioBlkVhostVdpa',
>-  'data': { 'path': { 'type': 'str',
>-                      'features': [ { 'name' :'fdset',
>-                                      'if': 
>'CONFIG_BLKIO_VHOST_VDPA_FD' } ]
>-            } },
>-  'if': 'CONFIG_BLKIO' }
>+  'data': { 'path': 'str' },
>+  'features': [ { 'name' :'fdset',
>+                'if': 'CONFIG_BLKIO_VHOST_VDPA_FD' } ],
>+  'if': 'CONFIG_BLKIO'
>+ }
>
> ##
> # @IscsiTransport:
>
>


