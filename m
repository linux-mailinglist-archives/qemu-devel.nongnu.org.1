Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F147DFFE8
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 10:09:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyqAA-0004CK-77; Fri, 03 Nov 2023 05:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qyqA5-0004BZ-UG
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 05:08:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qyqA4-0007lU-6k
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 05:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699002491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3p0+QtNUIXsXPhjbvkAscPxWkVyIBO+YHmcaHAM2u/g=;
 b=ajp4zHv/W1rjuA3S7hx345OUQwcg7aP+ioqPxTFUjC/eM0epgUqlY53zpW/8v2zKQ3q+G4
 9qG32nkRcE4C6E4LjHFa1vRFXnF06gqe/nsl0LUxj1XTor2bqXBKDxKYAig/CrOiUyoqAb
 YcZsfCOw7Ykc3S10wczwGORG7wfbSUs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-k_TsiylJOdeawxWPiNeOkw-1; Fri,
 03 Nov 2023 05:08:07 -0400
X-MC-Unique: k_TsiylJOdeawxWPiNeOkw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C895381A88F;
 Fri,  3 Nov 2023 09:08:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9244C016B3;
 Fri,  3 Nov 2023 09:08:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D41A621E6A1F; Fri,  3 Nov 2023 10:08:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>,  qemu-devel@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  dlemoal@kernel.org,
 hare@suse.de,  dmitry.fomichev@wdc.com,  stefanha@redhat.com,
 qemu-block@nongnu.org,  Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 2/4] qcow2: add configurations for zoned format
 extension
References: <20231030121847.4522-1-faithilikerun@gmail.com>
 <20231030121847.4522-3-faithilikerun@gmail.com>
 <i43illqyyzu7wbotuw2fbuft7izdmfo7jkwnds4yrigewachhw@7pudpozwjer5>
Date: Fri, 03 Nov 2023 10:08:05 +0100
In-Reply-To: <i43illqyyzu7wbotuw2fbuft7izdmfo7jkwnds4yrigewachhw@7pudpozwjer5>
 (Eric Blake's message of "Mon, 30 Oct 2023 09:53:36 -0500")
Message-ID: <878r7f19xm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

Eric Blake <eblake@redhat.com> writes:

> On Mon, Oct 30, 2023 at 08:18:45PM +0800, Sam Li wrote:
>> To configure the zoned format feature on the qcow2 driver, it
>> requires settings as: the device size, zone model, zone size,
>> zone capacity, number of conventional zones, limits on zone
>> resources (max append bytes, max open zones, and max_active_zones).
>> 
>> To create a qcow2 file with zoned format, use command like this:
>> $ qemu-img create -f qcow2 test.qcow2 -o size=768M -o
>> zone_size=64M -o zone_capacity=64M -o conventional_zones=0 -o
>> max_append_bytes=4096 -o max_open_zones=0 -o max_active_zones=0
>> -o zone_model=host-managed
>> 
>> Signed-off-by: Sam Li <faithilikerun@gmail.com>
>> 
>> fix config?
>
> Is this comment supposed to be part of the commit message?  If not,...
>
>> ---
>
> ...place it here under the divider, so 'git am' won't include it, if there is nothing further to change on this patch.

[...]

>> +++ b/qapi/block-core.json
>> @@ -4981,6 +4981,21 @@
>>  { 'enum': 'Qcow2CompressionType',
>>    'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
>>  
>> +##
>> +# @Qcow2ZoneModel:
>> +#
>> +# Zoned device model used in qcow2 image file
>> +#
>> +# @non-zoned: non-zoned model is for regular block devices
>> +#
>> +# @host-managed: host-managed model only allows sequential write over the
>> +#     device zones
>> +#
>> +# Since 8.2
>> +##
>> +{ 'enum': 'Qcow2ZoneModel',
>> +  'data': ['non-zoned', 'host-managed'] }
>> +
>>  ##
>>  # @BlockdevCreateOptionsQcow2:
>>  #
>> @@ -5023,6 +5038,27 @@
>>  # @compression-type: The image cluster compression method
>>  #     (default: zlib, since 5.1)
>>  #
>> +# @zone-model: @Qcow2ZoneModel.  The zone device model.
>> +#     (default: non-zoned, since 8.2)
>> +#
>> +# @zone-size: Total number of bytes within zones (since 8.2)
>
> If @zone-model is "non-zoned", does it make sense to even allow
> @zone-size and friends?  Should this use a QMP union, where you can
> pass in the remaining zone-* fields only when zone-model is set to
> host-managed?

Valid question; needs an answer.

>> +#
>> +# @zone-capacity: The number of usable logical blocks within zones
>> +#     in bytes.  A zone capacity is always smaller or equal to the
>> +#     zone size (since 8.2)
>> +#
>> +# @conventional-zones: The number of conventional zones of the
>> +#     zoned device (since 8.2)
>> +#
>> +# @max-open-zones: The maximal number of open zones (since 8.2)
>> +#
>> +# @max-active-zones: The maximal number of zones in the implicit
>> +#     open, explicit open or closed state (since 8.2)
>> +#
>> +# @max-append-bytes: The maximal number of bytes of a zone
>> +#     append request that can be issued to the device.  It must be
>> +#     512-byte aligned (since 8.2)
>> +#
>>  # Since: 2.12
>>  ##
>>  { 'struct': 'BlockdevCreateOptionsQcow2',
>> @@ -5039,7 +5075,14 @@
>>              '*preallocation':   'PreallocMode',
>>              '*lazy-refcounts':  'bool',
>>              '*refcount-bits':   'int',
>> -            '*compression-type':'Qcow2CompressionType' } }
>> +            '*compression-type':'Qcow2CompressionType',
>> +            '*zone-model':         'Qcow2ZoneModel',
>> +            '*zone-size':          'size',
>> +            '*zone-capacity':      'size',
>> +            '*conventional-zones': 'uint32',
>> +            '*max-open-zones':     'uint32',
>> +            '*max-active-zones':   'uint32',
>> +            '*max-append-bytes':   'uint32' } }
>
> In other words, I'm envisioning something like an optional
> '*zone':'ZoneStruct', where:
>
> { 'struct': 'ZoneHostManaged',
>   'data': { 'size': 'size', '*capacity': 'size', ..., '*max-append-bytes': 'uint32' } }
> { 'union': 'ZoneStruct',
>   'base': { 'model': 'Qcow2ZoneModel' },
>   'discriminator': 'model',
>   'data': { 'non-zoned': {},
>             'host-managed': 'ZoneHostManaged' } }
>
> then over the wire, QMP can use the existing:
> { ..., "compression-type":"zstd" }
>
> as a synonym for the new but explicit non-zoned:
> { ..., "compression-type":"zstd", "zone":{"mode":"non-zoned"} }

I.e. @zone is optional, and defaults to {"mode": "non-zoned"}.

> and when we want to use zones, we pass:
> { ..., "compression-type":"zstd", "zone":{"mode":"host-managed", "size":16777216} }
>
> where you don't have to have zone- prefixing everywhere because it is
> instead contained in the smart union object where it is obvious from
> the 'mode' field what other fields should be present.


