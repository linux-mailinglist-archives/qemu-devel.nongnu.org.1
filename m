Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0733719703
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:33:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4efy-0006ZY-Q9; Thu, 01 Jun 2023 05:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4efw-0006Z0-9l
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:32:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4efu-0007qy-HM
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685611973;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mHqInsRsVfn8uK1Ll5c2+gN2wUuqpY/xEmx5A3WVh94=;
 b=X+WJyxYN0y2+KRm2HxEp82urIA2hfRRBINzYYBaOkKsOhrBu4rGPDkyWXSz8Hyt/8DdJqE
 t1bWuQ8EsiiZQfSCVz6T8ncKgJmReA0ER+EnQsHD6axnrvcvgxb8OPMkILJNpElB398TV0
 1ovm+/IdiLMlSbFd6hYSRNYGW7Weiis=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-7iDlQ1VuMM-Qgm_z5vSBVw-1; Thu, 01 Jun 2023 05:32:52 -0400
X-MC-Unique: 7iDlQ1VuMM-Qgm_z5vSBVw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 763DF3C1412D
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 09:32:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE4732166B25;
 Thu,  1 Jun 2023 09:32:47 +0000 (UTC)
Date: Thu, 1 Jun 2023 10:32:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 3/9] tests/qtest: get rid of 'qmp_command' helper in
 migration test
Message-ID: <ZHhluk6cApCygV4S@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-4-berrange@redhat.com>
 <7e0f528c-ba81-068c-46b6-e0f3142ec1b8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e0f528c-ba81-068c-46b6-e0f3142ec1b8@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jun 01, 2023 at 11:26:46AM +0200, Thomas Huth wrote:
> On 31/05/2023 15.23, Daniel P. Berrangé wrote:
> > This function duplicates logic of qtest_qmp_assert_success_ref
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/qtest/migration-helpers.c | 22 ----------------------
> >   tests/qtest/migration-helpers.h |  3 ---
> >   tests/qtest/migration-test.c    | 29 +++++++++++++++--------------
> >   3 files changed, 15 insertions(+), 39 deletions(-)
> > 
> > diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> > index f6f3c6680f..bddf3f8d4d 100644
> > --- a/tests/qtest/migration-helpers.c
> > +++ b/tests/qtest/migration-helpers.c
> > @@ -85,28 +85,6 @@ QDict *wait_command(QTestState *who, const char *command, ...)
> >       return ret;
> >   }
> > -/*
> > - * Execute the qmp command only
> > - */
> > -QDict *qmp_command(QTestState *who, const char *command, ...)
> > -{
> > -    va_list ap;
> > -    QDict *resp, *ret;
> > -
> > -    va_start(ap, command);
> > -    resp = qtest_vqmp(who, command, ap);
> > -    va_end(ap);
> > -
> > -    g_assert(!qdict_haskey(resp, "error"));
> 
> What about this g_assert(!qdict_haskey(resp, "error")) ?
> qtest_qmp_assert_success_ref() does not have this assert... do we still need
> it somewhere? If not, please add a comment to the patch description why it
> can be ignored now.

The caller just wants the 'return' field data. If that is missing,
qtest_qmp_assert_success_ref() will issue the diagnostic message
printing the entire QMP resposne, which is way more debuggable
than just asserting on 'error' without printing the error contents

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


