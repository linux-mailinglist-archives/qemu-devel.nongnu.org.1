Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E47CC954EC6
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Aug 2024 18:28:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sezob-00048p-1W; Fri, 16 Aug 2024 12:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sezoZ-00040T-KU
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:28:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sezoW-00015w-Vq
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723825711;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aNkaJQ/DOIkhSCnNQ5G0CYowaq/sSde4/HKQXjiwMw4=;
 b=OIo2JRbgZyHud4clThfbV5V5XpVxlGi8bqRtUb8BMPQ6SPf5vQZOm2o6oSAe3UwsTZEE7t
 7rvt9bURD2rkW3xWbQvwHtQrm8mgozxzt9VuiRumJYhk5fMiiXVe169HjpTO4lTwSNt/IT
 ZJK4biONWyIht4hiiQ9DAauvNdQbyOc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-6whYl7p_OemslGUPfWb9oA-1; Fri,
 16 Aug 2024 12:28:28 -0400
X-MC-Unique: 6whYl7p_OemslGUPfWb9oA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C6B21956048; Fri, 16 Aug 2024 16:28:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.143])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 273211954B04; Fri, 16 Aug 2024 16:28:21 +0000 (UTC)
Date: Fri, 16 Aug 2024 17:28:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
Message-ID: <Zr9-IvoRkGjre4CI@redhat.com>
References: <Zpk7Mf2c7LiNV2xC@x1n> <ZrCi8DWCKFiBHQAQ@redhat.com>
 <5776f6b4-c55f-4e56-aac5-bee7e441ad15@oracle.com>
 <Zru4AaTmBIAGnyDr@x1n>
 <46b63356-9602-4fa2-9d31-186f5f85151f@oracle.com>
 <Zr9q4muKZmYCf9mv@x1n> <Zr9tYsmy8j2t8fq0@redhat.com>
 <Zr9xcmUfkYAWnXH-@x1n> <Zr93oOn9J5JLs2Rn@redhat.com>
 <Zr97ms6Ur9HH_EXG@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zr97ms6Ur9HH_EXG@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 16, 2024 at 12:17:30PM -0400, Peter Xu wrote:
