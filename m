Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4479760E32
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 11:17:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOEAD-0001oe-AF; Tue, 25 Jul 2023 05:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOEAB-0001oV-UR
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 05:17:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOEAA-0002oP-1P
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 05:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690276620;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GcAyr0hvv3MZrreXYmKmPhBUht1RA3cmg4lmvgKSPKk=;
 b=coPzExfR7FN4fzSHVfzEqfJc44NCqokb4N+2Z5M8SwsLtKXST2qqxwsL3X10PUuoKaghzh
 3JcOEs0CTMqWW6W5aVlAJ/hWhWs6A6aHzrvkcwD8XECcqH/rtyFeLF0S8t2eplfsSIu6tC
 0fH8E/7tns4cgYzDBxLb/IXQ2EgnfkE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-F4CgqK94P5aHyqDGY9p7Hw-1; Tue, 25 Jul 2023 05:16:56 -0400
X-MC-Unique: F4CgqK94P5aHyqDGY9p7Hw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34523858290;
 Tue, 25 Jul 2023 09:16:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E35C11415115;
 Tue, 25 Jul 2023 09:16:54 +0000 (UTC)
Date: Tue, 25 Jul 2023 10:16:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Chensheng Dong <chdong@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Allow user to specify migration available
 bandwidth
Message-ID: <ZL+TBBtL+RiMrOXJ@redhat.com>
References: <20230724170755.1114519-1-peterx@redhat.com>
 <ZL69LTVHhNzEjqGM@redhat.com> <ZL7VZsaFxkIq4+cP@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZL7VZsaFxkIq4+cP@x1n>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 24, 2023 at 03:47:50PM -0400, Peter Xu wrote:
> On Mon, Jul 24, 2023 at 07:04:29PM +0100, Daniel P. Berrangé wrote:
> > On Mon, Jul 24, 2023 at 01:07:55PM -0400, Peter Xu wrote:
> > > Migration bandwidth is a very important value to live migration.  It's
> > > because it's one of the major factors that we'll make decision on when to
> > > switchover to destination in a precopy process.
> > 
> > To elaborate on this for those reading along...
> > 
> > QEMU takes maxmimum downtime limit and multiplies by its estimate
> > of bandwidth. This gives a figure for the amount of data QEMU thinks
> > it can transfer within the downtime period.
> > 
> > QEMU compares this figure to the amount of data that is still pending
> > at the end of an iteration.
> > 
> > > This value is currently estimated by QEMU during the whole live migration
> > > process by monitoring how fast we were sending the data.  This can be the
> > > most accurate bandwidth if in the ideal world, where we're always feeding
> > > unlimited data to the migration channel, and then it'll be limited to the
> > > bandwidth that is available.
> > 
> > The QEMU estimate for available bandwidth will definitely be wrong,
> > potentially by orders of magnitude, if QEMU has a max bandwidth limit
> > set, as in that case it is never trying to push the peak rates available
> > from the NICs/network fabric.
> > 
> > > The issue is QEMU itself may not be able to avoid those uncertainties on
> > > measuing the real "available migration bandwidth".  At least not something
> > > I can think of so far.
> > 
> > IIUC, you can query the NIC properties to find the hardware transfer
> > rate of the NICs. That doesn't imply apps can actually reach that
> > rate in practice - it has a decent chance of being a over-estimate
> > of bandwidth, possibly very very much over.
> > 
> > Is such an over estimate better or worse than QEMU's current
> > under-estimate ? It depends on the POV.
> > 
> > From the POV of QEMU, over-estimating means means it'll be not
> > be throttling as much as it should. That's not a downside of
> > migration - it makes it more likely for migration to complete :-)
> 
> Heh. :)
> 
> > 
> > From the POV of non-QEMU apps though, if QEMU over-estimates,
> > it'll mean other apps get starved of network bandwidth.
> > 
> > Overall I agree, there's no obvious way QEMU can ever come up
> > with a reliable estimate for bandwidth available.
> > 
> > > One way to fix this is when the user is fully aware of the available
> > > bandwidth, then we can allow the user to help providing an accurate value.
> > >
> > > For example, if the user has a dedicated channel of 10Gbps for migration
> > > for this specific VM, the user can specify this bandwidth so QEMU can
> > > always do the calculation based on this fact, trusting the user as long as
> > > specified.
> > 
> > I can see that in theory, but when considering a non-trivial
> > deployments of QEMU, I wonder if the user can really have any
> > such certainty of what is truely avaialble. It would need
> > global awareness of the whole network of hosts & workloads.
> 
> Indeed it may or may not be easy always.
> 
> The good thing about this parameter is we always use the old estimation if
> the user can't specify anything valid, so this is always optional not
> required.
> 
> It solves the cases where the user can still specify accurately on the bw -
> our QE team has already verified that it worked for us on GPU tests, where
> it used to not be able to migrate at all with any sane downtime specified.
> I should have attached a Tested-By from Zhiyi but since this is not exactly
> the patch he was using I didn't.
> 
> > 
> > > When the user wants to have migration only use 5Gbps out of that 10Gbps,
> > > one can set max-bandwidth to 5Gbps, along with available-bandwidth to 5Gbps
> > > so it'll never use over 5Gbps too (so the user can have the rest 5Gbps for
> > > other things).  So it can be useful even if the network is not dedicated,
> > > but as long as the user can know a solid value.
> > > 
> > > A new parameter "available-bandwidth" is introduced just for this. So when
> > > the user specified this parameter, instead of trusting the estimated value
> > > from QEMU itself (based on the QEMUFile send speed), let's trust the user
> > > more.
> > 
> > I feel like rather than "available-bandwidth", we should call
> > it "max-convergance-bandwidth".
> > 
> > To me that name would better reflect the fact that this isn't
> > really required to be a measure of how much NIC bandwidth is
> > available. It is merely an expression of a different bandwidth
> > limit to apply during switch over.
> > 
> > IOW
> > 
> > * max-bandwidth: limit during pre-copy main transfer
> > * max-convergance-bandwidth: limit during pre-copy switch-over
> > * max-postcopy-banwidth: limit during post-copy phase
> 
> I worry the new name suggested is not straightforward enough at the 1st
> glance, even to me as a developer.
> 
> "available-bandwidth" doesn't even bind that value to "convergence" at all,
> even though it was for solving this specific problem here. I wanted to make
> this parameter sololy for the admin to answer the question "how much
> bandwidth is available to QEMU migration in general?"  That's pretty much
> straightforward IMHO.  With that, it's pretty sane to consider using all we
> have during switchover (aka, unlimited bandwidth, as fast as possible).
> 
> Maybe at some point we can even leverage this information for other purpose
> rather than making the migration converge.

The flipside is that the semantics & limits we want for convergance
are already known to be different from what we wanted for pre-copy
and post-copy. With that existing practice, it is probably more
likely that we would not want to re-use the same setting for different
cases, which makes me think a specifically targetted parameter is
better.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


