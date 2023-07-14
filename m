Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 302C9753722
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 11:52:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKFSH-0007oQ-VL; Fri, 14 Jul 2023 05:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qKFSF-0007oD-FF
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 05:51:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qKFSD-0004Ik-Eh
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 05:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689328272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mQ117J4m/3d+YOaL7AgJjZQRLPuUXgb33HB6UGqQ0Mc=;
 b=FhIDG/XesviF7egAWzK5/L6wCE4qRDtMqkG3hmk6+pkVqWTsELe/kIoa/RHSQcEaQ137Gs
 F4oCtpemwKUP5zZ6azltP+yxW9dpztimStrOqdLDKzFALT3RwBCNwdpfnbDfK+i3NjdZrg
 cSifXlncGtZeQN00VHkMjLIhnKKzVFA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-W8QkoA0pN2K_M3oj43q2Gw-1; Fri, 14 Jul 2023 05:51:10 -0400
X-MC-Unique: W8QkoA0pN2K_M3oj43q2Gw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-506b21104faso1055836a12.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 02:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689328269; x=1691920269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mQ117J4m/3d+YOaL7AgJjZQRLPuUXgb33HB6UGqQ0Mc=;
 b=LI3w0Bj96lplT4PKrh9sYNpP8czvQgMKHhz7grPkNCsTfUty45YCnVejPx8rYkeu6p
 HHiVuSzV4SdpHYIKOdF/q7NRp8Pm/UuDJGOspVNPkKSs0zLeaIGxCl04/oIHTyO1byV9
 FScMZNj4zIdWWZcJ6kKYToC6XX99HzYOgE86+5DmFdnl6nVNxETZNhd+JjjT2E350sfC
 jGbbJ/WbiI+uiq14Zl9iof1TThKWv2NqyY9D5NeVCQXJ1o3OnpDOrAZ6KcS2uY+4D+ED
 Eh8zJQjrahl+SOacWob7yZZcy2wGYYauDAZ4XBLnj5BMLatHLsUJq0yKlZxs8cli1WSP
 umNQ==
X-Gm-Message-State: ABy/qLYV82X51ezNyvwRMGcmemhDrdkuJDdpQJ83AfG2OucVcsOBjoML
 twPwxBwcIT/Vi9xQhAfnEHCYkqGWF0GW3SiNAQ4SbOJJphV2ZaFAW2dcDOhZdlJ2Nm342D4DNM+
 Y/ZgKZiEjSNh7dF8=
X-Received: by 2002:aa7:dd13:0:b0:51e:fbe:dc81 with SMTP id
 i19-20020aa7dd13000000b0051e0fbedc81mr3925437edv.3.1689328269043; 
 Fri, 14 Jul 2023 02:51:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHOOGHQrudEbqHbn3uA1RvnesHAWdIug2ZCUZxOFafPfBgQBGF/8cDKG3d5PqTf42GyqSDB5A==
X-Received: by 2002:aa7:dd13:0:b0:51e:fbe:dc81 with SMTP id
 i19-20020aa7dd13000000b0051e0fbedc81mr3925426edv.3.1689328268601; 
 Fri, 14 Jul 2023 02:51:08 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 s11-20020aa7c54b000000b0050cc4461fc5sm5448184edr.92.2023.07.14.02.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 02:51:07 -0700 (PDT)
Date: Fri, 14 Jul 2023 11:51:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Cc: Babu Moger <babu.moger@amd.com>, pbonzini@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com, qemu-devel@nongnu.org, mst@redhat.com, Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: x86 custom apicid assignments [Was: Re: [PATCH v7 0/2] Remove
 EPYC mode apicid decode and use generic decode]
Message-ID: <20230714115107.3d2e99ea@imammedo.users.ipa.redhat.com>
In-Reply-To: <e6f25b8a-2a1e-0b40-c848-bbc2f13fdc5f@suse.de>
References: <159897580089.30750.12581669374705391794.stgit@naples-babu.amd.com>
 <e6f25b8a-2a1e-0b40-c848-bbc2f13fdc5f@suse.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Wed, 5 Jul 2023 10:12:40 +0200
Claudio Fontana <cfontana@suse.de> wrote:

> Hi all, partially resurrecting an old thread.
> 
> I've seen how for Epyc something special was done in the past in terms of apicid assignments based on topology, which was then reverted apparently,
> but I wonder if something more general would be useful to all?
> 
> The QEMU apicid assignments first of all do not seem to match what is happening on real hardware.

QEMU typically does generate valid APIC IDs
it however doesn't do a good job when using odd number of cores and/or NUMA enabled cases.
(That is what Babu have attempted to fix, but eventually that have been dropped for
reasons described in quoted cover letter)

> Functionally things are ok, but then when trying to investigate issues, specifically in the guest kernel KVM PV code (arch/x86/kernel/kvm.c),
> in some cases the actual apicid values in relationship to the topology do matter,

Care to point out specific places you are referring to?

KVM is not the only place where it might matter, it affects topo/numa code on guest side as well. 

> and currently there is no way (I know of), of supplying our own apicid assignment, more closely matching what happens on hardware.
> 
> This has been an issue when debugging guest images in the cloud, where being able to reproduce issues locally would be very beneficial as opposed to using cloud images as the feedback loop,
> but unfortunately QEMU cannot currently create the right apicid values to associate to the cpus.

