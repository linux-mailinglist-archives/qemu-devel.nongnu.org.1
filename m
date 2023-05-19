Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B4F709E93
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 19:52:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q04H8-0006fO-E4; Fri, 19 May 2023 13:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q04H6-0006fG-ML
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:52:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q04H4-000598-RM
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684518737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t09Dq5VurfFflxzaTZKr0bStfAuoXbopn2trMkMowLs=;
 b=XmPyKDmKLu1r9z9Vrj5yIEJYKhu9qGS0zSpu8yjDaPtbfhqAdv5VSdRIhKC6hGPCKaZkjz
 Yhwxnfltm5nVxdNedw1X0qjj/DC/orEHyQM/stkukiWrGRVL6Qggjron4D/yPWeGzhGHsF
 6pmcZniJXenEOtR25VByDLIF0FKn7bU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-Coch_jQmPMm-u27gFS4k9Q-1; Fri, 19 May 2023 13:52:16 -0400
X-MC-Unique: Coch_jQmPMm-u27gFS4k9Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCB953C01DB1;
 Fri, 19 May 2023 17:52:15 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF878492B0A;
 Fri, 19 May 2023 17:52:14 +0000 (UTC)
Date: Fri, 19 May 2023 12:52:12 -0500
From: Eric Blake <eblake@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH v2 09/19] test-cutils: Add coverage of qemu_strtod
Message-ID: <uc3cbsxtikz3icrxkct2ry4xowmtxm5fvkrnmfiufjb7xt3ncw@bt2xoq3qqbiu>
References: <20230512021033.1378730-1-eblake@redhat.com>
 <20230512021033.1378730-10-eblake@redhat.com>
 <2e230e7f-694f-6b4e-2fcf-7504532581ed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e230e7f-694f-6b4e-2fcf-7504532581ed@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, May 19, 2023 at 05:05:20PM +0200, Hanna Czenczek wrote:
> On 12.05.23 04:10, Eric Blake wrote:
> > It's hard to tweak code for consistency if I can't prove what will or
> > won't break from those tweaks.  Time to add unit tests for
> > qemu_strtod() and qemu_strtod_finite().
> > 
> > Among other things, I wrote a check whether we have C99 semantics for
> > strtod("0x1") (which MUST parse hex numbers) rather than C89 (which
> > must stop parsing at 'x').  These days, I suspect that is okay; but if
> > it fails CI checks, knowing the difference will help us decide what we
> > want to do about it.  Note that C2x, while not final at the time of
> > this patch, has been considering whether to make strtol("0b1") parse
> > as 1 with no slop instead of the C17 parse of 0 with slop "b1"; that
> > decision may also bleed over to strtod().  But for now, I didn't think
> > it worth adding unit tests on that front (to strtol or strtod) as
> > things may still change.
> > 
> > Likewise, there are plenty more corner cases of strtod proper that I
> > don't explicitly test here, but there are enough unit tests added here
> > that it covers all the branches reached in our wrappers.  In
> > particular, it demonstrates the difference on when *value is left
> > uninitialized, which an upcoming patch will normalize.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > 
> > ---
> > 
> > v2: Added g_assert_false(signbit(res)) anywhere I used
> > g_assert_cmpfloat(res,==,0.0); add a test for strtod() hex parsing and
> > handling of junk after ERANGE, which is major enough that I dropped
> > R-b
> > ---
> >   tests/unit/test-cutils.c | 510 +++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 510 insertions(+)
> > 
> > diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
> > index d3076c3fec1..1763839a157 100644
> > --- a/tests/unit/test-cutils.c
> > +++ b/tests/unit/test-cutils.c
> 
> [...]
> 
> > +static void test_qemu_strtod_erange_junk(void)
> > +{
> > +    const char *str;
> > +    const char *endptr;
> > +    int err;
> > +    double res;
> > +
> > +    /* EINVAL has priority over ERANGE */
> 
> By being placed here, this comment confused me a bit, because the first case
> does return ERANGE.  So I’d prefer it above the second case, where we
> actually expect EINVAL, but understand that’s a personal preference.  (Same
> for the _finite_ variant)

The test is what happens when both conditions apply.  For
qemu_strtod("1e-999junk", &endptr), only ERANGE applies (because
"junk" is returned in endptr); it is not until
qemu_strtod("1e-999junk", NULL) where EINVAL is also possible
(trailing junk takes precedence over underflow).  For qemu_strtosz(),
I made it a bit more obvious by writing a helper function that shows
both errno values in a single line, rather than spreading out the
boilerplate over multiple lines.

Should I do a similar helper function for qemu_strtod[_finite] in v3?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


