Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0E9712EE1
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 23:21:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2erI-0006vR-Gr; Fri, 26 May 2023 17:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjongsma@redhat.com>)
 id 1q2erF-0006v3-72
 for qemu-devel@nongnu.org; Fri, 26 May 2023 17:20:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjongsma@redhat.com>)
 id 1q2erD-0006cf-In
 for qemu-devel@nongnu.org; Fri, 26 May 2023 17:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685136018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Puogaqt2muWFkB1IT+7h4RLRHxmkEjfWsNpOD1eNeXI=;
 b=jUoFkWFfYG0hPvaRR5TEzDapRcKmnNEfKoZ7i4GePOVSdf0SeW6Z7w05f2I/LMnCw2tfNT
 lMw1+ht5mQnjOpweX2Lj8+p+qg1M/xG0KfgDD57UhhKOBB37bK1+XbgqXsc4BHBLcdkQ0h
 4E5qN3yp72j9iQCHihRmViu+WgZfl5s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-rFdo6JuwOPmx_VkRYsFNJA-1; Fri, 26 May 2023 17:20:16 -0400
X-MC-Unique: rFdo6JuwOPmx_VkRYsFNJA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-75b3b759217so97087585a.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 14:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685136016; x=1687728016;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Puogaqt2muWFkB1IT+7h4RLRHxmkEjfWsNpOD1eNeXI=;
 b=QH6RLiI4NJmCW3BG6ZCyP4l6EaJLRdfBzKNHsMKaFuIXSM+6wJtms/m1vn3nCf8GMv
 TpiC4s2fCpeayd7QLhhgo2jFOC/4yVmXy8ba5ukdwI5CkIcWFu7xxz7VLvLBS4FWuSZP
 F2Gs/MRKTkBKcgZ4SJek1Xe4I0ws5JMuPnvqS2VbyRvdR6vH+hFOVp1qhNP8qTj93q3/
 jUxmp1g00VnglRnY0wOc6Zn6tZLP3CDKACrt0lEYii0Gh5iprmixj3qyJ8muAVtewTjf
 STX6r20sQ9FmSYLJPafgU6GMWhoAVueE8K8AJGPa7IQHp/lM+rygp7NObnog27ux7mvr
 QZzg==
X-Gm-Message-State: AC+VfDwsP7l0F/UfyBNaWq9cER02/RCsEPnxY/yCxtJspi70PGeWtOQy
 GqfA6kp5SfwkGuotg+u4Np9JmdYuMlO1yBVS3TduZKuZbWE49317iAlytv5akV+VxNwPtGdei/a
 NPZ7JPGuUElLG/4M=
X-Received: by 2002:a05:620a:2b8f:b0:75b:23a1:3652 with SMTP id
 dz15-20020a05620a2b8f00b0075b23a13652mr1006938qkb.19.1685136016351; 
 Fri, 26 May 2023 14:20:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ705HbloKD7S8XiMwuPr9udLCgI/vjBAgIly7kikYi2UkdsFXTXxhUYQ/8erPU4DpCyEoitwA==
X-Received: by 2002:a05:620a:2b8f:b0:75b:23a1:3652 with SMTP id
 dz15-20020a05620a2b8f00b0075b23a13652mr1006921qkb.19.1685136016075; 
 Fri, 26 May 2023 14:20:16 -0700 (PDT)
Received: from [192.168.0.245] (207-153-48-138.fttp.usinternet.com.
 [207.153.48.138]) by smtp.gmail.com with ESMTPSA id
 u22-20020a05620a121600b007579ff44f0dsm1421995qkj.124.2023.05.26.14.20.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 14:20:15 -0700 (PDT)
Message-ID: <d3af616d-166f-51e3-b24b-ae36e82c48d4@redhat.com>
Date: Fri, 26 May 2023 16:20:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 2/2] qapi: add '@fdset' feature for
 BlockdevOptionsVirtioBlkVhostVdpa
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20230526150304.158206-1-sgarzare@redhat.com>
 <20230526150304.158206-3-sgarzare@redhat.com>
From: Jonathon Jongsma <jjongsma@redhat.com>
In-Reply-To: <20230526150304.158206-3-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jjongsma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/26/23 10:03 AM, Stefano Garzarella wrote:
> The virtio-blk-vhost-vdpa driver in libblkio 1.3.0 supports the fd
> passing through the new 'fd' property.
> 
> Since now we are using qemu_open() on '@path' if the virtio-blk driver
> supports the fd passing, let's announce it.
> In this way, the management layer can pass the file descriptor of an
> already opened vhost-vdpa character device. This is useful especially
> when the device can only be accessed with certain privileges.
> 
> Add the '@fdset' feature only when the virtio-blk-vhost-vdpa driver
> in libblkio supports it.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> 
> Notes:
>      v4:
>      - added this patch to allow libvirt to discover we support fdset [Markus]
> 
>   meson.build          | 4 ++++
>   qapi/block-core.json | 8 +++++++-
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 78890f0155..8ea911f7b4 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2108,6 +2108,10 @@ config_host_data.set('CONFIG_LZO', lzo.found())
>   config_host_data.set('CONFIG_MPATH', mpathpersist.found())
>   config_host_data.set('CONFIG_MPATH_NEW_API', mpathpersist_new_api)
>   config_host_data.set('CONFIG_BLKIO', blkio.found())
> +if blkio.found()
> +  config_host_data.set('CONFIG_BLKIO_VHOST_VDPA_FD',
> +                       blkio.version().version_compare('>=1.3.0'))
> +endif
>   config_host_data.set('CONFIG_CURL', curl.found())
>   config_host_data.set('CONFIG_CURSES', curses.found())
>   config_host_data.set('CONFIG_GBM', gbm.found())
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 98d9116dae..1538d84ef4 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3955,10 +3955,16 @@
>   #
>   # @path: path to the vhost-vdpa character device.
>   #
> +# Features:
> +# @fdset: Member @path supports the special "/dev/fdset/N" path (since 8.1)
> +#
>   # Since: 7.2
>   ##
>   { 'struct': 'BlockdevOptionsVirtioBlkVhostVdpa',
> -  'data': { 'path': 'str' },
> +  'data': { 'path': { 'type': 'str',
> +                      'features': [ { 'name' :'fdset',
> +                                      'if': 'CONFIG_BLKIO_VHOST_VDPA_FD' } ]
> +            } },
>     'if': 'CONFIG_BLKIO' }
>   
>   ##


Take this for what it's worth and do what's best for qemu, but... It's 
easier for libvirt if the 'features' are on the object rather than on 
the 'path' member. Our schema parsing code already supports object 
features but does not yet support features on builtin types.

i.e. something like this just works without any refactoring in libvirt:

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1538d84ef4..78cfd10cdb 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3961,11 +3961,11 @@
  # Since: 7.2
  ##
  { 'struct': 'BlockdevOptionsVirtioBlkVhostVdpa',
-  'data': { 'path': { 'type': 'str',
-                      'features': [ { 'name' :'fdset',
-                                      'if': 
'CONFIG_BLKIO_VHOST_VDPA_FD' } ]
-            } },
-  'if': 'CONFIG_BLKIO' }
+  'data': { 'path': 'str' },
+  'features': [ { 'name' :'fdset',
+                'if': 'CONFIG_BLKIO_VHOST_VDPA_FD' } ],
+  'if': 'CONFIG_BLKIO'
+ }

  ##
  # @IscsiTransport:



