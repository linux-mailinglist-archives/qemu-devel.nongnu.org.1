Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F16D7560A3
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 12:38:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLLcE-0005lc-TW; Mon, 17 Jul 2023 06:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qLLcA-0005lN-Ed
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 06:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qLLc7-0001zD-Sg
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 06:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689590278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dHK7Wr2rK92Bgu79vel7QH6jzr8XSU8N5rfanbPiaNk=;
 b=NL7T3+uzZ9f1HgfAQOl3rDSdud+/ZA06Dr3XPTfyZKM61SSFl6B7+f409NG5reGKSZJ1Ye
 vrxxzftLBCE1N7mDdLdQwhJihmyc0+vL03ksFVBv3h+JciKPyGxGljzBwuIHA5i48bUnXs
 IuE6FWRJwsBzlwl4yF7QpgkbVyHw2xA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-hkbYm_7JPqGV5awYv-zGog-1; Mon, 17 Jul 2023 06:37:56 -0400
X-MC-Unique: hkbYm_7JPqGV5awYv-zGog-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-50bf847b267so3240580a12.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 03:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689590275; x=1692182275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dHK7Wr2rK92Bgu79vel7QH6jzr8XSU8N5rfanbPiaNk=;
 b=JoDtcOrSFPxhtxWB6Hbswg2TPcApyDIvryG62YNkLgS3UJK2Aoils+T95CeHQaYbjQ
 coFK/ptdxC+GGsAQyGz1ABfpRq7DpOWySrb6iNvc6yY0YoLskKNE11j7On+viEGcAHD5
 wX8KnWcR0YdRNR9CQveGQHYOcBMyWjm6H4VEWiIw4oYwbenhnaIgrRVukyrlq9DSekW5
 Wlfhvy9UsoE3HtNDZJpOjWQd6Et4P/sWi6xlibPHcNPV5wsKzfLPk9u05wcFCyS7Xf+q
 t/wttLxEbGJf5d+duFAVyJLyl3/vugGA81BZKk+YPTvGohXKYQEjxYTwfjScp+T9nNq3
 Gwzg==
X-Gm-Message-State: ABy/qLaYXn4nxMeqfJND35NViTyyasLEvNSoqqfQswNENQCQCMfukmwV
 iw/DMzLbko6Cl5XEo31wpW41rY/JuqFpdMFpDYg+fuXHf7MHgXmZHU3jD2D/AMh/d2vzcMCRYnv
 k+OQtD00tCDYQpDs=
X-Received: by 2002:a17:907:2950:b0:993:e752:1a70 with SMTP id
 et16-20020a170907295000b00993e7521a70mr11179737ejc.19.1689590275195; 
 Mon, 17 Jul 2023 03:37:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGGjbyL+Id29pyAULy+F+U69bj8K8FmGooAOx+2izI9DPWmC/RXSiXnBu8m59QJfh3PtrBd3w==
X-Received: by 2002:a17:907:2950:b0:993:e752:1a70 with SMTP id
 et16-20020a170907295000b00993e7521a70mr11179719ejc.19.1689590274818; 
 Mon, 17 Jul 2023 03:37:54 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 l13-20020a1709060e0d00b00992b1c93279sm9024921eji.110.2023.07.17.03.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 03:37:53 -0700 (PDT)
Date: Mon, 17 Jul 2023 12:37:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Cc: Babu Moger <babu.moger@amd.com>, pbonzini@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com, qemu-devel@nongnu.org, mst@redhat.com, Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: x86 custom apicid assignments [Was: Re: [PATCH v7 0/2] Remove
 EPYC mode apicid decode and use generic decode]
Message-ID: <20230717123753.75050c16@imammedo.users.ipa.redhat.com>
In-Reply-To: <cf647180-d562-d986-e2dd-a818f127eb7e@suse.de>
References: <159897580089.30750.12581669374705391794.stgit@naples-babu.amd.com>
 <e6f25b8a-2a1e-0b40-c848-bbc2f13fdc5f@suse.de>
 <20230714115107.3d2e99ea@imammedo.users.ipa.redhat.com>
 <cf647180-d562-d986-e2dd-a818f127eb7e@suse.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Mon, 17 Jul 2023 10:32:33 +0200
