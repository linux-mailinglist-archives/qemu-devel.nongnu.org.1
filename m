Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3DF758D17
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 07:28:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLzhz-0002B1-Tg; Wed, 19 Jul 2023 01:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qLzhx-00029G-6B
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 01:26:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qLzhv-0003CN-F1
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 01:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689744398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tiq7wgASk5lFBCl91791cs0r6ITeYNv4MkzlMeh6e/8=;
 b=h2LfFJiEOU0icALSF49oinI1X2kUlBkp97HlpYrfxNkud9nY/luLQMGF+kvUbW2DWJML5B
 WyY8JtdmOa9zpJ+SoSxhCf7hosvfDW1S5Gs25D80icTKcBxkTB7ioe0wj1s5n+UYI0RhEO
 jGzLDr5UnUL1Hm60oe9F9pd25bma8N4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-iRufqK5-OfqpwbvYKohL0A-1; Wed, 19 Jul 2023 01:26:34 -0400
X-MC-Unique: iRufqK5-OfqpwbvYKohL0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C3ED800CAF;
 Wed, 19 Jul 2023 05:26:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CFEA6F66D6;
 Wed, 19 Jul 2023 05:26:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C70F221E6608; Wed, 19 Jul 2023 07:26:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Juan Quintela
 <quintela@redhat.com>,  "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH QEMU v8 4/9] migration: Introduce dirty-limit capability
References: <168870305868.29142.5121604177475325995-4@git.sr.ht>
 <875y6oj80i.fsf@pond.sub.org>
 <CAK9dgmZ73F2qrD-iM-EBSiARRmwGPPorsLdt8NqmkOSyYaRCVw@mail.gmail.com>
 <87zg3tjxb2.fsf@pond.sub.org>
 <CAK9dgmYyxZC_6CPZcgudXVpRXKcdd6kXTsYLhZ_PTiOh=c4-2g@mail.gmail.com>
Date: Wed, 19 Jul 2023 07:26:32 +0200
In-Reply-To: <CAK9dgmYyxZC_6CPZcgudXVpRXKcdd6kXTsYLhZ_PTiOh=c4-2g@mail.gmail.com>
 (Yong Huang's message of "Wed, 19 Jul 2023 12:10:09 +0800")
Message-ID: <87a5vsh3p3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

> On Tue, Jul 18, 2023 at 7:04=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> Yong Huang <yong.huang@smartx.com> writes:
>>
>> > On Thu, Jul 13, 2023 at 8:44=E2=80=AFPM Markus Armbruster <armbru@redh=
at.com>
>> wrote:
>> >
>> >> ~hyman <hyman@git.sr.ht> writes:
>> >>
>> >> > From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
>> >> >
>> >> > Introduce migration dirty-limit capability, which can
>> >> > be turned on before live migration and limit dirty
>> >> > page rate durty live migration.
>> >> >
>> >> > Introduce migrate_dirty_limit function to help check
>> >> > if dirty-limit capability enabled during live migration.
>> >> >
>> >> > Meanwhile, refactor vcpu_dirty_rate_stat_collect
>> >> > so that period can be configured instead of hardcoded.
>> >> >
>> >> > dirty-limit capability is kind of like auto-converge
>> >> > but using dirty limit instead of traditional cpu-throttle
>> >> > to throttle guest down. To enable this feature, turn on
>> >> > the dirty-limit capability before live migration using
>> >> > migrate-set-capabilities, and set the parameters
>> >> > "x-vcpu-dirty-limit-period", "vcpu-dirty-limit" suitably
>> >> > to speed up convergence.
>> >> >
>> >> > Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.c=
om>
>> >> > Acked-by: Peter Xu <peterx@redhat.com>
>> >> > Reviewed-by: Juan Quintela <quintela@redhat.com>
>> >>
>> >> [...]
>> >>
>> >> > diff --git a/qapi/migration.json b/qapi/migration.json
>> >> > index e43371955a..031832cde5 100644
>> >> > --- a/qapi/migration.json
>> >> > +++ b/qapi/migration.json
>> >> > @@ -497,6 +497,15 @@
>> >> >  #     are present.  'return-path' capability must be enabled to use
>> >> >  #     it.  (since 8.1)
>> >> >  #
>> >> > +# @dirty-limit: If enabled, migration will use the dirty-limit
>> >> > +#     algorithm to throttle down guest instead of auto-converge
>> >> > +#     algorithm. This algorithm only works when vCPU's dirtyrate
>> >>
>> >> Two spaces after sentence-ending punctuation, please.
>> >>
>> >> "dirty rate" with a space, because that's how we spell it elsewhere.
>> >>
>> >> > +#     greater than 'vcpu-dirty-limit', read processes in guest os
>> >> > +#     aren't penalized any more, so the algorithm can improve
>> >> > +#     performance of vCPU during live migration. This is an option=
al
>> >> > +#     performance feature and should not affect the correctness of
>> the
>> >> > +#     existing auto-converge algorithm. (since 8.1)
>> >> > +#
>> >>
>> >> I'm still confused.
>> >>
>> >> The text suggests there are two separate algorithms "to throttle down
>> >> guest": "auto converge" and "dirty limit", and we get to pick one.
>> >> Correct?
>> >>
>> > Yes, indeed !
>> >
>> >>
>> >> If it is correct, then the last sentence feels redundant: picking
>> >> another algorithm can't affect the algorithm we're *not* using.  What
>> >> are you trying to express here?
>> >>
>> > What i want to express is that the new algorithm implementation does
>> > not affect the original algorithm, leaving it in the comments seems
>> > redundant indeed.  I'll drop this in the next version.
>>
>> Works for me.
>>
>> >> When do we use "auto converge", and when do we use "dirty limit"?
>> >>
>> >> What does the user really need to know about these algorithms?  Enough
>> >> to pick one, I guess.  That means advantages and disadvantages of the
>> >> two algorithms.  Which are?
>> >
>> > 1. The implementation of dirty-limit is based on dirty-ring, which is
>> > qualified
>> >    to big systems with huge memories and can improve huge guest VM
>> >     responsiveness remarkably during live migration. As a consequence,
>> > dirty-limit
>> >     is recommended on platforms with huge guest VMs as is the way with
>> > dirty-ring.
>> > 2. dirty-limit convergence algorithm does not affect the "read-process"
>> in
>> > guest
>> >    VM, so guest VM gains the equal read performance nearly as it runs =
on
>> > host
>> >    during the live migration. As a result, dirty-limit is recommended =
if
>> > the guest
>> >     VM requires a stable read performance.
>> > The above explanation is about the recommendation of dirty-limit, plea=
se
>> > review,
>> > if it's ok, i'll place it in the comment of the dirty-limit capability.
>>
>> Yes, please.  But before that, I have still more questions.  "This
>> algorithm only works when vCPU's dirtyrate greater than
>> 'vcpu-dirty-limit'" is a condition: "FEATURE only works when CONDITION".
>>
> I failed to express my meaning again : ( .  "Throttle algo only works when
> vCPU's  dirtyrate greater than 'vcpu-dirty-limit' " should change to
> "vCPU throttle only works when vCPU's dirtyrate greater than
> 'vcpu-dirty-limit'".
> Not the whole "algo" !

Let me paraphrase to make sure I got it...  The vCPU is throttled as
needed to keep its dirty rate within the limit set with
set-vcpu-dirty-limit.  Correct?

What happens when I enable the dirty limit convergence algorithm without
setting a limit with set-vcpu-dirty-limit?

>> What happens when the condition is not met?  How can the user ensure the
>> condition is met?
>>
>> [...]
>>
>>


