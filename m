Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 675B171F64C
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:56:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4rDG-0000UK-ME; Thu, 01 Jun 2023 18:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4rDC-0000Tk-Cl
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4rDA-00077i-Nj
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685660163;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZmXWYV/eufKnJUY2Ukvw0m4vzC0QmtYVRLNthyMo1t4=;
 b=KiQz5REktUyvLvvgBwm1/daGFc6Ci1mILpJHIGyB1BMFUW34Wy2I9YVnmAq+g5XcohrrgD
 XzEuPW1JuNgjVrdzn3d8RRtbUOtBhYoqGnVz76eWZf2QRS1XXUlZx1J1N48Nh3wDbp8yVQ
 Gnrm/UqVCsTJmUllCrOggDCEUnvNRqQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-MERoPgqDMzWU5XGAuIi51Q-1; Thu, 01 Jun 2023 18:56:02 -0400
X-MC-Unique: MERoPgqDMzWU5XGAuIi51Q-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30af00323b0so800598f8f.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 15:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685660161; x=1688252161;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZmXWYV/eufKnJUY2Ukvw0m4vzC0QmtYVRLNthyMo1t4=;
 b=S2x9cXhjQlo8jhd2g4iig40GrJ3WCnEk8jeH9eESqABlE284qChpxobt67bQxuVpu5
 2j982bONVFu+HcoTohtDz5jDiGyfU0RDUFFuU/4qPjMHKjIW+qXMgjuLZ++rjAgdh0Cp
 B1BVPWZfHsg9A7HAT6UuBiP4QLxx/n9K+nGLJQy+okigsfJCHGiruiHU0apq1wTVNQzo
 vMiXvmsNChhaPcGCxwTUR3zTrAEYMsuf+Vv1Z9ANU9LraxPoIi7LJyqmdb6YkRZ/M2qR
 Glg9Sbohv6xxJZ6eF9BV9KylkSfjqxNYcUbF2yIpGyQ+tMJCyGqDwNk76CBHnvtOk5H/
 OoLw==
X-Gm-Message-State: AC+VfDyxb76Fm7ZpXjXwncIes5LJDU4DS36axbR5e71aACV06PC8R6KL
 BOgzrgisf5AlWDqb7JbfCMg9e7P6Ixnn031NbxNE3Ns7LRwDUNh2L7xFFpU6ONmZMvhzNSKRPSa
 cSyx4SkW1z3pq58M=
X-Received: by 2002:a5d:688d:0:b0:306:2aa0:ce81 with SMTP id
 h13-20020a5d688d000000b003062aa0ce81mr3000816wru.30.1685660161338; 
 Thu, 01 Jun 2023 15:56:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ63W98ie7HffZlpgR9iw3isy2kzelj8Ge3FHkEoWaMZUeHX1poTp6PFrUYcsuC5hoR9F7vPtg==
X-Received: by 2002:a5d:688d:0:b0:306:2aa0:ce81 with SMTP id
 h13-20020a5d688d000000b003062aa0ce81mr3000807wru.30.1685660161063; 
 Thu, 01 Jun 2023 15:56:01 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 e16-20020adfe390000000b003048477729asm11574039wrm.81.2023.06.01.15.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 15:56:00 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,  qemu-devel@nongnu.org,  Laurent Vivier
 <lvivier@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 8/9] tests/qtest: make more migration pre-copy
 scenarios run non-live
In-Reply-To: <ZHi/beg2UqoEnk/b@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 1 Jun 2023 16:55:25 +0100")
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-9-berrange@redhat.com> <ZHi5gmd+5pQhDqBF@x1n>
 <ZHi7xLhUp0+5cay7@redhat.com> <ZHi+7bgcHPUisc8d@x1n>
 <ZHi/beg2UqoEnk/b@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 02 Jun 2023 00:55:59 +0200
Message-ID: <87bkhyrdvk.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Thu, Jun 01, 2023 at 11:53:17AM -0400, Peter Xu wrote:
>> On Thu, Jun 01, 2023 at 04:39:48PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> > On Thu, Jun 01, 2023 at 11:30:10AM -0400, Peter Xu wrote:
>> > > Thanks for looking into this.. definitely worthwhile.
>> > >=20
>> > > On Wed, May 31, 2023 at 02:23:59PM +0100, Daniel P. Berrang=C3=A9 wr=
ote:
>> > > > There are 27 pre-copy live migration scenarios being tested. In al=
l of
>> > > > these we force non-convergance and run for one iteration, then let=
 it
>> > > > converge and wait for completion during the second (or following)
>> > > > iterations. At 3 mbps bandwidth limit the first iteration takes a =
very
>> > > > long time (~30 seconds).
>> > > >=20
>> > > > While it is important to test the migration passes and convergance
>> > > > logic, it is overkill to do this for all 27 pre-copy scenarios. The
>> > > > TLS migration scenarios in particular are merely exercising differ=
ent
>> > > > code paths during connection establishment.
>> > > >=20
>> > > > To optimize time taken, switch most of the test scenarios to run
>> > > > non-live (ie guest CPUs paused) with no bandwidth limits. This giv=
es
>> > > > a massive speed up for most of the test scenarios.
>> > > >=20
>> > > > For test coverage the following scenarios are unchanged
>> > >=20
>> > > Curious how are below chosen?  I assume..
>> >=20
>> > Chosen based on whether they exercise code paths that are unique
>> > and interesting during the RAM transfer phase.
>> >=20
>> > Essentially the goal is that if we have N% code coverage before this
>> > patch, then we should still have the same N% code coverage after this
>> > patch.
>> >=20
>> > The TLS tests exercise code paths that are unique during the migration
>> > establishment phase. Once establishd they don't exercise anything
>> > "interesting" during RAM transfer phase. Thus we don't loose code cove=
rage
>> > by runing TLS tests non-live.
>> >=20
>> > >=20
>> > > >=20
>> > > >  * Precopy with UNIX sockets
>> > >=20
>> > > this one verifies dirty log.
>> > >=20
>> > > >  * Precopy with UNIX sockets and dirty ring tracking
>> > >=20
>> > > ... dirty ring...
>> > >=20
>> > > >  * Precopy with XBZRLE
>> > >=20
>> > > ... xbzrle I think needs a diff on old/new, makes sense.
>> > >=20
>> > > >  * Precopy with UNIX compress
>> > > >  * Precopy with UNIX compress (nowait)
>> > > >  * Precopy with multifd
>> > >=20
>> > > What about the rest three?  Especially for two compression tests.
>> >=20
>> > The compress thread logic is unique/interesting during RAM transfer
>> > so benefits from running live. The wait vs non-wait scenario tests
>> > a distinct codepath/logic.
>>=20
>> I assume you mean e.g. when compressing with guest page being modified a=
nd
>> we should survive that rather than crashing the compressor?
>
> No, i mean the compression code has a significant behaviour difference
> between its two tests, because they toggle:
>
>  @compress-wait-thread: Controls behavior when all compression
>      threads are currently busy.  If true (default), wait for a free
>      compression thread to become available; otherwise, send the page
>      uncompressed.  (Since 3.1)
>
> so we need to exercise the code path that falls back to sending
> uncompressed, as well as the code path that waits for free threads.

It don't work.
I think that I am going to just drop it for this iteration.

I tried 2 or 3 years ago to get a test to run to compression -> was not
able to get it to work.

Moved compression on top of multifd, much, much faster and much cleaner
(each compression method is around 50 lines of code).

Lukas tried this time and he was not able to get it working either.

So I have no hope at all for this code.

To add insult to injury, it copies things so many times that is just not
worthy.

Later, Juan.


