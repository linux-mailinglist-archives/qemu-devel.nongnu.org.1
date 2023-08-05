Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7C9770EAB
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 10:06:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSCIU-0000MB-PD; Sat, 05 Aug 2023 04:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qSCIS-0000DG-PL
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 04:06:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qSCIR-0007rp-4I
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 04:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691222758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cz/AbyB3gR8281UPiOO3llHKXaz6epLpZ/36x6odaDE=;
 b=aENZ2ZfG74b/V3qFrMcUTnZh2hm9rkd1/uOYEfQnjcd5KPQRFTGG327Aj8ISMkfrjftizW
 pRwFXJa1K+e487s9AozcZb7RcQo45s/PYvZdQPL8FYRe6Sosqnn5nD/vspGxgnZ2/0KhcB
 4eUnG6SuA/9hMCrK2uND6U5f2dN1OMo=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-1kKORC-rOEGvBNcd93WZOg-1; Sat, 05 Aug 2023 04:05:55 -0400
X-MC-Unique: 1kKORC-rOEGvBNcd93WZOg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB9423C11C7D;
 Sat,  5 Aug 2023 08:05:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4FF6C5796B;
 Sat,  5 Aug 2023 08:05:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8459921E692A; Sat,  5 Aug 2023 10:05:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Juan Quintela <quintela@redhat.com>,  Chensheng Dong
 <chdong@redhat.com>,  Zhiyi Guo <zhguo@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>
Subject: Re: [PATCH] migration: Allow user to specify migration available
 bandwidth
References: <20230724170755.1114519-1-peterx@redhat.com>
 <87351cfdrq.fsf@pond.sub.org> <ZL/7XtiEFWEprQhD@x1n>
 <87o7jz8a6o.fsf@pond.sub.org> <ZME33z8vFL0fRGYV@x1n>
 <ZMz/g+qU7vzXx6aP@redhat.com> <ZM0FDgndvbhrhMa0@x1n>
Date: Sat, 05 Aug 2023 10:05:53 +0200
In-Reply-To: <ZM0FDgndvbhrhMa0@x1n> (Peter Xu's message of "Fri, 4 Aug 2023
 10:02:54 -0400")
Message-ID: <87a5v5ykv2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Aug 04, 2023 at 02:39:15PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, Jul 26, 2023 at 11:12:31AM -0400, Peter Xu wrote:
>> > On Wed, Jul 26, 2023 at 08:21:35AM +0200, Markus Armbruster wrote:
>> > > Peter Xu <peterx@redhat.com> writes:
>> > >=20
>> > > > Hi, Markus,
>> > > >
>> > > > On Tue, Jul 25, 2023 at 01:10:01PM +0200, Markus Armbruster wrote:
>> > >=20
>> > > [...]
>> > >=20
>> > > >> For better or worse, we duplicate full documentation between
>> > > >> MigrationParameter, MigrateSetParameters, and MigrationParameters=
.  This
>> > > >> would be the first instance where we reference instead.  I'm not =
opposed
>> > > >> to use references, but if we do, I want them used consistently.
>> > > >
>> > > > We discussed this over the other "switchover" parameter, but that =
patchset
>> > > > just stranded..
>> > > >
>> > > > Perhaps I just provide a pre-requisite patch to remove all the com=
ments in
>> > > > MigrateSetParameters and MigrationParameters, letting them all poi=
nt to
>> > > > MigrationParameter?
>> > >=20
>> > > Simplifies maintaining the doc commments.  But how does it affect the
>> > > documentation generated from it?  Better, neutral, or worse?
>> >=20
>> > Probably somewhere neutral.  There are definitely benefits, shorter
>> >
>> > man/html page in total, and avoid accidentally different docs over the=
 same
>> > fields.  E.g., we sometimes have different wordings for different obje=
cts:
>> >=20
>> >        max-cpu-throttle
>> >               maximum cpu throttle percentage.  Defaults to 99.  (Sinc=
e 3.1)
>> >=20
>> >        max-cpu-throttle: int (optional)
>> >               maximum cpu throttle percentage.  The default value is 9=
9. (Since 3.1)
>> >=20
>> > This one is fine, but it's just very easy to leak in something that sh=
ows
>> > differently.  It's good to provide coherent documentation for the same
>> > fields over all three objects.
>>=20
>> Do we have any actual problems though where the difference in
>> docs is actively harmful ? I agree there's a possbility of the
>> duplication being problematic, but unless its actually the
>> case in reality, it is merely a theoretical downside.
>>=20
>> IMHO for someone consuming the docs, this patch is worse, not neutral.
>
> I agree.
>
>>=20
>> >=20
>> > When looking at qemu-qmp-ref.7, it can be like this when we can invite=
 the
>> > reader to read the other section (assuming we only keep MigrationParam=
eter
>> > to keep the documentations):
>> >=20
>> >    MigrationParameters (Object)
>> >=20
>> >        The object structure to represent a list of migration parameter=
s.
>> >        The optional members aren't actually optional.  For detailed
>> >        explanation for each of the field, please refer to the document=
ation
>> >        of MigrationParameter.
>> >=20
>> > But the problem is we always will generate the Members entry, where now
>> > it'll all filled up with "Not documented"..
>> >=20
>> >    Members
>> >        announce-initial: int (optional)
>> >               Not documented
>> >=20
>> >        announce-max: int (optional)
>> >               Not documented
>> >=20
>> >        announce-rounds: int (optional)
>> >               Not documented
>> >=20
>> >        [...]
>> >=20
>> > I think maybe it's better we just list the members without showing "Not
>> > documented" every time for the other two objects.  Not sure whether it=
's an
>> > easy way to fix it, or is it a major issue.
>> >=20
>> > For developers, dedup the comment should always be a win, afaict.
>>=20
>> IMHO that's optimizing for the wrong people and isn't a measurable
>> win anyway. Someone adding a new parameter can just cut+paste the
>> same docs string in the three places. It is a cost, but it is a
>> small one time cost, where having "not documented" is a ongoing
>> cost for consumers of our API.
>>=20
>> I don't think the burden on QEMU maintainers adding new migration
>> parameters is significant enough to justify ripping out our existing
>> docs.
>
> I had that strong feeling mostly because I'm a migration developer and
> migration reviewer, so I suffer on both sides. :) I was trying to stand o=
ut
> for either any future author/reviewer from that pov, but I think indeed t=
he
> ultimate consumer is the reader.
>
> Fundamentally to solve the problem, maybe we must dedup the objects rather
> than the documents only?  I'll try to dig a bit more in this area next we=
ek
> if I have time, any link for previous context would be welcomed (or obvio=
us
> reason that we just won't be able to do that; I only know that at least
> shouldn't be trivial to resolve).
>
> For this one - Markus, let me know what do you think, or I'll simply repo=
st
> v3 with the duplications (when needed, probably later not sooner).

Since you want to investigate de-duplicating the objects, do that
*first*.  If you succeed, we don't have to argue about de-duplicating
docs.


