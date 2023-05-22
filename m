Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FA070BEF1
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 15:00:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q158u-00050J-7U; Mon, 22 May 2023 09:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q158r-0004zF-9l
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:00:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q158p-00059a-PU
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684760398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e7FH+lFBjtrL0PxBcSCFExiHC2AJWj4yNpUgJUeiQio=;
 b=iiH9ViBXqJ1sSMicsxdLPBMLTsJ31RPaytplpJEWNkyLmRtXZuDQiRae2octqU/R6wWBrX
 ZTvwXWsliK/W7lhnsj+4qq7jsl3fhiAs/rbxqHtpF0HGfjETu8ecNvjdBSnpBOtUf420ZV
 vw8k8Doqkby5iVLi+JWOtBEVXbdbA/o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-oM5jzJUsMJGxsasP5DMCYw-1; Mon, 22 May 2023 08:59:56 -0400
X-MC-Unique: oM5jzJUsMJGxsasP5DMCYw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B7513802366;
 Mon, 22 May 2023 12:59:56 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27BBE2166B25;
 Mon, 22 May 2023 12:59:56 +0000 (UTC)
Date: Mon, 22 May 2023 07:59:54 -0500
From: Eric Blake <eblake@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH v2 09/19] test-cutils: Add coverage of qemu_strtod
Message-ID: <go467is2thgiy45r4q74qrlyg4qo5owdwkpsnhxifhyomyu72b@adcwk2wqs6b5>
References: <20230512021033.1378730-1-eblake@redhat.com>
 <20230512021033.1378730-10-eblake@redhat.com>
 <2e230e7f-694f-6b4e-2fcf-7504532581ed@redhat.com>
 <uc3cbsxtikz3icrxkct2ry4xowmtxm5fvkrnmfiufjb7xt3ncw@bt2xoq3qqbiu>
 <935a5d04-5119-18c2-2b32-a77f3ac415f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <935a5d04-5119-18c2-2b32-a77f3ac415f5@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

On Mon, May 22, 2023 at 12:56:31PM +0200, Hanna Czenczek wrote:
> > > > +static void test_qemu_strtod_erange_junk(void)
> > > > +{
> > > > +    const char *str;
> > > > +    const char *endptr;
> > > > +    int err;
> > > > +    double res;
> > > > +
> > > > +    /* EINVAL has priority over ERANGE */
> > > By being placed here, this comment confused me a bit, because the first case
> > > does return ERANGE.  So I’d prefer it above the second case, where we
> > > actually expect EINVAL, but understand that’s a personal preference.  (Same
> > > for the _finite_ variant)
> > The test is what happens when both conditions apply.  For
> > qemu_strtod("1e-999junk", &endptr), only ERANGE applies (because
> > "junk" is returned in endptr); it is not until
> > qemu_strtod("1e-999junk", NULL) where EINVAL is also possible
> > (trailing junk takes precedence over underflow).
> 
> Yep; it’s just that because the comment is directly above one test case, I
> assumed it applied to just that case, and was looking for the EINVAL there. 
> Only then I realized that EINVAL won’t occur there, and the comment instead
> points out the difference between the two cases there are.
> 
> > For qemu_strtosz(),
> > I made it a bit more obvious by writing a helper function that shows
> > both errno values in a single line, rather than spreading out the
> > boilerplate over multiple lines.
> > 
> > Should I do a similar helper function for qemu_strtod[_finite] in v3?
> 
> I mean, from my perspective, all I can see is that it would make reviewing
> v3 more tedious…

Okay, v3 will NOT include a helper function for strtoi or strtod (but
the helper already in place for strtosz remains).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


