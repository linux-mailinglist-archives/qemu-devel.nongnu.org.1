Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D2876B4D6
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 14:34:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQoZE-0007tT-9F; Tue, 01 Aug 2023 08:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qQoZ5-0007t9-BH
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 08:33:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qQoZ3-0002LU-Aq
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 08:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690893203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EjJ//tCmHa56bEE24EXXwaiKjDje+AcnAEZIq1SqYbE=;
 b=ZySP8osl0Wulw7D57rSkXPuMuMxB360NgQgMY0faFngrTKJVg+zeYSCjQBwGDxZdo9Z4bV
 c/sEKSTObVVahmg62NfptHXj7bibo966lEw/6qvWY97ZPF1As1h+JlQ9e5sv+aeSG09k/d
 XllyUZ433tDRoUvpSGNKs0O9rQyyV8U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-LIBMuWPBPky3eufa9E2SzA-1; Tue, 01 Aug 2023 08:33:20 -0400
X-MC-Unique: LIBMuWPBPky3eufa9E2SzA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2BE6800962;
 Tue,  1 Aug 2023 12:33:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4186E40D283A;
 Tue,  1 Aug 2023 12:33:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0D11621E692A; Tue,  1 Aug 2023 14:33:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org,  Juan Quintela <quintela@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH QEMU 1/2] qapi: Reformat and craft the migration doc
 comments
References: <169040075240.21656.5651891935411754498-1@git.sr.ht>
 <87y1j0lblv.fsf@pond.sub.org>
 <CAK9dgmaWfHyPDKneJVEo2TDehZ9PX0a-YLSp2x+Z=kYeJohmOQ@mail.gmail.com>
Date: Tue, 01 Aug 2023 14:33:18 +0200
In-Reply-To: <CAK9dgmaWfHyPDKneJVEo2TDehZ9PX0a-YLSp2x+Z=kYeJohmOQ@mail.gmail.com>
 (Yong Huang's message of "Fri, 28 Jul 2023 17:11:38 +0800")
Message-ID: <87o7jr0woh.fsf@pond.sub.org>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Yong Huang <yong.huang@smartx.com> writes:

> On Fri, Jul 28, 2023 at 3:49=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> ~hyman <hyman@git.sr.ht> writes:
>>
>> > From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
>> >
>> > Reformat migration doc comments to conform to current conventions
>> > as commit a937b6aa739 (qapi: Reformat doc comments to conform to
>> > current conventions).
>> >
>> > Also, craft the dirty-limit capability comment.
>>
>> Split into two patches?
>>
> Ok.
>
>>
>> > Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
>> > ---
>> >  qapi/migration.json | 66 +++++++++++++++++++++------------------------
>> >  1 file changed, 31 insertions(+), 35 deletions(-)
>> >
>> > diff --git a/qapi/migration.json b/qapi/migration.json
>> > index 6b49593d2f..5d5649c885 100644
>> > --- a/qapi/migration.json
>> > +++ b/qapi/migration.json
>> > @@ -258,17 +258,17 @@
>> >  #     blocked.  Present and non-empty when migration is blocked.
>> >  #     (since 6.0)
>> >  #
>> > -# @dirty-limit-throttle-time-per-round: Maximum throttle time (inmicr=
oseconds) of virtual
>> > -#                                       CPUs each dirty ring fullroun=
d, which shows how
>> > -#                                       MigrationCapability dirty-lim=
itaffects the guest
>> > -#                                       during live migration. (since=
8.1)
>> > -#
>> > -# @dirty-limit-ring-full-time: Estimated average dirty ring full time=
(in microseconds)
>> > -#                              each dirty ring full round, note thatt=
he value equals
>> > -#                              dirty ring memory size divided byavera=
ge dirty page rate
>> > -#                              of virtual CPU, which can be used toob=
serve the average
>> > -#                              memory load of virtual CPU indirectly.=
Note that zero
>> > -#                              means guest doesn't dirty memory (sinc=
e8.1)
>> > +# @dirty-limit-throttle-time-per-round: Maximum throttle time
>> > +#     (in microseconds) of virtual CPUs each dirty ring full round,
>> > +#     which shows how MigrationCapability dirty-limit affects the
>>
>> Perhaps "for each ... round"?
>>
>> Remind me, what's a "dirty ring full round"?
>>
> Every time the x86 PML buffer is filled with gpa, hardware throws an
> exception and
> guest exits to kvm, then to qemu. Qemu will handle the exception with
> reaping the
> dirty ring and get the dirty page info, then enter the kvm, empty the PML
> buffer and
> enter guests again, i call this "dirty ring full round", but it seems not
> straightforward,
> please help me describe that,  thanks.

