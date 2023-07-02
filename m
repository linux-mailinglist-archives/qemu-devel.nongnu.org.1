Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B628C744C5D
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 07:52:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFpzV-0002ez-9m; Sun, 02 Jul 2023 01:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFpzT-0002er-Hi
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 01:51:19 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFpzR-0000j6-QF
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 01:51:19 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4fb9ae4cef6so5271614e87.3
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 22:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688277074; x=1690869074;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oo9t0yMjBv98AVIrhEgF6Uo+X34qQZVU8aAewTKr5rg=;
 b=YWPByFmlwtVeQ9Z27P/lWh8GpVtF4Pg329JfsXFukrvBjG3lEuMUcAvQcuPjSLguFT
 Ggu9bMHTvKJh/2ZV0tXC+w1tktnEycgWAK0FUCPHQOJOga6c/c7dlJCdaSLtll7n9rwL
 Fc9uzbwtvxxE1/SxU3/1JpnhDI4a3kYaDh5KdQKjFFL6/9OItujKo8US/MN0Fsc4oStm
 N8J/uZfNblwjlMrSSY73dSeUlbtUy7Hf0kFuZebv/oAQHVYSjcpvcF4Ww8u1zhSKM7Sr
 FL3gmRUQjevoYcu/bVq/bscdhRz7YXXV0N4kDKOoHTukIlSBTSYlu5psvu4BEnhAPwO7
 h3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688277074; x=1690869074;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Oo9t0yMjBv98AVIrhEgF6Uo+X34qQZVU8aAewTKr5rg=;
 b=fq8yBnJuQP+XO/c83ULG+Rkpymh97dJPH9ruyuc2Z69YNn5gPNvMPccnqXsM4cFq5R
 9GJlITuNMsLwHk8UMjsOiVGfLAwuCbL1QrIiNWRsn/1G+QWXVK+rFwN06pTcw4D0EAXg
 gg336CuDwSZJ5Xl5LQIMGguVXtnxTu5ubEYIAokvpY4Kxvcu/fWVjQYw3qpwYMu2D3IA
 GFYdiNuyK2R/2doDbqZNMkbPKdMBKitJcpbPRxnwNX1qdroYjABezZ/njXfu0UnQTC9O
 HinTV6OMQ470QGTDEi3bztLkvOdBxGWaxRHncxT4zT6T9j2vFSBJO6ltKxIMg+pKkdNf
 Zarw==
X-Gm-Message-State: ABy/qLaD1fooIwf00x3K4YtdLrPbHzYsiWmNLVH6qZhexM5fx851WwOJ
 MSrktAK1qUiJmMiU8sIUCmQNxg==
X-Google-Smtp-Source: APBJJlGuM5v+DR5xjFx1zU2TuUi8HC662w91bDLgTnmYcbWbnx50mY0Ey86frOTwF96sYLZjYnvwow==
X-Received: by 2002:a05:6512:2211:b0:4fb:8948:2b2b with SMTP id
 h17-20020a056512221100b004fb89482b2bmr6366035lfu.48.1688277074371; 
 Sat, 01 Jul 2023 22:51:14 -0700 (PDT)
Received: from [192.168.1.25] (91.232.79.188.dynamic.jazztel.es.
 [188.79.232.91]) by smtp.gmail.com with ESMTPSA id
 c25-20020a7bc019000000b003f819faff24sm26351815wmb.40.2023.07.01.22.51.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jul 2023 22:51:13 -0700 (PDT)
Message-ID: <d2656da4-b4e1-276d-f1ae-1afde928898c@linaro.org>
Date: Sun, 2 Jul 2023 07:51:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 01/46] target/loongarch: Add LASX data support
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-2-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-2-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/30/23 09:58, Song Gao wrote:
> +#if HOST_BIG_ENDIAN
> +#define B(x)  B[(x) ^ 15]
> +#define H(x)  H[(x) ^ 7]
> +#define W(x)  W[(x) ^ 3]
> +#define D(x)  D[(x) ^ 2]
> +#define UB(x) UB[(x) ^ 15]
> +#define UH(x) UH[(x) ^ 7]
> +#define UW(x) UW[(x) ^ 3]
> +#define UD(x) UD[(x) ^ 2]
> +#define Q(x)  Q[(x) ^ 1]

D/UD use ^ 1, Q does not change.

> @@ -92,8 +125,8 @@ const VMStateDescription vmstate_tlb = {
>  /* LoongArch CPU state */
>  const VMStateDescription vmstate_loongarch_cpu = {
>      .name = "cpu",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINTTL_ARRAY(env.gpr, LoongArchCPU, 32),
>          VMSTATE_UINTTL(env.pc, LoongArchCPU),
> @@ -163,6 +196,7 @@ const VMStateDescription vmstate_loongarch_cpu = {
>      .subsections = (const VMStateDescription*[]) {
>          &vmstate_fpu,
>          &vmstate_lsx,
> +        &vmstate_lasx,

You actually don't need to bump the revision for a new subsection.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

