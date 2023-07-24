Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B53760002
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 21:49:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qO1XS-0003KA-8p; Mon, 24 Jul 2023 15:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qO1XN-0003Jl-KX
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 15:48:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qO1XJ-0007Vv-8R
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 15:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690228084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bIlbK4n1b3WTpW6yQWmzZEoJLhv7/oS0PXwlWqAdiM8=;
 b=g11nGPCrR+LKemOsl99nWG6YC2m80OecNIF/Ea9XKj5P90UVXPosQWmkUzYggSILdoRZes
 K/OIzVog5Dl49fLVFmozqoQ0r+mGoassHMfDpBfS6mPUeT7edxbJkUcfUyG3fb4sFHEds+
 4Xv8S138Hr7UyppbQVsbrh3ucWCdJCc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-keJfy-XZMR-xjRw6zJIayQ-1; Mon, 24 Jul 2023 15:48:00 -0400
X-MC-Unique: keJfy-XZMR-xjRw6zJIayQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7672918d8a4so129669985a.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 12:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690228080; x=1690832880;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bIlbK4n1b3WTpW6yQWmzZEoJLhv7/oS0PXwlWqAdiM8=;
 b=laiRXkA0i61iuz4HexADzwobmdyZ3TrXscNS08BUvPU1mz0a3jVaAw0i7f8K1mIOYD
 m+0XuuE6hgmGR2zU14MiVgfuqFGTC4y5Ox+nzoF84Qu1fjpmW9oDh3Vb/YO/rLZFSSPM
 joh4rtI3YgX+OHZiusX14fMrvqPnH1/zkCnFAGeS89YjZ1XW4B/yqARrSq/r26mjccca
 TScmz6y2ZiK6+yexbw7yhej3KtU0HonIcfgnfDkZvrlJx3r3IAOg279ZCeX1RVmeMJlj
 1GGwTRjXAhPonihsxIjnHiPIXrXuNqHKBbl7jMWQbO0Egh0qZObooCaVaLTtIJhullCF
 saEA==
X-Gm-Message-State: ABy/qLbxQxvj7/zFHPeReo6F9av9qc0vD8WSYxkHrunzD5mGmFPyGoN7
 BDEtoWqiHGsA9EuQxzLoRB6vDd5SabiSOc0l/6znqDtQqzM+sug1bswBRr4HTYDugoXKt3QROvG
 Hi0aj3kzaV8ijlWk=
X-Received: by 2002:a05:620a:2492:b0:75b:23a1:69e4 with SMTP id
 i18-20020a05620a249200b0075b23a169e4mr14358488qkn.4.1690228079814; 
 Mon, 24 Jul 2023 12:47:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGQTIzNepMsZ15A4L6h9bmROUhUwXm5syHzh67XkXtrtuc0YpD30/xadZrXiF+AxP9DHLzczQ==
X-Received: by 2002:a05:620a:2492:b0:75b:23a1:69e4 with SMTP id
 i18-20020a05620a249200b0075b23a169e4mr14358472qkn.4.1690228079457; 
 Mon, 24 Jul 2023 12:47:59 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 oq16-20020a05620a611000b007672e3348edsm3204621qkn.108.2023.07.24.12.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 12:47:59 -0700 (PDT)
Date: Mon, 24 Jul 2023 15:47:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Chensheng Dong <chdong@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Allow user to specify migration available
 bandwidth
Message-ID: <ZL7VZsaFxkIq4+cP@x1n>
References: <20230724170755.1114519-1-peterx@redhat.com>
 <ZL69LTVHhNzEjqGM@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZL69LTVHhNzEjqGM@redhat.com>
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

