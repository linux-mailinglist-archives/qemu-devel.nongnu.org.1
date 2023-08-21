Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20394782A3C
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 15:15:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY4jG-0001Co-U7; Mon, 21 Aug 2023 09:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qY4jB-0001CQ-CM
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qY4j8-00045v-VE
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692623629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lNZ9Xp3GBhnu4J8z6DR/CnaIa6I80pUf4AsvCrUv9P0=;
 b=EsEBAofI3WdBfCs4vKeV7sKmcsJX8KViMa9pbNhsjWyuJJtC8kIfFDOKCqsTB3ePreDfws
 lbT5ZO+CgUU0G8mAaWPG8nykjKzekBd1Enj/4qUxxRQ3OzP5L4iAh5/FCBPJpWF3suY6Bc
 OMt05pFQWo5V8Vgkgg/zfa93AVaQMPA=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-Gcm0HNMcMBaaAtPzq2hV_g-1; Mon, 21 Aug 2023 09:13:46 -0400
X-MC-Unique: Gcm0HNMcMBaaAtPzq2hV_g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A5E53815F7F;
 Mon, 21 Aug 2023 13:13:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B05A9492C13;
 Mon, 21 Aug 2023 13:13:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A811821E690D; Mon, 21 Aug 2023 15:13:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org,  hare@suse.de,  Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com,  qemu-block@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  Eric Blake <eblake@redhat.com>,  stefanha@redhat.com,
 dlemoal@kernel.org
Subject: Re: [PATCH v2 2/4] qcow2: add configurations for zoned format
 extension
References: <20230814085802.61459-1-faithilikerun@gmail.com>
 <20230814085802.61459-3-faithilikerun@gmail.com>
Date: Mon, 21 Aug 2023 15:13:44 +0200
In-Reply-To: <20230814085802.61459-3-faithilikerun@gmail.com> (Sam Li's
 message of "Mon, 14 Aug 2023 16:58:00 +0800")
Message-ID: <87wmxobks7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> requires following arguments: the device size, zoned profile,
> zoned model, zone size, zone capacity, number of conventional
> zones, limits on zone resources (max append sectors, max open
> zones, and max_active_zones). The zoned profile option is set
> to zns when using the qcow2 file as a ZNS drive.
>
> To create a qcow2 file with zoned format, use command like this:
> $ qemu-img create -f qcow2 test.qcow2 -o size=768M -o
> zone_size=64M -o zone_capacity=64M -o zone_nr_conv=0 -o
> max_append_sectors=512 -o max_open_zones=0 -o max_active_zones=0
>  -o zoned_profile=zbc/zns
>
> Signed-off-by: Sam Li <faithilikerun@gmail.com>

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 2b1d493d6e..0c97ae678b 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -5020,24 +5020,42 @@
>  #
>  # @compression-type: The image cluster compression method
>  #     (default: zlib, since 5.1)
> +# @zoned-profile: Two zoned device protocol options, zbc or zns
> +#                 (default: off, since 8.0)

When a 'str' thing accepts a fixed set of (string) values, it most
likely should be an enum instead.  Have you considered making
@zoned-profile one?

> +# @zone-size: The size of a zone of the zoned device (since 8.0)
> +# @zone-capacity: The capacity of a zone of the zoned device (since 8.0)

In bytes, I presume?

What's the difference between size and capacity?

> +# @zone-nr-conv: The number of conventional zones of the zoned device
> +#                (since 8.0)
> +# @max-open-zones: The maximal allowed open zones (since 8.0)
> +# @max-active-zones: The limit of the zones that have the implicit open,
> +#                    explicit open or closed state (since 8.0)

Naming...  if I understand the comment correctly, then @zone-nr-conv,
@max-open-zones, and @max-active-zones are all counting zones.  Rename
@zone-nr-conv to @conventional-zones?

> +# @max-append-sectors: The maximal sectors that is allowed to append write

I'm not sure I understand the explanation.  Elaborate for me?

> +#                      (since 8.0)

Please format like

   #
   # @zoned-profile: Two zoned device protocol options, zbc or zns
   #     (default: off, since 8.0)
   #
   # @zone-size: The size of a zone of the zoned device (since 8.0)
   #
   # @zone-capacity: The capacity of a zone of the zoned device
   #     (since 8.0)
   #
   # @zone-nr-conv: The number of conventional zones of the zoned device
   #     (since 8.0)
   #
   # @max-open-zones: The maximal allowed open zones (since 8.0)
   #
   # @max-active-zones: The limit of the zones that have the implicit
   #     open, explicit open or closed state (since 8.0)
   #
   # @max-append-sectors: The maximal sectors that is allowed to append
   #     write (since 8.0)

to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
to conform to current conventions).

>  #
>  # Since: 2.12
>  ##
>  { 'struct': 'BlockdevCreateOptionsQcow2',
> -  'data': { 'file':             'BlockdevRef',
> -            '*data-file':       'BlockdevRef',
> -            '*data-file-raw':   'bool',
> -            '*extended-l2':     'bool',
> -            'size':             'size',
> -            '*version':         'BlockdevQcow2Version',
> -            '*backing-file':    'str',
> -            '*backing-fmt':     'BlockdevDriver',
> -            '*encrypt':         'QCryptoBlockCreateOptions',
> -            '*cluster-size':    'size',
> -            '*preallocation':   'PreallocMode',
> -            '*lazy-refcounts':  'bool',
> -            '*refcount-bits':   'int',
> -            '*compression-type':'Qcow2CompressionType' } }
> +  'data': { 'file':                'BlockdevRef',
> +            '*data-file':          'BlockdevRef',
> +            '*data-file-raw':      'bool',
> +            '*extended-l2':        'bool',
> +            'size':                'size',
> +            '*version':            'BlockdevQcow2Version',
> +            '*backing-file':       'str',
> +            '*backing-fmt':        'BlockdevDriver',
> +            '*encrypt':            'QCryptoBlockCreateOptions',
> +            '*cluster-size':       'size',
> +            '*preallocation':      'PreallocMode',
> +            '*lazy-refcounts':     'bool',
> +            '*refcount-bits':      'int',
> +            '*compression-type':   'Qcow2CompressionType',

I'd keep the existing lines unchanged.  Not a demand.

> +            '*zoned-profile':      'str',
> +            '*zone-size':          'size',
> +            '*zone-capacity':      'size',
> +            '*zone-nr-conv':       'uint32',
> +            '*max-open-zones':     'uint32',
> +            '*max-active-zones':   'uint32',
> +            '*max-append-sectors': 'uint32'}}

Keep the spaces around the } for consistency.  Yes, they're kind of
ugly.

>  
>  ##
>  # @BlockdevCreateOptionsQed:


