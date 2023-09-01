Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A25778FC17
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 13:09:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc20X-0003ko-Uc; Fri, 01 Sep 2023 07:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qc20V-0003jq-Rz
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 07:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qc20S-00077M-Cs
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 07:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693566483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O+Ox4YhjRAS+6JpdY3sbU01lDKvRVkskCT3SxPC6Zew=;
 b=MO2F94uKVQwZxtzo81syjoyKs3HN++8qwAf8J0VjVhe86LiGZe+NudOjwFqTpAASIc3AIs
 fh4r4qlXSTSLGFNusl69L7+TTXrs6Xzhb7EwYZZadf2bFvr+/dJ6ZXlWUqA+FGDKr+XzRE
 J0cYUIKa7DEYOeHh4jBBJ4oMDhZJZQA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-680-SfamMgCkPquxG57IwQgDwg-1; Fri, 01 Sep 2023 07:08:00 -0400
X-MC-Unique: SfamMgCkPquxG57IwQgDwg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 470C11817907;
 Fri,  1 Sep 2023 11:08:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC724200A7CB;
 Fri,  1 Sep 2023 11:07:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 06EE421E692A; Fri,  1 Sep 2023 13:07:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org,  Kevin Wolf <kwolf@redhat.com>,
 dmitry.fomichev@wdc.com,  Hanna Reitz <hreitz@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  hare@suse.de,  qemu-block@nongnu.org,
 stefanha@redhat.com,  dlemoal@kernel.org
Subject: Re: [PATCH v3 2/4] qcow2: add configurations for zoned format
 extension
References: <20230828150955.3481-1-faithilikerun@gmail.com>
 <20230828150955.3481-3-faithilikerun@gmail.com>
Date: Fri, 01 Sep 2023 13:07:59 +0200
In-Reply-To: <20230828150955.3481-3-faithilikerun@gmail.com> (Sam Li's message
 of "Mon, 28 Aug 2023 23:09:53 +0800")
Message-ID: <875y4ugnhs.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> requires following arguments: the device size, zoned profile,

"Zoned profile" is gone in v3.

> zone model, zone size, zone capacity, number of conventional
> zones, limits on zone resources (max append sectors, max open
> zones, and max_active_zones).
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
> index 2b1d493d6e..0d8f9e0a88 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -5021,6 +5021,27 @@
>  # @compression-type: The image cluster compression method
>  #     (default: zlib, since 5.1)
>  #
> +# @zone-model: Zoned device model, 1 for host-managed and 0 for

Why is this encoded as a number?

If it's fundamentally a flag, use bool.

If more models could appear in the future, make it an enum.

> +#     non-zoned devices (default: 0, since 8.0)

Since 8.2.  More of the same below.

> +#
> +# @zone-size: Total number of logical blocks within zones in bytes
> +#     (since 8.0)
> +#
> +# @zone-capacity: The number of usable logical blocks within zones
> +#     in bytes. A zone capacity is always smaller or equal to the
> +#     zone size. (since 8.0)

Two spaces between sentences for consistency, please.

> +#
> +# @nr-conv-zones: The number of conventional zones of the zoned device
> +#     (since 8.0)

I think @conventional-zones would be more obvious.

> +#
> +# @max-open-zones: The maximal allowed open zones (since 8.0)

Maybe "The maximum number of open zones".

> +#
> +# @max-active-zones: The limit of the zones that have the implicit
> +#     open, explicit open or closed state (since 8.0)

Maybe "The maximum number of zones in the implicit open, explicit open
or closed state".

> +#
> +# @max-append-sectors: The maximal data size in sectors of a zone
> +#     append request that can be issued to the device. (since 8.0)

What's the sector size, and how can the user determine it?  Why can't we
use bytes here?

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


