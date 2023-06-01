Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D1D719C84
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:49:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hjg-0006pm-NY; Thu, 01 Jun 2023 08:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4hje-0006p9-D1
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:48:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4hjc-0005Lu-Hr
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685623734;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oGCRKGH7Sel7XbQn2kjvD2dIb6AkwZoOuyqdOeGxoN0=;
 b=LHSTYYINfzneYBVlrxFwUTXotaL+fd4/Rz+xeA5Wa/DjKoKoVxS1GAlzQ/viZ7v3pwpBJa
 imtaU26ASteAZpXQyOOSJS9C6uIehwIylXFpDKTtd+OHT2lPgDaQp4nR5vRrn5k81dKvaV
 kkdilqCO/y/X/zOwmo6+joIhXEanxaw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-mZQ-tqpOPVGUdVZOpqtVgA-1; Thu, 01 Jun 2023 08:48:53 -0400
X-MC-Unique: mZQ-tqpOPVGUdVZOpqtVgA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE58328135A0
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 12:48:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4BD5C154D7;
 Thu,  1 Jun 2023 12:48:51 +0000 (UTC)
Date: Thu, 1 Jun 2023 13:48:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 1/9] tests/qtest: add various
 qtest_qmp_assert_success() variants
Message-ID: <ZHiTsRKrG24QojEM@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-2-berrange@redhat.com>
 <629f6745-6c36-93a9-8ebe-a8a83fd154c7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <629f6745-6c36-93a9-8ebe-a8a83fd154c7@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Thu, Jun 01, 2023 at 11:23:01AM +0200, Thomas Huth wrote:
> On 31/05/2023 15.23, Daniel P. Berrangé wrote:
> > Add several counterparts of qtest_qmp_assert_success() that can
> > 
> >   * Use va_list instead of ...
> >   * Accept a list of FDs to send
> >   * Return the response data
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/qtest/libqtest.c |  99 +++++++++++++++++++++++++++++++++--
> >   tests/qtest/libqtest.h | 115 +++++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 209 insertions(+), 5 deletions(-)


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
> > +    }
> > +    g_assert(qdict_haskey(response, "return"));
> > +    ret = qdict_get_qdict(response, "return");
> > +    qobject_ref(ret);
> > +    qobject_unref(response);
> > +
> > +    return ret;
> > +}
> > +
> > +void qtest_vqmp_fds_assert_success(QTestState *qts, int *fds, size_t nfds,
> > +                                   const char *fmt, va_list args)
> > +{
> > +    QDict *response;
> > +    response = qtest_vqmp_fds_assert_success_ref(qts, fds, nfds, fmt, args);
> >       qobject_unref(response);
> >   }
> 
> <bikeshedding>The ordering is a little bit inconsistent ... for some pairs,
> you do the _success() function first, and for some others you do the
> _success_ref() function first. IMHO it would be nicer to have the same
> ordering everywhere, preferably with the _success_ref() function first
> (since that's the one that is called from the other).</bikeshedding>

Sure, will do.

> 
> > +#endif /* !_WIN32 */
> > +
> > +void qtest_qmp_assert_success(QTestState *qts, const char *fmt, ...)
> > +{
> > +    QDict *response;
> > +    va_list ap;
> > +    va_start(ap, fmt);
> > +    response = qtest_vqmp_assert_success_ref(qts, fmt, ap);
> 
> You could use qtest_vqmp_assert_success() instead, I think, and dro the
> qobject_unref() below.

Agreed


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