Claudio Fontana <cfontana@suse.de> wrote:

> Hello Igor,
> 
> thanks for getting back to me on this,
> 
> On 7/14/23 11:51, Igor Mammedov wrote:
> > On Wed, 5 Jul 2023 10:12:40 +0200
> > Claudio Fontana <cfontana@suse.de> wrote:
> >   
> >> Hi all, partially resurrecting an old thread.
> >>
> >> I've seen how for Epyc something special was done in the past in terms of apicid assignments based on topology, which was then reverted apparently,
> >> but I wonder if something more general would be useful to all?
> >>
> >> The QEMU apicid assignments first of all do not seem to match what is happening on real hardware.  
> > 
> > QEMU typically does generate valid APIC IDs
> > it however doesn't do a good job when using odd number of cores and/or NUMA enabled cases.  
> 
> 
> Right, this is what I meant, the QEMU assignment is generally a valid choice, it just seems to differ from what (some) hardware/firmware does.
> 
> 
> 
> 
> > (That is what Babu have attempted to fix, but eventually that have been dropped for
> > reasons described in quoted cover letter)
> >   
> >> Functionally things are ok, but then when trying to investigate issues, specifically in the guest kernel KVM PV code (arch/x86/kernel/kvm.c),
> >> in some cases the actual apicid values in relationship to the topology do matter,  
> > 
> > Care to point out specific places you are referring to?  
> 
> 
> What we wanted to do was to reproduce an issue that only happened when booting our distro in the Cloud,
> but did not instead appear by booting locally (neither on bare metal nor under QEMU/KVM).
> 
> In the end, after a lot of slow-turnaround research, the issue we encountered was the already fixed:
>  
> commit c15e0ae42c8e5a61e9aca8aac920517cf7b3e94e
> Author: Li RongQing <lirongqing@baidu.com>
> Date:   Wed Mar 9 16:35:44 2022 +0800
> 
>     KVM: x86: fix sending PV IPI
>     
>     If apic_id is less than min, and (max - apic_id) is greater than
>     KVM_IPI_CLUSTER_SIZE, then the third check condition is satisfied but
>     the new apic_id does not fit the bitmask.  In this case __send_ipi_mask
>     should send the IPI.
>     
>     This is mostly theoretical, but it can happen if the apic_ids on three
>     iterations of the loop are for example 1, KVM_IPI_CLUSTER_SIZE, 0.
>     
>     Fixes: aaffcfd1e82 ("KVM: X86: Implement PV IPIs in linux guest")
>     Signed-off-by: Li RongQing <lirongqing@baidu.com>
>     Message-Id: <1646814944-51801-1-git-send-email-lirongqing@baidu.com>
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> 
> But this took a very long time to investigate, because the KVM PV code only misbehaves with the old unpatched algorithm during boot
> if it encounters a specific sequence of ACPI IDs,
> where countrary to the comment in the commit, the issue can become very practical depending on such ACPI IDs assignments as seen by the guest KVM PV code.
> 
> > 
> > KVM is not the only place where it might matter, it affects topo/numa code on guest side as well. 
> >   
> >> and currently there is no way (I know of), of supplying our own apicid assignment, more closely matching what happens on hardware.
> >>
> >> This has been an issue when debugging guest images in the cloud, where being able to reproduce issues locally would be very beneficial as opposed to using cloud images as the feedback loop,
> >> but unfortunately QEMU cannot currently create the right apicid values to associate to the cpus.  
> > 
> > Indeed EPYC APIC encoding mess increases support cases load downstream,
> > but as long as one has access to similar host hw, one should be able
> > to reproduce the issue locally.  
> 
> Unfortunately this does not seem to be always the case, with the case in point being the kvm pv code,
> but I suspect other buggy guest code whose behaviour depends on APICIds and APICId sequences must exist in more areas of the kernel.
> 
> In order to properly reproduce these kinds of issues locally, being able to assign desired APICIDs to cpus in VMs would come very handy.
> 
> 
> > However I would expect end result on such support end with an advice
> > to change topo/use another CPU model.
> > 
> > (what we lack is a documentation what works and what doesn't,
> > perhaps writing guidelines would be sufficient to steer users
> > to the usable EPYC configurations)  
> 
> 
> In our case we encountered issues on Intel too.

