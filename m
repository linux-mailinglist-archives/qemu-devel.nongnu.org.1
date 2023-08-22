Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C9C784682
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 18:05:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYTs9-00087r-EL; Tue, 22 Aug 2023 12:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYTs7-00087c-6J
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:04:47 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYTs4-00062G-W4
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:04:46 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68a3082c771so1993291b3a.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 09:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692720282; x=1693325082;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dfDgGRxWetl9W0JrxxSDzG1xu85JY7wFY6ujE5Yphx8=;
 b=KeExDsFJl9dgc476IRkDauEMyIHWcZLLH07fNvr4/vc2XDr+Sk8A5yWsQe+8Oq9NQD
 OQAJGGuEdMe0Z7KW1ELEQGut2i6oSX9+UFxO1JOt1322K0yylHfBWouLWKtbR0uVj7QX
 gy5z243G/4MWV53jVzzBgd2rcwuM1g00nCXIOWI/IJ2tNqSx5ej8L3hvHAgZSzwsI9dy
 gez+cz0GIB0EBP4zgszPQibYkypLhd5vD+9A8xdQfEAK9PZnkBuHtTQSVk6+MbgLtNkK
 Wk5fQZHf7sZpB4AsxlrzrTSgx0dr/kuUgWxxchtusCzj5lhBrbAOCmikUvcxxR/J5EzM
 t/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692720282; x=1693325082;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dfDgGRxWetl9W0JrxxSDzG1xu85JY7wFY6ujE5Yphx8=;
 b=Cq92cjS8KKBDwkpAxf5paIX+t6vZNJNU+Idq7s1NGOQc8JbvhiH+/lG3+ZHEPAk1Ff
 YTnSLpscIds5Fqs911AcjFesVPxmZayXS5OWuP0oNUPOYaouxBKSsEaSEwuCi1hmMWam
 Exmyz/wSe8cQeeqxfgKmKIUh63ZpuvkLj296DAHdPosgetNk9T/9+5prTEv1FFrkeWjV
 M0qp8najfS/Sm7gmUDcSgF7zvYC/r48lUR54ih+YGqMGBTNXbxOzWkR+/tn7Q/X+mefL
 gXURt6k131zGyTXBpvno9Rzm2qlv4vjcZtthKtpBpO+IiTW5SR5Rl6b0gJA4guU92NNk
 9NBQ==
X-Gm-Message-State: AOJu0YwK7VsfitlnZoNcq4Dyr5v5L2qZrMIZG9Ye9ou2kScs05vNsAxF
 xNaSfpdbVdGgYydUvDzYwTlrtASARR0C3+7ZRxc=
X-Google-Smtp-Source: AGHT+IEuZlDc97Fb6ntu8MlIiNXAjPyI9uUFZC2KzQYv/DW0+ntgn1wFZkNIH2MVU1wAp0aJVObmPg==
X-Received: by 2002:a05:6a00:18a2:b0:68a:6734:b018 with SMTP id
 x34-20020a056a0018a200b0068a6734b018mr4737554pfh.15.1692720282598; 
 Tue, 22 Aug 2023 09:04:42 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 f7-20020aa78b07000000b00686edf28c22sm7911423pfd.87.2023.08.22.09.04.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 09:04:42 -0700 (PDT)
Message-ID: <df6e8477-0a5b-aa60-b053-ea991bc82e40@linaro.org>
Date: Tue, 22 Aug 2023 09:04:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/7] tcg/tcg-op: Document hswap() byte pattern
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230822093712.38922-1-philmd@linaro.org>
 <20230822093712.38922-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230822093712.38922-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 8/22/23 02:37, Philippe Mathieu-Daudé wrote:
> Document hswap_i32() and hswap_i64(), added in commit
> 46be8425ff ("tcg: Implement tcg_gen_{h,w}swap_{i32,i64}").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/devel/tcg-ops.rst |  4 ++++
>   tcg/tcg-op.c           | 26 +++++++++++++++++++-------
>   2 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
> index 6a166c5665..d9364effd2 100644
> --- a/docs/devel/tcg-ops.rst
> +++ b/docs/devel/tcg-ops.rst
> @@ -486,6 +486,10 @@ Misc
>            into 32-bit output *t0*.  Depending on the host, this may be a simple shift,
>            or may require additional canonicalization.
>   
> +   * - hswap_i32/i64 *t0*, *t1*
> +
> +     - | Swap 16-bit halfwords within a 32/64-bit value.

hswap is not a tcg opcode, so this is incorrect.

This falls into the part of TCG that Peter has mentioned many times: we have opcode 
documentation, but no separate translator front end documentation.


r~

