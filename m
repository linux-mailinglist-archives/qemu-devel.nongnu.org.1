Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E498A7CF144
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 09:30:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtNUE-0000H9-G3; Thu, 19 Oct 2023 03:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qtNUC-0000Gt-QZ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:30:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qtNUA-0000gH-9j
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697700625;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=KvL2AJoaYw9ET1W915t7GQD4l5xEN2AJ8dhNdcFdIoI=;
 b=DqSYvGNWi9LyQGr/xZdwjyDM9gdKYPS3FrW3TiYhhxjsdU9PoDowp2MZIJzbgxB2KIvb1g
 P6WJirzlV9TouOzg3qBLoOAzIkjdPqw9xlOxug2fWwLolcgfRBJcJcgehgBDK3sP3WKpq/
 ESvnBfGvNNt00qt4yZN4Ti8qLFZlQuU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-fe13NvMQOFyYHVehSbEXKQ-1; Thu, 19 Oct 2023 03:30:18 -0400
X-MC-Unique: fe13NvMQOFyYHVehSbEXKQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76AEC282380D
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 07:30:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64C5D492BFA;
 Thu, 19 Oct 2023 07:30:17 +0000 (UTC)
Date: Thu, 19 Oct 2023 08:30:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Victor Toso <victortoso@redhat.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v2 02/11] scripts: qapi: black format main.py
Message-ID: <ZTDbB/VR1NkuDOYf@redhat.com>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-3-victortoso@redhat.com>
 <87pm1crya0.fsf@pond.sub.org>
 <iwlndli3c4waxnjgtvyo6bi52vc4nundupqkrjeufwilua22s2@rh4j2jk26htq>
 <878r7zmalt.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878r7zmalt.fsf@pond.sub.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Oct 19, 2023 at 07:42:38AM +0200, Markus Armbruster wrote:
> Victor Toso <victortoso@redhat.com> writes:
> 
> > On Wed, Oct 18, 2023 at 01:00:07PM +0200, Markus Armbruster wrote:
> >> Victor Toso <victortoso@redhat.com> writes:
> >> 
> >> > flake8 complained:
> >> >     ./main.py:60:1: E302 expected 2 blank lines, found 1
> >> >
> >> > Which is simple enough. My vim has black [0] enabled by default, so it
> >> > did some extra formatting. I'm proposing to follow it.
> >> >
> >> > [0] https://black.readthedocs.io/en/stable/
> >> >
> >> > Signed-off-by: Victor Toso <victortoso@redhat.com>
> >> > ---
> >> >  scripts/qapi/main.py | 76 ++++++++++++++++++++++++++++----------------
> >> >  1 file changed, 48 insertions(+), 28 deletions(-)
> >> 
> >> Is this all black hates about scripts/qapi/?
> >
> > No, just scripts/qapi/main.py.
> >
> >> Did you configure it in any way, and if yes, how?
> >
> > Only to reduce line length to 79.
> >
> > I can do a separate series for this, if the idea is accepted.
> 
> Let's build a rough idea of how much churn this would be.
> 
> We have a bit over 5000 lines:
> 
>     $ wc -l scripts/qapi/*py
>        419 scripts/qapi/commands.py
>        251 scripts/qapi/common.py
>         50 scripts/qapi/error.py
>        251 scripts/qapi/events.py
>        679 scripts/qapi/expr.py
>        368 scripts/qapi/gen.py
>        390 scripts/qapi/introspect.py
>        103 scripts/qapi/main.py
>        777 scripts/qapi/parser.py
>       1233 scripts/qapi/schema.py
>         71 scripts/qapi/source.py
>        387 scripts/qapi/types.py
>        429 scripts/qapi/visit.py
>       5408 total
> 
> Feed them to black:
> 
>     $ black -q -l 75 scripts/qapi
>     $ git-diff --stat
>      scripts/qapi/commands.py   | 448 +++++++++++++++++-----------
>      scripts/qapi/common.py     | 240 ++++++++++-----
>      scripts/qapi/error.py      |  15 +-
>      scripts/qapi/events.py     | 274 +++++++++++-------
>      scripts/qapi/expr.py       | 409 ++++++++++++++++----------
>      scripts/qapi/gen.py        | 187 +++++++-----
>      scripts/qapi/introspect.py | 323 +++++++++++++--------
>      scripts/qapi/main.py       |  80 +++--
>      scripts/qapi/parser.py     | 370 +++++++++++++----------
>      scripts/qapi/schema.py     | 709 +++++++++++++++++++++++++++++----------------
>      scripts/qapi/source.py     |  17 +-
>      scripts/qapi/types.py      | 369 ++++++++++++++---------
>      scripts/qapi/visit.py      | 355 ++++++++++++++---------
>      13 files changed, 2383 insertions(+), 1413 deletions(-)
> 
> *Ouch*
> 
> Peeking at the result, I see string quote normalization.  Try again with
> that switched off, and the line length relaxed:
> 
>     $ black -q -l 79 -S scripts/qapi
>     $ git-diff --stat
>      scripts/qapi/commands.py   | 357 +++++++++++++++++++++------------
>      scripts/qapi/common.py     | 170 ++++++++++++----
>      scripts/qapi/error.py      |  11 +-
>      scripts/qapi/events.py     | 220 +++++++++++++-------
>      scripts/qapi/expr.py       | 261 +++++++++++++++---------
>      scripts/qapi/gen.py        | 114 ++++++-----
>      scripts/qapi/introspect.py | 231 +++++++++++++--------
>      scripts/qapi/main.py       |  72 ++++---
>      scripts/qapi/parser.py     | 224 ++++++++++++---------
>      scripts/qapi/schema.py     | 488 +++++++++++++++++++++++++++++++--------------
>      scripts/qapi/source.py     |   7 +-
>      scripts/qapi/types.py      | 303 ++++++++++++++++++----------
>      scripts/qapi/visit.py      | 287 ++++++++++++++++----------
>      13 files changed, 1802 insertions(+), 943 deletions(-)
> 
> Still massive churn.

FWIW, the .git-blame-ignore-revs file can be populated with commit
hashes afterwards, to make 'git blame' ignore the reformatting
changes. Doesn't help with people cherry-picking fixes to old
branches though, which is the other main downside of such churn.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


