Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6C678EC0F
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 13:31:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfsN-0006ej-Lb; Thu, 31 Aug 2023 07:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbfsM-0006eP-AA
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 07:30:14 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbfsJ-00072i-7n
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 07:30:14 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5009d4a4897so1435324e87.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 04:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693481409; x=1694086209; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CmZrowIxwXiD7DoIL1Ho8chJKC8zjuG/WJARq3zbTas=;
 b=oQMx5eQ97tbqIDtxeowFPMCUfAxWxCA9EjOkvMNm6GlrhBAccrjXKU9YM4ERxlEJSd
 QdbM2oIbt5+j5ZoWChmFNMFOkIEEw0f4HOL/qNV5rklOkoXPILopNwmJOZgESA+A/0eg
 lFO5tQ5ktn339T8trh9RcmwG6kI8wFMxx6HQwprfTqnT7/T0re4rEP/y6HWZoM2eMqtv
 6cGOzhdKsQGFyfgFTSGe+WCFJdD0fH0lwwuE3gH7UnSgK8MmAseX+5d1L6ikVHWZORMJ
 MKJVHXMA/aBn5Z7IpfjprGUEf3D2911PYmHhtGGZHy4ZHn+KdR3pqGfM3zEHQkTD424y
 yU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693481409; x=1694086209;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CmZrowIxwXiD7DoIL1Ho8chJKC8zjuG/WJARq3zbTas=;
 b=d6ITNE6ieyRGnp3jzL88sQb+mWsedcDGo1QOYW+S+WwQblLOH4krog3FDkf9k942+G
 EUcAro8pPv9A9H6WKWaGTLBSF+sVkf0VV8ILJtaFnSgIjLx1JxL+lbzw7hkasd/n8Wn6
 tFpz9EYCbTA3Z6YkschFyh3dt+stt7xp4PXbnbISEYNW0T2KWlH/CiMitmgnnoxT5jn5
 vpezzzj/8X3JQ621vRB2oazsWUrD1jA8MFNAgKVrDx3uROQUyETgMtf7yQOE40TJYr2y
 5+VLNY2KmMI3oonf/l0BIllqJiVI8iMpeaElAKn3Xcbli0rrs6N7c8G/vKHzjBMh7byH
 5Qng==
X-Gm-Message-State: AOJu0Yz1PYFHaPzCNL4XEOsGsC1SqMLnPvCIE1YzDKVeKx7iRUnG31Ap
 66mHUJQMQCXQ79CSIAJW8PaN2Q==
X-Google-Smtp-Source: AGHT+IGrIca6MJ/BrXnpuSHthz9hj5/QHcLkCWXRPLrfBBq9EmUtKIXos4zWKITQogblHGONeUXgWA==
X-Received: by 2002:a05:6512:220f:b0:4fb:9fa7:dcda with SMTP id
 h15-20020a056512220f00b004fb9fa7dcdamr4263408lfu.26.1693481409338; 
 Thu, 31 Aug 2023 04:30:09 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 x2-20020aa7dac2000000b005272523b162sm674589eds.69.2023.08.31.04.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 04:30:08 -0700 (PDT)
Date: Thu, 31 Aug 2023 13:30:08 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 12/20] target/riscv: move KVM only files to kvm subdir
Message-ID: <20230831-032c04ea20e3338ff9170980@orel>
References: <20230825130853.511782-1-dbarboza@ventanamicro.com>
 <20230825130853.511782-13-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825130853.511782-13-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=ajones@ventanamicro.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Aug 25, 2023 at 10:08:45AM -0300, Daniel Henrique Barboza wrote:
> Move the files to a 'kvm' dir to promote more code separation between
> accelerators and making our lives easier supporting build options such
> as --disable-tcg.
> 
> Rename kvm.c to kvm-cpu.c to keep it in line with its TCG counterpart.

Now that we have 'kvm' and 'tcg' subdirectories, it seems like we should
be removing prefixes from files, i.e. 'kvm/cpu.c' and 'tcg/cpu.c' would be
less verbose and just as easy to identify, but whatever people like...

> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/riscv/virt.c                       | 2 +-
>  target/riscv/cpu.c                    | 2 +-
>  target/riscv/{kvm.c => kvm/kvm-cpu.c} | 0
>  target/riscv/{ => kvm}/kvm-stub.c     | 0
>  target/riscv/{ => kvm}/kvm_riscv.h    | 0
>  target/riscv/kvm/meson.build          | 2 ++
>  target/riscv/meson.build              | 2 +-
>  7 files changed, 5 insertions(+), 3 deletions(-)
>  rename target/riscv/{kvm.c => kvm/kvm-cpu.c} (100%)
>  rename target/riscv/{ => kvm}/kvm-stub.c (100%)
>  rename target/riscv/{ => kvm}/kvm_riscv.h (100%)
>  create mode 100644 target/riscv/kvm/meson.build
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 388e52a294..77c384ddc3 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -35,7 +35,7 @@
>  #include "hw/riscv/virt.h"
>  #include "hw/riscv/boot.h"
>  #include "hw/riscv/numa.h"
> -#include "kvm_riscv.h"
> +#include "kvm/kvm_riscv.h"
>  #include "hw/intc/riscv_aclint.h"
>  #include "hw/intc/riscv_aplic.h"
>  #include "hw/intc/riscv_imsic.h"
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 04c6bfaeef..bf6c8519b1 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -33,7 +33,7 @@
>  #include "fpu/softfloat-helpers.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/tcg.h"
> -#include "kvm_riscv.h"
> +#include "kvm/kvm_riscv.h"
>  #include "tcg/tcg.h"
>  
>  /* RISC-V CPU definitions */
> diff --git a/target/riscv/kvm.c b/target/riscv/kvm/kvm-cpu.c
> similarity index 100%
> rename from target/riscv/kvm.c
> rename to target/riscv/kvm/kvm-cpu.c
> diff --git a/target/riscv/kvm-stub.c b/target/riscv/kvm/kvm-stub.c
> similarity index 100%
> rename from target/riscv/kvm-stub.c
> rename to target/riscv/kvm/kvm-stub.c
> diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
> similarity index 100%
> rename from target/riscv/kvm_riscv.h
> rename to target/riscv/kvm/kvm_riscv.h
> diff --git a/target/riscv/kvm/meson.build b/target/riscv/kvm/meson.build
> new file mode 100644
> index 0000000000..1cd6783894
> --- /dev/null
> +++ b/target/riscv/kvm/meson.build
> @@ -0,0 +1,2 @@
> +riscv_ss.add(when: 'CONFIG_KVM', if_true: files('kvm-cpu.c'),
> +                                 if_false: files('kvm-stub.c'))
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index f0486183fa..c53962215f 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -24,7 +24,6 @@ riscv_ss.add(files(
>    'zce_helper.c',
>    'vcrypto_helper.c'
>  ))
> -riscv_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files('kvm-stub.c'))
>  
>  riscv_system_ss = ss.source_set()
>  riscv_system_ss.add(files(
> @@ -39,6 +38,7 @@ riscv_system_ss.add(files(
>  ))
>  
>  subdir('tcg')
> +subdir('kvm')
>  
>  target_arch += {'riscv': riscv_ss}
>  target_softmmu_arch += {'riscv': riscv_system_ss}
> -- 
> 2.41.0
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

