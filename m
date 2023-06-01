Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4694F71EF32
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:37:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4lIC-0008QS-PB; Thu, 01 Jun 2023 12:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4lIA-0008Os-Iu
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:36:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4lI8-0008CM-92
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685637407;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5jXlziP3sjlQZpZx3sJofdu5MVfGJ2tlmj9s5+PaI8=;
 b=hHos+HBQgoXIPuegcieeiLGSdLbwTyKB/6tmiV7fBVS3ThH0PumXV9kXdySFKiLD9XRi99
 49om8/hPqtopupBHlRQKlwe69WuvxfiTBNkXzLAl/ylJ2/PbHRQCeeEBMhyODUyUBwhiDr
 RGh2zK5fGc/dALPxaZ9oYHMiVuqVAnY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-rEtJ6TmiMAqUZTX09lqoCA-1; Thu, 01 Jun 2023 12:36:46 -0400
X-MC-Unique: rEtJ6TmiMAqUZTX09lqoCA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2BE3280AA32
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 16:36:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE346202696C;
 Thu,  1 Jun 2023 16:36:44 +0000 (UTC)
Date: Thu, 1 Jun 2023 17:36:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 9/9] tests/qtest: massively speed up migration-test
Message-ID: <ZHjJGjZKgyaT4EO5@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-10-berrange@redhat.com>
 <ZHi9OQz8PGuHMPpN@x1n> <ZHjBw2E+eJKNsniO@redhat.com>
 <ZHjFzH9zT34MIBEv@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHjFzH9zT34MIBEv@x1n>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

On Thu, Jun 01, 2023 at 12:22:36PM -0400, Peter Xu wrote:
> On Thu, Jun 01, 2023 at 05:05:23PM +0100, Daniel P. Berrangé wrote:
> > On Thu, Jun 01, 2023 at 11:46:01AM -0400, Peter Xu wrote:
> > > On Wed, May 31, 2023 at 02:24:00PM +0100, Daniel P. Berrangé wrote:
> > > > The migration test cases that actually exercise live migration want to
> > > > ensure there is a minimum of two iterations of pre-copy, in order to
> > > > exercise the dirty tracking code.
> > > > 
> > > > Historically we've queried the migration status, looking for the
> > > > 'dirty-sync-count' value to increment to track iterations. This was
> > > > not entirely reliable because often all the data would get transferred
> > > > quickly enough that the migration would finish before we wanted it
> > > > to. So we massively dropped the bandwidth and max downtime to
> > > > guarantee non-convergance. This had the unfortunate side effect
> > > > that every migration took at least 30 seconds to run (100 MB of
> > > > dirty pages / 3 MB/sec).
> > > > 
> > > > This optimization takes a different approach to ensuring that a
> > > > mimimum of two iterations. Rather than waiting for dirty-sync-count
> > > > to increment, directly look for an indication that the source VM
> > > > has dirtied RAM that has already been transferred.
> > > > 
> > > > On the source VM a magic marker is written just after the 3 MB
> > > > offset. The destination VM is now montiored to detect when the
> > > > magic marker is transferred. This gives a guarantee that the
> > > > first 3 MB of memory have been transferred. Now the source VM
> > > > memory is monitored at exactly the 3MB offset until we observe
> > > > a flip in its value. This gives us a guaranteed that the guest
> > > > workload has dirtied a byte that has already been transferred.
> > > > 
> > > > Since we're looking at a place that is only 3 MB from the start
> > > > of memory, with the 3 MB/sec bandwidth, this test should complete
> > > > in 1 second, instead of 30 seconds.
> > > > 
> > > > Once we've proved there is some dirty memory, migration can be
> > > > set back to full speed for the remainder of the 1st iteration,
> > > > and the entire of the second iteration at which point migration
> > > > should be complete.
> > > > 
> > > > On a test machine this further reduces the migration test time
> > > > from 8 minutes to 1 minute 40.
> > > 
> > > The outcome is definitely nice, but it does looks slightly hacky to me and
> > > make the test slightly more complicated.
> > > 
> > > If it's all about making sure we finish the 1st iteration, can we simply
> > > add a src qemu parameter "switchover-hold"?  If it's set, src never
> > > switchover to dst but keeps the iterations.
> > 
> > For *most* of the tests, we want to ensure there are a minimum
> > of 2 iterations. For the XBZRLE test we want to ensure there are
> > a minimum of 3 iterations, so the cache gets  workout.
> > 
> > > Then migrate_ensure_non_converge() will be as simple as setting
> > > switchover-hold to true.
> > > 
> > > I am even thinking whether there can even be real-life use case for that,
> > > e.g., where a user might want to have a pre-heat of a migration of some VM,
> > > and trigger it immediately when the admin really wants (the pre-heats moved
> > > most of the pages and keep doing so).
> > > 
> > > It'll be also similar to what Avihai proposed here on switchover-ack, just
> > > an ack mechanism on the src side:
> > > 
> > > https://lore.kernel.org/r/20230530144821.1557-3-avihaih@nvidia.com
> > 
> > In general I strongly wanted to avoid adding special logic to the
> > migration code that makes it directly synchronize with the  test
> > suite, because once we do that I don't think the test suite is a
> > providing coverage of the real world usage scenario.
> 
> The problem is non-live is already not real world usage in most cases.  It
> seems we all agreed that it's the code paths to cover not real world usages
> in the tests, or maybe not?

The cases that i made run non-live are exercising code paths that
are only relevant during migration setup, so the non-live vs live
status is irrelevant to the code coverage attained for those tests.
Other remaining live tests give sufficient coverage for the live
scenario
 
> > IOW, if we add a switchover-ack feature, we should certainly have
> > *a* test that uses it, but we should not modify other tests because
> > we want to exercise the logic as it would run with apps that don't
> > rely on switchover-ack.
> > 
> > Also, this slow migration test is incredibly painful for people right
> > now, so I'd like to see us get a speed up committed to git quickly.
> > I don't want to block it on a feature proposal that might yet take
> > months to merge.
> 
> That'll be trivial, afaict.
> 
> I just worry that this patch will bring complexity to the test cases,
> that's another burden we need to carry besides QEMU itself.
> 
> If you want, I can try to prepare such a patch before this weekend, and if
> it's complicated enough and take more than next week to review feel free to
> go ahead with this one.
> 
> I understand the migration test issue was there for a long time.  But still
> to me it's important on which may be cleaner for the long term too.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


