Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BBE78EE46
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:14:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhS8-0005P3-TZ; Thu, 31 Aug 2023 09:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbhS3-00050K-8q
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:11:11 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbhRz-0001ym-HS
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:11:09 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-99c1f6f3884so90451066b.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 06:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693487465; x=1694092265; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=njvqji7ZYkq9lGMC9uKIVhI5gf1E+Sm34Az4hHBWlJ8=;
 b=dlJR3N3p+c6DvgakgiMLZwooZsqYbxa/cV8fmH8r1EKp1VCsTGknj3UmvoBKk9nF9s
 d73foWh+Em2LBPeXducFGw1GnLDXT3DZmdYcTM8stobKMXSsMW/98PrRHeZOy8gxystt
 HtT8N+W7LebIDv4f/0Vegg/+gIfpnwepyiuyYKDCXDAAeq+IMvLl5ppBAjKiH4r3X65s
 SwuTPjaV87fQTPZFFk2pbyDGVYMdqASsbkX76EfZMtMN66MpSkojz8VMf36OGx7rhwIk
 hePuPpcUCL7HKFat8b1MoGMl+8MbpMx9AKjy2TVYNlvcPdGgFZaI/iBuMiV3yY3A8KZE
 QymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693487465; x=1694092265;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=njvqji7ZYkq9lGMC9uKIVhI5gf1E+Sm34Az4hHBWlJ8=;
 b=bLqDrLgSk37x6K/q/wGG3QKPLPzyOa/P8gvQb3VYfxehxFBAfujn4Zamz+F+RmGPkn
 ksShPp2IdV9g0IVjwz5D7zKjEvS50+tbJwpmBCQV/HpalH0SH/o3KuFGOfXdzv0K2GVW
 NjWzLQAn6CBrnuvo9rW/JBjPLsC9l3CDfHLgV3APUMsjyNDgr7c698G+Jn2sTkLzxgZU
 LdKwFXmoI+aDHJmkA/qEaNwWnmYQIH2TcZPId3TeMyUXr9MRYXY2hLSE0qah308jtLLY
 mT8ztPwWxeEQdarbFJ9IQAG5WBJH02oUuZRteW02E/YYjQmK1N1fM05FuUIZsO3Ayxdi
 rE1w==
X-Gm-Message-State: AOJu0YzSJwukZRpXDsC7T6d8J6mxv2LyoF1xRqWvVIochTWUI3/+WrNU
 q4TDr+wN5DJFWmTe+9mfo9umKw==
X-Google-Smtp-Source: AGHT+IGMdZtDUwjMhwCbFscMlP7UJFPB7vmOPBDFsVpPj+2KLqE9BFt6PkgIH33/M2CrNE1IV/vLuw==
X-Received: by 2002:a17:906:1d8:b0:99d:ff60:6ff4 with SMTP id
 24-20020a17090601d800b0099dff606ff4mr4299319ejj.70.1693487465176; 
 Thu, 31 Aug 2023 06:11:05 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a1709064dc200b0099c53c4407dsm749542ejw.78.2023.08.31.06.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 06:11:04 -0700 (PDT)
Date: Thu, 31 Aug 2023 15:11:03 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH RESEND v8 10/20] target/riscv: add 'max' CPU type
Message-ID: <20230831-8bda2abafcb322586175aa69@orel>
References: <20230824221440.484675-1-dbarboza@ventanamicro.com>
 <20230824221440.484675-11-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824221440.484675-11-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x629.google.com
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

On Thu, Aug 24, 2023 at 07:14:30PM -0300, Daniel Henrique Barboza wrote:
> The 'max' CPU type is used by tooling to determine what's the most
> capable CPU a current QEMU version implements. Other archs such as ARM
> implements this type. Let's add it to RISC-V.
> 
> What we consider "most capable CPU" in this context are related to
> ratified, non-vendor extensions. This means that we want the 'max' CPU
> to enable all (possible) ratified extensions by default. The reasoning
> behind this design is (1) vendor extensions can conflict with each other
> and we won't play favorities deciding which one is default or not and
> (2) non-ratified extensions are always prone to changes, not being
> stable enough to be enabled by default.
> 
> All this said, we're still not able to enable all ratified extensions
> due to conflicts between them. Zfinx and all its dependencies aren't
> enabled because of a conflict with RVF. zce, zcmp and zcmt are also
> disabled due to RVD conflicts. When running with 64 bits we're also
> disabling zcf.
> 
> MISA bits RVG, RVJ and RVV are also being set manually since they're
> default disabled.
> 
> This is the resulting 'riscv,isa' DT for this new CPU:
> 
> rv64imafdcvh_zicbom_zicboz_zicsr_zifencei_zihintpause_zawrs_zfa_
> zfh_zfhmin_zca_zcb_zcd_zba_zbb_zbc_zbkb_zbkc_zbkx_zbs_zk_zkn_zknd_
> zkne_zknh_zkr_zks_zksed_zksh_zkt_zve32f_zve64f_zve64d_
> smstateen_sscofpmf_sstc_svadu_svinval_svnapot_svpbmt
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 56 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


