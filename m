Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A39F67132B3
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 07:57:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2mug-0007mV-7E; Sat, 27 May 2023 01:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2mud-0007lq-I2
 for qemu-devel@nongnu.org; Sat, 27 May 2023 01:56:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2mua-0001mo-9Z
 for qemu-devel@nongnu.org; Sat, 27 May 2023 01:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685166978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H7FL/aweAHjRxh/Z/zGk/YVtmY/rODZMdyXqKTNOR6c=;
 b=et1kh0tiV/hCwo0tw8gTAu5UQe7dJO+T0ek2QYpyuqJelrMpJEXMMTmeboaa7wws71xmfq
 4/yKMSska9MY0jEo8Fn+VFXgdiXqlLHCYA6ml3T6DxIEGvhPiDfo0z7GhsBA0d2am3Bccz
 eh8Db/SngBGvm1zNl5b/oh9mWD+IAQ4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-sto8Hg-DMRKxsYPLSdgiKA-1; Sat, 27 May 2023 01:56:15 -0400
X-MC-Unique: sto8Hg-DMRKxsYPLSdgiKA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB96E3C01C1A;
 Sat, 27 May 2023 05:56:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AAEAA492B0A;
 Sat, 27 May 2023 05:56:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A1D1821E692E; Sat, 27 May 2023 07:56:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org,  Hanna Reitz <hreitz@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Jonathon Jongsma
 <jjongsma@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?M?=
 =?utf-8?Q?arc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,  qemu-block@nongnu.org,  Thomas Huth
 <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 2/2] qapi: add '@fdset' feature for
 BlockdevOptionsVirtioBlkVhostVdpa
References: <20230526150304.158206-1-sgarzare@redhat.com>
 <20230526150304.158206-3-sgarzare@redhat.com>
Date: Sat, 27 May 2023 07:56:13 +0200
In-Reply-To: <20230526150304.158206-3-sgarzare@redhat.com> (Stefano
 Garzarella's message of "Fri, 26 May 2023 17:03:04 +0200")
Message-ID: <87o7m648si.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Stefano Garzarella <sgarzare@redhat.com> writes:

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
>     v4:
>     - added this patch to allow libvirt to discover we support fdset [Markus]
>
>  meson.build          | 4 ++++
>  qapi/block-core.json | 8 +++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/meson.build b/meson.build
> index 78890f0155..8ea911f7b4 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2108,6 +2108,10 @@ config_host_data.set('CONFIG_LZO', lzo.found())
>  config_host_data.set('CONFIG_MPATH', mpathpersist.found())
>  config_host_data.set('CONFIG_MPATH_NEW_API', mpathpersist_new_api)
>  config_host_data.set('CONFIG_BLKIO', blkio.found())
> +if blkio.found()
> +  config_host_data.set('CONFIG_BLKIO_VHOST_VDPA_FD',
> +                       blkio.version().version_compare('>=1.3.0'))
> +endif
>  config_host_data.set('CONFIG_CURL', curl.found())
>  config_host_data.set('CONFIG_CURSES', curses.found())
>  config_host_data.set('CONFIG_GBM', gbm.found())
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 98d9116dae..1538d84ef4 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3955,10 +3955,16 @@
>  #
>  # @path: path to the vhost-vdpa character device.
>  #
> +# Features:
> +# @fdset: Member @path supports the special "/dev/fdset/N" path (since 8.1)

Slightly long line, break it like this:

   # @fdset: Member @path supports the special "/dev/fdset/N" path
   #     since 8.1)

> +#
>  # Since: 7.2
>  ##
>  { 'struct': 'BlockdevOptionsVirtioBlkVhostVdpa',
> -  'data': { 'path': 'str' },
> +  'data': { 'path': { 'type': 'str',
> +                      'features': [ { 'name' :'fdset',
> +                                      'if': 'CONFIG_BLKIO_VHOST_VDPA_FD' } ]
> +            } },
>    'if': 'CONFIG_BLKIO' }
>  
>  ##

Tacking the feature to the member works.

For what it's worth, the existing features serving similar purposes are
all tacked to the command or type.

Do libvirt developers have a preference?


