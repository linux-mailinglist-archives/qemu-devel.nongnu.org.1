Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F38DC8225EA
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 01:23:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKp1t-0001EG-IJ; Tue, 02 Jan 2024 19:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKp1r-0001E8-JL
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 19:22:39 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKp1p-0005jT-Ji
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 19:22:39 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d44200b976so33160525ad.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 16:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704241354; x=1704846154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gza86VDTwHN5Ij2jw315cml16cTwUefHEJrmNAED8vI=;
 b=WFIj7WtvZrgm8gNLqAecSHGIciIhLgo4d3bHQZU9MPIHLTIoDJ3Y6QobBMAeYyy3VR
 CElwpuKiRg5UOA4SpP77s9crUrk19GcDg0VnavSpINKsgbLTsl+OllFpgZKFHbkuaZ0Z
 vRXfzVLmUzMEa3QQ1E4i/HRRjpxU9x8IOXWEhaWAAu5LBIyRhYZ5wedzdjMK9ixdg9bo
 GvlWfQeBBayerQnRydPTyFgaBmB4e5fnXmA10KO+s4SVvkn8q+88cIyRFNbg82i7M316
 hmTYaUh7HCxCDDp9TQCmcfeCILF8S5ybSiAeTvlRly460F4sVDfhr2d3QEj724GKb7De
 lRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704241354; x=1704846154;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gza86VDTwHN5Ij2jw315cml16cTwUefHEJrmNAED8vI=;
 b=FfPX/Li1MaiCGO+J89E+y9jiies7v6MZ5E005P0r2e+7b8IC2IheRi50TN/4gAknCG
 uPR9ykxzNAu+ZsfDQtlnjfMzFk0ZiA5Fq7mbl4eZgh7oRlPaiv/OISPVrgPyjiL80nhw
 h1f+LM5/FepKH4fuk594NZ6iEUP9Bqe0i9wz0i4EjYlB93o4yGcby8u81cOb9jyOd4oc
 j69h12Xvck5M12XeyvUIq65trfrzEeQlO00T6Mec1ckigZ51h4aCGWmlufsKLVu06zs1
 ULenQao0Qncr1l++UuwVWRb5rlj23vVA9O3I7TGKuzfg8CU9fz2EV3umklcpOpSDx/NX
 PDBA==
X-Gm-Message-State: AOJu0Yxr5+9SrzNRix5y+PiZq8iA9x9qbe6jq2QuhWGpROWJBWu0U+/a
 nfOEu88vZ7IPf1D/nO7NxpDs4hhnpxsdN5bacal0m//ZbV0=
X-Google-Smtp-Source: AGHT+IEUtxxN1Oj2BICiAD1Osb/WMZWUeIAg26Nf4fM6/WUqQfiQHxvSQEkmPYM1CTqKPQ4Y4KJk3w==
X-Received: by 2002:a17:902:684d:b0:1c5:d063:b70e with SMTP id
 f13-20020a170902684d00b001c5d063b70emr8884119pln.53.1704241354578; 
 Tue, 02 Jan 2024 16:22:34 -0800 (PST)
Received: from [192.168.50.95] (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a170902cec400b001c62b9a51a4sm22612511plg.239.2024.01.02.16.22.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 16:22:33 -0800 (PST)
Message-ID: <dfc5987a-4210-4579-b9a3-1cc12fe1b909@linaro.org>
Date: Wed, 3 Jan 2024 11:22:29 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: chacha20-s390 broken in 8.2.0 in TCG on s390x
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>
References: <d5e8f88b-1d19-4e00-8dc2-b20e0cd34931@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <d5e8f88b-1d19-4e00-8dc2-b20e0cd34931@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 12/22/23 01:51, Michael Tokarev wrote:
> When running current kernel on s390x in tcg mode *on s390x hw*, the following
> is generated when loading crypto selftest module (it gets loaded automatically):
> 
> [   10.546690] alg: skcipher: chacha20-s390 encryption test failed (wrong result) on test 
> vector 1, cfg="in-place (one sglist)"
> [   10.546914] alg: self-tests for chacha20 using chacha20-s390 failed (rc=-22)
> [   10.546969] ------------[ cut here ]------------
> [   10.546998] alg: self-tests for chacha20 using chacha20-s390 failed (rc=-22)
> [   10.547182] WARNING: CPU: 1 PID: 109 at crypto/testmgr.c:5936 alg_test+0x55a/0x5b8
> [   10.547510] Modules linked in: net_failover chacha_s390(+) libchacha virtio_blk(+) 
> failover
> [   10.547854] CPU: 1 PID: 109 Comm: cryptomgr_test Not tainted 6.5.0-5-s390x #1  Debian 
> 6.5.13-1
> [   10.548002] Hardware name: QEMU 8561 QEMU (KVM/Linux)
> [   10.548101] Krnl PSW : 0704c00180000000 00000000005df8fe (alg_test+0x55e/0x5b8)
> [   10.548207]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> [   10.548291] Krnl GPRS: 0000000000000000 0000000001286408 00000000005df8fa 0000000001286408
> [   10.548337]            000000000014bf14 00000000001c6ba8 0000000001838b3c 0000000000000005
> [   10.548475]            00000000025a4880 00000000025a4800 ffffffffffffffea 00000000ffffffea
> [   10.548521]            000000003e649200 00000000ffffffff 00000000005df8fa 000003800016bcf8
> [   10.549504] Krnl Code: 00000000005df8ee: c020003b5828    larl    %r2,0000000000d4a93e
> [   10.549504]            00000000005df8f4: c0e5ffdb62d2    brasl    %r14,000000000014be98
> [   10.549504]           #00000000005df8fa: af000000        mc    0,0
> [   10.549504]           >00000000005df8fe: a7f4fee6        brc    15,00000000005df6ca
> [   10.549504]            00000000005df902: b9040042        lgr    %r4,%r2
> [   10.549504]            00000000005df906: b9040039        lgr    %r3,%r9
> [   10.549504]            00000000005df90a: c020003b57df    larl    %r2,0000000000d4a8c8
> [   10.549504]            00000000005df910: 18bd        lr    %r11,%r13
> [   10.550004] Call Trace:
> [   10.550375]  [<00000000005df8fe>] alg_test+0x55e/0x5b8
> [   10.550467] ([<00000000005df8fa>] alg_test+0x55a/0x5b8)
> [   10.550489]  [<00000000005d9fbc>] cryptomgr_test+0x34/0x60
> [   10.550514]  [<000000000017d004>] kthread+0x124/0x130
> [   10.550539]  [<0000000000103124>] __ret_from_fork+0x3c/0x50
> [   10.550562]  [<0000000000b1dfca>] ret_from_fork+0xa/0x30
> [   10.550611] Last Breaking-Event-Address:
> [   10.550626]  [<000000000014bf20>] __warn_printk+0x88/0x110
> [   10.550723] ---[ end trace 0000000000000000 ]---
> 
> git bisect points to this commit:
> 
> commit ab84dc398b3b702b0c692538b947ef65dbbdf52f
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Wed Aug 23 23:04:24 2023 -0700
> 
>      tcg/optimize: Optimize env memory operations
> 
> So far, this seems to work on amd64 host, but fails on s390x host -
> where this has been observed so far.  Maybe it also fails in some
> other combinations too, I don't yet know.  Just finished bisecting
> it on s390x.

I haven't been able to build a reproducer for this.
Have you an image or kernel you can share?


r~


