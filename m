Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D9D709B11
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:17:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01r4-0002Sb-Eu; Fri, 19 May 2023 11:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q01qv-0002Q4-3f
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q01qs-0004TB-Mo
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684509425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vl1r6HJ5E5vFtdAQVEl3FLJvzbWYjZFyZOIHe3KqOgY=;
 b=ZpwMzcStH6j/uQ1+RB84kT8gdwwi9lmH/jQDZymWsbCZ0/NT6c+R60b/++py25Q7fJWXqw
 N9HQZmLC+aT/7SIrfQkWZ4oL7D69nd2VnKDXI2/NSfD/bRJ034zs5jJi7umccHO7YJqf/4
 QU2jhh+LVAo2614qN4ZCamcZJ/+c7xw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-5F70q8WVOdG1dRmaUF0l8A-1; Fri, 19 May 2023 11:17:04 -0400
X-MC-Unique: 5F70q8WVOdG1dRmaUF0l8A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 335E7858299;
 Fri, 19 May 2023 15:17:04 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9B1340CFD45;
 Fri, 19 May 2023 15:17:03 +0000 (UTC)
Date: Fri, 19 May 2023 10:17:01 -0500
From: Eric Blake <eblake@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH v2 04/19] test-cutils: Test more integer corner cases
Message-ID: <jpuwow2gu5ooo4jlgz3lbyj3wilsqv2atwshtm2dpdnrrhbuix@jsqihr4nuyv3>
References: <20230512021033.1378730-1-eblake@redhat.com>
 <20230512021033.1378730-5-eblake@redhat.com>
 <0fd2fa2b-dfd5-7c22-e6de-7e018868c8ce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fd2fa2b-dfd5-7c22-e6de-7e018868c8ce@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

On Fri, May 19, 2023 at 04:27:10PM +0200, Hanna Czenczek wrote:
> On 12.05.23 04:10, Eric Blake wrote:
> > We have quite a few undertested and underdocumented integer parsing
> > corner cases.  To ensure that any changes we make in the code are
> > intentional rather than accidental semantic changes, it is time to add
> > more unit tests of existing behavior.
> > 
> > In particular, this demonstrates that parse_uint() and qemu_strtou64()
> > behave differently.  For "-0", it's hard to argue why parse_uint needs
> > to reject it (it's not a negative integer), but the documentation sort
> > of mentions it; but it is intentional that all other negative values
> > are treated as ERANGE with value 0 (compared to qemu_strtou64()
> > treating "-2" as success and UINT64_MAX-1, for example).
> > 
> > Also, when mixing overflow/underflow with a check for no trailing
> > junk, parse_uint_full favors ERANGE over EINVAL, while qemu_strto[iu]*
> > favor EINVAL.  This behavior is outside the C standard, so we can pick
> > whatever we want, but it would be nice to be consistent.
> > 
> > Note that C requires that "9223372036854775808" fail strtoll() with
> > ERANGE/INT64_MAX, but "-9223372036854775808" pass with INT64_MIN; we
> > weren't testing this.  For strtol(), the behavior depends on whether
> > long is 32- or 64-bits (the cutoff point either being the same as
> > strtoll() or at "-2147483648").  Meanwhile, C is clear that
> > "-18446744073709551615" pass stroull() (but not strtoll) with value 1,
> > even though we want it to fail parse_uint().  And although
> > qemu_strtoui() has no C counterpart, it makes more sense if we design
> > it like 32-bit strtoul() (that is, where "-4294967296" be an alternate
> > acceptable spelling for "1".  We aren't there yet, so some of the
> > tests added in this patch have FIXME comments.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >   tests/unit/test-cutils.c | 799 ++++++++++++++++++++++++++++++++++++---
> >   1 file changed, 738 insertions(+), 61 deletions(-)
> > 
> > diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
> > index 1eeaf21ae22..89c10f5307a 100644
> > --- a/tests/unit/test-cutils.c
> > +++ b/tests/unit/test-cutils.c
> 
> [...]
> 
> > @@ -717,34 +890,75 @@ static void test_qemu_strtoui_max(void)
> > 
> >   static void test_qemu_strtoui_overflow(void)
> >   {
> > -    char *str = g_strdup_printf("%lld", (long long)UINT_MAX + 1ll);
> > -    char f = 'X';
> > -    const char *endptr = &f;
> > -    unsigned int res = 999;
> > +    const char *str;
> > +    const char *endptr;
> > +    unsigned int res;
> >       int err;
> > 
> > +    str = "4294967296"; /* UINT_MAX + 1ll */
> > +    endptr = "somewhere";
> > +    res = 999;
> >       err = qemu_strtoui(str, &endptr, 0, &res);
> > +    g_assert_cmpint(err, ==, -ERANGE);
> > +    g_assert_cmpint(res, ==, UINT_MAX);
> 
> Why cmpint and not cmpuint here?  (I see you’re using cmpint instead of
> cmpuint in many strtou* test functions below, too.)

Probably a combination of copy-paste vs rebase patch re-ordering.
Yes, all test_*strtoui* tests should be using
g_assert_cmpuint(res...).  Will fix.

> 
> [...]
> 
> > @@ -1325,31 +1697,67 @@ static void test_qemu_strtoul_max(void)
> 
> [...]
> 
> >   static void test_qemu_strtoul_underflow(void)
> >   {
> > -    const char *str = "-99999999999999999999999999999999999999999999";
> > -    char f = 'X';
> > -    const char *endptr = &f;
> > -    unsigned long res = 999;
> > +    const char *str;
> > +    const char *endptr;
> > +    unsigned long res;
> >       int err;
> > 
> > +    /* 1 less than -ULONG_MAX */
> > +    str = ULONG_MAX == UINT_MAX ? "-4294967297" : "-18446744073709551617";
> 
> Technically these are 2 less than -ULONG_MAX, not 1 less.

Indeed.  Both constants should end in 6, not 7.  Will fix.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


