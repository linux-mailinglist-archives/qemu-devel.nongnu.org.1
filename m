Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A73885A2D2
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Feb 2024 13:06:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc2Ok-000690-UB; Mon, 19 Feb 2024 07:05:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rc2Oi-000675-Eg
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 07:05:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rc2Of-0006oI-BX
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 07:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708344319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HLeqbxaEqEFTtAoJ8+Arn63hNzAxVCjA0LF8U7/4f6w=;
 b=EqnS7hB0eNbyNz5K38VfjK2uyN0e09JbMLKzGYwwgECbzT2rMh5R4LA0iHheVwlCny3nFm
 xxUlxL/ERinRnqHow0yZtNKxUVivLRGVwQ5ZWWI+8G9MkX79u2O5De0GzXgpRLrxSezCCl
 zRALLlLXuDHATuqVk3a2ILBKyCPCjxc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-v7DSRIRtNq277DYwp_Czgw-1; Mon, 19 Feb 2024 07:05:15 -0500
X-MC-Unique: v7DSRIRtNq277DYwp_Czgw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27D35869EC1;
 Mon, 19 Feb 2024 12:05:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BFFF9A26;
 Mon, 19 Feb 2024 12:05:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A0F2221E66D0; Mon, 19 Feb 2024 13:05:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org,  dlemoal@kernel.org,  Hanna Reitz
 <hreitz@redhat.com>,  dmitry.fomichev@wdc.com,  qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>,  hare@suse.de,  Kevin Wolf
 <kwolf@redhat.com>,  stefanha@redhat.com
Subject: Re: [PATCH v7 2/4] qcow2: add configurations for zoned format
 extension
In-Reply-To: <87plwsfyyv.fsf@pond.sub.org> (Markus Armbruster's message of
 "Mon, 19 Feb 2024 12:57:44 +0100")
References: <20240122184830.40094-1-faithilikerun@gmail.com>
 <20240122184830.40094-3-faithilikerun@gmail.com>
 <87plwsfyyv.fsf@pond.sub.org>
Date: Mon, 19 Feb 2024 13:05:13 +0100
Message-ID: <87edd8fyme.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

One more thing...

Markus Armbruster <armbru@redhat.com> writes:

> I apologize for the delayed review.
>
> Sam Li <faithilikerun@gmail.com> writes:
>
>> To configure the zoned format feature on the qcow2 driver, it
>> requires settings as: the device size, zone model, zone size,
>> zone capacity, number of conventional zones, limits on zone
>> resources (max append bytes, max open zones, and max_active_zones).
>>
>> To create a qcow2 image with zoned format feature, use command like
>> this:
>> qemu-img create -f qcow2 zbc.qcow2 -o size=768M \
>> -o zone.size=64M -o zone.capacity=64M -o zone.conventional_zones=0 \
>> -o zone.max_append_bytes=4096 -o zone.max_open_zones=6 \
>> -o zone.max_active_zones=8 -o zone.mode=host-managed
>>
>> Signed-off-by: Sam Li <faithilikerun@gmail.com>
>
> [...]
>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index ca390c5700..e2e0ec21a5 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -5038,6 +5038,67 @@
>>  { 'enum': 'Qcow2CompressionType',
>>    'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
>>  
>> +##
>> +# @Qcow2ZoneModel:
>> +#
>> +# Zoned device model used in qcow2 image file
>> +#
>> +# @host-managed: The host-managed model only allows sequential write over the
>> +#     device zones.
>> +#
>> +# Since 8.2
>> +##
>> +{ 'enum': 'Qcow2ZoneModel',
>> +  'data': [ 'host-managed'] }
>> +
>> +##
>> +# @Qcow2ZoneHostManaged:
>> +#
>> +# The host-managed zone model.  It only allows sequential writes.
>> +#
>> +# @size: Total number of bytes within zones.
>
> Default?
>
>> +#
>> +# @capacity: The number of usable logical blocks within zones
>> +#     in bytes.  A zone capacity is always smaller or equal to the
>> +#     zone size.
>
> Default?
>
>> +#
>> +# @conventional-zones: The number of conventional zones of the
>> +#     zoned device (default 0).
>> +#
>> +# @max-open-zones: The maximal number of open zones.  It is less than
>> +#     or equal to the number of sequential write required zones of
>> +#     the device (default 0).
>> +#
>> +# @max-active-zones: The maximal number of zones in the implicit
>> +#     open, explicit open or closed state.  It is less than or equal
>> +#     to the max open zones (default 0).
>> +#
>> +# @max-append-bytes: The maximal number of bytes of a zone
>> +#     append request that can be issued to the device.  It must be
>> +#     512-byte aligned and less than the zone capacity.
>
> Default?
>
>> +#
>> +# Since 8.2
>> +##
>> +{ 'struct': 'Qcow2ZoneHostManaged',
>> +  'data': { '*size':          'size',
>> +            '*capacity':      'size',
>> +            '*conventional-zones': 'uint32',
>> +            '*max-open-zones':     'uint32',
>> +            '*max-active-zones':   'uint32',
>> +            '*max-append-bytes':   'size' } }
>> +
>> +##
>> +# @Qcow2ZoneCreateOptions:
>> +#
>> +# The zone device model for the qcow2 image.

Please document member @mode.

Fails to build since merge commit 61e7a0d27c1:

    qapi/block-core.json: In union 'Qcow2ZoneCreateOptions':
    qapi/block-core.json:5135: member 'mode' lacks documentation

>> +#
>> +# Since 8.2
>> +##
>> +{ 'union': 'Qcow2ZoneCreateOptions',
>> +  'base': { 'mode': 'Qcow2ZoneModel' },
>> +  'discriminator': 'mode',
>> +  'data': { 'host-managed': 'Qcow2ZoneHostManaged' } }
>> +
>>  ##
>>  # @BlockdevCreateOptionsQcow2:
>>  #
>> @@ -5080,6 +5141,9 @@
>>  # @compression-type: The image cluster compression method
>>  #     (default: zlib, since 5.1)
>>  #
>> +# @zone: The zone device model modes.  The default is that the device is
>> +# not zoned.  (since 8.2)
>> +#
>>  # Since: 2.12
>>  ##
>>  { 'struct': 'BlockdevCreateOptionsQcow2',
>> @@ -5096,7 +5160,8 @@
>>              '*preallocation':   'PreallocMode',
>>              '*lazy-refcounts':  'bool',
>>              '*refcount-bits':   'int',
>> -            '*compression-type':'Qcow2CompressionType' } }
>> +            '*compression-type':'Qcow2CompressionType',
>> +            '*zone':            'Qcow2ZoneCreateOptions' } }
>>  
>>  ##
>>  # @BlockdevCreateOptionsQed:


