Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A9C7C5406
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 14:33:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqYNV-0002Mg-CR; Wed, 11 Oct 2023 08:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqYNT-0002MW-W4
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 08:31:52 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqYNS-0000Cj-5C
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 08:31:51 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-53da72739c3so2420075a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 05:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697027508; x=1697632308; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=recTgP2Y7PcpsL0p5G+CcwbO2WQASP0/e+EofPLlj74=;
 b=eGohz9AMgEc1YNP8bK+QRAty3UBLUpu5bkuDXROtR1Jv9FsabdmKErlh2+dAGuUGSV
 DTjsc5AvX5Wn54hJsVcfwwyP2sn3njF3hxCyXbHfNmznZeUx6MS1AHc5qCkV2JmQtJpr
 rOQk2JSpvlMXvz402g/b8o47DZr/Dn47gwsFAewkJHmSX1iM2R73oGIE8lG2VdVgJfM1
 XrO6xHZ0ZFLMSUnloYhKCTasXgBDLRBSoNFtq1QP3hYj7+kM41Pv4n/XTzSxEykTSCaM
 cfL/bUxxEWMYFxapJ6AkhsdrJhgWDxUGMcnLPmQXaV4MuxnHdWybShBlaumJmC/I7UK0
 LTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697027508; x=1697632308;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=recTgP2Y7PcpsL0p5G+CcwbO2WQASP0/e+EofPLlj74=;
 b=OQtdYQ0xRcIKE+WLKQvZ8aQKtAKtbVP/W8k0gB6blLwt2Au7V0rJqXjaLCYSAOBtn1
 5PFcBhsGNdzObq0Tt164o1MLdSUbPj2sNchN+kyWTPyxA6O9uvHbwBqnKkgE2EpZfHSS
 E1vyJhbW7qJhjO8PO0s1pMWOat6TBkcH52Ek5uIukBzkyhWUglbEIC6UzErXEdX0Qq3v
 Qz3zZTTJCuSzXW0rN764fFwH5NM9LCXSf+4nQ4NHyi5d6RyXf4+TeG2O9uLS4mTJaDdl
 f/VbpHSN/9HbC8L3PYG2Qm/LM2QfeIWEYZxpAU2PYxUSNwcZkgDI+sJA40LiDr4W7pfy
 zXPQ==
X-Gm-Message-State: AOJu0Yxu2iJ9EVInCs3GYPipVeeY3/1h+iMjWs924CjN8HsFN9yywWdX
 EIH3zjUrVwEt3puems+kLz71m4pGS1VpceHiB8k=
X-Google-Smtp-Source: AGHT+IHKXSzBKMi0yk1tnEqTXKNM0g3SQ4T2hGlPTrVloRNhlJ3IgtkjlrNmhIUwRTXzWQl0jiPkvQ==
X-Received: by 2002:a17:906:10ce:b0:9a1:e233:e627 with SMTP id
 v14-20020a17090610ce00b009a1e233e627mr20512374ejv.42.1697027508264; 
 Wed, 11 Oct 2023 05:31:48 -0700 (PDT)
Received: from [192.168.69.115] (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 w13-20020a170906480d00b0098d2d219649sm9868746ejq.174.2023.10.11.05.31.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 05:31:46 -0700 (PDT)
Message-ID: <e9f0c004-cb23-0985-30ca-394197d6bf94@linaro.org>
Date: Wed, 11 Oct 2023 14:31:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH RFC v4 0/9] Add loongarch kvm accel support
Content-Language: en-US
To: xianglai li <lixianglai@loongson.cn>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Song Gao <gaosong@loongson.cn>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <cover.1696841645.git.lixianglai@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <cover.1696841645.git.lixianglai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

Hi,

On 9/10/23 11:01, xianglai li wrote:
> This series add loongarch kvm support, mainly implement
> some interfaces used by kvm such as kvm_arch_get/set_regs,
> kvm_arch_handle_exit, kvm_loongarch_set_interrupt, etc.
> 
> Currently, we are able to boot LoongArch KVM Linux Guests.
> In loongarch VM, mmio devices and iocsr devices are emulated
> in user space such as APIC, IPI, pci devices, etc, other
> hardwares such as MMU, timer and csr are emulated in kernel.
> 
> It is based on temporarily unaccepted linux kvm:
> https://github.com/loongson/linux-loongarch-kvm
> And We will remove the RFC flag until the linux kvm patches
> are merged.
> 
> The running environment of LoongArch virt machine:
> 1. Get the linux source by the above mentioned link.
>     git checkout kvm-loongarch
>     make ARCH=loongarch CROSS_COMPILE=loongarch64-unknown-linux-gnu- loongson3_defconfig
>     make ARCH=loongarch CROSS_COMPILE=loongarch64-unknown-linux-gnu-
> 2. Get the qemu source: https://github.com/loongson/qemu
>     git checkout kvm-loongarch
>     ./configure --target-list="loongarch64-softmmu"  --enable-kvm
>     make
> 3. Get uefi bios of LoongArch virt machine:
>     Link: https://github.com/tianocore/edk2-platforms/tree/master/Platform/Loongson/LoongArchQemuPkg#readme
> 4. Also you can access the binary files we have already build:
>     https://github.com/yangxiaojuan-loongson/qemu-binary
> 
> The command to boot loongarch virt machine:
>     $ qemu-system-loongarch64 -machine virt -m 4G -cpu la464 \
>     -smp 1 -bios QEMU_EFI.fd -kernel vmlinuz.efi -initrd ramdisk \
>     -serial stdio   -monitor telnet:localhost:4495,server,nowait \
>     -append "root=/dev/ram rdinit=/sbin/init console=ttyS0,115200" \
>     --nographic

2 years ago Song helped with an access to a LoongArch 3a5000 machine but
it stopped working (IP was x.242.206.180).

Would it be possible to add a Loongarch64 runner to our CI
(ideally with KVM support, but that can come later)? See:
https://www.qemu.org/docs/master/devel/ci.html#jobs-on-custom-runners

Regards,

Phil.

