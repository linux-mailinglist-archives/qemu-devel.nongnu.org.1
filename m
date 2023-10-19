Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEEE7CEF37
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 07:43:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtLoA-0006kp-2Z; Thu, 19 Oct 2023 01:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtLnz-0006fO-3d
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 01:42:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtLnw-0006BP-Ao
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 01:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697694161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0U2XmuH3q2/kZr9UPnUhMG4FQ6QES1sDAXlE0cxMrEA=;
 b=gcnXCGUCZbRWlDjY5/PAm4MOyh4V/x+Cm8C42GKC4ILl+kkHQHoGq+YIswoxIOuMYasToY
 QArl4q13TK9EBTE545SXYDTrPUhEUXuig9aW1dqZv+EPtOhr7mWnWwlXYPYz0oQDc5IHMJ
 PGJHJ470q7f4B7WxYgsnbh1DbIk5gb8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-l8UQWnR3PVihqjh1_a9cvg-1; Thu, 19 Oct 2023 01:42:39 -0400
X-MC-Unique: l8UQWnR3PVihqjh1_a9cvg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 614B729AB41A
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 05:42:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 404D540C6F7B
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 05:42:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4FC1821E6A1F; Thu, 19 Oct 2023 07:42:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Andrea Bolognani
 <abologna@redhat.com>
Subject: Re: [PATCH v2 02/11] scripts: qapi: black format main.py
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-3-victortoso@redhat.com>
 <87pm1crya0.fsf@pond.sub.org>
 <iwlndli3c4waxnjgtvyo6bi52vc4nundupqkrjeufwilua22s2@rh4j2jk26htq>
Date: Thu, 19 Oct 2023 07:42:38 +0200
In-Reply-To: <iwlndli3c4waxnjgtvyo6bi52vc4nundupqkrjeufwilua22s2@rh4j2jk26htq>
 (Victor Toso's message of "Wed, 18 Oct 2023 17:23:27 +0200")
Message-ID: <878r7zmalt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

Victor Toso <victortoso@redhat.com> writes:

> On Wed, Oct 18, 2023 at 01:00:07PM +0200, Markus Armbruster wrote:
>> Victor Toso <victortoso@redhat.com> writes:
>> 
>> > flake8 complained:
>> >     ./main.py:60:1: E302 expected 2 blank lines, found 1
>> >
>> > Which is simple enough. My vim has black [0] enabled by default, so it
>> > did some extra formatting. I'm proposing to follow it.
>> >
>> > [0] https://black.readthedocs.io/en/stable/
>> >
>> > Signed-off-by: Victor Toso <victortoso@redhat.com>
>> > ---
>> >  scripts/qapi/main.py | 76 ++++++++++++++++++++++++++++----------------
>> >  1 file changed, 48 insertions(+), 28 deletions(-)
>> 
>> Is this all black hates about scripts/qapi/?
>
> No, just scripts/qapi/main.py.
>
>> Did you configure it in any way, and if yes, how?
>
> Only to reduce line length to 79.
>
> I can do a separate series for this, if the idea is accepted.

Let's build a rough idea of how much churn this would be.

We have a bit over 5000 lines:

    $ wc -l scripts/qapi/*py
       419 scripts/qapi/commands.py
       251 scripts/qapi/common.py
        50 scripts/qapi/error.py
       251 scripts/qapi/events.py
       679 scripts/qapi/expr.py
       368 scripts/qapi/gen.py
       390 scripts/qapi/introspect.py
       103 scripts/qapi/main.py
       777 scripts/qapi/parser.py
      1233 scripts/qapi/schema.py
        71 scripts/qapi/source.py
       387 scripts/qapi/types.py
       429 scripts/qapi/visit.py
      5408 total

Feed them to black:

    $ black -q -l 75 scripts/qapi
    $ git-diff --stat
     scripts/qapi/commands.py   | 448 +++++++++++++++++-----------
     scripts/qapi/common.py     | 240 ++++++++++-----
     scripts/qapi/error.py      |  15 +-
     scripts/qapi/events.py     | 274 +++++++++++-------
     scripts/qapi/expr.py       | 409 ++++++++++++++++----------
     scripts/qapi/gen.py        | 187 +++++++-----
     scripts/qapi/introspect.py | 323 +++++++++++++--------
     scripts/qapi/main.py       |  80 +++--
     scripts/qapi/parser.py     | 370 +++++++++++++----------
     scripts/qapi/schema.py     | 709 +++++++++++++++++++++++++++++----------------
     scripts/qapi/source.py     |  17 +-
     scripts/qapi/types.py      | 369 ++++++++++++++---------
     scripts/qapi/visit.py      | 355 ++++++++++++++---------
     13 files changed, 2383 insertions(+), 1413 deletions(-)

*Ouch*

Peeking at the result, I see string quote normalization.  Try again with
that switched off, and the line length relaxed:

    $ black -q -l 79 -S scripts/qapi
    $ git-diff --stat
     scripts/qapi/commands.py   | 357 +++++++++++++++++++++------------
     scripts/qapi/common.py     | 170 ++++++++++++----
     scripts/qapi/error.py      |  11 +-
     scripts/qapi/events.py     | 220 +++++++++++++-------
     scripts/qapi/expr.py       | 261 +++++++++++++++---------
     scripts/qapi/gen.py        | 114 ++++++-----
     scripts/qapi/introspect.py | 231 +++++++++++++--------
     scripts/qapi/main.py       |  72 ++++---
     scripts/qapi/parser.py     | 224 ++++++++++++---------
     scripts/qapi/schema.py     | 488 +++++++++++++++++++++++++++++++--------------
     scripts/qapi/source.py     |   7 +-
     scripts/qapi/types.py      | 303 ++++++++++++++++++----------
     scripts/qapi/visit.py      | 287 ++++++++++++++++----------
     13 files changed, 1802 insertions(+), 943 deletions(-)

Still massive churn.


