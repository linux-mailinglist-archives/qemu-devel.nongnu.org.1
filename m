Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04727823638
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 21:12:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL7aI-0004qO-3o; Wed, 03 Jan 2024 15:11:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rL7aF-0004pI-L8
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 15:11:23 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rL7aD-0003pB-QO
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 15:11:23 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-28c0536806fso7976201a91.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 12:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704312680; x=1704917480; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lxDySQciFjYDcNGSfu3KWzZrkw4L2H3CVDjlqeqQKgI=;
 b=IoVxvhMrVq/LFxBxldtONJsk60NQus/Y52tcQM/HWZacwS89/qeOpuArDymUelum9r
 G8kXIH8abgiszDslO09fRbwDo4kls5RatFvtmEw/IEM/u6gRg7inVSVn3sw0pbWX1Z4E
 X0naLIPsvPJq3hB1AZL8iSzQf/DMos7IX8viEKhvW6TraNNcZAT4/6qzMn0LXY/EOOL9
 0HBNVvIJhIT67X/3V6anL4WIrJcxhPDWzjN9QgSHFZDITKvUONjvZ32XPV4kKEwdgung
 Xfj8OVRnG50PuFeqp11ljzEOKAor+BpiSEYkv87xmY9y50QhObrnbwx/9zVqlLAoiLJY
 Gc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704312680; x=1704917480;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lxDySQciFjYDcNGSfu3KWzZrkw4L2H3CVDjlqeqQKgI=;
 b=WVMBPWDUaSkF1HPcfC/R+6Rv2eYlNB4SxdBDTqwmzxLGwerAS5x9w/EDxeig9mPFj3
 k4q9jw+V6dj+iXKdSZ/gj1Ytj5H04bev/rcFTmsHwgOyQkipAB2s7H4ApWYt2cTt3WOr
 vcVrpjV7S7UwdRdtPooU0TbwJrFkkOE8M1xpxL1GJPo/5XY22lXWw+8tkrNoi+8NOPCt
 K0hBTPJfilOlCFbh6d+WQhL7+mD1/LSEswyJ/2GJTXWHS/fRQjwS8c/nk4cFE2BHEEma
 XyJhTJTy9HMhiEUXUUj6FbytFyd3EBkyuzzMZlIod4kQ1wFWbArj++SXXGNjQvzpQONR
 Shfw==
X-Gm-Message-State: AOJu0Yz6APRI40MchpRJRc9UMJtLmQZygngU9nTniS71KllvQnKrt2wd
 NeL2xQEuWth8bEW0MNFO35b4g2UKbV53TQ==
X-Google-Smtp-Source: AGHT+IEQqL8GEtF+ndM/QBR7kC0U+9uRZVkUD9G51HVsDJN8X5AGxr9OTrWm7TQma/+r4GUapc7C5Q==
X-Received: by 2002:a17:90a:c68b:b0:28c:ab21:6a9 with SMTP id
 n11-20020a17090ac68b00b0028cab2106a9mr5011214pjt.1.1704312680329; 
 Wed, 03 Jan 2024 12:11:20 -0800 (PST)
Received: from [192.168.68.110] ([189.79.21.107])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a17090a930700b0028b89520c7asm2132049pjo.9.2024.01.03.12.11.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 12:11:19 -0800 (PST)
Message-ID: <ff37b49d-e152-472e-8c24-4adbb8cdcb46@ventanamicro.com>
Date: Wed, 3 Jan 2024 17:11:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 2/5] target/riscv: Add cycle & instret privilege mode
 filtering properties
To: Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
References: <20231229004929.3842055-1-atishp@rivosinc.com>
 <20231229004929.3842055-3-atishp@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231229004929.3842055-3-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102e.google.com
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



On 12/28/23 21:49, Atish Patra wrote:
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
> 
> This adds the properties for ISA extension smcntrpmf. Patches
> implementing it will follow.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> ---
>   target/riscv/cpu.c     | 3 ++-
>   target/riscv/cpu_cfg.h | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 83c7c0cf07be..da3f05cd5373 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -148,6 +148,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>       ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>       ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
> +    ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>       ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
>       ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
>       ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
> @@ -1296,6 +1297,7 @@ const char *riscv_get_misa_ext_description(uint32_t bit)
>   const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       /* Defaults for standard extensions */
>       MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
> +    DEFINE_PROP_BOOL("smcntrpmf", RISCVCPU, cfg.ext_smcntrpmf, false),

This will end up breaking the build since this macro is adding a Property object
inside a RISCVCPUMultiExtConfig array. Patch 3 is then fixing it by removing this
line, so in the end the build works fine. But having a patch that doesn't build
can make future bisects unpleasant.

I don't see a problem adding right now the actual flag:

+    MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),

The flag will do nothing, sure, but the commit msg already mentions "Patches
implementing it will follow", so it's fine to me.



Thanks,

Daniel


>       MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
>       MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
>       MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
> @@ -1308,7 +1310,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       MULTI_EXT_CFG_BOOL("zve64f", ext_zve64f, false),
>       MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
>       MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
> -
>       MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
>       MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
>       MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index f4605fb190b9..00c34fdd3209 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -72,6 +72,7 @@ struct RISCVCPUConfig {
>       bool ext_zihpm;
>       bool ext_smstateen;
>       bool ext_sstc;
> +    bool ext_smcntrpmf;
>       bool ext_svadu;
>       bool ext_svinval;
>       bool ext_svnapot;

