Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAD4769F52
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 19:21:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQWZ1-0006nm-Cg; Mon, 31 Jul 2023 13:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQWYu-0006nT-FR
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 13:20:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQWYr-0002ou-PD
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 13:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690824000;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=i2iiLGt0HvuNY6jB6GLzJXyTSyVO4peHkLDKzZW0dd0=;
 b=NBrtuJDmz86jqY6eO7601+GezF8vW6TWqZpHFDYrTKHk0JyRfQ735gGLuxUlQR41NVp8QE
 aoY1MfvKXfmfcQ3L+8d04PDRWL4CKxIj/gsQjEUhIwbwRuEFpw45EhGwth539N6FOpFQDS
 n7BsfXPnDgwPk+43U4iOWyU7x3nPHrM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-NeMCzSCaNKyqGdjAkFlqfg-1; Mon, 31 Jul 2023 13:19:59 -0400
X-MC-Unique: NeMCzSCaNKyqGdjAkFlqfg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E91391C068CF
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 17:19:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 16663C5CE60;
 Mon, 31 Jul 2023 17:19:57 +0000 (UTC)
Date: Mon, 31 Jul 2023 18:19:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alex Kalenyuk <akalenyu@redhat.com>, Adam Litke <alitke@redhat.com>,
 qemu-devel@nongnu.org, kwolf@redhat.com,
 "Richard W.M. Jones" <rjones@redhat.com>
Subject: Re: qemu-img cache modes with Linux cgroup v1
Message-ID: <ZMftO2aPh9YOu5R0@redhat.com>
References: <20230731154036.GA1258836@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731154036.GA1258836@fedora>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jul 31, 2023 at 11:40:36AM -0400, Stefan Hajnoczi wrote:
> Hi,
> qemu-img -t writeback -T writeback is not designed to run with the Linux
> cgroup v1 memory controller because dirtying too much page cache leads
> to process termination instead of usual non-cgroup and cgroup v2
> throttling behavior:
> https://bugzilla.redhat.com/show_bug.cgi?id=2196072

Ewww, a horrible behavioural change v1 is imposing on apps :-(

QEMU happens to hit it because we do lots of I/O, but plenty of
other apps do major I/o and can fall into the same trap :-( I
can imagine that simply running a big "tar zxvf" would have much
the same effect in terms of masses of I/O in a short time.

> I wanted to share my thoughts on this issue.
> 
> cache=none bypasses the host page cache and will not hit the cgroup
> memory limit. It's an easy solution to avoid exceeding the cgroup v1
> memory limit.

I go further and say that is a good recommendation even without
this bug in cgroups v1.

writeback caching helps if you have lots of free memory, but on
virtualization hosts memory is usually the biggest VM density
constraint, so apps shouldn't generally expect there to be lots
of free host memory to burn as I/O cache.

If you're using qemu-img in preparation for running qemu-system-XXX
and the latter will use cache=none anyway, then it is even less
desirable for qemu-img to fill the host cache with pages that won't
be accessed again when the VM starts in qemu-system-XXXX.

> However, not all Linux file systems support O_DIRECT and qemu-img's I/O
> pattern may perform worse under cache=none than cache=writeback.
> 
> 1. Which file systems support O_DIRECT in Linux 6.5?
> 
> I searched the Linux source code for file systems that implement
> .direct_IO or set FMODE_CAN_ODIRECT. This is not exhaustive and may not
> be 100% accurate.
> 
> The big name file systems (ext4, XFS, btrfs, nfs, smb, ceph) support
> O_DIRECT. The most obvious omission is tmpfs.

Rather than trying to fogure out a list of FS types, in openstack,
a bit of code was added to simply attempt to open a test file with
O_DIRECT on the target filesystem. If that works then run qemu-img
/ qemu-system-XXX with cache=none, otherwise use cache=writeback.
IOW, a "best effort" to avoid host cache where supported.

Could there be justification for QEMU to support a "best effort"
host cache bypass mode natively, to avoid every app needing to
re-implement this logic to check for support of O_DIRECT ?

eg a QEMU 'cache=trynone' option instead of 'cache=none' ?


> 2. Is qemu-img performance with O_DIRECT acceptable?
> 
> The I/O pattern matters more with O_DIRECT because every I/O request is
> sent to the storage device. This means buffer sizes matter more (more
> small I/Os have higher overhead than fewer large I/Os). Concurrency can
> also help saturate the storage device.

"qemu-img convert" supports the '--parallel' flag to use many
coroutines for I/O

> If you switch to O_DIRECT and encounter performance problems then
> qemu-img can be optimized to send I/O patterns with less overhead. This
> requires performance analysis.

Since we're in pretty direct control of the I/O pattern qemu-img imposes,
it feels very sensible to optimize it to such that cache=none achieves
ideal performance.  


> 3. Using buffered I/O because O_DIRECT is not universally supported?
> 
> If you can't use O_DIRECT, then qemu-img could be extended to manage its
> dirty page cache set carefully. This consists of picking a budget and
> writing back to disk when the budget is exhausted.

IOW, re-implementing what the kernel should already be doing for us :-(

This feels like the least desirable thing for QEMU to take on, especially
since cgroups v1 is an evolutionary dead-end, with v2 increasingly taking
over the world.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


