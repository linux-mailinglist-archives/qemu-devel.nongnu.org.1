Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7330817110
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 14:54:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFE36-0007Gs-7L; Mon, 18 Dec 2023 08:52:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rFE33-0007Fr-4d
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 08:52:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rFE31-00011s-Mp
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 08:52:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702907563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E6/B/glaHc9v/csHKKYkQiw3lBlKZwtQMyuJs+huVR4=;
 b=iV7WT2hp6q1Fg4a6Sn0tDUOmYhk6JSeZ8Sc+lJpgIZl7gzkuz8cDgmJqBl0pn9++zdv/Gu
 ONsraKgaXnJbweMbrOyJpXXCr8brDLrLFdlHu4LHqFGsFpK3mLD1XwH2rTxjoaqLs1LfyH
 G+2gvqvon3+Dwbv0tqk4rQKx3rIRpJ4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-quY146RMNEaJ489IzIY5MA-1; Mon, 18 Dec 2023 08:52:39 -0500
X-MC-Unique: quY146RMNEaJ489IzIY5MA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A2F38350E4;
 Mon, 18 Dec 2023 13:52:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 593F6492BC7;
 Mon, 18 Dec 2023 13:52:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B11C21E6920; Mon, 18 Dec 2023 14:52:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org,  dmitry.fomichev@wdc.com,  qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>,  dlemoal@kernel.org,  hare@suse.de,  Hanna
 Reitz <hreitz@redhat.com>,  stefanha@redhat.com,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v6 2/4] qcow2: add configurations for zoned format
 extension
In-Reply-To: <CAAAx-8LReW-U5omAzVckymtwNB_sWDMebqJYyDyGm344r9WpcA@mail.gmail.com>
 (Sam Li's message of "Sun, 17 Dec 2023 01:30:00 +0100")
References: <20231127043703.49489-1-faithilikerun@gmail.com>
 <20231127043703.49489-3-faithilikerun@gmail.com>
 <87bkbbeis6.fsf@pond.sub.org>
 <CAAAx-8LReW-U5omAzVckymtwNB_sWDMebqJYyDyGm344r9WpcA@mail.gmail.com>
Date: Mon, 18 Dec 2023 14:52:37 +0100
Message-ID: <878r5rsjmi.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.083,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Markus Armbruster <armbru@redhat.com> =E4=BA=8E2023=E5=B9=B411=E6=9C=8830=
=E6=97=A5=E5=91=A8=E5=9B=9B 09:40=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Sam Li <faithilikerun@gmail.com> writes:

[...]

>> > +##
>> > +# @Qcow2ZoneHostManaged:
>> > +#
>> > +# The host-managed zone model.  It only allows sequential writes.
>> > +#
>> > +# @size: Total number of bytes within zones
>> > +#
>> > +# @capacity: The number of usable logical blocks within zones
>> > +#     in bytes.  A zone capacity is always smaller or equal to the
>> > +#     zone size
>> > +#
>> > +# @conventional-zones: The number of conventional zones of the
>> > +#     zoned device
>> > +#
>> > +# @max-open-zones: The maximal number of open zones
>> > +#
>> > +# @max-active-zones: The maximal number of zones in the implicit
>> > +#     open, explicit open or closed state
>> > +#
>> > +# @max-append-bytes: The maximal number of bytes of a zone
>> > +#     append request that can be issued to the device.  It must be
>> > +#     512-byte aligned
>>
>> Missing period at the end.
>>
>> For all the optional members: what's the default?
>
> The default for optional members is 0. When max-open-zones and
> max-active-zones are 0, it implies no limit on zone resources.

Please document the default in the doc comment.  We commonly do it like
this:

      # @max-open-zones: The maximal number of open zones (default 0)

[...]


