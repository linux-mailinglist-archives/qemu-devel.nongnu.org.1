Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA8AB50EDA
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Sep 2025 09:13:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwEzJ-0000P5-AD; Wed, 10 Sep 2025 03:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwEz8-0000Ok-Ct
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 03:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwEyy-0005cB-T2
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 03:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757488265;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLxMPxFFsLS2H/DSNHJbsQVN++kTMXBZr+u/3TrYLFU=;
 b=NW1Dg6rGOEpI+BfUi16hVXN2bK3/hPp3DI8s4kF1MkHOZKVlNyqd/k8D54FVoyGFlferHV
 +/ar52jUHSCmYGRthfASlz4kqiKAmGMMs/zRFsrryABXmnSsThNi8YF/GqMZFEykLT1iTJ
 cZiNd+c+lCymR96L9AZfkTdZJ3J8uag=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-JI6ahnESNkSXS1x2UGaA7A-1; Wed,
 10 Sep 2025 03:11:03 -0400
X-MC-Unique: JI6ahnESNkSXS1x2UGaA7A-1
X-Mimecast-MFC-AGG-ID: JI6ahnESNkSXS1x2UGaA7A_1757488262
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3044A1800371; Wed, 10 Sep 2025 07:11:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.57])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B927019560AB; Wed, 10 Sep 2025 07:11:00 +0000 (UTC)
Date: Wed, 10 Sep 2025 08:10:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Apply migration specific keep-alive defaults
 to inet socket
Message-ID: <aMEkY3N9ITwH_Y8Z@redhat.com>
References: <20250909150127.1494626-1-jmarcin@redhat.com>
 <aMBDIwKDxTVrBJBQ@redhat.com> <aMCjGVUiM3MY-RM3@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMCjGVUiM3MY-RM3@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 09, 2025 at 05:58:49PM -0400, Peter Xu wrote:
> On Tue, Sep 09, 2025 at 04:09:23PM +0100, Daniel P. Berrangé wrote:
> > On Tue, Sep 09, 2025 at 05:01:24PM +0200, Juraj Marcin wrote:
> > > From: Juraj Marcin <jmarcin@redhat.com>
> > > 
> > > Usual system defaults for TCP keep-alive options are too long for
> > > migration workload. On Linux, a TCP connection waits idle for 2 hours
> > > before it starts checking if the connection is not broken.
> > > 
> > > Now when InetSocketAddress supports keep-alive options [1], this patch
> > > applies migration specific defaults if they are not supplied by the user
> > > or the management software. With these defaults, a migration TCP stream
> > > waits idle for 1 minute and then sends 5 TCP keep-alive packets in 30
> > > second interval before considering the connection as broken.
> > > 
> > > System defaults can be still used by explicitly setting these parameters
> > > to 0.
> > 
> > IMHO this is not a good idea. This is a very short default, which
> > may be fine for the scenario where your network conn is permanently
> > dead, but it is going to cause undesirable failures when the network
> > conn is only temporarily dead.
> > 
> > Optimizing defaults for temporary outages is much more preferrable
> > as that maximises reliability of migration. In the case of permanent
> > outages, it is already possible to tear down the connection without
> > waiting for a keep-alive timeout, and liveliness checks can also be
> > perform by the mgmt app at a higher level too. The TCP keepalives
> > are just an eventual failsafe, and having those work on a long
> > timeframe is OK.
> 
> For precopy it looks fine indeed, because migrate_cancel should always work
> on src if src socket hanged, and even if dest QEMU socket hanged, it can
> simply be killed if src QEMU can be gracefully cancelled and rolled back to
> RUNNING, disregarding the socket status on dest QEMU.
> 
> For postcopy, we could still use migrate_pause to enforce src shutdown().
> Initially I thought we have no way of doing that for dest QEMU, but I just
> noticed two years ago I added that to dest QEMU for migrate_paused when
> working on commit f8c543e808f20b..  So looks like that part is covered too,
> so that if dest QEMU socket hanged we can also kick it out.
> 
> I'm not 100% sure though, on whether shutdown() would always be able to
> successfully kick out the hanged socket while the keepalive is ticking.  Is
> it guaranteed?

I don't know about shutdown(), but close() certainly works. If shutdown()
is not sufficient, then IMHO the migration code would need the ability to
use close() to deal with this situation.


> I also am not sure if that happens, whether libvirt would automatically do
> that, or provide some way so the user can trigger that.  The goal IIUC here
> is we shouldn't put user into a situation where the migration hanged but
> without any way to either cancel or recover.  With the default values Juraj
> provided here, it makes sure the hang won't happen more than a few minutes,
> which sounds like a sane timeout value.

Sufficient migration QMP commands should exist to ensure migration can
always be cancelled. Short keepalive timeouts should not be considered
a solution to any gaps in that respect.

Also there is yank, but IMHO apps shouldn't have to rely on yank - I see
yank as a safety net for apps to workaround limitations in QEMU.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


