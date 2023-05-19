Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3337092EF
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:24:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwKu-0007qy-KB; Fri, 19 May 2023 05:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzwKs-0007qn-PX
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:23:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzwKn-0004Xw-2U
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684488215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O77d2ljDu6cS72/vSV7ePrKSjwMeChTyQBxdWh1ghJk=;
 b=AS4EnVm9UN4E8mkKo5lo8xxGB8Au/1CCevelzUMrxBnvJYq6/ZxcPuxMLQcHuiwDNkObDL
 MZzZbeBVXavMmxsAFW88jzh+Y1ooIJtinW5kynP4oE4n3kyKlM3ocNP9XfUV0wQNpueWRM
 5AbNgV8Ys5VI05tEyaun2wgX+rOpH9c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601--I0zw6JAPUyge_LQPQphLw-1; Fri, 19 May 2023 05:23:32 -0400
X-MC-Unique: -I0zw6JAPUyge_LQPQphLw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FE3185A5AA;
 Fri, 19 May 2023 09:23:32 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.158])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6110B1121314;
 Fri, 19 May 2023 09:23:31 +0000 (UTC)
Date: Fri, 19 May 2023 11:23:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 18/18] tested: add test for nested aio_poll() in poll
 handlers
Message-ID: <ZGdAEpLlO8GmQHr4@redhat.com>
References: <20230517165116.475123-1-kwolf@redhat.com>
 <20230517165116.475123-19-kwolf@redhat.com>
 <1d53f391-7fa4-f60d-119c-0cacb14209d6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d53f391-7fa4-f60d-119c-0cacb14209d6@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 17.05.2023 um 21:10 hat Richard Henderson geschrieben:
> On 5/17/23 09:51, Kevin Wolf wrote:
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > 
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Message-Id: <20230502184134.534703-3-stefanha@redhat.com>
> > Tested-by: Kevin Wolf <kwolf@redhat.com>
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   tests/unit/test-nested-aio-poll.c | 130 ++++++++++++++++++++++++++++++
> >   tests/unit/meson.build            |   1 +
> >   2 files changed, 131 insertions(+)
> >   create mode 100644 tests/unit/test-nested-aio-poll.c
> 
> This new test fails on windows:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/4304413315#L3375
> https://gitlab.com/qemu-project/qemu/-/jobs/4304413313#L3357

What the CI output doesn't show is that the problem seems to be that the
test doesn't even make sense on Windows. When I run it manually:

Unexpected error in aio_context_set_poll_params() at ../../home/kwolf/source/qemu/util/aio-win32.c:443:
Z:\tmp\build-win32\tests\unit\test-nested-aio-poll.exe: AioContext polling is not implemented on Windows

Stefan, I'll squash in the following, so you don't have to resubmit the
series.

Kevin


diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index a314f82baa..8ed81786ee 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -67,7 +67,6 @@ if have_block
     'test-coroutine': [testblock],
     'test-aio': [testblock],
     'test-aio-multithread': [testblock],
-    'test-nested-aio-poll': [testblock],
     'test-throttle': [testblock],
     'test-thread-pool': [testblock],
     'test-hbitmap': [testblock],
@@ -115,7 +114,10 @@ if have_block
     tests += {'test-crypto-xts': [crypto, io]}
   endif
   if 'CONFIG_POSIX' in config_host
-    tests += {'test-image-locking': [testblock]}
+    tests += {
+      'test-image-locking': [testblock],
+      'test-nested-aio-poll': [testblock],
+    }
   endif
   if config_host_data.get('CONFIG_REPLICATION')
     tests += {'test-replication': [testblock]}