On Mon, Jul 24, 2023 at 07:04:29PM +0100, Daniel P. Berrangé wrote:
> On Mon, Jul 24, 2023 at 01:07:55PM -0400, Peter Xu wrote:
> > Migration bandwidth is a very important value to live migration.  It's
> > because it's one of the major factors that we'll make decision on when to
> > switchover to destination in a precopy process.
> 
> To elaborate on this for those reading along...
> 
> QEMU takes maxmimum downtime limit and multiplies by its estimate
> of bandwidth. This gives a figure for the amount of data QEMU thinks
> it can transfer within the downtime period.
> 
> QEMU compares this figure to the amount of data that is still pending
> at the end of an iteration.
> 
> > This value is currently estimated by QEMU during the whole live migration
> > process by monitoring how fast we were sending the data.  This can be the
> > most accurate bandwidth if in the ideal world, where we're always feeding
> > unlimited data to the migration channel, and then it'll be limited to the
> > bandwidth that is available.
> 
> The QEMU estimate for available bandwidth will definitely be wrong,
> potentially by orders of magnitude, if QEMU has a max bandwidth limit
> set, as in that case it is never trying to push the peak rates available
> from the NICs/network fabric.
> 
> > The issue is QEMU itself may not be able to avoid those uncertainties on
> > measuing the real "available migration bandwidth".  At least not something
> > I can think of so far.
> 
> IIUC, you can query the NIC properties to find the hardware transfer
> rate of the NICs. That doesn't imply apps can actually reach that
> rate in practice - it has a decent chance of being a over-estimate
> of bandwidth, possibly very very much over.
> 
> Is such an over estimate better or worse than QEMU's current
> under-estimate ? It depends on the POV.
> 
> From the POV of QEMU, over-estimating means means it'll be not
> be throttling as much as it should. That's not a downside of
> migration - it makes it more likely for migration to complete :-)

Heh. :)

> 
> From the POV of non-QEMU apps though, if QEMU over-estimates,
> it'll mean other apps get starved of network bandwidth.
> 
> Overall I agree, there's no obvious way QEMU can ever come up
> with a reliable estimate for bandwidth available.
> 
> > One way to fix this is when the user is fully aware of the available
> > bandwidth, then we can allow the user to help providing an accurate value.
> >
> > For example, if the user has a dedicated channel of 10Gbps for migration
> > for this specific VM, the user can specify this bandwidth so QEMU can
> > always do the calculation based on this fact, trusting the user as long as
> > specified.
> 
> I can see that in theory, but when considering a non-trivial
> deployments of QEMU, I wonder if the user can really have any
> such certainty of what is truely avaialble. It would need
> global awareness of the whole network of hosts & workloads.

Indeed it may or may not be easy always.

The good thing about this parameter is we always use the old estimation if
the user can't specify anything valid, so this is always optional not
required.

It solves the cases where the user can still specify accurately on the bw -
our QE team has already verified that it worked for us on GPU tests, where
it used to not be able to migrate at all with any sane downtime specified.
I should have attached a Tested-By from Zhiyi but since this is not exactly
the patch he was using I didn't.

> 
> > When the user wants to have migration only use 5Gbps out of that 10Gbps,
> > one can set max-bandwidth to 5Gbps, along with available-bandwidth to 5Gbps
> > so it'll never use over 5Gbps too (so the user can have the rest 5Gbps for
> > other things).  So it can be useful even if the network is not dedicated,
> > but as long as the user can know a solid value.
> > 
> > A new parameter "available-bandwidth" is introduced just for this. So when
> > the user specified this parameter, instead of trusting the estimated value
> > from QEMU itself (based on the QEMUFile send speed), let's trust the user
> > more.
> 
> I feel like rather than "available-bandwidth", we should call
> it "max-convergance-bandwidth".
> 
> To me that name would better reflect the fact that this isn't
> really required to be a measure of how much NIC bandwidth is
> available. It is merely an expression of a different bandwidth
> limit to apply during switch over.
> 
> IOW
> 
> * max-bandwidth: limit during pre-copy main transfer
> * max-convergance-bandwidth: limit during pre-copy switch-over
> * max-postcopy-banwidth: limit during post-copy phase

I worry the new name suggested is not straightforward enough at the 1st
glance, even to me as a developer.

"available-bandwidth" doesn't even bind that value to "convergence" at all,
even though it was for solving this specific problem here. I wanted to make
this parameter sololy for the admin to answer the question "how much
bandwidth is available to QEMU migration in general?"  That's pretty much
straightforward IMHO.  With that, it's pretty sane to consider using all we
have during switchover (aka, unlimited bandwidth, as fast as possible).

Maybe at some point we can even leverage this information for other purpose
rather than making the migration converge.

Thanks,

-- 
Peter Xu


