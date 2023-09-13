Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B8779E183
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 10:07:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKtc-0004e6-QF; Wed, 13 Sep 2023 04:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qgKtO-0004Xh-Th
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:06:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qgKtL-0005gO-Cg
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694592390;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2vypmGGO542FvhC+rqHXoTq9LwoWe2+pNCM7zeyfaQw=;
 b=ZSMwEMMvrLdIu9HfT24Czdg0/I+4MgtnZkGrJjgSP4ABxvUdffb6ILEWpzc0OeVrMu+vIY
 pAMk1i8EsVwjHg3Q3MU1geppbRjNFHPNErgrpKH/2HjWClfe3pzGSGNpVSJIEUkV2AcVz1
 nKBIa9eJQmBCDjXjNHmXyVSrdT6b+yA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-qA9ymuBYOx6QTK2s39N2wg-1; Wed, 13 Sep 2023 04:06:25 -0400
X-MC-Unique: qA9ymuBYOx6QTK2s39N2wg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 929B91818E43;
 Wed, 13 Sep 2023 08:06:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87A0D2156721;
 Wed, 13 Sep 2023 08:06:22 +0000 (UTC)
Date: Wed, 13 Sep 2023 09:06:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/4] microbit: add missing qtest_quit() call
Message-ID: <ZQFteR+kBmMzK7v2@redhat.com>
References: <20230912184130.3056054-1-berrange@redhat.com>
 <20230912184130.3056054-2-berrange@redhat.com>
 <61724857-2edd-e19b-aa37-23658cd4119b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61724857-2edd-e19b-aa37-23658cd4119b@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 12, 2023 at 12:10:19PM -0700, Richard Henderson wrote:
> On 9/12/23 11:41, Daniel P. Berrangé wrote:
> > Without this call, the QEMU process is being left running which on
> > FreeBSD 13.2 at least, makes meson think the test is still running,
> > and thus execution of "make check" continues forever.
> > 
> > This fixes the regression introduced in:
> > 
> >    commit a9c9bbee855877293683012942d3485d50f286af
> >    Author: Chris Laplante<chris@laplante.io>
> >    Date:   Tue Aug 22 17:31:02 2023 +0100
> > 
> >      qtest: microbit-test: add tests for nRF51 DETECT
> > 
> > Fixes:https://gitlab.com/qemu-project/qemu/-/issues/1882
> > Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> > ---
> >   tests/qtest/microbit-test.c | 2 ++
> >   1 file changed, 2 insertions(+)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> But I think that it's unfortunate that we have to remember this for each test.

We should use G_DEFINE_AUTOPTR_CLEANUP_FUNC for QTestState, and
then we can change tests to declare

   g_autoptr(QTestState) qts = qtest_init(....)

which will make it a bit more robust against forgotten cleanup.



We register an ABRT handler to kill off QEMU manually during
g_asserts().

The "death signal" code will give another layer of robustness
for exits too on Linux and now FreeBSD.

If we really wanted to we could add a 3rd layer of defence by
adding an atexit() handler, but I'm not sure this last one is
worth it for something we're not hitting frequently AFAIR.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


