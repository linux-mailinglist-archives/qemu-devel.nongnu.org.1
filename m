Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB84717FB9
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:17:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Kk8-0004UO-DL; Wed, 31 May 2023 08:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4Kk5-0004U6-4h
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:15:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4Kk1-00085n-VJ
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685535349;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3pV/UV4Kb9xVrfXn8pAOVGn5RFKKAUPsu7OGq9tUlGM=;
 b=VgGvufyg8xLENgcTzNiTYMrARA9Z+tbmIyv5PRfj6H+f2TbqJwrSAYjWi+VfHU+d2t7Q19
 6efRX7HI8Yj7wa09EuyLlU7uX78PX+O2H1SuuLw4ldNhsWfNyvPjr5Jayn416fiuVZSbPa
 HXn75lPSK4IgQXgSDAd4WCrpDlfg/7s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-z8pIQbhYMSOvC88dcKEJgA-1; Wed, 31 May 2023 08:15:46 -0400
X-MC-Unique: z8pIQbhYMSOvC88dcKEJgA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3B71185A794;
 Wed, 31 May 2023 12:15:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 629C8C154D7;
 Wed, 31 May 2023 12:15:43 +0000 (UTC)
Date: Wed, 31 May 2023 13:15:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juan Quintela <quintela@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 4/6] tests/qtest: make more migration pre-copy
 scenarios run non-live
Message-ID: <ZHc6a+7881ExE0D/@redhat.com>
References: <20230421171411.566300-1-berrange@redhat.com>
 <20230421171411.566300-5-berrange@redhat.com>
 <87jzy1ro3z.fsf@suse.de> <ZHDzVe5rOSW2CX96@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHDzVe5rOSW2CX96@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

On Fri, May 26, 2023 at 06:58:45PM +0100, Daniel P. Berrangé wrote:
> On Mon, Apr 24, 2023 at 06:01:36PM -0300, Fabiano Rosas wrote:
> > Daniel P. Berrangé <berrange@redhat.com> writes:
> > 
> > > There are 27 pre-copy live migration scenarios being tested. In all of
> > > these we force non-convergance and run for one iteration, then let it
> > > converge and wait for completion during the second (or following)
> > > iterations. At 3 mbps bandwidth limit the first iteration takes a very
> > > long time (~30 seconds).
> > >
> > > While it is important to test the migration passes and convergance
> > > logic, it is overkill to do this for all 27 pre-copy scenarios. The
> > > TLS migration scenarios in particular are merely exercising different
> > > code paths during connection establishment.
> > >
> > > To optimize time taken, switch most of the test scenarios to run
> > > non-live (ie guest CPUs paused) with no bandwidth limits. This gives
> > > a massive speed up for most of the test scenarios.
> > >
> > > For test coverage the following scenarios are unchanged
> > >
> > >  * Precopy with UNIX sockets
> > >  * Precopy with UNIX sockets and dirty ring tracking
> > >  * Precopy with XBZRLE
> > >  * Precopy with multifd
> > >
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > ---
> > >  tests/qtest/migration-test.c | 60 ++++++++++++++++++++++++++++++------
> > >  1 file changed, 50 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> > > index 6492ffa7fe..40d0f75480 100644
> > > --- a/tests/qtest/migration-test.c
> > > +++ b/tests/qtest/migration-test.c
> > > @@ -568,6 +568,9 @@ typedef struct {
> > >          MIG_TEST_FAIL_DEST_QUIT_ERR,
> > >      } result;
> > >  
> > > +    /* Whether the guest CPUs should be running during migration */
> > > +    bool live;
> > > +
> > >      /* Postcopy specific fields */
> > >      void *postcopy_data;
> > >      bool postcopy_preempt;
> > > @@ -1324,8 +1327,6 @@ static void test_precopy_common(MigrateCommon *args)
> > >          return;
> > >      }
> > >  
> > > -    migrate_ensure_non_converge(from);
> > > -
> > >      if (args->start_hook) {
> > >          data_hook = args->start_hook(from, to);
> > >      }
> > > @@ -1335,6 +1336,31 @@ static void test_precopy_common(MigrateCommon *args)
> > >          wait_for_serial("src_serial");
> > >      }
> > >  
> > > +    if (args->live) {
> > > +        /*
> > > +         * Testing live migration, we want to ensure that some
> > > +         * memory is re-dirtied after being transferred, so that
> > > +         * we exercise logic for dirty page handling. We achieve
> > > +         * this with a ridiculosly low bandwidth that guarantees
> > > +         * non-convergance.
> > > +         */
> > > +        migrate_ensure_non_converge(from);
> > > +    } else {
> > > +        /*
> > > +         * Testing non-live migration, we allow it to run at
> > > +         * full speed to ensure short test case duration.
> > > +         * For tests expected to fail, we don't need to
> > > +         * change anything.
> > > +         */
> > > +        if (args->result == MIG_TEST_SUCCEED) {
> > > +            qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
> > > +            if (!got_stop) {
> > > +                qtest_qmp_eventwait(from, "STOP");
> > > +            }
> > > +            migrate_ensure_converge(from);
> > > +        }
> > > +    }
> > > +
> > >      if (!args->connect_uri) {
> > >          g_autofree char *local_connect_uri =
> > >              migrate_get_socket_address(to, "socket-address");
> > > @@ -1352,19 +1378,29 @@ static void test_precopy_common(MigrateCommon *args)
> > >              qtest_set_expected_status(to, EXIT_FAILURE);
> > >          }
> > >      } else {
> > > -        wait_for_migration_pass(from);
> > > +        if (args->live) {
> > > +            wait_for_migration_pass(from);
> > >  
> > > -        migrate_ensure_converge(from);
> > > +            migrate_ensure_converge(from);
> > >  
> > > -        /* We do this first, as it has a timeout to stop us
> > > -         * hanging forever if migration didn't converge */
> > > -        wait_for_migration_complete(from);
> > > +            /*
> > > +             * We do this first, as it has a timeout to stop us
> > > +             * hanging forever if migration didn't converge
> > > +             */
> > > +            wait_for_migration_complete(from);
> > > +
> > > +            if (!got_stop) {
> > > +                qtest_qmp_eventwait(from, "STOP");
> > > +            }
> > > +        } else {
> > > +            wait_for_migration_complete(from);
> > >  
> > > -        if (!got_stop) {
> > > -            qtest_qmp_eventwait(from, "STOP");
> > > +            qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
> > 
> > I retested and the problem still persists. The issue is with this wait +
> > cont sequence:
> > 
> > wait_for_migration_complete(from);
> > qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
> > 
> > We wait for the source to finish but by the time qmp_cont executes, the
> > dst is still INMIGRATE, autostart gets set and I never see the RESUME
> > event.
> 
> This is ultimately caused by the broken logic in the previous
> patch 3 that looked for RESUME. The loooking for the STOP would
> discard all non-STOP events, which includes the RESUME event
> we were just about to look for. I've had to completely change
> the event handling in migration-helpers and libqtest to fix this.

Actually, no it is not. The broken logic wouldn't help, but the root
cause was indeed a race condition that Fabiano points out. 

We are issuing the 'cont' before tgt QEMU has finished reading data
from the source.  The solution is actually quite simple - we must
call 'query-migrate' on dst to check its status. ie the code needs
to be:

 wait_for_migration_complete(from);
 wait_for_migration_complete(to);
 qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");

this matches what libvirt does, and libvirt has a comment saying
it was not permitted to issue 'cont' before 'query-migrate' on
the dst indicated completion.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


