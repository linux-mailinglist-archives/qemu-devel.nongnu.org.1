Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92627878959
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Mar 2024 21:16:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjm3v-0004rH-Ag; Mon, 11 Mar 2024 16:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjm3q-0004lt-5N
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:15:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjm3n-0003H9-NG
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710188146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qVwXJJ2Du3lMvsWI6GL3J8up2r9mi8KzJm/dF6qyk08=;
 b=hV8V8v3xUahUJwyRRxUbdBH9H8OBogCCV+nAPKDv3Tocc/9TBRcKhzkfiQc9JwlNM0LnuH
 alMctcoFu5r1vkfj2YvmYJnTbGJsWoW5qbYNo16hof1sMR8M9kpPnFYOwZlJVYuC7URIWu
 5j92LnXCRnzaW2BmRUkKH1LetxwmLME=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-WulDtruiPKG7-By2BsuGBA-1; Mon, 11 Mar 2024 16:15:45 -0400
X-MC-Unique: WulDtruiPKG7-By2BsuGBA-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-221a566a435so1521858fac.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 13:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710188144; x=1710792944;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qVwXJJ2Du3lMvsWI6GL3J8up2r9mi8KzJm/dF6qyk08=;
 b=fpCMC79mtBhwYjhuRO+QKL/gHn4n2K4nB2rQaproi58Adlb928VsfPdKHnAr4SPa5T
 MYJVZUQW4anVX3Kbs6myxWlhz3hvaRjkZqW15hW6QUtuOHIg4ocbsKiT3uGW6DbUe/TL
 UgPFLdF7dXLkuCO9Fjj8iAQUpnDshBu5ScwDBEVe3DGQaJoZCWzcDFkpPiQk+9vc5ocB
 GP8C+2ySXuxKKjQld9/3gFrOfK2cqg576n10oy3lvYGyS4Z5DoxEMKuyYSoCcayExIVM
 W8oucJZtz6+Q2V/1Ib/YVVfnO45OjbQ7ve/zjupbcLW0IRN3f9uwaRueg+mPNgoC//CI
 Dz+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkiTomT5dkVIx7JqUSU6JanHT7aSQNuw0bEUwUlzkZ40ZkU+D+VVln7Ze5UTo0OjQraj3oGFAVbYGrg5l7DW6O/lCk700=
X-Gm-Message-State: AOJu0Yz+PI9PMR/Gf95uOsQUwm7a6VPvhRfT55zzghz54qSQY0XaSlSQ
 pTWqFwKcGy8HvgapuMo4vyr9hqrKxdqGW8jeM4utmHn9TOYnJDsH03hL9z5N9AzQMDduaybeg7x
 4geW1DgTdNQcpzquQlkQgLNqBSC6B96EbVfzNwQPGV5nXAAUNF6Ht
X-Received: by 2002:a05:6871:829:b0:221:3a21:5b37 with SMTP id
 q41-20020a056871082900b002213a215b37mr7610655oap.4.1710188144430; 
 Mon, 11 Mar 2024 13:15:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfYo7jFp1bKYIy/+a+bI53Hkf6kePtv5Cbow0Ozzyfoaq3MV49GoGmiIUnCit33DnZmqOHNA==
X-Received: by 2002:a05:6871:829:b0:221:3a21:5b37 with SMTP id
 q41-20020a056871082900b002213a215b37mr7610636oap.4.1710188144082; 
 Mon, 11 Mar 2024 13:15:44 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 xa19-20020a0568707f1300b002214ef3955esm1754026oab.34.2024.03.11.13.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 13:15:43 -0700 (PDT)
Date: Mon, 11 Mar 2024 16:15:41 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
Message-ID: <Ze9mbTe7yOiSyix0@x1n>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-11-clg@redhat.com> <ZesLDCwh3r_pV2r3@x1n>
 <deec998e-cab5-4aff-8582-86031778b089@redhat.com>
 <cd1ec55d-acdc-4960-8a9c-24c42ff669fa@redhat.com>
 <9772e612-6ecc-4a8f-aae8-86884397f39d@redhat.com>
 <ZeseDv1o6ihlA2Ct@x1n>
 <74d722a9-ad04-4501-ba79-7d1a7029963d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74d722a9-ad04-4501-ba79-7d1a7029963d@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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

