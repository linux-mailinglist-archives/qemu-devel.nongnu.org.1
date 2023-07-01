Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 019E97447F5
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 10:11:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFVgu-0006AZ-PW; Sat, 01 Jul 2023 04:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFVgs-0006AH-Hz
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 04:10:46 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFVgq-0000Fa-K6
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 04:10:46 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-313f18f5295so3303985f8f.3
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 01:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688199042; x=1690791042;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=01a8o/tk/c4y8WOvDy3ECVJWZtxpD5Zy1/Q88ekbRvo=;
 b=ivPMo+Sg6d1QbqHMHJhifx6la6hZq+oVK4ADXYIG8e08wqbB4PCrK9BCIZY6+vxJ1y
 HXvBZu2fkW0ymuAjbYERA9iJwpBpg1v5/xPnj3/G2x4yanX5XfOIp2o3WsIivvtYrLyY
 jeuKZ7jSThmPXLEAwN1tDJbbDoB1ZQVaWFZ6GWdZE4h3haufhXLz0s/TBxLshpVm+tra
 jk9BWMFfhoEtAR6LX85YgJioDf/bWSzOZtbnJC++9lXw2Z//aL6Ytb7RxM3tQhbcBwgN
 fAZvbWmhKtREEL+nIY7LT1g7DYb8PmzcG6wSdt+cqe3aLRLg5uawLzhLEnksZq83XDm4
 BJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688199042; x=1690791042;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=01a8o/tk/c4y8WOvDy3ECVJWZtxpD5Zy1/Q88ekbRvo=;
 b=fLXCSP4f5siYP6hccguCWse3EPYuv9cRYYF/jIb2iKLWiMZrU+okwsPSapNyxMFSAd
 mRS/YL15i2qh64OdvxW6CH7dKwBi7jdoXnEcOAtLuNnS70UUksK8TsHYvWNobyAS7Hcu
 Q86F1dKNDl4PiMGun6JxJZIXqcfoyD/LuzxhFcMukmvINDjAphnqoluXkPHYGhfUhLpo
 czN6x2kM1f6bOBJEot3+TiMuYwDRNwubePPICuSdf7NIPunXQ45X10GcxNIv33wuGewn
 X7nbShRQGWRm41sM1Bxgr/rL9wLf/RPuGsuKPyj89Q0IC/DOn8FTFJW1jGQzKzUNWLDl
 VHLg==
X-Gm-Message-State: ABy/qLaFC0vSJY/e84I7Bq0yd39ipaY9VGBQ0nL3M1UsL5B2jcsczys6
 zWR370bZEuPLZGTibAtdur0ncOPOeNPMr6AOaq0=
X-Google-Smtp-Source: APBJJlEzoWTReqjzD3cW5NBSYjpIJqoS3f495W+m2Hs6lCcvZPzNSUFuz0oE+tOfRSmePY5h37vrPg==
X-Received: by 2002:adf:dc84:0:b0:313:e591:94ec with SMTP id
 r4-20020adfdc84000000b00313e59194ecmr3658158wrj.67.1688199042560; 
 Sat, 01 Jul 2023 01:10:42 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.169.251])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a1c6a04000000b003fba2734f1esm12298086wmc.1.2023.07.01.01.10.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jul 2023 01:10:42 -0700 (PDT)
Message-ID: <5c405ffd-eda2-9a85-264b-38acf24a6ef3@linaro.org>
Date: Sat, 1 Jul 2023 10:10:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PULL 00/11] tcg and misc patch queue
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230701065510.514743-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230701065510.514743-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 1/7/23 08:54, Richard Henderson wrote:
> The following changes since commit 408015a97dbe48a9dde8c0d2526c9312691952e7:
> 
>    Merge tag 'pull-vfio-20230630' of https://github.com/legoater/qemu into staging (2023-06-30 08:11:08 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230701
> 
> for you to fetch changes up to 605a8b5491a119a2a6efbf61e5a38f9374645990:
> 
>    linux-user: Avoid mmap of the last byte of the reserved_va (2023-07-01 08:33:08 +0200)
> 
> ----------------------------------------------------------------
> dbus: Two hot fixes, per request of Marc-André Lureau

Mentioning here again in case you missed in the other thread,
I believe the proper fix is:
https://lore.kernel.org/qemu-devel/20230630234839.14716-1-philmd@linaro.org/
Anyhow since this patch happens to fix the build, mine can
get merged later on top.

> accel/tcg: Fix tb_invalidate_phys_range iteration
> fpu: Add float64_to_int{32,64}_modulo
> tcg: Reduce scope of tcg_assert_listed_vecop
> target/nios2: Explicitly ask for target-endian loads
> linux-user: Avoid mmap of the last byte of the reserved_va
> 
> ----------------------------------------------------------------
> Marc-André Lureau (1):
>        audio: dbus requires pixman
> 
> Mark Cave-Ayland (2):
>        accel/tcg: Fix start page passed to tb_invalidate_phys_page_range__locked
>        accel/tcg: Assert one page in tb_invalidate_phys_page_range__locked
> 
> Peter Maydell (1):
>        target/nios2 : Explicitly ask for target-endian loads and stores
> 
> Philippe Mathieu-Daudé (1):
>        tcg: Reduce tcg_assert_listed_vecop() scope
> 
> Richard Henderson (6):
>        ui/dbus: fix build errors in dbus_update_gl_cb and dbus_call_update_gl
>        fpu: Add float64_to_int{32,64}_modulo
>        tests/tcg/alpha: Add test for cvttq
>        target/alpha: Use float64_to_int64_modulo for CVTTQ
>        target/arm: Use float64_to_int32_modulo for FJCVTZS
>        linux-user: Avoid mmap of the last byte of the reserved_va
> 
>   include/fpu/softfloat.h         |  3 ++
>   include/tcg/tcg.h               |  6 ---
>   accel/tcg/tb-maint.c            | 13 +++++--
>   fpu/softfloat.c                 | 31 +++++++++++++++
>   linux-user/mmap.c               | 14 +++++--
>   target/alpha/fpu_helper.c       | 85 +++++++++--------------------------------
>   target/arm/vfp_helper.c         | 71 ++++++----------------------------
>   target/nios2/translate.c        | 20 +++++-----
>   tcg/tcg-op-vec.c                |  6 +--
>   tests/tcg/alpha/test-cvttq.c    | 78 +++++++++++++++++++++++++++++++++++++
>   ui/dbus-listener.c              |  4 ++
>   fpu/softfloat-parts.c.inc       | 78 +++++++++++++++++++++++++++++++++++++
>   audio/meson.build               |  2 +-
>   tests/tcg/alpha/Makefile.target |  2 +-
>   14 files changed, 258 insertions(+), 155 deletions(-)
>   create mode 100644 tests/tcg/alpha/test-cvttq.c
> 


