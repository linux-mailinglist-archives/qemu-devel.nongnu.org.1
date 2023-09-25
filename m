Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E44BE7AD897
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 15:07:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qklHD-0001Ep-5N; Mon, 25 Sep 2023 09:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qklH9-0001E5-VY
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 09:05:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qklH8-0004E8-EV
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 09:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695647121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/tVA5KOYNJLX/kNTey4D0GtPzY9dAgsMg2kQFHl0IhI=;
 b=ADRp4MaCHt24W6K2Uiyl+xbT0d+gUAURat3raSlN2ra7T/7Lf2B3Q4QclL57NAI0hASR3v
 LWL0wuYgjnVm2yMTGeFsMK/+IEKmFEk4bfhSyBUosllUTWzeE7L7+ZnlPjqXjPoWLPeffm
 8H+be+j4ApuvGuuBpmYukAux8bBvL/o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-684-thnFv8YTOdGXUCiMDfoUUg-1; Mon, 25 Sep 2023 09:05:18 -0400
X-MC-Unique: thnFv8YTOdGXUCiMDfoUUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F24FF185A790;
 Mon, 25 Sep 2023 13:05:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98B8540C2064;
 Mon, 25 Sep 2023 13:05:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A4A7521E6900; Mon, 25 Sep 2023 15:05:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org,  dmitry.fomichev@wdc.com,  Eric Blake
 <eblake@redhat.com>,  dlemoal@kernel.org,  Hanna Reitz
 <hreitz@redhat.com>,  stefanha@redhat.com,  hare@suse.de,  Kevin Wolf
 <kwolf@redhat.com>,  qemu-block@nongnu.org
Subject: Re: [PATCH v4 2/4] qcow2: add configurations for zoned format
 extension
References: <20230918095313.5492-1-faithilikerun@gmail.com>
 <20230918095313.5492-3-faithilikerun@gmail.com>
Date: Mon, 25 Sep 2023 15:05:16 +0200
In-Reply-To: <20230918095313.5492-3-faithilikerun@gmail.com> (Sam Li's message
 of "Mon, 18 Sep 2023 17:53:11 +0800")
Message-ID: <87a5tatncj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> resources (max append sectors, max open zones, and max_active_zones).
>
> To create a qcow2 file with zoned format, use command like this:
> $ qemu-img create -f qcow2 test.qcow2 -o size=768M -o
> zone_size=64M -o zone_capacity=64M -o nr_conv_zones=0 -o
> max_append_sectors=512 -o max_open_zones=0 -o max_active_zones=0
> -o zone_model=1
>
> Signed-off-by: Sam Li <faithilikerun@gmail.com>

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 2b1d493d6e..2aad82c399 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -5021,6 +5021,27 @@
>  # @compression-type: The image cluster compression method
>  #     (default: zlib, since 5.1)
>  #
> +# @zone-model: Zoned device model, 1 for host-managed and 0 for
> +#     non-zoned devices (default: 0, since 8.2)

Shouldn't this be a QAPI enum rather than a number?

> +#
> +# @zone-size: Total number of logical blocks within zones in bytes
> +#     (since 8.2)
> +#
> +# @zone-capacity: The number of usable logical blocks within zones
> +#     in bytes.  A zone capacity is always smaller or equal to the
> +#     zone size. (since 8.2)
> +#
> +# @nr-conv-zones: The number of conventional zones of the zoned device
> +#     (since 8.2)

I still think @conventional-zones would be more obvious.

> +#
> +# @max-open-zones: The maximal number of open zones (since 8.2)
> +#
> +# @max-active-zones: The limit of the zones that have the implicit
> +#     open, explicit open or closed state (since 8.2)

Maybe "The maximum number of zones in the implicit open, explicit open
or closed state".

(I'll repeat suggestions until you reject them, just to make sure they
get ignored by accident)

> +#
> +# @max-append-sectors: The maximal number of 512-byte sectors of a zone
> +#     append request that can be issued to the device. (since 8.2)
> +#
>  # Since: 2.12
>  ##
>  { 'struct': 'BlockdevCreateOptionsQcow2',
> @@ -5037,7 +5058,14 @@
>              '*preallocation':   'PreallocMode',
>              '*lazy-refcounts':  'bool',
>              '*refcount-bits':   'int',
> -            '*compression-type':'Qcow2CompressionType' } }
> +            '*compression-type':'Qcow2CompressionType',
> +            '*zone-model':         'uint8',
> +            '*zone-size':          'size',
> +            '*zone-capacity':      'size',
> +            '*nr-conv-zones':      'uint32',
> +            '*max-open-zones':     'uint32',
> +            '*max-active-zones':   'uint32',
> +            '*max-append-sectors': 'uint32' } }
>  
>  ##
>  # @BlockdevCreateOptionsQed:


