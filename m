Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2190F761DCE
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 17:56:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOKNV-0007XO-Cz; Tue, 25 Jul 2023 11:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOKNT-0007X3-DS
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 11:55:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOKNR-0005Gf-34
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 11:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690300507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KzKx7tds4UwVg8XTu2i0mVULKFnOyBunIDT2SLKomUg=;
 b=e1jM0HfJZfQjGysf3a+YJyoHCkARlufGd5zz4zPcrDI7sg9WSb4mpdw6YWJWmJpKaYUK2j
 GIfKAEHLCCsZQpsHwFgJ1sKe7B0XyK/2GLq6s2xl84w46qdPCZ0jXYOiyHhqgaDzDL3HgB
 mhV0Kj/31go+mNZ0B2sCo0Sj760KDKg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-n5MgiEP9OfiQTmM2V40xHg-1; Tue, 25 Jul 2023 11:55:05 -0400
X-MC-Unique: n5MgiEP9OfiQTmM2V40xHg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-639d9eaf37aso12891506d6.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 08:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690300505; x=1690905305;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KzKx7tds4UwVg8XTu2i0mVULKFnOyBunIDT2SLKomUg=;
 b=FzvCTS2jaK+wejt6+4raWCFrdhBKO7/8fgQJ+dU3jyS+CgE4oixasAt407sBrSm1GV
 AQOHt6y0r+gRB5DmfWHlwHDtJ8/VEda/R8ZiLWYNHWTPvFCbhIYTPxEawyV200/1WIRY
 a7NY84pmDv+xH0+C+4mRDbwu+wY0ZittJBUup+bAAxgV4NPMX3msgLrRLIVm0y4yD/P3
 fWm04QHnmo7RbFF+oleR8U7GCUYvecX6gtDytY+Fube23zrOnFMG70ZT4vY6AMLZzjXi
 lXCqRSBZ0TF/ytyABUVW1MdXT2CZkcJM3rVWNDgNWD2w6BW+AzYqDT/VgchkTGL0CeM+
 upTw==
X-Gm-Message-State: ABy/qLbq3B+EgP+fqcLV/9FaUKPZgrHLQP9TnWq15tcEP9MpLcP9aWbL
 HAfPXmvEP43M4p2jx18tmv1x1RGg3g9v3Wpomexr3QK0Ndv/G7Iin8Jb9rATxSx6Vr2JzzUSfRh
 A5bsfNQPT94Nl8o0=
X-Received: by 2002:a05:6214:501d:b0:63c:f5fd:d30d with SMTP id
 jo29-20020a056214501d00b0063cf5fdd30dmr10534265qvb.1.1690300505457; 
 Tue, 25 Jul 2023 08:55:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHTSyCf+LfLuoZ5GT8XHSOAFZ1Ab/3p+54czpH02qUe9ySAbuLv+9v1oRd0ldkKHhTb/YLHxQ==
X-Received: by 2002:a05:6214:501d:b0:63c:f5fd:d30d with SMTP id
 jo29-20020a056214501d00b0063cf5fdd30dmr10534241qvb.1.1690300505050; 
 Tue, 25 Jul 2023 08:55:05 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 v12-20020a0cdd8c000000b005dd8b9345b9sm4434037qvk.81.2023.07.25.08.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 08:55:04 -0700 (PDT)
Date: Tue, 25 Jul 2023 11:54:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Chensheng Dong <chdong@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Allow user to specify migration available
 bandwidth
Message-ID: <ZL/wTBP/7ZdM9Xd4@x1n>
References: <20230724170755.1114519-1-peterx@redhat.com>
 <ZL69LTVHhNzEjqGM@redhat.com> <ZL7VZsaFxkIq4+cP@x1n>
 <ZL+TBBtL+RiMrOXJ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZL+TBBtL+RiMrOXJ@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Jul 25, 2023 at 10:16:52AM +0100, Daniel P. Berrangé wrote:
> On Mon, Jul 24, 2023 at 03:47:50PM -0400, Peter Xu wrote:
> > On Mon, Jul 24, 2023 at 07:04:29PM +0100, Daniel P. Berrangé wrote:
> > > On Mon, Jul 24, 2023 at 01:07:55PM -0400, Peter Xu wrote:
> > > > Migration bandwidth is a very important value to live migration.  It's
> > > > because it's one of the major factors that we'll make decision on when to
> > > > switchover to destination in a precopy process.
> > > 
> > > To elaborate on this for those reading along...
> > > 
> > > QEMU takes maxmimum downtime limit and multiplies by its estimate
> > > of bandwidth. This gives a figure for the amount of data QEMU thinks
> > > it can transfer within the downtime period.
> > > 
> > > QEMU compares this figure to the amount of data that is still pending
> > > at the end of an iteration.
> > > 
> > > > This value is currently estimated by QEMU during the whole live migration
> > > > process by monitoring how fast we were sending the data.  This can be the
> > > > most accurate bandwidth if in the ideal world, where we're always feeding
> > > > unlimited data to the migration channel, and then it'll be limited to the
> > > > bandwidth that is available.
> > > 
> > > The QEMU estimate for available bandwidth will definitely be wrong,
> > > potentially by orders of magnitude, if QEMU has a max bandwidth limit
> > > set, as in that case it is never trying to push the peak rates available
> > > from the NICs/network fabric.
> > > 
> > > > The issue is QEMU itself may not be able to avoid those uncertainties on
> > > > measuing the real "available migration bandwidth".  At least not something
> > > > I can think of so far.
> > > 
> > > IIUC, you can query the NIC properties to find the hardware transfer
> > > rate of the NICs. That doesn't imply apps can actually reach that
> > > rate in practice - it has a decent chance of being a over-estimate
> > > of bandwidth, possibly very very much over.
> > > 
> > > Is such an over estimate better or worse than QEMU's current
> > > under-estimate ? It depends on the POV.
> > > 
> > > From the POV of QEMU, over-estimating means means it'll be not
> > > be throttling as much as it should. That's not a downside of
> > > migration - it makes it more likely for migration to complete :-)
> > 
> > Heh. :)
> > 
> > > 
> > > From the POV of non-QEMU apps though, if QEMU over-estimates,
> > > it'll mean other apps get starved of network bandwidth.
> > > 
> > > Overall I agree, there's no obvious way QEMU can ever come up
> > > with a reliable estimate for bandwidth available.
> > > 
> > > > One way to fix this is when the user is fully aware of the available
> > > > bandwidth, then we can allow the user to help providing an accurate value.
> > > >
> > > > For example, if the user has a dedicated channel of 10Gbps for migration
> > > > for this specific VM, the user can specify this bandwidth so QEMU can
> > > > always do the calculation based on this fact, trusting the user as long as
> > > > specified.
> > > 
> > > I can see that in theory, but when considering a non-trivial
> > > deployments of QEMU, I wonder if the user can really have any
> > > such certainty of what is truely avaialble. It would need
> > > global awareness of the whole network of hosts & workloads.
> > 
> > Indeed it may or may not be easy always.
> > 
> > The good thing about this parameter is we always use the old estimation if
> > the user can't specify anything valid, so this is always optional not
> > required.
> > 
> > It solves the cases where the user can still specify accurately on the bw -
> > our QE team has already verified that it worked for us on GPU tests, where
> > it used to not be able to migrate at all with any sane downtime specified.
> > I should have attached a Tested-By from Zhiyi but since this is not exactly
> > the patch he was using I didn't.
> > 
> > > 
> > > > When the user wants to have migration only use 5Gbps out of that 10Gbps,
> > > > one can set max-bandwidth to 5Gbps, along with available-bandwidth to 5Gbps
> > > > so it'll never use over 5Gbps too (so the user can have the rest 5Gbps for
> > > > other things).  So it can be useful even if the network is not dedicated,
> > > > but as long as the user can know a solid value.
> > > > 
> > > > A new parameter "available-bandwidth" is introduced just for this. So when
> > > > the user specified this parameter, instead of trusting the estimated value
> > > > from QEMU itself (based on the QEMUFile send speed), let's trust the user
> > > > more.
> > > 
> > > I feel like rather than "available-bandwidth", we should call
> > > it "max-convergance-bandwidth".
> > > 
> > > To me that name would better reflect the fact that this isn't
> > > really required to be a measure of how much NIC bandwidth is
> > > available. It is merely an expression of a different bandwidth
> > > limit to apply during switch over.
> > > 
> > > IOW
> > > 
> > > * max-bandwidth: limit during pre-copy main transfer
> > > * max-convergance-bandwidth: limit during pre-copy switch-over
> > > * max-postcopy-banwidth: limit during post-copy phase
> > 
> > I worry the new name suggested is not straightforward enough at the 1st
> > glance, even to me as a developer.
> > 
> > "available-bandwidth" doesn't even bind that value to "convergence" at all,
> > even though it was for solving this specific problem here. I wanted to make
> > this parameter sololy for the admin to answer the question "how much
> > bandwidth is available to QEMU migration in general?"  That's pretty much
> > straightforward IMHO.  With that, it's pretty sane to consider using all we
> > have during switchover (aka, unlimited bandwidth, as fast as possible).
> > 
> > Maybe at some point we can even leverage this information for other purpose
> > rather than making the migration converge.
> 
> The flipside is that the semantics & limits we want for convergance
> are already known to be different from what we wanted for pre-copy
> and post-copy. With that existing practice, it is probably more
> likely that we would not want to re-use the same setting for different
> cases, which makes me think a specifically targetted parameter is
> better.

We can make the semantics specific, no strong opinion here.  I wished it
can be as generic / easy as possible but maybe I went too far.

Though, is there anything else we can choose from besides
"max-convergence-bandwidth"? Or am I the only one that thinks it's hard to
understand when put "max" and "convergence" together?

When I take one step back to look at the whole "bandwidth" parameters, I am
not sure why we'd even need both "convergence" and "postcopy" bandwidth
being separate.  With my current understanding of migration, we may
actually need:

  - One bandwidth that we may want to run the background migration, aka,
    precopy migration, where we don't rush on pushing data.

  - One bandwidth that is whatever we can have maximum; for dedicated NIC
    that's the line speed.  We should always use this full speed for
    important things.  I'd say postcopy falls into this, and this
    "convergence" calculation should also rely on this.

So another way to do this is we leverage the existing "postcopy-bandwidth"
for calculation when set, it may help us to shrink the bandwidth values to
two, but I'm not sure whether the name can be confusing too.

Thanks,

-- 
Peter Xu


