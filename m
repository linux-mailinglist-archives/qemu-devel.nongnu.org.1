Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E75C7A4B3A
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:48:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFWw-0005m8-I4; Mon, 18 Sep 2023 10:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFWd-0005N1-8O
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFWb-0003ki-P7
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ps7XEZcGrB/0PYnyZBdChlnZgjJWf8VzJlGSc4+CNW4=;
 b=QGNbf+HEkocarbO+IDwkC08Rx8B7BatUAveNEQkNZNUHmu9tmhkNSGMA3qlNtG8iah+MUY
 hgeaPJqxqk/S3IfFLyA1UWYrCX5lBNuJ3ylKI3Tt6gPxOh3fYp5iSnzl++eMbNzEhBbw5U
 V61HH5fjuitwCoT5vPqcttVIqMAAZYI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-PrUrkRPVN2Khihf-6g4emA-1; Mon, 18 Sep 2023 10:46:51 -0400
X-MC-Unique: PrUrkRPVN2Khihf-6g4emA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 445F6858F1B;
 Mon, 18 Sep 2023 14:46:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0083949BB9A;
 Mon, 18 Sep 2023 14:46:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0FBB421E6900; Mon, 18 Sep 2023 16:46:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Kevin
 Wolf <kwolf@redhat.com>,  dmitry.fomichev@wdc.com,  Hanna Reitz
 <hreitz@redhat.com>,  Eric Blake <eblake@redhat.com>,  hare@suse.de,
 qemu-block@nongnu.org,  stefanha@redhat.com,  dlemoal@kernel.org
Subject: Re: [PATCH v3 2/4] qcow2: add configurations for zoned format
 extension
References: <20230828150955.3481-1-faithilikerun@gmail.com>
 <20230828150955.3481-3-faithilikerun@gmail.com>
 <875y4ugnhs.fsf@pond.sub.org>
 <CAAAx-8Lf1FrJ52+=8=t4qKwA2HevYq0PToSQuXtQ9HBsbxbUzA@mail.gmail.com>
Date: Mon, 18 Sep 2023 16:46:50 +0200
In-Reply-To: <CAAAx-8Lf1FrJ52+=8=t4qKwA2HevYq0PToSQuXtQ9HBsbxbUzA@mail.gmail.com>
 (Sam Li's message of "Mon, 18 Sep 2023 16:24:26 +0800")
Message-ID: <875y47czdx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

> Markus Armbruster <armbru@redhat.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=881=
=E6=97=A5=E5=91=A8=E4=BA=94 19:08=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Sam Li <faithilikerun@gmail.com> writes:
>>
>> > To configure the zoned format feature on the qcow2 driver, it
>> > requires following arguments: the device size, zoned profile,
>>
>> "Zoned profile" is gone in v3.
>>
>> > zone model, zone size, zone capacity, number of conventional
>> > zones, limits on zone resources (max append sectors, max open
>> > zones, and max_active_zones).
>> >
>> > To create a qcow2 file with zoned format, use command like this:
>> > $ qemu-img create -f qcow2 test.qcow2 -o size=3D768M -o
>> > zone_size=3D64M -o zone_capacity=3D64M -o nr_conv_zones=3D0 -o
>> > max_append_sectors=3D512 -o max_open_zones=3D0 -o max_active_zones=3D0
>> > -o zone_model=3D1
>> >
>> > Signed-off-by: Sam Li <faithilikerun@gmail.com>
>>
>> [...]
>>
>> > diff --git a/qapi/block-core.json b/qapi/block-core.json
>> > index 2b1d493d6e..0d8f9e0a88 100644
>> > --- a/qapi/block-core.json
>> > +++ b/qapi/block-core.json
>> > @@ -5021,6 +5021,27 @@
>> >  # @compression-type: The image cluster compression method
>> >  #     (default: zlib, since 5.1)
>> >  #
>> > +# @zone-model: Zoned device model, 1 for host-managed and 0 for
>>
>> Why is this encoded as a number?
>>
>> If it's fundamentally a flag, use bool.
>>
>> If more models could appear in the future, make it an enum.
>>
>
> Yes, it is an enum.
>
> typedef enum BlockZoneModel {
>     BLK_Z_NONE =3D 0x0, /* Regular block device */
>     BLK_Z_HM =3D 0x1, /* Host-managed zoned block device */
>     BLK_Z_HA =3D 0x2, /* Host-aware zoned block device */
> } BlockZoneModel;

Please make it an enum in the QAPI schema, too.

>> > +#     non-zoned devices (default: 0, since 8.0)
>>
>> Since 8.2.  More of the same below.
>>
>> > +#
>> > +# @zone-size: Total number of logical blocks within zones in bytes
>> > +#     (since 8.0)
>> > +#
>> > +# @zone-capacity: The number of usable logical blocks within zones
>> > +#     in bytes. A zone capacity is always smaller or equal to the
>> > +#     zone size. (since 8.0)
>>
>> Two spaces between sentences for consistency, please.
>>
>> > +#
>> > +# @nr-conv-zones: The number of conventional zones of the zoned device
>> > +#     (since 8.0)
>>
>> I think @conventional-zones would be more obvious.
>>
>> > +#
>> > +# @max-open-zones: The maximal allowed open zones (since 8.0)
>>
>> Maybe "The maximum number of open zones".
>>
>> > +#
>> > +# @max-active-zones: The limit of the zones that have the implicit
>> > +#     open, explicit open or closed state (since 8.0)
>>
>> Maybe "The maximum number of zones in the implicit open, explicit open
>> or closed state".
>>
>> > +#
>> > +# @max-append-sectors: The maximal data size in sectors of a zone
>> > +#     append request that can be issued to the device. (since 8.0)
>>
>> What's the sector size, and how can the user determine it?  Why can't we
>> use bytes here?
>
> The sector size is 512 bytes.

Needs to be documented.

I believe bytes would be easier to document, which makes me suspect
they'd be the simpler interface.

>                               It's more for conventional use.

I'm afraid I don't understand this part.  Do I have to?

>> > +#
>> >  # Since: 2.12
>> >  ##
>> >  { 'struct': 'BlockdevCreateOptionsQcow2',
>> > @@ -5037,7 +5058,14 @@
>> >              '*preallocation':   'PreallocMode',
>> >              '*lazy-refcounts':  'bool',
>> >              '*refcount-bits':   'int',
>> > -            '*compression-type':'Qcow2CompressionType' } }
>> > +            '*compression-type':'Qcow2CompressionType',
>> > +            '*zone-model':         'uint8',
>> > +            '*zone-size':          'size',
>> > +            '*zone-capacity':      'size',
>> > +            '*nr-conv-zones':      'uint32',
>> > +            '*max-open-zones':     'uint32',
>> > +            '*max-active-zones':   'uint32',
>> > +            '*max-append-sectors': 'uint32' } }
>> >
>> >  ##
>> >  # @BlockdevCreateOptionsQed:
>>


