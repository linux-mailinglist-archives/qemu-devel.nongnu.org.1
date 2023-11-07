Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E28597E434A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 16:19:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0NqN-0000gM-Gr; Tue, 07 Nov 2023 10:18:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1r0NqH-0000g8-Bs; Tue, 07 Nov 2023 10:18:13 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1r0NqB-0003AM-JR; Tue, 07 Nov 2023 10:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699370287; x=1730906287;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=bhQV/5pRCTZQZZcQQuwChWOVGzcMA3bLf6XhA6yP8+c=;
 b=BfYvHv2GdunrYEwGP3AkRqKsGnOPRUqD1GcqbImF/sEKFj26etuHThHx
 5H0LciqgBhuFdp/zG9tyeZ/WQB55BHLnwqrMoClJrK5KnEMgxxMXu4qaR
 HaNm63MHq7rhIwGTojSMJCG2miBrQLAEPXaCTvW/3FwkYYmcLznASZUeR
 pptoAq74u661ZEojQvb4g9m4CTnAwSND0TYc7qY/CSXFiieGkDvyQ6OCJ
 g/6gU3cXhX/nVKYxfMq33tsM7BRq5RaHcb86l6yGCUtcFtzTRGt6a/ib4
 1cfvZVWxnwfNRImW0a07uSGOs+yLs/a/MnwdbtTMgKhMQgH8x9CJUibYB Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="389333981"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; d="scan'208";a="389333981"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2023 07:17:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="3827736"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 07 Nov 2023 07:17:49 -0800
Date: Tue, 7 Nov 2023 23:29:34 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH 4/4] target/s390x/cpu: Restrict CPUS390XState declaration
 to 'cpu.h'
Message-ID: <ZUpX3m/I7uOzMyEE@intel.com>
References: <20231106114500.5269-1-philmd@linaro.org>
 <20231106114500.5269-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231106114500.5269-5-philmd@linaro.org>
Received-SPF: pass client-ip=192.55.52.115; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Nov 06, 2023 at 12:44:59PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon,  6 Nov 2023 12:44:59 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 4/4] target/s390x/cpu: Restrict CPUS390XState declaration
>  to 'cpu.h'
> X-Mailer: git-send-email 2.41.0
> 
> "target/s390x/cpu-qom.h" has to be target-agnostic. However, it
> currently declares CPUS390XState, which is target-specific.
> Move that declaration to "cpu.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/s390x/cpu-qom.h | 2 --
>  target/s390x/cpu.h     | 4 ++--
>  2 files changed, 2 insertions(+), 4 deletions(-)

Sorry be late, as the response for [1],

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

[1]: https://lore.kernel.org/qemu-devel/9b6eb677-1655-e452-2555-01eb01cf9072@linaro.org/

> 
> diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
> index fcd70daddf..ccf126b7a9 100644
> --- a/target/s390x/cpu-qom.h
> +++ b/target/s390x/cpu-qom.h
> @@ -33,8 +33,6 @@ OBJECT_DECLARE_CPU_TYPE(S390CPU, S390CPUClass, S390_CPU)
>  typedef struct S390CPUModel S390CPUModel;
>  typedef struct S390CPUDef S390CPUDef;
>  
> -typedef struct CPUArchState CPUS390XState;
> -
>  typedef enum cpu_reset_type {
>      S390_CPU_RESET_NORMAL,
>      S390_CPU_RESET_INITIAL,
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 110902fa3c..942589c597 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -55,7 +55,7 @@ typedef struct PSW {
>      uint64_t addr;
>  } PSW;
>  
> -struct CPUArchState {
> +typedef struct CPUArchState {
>      uint64_t regs[16];     /* GP registers */
>      /*
>       * The floating point registers are part of the vector registers.
> @@ -157,7 +157,7 @@ struct CPUArchState {
>      /* currently processed sigp order */
>      uint8_t sigp_order;
>  
> -};
> +} CPUS390XState;
>  
>  static inline uint64_t *get_freg(CPUS390XState *cs, int nr)
>  {
> -- 
> 2.41.0
> 




