Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 299C2835EED
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 11:01:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRr7I-0003Es-Kl; Mon, 22 Jan 2024 05:01:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rRr6v-00033t-H8
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 05:01:03 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rRr6s-0005iG-8V
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 05:00:55 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e9d4ab5f3so32707375e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 02:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705917653; x=1706522453; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=giTntrrGnwZ3RFDTTXhjHj52B7+z6MrLK0FEOOPyD7o=;
 b=CcK1jQN1XMRopn7PTNgIO3TkmKL2MhAQ4STeMzrO7f1hxT4vqSDyZb4+CdZt+GBXl3
 d4Fo4tMYdWd1El0a8qukIMaKVd9uHcmjnVbPzlMVIO+pX8v6gp2rbsfROr40J95ZqrL7
 Rb5sM/pEJbnfEVkSMpwDPVQlH71NdGBoqsnEU7R+V0tAjwLFyikNDL9nRL8KGNwizvKt
 yUte2k0pZEg7U6IG+lUTWWZlqhynH0YH7xgajYA7SV5CKf0KkjHqzY1ZvBVEUkjua98j
 K6afiQ1K+rogMGt6aTBdVCc1iUGoCBU0JdVkeeO1uGsBkdj0esQB/gHPbtd87LBfd80d
 jFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705917653; x=1706522453;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=giTntrrGnwZ3RFDTTXhjHj52B7+z6MrLK0FEOOPyD7o=;
 b=Anau+imW1m46PbhhYeBokuuizgJlEy0EtfbyUo5Rg6dsrNJ/7q/X3Yc6dsG80g0zU+
 JNIHqeEHkw6pV1WBow0gbrS0N9jo1/bBHDw2gjf9biDspZxRRCeQvBQOlem9SsdyvdyK
 /h8qTqwRF47o978t8MkRxz7R3fs9jkxeVpQ0yfu2ySM7NxlLVJIchm4Vg6s8cMX/icou
 aA/k/D8hNkSZ7BDZ1lw5kAFL9gsXfnvHMFcsxAlv4RoNAwOYqUldNg6g5VyRjubUTOIc
 5eV9cBUin93dZ/StzETt9UIoZG2ykPuLCgg89M482EPSq5orCyg46PHqUcj9GsPB+NB2
 7hnQ==
X-Gm-Message-State: AOJu0YzcPBHPXx0PRWXwv2WNTvMypJN+SWV+V+ttXWBKyp505OMMxyGw
 /Ybx4mrCGc1WwJz0DKiWyZSiWXYQiKWp4m3p9HGOAAhi2898o64oX3XawdK2nUk=
X-Google-Smtp-Source: AGHT+IHqOgBlQrjJjux94ZxjhHGfFpsl1Ia0wzNgTLlX9kcWKYdnda01RVzn/TCBGBrdYi3cP9MBeQ==
X-Received: by 2002:a05:600c:1f86:b0:40e:5118:5046 with SMTP id
 je6-20020a05600c1f8600b0040e51185046mr2163839wmb.21.1705917652574; 
 Mon, 22 Jan 2024 02:00:52 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 bg23-20020a05600c3c9700b0040d91fa270fsm38770353wmb.36.2024.01.22.02.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 02:00:52 -0800 (PST)
Date: Mon, 22 Jan 2024 11:00:51 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 4/4] qemu-options: enable -smbios option on RISC-V
Message-ID: <20240122-14abf335500d65fcf11422b6@orel>
References: <20231229120724.41383-1-heinrich.schuchardt@canonical.com>
 <20231229120724.41383-5-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229120724.41383-5-heinrich.schuchardt@canonical.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Dec 29, 2023 at 01:07:24PM +0100, Heinrich Schuchardt wrote:
> With SMBIOS support added for RISC-V we also should enable the command line
> option.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	new patch
> ---
>  qemu-options.hx | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 7bdb414345..5ed82df11f 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2705,7 +2705,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
>      "                specify SMBIOS type 17 fields\n"
>      "-smbios type=41[,designation=str][,kind=str][,instance=%d][,pcidev=str]\n"
>      "                specify SMBIOS type 41 fields\n",
> -    QEMU_ARCH_I386 | QEMU_ARCH_ARM | QEMU_ARCH_LOONGARCH)
> +    QEMU_ARCH_I386 | QEMU_ARCH_ARM | QEMU_ARCH_LOONGARCH | QEMU_ARCH_RISCV)
>  SRST
>  ``-smbios file=binary``
>      Load SMBIOS entry from binary file.
> -- 
> 2.43.0
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

