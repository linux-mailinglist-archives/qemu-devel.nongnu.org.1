Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B477D70B8
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 17:26:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvflJ-0001vt-8d; Wed, 25 Oct 2023 11:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvflH-0001vb-M9
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvflG-0005fC-1q
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698247533;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ELvQYxtueYWS5mp8ZKcJro7XbxrWmhJTuQySz+q+dWI=;
 b=fD2YjM75ZgPowWLyZve69LwVZwNqpo/OCuBF+CwVFKviPwtdjQUd1LMDSlNyh4M35vyQWs
 pIf42UTdNcGdwbMaYTHxB+S5PZtDwUB1Ppf8G1QqivnM401fIOj4edfl82OqoV3AgL5N72
 Z/S2LAjCIHjGh+M0YZmuI7BZDq1MAj8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-3Wm45M9ROrqykCJMIiecZQ-1; Wed, 25 Oct 2023 11:25:28 -0400
X-MC-Unique: 3Wm45M9ROrqykCJMIiecZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C7158870E1;
 Wed, 25 Oct 2023 15:25:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D403C1C060AE;
 Wed, 25 Oct 2023 15:25:25 +0000 (UTC)
Date: Wed, 25 Oct 2023 16:25:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 06/29] migration: Add auto-pause capability
Message-ID: <ZTkzY0nKtdeZJojP@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-7-farosas@suse.de>
 <ZTjWV9wQ5obKTpOG@redhat.com> <87y1fqerev.fsf@suse.de>
 <ZTkkICSD6j6Xf/KK@redhat.com> <ZTktCM/ccipYaJ80@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTktCM/ccipYaJ80@x1n>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

On Wed, Oct 25, 2023 at 10:58:16AM -0400, Peter Xu wrote:
> On Wed, Oct 25, 2023 at 03:20:16PM +0100, Daniel P. Berrangé wrote:
> > On Wed, Oct 25, 2023 at 10:57:12AM -0300, Fabiano Rosas wrote:
> > > Daniel P. Berrangé <berrange@redhat.com> writes:
> > > 
> > > > On Mon, Oct 23, 2023 at 05:35:45PM -0300, Fabiano Rosas wrote:
> > > >> Add a capability that allows the management layer to delegate to QEMU
> > > >> the decision of whether to pause a VM and perform a non-live
> > > >> migration. Depending on the type of migration being performed, this
> > > >> could bring performance benefits.
> > > >
> > > > I'm not really see what problem this is solving.
> > > >
> > > 
> > > Well, this is the fruit of your discussion with Peter Xu in the previous
> > > version of the patch.
> > > 
> > > To recap: he thinks QEMU is doing useless work with file migrations
> > > because they are always asynchronous. He thinks we should always pause
> > > before doing fixed-ram migration. You said that libvirt would rather use
> > > fixed-ram for a more broad set of savevm-style commands, so you'd rather
> > > not always pause. I'm trying to cater to both of your wishes. This new
> > > capability is the middle ground I came up with.
> > > 
> > > So fixed-ram would always pause the VM, because that is the primary
> > > use-case, but libvirt would be allowed to say: don't pause this time.
> > 
> > If the VM is going to be powered off immediately after saving
> > a snapshot then yes, you might as well pause it, but we can't
> > assume that will be the case.  An equally common use case
> > would be for saving periodic snapshots of a running VM. This
> > should be transparent such that the VM remains running the
> > whole time, except a narrow window at completion of RAM/state
> > saving where we flip the disk snapshots, so they are in sync
> > with the RAM snapshot.
> 
> Libvirt will still use fixed-ram for live snapshot purpose, especially for
> Windows?  Then auto-pause may still be useful to identify that from what
> Fabiano wants to achieve here (which is in reality, non-live)?
> 
> IIRC of previous discussion that was the major point that libvirt can still
> leverage fixed-ram for a live case - since Windows lacks efficient live
> snapshot (background-snapshot feature).

Libvirt will use fixed-ram for all APIs it has that involve saving to
disk, with CPUs both running and paused.

> From that POV it sounds like auto-pause is a good knob for that.

From libvirt's POV auto-pause will create extra work for integration
for no gain.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


