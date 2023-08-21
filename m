Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8146E7835D3
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 00:32:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYDQ7-0006Tw-R5; Mon, 21 Aug 2023 18:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qYDQ4-0006Rn-T0
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 18:30:44 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qYDQ2-00011i-Bx
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 18:30:44 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bda9207132so30142385ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 15:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692657040; x=1693261840;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nNPzaFzeYLsSfgRlWm4jcR7ku+ZIkaKbn5zIZ6TjKtY=;
 b=pzvPd8tmhLGnA1NIqaWnNAu7ROyL7dNs/agavNLrdKuHf2F54+ZiBCdeys0WG3DlBf
 el9IGjmbNeiL/HCaKLSZ1g6wruUAlE/CqYyg+nCwRuN1lPOWn3M6KbDU34Yuq8XyQHv0
 VQdCHtiZqTJ+ieR9ls9FQeklmE/NswJ1gFxsFM1mnlxcB0gcHO+uy/XskHSNPin6G0uI
 vdPNmvXwRYgMBPgR+3Lrhj2ZCOBgvBqToMsdenqQBzEMwz0rVsR/EuCFjaSBbHbQk6mI
 /155oVL8bhN6ztVI2Sg2HpSPXjbQeD7v2oSWuWJqNi7M7DijUPzixEiGRD7p2Ngv/k/8
 AbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692657040; x=1693261840;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nNPzaFzeYLsSfgRlWm4jcR7ku+ZIkaKbn5zIZ6TjKtY=;
 b=bOHO3SLlMYlbqfWBKMeJlYL7QnUWJYd03m3pX8r6/I7ASkODtKCN+X90KnsyPPehz/
 UjAFQXBZSQeb3sNg0/Hd45mSw/10Hfzxa8IfRnfFMxj+5vPvbCchnXvbx9XyYSJXaKBg
 bhxq7AVNfea569h0Pup/CVi1/2Idq8SGnnzxLQTBjZ2W99Bf0pQfTWvGBJM8rbL0bV7L
 bNkd6MbzkCTp+H7qqPnz6qMqHKm/xKG3I/RISIraTgxavgg+mf3YDpvtW5aY3cJ+a+yq
 KCFWlpyyknYoTCUO+s09e8Ww/wX7K6W3QfBgz7MeuDvF88r9F3LxkCAI1HfWlDJKXCrc
 XuGQ==
X-Gm-Message-State: AOJu0YztTlDtpswALBuWLq15WAIJIfRiYZi4MJRiAEhl4IZGU6/BTi1t
 hH6FOGdfFSaulV7DWT325FA=
X-Google-Smtp-Source: AGHT+IGzfcemV/qSVwWRmG53F6Lzz+WBODZzzn6pWTlhZnymN0nr+ZQgh107vhpIB+nAnO1Z4Yn8Vg==
X-Received: by 2002:a17:902:7684:b0:1bc:e6a:205a with SMTP id
 m4-20020a170902768400b001bc0e6a205amr7188735pll.4.1692657040230; 
 Mon, 21 Aug 2023 15:30:40 -0700 (PDT)
Received: from localhost ([192.55.55.51]) by smtp.gmail.com with ESMTPSA id
 r21-20020a170902be1500b001bbbc655ca1sm7544906pls.219.2023.08.21.15.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 15:30:39 -0700 (PDT)
Date: Mon, 21 Aug 2023 15:30:38 -0700
From: Isaku Yamahata <isaku.yamahata@gmail.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Eduardo Habkost <eduardo@habkost.net>,
 Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v2 45/58] i386/tdx: Limit the range size for MapGPA
Message-ID: <20230821223038.GA3642077@ls.amr.corp.intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-46-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818095041.1973309-46-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=isaku.yamahata@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 18, 2023 at 05:50:28AM -0400,
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> If the range for TDG.VP.VMCALL<MapGPA> is too large, process the limited
> size and return retry error.  It's bad for VMM to take too long time,
> e.g. second order, with blocking vcpu execution.  It results in too many
> missing timer interrupts.

This patch requires the guest side patch. [1]
Unless with large guest memory, it's unlikely to hit the limit with KVM/qemu,
though.

[1] https://lore.kernel.org/all/20230811021246.821-1-decui@microsoft.com/

> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/kvm/tdx.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 0c43c1f7759f..ced55be506d1 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -994,12 +994,16 @@ static hwaddr tdx_shared_bit(X86CPU *cpu)
>      return (cpu->phys_bits > 48) ? BIT_ULL(51) : BIT_ULL(47);
>  }
>  
> +/* 64MB at most in one call. What value is appropriate? */
> +#define TDX_MAP_GPA_MAX_LEN     (64 * 1024 * 1024)
> +
>  static void tdx_handle_map_gpa(X86CPU *cpu, struct kvm_tdx_vmcall *vmcall)
>  {
>      hwaddr shared_bit = tdx_shared_bit(cpu);
>      hwaddr gpa = vmcall->in_r12 & ~shared_bit;
>      bool private = !(vmcall->in_r12 & shared_bit);
>      hwaddr size = vmcall->in_r13;
> +    bool retry = false;
>      int ret = 0;
>  
>      vmcall->status_code = TDG_VP_VMCALL_INVALID_OPERAND;
> @@ -1018,12 +1022,25 @@ static void tdx_handle_map_gpa(X86CPU *cpu, struct kvm_tdx_vmcall *vmcall)
>          return;
>      }
>  
> +    if (size > TDX_MAP_GPA_MAX_LEN) {
> +        retry = true;
> +        size = TDX_MAP_GPA_MAX_LEN;
> +    }
> +
>      if (size > 0) {
>          ret = kvm_convert_memory(gpa, size, private);
>      }
>  
>      if (!ret) {
> -        vmcall->status_code = TDG_VP_VMCALL_SUCCESS;
> +        if (retry) {
> +            vmcall->status_code = TDG_VP_VMCALL_RETRY;
> +            vmcall->out_r11 = gpa + size;
> +            if (!private) {
> +                vmcall->out_r11 |= shared_bit;
> +            }
> +        } else {
> +            vmcall->status_code = TDG_VP_VMCALL_SUCCESS;
> +        }
>      }
>  }
>  
> -- 
> 2.34.1
> 
> 

-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>

