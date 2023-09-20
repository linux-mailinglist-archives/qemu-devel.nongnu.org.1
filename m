Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C189B7A8338
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 15:23:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qixAA-0004Th-QO; Wed, 20 Sep 2023 09:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qixA7-0004TE-U9
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 09:22:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qixA5-0002Ut-R8
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 09:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695216156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFfi7pjxQSw9VVLKXr6BlE+iroOPsG5xuhorKXSb3TY=;
 b=YVdKve7giPUoIaqyturqMNnuaQ/Uf1RH42+S+eUH4T9kQCw5kpBiM63v50Lhv5dHt6uz8Q
 +QAlrMQTgPRu6Rci+zzH8qrtc+jo+ygw/L6KAukptzhTxyTy82lzHrbudh4XQM7yOqzAhc
 bjBVezvbPUXpd+YtqHpa0WugLFyya7c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-Y-RMt2MhNg2Q5hrNerNczw-1; Wed, 20 Sep 2023 09:22:35 -0400
X-MC-Unique: Y-RMt2MhNg2Q5hrNerNczw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1E3D101A550;
 Wed, 20 Sep 2023 13:22:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 89C1540C6EBF;
 Wed, 20 Sep 2023 13:22:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9008521E6900; Wed, 20 Sep 2023 15:22:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,  qemu-devel@nongnu.org,
 quintela@redhat.com,  leobras@redhat.com,  Li Zhijian
 <lizhijian@fujitsu.com>
Subject: Re: [PATCH 00/52] migration/rdma: Error handling fixes
References: <20230918144206.560120-1-armbru@redhat.com> <ZQnRKjo0M50BRbZh@x1n>
 <ZQnojJOqoFu73995@redhat.com>
Date: Wed, 20 Sep 2023 15:22:33 +0200
In-Reply-To: <ZQnojJOqoFu73995@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 19 Sep 2023 19:29:32 +0100")
Message-ID: <8734z9f086.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Sep 19, 2023 at 12:49:46PM -0400, Peter Xu wrote:
>> On Mon, Sep 18, 2023 at 04:41:14PM +0200, Markus Armbruster wrote:
>> > Oh dear, where to start.  There's so much wrong, and in pretty obvious
>> > ways.  This code should never have passed review.  I'm refraining from
>> > saying more; see the commit messages instead.
>> >=20
>> > Issues remaining after this series include:
>> >=20
>> > * Terrible error messages
>> >=20
>> > * Some error message cascades remain
>> >=20
>> > * There is no written contract for QEMUFileHooks, and the
>> >   responsibility for reporting errors is unclear
>>=20
>> Even being removed.. because no one is really extending that..
>>=20
>> https://lore.kernel.org/all/20230509120700.78359-1-quintela@redhat.com/#t
>
> One day (in another 5-10 years) I still hope we'll get to
> the point where QEMUFile itself is obsolete :-) Getting
> rid of QEMUFileHooks is a great step in that direction.
> Me finishing a old PoC to bring buffering to QIOChannel
> would be another big step.
>
> The data rate limiting would be the biggest missing piece
> to enable migration/vmstate logic to directly consume
> a QIOChannel.
>
> Eliminating QEMUFile would help to bring Error **errp
> to all the vmstate codepaths.

Sounds like improvement to me.

>> > * There seem to be no tests whatsoever
>>=20
>> I always see rdma as "odd fixes" stage.. for a long time.  But maybe I w=
as
>> wrong.

To be honest, it doesn't look or smell maintained to me.  More like
thrown over the fence and left to rot.  Given the shape it is in, I
wouldn't let friends use it in production.

> In the MAINTAINERS file RDMA still get classified as formally
> supported under the migration maintainers.  I'm not convinced
> that is an accurate description of its status.  I tend to agree
> with you that it is 'odd fixes' at the very best.

Let's fix MAINTAINERS not to raise unrealistic expectations.

> Dave Gilbert had previously speculated about whether we should
> even consider deprecating it on the basis that latest non-RDMA
> migration is too much better than in the past, with multifd
> and zerocopy, that RDMA might not even offer a significant
> enough peformance win to justify.

I provided approximately 52 additional arguments for deprecating it :)

>> Copying Zhijian for status of rdma; Zhijian, I saw that you just replied=
 to
>> the hwpoison issue.  Maybe we should have one entry for rdma too, just l=
ike
>> colo?
>
> With regards,
> Daniel


