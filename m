Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F2C7D1213
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:01:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtqzA-0005p0-Hs; Fri, 20 Oct 2023 11:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1qtqz5-0005oc-QG
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:00:20 -0400
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1qtqz3-0000Dk-3B
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697814017; x=1729350017;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=13/qGEdX548tUAlhnH19WXaxrurKdThSnzOP3rMgSGQ=;
 b=IuvWYLXMcDyQdxynAI0Ld+SX18Gt+4AAQCgvk6c4ypEoMwZewWsF+28z
 3JhwHRLpsx9+8cXLPEw0m0WPO/qMZKv+BEKDSuQVJiOEQerwdyq9tVByt
 19rTZJNAl29BN/5n5kBWS6PMgMDLu8p3iRvUVKGkYpSM6S3SNZePEpziC
 TzcdItRQp+vXYf313NMot1UIsCqyKljXZK6OMtzS9e1+4cTXgixU8r3Wy
 YJdfoZ42/QYUios1en67CazmXma3q4P5EyW2KwcQGuNrYRp8mdJt8B6eH
 fQ0zmtjUmFuw82UnElb5KY0YfollxOpMhOfqom0IMOBWBq4DwhEY6pIat Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="376890718"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; d="scan'208";a="376890718"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2023 08:00:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="707249788"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; d="scan'208";a="707249788"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga003.jf.intel.com with ESMTP; 20 Oct 2023 08:00:13 -0700
Date: Fri, 20 Oct 2023 23:11:50 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: Re: [PATCH 1/3] target/i386/hvf: Use CPUState typedef
Message-ID: <ZTKYttFo4EHBfkTl@intel.com>
References: <20231020111136.44401-1-philmd@linaro.org>
 <20231020111136.44401-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020111136.44401-2-philmd@linaro.org>
Received-SPF: pass client-ip=134.134.136.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 20, 2023 at 01:11:34PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Fri, 20 Oct 2023 13:11:34 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 1/3] target/i386/hvf: Use CPUState typedef
> X-Mailer: git-send-email 2.41.0
> 
> Follow C style guidelines and use CPUState forward
> declaration from "qemu/typedefs.h".
> 
> No functional changes.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/hvf/x86_emu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
> index b1f8a685d1..cd7ef30126 100644
> --- a/target/i386/hvf/x86_emu.c
> +++ b/target/i386/hvf/x86_emu.c
> @@ -45,7 +45,7 @@
>  #include "vmcs.h"
>  #include "vmx.h"
>  
> -void hvf_handle_io(struct CPUState *cpu, uint16_t port, void *data,
> +void hvf_handle_io(CPUState *cpu, uint16_t port, void *data,
>                     int direction, int size, uint32_t count);
>  
>  #define EXEC_2OP_FLAGS_CMD(env, decode, cmd, FLAGS_FUNC, save_res) \
> @@ -1417,7 +1417,7 @@ static void init_cmd_handler()
>      }
>  }
>  
> -void load_regs(struct CPUState *cpu)
> +void load_regs(CPUState *cpu)
>  {
>      X86CPU *x86_cpu = X86_CPU(cpu);
>      CPUX86State *env = &x86_cpu->env;
> @@ -1440,7 +1440,7 @@ void load_regs(struct CPUState *cpu)
>      env->eip = rreg(cpu->accel->fd, HV_X86_RIP);
>  }
>  
> -void store_regs(struct CPUState *cpu)
> +void store_regs(CPUState *cpu)
>  {
>      X86CPU *x86_cpu = X86_CPU(cpu);
>      CPUX86State *env = &x86_cpu->env;
> -- 
> 2.41.0
> 