"x86 PML" is page modification logging, right?

>> > +#     guest during live migration.  (Since 8.1)
>> > +#
>> > +# @dirty-limit-ring-full-time: Estimated average dirty ring full
>> > +#     time (in microseconds) each dirty ring full round. The value
>>
>> Likewise.
>>
>> > +#     equals dirty ring memory size divided by average dirty page
>>
>> "the dirty ring memory size divided by the average ..."
>>
>> > +#     rate of the virtual CPU, which can be used to observe the
>> > +#     average memory load of the virtual CPU indirectly. Note that
>> > +#     zero means guest doesn't dirty memory.  (Since 8.1)
>>
>> Two spaces between sentences for consistency.
>>
>> >  #
>> >  # Since: 0.14
>> >  ##
>> > @@ -519,15 +519,11 @@
>> >  #     are present.  'return-path' capability must be enabled to use
>> >  #     it.  (since 8.1)
>> >  #
>> > -# @dirty-limit: If enabled, migration will use the dirty-limit algo to
>> > -#               throttle down guest instead of auto-converge algo.
>> > -#               Throttle algo only works when vCPU's dirtyrate greater
>> > -#               than 'vcpu-dirty-limit', read processes in guest os
>> > -#               aren't penalized any more, so this algo can improve
>> > -#               performance of vCPU during live migration. This is an
>> > -#               optional performance feature and should not affect the
>> > -#               correctness of the existing auto-converge algo.
>> > -#               (since 8.1)
>> > +# @dirty-limit: If enabled, migration will throttle vCPUs as needed to
>> > +#     keep their dirty page rate within @vcpu-dirty-limit.  This can
>> > +#     improve responsiveness of large guests during live migration,
>> > +#     and can result in more stable read performance.  Requires KVM
>> > +#     with accelerator property "dirty-ring-size" set.  (Since 8.1)
>> >  #
>> >  # Features:
>> >  #
>> > @@ -822,17 +818,17 @@
>> >  #     Nodes are mapped to their block device name if there is one, and
>> >  #     to their node name otherwise.  (Since 5.2)
>> >  #
>> > -# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirt=
ylimit during
>> > -#                             live migration. Should be in the range =
1to 1000ms,
>> > -#                             defaults to 1000ms. (Since 8.1)
>> > +# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
>> > +#     limit during  live migration. Should be in the range 1 to 1000m=
s,
>>
>> Single space in "during live", and two space between sentences, please.
>>
>> > +#     defaults to 1000ms.  (Since 8.1)
>>
>> I dislike that we mix milli- and microseconds.  Too late to fix, I'm
>> afraid.
>>
>> Remind me, what't the "periodic time of dirty limit during live
>> migration"?
>>
> It is the period to calculate the dirty page rate for each vCPU.
> So Qemu will use it to compare with the dirty-limit value.
> If the period is too short, cpu overhead is increasing and if
> it is too long, the result may not be precise. So we make it
> configurable.

The limited migration knowledge I have wasn't enough to review the doc
part of your QAPI schema patch with reasonable effort and within a
reasonable time.  You had to answer a lot of fairly basic questions.
Thanks for your patience.

Perhaps I should've given up and left the docs to the migration
maintainers.

I believe what I've been missing is an overview of the dirty limit
algorithm to throttle guests being live-migrated.

Could we have that in docs/devel/migration.rst?

Apropos migration.rst: not a peep on compression.  Juan, Peter,
Leonardo, should it be covered there?

[...]


