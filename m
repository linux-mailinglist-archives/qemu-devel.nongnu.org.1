Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E7378D0AC
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:39:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb8Hl-0005Xl-3m; Tue, 29 Aug 2023 19:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb8Hf-0005RK-H9
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:38:08 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb8Hb-0004YX-Ji
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:38:05 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c1e128135aso18058845ad.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 16:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693352282; x=1693957082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ob0pTbTTKDlmZ0UmmGR2qYOblPjAnuUjQIupLa9DU1c=;
 b=PFwWfKiBXNpOLdqZTUZO4qAUsh0UutLsWhIY80YdD2DqvU/sYbFuYBvR1SPYNdYoth
 MPFfDWrI8sGWryjomOOfMWnQyFN8hy5DZD4RAZtI7Aq0XOKCcVA046IKW7eaO+vo/nvP
 nZDKwdwx15iVnibMt3edZBXdpR4OF8fDfVskenLUvOd6D/UOFqUJyIYx2vG+df7znrqB
 Bq4BjTUJvqviS/2YSNlJQFB68YumC9DFvWHxHNmaJdxGAQuqC1Zj8irzTxG72BA2sp/H
 iq5t3VTANWUcDPKzpRTY2JH04xoW5Lss5mGIkvxWmRybMc3I3I0RF8q6jABCyxXOFYEg
 hxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693352282; x=1693957082;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ob0pTbTTKDlmZ0UmmGR2qYOblPjAnuUjQIupLa9DU1c=;
 b=AjvnGAv2PelRL7EY2pALgROjK9V9HwMVMBMDlEDT8tLjC3I1QxAn4VMLzhCd1WNKJb
 4ja9QPjRP8H6uWZ9pIKuNtYhAmJCUCBJy25BjaBJn87w8NWPSUbUPxZ2b/nNNzGFOFK1
 BXM9rQAyu9LcCVROXsvHnDByGaTW1OC3Ei4g0dBhSwAZoslTFyzKIvsgqlU+Z8bFIJXl
 dTUnssCE7es7w3PAd17x6OCX/bmiSTupF42JjK4D/ixT8vEpqaJvTpenAQV3gjugwMUV
 cceXpa/cWAZTQLMVEuhH5FacCuNMOq1PC52hL+eV8B81lU48cMTFp6jmbTwgnqVU+Q8e
 ukEw==
X-Gm-Message-State: AOJu0YyO7WyELe6nGwtv0zKK2YMduZs+CXY8qHNCjph0HBxXmfwhhL9W
 vc8s4MJBfC/D4QXGHP8a+4c2ByDqFmofL8ACdV4=
X-Google-Smtp-Source: AGHT+IFlyKYeZuMf12GvAOP2LIB96J4bCiBVQ67VIek12W4GuyX9bFoVk4XmVD+2X3YHsCbdv0pRqg==
X-Received: by 2002:a17:902:ef93:b0:1b7:e49f:1d with SMTP id
 iz19-20020a170902ef9300b001b7e49f001dmr600886plb.62.1693352282032; 
 Tue, 29 Aug 2023 16:38:02 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 g5-20020a170902740500b001b39ffff838sm9892762pll.25.2023.08.29.16.38.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 16:38:01 -0700 (PDT)
Message-ID: <65ac368a-5017-378b-b13e-cb450f5a7d59@linaro.org>
Date: Tue, 29 Aug 2023 16:37:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: [PULL v2 0/5] tcg patch queue
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
References: <20230829185458.861690-1-richard.henderson@linaro.org>
In-Reply-To: <20230829185458.861690-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Gah, second time in a row messing up the PULL tag.

r~

On 8/29/23 11:54, Richard Henderson wrote:
> The following changes since commit 813bac3d8d70d85cb7835f7945eb9eed84c2d8d0:
> 
>    Merge tag '2023q3-bsd-user-pull-request' of https://gitlab.com/bsdimp/qemu into staging (2023-08-29 08:58:00 -0400)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230829-2
> 
> for you to fetch changes up to 669fd6151337fdc81e34f7eb4940ba2f20d89957:
> 
>    Revert "include/exec: typedef abi_ptr to vaddr in softmmu" (2023-08-29 11:30:33 -0700)
> 
> ----------------------------------------------------------------
> softmmu: Use async_run_on_cpu in tcg_commit
> tcg: Remove vecop_list check from tcg_gen_not_vec
> tcg/sparc64: Disable TCG_TARGET_HAS_extr_i64_i32
> Revert "include/exec: typedef abi_ptr to vaddr in softmmu"
> 
> ----------------------------------------------------------------
> Richard Henderson (5):
>        softmmu: Assert data in bounds in iotlb_to_section
>        softmmu: Use async_run_on_cpu in tcg_commit
>        tcg: Remove vecop_list check from tcg_gen_not_vec
>        tcg/sparc64: Disable TCG_TARGET_HAS_extr_i64_i32
>        Revert "include/exec: typedef abi_ptr to vaddr in softmmu"
> 
>   include/exec/cpu-common.h    |  1 -
>   include/exec/cpu_ldst.h      |  4 ++--
>   tcg/sparc64/tcg-target.h     |  2 +-
>   accel/tcg/cpu-exec-common.c  | 30 --------------------------
>   softmmu/physmem.c            | 50 ++++++++++++++++++++++++++++++++------------
>   tcg/tcg-op-vec.c             |  7 +++----
>   tcg/sparc64/tcg-target.c.inc | 11 ----------
>   7 files changed, 43 insertions(+), 62 deletions(-)


