Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAD1798631
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 12:53:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeZ6e-0004nT-7A; Fri, 08 Sep 2023 06:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qeZ6b-0004nA-OB
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 06:52:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qeZ6Z-0005m3-4e
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 06:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694170370;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ph7pItCEzIn+p9PFbsyp3+x/QVhBRcHm5W4bKCJ7udc=;
 b=guVT8qTRbOF2s5i9i0oAjMukXrXh+O54JLG8u1wME33HSS3MT+lxWskB3WBxMRgKpGPti7
 8LWUH/yS2p6nxsDm0Umqwkfuuxq8YmwjVAvZnQOEpiX8X31VnIDJMhHYw5J3uje0dTAXVD
 FezCN3d+d1Qru/lt9jMiPeZIIT4lVR8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-qRI6uXnIN5u3IHVTvZXnbQ-1; Fri, 08 Sep 2023 06:52:46 -0400
X-MC-Unique: qRI6uXnIN5u3IHVTvZXnbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B37C101CA83;
 Fri,  8 Sep 2023 10:52:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7ABBE40C84A7;
 Fri,  8 Sep 2023 10:52:45 +0000 (UTC)
Date: Fri, 8 Sep 2023 11:52:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V4 1/2] migration: file URI
Message-ID: <ZPr8+zjFneDQ90Vy@redhat.com>
References: <1688135108-316997-1-git-send-email-steven.sistare@oracle.com>
 <1688135108-316997-2-git-send-email-steven.sistare@oracle.com>
 <ZO9BNnnOnLjH3bcD@redhat.com>
 <2dbbaf06-81cb-0442-05f2-f0f00deb5618@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2dbbaf06-81cb-0442-05f2-f0f00deb5618@oracle.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 30, 2023 at 10:15:43AM -0400, Steven Sistare wrote:
> On 8/30/2023 9:16 AM, Daniel P. Berrangé wrote:
> > On Fri, Jun 30, 2023 at 07:25:07AM -0700, Steve Sistare wrote:
> >> Extend the migration URI to support file:<filename>.  This can be used for
> >> any migration scenario that does not require a reverse path.  It can be
> >> used as an alternative to 'exec:cat > file' in minimized containers that
> >> do not contain /bin/sh, and it is easier to use than the fd:<fdname> URI.
> >> It can be used in HMP commands, and as a qemu command-line parameter.
> >>
> >> For best performance, guest ram should be shared and x-ignore-shared
> >> should be true, so guest pages are not written to the file, in which case
> >> the guest may remain running.  If ram is not so configured, then the user
> >> is advised to stop the guest first.  Otherwise, a busy guest may re-dirty
> >> the same page, causing it to be appended to the file multiple times,
> >> and the file may grow unboundedly.  That issue is being addressed in the
> >> "fixed-ram" patch series.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> >> Reviewed-by: Peter Xu <peterx@redhat.com>
> >> ---
> >>  migration/file.c       | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  migration/file.h       | 14 ++++++++++++
> >>  migration/meson.build  |  1 +
> >>  migration/migration.c  |  5 ++++
> >>  migration/trace-events |  4 ++++
> >>  qemu-options.hx        |  6 ++++-
> >>  6 files changed, 91 insertions(+), 1 deletion(-)
> >>  create mode 100644 migration/file.c
> >>  create mode 100644 migration/file.h
> >>
> >> diff --git a/migration/file.c b/migration/file.c
> >> new file mode 100644
> >> index 0000000..8e35827
> >> --- /dev/null
> >> +++ b/migration/file.c
> >> @@ -0,0 +1,62 @@
> >> +/*
> >> + * Copyright (c) 2021-2023 Oracle and/or its affiliates.
> >> + *
> >> + * This work is licensed under the terms of the GNU GPL, version 2.
> > 
> > Was it an intentional decision to assign this under the version 2 *only* ?
> > 
> > QEMU's LICENSE file states
> > 
> > [quote]
> > As of July 2013, contributions under version 2 of the GNU General Public
> > License (and no later version) are only accepted for the following files
> > or directories: bsd-user/, linux-user/, hw/vfio/, hw/xen/xen_pt*.
> > [/quote]
> > 
> > Thus we'd expect this new file to be version 2, or later.
> 
> My mistake, sorry.  It should say "GNU GPL, version 2 or later"

Could you re-post, as aside from that, this series looks
ready for merge.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


