Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDDC7717C6
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 03:24:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSoxh-0004Kn-L7; Sun, 06 Aug 2023 21:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSoxZ-0004KQ-EK
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 21:23:01 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSoxX-0006Kt-9h
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 21:23:00 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6bc9811558cso3407943a34.0
 for <qemu-devel@nongnu.org>; Sun, 06 Aug 2023 18:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691371376; x=1691976176;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+phdIQO+HgV9vQyEMRyDPWWF5orpME9gcbh3hd9moys=;
 b=JD0zRTE1w4KmDOX3Qp+8S84AqjFX1Ek1Sm7lmyqhGIKXGvU6Oa3FbcVszAN0K7H31a
 Xx3X3+lvrlSP+JCIgoqDEuxKkxdG/jA9p5jmlUB6MmMlxw93g1Cx5n8U8qxxTw6xApxS
 Jw1tfVI1WLZv3MqtNKzitSVqlAaEOIPjagM0ykxWpwh0l1PZXoMwv5KzEMOwgKvwi/8y
 sZkMiEJe+gOrI1PNm6f+YsHNfHXxhghjog88NuQsAehYsu+gPiMPgeWXghWpk6geKufA
 yOhVzznsAJRuIWsZ22GxP+d5dqFsSPJtcf9G5xLsrknW3kJ/wNdgyn43R/MawuiFPzja
 VT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691371376; x=1691976176;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+phdIQO+HgV9vQyEMRyDPWWF5orpME9gcbh3hd9moys=;
 b=X9jG9ZLmHaz1HMVy1vcM+U9eRGPDqleDuqt6TstcYqET393mapRIEnZxzfX1fpq6Fp
 Xg87R/2kUL1GtNr4TuNQJTz1FVy4pCWMF6UOlUWy5m9qBJel3crNxf8O0iLRhyiVE76H
 TLfwoCfIgTi8Syd7Y1kWp1KWxERQ8EAA0QDvsvUX7EmZrCx7dtW4vbo2iRgmIxoRTFEL
 YCq+dxNBdkw514Ryhjb5bzZSUiVQu8ZYPH/GsgydujWYxIbrLDEONFSXZgi1GKthtf5n
 Tcah837xtYzGLc0KpieuJJw0ibZPNhEubqg1KdOmIwKtRGrj3DycI57yrKHNHG2YCaWU
 QqFQ==
X-Gm-Message-State: AOJu0YwERMS/vO/gBFl1QfFW14FXBVYZYxX6S1N+9+zB1byxBWNTL1b7
 PdsjcjPREM+e3AAWzW5jnnfxvfXUCUjSqpmz3KA=
X-Google-Smtp-Source: AGHT+IFM5dsnnoo7aaqNzWpbIS1OR3tlm0UVGB6Q5Yvb8eg3pFF/5lTd5cSOKwoPRkchXFoKaMjD/A==
X-Received: by 2002:a05:6871:711:b0:1bf:c55b:eef9 with SMTP id
 f17-20020a056871071100b001bfc55beef9mr5610166oap.27.1691371376287; 
 Sun, 06 Aug 2023 18:22:56 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:aa8f:d2aa:4d57:4d3c?
 ([2602:47:d490:6901:aa8f:d2aa:4d57:4d3c])
 by smtp.gmail.com with ESMTPSA id
 7-20020a17090a034700b002681bda127esm5197641pjf.35.2023.08.06.18.22.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Aug 2023 18:22:55 -0700 (PDT)
Message-ID: <d0dc52f9-89c2-6a4d-f19c-da3649c5993d@linaro.org>
Date: Sun, 6 Aug 2023 18:22:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 00/24] tcg + linux-user queue for 8.1-rc3
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230806033715.244648-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20230806033715.244648-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.139,
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

