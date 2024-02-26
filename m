Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66119867584
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Feb 2024 13:47:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reaNA-0001vZ-42; Mon, 26 Feb 2024 07:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reaMz-0001sh-RA
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 07:46:09 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reaMx-000294-SP
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 07:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708951568; x=1740487568;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=1n9Gx8mBT4NzaqxK8Nl9wpoyjAT6B0cx8aQmqjCBAfc=;
 b=Hl+UXFbZ30Iys7Yzyu3HyYYMrVNQd3EPt7s9OQBKyQpW9LpfvcpEu8RJ
 8Z4Lf0v0b1IJTI/4i38EDOAibQv6WdQZd0SH5mxpzpa+1rMNLlv867jYs
 xKQ7aQvYuD7JGxALLL92d67RAQ/+IwCJ3dugl7DRuuYvV1nFOAeJ62Qk0
 ey7hbDjuXTS4EOzlRJVnktBWQ0IwayZInt3JWm8LoAyiOacjmEzSxmhC7
 CcGmfemaOP/xdvgYgQlogsjSYDaHkxxlXSuZbwF0MydVlcKgvp5smBf1l
 TdkE+P0K4fbpl+liP9MAvoXuZkzCF4WzN/k4IQEIOK+1SpRkwXccYHgKt A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="20777361"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="20777361"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 04:46:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="44133873"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 26 Feb 2024 04:46:03 -0800
Date: Mon, 26 Feb 2024 20:59:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, mcb30@ipxe.org
Subject: Re: [PATCH v2 4/7] target/i386: use separate MMU indexes for 32-bit
 accesses
Message-ID: <ZdyLQcDGryczl/7V@intel.com>
References: <20240223130948.237186-1-pbonzini@redhat.com>
 <20240223130948.237186-5-pbonzini@redhat.com>
 <ZdxNkStjZyB6iJtk@intel.com>
 <CABgObfYz0MitUFmLkm3YncpmLFpQ=YOspr=KrYYWn7cFiuouKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfYz0MitUFmLkm3YncpmLFpQ=YOspr=KrYYWn7cFiuouKw@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Paolo,

On Mon, Feb 26, 2024 at 10:55:14AM +0100, Paolo Bonzini wrote:
> Date: Mon, 26 Feb 2024 10:55:14 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH v2 4/7] target/i386: use separate MMU indexes for
>  32-bit accesses
> 
> On Mon, Feb 26, 2024 at 9:22 AM Zhao Liu <zhao1.liu@intel.com> wrote:
> > On Fri, Feb 23, 2024 at 02:09:45PM +0100, Paolo Bonzini wrote:
> > > Accesses from a 32-bit environment (32-bit code segment for instruction
> > > accesses, EFER.LMA==0 for processor accesses) have to mask away the
> > > upper 32 bits of the address.  While a bit wasteful, the easiest way
> > > to do so is to use separate MMU indexes.  These days, QEMU anyway is
> > > compiled with a fixed value for NB_MMU_MODES.  Split MMU_USER_IDX,
> > > MMU_KSMAP_IDX and MMU_KNOSMAP_IDX in two.
> >
> > Maybe s/in/into/ ?
> 
> Both are acceptable grammar.
> 
> > >  static inline int cpu_mmu_index_kernel(CPUX86State *env)
> > >  {
> > > -    return !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP_IDX :
> > > -        ((env->hflags & HF_CPL_MASK) < 3 && (env->eflags & AC_MASK))
> > > -        ? MMU_KNOSMAP_IDX : MMU_KSMAP_IDX;
> > > +    int mmu_index_32 = (env->hflags & HF_LMA_MASK) ? 1 : 0;
> > > +    int mmu_index_base =
> > > +        !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
> > > +        ((env->hflags & HF_CPL_MASK) < 3 && (env->eflags & AC_MASK)) ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX;
> 
> > Change the line?
> 
> It's reformatted but the logic is the same.
> 
> - if !SMAP -> MMU_KNOSMAP_IDX
> 
> - if CPL < 3 && EFLAGS.AC - MMU_KNOSMAP_IDX
> 
> - else MMU_KSMAP_IDX
> 
> The only change is adding the "64" suffix, which is then changed to
> 32-bit if needed via mmu_index_32.
> 

Thanks for the explanation, I get your point.
Similarly, I also understand your change in x86_cpu_mmu_index().

LGTM, please allow me to add my review tag:

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


