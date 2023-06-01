Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B38A719C3C
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:35:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hVt-0007Bo-PP; Thu, 01 Jun 2023 08:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4hVq-00075W-7J
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4hVo-0002hE-FB
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685622879;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5rpB/iXUruvn6S1g+N4l8YVtbGVo5mUuVVBCm6B92pI=;
 b=TdVJMBc/XvFeaZ+viFDkenNjpO3YAh1KXadDipe4ekW4vFL4+4AQo0emjKCVBm24DJjfqf
 t4SX95q5Zr/3txwiqzR6Jyg2+egsgogCIapE6EG2HIRloKqgbipfei0FyH1Zqk1DF0VYd4
 y3sPulOn2OMoBxbr8hsqasxN4f/fxbA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-y-v_MN43My6YsJYvDcgkTg-1; Thu, 01 Jun 2023 08:34:37 -0400
X-MC-Unique: y-v_MN43My6YsJYvDcgkTg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57452185A792
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 12:34:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 213342166B25;
 Thu,  1 Jun 2023 12:34:36 +0000 (UTC)
Date: Thu, 1 Jun 2023 13:34:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 7/9] tests/qtest: capture RESUME events during migration
Message-ID: <ZHiQWcv2xeVPte1d@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-8-berrange@redhat.com>
 <87edmvs6su.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87edmvs6su.fsf@secure.mitica>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

On Thu, Jun 01, 2023 at 02:31:13PM +0200, Juan Quintela wrote:
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> > When running migration tests we monitor for a STOP event so we can skip
> > redundant waits. This will be needed for the RESUME event too shortly.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  tests/qtest/migration-helpers.c | 12 ++++++++++++
> >  tests/qtest/migration-helpers.h |  2 ++
> >  tests/qtest/migration-test.c    |  5 +++++
> >  3 files changed, 19 insertions(+)
> >
> > diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> > index 884d8a2e07..d50b565967 100644
> > --- a/tests/qtest/migration-helpers.c
> > +++ b/tests/qtest/migration-helpers.c
> > @@ -35,6 +35,18 @@ bool migrate_watch_for_stop(QTestState *who, const char *name,
> >      return false;
> >  }
> >  
> > +bool migrate_watch_for_resume(QTestState *who, const char *name,
> > +                              QDict *event, void *opaque)
> > +{
> > +    bool *seen = opaque;
> > +
> > +    if (g_str_equal(name, "RESUME")) {
> > +        *seen = true;
> > +    }
> > +
> > +    return false;
> > +}
> > +
> 
> I think I am not understanding this.
> 
> Can we wait for both RESUME and STOP events?
> 
> Or do you want an implementation that can only look for one event?

For the purpose of the migration test we only need the STOP event
on the src and the RESUME event on the dst. While I could have made
it track both STOP and RESUME events on both src & dst, I figured
it was overkill.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