On 8/5/23 20:36, Richard Henderson wrote:
> The following changes since commit 6db03ccc7f4ca33c99debaac290066f4500a2dfb:
> 
>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-08-04 14:47:00 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230805
> 
> for you to fetch changes up to 843246699425adfb6b81f927c16c9c6249b51e1d:
> 
>    linux-user/elfload: Set V in ELF_HWCAP for RISC-V (2023-08-05 18:17:20 +0000)
> 
> ----------------------------------------------------------------
> accel/tcg: Do not issue misaligned i/o
> accel/tcg: Call save_iotlb_data from io_readx
> gdbstub: use 0 ("any process") on packets with no PID
> linux-user: Fixes for MAP_FIXED_NOREPLACE
> linux-user: Fixes for brk
> linux-user: Adjust task_unmapped_base for reserved_va
> linux-user: Use ELF_ET_DYN_BASE for ET_DYN with interpreter
> linux-user: Remove host != guest page size workarounds in brk and image load
> linux-user: Set V in ELF_HWCAP for RISC-V
> *-user: Remove last_brk as unused
> 
> ----------------------------------------------------------------
> Akihiko Odaki (6):
>        linux-user: Unset MAP_FIXED_NOREPLACE for host
>        linux-user: Fix MAP_FIXED_NOREPLACE on old kernels
>        linux-user: Do not call get_errno() in do_brk()
>        linux-user: Use MAP_FIXED_NOREPLACE for do_brk()
>        linux-user: Do nothing if too small brk is specified
>        linux-user: Do not align brk with host page size
> 
> Helge Deller (1):
>        linux-user: Adjust initial brk when interpreter is close to executable
> 
> Matheus Tavares Bernardino (1):
>        gdbstub: use 0 ("any process") on packets with no PID
> 
> Mikhail Tyutin (1):
>        accel/tcg: Call save_iotlb_data from io_readx as well.
> 
> Nathan Egge (1):
>        linux-user/elfload: Set V in ELF_HWCAP for RISC-V
> 
> Richard Henderson (14):
>        accel/tcg: Adjust parameters and locking with do_{ld,st}_mmio_*
>        accel/tcg: Issue wider aligned i/o in do_{ld,st}_mmio_*
>        accel/tcg: Do not issue misaligned i/o
>        linux-user: Remove last_brk
>        bsd-user: Remove last_brk
>        linux-user: Adjust task_unmapped_base for reserved_va
>        linux-user: Define TASK_UNMAPPED_BASE in $guest/target_mman.h
>        linux-user: Define ELF_ET_DYN_BASE in $guest/target_mman.h
>        linux-user: Use MAP_FIXED_NOREPLACE for initial image mmap
>        linux-user: Use elf_et_dyn_base for ET_DYN with interpreter
>        linux-user: Properly set image_info.brk in flatload
>        linux-user: Do not adjust image mapping for host page size
>        linux-user: Do not adjust zero_bss for host page size
>        linux-user: Use zero_bss for PT_LOAD with no file contents too

Applied a truncated version of this PR:

3c4a8a8fda bsd-user: Remove last_brk
62cbf08150 linux-user: Remove last_brk
0662a626a7 linux-user: Properly set image_info.brk in flatload
2aea137a42 linux-user: Do not align brk with host page size
cb9d5d1fda linux-user: Do nothing if too small brk is specified
e69e032d1a linux-user: Use MAP_FIXED_NOREPLACE for do_brk()
c6cc059eca linux-user: Do not call get_errno() in do_brk()
ddcdd8c48f linux-user: Fix MAP_FIXED_NOREPLACE on old kernels
c3dd50da0f linux-user: Unset MAP_FIXED_NOREPLACE for host
4333f0924c linux-user/elfload: Set V in ELF_HWCAP for RISC-V
89e5b7935e configure: Fix linux-user host detection for riscv64
6c78de6eb6 gdbstub: use 0 ("any process") on packets with no PID
c30d0b861c accel/tcg: Call save_iotlb_data from io_readx as well
f7eaf9d702 accel/tcg: Do not issue misaligned i/o
190aba803f accel/tcg: Issue wider aligned i/o in do_{ld,st}_mmio_*
1966855e56 accel/tcg: Adjust parameters and locking with do_{ld,st}_mmio_*


The "Use MAP_FIXED_NOREPLACE for initial image mmap" patch tickles a latent bug in 
probe_guest_base, which affects our s390x host.  I omitted all of the task_unmapped_base 
and elf_et_dyn_base patches as well since they are also affect layout.


r~

