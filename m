Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B118C8D70CC
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jun 2024 17:13:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDQOb-00024x-UE; Sat, 01 Jun 2024 11:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sDQOU-00023q-Tz; Sat, 01 Jun 2024 11:11:42 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sDQOS-0003LH-89; Sat, 01 Jun 2024 11:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717254700; x=1748790700;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=iqxY4OA9pDpwm3vLPpCWLZjHd2gPOinMkapeVP844vw=;
 b=mhH60uBvVPBFNbBmXtKyHp/mxToxHfhPWRJLIUENn/juC4K66AW6556L
 AVZKet7f6Ig9Pd51yFg9mLR1QTUEduUCbxcuSqIkR1UDu+l7oAQV/A8Bb
 +XiXzi0Jq4Fry4Z1YC484nNo5/rwH5/fPiq44HI018DAYa13WGiFNH91E
 P9uP1KTlvu/QFg4nGbQf5kv5YiSpzmDwLqb8rtoT89KYxJTcPNPIf01ax
 i7a00LhGtbOSNE2jV5r/YhLI1dZJlJf4sz+lI3+rDgddlNl9B0OPyvJ5W
 pa41bHl03O5563G18Ft1frcRbBddeJU1ljKq3HYEXkcbqadcLYlAAL5Y8 A==;
X-CSE-ConnectionGUID: RTLKeMpCSnGbnzPgFMd/Jg==
X-CSE-MsgGUID: fEkPzcR8RYKjn2bTjTHZpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="39196306"
X-IronPort-AV: E=Sophos;i="6.08,207,1712646000"; d="scan'208";a="39196306"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2024 08:11:32 -0700
X-CSE-ConnectionGUID: CmcTnsCPRKaYFx4ykXE49A==
X-CSE-MsgGUID: vhHJoFX2QPuAf7Gy4YnoSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,207,1712646000"; d="scan'208";a="40881543"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 01 Jun 2024 08:11:30 -0700
Date: Sat, 1 Jun 2024 23:26:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Chen, Zide" <zide.chen@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 thuth@redhat.com, cfontana@suse.de, xiaoyao.li@intel.com,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH V2 2/3] target/i386: call cpu_exec_realizefn before
 x86_cpu_filter_features
Message-ID: <Zls9v9mg17SXZhO7@intel.com>
References: <20240524200017.150339-1-zide.chen@intel.com>
 <20240524200017.150339-3-zide.chen@intel.com>
 <ZlluoKXUF6ctecVt@intel.com>
 <04d3dfd8-93d2-493d-82d1-8fbcad6ecd22@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04d3dfd8-93d2-493d-82d1-8fbcad6ecd22@intel.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.041,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, May 31, 2024 at 10:13:47AM -0700, Chen, Zide wrote:
