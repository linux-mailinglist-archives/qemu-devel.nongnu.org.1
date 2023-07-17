Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F518755E97
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 10:37:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLJie-0007YY-Lg; Mon, 17 Jul 2023 04:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qLJiM-0007XR-3j
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 04:36:19 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qLJiJ-0008Og-Kv
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 04:36:17 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 58AA81F74C;
 Mon, 17 Jul 2023 08:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689582974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HHrVkTAl8YgnCYbdhuJPGo+xsQ9r4t/GsxrhesgrSDc=;
 b=zbTmwW8FbCjgrRsorq/aj/N0eKuwkOp+jJJKBoDJDBaGbmmLTetAtLCcV+eynwPdCZlvqN
 hqcJrZI1JW1ox/yFtnXkate7Ixrx0kV0/bw5xe8YG5gxh1YnEJOoE426y36+WQPeBrAaQZ
 4slMzeIWFmxtEPPE+6BwUvUlpSyD6UU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689582974;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HHrVkTAl8YgnCYbdhuJPGo+xsQ9r4t/GsxrhesgrSDc=;
 b=+jabRMNUihcc9INOHq5mBf+XDZqK96rbrmmzLewpgGyl35o0bo8bD99urH4EuOj4hB+J8V
 6qSCL/GdSBuUkWCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2B3813276;
 Mon, 17 Jul 2023 08:36:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IcwxOX39tGTPKgAAMHmgww
 (envelope-from <cfontana@suse.de>); Mon, 17 Jul 2023 08:36:13 +0000
Message-ID: <c552efe2-e9d5-1a53-86e9-14cd2f86e96b@suse.de>
Date: Mon, 17 Jul 2023 10:36:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: x86 custom apicid assignments [Was: Re: [PATCH v7 0/2] Remove
 EPYC mode apicid decode and use generic decode]
Content-Language: en-US
From: Claudio Fontana <cfontana@suse.de>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Babu Moger <babu.moger@amd.com>, pbonzini@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com, qemu-devel@nongnu.org, mst@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
References: <159897580089.30750.12581669374705391794.stgit@naples-babu.amd.com>
 <e6f25b8a-2a1e-0b40-c848-bbc2f13fdc5f@suse.de>
 <20230714115107.3d2e99ea@imammedo.users.ipa.redhat.com>
 <cf647180-d562-d986-e2dd-a818f127eb7e@suse.de>
In-Reply-To: <cf647180-d562-d986-e2dd-a818f127eb7e@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d;
 envelope-from=cfontana@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/17/23 10:32, Claudio Fontana wrote:
> Hello Igor,
> 
> thanks for getting back to me on this,
> 
> On 7/14/23 11:51, Igor Mammedov wrote:
>> On Wed, 5 Jul 2023 10:12:40 +0200
>> Claudio Fontana <cfontana@suse.de> wrote:
>>
>>> Hi all, partially resurrecting an old thread.
>>>
>>> I've seen how for Epyc something special was done in the past in terms of apicid assignments based on topology, which was then reverted apparently,
>>> but I wonder if something more general would be useful to all?
>>>
>>> The QEMU apicid assignments first of all do not seem to match what is happening on real hardware.
>>
>> QEMU typically does generate valid APIC IDs
>> it however doesn't do a good job when using odd number of cores and/or NUMA enabled cases.
> 
> 
> Right, this is what I meant, the QEMU assignment is generally a valid choice, it just seems to differ from what (some) hardware/firmware does.
> 
> 
> 
> 
>> (That is what Babu have attempted to fix, but eventually that have been dropped for
>> reasons described in quoted cover letter)
>>
>>> Functionally things are ok, but then when trying to investigate issues, specifically in the guest kernel KVM PV code (arch/x86/kernel/kvm.c),
>>> in some cases the actual apicid values in relationship to the topology do matter,
>>
>> Care to point out specific places you are referring to?
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
>>
>> KVM is not the only place where it might matter, it affects topo/numa code on guest side as well. 
>>
>>> and currently there is no way (I know of), of supplying our own apicid assignment, more closely matching what happens on hardware.
>>>
>>> This has been an issue when debugging guest images in the cloud, where being able to reproduce issues locally would be very beneficial as opposed to using cloud images as the feedback loop,
>>> but unfortunately QEMU cannot currently create the right apicid values to associate to the cpus.
>>
>> Indeed EPYC APIC encoding mess increases support cases load downstream,
>> but as long as one has access to similar host hw, one should be able
>> to reproduce the issue locally.
> 
> Unfortunately this does not seem to be always the case, with the case in point being the kvm pv code,
> but I suspect other buggy guest code whose behaviour depends on APICIds and APICId sequences must exist in more areas of the kernel.
> 
> In order to properly reproduce these kinds of issues locally, being able to assign desired APICIDs to cpus in VMs would come very handy.
> 
> 
>> However I would expect end result on such support end with an advice
>> to change topo/use another CPU model.
>>
>> (what we lack is a documentation what works and what doesn't,
>> perhaps writing guidelines would be sufficient to steer users
>> to the usable EPYC configurations)
> 
> 
> In our case we encountered issues on Intel too.
> 
> 
>>
>>> Do I understand the issue correctly, comments, ideas?
>>> How receptive the project would be for changes aimed at providing a custom assignment of apicids to cpus, regardless of Intel or AMD?
>>
>> It's not that simple to just set custom APIC ID in register and be done with it,
> 
> 
> right, I am under no illusion that this is going to be easy.
> 
> 
>> you'll likely break (from the top of my head: some CPUID leaves might
>> depend on it, ACPI tables, NUMA mapping, KVM's vcpu_id).
>>
>> Current topo code aims to work on information based on '-smp'/'-numa',
>> all through out QEMU codebase.
> 
> 
> just a thought, that information "-smp, -numa" could be optionally enriched with additional info on apicids assignment
> 
> 
>> If however we were let user set APIC ID (which is somehow
>> correct), we would need to take reverse steps to decode that
>> (in vendor specific way) and incorporate resulting topo into other
>> code that uses topology info.
>> That makes it quite messy, not to mention it's x86(AMD specific) and
>> doesn't fit well with generalizing topo handling.
>> So I don't really like this route.
> 
> 
> I don't think I am suggesting something like described in the preceding paragraph,
> but instead I would think that with the user providing the full apicid assignment map, (in addition / as part of)  to the -smp, -numa options,
> all other pieces would be derived from that (I suppose ACPI tables, cpuid leaves, and everything that the guest could see, plus the internal
> QEMU conversion functions between apicids and cpu index in topology.h
> 
> 
>>
>> (x86 cpus have apic_id property, so theoretically you can set it
>> and with some minimal hacking lunch a guest, but then
>> expect guest to be unhappy when ACPI ID goes out of sync with
>> everything else. I would do that only for the sake of an experiment
>> and wouldn't try to upstream that)
> 
> Right, it would all need to be consistent.
> 
>>
>> What I wouldn't mind is taking the 2nd stab at what Babu had tried
>> do. Provided it manages to encode APIC ID for EPYC correctly and won't
>> complicate code much (and still using -smp/-numa as the root source for
>> topo configuration).
> 
> 
> For the specific use case I am thinking (debugging with a guest-visible topology that resembles a cloud one),
> I don't think that the EPYC-specific work would be sufficient, it would need to be complemented in any case with Intel work,
> 
> but I suppose that a more general solution of the user providing all mappings would be the best and easiest one for this debugging scenario.
> 
> Thanks for your thoughts,
> 
> Claudio

As a PS: I had a lot of typos where I wrote ACPI ID instead of APIC ID, hope it does not cause too much confusion..

Ciao,

C

