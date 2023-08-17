Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6352C77FE92
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 21:34:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWikk-0003tq-LW; Thu, 17 Aug 2023 15:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qWikf-0003tR-3b
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 15:33:49 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qWikc-0005Vj-NY
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 15:33:48 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bba48b0bd2so1241775ad.3
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 12:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692300825; x=1692905625;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E++zbqUvCRSLZT+0PLMrw7FmLWtGLTP/2tsc4SkVPxw=;
 b=kA/D+OC+5knB+mm5dNPFFB3911nAN+S/vfh7u5QHXxLbF6aYlE/8gIIEb3I5IbhKU6
 XF6ez7nELG9BfcpSf3eFRPW+O10JqSmBrq1SlWIwrgtXYUku44/NoWuaHTSpBtGPeaBk
 jlOcv9hYitRY116dfLJnk8FRa0h76cJFlEzh42if5hqideCzh+65MTYp3A/a5L9ltmck
 faZpD1EDWV8QCntE5EY3tOqQwCqFnHnoppnz3XS1AGe3nJzalDtoiszC9c+Fx1o+amK+
 rofxoZNJd6QNL8ySFjmTVJUs2cFkJbyartXhpnA9QBfk3MMazItBUH6G8MkK5xa8TH7f
 7OIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692300825; x=1692905625;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E++zbqUvCRSLZT+0PLMrw7FmLWtGLTP/2tsc4SkVPxw=;
 b=aLcOG19Dx2cnKU6JT1BgxdmzTXNfBUVjfcvHQ3hoiQm8nqVkDz1HwjTOcIsIGKz5da
 sc4mXRhPUoWrxjO0Puxp7wLproCpiGlrqnW4HzXWmk9tAX+0i1eWOG8T1VAQ+KojYMI7
 s1JnRx8w7aDvnkOlW2cEWGQ+SO6vk9kXbJJONvY6wfnN3iJuU3hOe7GhbytsJ0YfghRl
 ZceayfWexOeNWH1DqNjzUge0S64tbHhx1hhF5dWkO0uyJuzlNont4uXIhSO+46k5fdxY
 iSkKuwR53UFM8jYh1gZDNvUgrCP5DJvitsBji/md4WOyBhd2jYHCM/WEF5aQgQIzF8GB
 K1/A==
X-Gm-Message-State: AOJu0YyOCVWEpMyd4K9gKJkwmhUXiShdwZawoVSFuqyCVplPTt2lmWVm
 rKbJUKOuFxcDruYkB6IopLU=
X-Google-Smtp-Source: AGHT+IGxnf7ppLqAeqELWY9mX1ukjF/voZ/+xmmNSOV1hO6yNvRuiYEJKYcX44P8vJ8IZE1rHDybPg==
X-Received: by 2002:a17:90b:104b:b0:26b:455b:657e with SMTP id
 gq11-20020a17090b104b00b0026b455b657emr388955pjb.41.1692300825067; 
 Thu, 17 Aug 2023 12:33:45 -0700 (PDT)
Received: from localhost ([192.55.55.51]) by smtp.gmail.com with ESMTPSA id
 7-20020a17090a1a4700b00263f446d432sm2057452pjl.43.2023.08.17.12.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 12:33:44 -0700 (PDT)
Date: Thu, 17 Aug 2023 12:33:43 -0700
From: Isaku Yamahata <isaku.yamahata@gmail.com>
To: Qian Wen <qian.wen@intel.com>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 babu.moger@amd.com, isaku.yamahata@gmail.com
Subject: Re: [PATCH v3 1/2] target/i386: Avoid cpu number overflow in legacy
 topology
Message-ID: <20230817193343.GB3637892@ls.amr.corp.intel.com>
References: <20230816080658.3562730-1-qian.wen@intel.com>
 <20230816080658.3562730-2-qian.wen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816080658.3562730-2-qian.wen@intel.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=isaku.yamahata@gmail.com; helo=mail-pl1-x62c.google.com
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

On Wed, Aug 16, 2023 at 04:06:57PM +0800,
Qian Wen <qian.wen@intel.com> wrote:

> The legacy topology enumerated by CPUID.1.EBX[23:16] is defined in SDM
> Vol2:
> 
> Bits 23-16: Maximum number of addressable IDs for logical processors in
> this physical package.
> 
> When threads_per_socket > 255, it will 1) overwrite bits[31:24] which is
> apic_id, 2) bits [23:16] get truncated.
> 
> Specifically, if launching the VM with -smp 256, the value written to
> EBX[23:16] is 0 because of data overflow. If the guest only supports
> legacy topology, without V2 Extended Topology enumerated by CPUID.0x1f
> or Extended Topology enumerated by CPUID.0x0b to support over 255 CPUs,
> the return of the kernel invoking cpu_smt_allowed() is false and APs
> (application processors) will fail to bring up. Then only CPU 0 is online,
> and others are offline.
> 
> For example, launch VM via:
> qemu-system-x86_64 -M q35,accel=kvm,kernel-irqchip=split \
>     -cpu qemu64,cpuid-0xb=off -smp 256 -m 32G \
>     -drive file=guest.img,if=none,id=virtio-disk0,format=raw \
>     -device virtio-blk-pci,drive=virtio-disk0,bootindex=1 --nographic
> 
> The guest shows:
>     CPU(s):               256
>     On-line CPU(s) list:  0
>     Off-line CPU(s) list: 1-255
> 
> To avoid this issue caused by overflow, limit the max value written to
> EBX[23:16] to 255 as the HW does.
> 
> Signed-off-by: Qian Wen <qian.wen@intel.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  target/i386/cpu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 97ad229d8b..5c008b9d7e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6008,6 +6008,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>      uint32_t die_offset;
>      uint32_t limit;
>      uint32_t signature[3];
> +    uint32_t threads_per_socket;
>      X86CPUTopoInfo topo_info;
>  
>      topo_info.dies_per_pkg = env->nr_dies;
> @@ -6049,8 +6050,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              *ecx |= CPUID_EXT_OSXSAVE;
>          }
>          *edx = env->features[FEAT_1_EDX];
> -        if (cs->nr_cores * cs->nr_threads > 1) {
> -            *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
> +        threads_per_socket = cs->nr_cores * cs->nr_threads;
> +        if (threads_per_socket > 1) {
> +            *ebx |= MIN(threads_per_socket, 255) << 16;
>              *edx |= CPUID_HT;
>          }
>          if (!cpu->enable_pmu) {
> -- 
> 2.25.1
> 
> 

Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>