Indeed EPYC APIC encoding mess increases support cases load downstream,
but as long as one has access to similar host hw, one should be able
to reproduce the issue locally.
However I would expect end result on such support end with an advice
to change topo/use another CPU model.

(what we lack is a documentation what works and what doesn't,
perhaps writing guidelines would be sufficient to steer users
to the usable EPYC configurations)

> Do I understand the issue correctly, comments, ideas?
> How receptive the project would be for changes aimed at providing a custom assignment of apicids to cpus, regardless of Intel or AMD?

It's not that simple to just set custom APIC ID in register and be done with it,
you'll likely break (from the top of my head: some CPUID leaves might
depend on it, ACPI tables, NUMA mapping, KVM's vcpu_id).

Current topo code aims to work on information based on '-smp'/'-numa',
all through out QEMU codebase.
If however we were let user set APIC ID (which is somehow
correct), we would need to take reverse steps to decode that
(in vendor specific way) and incorporate resulting topo into other
code that uses topology info.
That makes it quite messy, not to mention it's x86(AMD specific) and
doesn't fit well with generalizing topo handling.
So I don't really like this route.

(x86 cpus have apic_id property, so theoretically you can set it
and with some minimal hacking lunch a guest, but then
expect guest to be unhappy when ACPI ID goes out of sync with
everything else. I would do that only for the sake of an experiment
and wouldn't try to upstream that)

What I wouldn't mind is taking the 2nd stab at what Babu had tried
do. Provided it manages to encode APIC ID for EPYC correctly and won't
complicate code much (and still using -smp/-numa as the root source for
topo configuration).
 
> Thanks,
> 
> Claudio
> 
> 
> 
> On 9/1/20 17:57, Babu Moger wrote:
> > To support some of the complex topology, we introduced EPYC mode apicid decode.
> > But, EPYC mode decode is running into problems. Also it can become quite a
> > maintenance problem in the future. So, it was decided to remove that code and
> > use the generic decode which works for majority of the topology. Most of the
> > SPECed configuration would work just fine. With some non-SPECed user inputs,
> > it will create some sub-optimal configuration.
> > 
> > Here is the discussion thread.
> > https://lore.kernel.org/qemu-devel/c0bcc1a6-1d84-a6e7-e468-d5b437c1b254@amd.com/
> > https://lore.kernel.org/qemu-devel/20200826143849.59f6970b@redhat.com/
> > 
> > This series removes all the EPYC mode specific apicid changes and use the generic
> > apicid decode.
> > ---
> > v7:
> >  Eduardo has already queued 1-8 from the v6. Sending rest of the patches.
> >  Fixed CPUID 800000ld based on Igor's comment and few text changes.
> >  
> > v6:
> >  https://lore.kernel.org/qemu-devel/159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com/
> >  Found out that numa configuration is not mandatory for all the EPYC model topology.
> >  We can use the generic decode which works pretty well. Also noticed that
> >  cpuid does not changes when the numa nodes change(NPS- Nodes per socket).
> >  Took care of couple comments from Igor and Eduardo.
> >  Thank you Igor, Daniel, David, Eduardo for your feedback.  
> > 
> > v5:
> >  https://lore.kernel.org/qemu-devel/159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com/
> >  Revert EPYC specific decode.
> >  Simplify CPUID_8000_001E
> > 
> > v4:
> >   https://lore.kernel.org/qemu-devel/159744083536.39197.13827776633866601278.stgit@naples-babu.amd.com/
> >   Not much of a change. Just added few text changes.
> >   Error out configuration instead of warning if dies are not configured in EPYC.
> >   Few other text changes to clarify the removal of node_id, nr_nodes and nodes_per_pkg.
> > 
> > v3:
> >   https://lore.kernel.org/qemu-devel/159681772267.9679.1334429994189974662.stgit@naples-babu.amd.com/#r
> >   Added a new check to pass the dies for EPYC numa configuration.
> >   Added Simplify CPUID_8000_001E patch with some changes suggested by Igor.
> >   Dropped the patch to build the topology from CpuInstanceProperties.
> >   TODO: Not sure if we still need the Autonuma changes Igor mentioned.
> >   Needs more clarity on that.
> > 
> > v2:
> >   https://lore.kernel.org/qemu-devel/159362436285.36204.986406297373871949.stgit@naples-babu.amd.com/
> >   Used the numa information from CpuInstanceProperties for building
> >   the apic_id suggested by Igor.
> >   Also did some minor code re-aarangement to take care of changes.
> >   Dropped the patch "Simplify CPUID_8000_001E" from v1. Will send
> >   it later.
> > 
> > v1:
> >  https://lore.kernel.org/qemu-devel/159164739269.20543.3074052993891532749.stgit@naples-babu.amd.com
> > 
> > Babu Moger (2):
> >       i386: Simplify CPUID_8000_001d for AMD
> >       i386: Simplify CPUID_8000_001E for AMD
> > 
> > 
> >  target/i386/cpu.c |  226 ++++++++++++++---------------------------------------
> >  1 file changed, 61 insertions(+), 165 deletions(-)
> > 
> > --
> >   
> 


