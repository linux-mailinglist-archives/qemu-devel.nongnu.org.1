Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27543709C7E
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 18:32:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q030v-00081h-Rp; Fri, 19 May 2023 12:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q030j-00081K-Bq
 for qemu-devel@nongnu.org; Fri, 19 May 2023 12:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q030h-0000P3-07
 for qemu-devel@nongnu.org; Fri, 19 May 2023 12:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684513877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MTsxnNpC9tQ63h558SSxGh4yihZxonqdHPCEx91Ciro=;
 b=I3kT+tYom4FPq3bzuYkFOMrMimj5emTJpi0FAn5oRZlsNKbnJr+GYhHz/4WpY6+3zjLZFj
 /0LTZ6EofNHExO4p9v60RBZeQOi1ie8H+FupMFPSyvQqlgxRJJBmSNRVtre25h8v1kpxJo
 0lC5JQ2xvM+vriqsabOxaBOkxX54mNk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-Xl9zK7U5MAiOC99qLSm1oA-1; Fri, 19 May 2023 12:31:09 -0400
X-MC-Unique: Xl9zK7U5MAiOC99qLSm1oA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BDCC3C11C62;
 Fri, 19 May 2023 16:31:09 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F20B5C0004B;
 Fri, 19 May 2023 16:31:08 +0000 (UTC)
Date: Fri, 19 May 2023 11:31:07 -0500
From: Eric Blake <eblake@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH v2 05/19] cutils: Fix wraparound parsing in qemu_strtoui
Message-ID: <oa4z4ecqiaocxyblq6jeshu4c3gyvfqpryynglt4ztra7hd7ct@3u52kspbuf5k>
References: <20230512021033.1378730-1-eblake@redhat.com>
 <20230512021033.1378730-6-eblake@redhat.com>
 <af74699e-9ce2-b9f9-2fef-e0b862e32833@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af74699e-9ce2-b9f9-2fef-e0b862e32833@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, May 19, 2023 at 04:42:11PM +0200, Hanna Czenczek wrote:
> On 12.05.23 04:10, Eric Blake wrote:
> > While we were matching 32-bit strtol in qemu_strtoi, our use of a
> > 64-bit parse was leaking through for some inaccurate answers in
> > qemu_strtoui in comparison to a 32-bit strtoul.  Fix those, and update
> > the testsuite now that our bounds checks are correct.
> > 
> > Our int wrappers would be a lot easier to write if libc had a
> > guaranteed 32-bit parser even on platforms with 64-bit long.
> > 
> > Fixes: 473a2a331e ("cutils: add qemu_strtoi & qemu_strtoui parsers for int/unsigned int types", v2.12.0)
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >   tests/unit/test-cutils.c | 11 +++++------
> >   util/cutils.c            | 14 ++++++++++----
> >   2 files changed, 15 insertions(+), 10 deletions(-)
> 
> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
> 
> > diff --git a/util/cutils.c b/util/cutils.c
> > index 5887e744140..997ddcd09e5 100644
> > --- a/util/cutils.c
> > +++ b/util/cutils.c
> > @@ -466,10 +466,16 @@ int qemu_strtoui(const char *nptr, const char **endptr, int base,

Adding context:

long long lresult;
...
lresult = strtoull(nptr, &ep, base);

> >       if (errno == ERANGE) {
> >           *result = -1;
> >       } else {
> > -        if (lresult > UINT_MAX) {
> > -            *result = UINT_MAX;
> > -            errno = ERANGE;
> > -        } else if (lresult < INT_MIN) {
> > +        /*
> > +         * Note that platforms with 32-bit strtoul accept input in the
> > +         * range [-4294967295, 4294967295]; but we used 64-bit
> > +         * strtoull which wraps -18446744073709551615 to 1.  Reject
> > +         * positive values that contain '-', and wrap all valid
> > +         * negative values.
> > +         */
> > +        if (lresult > UINT_MAX ||
> > +            lresult < -(long long)UINT_MAX ||
> > +            (lresult > 0 && memchr(nptr, '-', ep - nptr))) {
> >               *result = UINT_MAX;
> >               errno = ERANGE;
> >           } else {
> 
> Just a question whether I guessed correctly, because there’s no comment on
> the matter: We store the (supposedly unsigned) result of strtoull() in a
> signed long long because e.g. -1 is mapped to ULLONG_MAX, so the valid
> unsigned ranges would be [0, UINT_MAX] \cup [ULLONG_MAX - UINT_MAX + 1,
> ULLONG_MAX], which is more cumbersome to check than the [-UINT_MAX,
> UINT_MAX] range?  (And we’d need to exclude strings with - in them if
> ullresult > UINT_MAX rather than > 0, probably)

Yes.  Not only will I take that as a hint that I should improve my
commit message, but you have pointed out a hole in my unit testing and
which is not fixed here; namely, strings like "-0xffffffffffff0000"
are accepted when they should be rejected.

I'm thinking the commit message should be something along the lines of
the following:

Note that strtoull takes two input ranges that overlap into a single
output range: [-0xffffffffffffffff, -1] which maps to [1,
0xffffffffffffffff], and [0, 0xffffffffffffffff] maps to itself.  The
output value alone does not tell us whether the input was in the
desired range [-0xffffffff, 0xffffffff], or in one of the other two
ranges that also map to the desired range [-0xffffffffffffffff,
-0xffffffff00000001] and [0xffffffff00000001, 0xffffffffffffffff], so
we need to do some additional filtering.  Merely checking whether
strlen(input) is longer than strlen("-4294967295") is not going to
work, because ("000000000000000000000000000") is longer but in range;
but we can check for the presence or absence of '-' in the input being
inconsistent with the resulting sign when the number is cast as a
signed long long.

v3 of this series will come soon, once you finish finding anything
else in v2 I need to fix.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