on Intel I've seen issues only in cases where specified topo wasn't
really supported by given CPU model (Intel CPUs are far from perfect
and kernel has a few quirks when it comes to handling topo (
the same as it has quirks for AMD cpus)).
On QEMU level we hasn't bothered implementing topo quirks
(modulo EPYC attempt, which we've later decided not worth of
complexity of supporting it)


> >   
> >> Do I understand the issue correctly, comments, ideas?
> >> How receptive the project would be for changes aimed at providing a custom assignment of apicids to cpus, regardless of Intel or AMD?  
> > 
> > It's not that simple to just set custom APIC ID in register and be done with it,  
> 
> 
> right, I am under no illusion that this is going to be easy.
> 
> 
> > you'll likely break (from the top of my head: some CPUID leaves might
> > depend on it, ACPI tables, NUMA mapping, KVM's vcpu_id).
> > 
> > Current topo code aims to work on information based on '-smp'/'-numa',
> > all through out QEMU codebase.  
> 
> 
> just a thought, that information "-smp, -numa" could be optionally enriched with additional info on apicids assignment
> 
> 
> > If however we were let user set APIC ID (which is somehow
> > correct), we would need to take reverse steps to decode that
> > (in vendor specific way) and incorporate resulting topo into other
> > code that uses topology info.
> > That makes it quite messy, not to mention it's x86(AMD specific) and
> > doesn't fit well with generalizing topo handling.
> > So I don't really like this route.  
> 
> 
> I don't think I am suggesting something like described in the preceding paragraph,
> but instead I would think that with the user providing the full apicid assignment map, (in addition / as part of)  to the -smp, -numa options,
> all other pieces would be derived from that (I suppose ACPI tables, cpuid leaves, and everything that the guest could see, plus the internal
> QEMU conversion functions between apicids and cpu index in topology.h

As I read it, you described the same approach as me, just in different words.

ACPI ID, is a function of -smp/-numa (and sometimes -cpu, which we ignore atm).
Pushing APIC ID up to a user visible interface duplicates that information.
That's would be my main objection to the approach.

Also my educated guess tells me that it would even more complicate
already not easy to deal with topo code.

If you really wish QEMU emulate FOO hypervisor, create a dedicated
board for it, that behaves as FOO and that could generate the same
topology based on -smp/-numa. (That approach might be acceptable,
assuming it self-containing and doesn't complicate common code a lot)

> > (x86 cpus have apic_id property, so theoretically you can set it
> > and with some minimal hacking lunch a guest, but then
> > expect guest to be unhappy when ACPI ID goes out of sync with
> > everything else. I would do that only for the sake of an experiment
> > and wouldn't try to upstream that)  
> 
> Right, it would all need to be consistent.
> 
> > 
> > What I wouldn't mind is taking the 2nd stab at what Babu had tried
> > do. Provided it manages to encode APIC ID for EPYC correctly and won't
> > complicate code much (and still using -smp/-numa as the root source for
> > topo configuration).  
> 
> 
> For the specific use case I am thinking (debugging with a guest-visible topology that resembles a cloud one),
> I don't think that the EPYC-specific work would be sufficient, it would need to be complemented in any case with Intel work,
> 
> but I suppose that a more general solution of the user providing all mappings would be the best and easiest one for this debugging scenario.

All of that for the sake of debugging some thirdparty hypervisor
issues (which in my opinion doesn't benefit QEMU* at all).
So do we really need this in QEMU code-base?

I think about this use-case as 1-off thingy, where I can quickly hack
QEMU by hardcodding desired specifics to get where I want, but not
something that I would try to upstream as it's not useful for the project
in general.

* under QEMU here I mean all the folks who have to read/touch/maintain
this code. (not to mention poor users who decided use this feature).

> Thanks for your thoughts,
> 
> Claudio
> >>
> >>
> >> On 9/1/20 17:57, Babu Moger wrote:  
> >>> To support some of the complex topology, we introduced EPYC mode apicid decode.
> >>> But, EPYC mode decode is running into problems. Also it can become quite a
> >>> maintenance problem in the future. So, it was decided to remove that code and
> >>> use the generic decode which works for majority of the topology. Most of the
> >>> SPECed configuration would work just fine. With some non-SPECed user inputs,
> >>> it will create some sub-optimal configuration.
> >>>
> >>> Here is the discussion thread.
> >>> https://lore.kernel.org/qemu-devel/c0bcc1a6-1d84-a6e7-e468-d5b437c1b254@amd.com/
> >>> https://lore.kernel.org/qemu-devel/20200826143849.59f6970b@redhat.com/
> >>>
> >>> This series removes all the EPYC mode specific apicid changes and use the generic
> >>> apicid decode.
> >>> ---
> >>> v7:
> >>>  Eduardo has already queued 1-8 from the v6. Sending rest of the patches.
> >>>  Fixed CPUID 800000ld based on Igor's comment and few text changes.
> >>>  
> >>> v6:
> >>>  https://lore.kernel.org/qemu-devel/159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com/
> >>>  Found out that numa configuration is not mandatory for all the EPYC model topology.
> >>>  We can use the generic decode which works pretty well. Also noticed that
> >>>  cpuid does not changes when the numa nodes change(NPS- Nodes per socket).
> >>>  Took care of couple comments from Igor and Eduardo.
> >>>  Thank you Igor, Daniel, David, Eduardo for your feedback.  
> >>>
> >>> v5:
> >>>  https://lore.kernel.org/qemu-devel/159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com/
> >>>  Revert EPYC specific decode.
> >>>  Simplify CPUID_8000_001E
> >>>
> >>> v4:
> >>>   https://lore.kernel.org/qemu-devel/159744083536.39197.13827776633866601278.stgit@naples-babu.amd.com/
> >>>   Not much of a change. Just added few text changes.
> >>>   Error out configuration instead of warning if dies are not configured in EPYC.
> >>>   Few other text changes to clarify the removal of node_id, nr_nodes and nodes_per_pkg.
> >>>
> >>> v3:
> >>>   https://lore.kernel.org/qemu-devel/159681772267.9679.1334429994189974662.stgit@naples-babu.amd.com/#r
> >>>   Added a new check to pass the dies for EPYC numa configuration.
> >>>   Added Simplify CPUID_8000_001E patch with some changes suggested by Igor.
> >>>   Dropped the patch to build the topology from CpuInstanceProperties.
> >>>   TODO: Not sure if we still need the Autonuma changes Igor mentioned.
> >>>   Needs more clarity on that.
> >>>
> >>> v2:
> >>>   https://lore.kernel.org/qemu-devel/159362436285.36204.986406297373871949.stgit@naples-babu.amd.com/
> >>>   Used the numa information from CpuInstanceProperties for building
> >>>   the apic_id suggested by Igor.
> >>>   Also did some minor code re-aarangement to take care of changes.
> >>>   Dropped the patch "Simplify CPUID_8000_001E" from v1. Will send
> >>>   it later.
> >>>
> >>> v1:
> >>>  https://lore.kernel.org/qemu-devel/159164739269.20543.3074052993891532749.stgit@naples-babu.amd.com
> >>>
> >>> Babu Moger (2):
> >>>       i386: Simplify CPUID_8000_001d for AMD
> >>>       i386: Simplify CPUID_8000_001E for AMD
> >>>
> >>>
> >>>  target/i386/cpu.c |  226 ++++++++++++++---------------------------------------
> >>>  1 file changed, 61 insertions(+), 165 deletions(-)
> >>>
> >>> --
> >>>     
> >>  
> >   
> 


