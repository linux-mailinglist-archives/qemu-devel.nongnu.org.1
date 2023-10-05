Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5777BAB74
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 22:31:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoV0H-0003ay-GU; Thu, 05 Oct 2023 16:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1qoUzo-0003Sy-Dp
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 16:30:58 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1qoUzl-0002w1-Vc
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 16:30:56 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5046bf37daeso1858883e87.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 13:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1696537850; x=1697142650;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z0j7Q67+q/acYpwgr1ioIuBbJnN2u+X+26+krbJ7VdQ=;
 b=jFVJlENUu/8bDkt82U5BvidESO46cz81I1vfac0QO6tOBtEv8YOCaTz8TuIZ57TkoU
 8Dzr9aeGetJscAY4CmyvAjnAzfLN1AVFlLfBXuiMP410y4ifvmuVifFrltfoBXg+IgrB
 f/Cs+/nLLem2DCRHOfrBsTwAbIyic7IhXcrn2DgN3m0j0Th66Y2lzzzgodwV4OepS3EY
 gRP7yP8cAnzh94IaRQ2mC7ce0Ea8J95RPNd78TAyqzHPTshDuQUBTvh4y6FWceBXB0Xp
 1rBlheufCopsUFEKWzqIiiTIDB8hPz/Ec0VCNa9hnV1uWEtV/5QX3pbkbJHO0fl+NTNF
 Z4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696537850; x=1697142650;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z0j7Q67+q/acYpwgr1ioIuBbJnN2u+X+26+krbJ7VdQ=;
 b=Zn7bO2+leDTpUCdX2l12IP9/O2iLYwDhpE3yInsdGZxwzQjpfvtU4KLcEpE/UyMgcZ
 NKsIppR5fXPC8ce3LZNikDWna5Wd9MKQ+Le7kWcQ7a6iTA2eeUu7LXfF78UvP+pnsPEu
 tXjXxmj5c94LHENIYLSdZtsjCBmvwTe6D3JCzyKLQuDOY23rxSvvhvfyDeZWQUuluv1R
 iHW7Vjd5FsaccvoYQjGRz5WRoi2ZuQ75w5PoZbB3nZqVI0/7hLf8v8mjI/ILMM5OiSUY
 crCPELU5rWu8IfqxFKtFU51vmybAF15TAGdhzO1o3UaX3TFIUxGfBd7qMGhzMelj856D
 x4tg==
X-Gm-Message-State: AOJu0Yx9nH2bXRx94Ws9oGnA9BfheZT0hp/B+oT0oYFUjgyfOsYuDLZM
 YHQrJrNZSQIgaJStGQINJA25VkjU2gFbPRfw5Un3BA==
X-Google-Smtp-Source: AGHT+IHzCDpq34Rai4ej5AMJGRlZVStm1yp9ClIaLIrOLL7eNOp3GFdU6/0HV0tAO6ISfvjy8FzqeSA+Iwy6Qj11AE0=
X-Received: by 2002:a05:6512:210c:b0:4fb:bef0:948e with SMTP id
 q12-20020a056512210c00b004fbbef0948emr4675954lfr.5.1696537850455; Thu, 05 Oct
 2023 13:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230922140914.13906-1-phil@philjordan.eu>
In-Reply-To: <20230922140914.13906-1-phil@philjordan.eu>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Thu, 5 Oct 2023 22:30:39 +0200
Message-ID: <CAGCz3vt7Mb_E5WQ860BTvO0-LBQJDnzfJ9ykTsCYFM2GDdguWQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] hvf x86 correctness and efficiency improvements
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, dirty@apple.com, rbolshakov@ddn.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: neutral client-ip=2a00:1450:4864:20::12f;
 envelope-from=lists@philjordan.eu; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

Ping - let me know if there's anything particularly controversial,
unclear, etc. about these patches or if I can do anything to make
reviewing easier.

Thanks!


On Fri, 22 Sept 2023 at 16:09, Phil Dennis-Jordan <phil@philjordan.eu> wrote:
>
> This is a series of semi-related patches for the x86 macOS Hypervisor.framework
> (hvf) accelerator backend. The intention is to make VMs run slightly more
> efficiently on macOS host machines. They have been subject to some months of
> CI workloads with macOS guest VMs without issues and they seem to give a few
> percent performance improvement. (Though this varies greatly with the type of
> workload.)
>
> Patch 1 enables the INVTSC CPUID bit when running with hvf. This can enable
> some optimisations in the guest OS, and I've not found any reason it shouldn't
> be allowed for hvf based hosts.
>
> Patch 2 fixes hvf_kick_vcpu_thread so it actually forces a VM exit instead of
> doing nothing. I guess this previously didn't cause any huge issues because
> hvf's hv_vcpu_run() would exit so extremely frequently on its own accord. The
> temp variable is needed because the pointer expected by the hv_vcpu_interrupt()
> call doesn't match the fd field's type in the hvf accel's struct AccelCPUState.
> I'm unsure if it would be better to change that struct field to the relevant
> architecture's handle types, hv_vcpuid_t (x86, unsigned int) and hv_vcpu_t
> (aarch64, uint64_t), perhaps via an intermediate typedef?
>
> Patch 3, which replaces the call to hv_vcpu_run() with the more modern
> hv_vcpu_run_until() for running the guest vCPU. The newer API is available
> from macOS 10.15 host systems onwards. This call causes significantly fewer
> VM exits, which also means we really need that exit-forcing interrupt from
> patch 2. The reduction in VM exits means less overhead from exits and less
> contention on the BQL. Using hv_vcpu_run_until() is also a prerequisite for
> using certain newer hvf features, though this patchset doesn't use any.
>
> Patches 2 & 3 must therefore be applied in that order, patch 1 is independent.
>
> This work has been sponsored by Sauce Labs Inc.
>
> Phil Dennis-Jordan (3):
>   i386: hvf: Adds support for INVTSC cpuid bit
>   i386: hvf: In kick_vcpu use hv_vcpu_interrupt to force exit
>   i386: hvf: Updates API usage to use modern vCPU run function
>
>  target/i386/hvf/hvf.c       | 26 +++++++++++++++++++++++++-
>  target/i386/hvf/x86_cpuid.c |  4 ++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
>
> --
> 2.36.1
>

