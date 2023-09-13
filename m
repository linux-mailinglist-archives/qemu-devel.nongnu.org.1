Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A573079EB43
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 16:39:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgR0c-0002jl-Bg; Wed, 13 Sep 2023 10:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgR0a-0002jX-NV
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:38:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgR0Y-0003YP-Cn
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694615901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FpwXsWLcXJVVONe30Ss+FgcMwnZiVWW3B4foIJpqEmQ=;
 b=ZvplY5cpaEF5o1jjHD2d8tCJWmMeR0sa5TTCmqxYVoXJpTLxsb/p/hghTuYwcN8Fhh/1/M
 cX68GhN/4BdnMc6n2futlevj0ZiJQ4y1dbtGYSgDfkqQlU/OHwkYi9baO07K5yT2H8Jwrg
 l7Bfu0Pl7gFJDKfqamk4v4qaNIvfl48=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-JIkYo4RCNpyEn-dhmSF8GQ-1; Wed, 13 Sep 2023 10:38:20 -0400
X-MC-Unique: JIkYo4RCNpyEn-dhmSF8GQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76f191e26f5so180528585a.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 07:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694615899; x=1695220699;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FpwXsWLcXJVVONe30Ss+FgcMwnZiVWW3B4foIJpqEmQ=;
 b=jIM38R5LeSPjQostlliDmp+lIMZHzYfa1HXGcFIzHc48/4wMOhdHFxGbg8FuiKKarI
 +JMiIL+nXOqi3YNYNouumL199smVehAD5pQdNvqREPTiwLJ5E7h3+W2dSIWv2AbzDltO
 Ghp/QyC6v0Ym65WY32PgxhMP8ohGxiOJRiO8y/UagIczWaacVrXmTUDj3+fBKLVvfHBi
 q565wNejgWXjXm1mMpvAC4OyXVZh0X2+5f+KUXM2gYs5qNWWTIDbwFPkHBCFzPswL6LS
 RObkqmRSmMKHf7h1AkLe8E93Ve6Abo8U0bqpyFK0QLH9LgymPtMv7OwFlrGHqNpIG3Tc
 m82g==
X-Gm-Message-State: AOJu0YxDVVFH9LHd4HvaAMdspID3pfRJFiiiD4YK1XAW1B5OuCtf14yt
 +gN6L5Y8wdWQF4Ox/KlsvPnayxCio6WtN/uwrGCm0BUvvTm0s6V5cdRJYKGkG2GqQks2Desd9mN
 FfS/+potNndQN5/k=
X-Received: by 2002:a05:620a:3187:b0:76f:1b38:e74a with SMTP id
 bi7-20020a05620a318700b0076f1b38e74amr2666011qkb.4.1694615899762; 
 Wed, 13 Sep 2023 07:38:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTnwnOiKeIodhvbeLFQiUZyyWqs4hp+aek6JwJ9eqc1SlW/gaP8WWDG4utEyOVZ6fmzAd/QQ==
X-Received: by 2002:a05:620a:3187:b0:76f:1b38:e74a with SMTP id
 bi7-20020a05620a318700b0076f1b38e74amr2665994qkb.4.1694615899402; 
 Wed, 13 Sep 2023 07:38:19 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 v6-20020a05620a122600b007676f3859fasm3971380qkj.30.2023.09.13.07.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 07:38:19 -0700 (PDT)
Date: Wed, 13 Sep 2023 10:38:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v2 11/11] tests/migration-test: Add a test for postcopy
 hangs during RECOVER
Message-ID: <ZQHJWrX85YY9pjVM@x1n>
References: <20230912222145.731099-1-peterx@redhat.com>
 <20230912222145.731099-12-peterx@redhat.com>
 <87wmwujghq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmwujghq.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Sep 13, 2023 at 11:27:13AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> >  
> > +static void wait_for_postcopy_status(QTestStatus *one, const char *status)
> > +{
> 
> QTestState *who
> 
> > +    wait_for_migration_status(from, status,
> 
> s/from/who
> 
> > +                              (const char * []) { "failed", "active",
> > +                                                  "completed", NULL });
> > +}
> > +
> > +static void postcopy_recover_fail(QTestState *from, QTestState *to)
> > +{
> > +    int ret, pair1[2], pair2[2];
> > +    char c;
> > +
> > +    /* Create two unrelated socketpairs */
> > +    ret = qemu_socketpair(PF_LOCAL, SOCK_STREAM, 0, pair1);
> > +    g_assert_cmpint(ret, ==, 0);
> > +
> > +    ret = qemu_socketpair(PF_LOCAL, SOCK_STREAM, 0, pair2);
> > +    g_assert_cmpint(ret, ==, 0);
> > +
> > +    /*
> > +     * Give the guests unpaired ends of the sockets, so they'll all blocked
> > +     * at reading.  This mimics a wrong channel established.
> > +     */
> > +    qtest_qmp_fds_assert_success(from, &pair1[0], 1,
> > +                                 "{ 'execute': 'getfd',"
> > +                                 "  'arguments': { 'fdname': 'fd-mig' }}");
> > +    qtest_qmp_fds_assert_success(to, &pair2[0], 1,
> > +                                 "{ 'execute': 'getfd',"
> > +                                 "  'arguments': { 'fdname': 'fd-mig' }}");
> > +
> > +    /*
> > +     * Write the 1st byte as QEMU_VM_COMMAND (0x8) for the dest socket, to
> > +     * emulate the 1st byte of a real recovery, but stops from there to
> > +     * keep dest QEMU in RECOVER.  This is needed so that we can kick off
> > +     * the recover process on dest QEMU (by triggering the G_IO_IN event).
> > +     *
> > +     * NOTE: this trick is not needed on src QEMUs, because src doesn't
> > +     * rely on an pre-existing G_IO_IN event, so it will always trigger the
> > +     * upcoming recovery anyway even if it can read nothing.
> > +     */
> > +#define QEMU_VM_COMMAND              0x08
> > +    c = QEMU_VM_COMMAND;
> > +    ret = send(pair2[1], &c, 1, 0);
> > +    g_assert_cmpint(ret, ==, 1);
> > +
> > +    migrate_recover(to, "fd:fd-mig");
> > +    migrate_qmp(from, "fd:fd-mig", "{'resume': true}");
> > +
> > +    /*
> > +     * Make sure both QEMU instances will go into RECOVER stage, then test
> > +     * kicking them out using migrate-pause.
> > +     */
> > +    wait_for_postcopy_status(from, "postcopy-recover")
> 
> semicolon

Sorry, I forgot to amend into this patch when I last touched the
bits.. here's the diff I'll amend into it:

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 6105c2da65..de5aa90483 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1358,9 +1358,9 @@ static void test_postcopy_preempt_tls_psk(void)
 }
 #endif
 
-static void wait_for_postcopy_status(QTestStatus *one, const char *status)
+static void wait_for_postcopy_status(QTestState *one, const char *status)
 {
-    wait_for_migration_status(from, status,
+    wait_for_migration_status(one, status,
                               (const char * []) { "failed", "active",
                                                   "completed", NULL });
 }
@@ -1410,7 +1410,7 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
      * Make sure both QEMU instances will go into RECOVER stage, then test
      * kicking them out using migrate-pause.
      */
-    wait_for_postcopy_status(from, "postcopy-recover")
+    wait_for_postcopy_status(from, "postcopy-recover");
     wait_for_postcopy_status(to, "postcopy-recover");
 
     /*

-- 
Peter Xu


