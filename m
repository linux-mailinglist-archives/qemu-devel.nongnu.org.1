Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFACA747F23
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 10:13:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGxd1-000345-Ok; Wed, 05 Jul 2023 04:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qGxd0-00032e-LP
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 04:12:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qGxcy-0006gL-LK
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 04:12:46 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0E4571F890;
 Wed,  5 Jul 2023 08:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688544761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vU65OOEypfxeMPmKX3ZU2MSqAyjcChKZaS1e1xIColo=;
 b=eHaH0LHG0CwBI9P5vgXhsaV77yevOWnD9MnJsqE2lzyaS8TaaQf+iVcae69+SlByNLfW2+
 EnUOxTIDeHTvgpzcGepaaJz5CcD6W3Meig5PejsvF5TCyDmcihy7wdSu+qqRMdcSlnKToY
 EAK8m/3vuoAzlKh5M5eW+IUURei1BAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688544761;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vU65OOEypfxeMPmKX3ZU2MSqAyjcChKZaS1e1xIColo=;
 b=5xJPxsfv098DJgKBdlhWb+zeWv3z1f30Kma3lsliYjjML7aR+W44vN+oYfrxo/qIU/wNrr
 xG/b1Yfv2jBi1EAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE14313460;
 Wed,  5 Jul 2023 08:12:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ttO/LPglpWRlRQAAMHmgww
 (envelope-from <cfontana@suse.de>); Wed, 05 Jul 2023 08:12:40 +0000
Message-ID: <e6f25b8a-2a1e-0b40-c848-bbc2f13fdc5f@suse.de>
Date: Wed, 5 Jul 2023 10:12:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: x86 custom apicid assignments [Was: Re: [PATCH v7 0/2] Remove EPYC
 mode apicid decode and use generic decode]
Content-Language: en-US
To: Babu Moger <babu.moger@amd.com>, pbonzini@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com, imammedo@redhat.com
Cc: qemu-devel@nongnu.org, mst@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
References: <159897580089.30750.12581669374705391794.stgit@naples-babu.amd.com>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <159897580089.30750.12581669374705391794.stgit@naples-babu.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=cfontana@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi all, partially resurrecting an old thread.

I've seen how for Epyc something special was done in the past in terms of apicid assignments based on topology, which was then reverted apparently,
but I wonder if something more general would be useful to all?

The QEMU apicid assignments first of all do not seem to match what is happening on real hardware.

Functionally things are ok, but then when trying to investigate issues, specifically in the guest kernel KVM PV code (arch/x86/kernel/kvm.c),
in some cases the actual apicid values in relationship to the topology do matter,

and currently there is no way (I know of), of supplying our own apicid assignment, more closely matching what happens on hardware.

This has been an issue when debugging guest images in the cloud, where being able to reproduce issues locally would be very beneficial as opposed to using cloud images as the feedback loop,
but unfortunately QEMU cannot currently create the right apicid values to associate to the cpus.

Do I understand the issue correctly, comments, ideas?
How receptive the project would be for changes aimed at providing a custom assignment of apicids to cpus, regardless of Intel or AMD?

Thanks,

Claudio



On 9/1/20 17:57, Babu Moger wrote:
> To support some of the complex topology, we introduced EPYC mode apicid decode.
> But, EPYC mode decode is running into problems. Also it can become quite a
> maintenance problem in the future. So, it was decided to remove that code and
> use the generic decode which works for majority of the topology. Most of the
> SPECed configuration would work just fine. With some non-SPECed user inputs,
> it will create some sub-optimal configuration.
> 
> Here is the discussion thread.
> https://lore.kernel.org/qemu-devel/c0bcc1a6-1d84-a6e7-e468-d5b437c1b254@amd.com/
> https://lore.kernel.org/qemu-devel/20200826143849.59f6970b@redhat.com/
> 
> This series removes all the EPYC mode specific apicid changes and use the generic
> apicid decode.
> ---
> v7:
>  Eduardo has already queued 1-8 from the v6. Sending rest of the patches.
>  Fixed CPUID 800000ld based on Igor's comment and few text changes.
>  
> v6:
>  https://lore.kernel.org/qemu-devel/159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com/
>  Found out that numa configuration is not mandatory for all the EPYC model topology.
>  We can use the generic decode which works pretty well. Also noticed that
>  cpuid does not changes when the numa nodes change(NPS- Nodes per socket).
>  Took care of couple comments from Igor and Eduardo.
>  Thank you Igor, Daniel, David, Eduardo for your feedback.  
> 
> v5:
>  https://lore.kernel.org/qemu-devel/159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com/
>  Revert EPYC specific decode.
>  Simplify CPUID_8000_001E
> 
> v4:
>   https://lore.kernel.org/qemu-devel/159744083536.39197.13827776633866601278.stgit@naples-babu.amd.com/
>   Not much of a change. Just added few text changes.
>   Error out configuration instead of warning if dies are not configured in EPYC.
>   Few other text changes to clarify the removal of node_id, nr_nodes and nodes_per_pkg.
> 
> v3:
>   https://lore.kernel.org/qemu-devel/159681772267.9679.1334429994189974662.stgit@naples-babu.amd.com/#r
>   Added a new check to pass the dies for EPYC numa configuration.
>   Added Simplify CPUID_8000_001E patch with some changes suggested by Igor.
>   Dropped the patch to build the topology from CpuInstanceProperties.
>   TODO: Not sure if we still need the Autonuma changes Igor mentioned.
>   Needs more clarity on that.
> 
> v2:
>   https://lore.kernel.org/qemu-devel/159362436285.36204.986406297373871949.stgit@naples-babu.amd.com/
>   Used the numa information from CpuInstanceProperties for building
>   the apic_id suggested by Igor.
>   Also did some minor code re-aarangement to take care of changes.
>   Dropped the patch "Simplify CPUID_8000_001E" from v1. Will send
>   it later.
> 
> v1:
>  https://lore.kernel.org/qemu-devel/159164739269.20543.3074052993891532749.stgit@naples-babu.amd.com
> 
> Babu Moger (2):
>       i386: Simplify CPUID_8000_001d for AMD
>       i386: Simplify CPUID_8000_001E for AMD
> 
> 
>  target/i386/cpu.c |  226 ++++++++++++++---------------------------------------
>  1 file changed, 61 insertions(+), 165 deletions(-)
> 
> --
> 


