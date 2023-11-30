Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F647FEB02
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 09:41:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8car-0002GN-6d; Thu, 30 Nov 2023 03:40:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r8cao-0002FP-VS
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 03:40:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r8cam-0001Ak-Ln
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 03:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701333615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VzsQzG4q/80sCSOgeUwPHpjOaKmbcvlsiYpOkmy+svU=;
 b=AvS5PbsWLviuCrHGkNDqhw/K+CTSlIhCjFVaMY31OSFQJw1bgc5Hn0K8rrqBxO8Cpxbt1o
 lfbR0ztNIQSntSpj89BU8hS5/SxbT55zrljyBiRadcS3ugtikABVULyMifkTwIhufBcF2e
 vBF9axj1KFlkGX3LXi/SNHQ6xx5spjo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-_4innWqtN0iOj2vQLuLC0g-1; Thu, 30 Nov 2023 03:40:11 -0500
X-MC-Unique: _4innWqtN0iOj2vQLuLC0g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC2EE811002;
 Thu, 30 Nov 2023 08:40:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD1F1112130D;
 Thu, 30 Nov 2023 08:40:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9B2E421E6A1F; Thu, 30 Nov 2023 09:40:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org,  dmitry.fomichev@wdc.com,  qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>,  dlemoal@kernel.org,  hare@suse.de,  Hanna
 Reitz <hreitz@redhat.com>,  stefanha@redhat.com,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v6 2/4] qcow2: add configurations for zoned format
 extension
References: <20231127043703.49489-1-faithilikerun@gmail.com>
 <20231127043703.49489-3-faithilikerun@gmail.com>
Date: Thu, 30 Nov 2023 09:40:09 +0100
In-Reply-To: <20231127043703.49489-3-faithilikerun@gmail.com> (Sam Li's
 message of "Mon, 27 Nov 2023 12:37:01 +0800")
Message-ID: <87bkbbeis6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Sam Li <faithilikerun@gmail.com> writes:

> To configure the zoned format feature on the qcow2 driver, it
> requires settings as: the device size, zone model, zone size,
> zone capacity, number of conventional zones, limits on zone
> resources (max append bytes, max open zones, and max_active_zones).
>
> To create a qcow2 image with zoned format feature, use command like
> this:
> $path/to/qemu-img create -f qcow2 zbc.qcow2 -o size=768M

I'd omit $path/to/

> -o zone.size=64M -o zone.capacity=64M -o zone.conventional_zones=0
> -o zone.max_append_bytes=4096 -o zone.max_open_zones=10
> -o zone.max_active_zones=12 -o zone.mode=host-managed

Suggest to add \ like this:

  qemu-img create -f qcow2 zbc.qcow2 -o size=768M \
  -o zone.size=64M -o zone.capacity=64M -o zone.conventional_zones=0 \
  -o zone.max_append_bytes=4096 -o zone.max_open_zones=10 \
  -o zone.max_active_zones=12 -o zone.mode=host-managed

>
> Signed-off-by: Sam Li <faithilikerun@gmail.com>

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index ca390c5700..ef98dc83a0 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -5038,6 +5038,64 @@
>  { 'enum': 'Qcow2CompressionType',
>    'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
>  
> +##
> +# @Qcow2ZoneModel:
> +#
> +# Zoned device model used in qcow2 image file
> +#
> +# @host-managed: host-managed model only allows sequential write over the

Suggest "the host-managed model ..."

> +#     device zones
> +#
> +# Since 8.2
> +##
> +{ 'enum': 'Qcow2ZoneModel',
> +  'data': [ 'host-managed'] }
> +
> +##
> +# @Qcow2ZoneHostManaged:
> +#
> +# The host-managed zone model.  It only allows sequential writes.
> +#
> +# @size: Total number of bytes within zones
> +#
> +# @capacity: The number of usable logical blocks within zones
> +#     in bytes.  A zone capacity is always smaller or equal to the
> +#     zone size
> +#
> +# @conventional-zones: The number of conventional zones of the
> +#     zoned device
> +#
> +# @max-open-zones: The maximal number of open zones
> +#
> +# @max-active-zones: The maximal number of zones in the implicit
> +#     open, explicit open or closed state
> +#
> +# @max-append-bytes: The maximal number of bytes of a zone
> +#     append request that can be issued to the device.  It must be
> +#     512-byte aligned

Missing period at the end.

For all the optional members: what's the default?

> +#
> +# Since 8.2
> +##
> +{ 'struct': 'Qcow2ZoneHostManaged',
> +  'data': { '*size':          'size',
> +            '*capacity':      'size',
> +            '*conventional-zones': 'uint32',
> +            '*max-open-zones':     'uint32',
> +            '*max-active-zones':   'uint32',
> +            '*max-append-bytes':   'uint32' } }

Why isn't @max-append-bytes 'size'?  It's a byte count...

> +
> +##
> +# @Qcow2ZoneCreateOptions:
> +#
> +# The zone device model for the qcow2 image.
> +#
> +# Since 8.2
> +##
> +{ 'union': 'Qcow2ZoneCreateOptions',
> +  'base': { 'mode': 'Qcow2ZoneModel' },
> +  'discriminator': 'mode',
> +  'data': { 'host-managed': 'Qcow2ZoneHostManaged' } }
> +
>  ##
>  # @BlockdevCreateOptionsQcow2:
>  #
> @@ -5080,6 +5138,8 @@
>  # @compression-type: The image cluster compression method
>  #     (default: zlib, since 5.1)
>  #
> +# @zone: @Qcow2ZoneCreateOptions.  The zone device model modes (since 8.2)

Don't put the type into the description like that, because it comes out
like

    "zone": "Qcow2ZoneCreateOptions" (optional)
       "Qcow2ZoneCreateOptions".  The zone device model modes (since 8.2)

in formatted documentation.

Let's spell out the default: the device is not zoned.

> +#
>  # Since: 2.12
>  ##
>  { 'struct': 'BlockdevCreateOptionsQcow2',
> @@ -5096,7 +5156,8 @@
>              '*preallocation':   'PreallocMode',
>              '*lazy-refcounts':  'bool',
>              '*refcount-bits':   'int',
> -            '*compression-type':'Qcow2CompressionType' } }
> +            '*compression-type':'Qcow2CompressionType',
> +            '*zone':            'Qcow2ZoneCreateOptions' } }
>  
>  ##
>  # @BlockdevCreateOptionsQed:


