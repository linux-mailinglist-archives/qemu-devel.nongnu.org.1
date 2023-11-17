Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C047EFA35
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 22:20:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r46GS-0005A7-B7; Fri, 17 Nov 2023 16:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1r46GO-00059F-S5
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 16:20:32 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1r46GM-0004rL-VU
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 16:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700256030; x=1731792030;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=n2y1j5HibPwd3gevMA9Pbsa8cS7PY+LR97YvXnnB6FE=;
 b=kTLNTV4hwaiJuXoI/Xg/jGZnTzRnV5isRC0aaW4ANwDAWY1vZPDlRX9V
 Xwy8vwxHX4Jo802gnuLLjclPWHLvHvbWibtcAKADQxuVJujDyd2ybyKhO
 xeIE685Omf4ORBsA0BVf+mF1j4GyfsS9fyEC7af5ynvKllcT4dDD1M7Gv
 /HJD+v1q2iYN16Uu5bZXSoyz2j/KKB9GbHtJQiswYMif/o8Qt/aV4I1gs
 5pv02gOuJaWIH/SNSLXc3tvzQ9gapwt8bMTsPPiJ1EoGwuQXWTPZHGQ2b
 PddO+cK03Vnvw7GL/4V2aOfWqAeD7jJhQgUg274iMiOV0yZjGUAi78AI2 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="391153678"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; d="scan'208";a="391153678"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2023 13:20:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="1013043694"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; d="scan'208";a="1013043694"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2023 13:20:28 -0800
Date: Fri, 17 Nov 2023 13:20:28 -0800
From: Isaku Yamahata <isaku.yamahata@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 isaku.yamahata@linux.intel.com, isaku.yamahata@intel.com
Subject: Re: [PATCH v3 19/70] i386/tdx: Introduce is_tdx_vm() helper and
 cache tdx_guest object
Message-ID: <20231117212028.GB1648821@ls.amr.corp.intel.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-20-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231115071519.2864957-20-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.55.52.115;
 envelope-from=isaku.yamahata@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

On Wed, Nov 15, 2023 at 02:14:28AM -0500,
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> It will need special handling for TDX VMs all around the QEMU.
> Introduce is_tdx_vm() helper to query if it's a TDX VM.
> 
> Cache tdx_guest object thus no need to cast from ms->cgs every time.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> changes in v3:
> - replace object_dynamic_cast with TDX_GUEST();
> ---
>  target/i386/kvm/tdx.c | 15 ++++++++++++++-
>  target/i386/kvm/tdx.h | 10 ++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index cb0040187b27..cf8889f0a8f9 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -21,8 +21,16 @@
>  #include "kvm_i386.h"
>  #include "tdx.h"
>  
> +static TdxGuest *tdx_guest;
> +
>  static struct kvm_tdx_capabilities *tdx_caps;
>  
> +/* It's valid after kvm_confidential_guest_init()->kvm_tdx_init() */
> +bool is_tdx_vm(void)
> +{
> +    return !!tdx_guest;
> +}
> +
>  enum tdx_ioctl_level{
>      TDX_PLATFORM_IOCTL,
>      TDX_VM_IOCTL,
> @@ -114,15 +122,20 @@ static int get_tdx_capabilities(Error **errp)
>  
>  int tdx_kvm_init(MachineState *ms, Error **errp)
>  {
> +    TdxGuest *tdx = TDX_GUEST(OBJECT(ms->cgs));
>      int r = 0;
>  
>      ms->require_guest_memfd = true;
>  
>      if (!tdx_caps) {
>          r = get_tdx_capabilities(errp);
> +        if (r) {
> +            return r;
> +        }
>      }
>  
> -    return r;
> +    tdx_guest = tdx;
> +    return 0;
>  }
>  
>  /* tdx guest */
> diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
> index c8a23d95258d..4036ca2f3f99 100644
> --- a/target/i386/kvm/tdx.h
> +++ b/target/i386/kvm/tdx.h
> @@ -1,6 +1,10 @@
>  #ifndef QEMU_I386_TDX_H
>  #define QEMU_I386_TDX_H
>  
> +#ifndef CONFIG_USER_ONLY
> +#include CONFIG_DEVICES /* CONFIG_TDX */
> +#endif
> +
>  #include "exec/confidential-guest-support.h"
>  
>  #define TYPE_TDX_GUEST "tdx-guest"
> @@ -16,6 +20,12 @@ typedef struct TdxGuest {
>      uint64_t attributes;    /* TD attributes */
>  } TdxGuest;
>  
> +#ifdef CONFIG_TDX
> +bool is_tdx_vm(void);
> +#else
> +#define is_tdx_vm() 0
> +#endif /* CONFIG_TDX */
> +
>  int tdx_kvm_init(MachineState *ms, Error **errp);
>  
>  #endif /* QEMU_I386_TDX_H */
> -- 
> 2.34.1
> 
> 

Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>