> On Fri, Aug 16, 2024 at 05:00:32PM +0100, Daniel P. Berrangé wrote:
> > On Fri, Aug 16, 2024 at 11:34:10AM -0400, Peter Xu wrote:
> > > On Fri, Aug 16, 2024 at 04:16:50PM +0100, Daniel P. Berrangé wrote:
> > > > On Fri, Aug 16, 2024 at 11:06:10AM -0400, Peter Xu wrote:
> > > > > On Thu, Aug 15, 2024 at 04:55:20PM -0400, Steven Sistare wrote:
> > > > > > On 8/13/2024 3:46 PM, Peter Xu wrote:
> > > > > > > On Tue, Aug 06, 2024 at 04:56:18PM -0400, Steven Sistare wrote:
> > > > > > > > > The flipside, however, is that localhost migration via 2 separate QEMU
> > > > > > > > > processes has issues where both QEMUs want to be opening the very same
> > > > > > > > > file, and only 1 of them can ever have them open.
> > > > > > > 
> > > > > > > I thought we used to have similar issue with block devices, but I assume
> > > > > > > it's solved for years (and whoever owns it will take proper file lock,
> > > > > > > IIRC, and QEMU migration should properly serialize the time window on who's
> > > > > > > going to take the file lock).
> > > > > > > 
> > > > > > > Maybe this is about something else?
> > > > > > 
> > > > > > I don't have an example where this fails.
> > > > > > 
> > > > > > I can cause "Failed to get "write" lock" errors if two qemu instances open
> > > > > > the same block device, but the error is suppressed if you add the -incoming
> > > > > > argument, due to this code:
> > > > > > 
> > > > > >   blk_attach_dev()
> > > > > >     if (runstate_check(RUN_STATE_INMIGRATE))
> > > > > >       blk->disable_perm = true;
> > > > > 
> > > > > Yep, this one is pretty much expected.
> > > > > 
> > > > > > 
> > > > > > > > Indeed, and "files" includes unix domain sockets.
> > > > > > 
> > > > > > More on this -- the second qemu to bind a unix domain socket for listening
> > > > > > wins, and the first qemu loses it (because second qemu unlinks and recreates
> > > > > > the socket path before binding on the assumption that it is stale).
> > > > > > 
> > > > > > One must use a different name for the socket for second qemu, and clients
> > > > > > that wish to connect must be aware of the new port.
> > > > > > 
> > > > > > > > Network ports also conflict.
> > > > > > > > cpr-exec avoids such problems, and is one of the advantages of the method that
> > > > > > > > I forgot to promote.
> > > > > > > 
> > > > > > > I was thinking that's fine, as the host ports should be the backend of the
> > > > > > > VM ports only anyway so they don't need to be identical on both sides?
> > > > > > > 
> > > > > > > IOW, my understanding is it's the guest IP/ports/... which should still be
> > > > > > > stable across migrations, where the host ports can be different as long as
> > > > > > > the host ports can forward guest port messages correctly?
> > > > > > 
> > > > > > Yes, one must use a different host port number for the second qemu, and clients
> > > > > > that wish to connect must be aware of the new port.
> > > > > > 
> > > > > > That is my point -- cpr-transfer requires fiddling with such things.
> > > > > > cpr-exec does not.
> > > > > 
> > > > > Right, and my understanding is all these facilities are already there, so
> > > > > no new code should be needed on reconnect issues if to support cpr-transfer
> > > > > in Libvirt or similar management layers that supports migrations.
> > > > 
> > > > Note Libvirt explicitly blocks localhost migration today because
> > > > solving all these clashing resource problems is a huge can of worms
> > > > and it can't be made invisible to the user of libvirt in any practical
> > > > way.
> > > 
> > > Ahhh, OK.  I'm pretty surprised by this, as I thought at least kubevirt
> > > supported local migration somehow on top of libvirt.
> > 
> > Since kubevirt runs inside a container, "localhost" migration
> > is effectively migrating between 2 completely separate OS installs
> > (containers), that happen to be on the same physical host. IOW, it
> > is a cross-host migration from Libvirt & QEMU's POV, and there are
> > no clashing resources to worry about.
> 
> OK, makes sense.
> 
> Then do you think it's possible to support cpr-transfer in that scenario
> from Libvirt POV?
> 
> > 
> > > Does it mean that cpr-transfer is a no-go in this case at least for Libvirt
> > > to consume it (as cpr-* is only for local host migrations so far)?  Even if
> > > all the rest issues we're discussing with cpr-exec, is that the only way to
> > > go for Libvirt, then?
> > 
> > cpr-exec is certainly appealing from the POV of avoiding the clashing
> > resources problem in libvirt.
> > 
> > It has own issues though, because libvirt runs all QEMU processes with
> > seccomp filters that block 'execve', as we consider QEMU to be untrustworthy
> > and thus don't want to allow it to exec anything !
> > 
> > I don't know which is the lesser evil from libvirt's POV.
> > 
> > Personally I see security controls as an overriding requirement for
> > everything.
> 
> One thing I am aware of is cpr-exec is not the only one who might start to
> use exec() in QEMU. TDX fundamentally will need to create another key VM to
> deliver the keys and the plan seems to be using exec() too.  However in
> that case per my understanding the exec() is optional - the key VM can also
> be created by Libvirt.

Since nothing is merged, I'd consider whatever might have been presented
wrt TDX migration to all be open for potential re-design. With SNP there
is the SVSM paravisor which runs inside the guest to provide services,
and IIUC its intended to address migration service needs.

There's a push to support SVSM with TDX too, in order to enable vTPM
support. With that it might make sense to explore whether SVSM can
service migration for TDX too, instead of having a separate parallel
VM on the host. IMHO its highly desirable to have a common architecture
for CVM migration from QEMU's POV, and from a libvirt POV I'd like to
avoid having extra host VMs too.


> IOW, it looks like we can still stick with execve() being blocked yet so
> far except cpr-exec().
> 
> Hmm, this makes the decision harder to make.  We need to figure out a way
> on knowing how to consume this feature for at least open source virt
> stack..  So far it looks like it's only possible (if we take seccomp high
> priority) we use cpr-transfer but only in a container.

Or we have cpr-transfer, but libvirt has to more games to solve the
clashing resources problem, by making much more use of FD passing,
and/or by changnig path conventions, or a mix of both.

What might make this viable is that IIUC, CPR only permits a subset
of backends to be used, so libvirt doesn't have to solve clashing
resources for /everything/, just parts that are supported by CPR.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


