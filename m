Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CC87B3D84
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 04:15:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmPUN-0007ww-OT; Fri, 29 Sep 2023 22:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmPUK-0007wg-TU
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 22:13:48 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmPUI-0001Sz-0R
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 22:13:48 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-564af0ac494so10132946a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 19:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696040023; x=1696644823; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Hwu+A/am+FE8DNBwDWMh+Qtl6ocN7A3tSSLL7oS/uBc=;
 b=oB1vUhcLs4detfgqaPEztskWyxXPzdxcGFClHa42baEIwEGPE8w9CuTrS4u7aWTTs0
 z6E+ixfnL9FD1bQ+lQRG5W7MpRsehp2y2hva2RcvpSyhdfUNZAy3r1mTKRm2c1vt9za+
 vs5CaMTp3Yto5d0PCzoajnc68jEW9DXuDtseXDnPYOdO8Ekl+BZV+TZ3czoCfVcFy8Ic
 ggfWmNkc4fx5siE5gTF3nQUljLZ1BxeOklKvDL6+bMamhdFaIJfDVlrdMnd3B8gohCKc
 5Zi6XLdYnScHLWMZo70L42/VXkFeVmx2quEBbuMqX3QD0RfpRiwxJ6phlvKPtwUhnafs
 KJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696040023; x=1696644823;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hwu+A/am+FE8DNBwDWMh+Qtl6ocN7A3tSSLL7oS/uBc=;
 b=Tgt4hsb9tYRizC6pXsahEWfh24BnfiCpIACa4IieSZ9oENMAy1I+pgTB6u6rs8vrD2
 srjs6knXqV30et0icyfF4vxUDr7n3QGY6e9B8MYnq1v2MMSP7ROuIb3gmHA5Uz+TlRSv
 wueqZCK6whHDoeKdCMMHJxdC9qGnSO+0Ml8ZLVr/tTh5Tx/RvM2lZbQYauf1pkheqvdo
 UgvevM0qGsWSFNc2R4NF2jjginm0ugubA946lfsAgEY06AmlCYYXAOifzqkKZD2tm1la
 5ufgmUmMYZIh0LV48Z+V5Q5SSarbzvGYypECkjwEFgyqCgMrU0a+rQxKIF0V3HyRmpcw
 XqDQ==
X-Gm-Message-State: AOJu0YwohUqY5P5MLQxmQc4A2H933gylV7N/AeXIHQxPgsTeE5Lcv+ht
 ztgR9Psf/jeqf1asrlXANDy2sj48Ugxxla05qBg=
X-Google-Smtp-Source: AGHT+IE205Mor3/6Rol/qSdQw92VPmp07WZM1E8Hg1TxNghLx//vuzLm3VO0usshXXCpBLQUpmpyMw==
X-Received: by 2002:a17:903:1207:b0:1bd:f7d7:3bcd with SMTP id
 l7-20020a170903120700b001bdf7d73bcdmr6651349plh.50.1696040023421; 
 Fri, 29 Sep 2023 19:13:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a170902d2cb00b001c06dcd453csm17495252plc.236.2023.09.29.19.13.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 19:13:42 -0700 (PDT)
Message-ID: <b9704f72-e4de-74e4-9b10-8ba14cea3d2d@linaro.org>
Date: Fri, 29 Sep 2023 19:13:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/7] tcg/loongarch64: Improvements for 128-bit load/store
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name, c@jia.je, gaosong@loongson.cn, yangxiaojuan@loongson.cn
References: <20230916220151.526140-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20230916220151.526140-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.295,
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

Ping.

r~

On 9/16/23 15:01, Richard Henderson wrote:
> For tcg generated code, use new registers with load so that we never
> overlap the input address, so that we can simplify address build for
> 64-bit user-only.
> 
> For tcg out-of-line code, implement the host/ headers to for atomic 128-bit
> load and store, reducing the cases for which we must raise EXCP_ATOMIC.
> 
> 
> r~
> 
> Based-on: 20230916171223.521545-1-richard.henderson@linaro.org
> ("[PULL v2 00/39] tcg patch queue")
> 
> Richard Henderson (7):
>    tcg: Add C_N2_I1
>    tcg/loongarch64: Use C_N2_I1 for INDEX_op_qemu_ld_a*_i128
>    util: Add cpuinfo for loongarch64
>    tcg/loongarch64: Use cpuinfo.h
>    host/include/loongarch64: Add atomic16 load and store
>    accel/tcg: Remove redundant case in store_atom_16
>    accel/tcg: Fix condition for store_atom_insert_al16
> 
>   .../include/loongarch64/host/atomic128-ldst.h | 52 +++++++++++++++++++
>   host/include/loongarch64/host/cpuinfo.h       | 21 ++++++++
>   .../loongarch64/host/load-extract-al16-al8.h  | 39 ++++++++++++++
>   .../loongarch64/host/store-insert-al16.h      | 12 +++++
>   tcg/loongarch64/tcg-target-con-set.h          |  2 +-
>   tcg/loongarch64/tcg-target.h                  |  8 +--
>   accel/tcg/cputlb.c                            |  2 +-
>   tcg/tcg.c                                     |  5 ++
>   util/cpuinfo-loongarch.c                      | 35 +++++++++++++
>   accel/tcg/ldst_atomicity.c.inc                | 14 ++---
>   tcg/loongarch64/tcg-target.c.inc              | 25 +++++----
>   util/meson.build                              |  2 +
>   12 files changed, 189 insertions(+), 28 deletions(-)
>   create mode 100644 host/include/loongarch64/host/atomic128-ldst.h
>   create mode 100644 host/include/loongarch64/host/cpuinfo.h
>   create mode 100644 host/include/loongarch64/host/load-extract-al16-al8.h
>   create mode 100644 host/include/loongarch64/host/store-insert-al16.h
>   create mode 100644 util/cpuinfo-loongarch.c
> 