> Date: Fri, 31 May 2024 10:13:47 -0700
> From: "Chen, Zide" <zide.chen@intel.com>
> Subject: Re: [PATCH V2 2/3] target/i386: call cpu_exec_realizefn before
>  x86_cpu_filter_features
> 
> On 5/30/2024 11:30 PM, Zhao Liu wrote:
> > Hi Zide,
> > 
> > On Fri, May 24, 2024 at 01:00:16PM -0700, Zide Chen wrote:
> >> Date: Fri, 24 May 2024 13:00:16 -0700
> >> From: Zide Chen <zide.chen@intel.com>
> >> Subject: [PATCH V2 2/3] target/i386: call cpu_exec_realizefn before
> >>  x86_cpu_filter_features
> >> X-Mailer: git-send-email 2.34.1
> >>
> >> cpu_exec_realizefn which calls the accel-specific realizefn may expand
> >> features.  e.g., some accel-specific options may require extra features
> >> to be enabled, and it's appropriate to expand these features in accel-
> >> specific realizefn.
> >>
> >> One such example is the cpu-pm option, which may add CPUID_EXT_MONITOR.
> >>
> >> Thus, call cpu_exec_realizefn before x86_cpu_filter_features to ensure
> >> that it won't expose features not supported by the host.
> >>
> >> Fixes: 662175b91ff2 ("i386: reorder call to cpu_exec_realizefn")
> >> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> >> Signed-off-by: Zide Chen <zide.chen@intel.com>
> >> ---
> >>  target/i386/cpu.c         | 24 ++++++++++++------------
> >>  target/i386/kvm/kvm-cpu.c |  1 -
> >>  2 files changed, 12 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >> index bc2dceb647fa..a1c1c785bd2f 100644
> >> --- a/target/i386/cpu.c
> >> +++ b/target/i386/cpu.c
> >> @@ -7604,6 +7604,18 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
> >>          }
> >>      }
> >>  
> >> +    /*
> >> +     * note: the call to the framework needs to happen after feature expansion,
> >> +     * but before the checks/modifications to ucode_rev, mwait, phys_bits.
> >> +     * These may be set by the accel-specific code,
> >> +     * and the results are subsequently checked / assumed in this function.
> >> +     */
> >> +    cpu_exec_realizefn(cs, &local_err);
> >> +    if (local_err != NULL) {
> >> +        error_propagate(errp, local_err);
> >> +        return;
> >> +    }
> >> +
> >>      x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid);
> > 
> > For your case, which sets cpu-pm=on via overcommit, then
> > x86_cpu_filter_features() will complain that mwait is not supported.
> > 
> > Such warning is not necessary, because the purpose of overcommit (from
> > code) is only to support mwait when possible, not to commit to support
> > mwait in Guest.
> > 
> > Additionally, I understand x86_cpu_filter_features() is primarily
> > intended to filter features configured by the user, 
> 
> Yes, that's why this patches intends to let x86_cpu_filter_features()
> filter out the MWAIT bit which is set from the overcommit option.

HMM, but in fact x86_cpu_filter_features() has already checked the MWAIT
bit set by "-overcommit cpu-pm=on". ;-)

(Pls correct me if I'm wrong) Revisiting what cpu-pm did to MWAIT:
* Firstly, it set MWAIT bit in x86_cpu_expand_features():
  x86_cpu_expand_features()
     -> x86_cpu_get_supported_feature_word()
        -> kvm_arch_get_supported_cpuid()
 This MWAIT is based on Host's MWAIT capability. This MWAIT enablement
 is fine for next x86_cpu_filter_features() and x86_cpu_filter_features()
 is working correctly here!

* Then, MWAIT was secondly set in host_cpu_enable_cpu_pm() regardless
  neither Host's support or previous MWAIT enablement result. This is
  the root cause of your issue.

Therefore, we should make cpu-pm honor his first MWAIT enablement result
instead of repeatly and unconditionally setting the MWAIT bit again in
host_cpu_enable_cpu_pm().

Additionally, I think the code in x86_cpu_realizefn():
  cpu->mwait.ecx |= CPUID_MWAIT_EMX | CPUID_MWAIT_IBE;
has the similar issue because it also should check MWAIT feature bit.

Further, it may be possible to remove cpu->mwait: just check the MWAIT
bit in leaf 5 of cpu_x86_cpuid(), and if MWAIT is present, use host's
mwait info plus CPUID_MWAIT_EMX | CPUID_MWAIT_IBE.

> > and the changes of
> > CPUID after x86_cpu_filter_features() should by default be regarded like
> > "QEMU knows what it is doing".
> 
> Sure, we can add feature bits after x86_cpu_filter_features(), but I
> think moving cpu_exec_realizefn() before x86_cpu_filter_features() is
> more generic, and actually this is what QEMU did before commit 662175b91ff2.
> 
> - Less redundant code. Specifically, no need to call
> x86_cpu_get_supported_feature_word() again.
> - Potentially there could be other features could be added from the
> accel-specific realizefn, kvm_cpu_realizefn() for example.  And these
> features need to be checked against the host availability.

Mainly I don't think this reorder is a direct fix for the problem (I
just analyse it above), also in your case x86_cpu_filter_features() will
print a WARNING when QEMU boots, which I don't think is cpu-pm's intention.



