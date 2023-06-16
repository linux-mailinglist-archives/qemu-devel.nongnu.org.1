Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 263F7732631
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 06:26:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA10v-0004Fu-1h; Fri, 16 Jun 2023 00:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qA10s-0004Fd-Im
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 00:24:42 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qA10q-0001ZC-6S
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 00:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686889480; x=1718425480;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=BlwPbxzdb0rWyV6pQuQLJo/dAjMFtKrPh8tzncXl64o=;
 b=mnDfO8PW1tjhc/Cm/wMpNdTesCt8HkQigLpg2QrBVU+eK7ZuJXHVB21I
 B6sxjcoWqeMaXLQUft0b5Dr4z84IdfkwW/DRkQicKmvgP61aLUbsCOLKT
 hDZ5T/WEffkwBihDK8nBajUSp7HfaVKbIUUGM6uPIQez199NKKbEMzJfP
 gmtXKOxTvchwhbvlDe64G37nPZXVXetMYRz8dBFdw7dlUGxjtBqnH2tuP
 27ODFRoljLXRU+JX0ll7zi5zs4JX+y4quXqj0AgDfhZgxRJo8+X/Yk3QA
 dHJN7qMDTMpQngayfgVtIIczjn+LD/fSLXlOhhEbrUWXw9Zyymo37spoB Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425047646"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; d="scan'208";a="425047646"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2023 21:24:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="886939576"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; d="scan'208";a="886939576"
Received: from linux.bj.intel.com ([10.238.156.127])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2023 21:24:32 -0700
Date: Fri, 16 Jun 2023 12:22:44 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: "Wang, Lei" <lei4.wang@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xiaoyao.li@intel.com,
 qian.wen@intel.com, imammedo@redhat.com
Subject: Re: [PATCH 0/7] Add new CPU model EmeraldRapids and GraniteRapids
Message-ID: <ZIvjlFC4OtqRxeYS@linux.bj.intel.com>
References: <20230616032311.19137-1-tao1.su@linux.intel.com>
 <728037d4-9f36-5bf2-5e2e-4f6ca76b79cd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <728037d4-9f36-5bf2-5e2e-4f6ca76b79cd@intel.com>
Received-SPF: none client-ip=134.134.136.100;
 envelope-from=tao1.su@linux.intel.com; helo=mga07.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Fri, Jun 16, 2023 at 12:01:52PM +0800, Wang, Lei wrote:
> On 6/16/2023 11:23, Tao Su wrote:
> > This patch series mainly updates SapphireRapids CPU model and adds
> > new CPU model EmeraldRapids and GraniteRapids.
> > 
> > Bit 13 (ARCH_CAP_FBSDP_NO), bit 14 (ARCH_CAP_FBSDP_NO) and bit 15
> 
> Bit 13 should be MSR_ARCH_CAP_SBDR_SSDP_NO, right?

Yes, copied by mistake, thanks!

Tao

> 
> > (ARCH_CAP_PSDP_NO) of MSR_IA32_ARCH_CAPABILITIES are enumerated starting
> > from latest SapphireRapids, which are missed in current SapphireRapids
> > CPU model, so add a new version for SapphireRapids CPU model to expose
> > these bits.
> > 
> > Add EmeraldRapids CPU model to this series, since EmeraldRapids also
> > enumerates these bits. The original patch of EmeraldRapids CPU model is
> > in [1].
> > 
> > GraniteRapids is Intel's successor to EmeraldRapids, an Intel 3 process
> > microarchitecture for enthusiasts and servers, which adds new features
> > based on SapphireRapids and EmeraldRapids.
> > 
> > [1]
> > https://lore.kernel.org/qemu-devel/20230515025308.1050277-1-qian.wen@intel.com/
> > 
> > Lei Wang (1):
> >   target/i386: Add few security fix bits in ARCH_CAPABILITIES into
> >     SapphireRapids CPU model
> > 
> > Qian Wen (1):
> >   target/i386: Add new CPU model EmeraldRapids
> > 
> > Tao Su (5):
> >   target/i386: Add FEAT_7_1_EDX to adjust feature level
> >   target/i386: Add support for MCDT_NO in CPUID enumeration
> >   target/i386: Allow MCDT_NO if host supports
> >   target/i386: Add new bit definitions of MSR_IA32_ARCH_CAPABILITIES
> >   target/i386: Add new CPU model GraniteRapids
> > 
> >  target/i386/cpu.c     | 303 +++++++++++++++++++++++++++++++++++++++++-
> >  target/i386/cpu.h     |   8 ++
> >  target/i386/kvm/kvm.c |   5 +
> >  3 files changed, 314 insertions(+), 2 deletions(-)
> > 
> > 
> > base-commit: 7efd65423ab22e6f5890ca08ae40c84d6660242f

