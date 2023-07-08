Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 662D874BC84
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 09:12:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI260-0002qH-2H; Sat, 08 Jul 2023 03:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qI25x-0002pg-VV
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 03:11:06 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qI25w-0000tr-8b
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 03:11:05 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbc59de0e2so29163445e9.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jul 2023 00:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688800261; x=1691392261;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qoi4uub60mCLj+7f1Y9H1tqYquOn2nWNJuD/abSy6gQ=;
 b=k5oFbkzgu8wg4ux1o34fbJXxjp9LyKVxMYaQqR1fBO8XKn2DLJJN47x3VZM5+M3h8P
 0JvOKDY+S8Nf9sgznJFa6xdoUAk1dXwOwxoiWVNwONfoO2sCYgX604Qjv6RjNqUUMQDB
 +T7Khd7nheri+qwL5D3NpYzJxJYvnzG/oUT2US0pj9OGD56o5TARut9R1sZNQ9YzpAxJ
 XuphKhS7MrH23jrt8EKB9L6QyVcPrX5avPB49a/sy5ooAFuPdRlliwCZHAiarsY74hNP
 X42ZybjYqmueq3FFo0/uRXD1o6l2Y56vuXwe0CC84l580UoWJahvDETbfODezhbXyCC/
 j9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688800261; x=1691392261;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qoi4uub60mCLj+7f1Y9H1tqYquOn2nWNJuD/abSy6gQ=;
 b=hOFzIi9PYqtSmtpR8amP/h9eYpYfJkdz8oLdKNzcf9Qg0JRcP+d1oSTBY4vsiVmxKm
 s+O9VD05Ip4v7AHq8DIENafE9x26l5A1jf+jdaEVwSXZU4drkqwN4/vc6S49ULjlWdsK
 cVEpMg3uBzZ/xO+g1uBlnZfDM4+Ena78Ztb2g2WcCxm1BFZjU5wrXbhyPhZ3wiZ1Z+HD
 BU6dAugrAKnjeUqrAmsoVav76+lXrVpzaynhCeYNQd4u3Bkhx11PHqg80s3X83zo48/v
 Mv+t2Sl2A69MMSWhhF6bXDBwF7Ko6GPKa50P82X/X2/Xz8bNtUorgV9WMXx1Rz/axJ6x
 XsEg==
X-Gm-Message-State: ABy/qLbS5ZoQLzh2bcvOffoGcRB8lE4/98N8tkuzSAS7q25IVNFIw1MC
 K/ZYyRSEpx5EoZp5dvPDSioQFx5BRUXLx9ZerC5d4w==
X-Google-Smtp-Source: APBJJlGKltJrFhlugHVPvZQrhRJ6Pq13KdtXBoVVRrV6UmvkZ097/MzAyDYTTqI2YpJ4jU+MbSaRSA==
X-Received: by 2002:a7b:c019:0:b0:3fa:9924:1241 with SMTP id
 c25-20020a7bc019000000b003fa99241241mr6141917wmb.4.1688800261513; 
 Sat, 08 Jul 2023 00:11:01 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 x18-20020a5d60d2000000b0031435731dfasm6261851wrt.35.2023.07.08.00.11.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jul 2023 00:11:01 -0700 (PDT)
Message-ID: <e2ba4fdd-7242-fa95-4312-028555877811@linaro.org>
Date: Sat, 8 Jul 2023 08:10:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 26/46] target/loongarch: Implement xvsllwil xvextl
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-27-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-27-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 6/30/23 08:58, Song Gao wrote:
> +#define VSLLWIL(NAME, BIT, E1, E2)                                     \
> +void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,              \
> +                  uint32_t vd, uint32_t vj, uint32_t imm)              \
> +{                                                                      \
> +    int i, max;                                                        \
> +    VReg temp;                                                         \
> +    VReg *Vd = &(env->fpr[vd].vreg);                                   \
> +    VReg *Vj = &(env->fpr[vj].vreg);                                   \
> +    typedef __typeof(temp.E1(0)) TD;                                   \
> +                                                                       \
> +    temp.Q(0) = int128_zero();                                         \
> +                                                                       \
> +    if (oprsz == 32) {                                                 \
> +        temp.Q(1) = int128_zero();                                     \
> +    }                                                                  \
> +                                                                       \
> +    max = LSX_LEN / BIT;                                               \
> +    for (i = 0; i < max; i++) {                                        \
> +        temp.E1(i) = (TD)Vj->E2(i) << (imm % BIT);                     \
> +        if (oprsz == 32) {                                             \
> +            temp.E1(i + max) = (TD)Vj->E2(i + max * 2) << (imm % BIT); \
> +        }                                                              \
> +    }                                                                  \
> +    *Vd = temp;                                                        \
> +}

Function parameters using void* and desc.

     VReg temp = { };

instead of conditional partial assignment.

Fix iteration, as previously discussed.


r~

