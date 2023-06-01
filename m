Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF70E719C9B
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:52:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hmK-0000Ug-OL; Thu, 01 Jun 2023 08:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4hm6-0000U1-EN
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4hm2-0005ur-TY
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685623885;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6HuwFDx7VtQ9oN+4Pp6m3Bl201WKF8XyyT4u3qyNa4U=;
 b=c36EvS2lG9plmqokNHiKpfNlA0sFwU2kflRYn91Rd5ta2uNZs9+jIv7SD1JsFmGuwbztAl
 BBItLUK/WgFp5vpQMDOJaM1jFoKNNsZFI9Q7dhOHm9Q11uS1pfQ8YSIG9SvqN6zI/8u8Rs
 95D/XM3FWkJ8hHKLmQiyaRdLcPSNXxg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-tHD9YxAXObmS75JOHBjgjA-1; Thu, 01 Jun 2023 08:51:24 -0400
X-MC-Unique: tHD9YxAXObmS75JOHBjgjA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F1CA28135A1
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 12:51:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C254F492B0A;
 Thu,  1 Jun 2023 12:51:22 +0000 (UTC)
Date: Thu, 1 Jun 2023 13:51:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 1/9] tests/qtest: add various
 qtest_qmp_assert_success() variants
Message-ID: <ZHiUQsaac6Rkhk7p@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-2-berrange@redhat.com>
 <87r0qvs7al.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0qvs7al.fsf@secure.mitica>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jun 01, 2023 at 02:20:34PM +0200, Juan Quintela wrote:
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> > Add several counterparts of qtest_qmp_assert_success() that can
> >
> >  * Use va_list instead of ...
> >  * Accept a list of FDs to send
> >  * Return the response data
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  tests/qtest/libqtest.c |  99 +++++++++++++++++++++++++++++++++--
> >  tests/qtest/libqtest.h | 115 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 209 insertions(+), 5 deletions(-)
> >
> > diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> > index c3a0ef5bb4..603c26d955 100644
> > --- a/tests/qtest/libqtest.c
> > +++ b/tests/qtest/libqtest.c


> > +#ifndef _WIN32
> > +QDict *qtest_vqmp_fds_assert_success_ref(QTestState *qts, int *fds, size_t nfds,
> > +                                         const char *fmt, va_list args)
> > +{
> > +    QDict *response;
> > +    QDict *ret;
> > +
> > +    response = qtest_vqmp_fds(qts, fds, nfds, fmt, args);
> > +
> > +    g_assert(response);
> > +    if (!qdict_haskey(response, "return")) {
> > +        GString *s = qobject_to_json_pretty(QOBJECT(response), true);
> > +        g_test_message("%s", s->str);
> > +        g_string_free(s, true);
> 
> I know we are not consistent ot this file, but what about using autoptr here?
> 
>         g_autoptr(GString) *s = qobject_to_json_pretty(QOBJECT(response), true);
>         g_test_message("%s", s->str);
> 
> ??

Sure.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