On Mon, Mar 11, 2024 at 07:12:11PM +0100, Cédric Le Goater wrote:
> On 3/8/24 15:17, Peter Xu wrote:
> > On Fri, Mar 08, 2024 at 02:55:30PM +0100, Cédric Le Goater wrote:
> > > On 3/8/24 14:39, Cédric Le Goater wrote:
> > > > On 3/8/24 14:14, Cédric Le Goater wrote:
> > > > > On 3/8/24 13:56, Peter Xu wrote:
> > > > > > On Wed, Mar 06, 2024 at 02:34:25PM +0100, Cédric Le Goater wrote:
> > > > > > > This prepares ground for the changes coming next which add an Error**
> > > > > > > argument to the .save_setup() handler. Callers of qemu_savevm_state_setup()
> > > > > > > now handle the error and fail earlier setting the migration state from
> > > > > > > MIGRATION_STATUS_SETUP to MIGRATION_STATUS_FAILED.
> > > > > > > 
> > > > > > > In qemu_savevm_state(), move the cleanup to preserve the error
> > > > > > > reported by .save_setup() handlers.
> > > > > > > 
> > > > > > > Since the previous behavior was to ignore errors at this step of
> > > > > > > migration, this change should be examined closely to check that
> > > > > > > cleanups are still correctly done.
> > > > > > > 
> > > > > > > Signed-off-by: Cédric Le Goater <clg@redhat.com>
> > > > > > > ---
> > > > > > > 
> > > > > > >    Changes in v4:
> > > > > > >    - Merged cleanup change in qemu_savevm_state()
> > > > > > >    Changes in v3:
> > > > > > >    - Set migration state to MIGRATION_STATUS_FAILED
> > > > > > >    - Fixed error handling to be done under lock in bg_migration_thread()
> > > > > > >    - Made sure an error is always set in case of failure in
> > > > > > >      qemu_savevm_state_setup()
> > > > > > >    migration/savevm.h    |  2 +-
> > > > > > >    migration/migration.c | 27 ++++++++++++++++++++++++---
> > > > > > >    migration/savevm.c    | 26 +++++++++++++++-----------
> > > > > > >    3 files changed, 40 insertions(+), 15 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/migration/savevm.h b/migration/savevm.h
> > > > > > > index 74669733dd63a080b765866c703234a5c4939223..9ec96a995c93a42aad621595f0ed58596c532328 100644
> > > > > > > --- a/migration/savevm.h
> > > > > > > +++ b/migration/savevm.h
> > > > > > > @@ -32,7 +32,7 @@
> > > > > > >    bool qemu_savevm_state_blocked(Error **errp);
> > > > > > >    void qemu_savevm_non_migratable_list(strList **reasons);
> > > > > > >    int qemu_savevm_state_prepare(Error **errp);
> > > > > > > -void qemu_savevm_state_setup(QEMUFile *f);
> > > > > > > +int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
> > > > > > >    bool qemu_savevm_state_guest_unplug_pending(void);
> > > > > > >    int qemu_savevm_state_resume_prepare(MigrationState *s);
> > > > > > >    void qemu_savevm_state_header(QEMUFile *f);
> > > > > > > diff --git a/migration/migration.c b/migration/migration.c
> > > > > > > index a49fcd53ee19df1ce0182bc99d7e064968f0317b..6d1544224e96f5edfe56939a9c8395d88ef29581 100644
> > > > > > > --- a/migration/migration.c
> > > > > > > +++ b/migration/migration.c
> > > > > > > @@ -3408,6 +3408,8 @@ static void *migration_thread(void *opaque)
> > > > > > >        int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
> > > > > > >        MigThrError thr_error;
> > > > > > >        bool urgent = false;
> > > > > > > +    Error *local_err = NULL;
> > > > > > > +    int ret;
> > > > > > >        thread = migration_threads_add("live_migration", qemu_get_thread_id());
> > > > > > > @@ -3451,9 +3453,17 @@ static void *migration_thread(void *opaque)
> > > > > > >        }
> > > > > > >        bql_lock();
> > > > > > > -    qemu_savevm_state_setup(s->to_dst_file);
> > > > > > > +    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
> > > > > > >        bql_unlock();
> > > > > > > +    if (ret) {
> > > > > > > +        migrate_set_error(s, local_err);
> > > > > > > +        error_free(local_err);
> > > > > > > +        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> > > > > > > +                          MIGRATION_STATUS_FAILED);
> > > > > > > +        goto out;
> > > > > > > +     }
> > > > > > 
> > > > > > There's a small indent issue, I can fix it.
> > > > > 
> > > > > checkpatch did report anything.
> > > > > 
> > > > > > 
> > > > > > The bigger problem is I _think_ this will trigger a ci failure in the
> > > > > > virtio-net-failover test:
> > > > > > 
> > > > > > ▶ 121/464 ERROR:../tests/qtest/virtio-net-failover.c:1203:test_migrate_abort_wait_unplug: assertion failed (status == "cancelling"): ("cancelled" == "cancelling") ERROR
> > > > > > 121/464 qemu:qtest+qtest-x86_64 / qtest-x86_64/virtio-net-failover    ERROR            4.77s   killed by signal 6 SIGABRT
> > > > > > > > > PYTHON=/builds/peterx/qemu/build/pyvenv/bin/python3.8 G_TEST_DBUS_DAEMON=/builds/peterx/qemu/tests/dbus-vmstate-daemon.sh MALLOC_PERTURB_=161 QTEST_QEMU_IMG=./qemu-img QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon QTEST_QEMU_BINARY=./qemu-system-x86_64 /builds/peterx/qemu/build/tests/qtest/virtio-net-failover --tap -k
> > > > > > ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
> > > > > > stderr:
> > > > > > qemu-system-x86_64: ram_save_setup failed: Input/output error
> > > > > > **
> > > > > > ERROR:../tests/qtest/virtio-net-failover.c:1203:test_migrate_abort_wait_unplug: assertion failed (status == "cancelling"): ("cancelled" == "cancelling")
> > > > > > (test program exited with status code -6)
> > > > > > ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> > > > > > 
> > > > > > I am not familiar enough with the failover code, and may not have time
> > > > > > today to follow this up, copy Laurent.  Cedric, if you have time, please
> > > > > > have a look.
> > > > > 
> > > > > 
> > > > > Sure. Weird because I usually run make check on x86_64, s390x, ppc64 and
> > > > > aarch64. Let me check again.
> > > > 
> > > > I see one timeout error on s390x but not always. See below. It occurs with
> > > > or without this patchset. the other x86_64, ppc64 arches run fine (a part
> > > > from one io  test failing from time to time)
> > > 
> > > Ah ! I got this once on aarch64 :
> > > 
> > >   161/486 ERROR:../tests/qtest/virtio-net-failover.c:1222:test_migrate_abort_wait_unplug: 'device' should not be NULL ERROR
> > > 161/486 qemu:qtest+qtest-x86_64 / qtest-x86_64/virtio-net-failover                  ERROR            5.98s   killed by signal 6 SIGABRT
> > > > > > G_TEST_DBUS_DAEMON=/home/legoater/work/qemu/qemu.git/tests/dbus-vmstate-daemon.sh MALLOC_PERTURB_=119 QTEST_QEMU_BINARY=./qemu-system-x86_64 QTEST_QEMU_IMG=./qemu-img PYTHON=/home/legoater/work/qemu/qemu.git/build/pyvenv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon /home/legoater/work/qemu/qemu.git/build/tests/qtest/virtio-net-failover --tap -k
> > > ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> > > stderr:
> > > qemu-system-x86_64: ram_save_setup failed: Input/output error
> > > **
> > > ERROR:../tests/qtest/virtio-net-failover.c:1222:test_migrate_abort_wait_unplug: 'device' should not be NULL
> > > 
> > > (test program exited with status code -6)
> > > ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> > 
> > Hmm, this one seems different..
> > 
> > > 
> > > I couldn't reproduce yet :/
> > 
> > I never reproduced it locally on x86, and my failure is always at checking
> > "cancelling" v.s. "cancelled" rather than the NULL check.  It's much easier
> > to trigger on CI in check-system-centos (I don't know why centos..):
> > 
> > https://gitlab.com/peterx/qemu/-/jobs/6351020546
> > 
> > I think at least for the error I hit, the problem is the failover test will
> > cancel the migration, but if it cancels too fast and during setup now it
> > can already fail it (while it won't fail before when we ignore
> > qemu_savevm_state_setup() errors), and I think it'll skip:
> > 
> >      qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
> >                                 MIGRATION_STATUS_ACTIVE);
> > 
> > It seems the test wants the "cancelling" to hold until later:
> > 
> >      /* while the card is not ejected, we must be in "cancelling" state */
> >      ret = migrate_status(qts);
> > 
> >      status = qdict_get_str(ret, "status");
> >      g_assert_cmpstr(status, ==, "cancelling");
> >      qobject_unref(ret);
> > 
> >      /* OS unplugs the cards, QEMU can move from wait-unplug state */
> >      qtest_outl(qts, ACPI_PCIHP_ADDR_ICH9 + PCI_EJ_BASE, 1);
> > 
> > Again, since I'll need to read the failover code, not much I can tell.
> > Laurent might have a clue.
> 
> I guess we need to fix the test to handle failures and this looks
> like a complex task.

It may not be as complicated, but that'll need some reviews outside
migration people, and someone will need to post a formal patch.  That'll
definitely take some time.

We can keep working on this issue during the 9.0-rc if you want.  Our
current plan for migration (at least what I have in mind in this
release... Fabiano will take over 9.1 release pulls, so he has the freedom
to change this) is we will allow patches to be queued even during RCs,
while I'll prepare two trees, one for -next and one for -stable, then -next
candidates will only be included in the first 9.1 pull, -stable for RC
pulls if necessary.

Thanks,

-- 
Peter Xu


