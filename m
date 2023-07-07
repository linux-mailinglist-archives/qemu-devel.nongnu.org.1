Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFC874B89F
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 23:20:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsrn-0007vw-Az; Fri, 07 Jul 2023 17:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsrj-0007v4-NX
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 17:19:47 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsri-0004ZT-AE
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 17:19:47 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3143b88faebso2591220f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 14:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688764784; x=1691356784;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9bhdV3/ZBjJ6zVPg9Iih8cCWoJrOfFZpK4OrnmVXllc=;
 b=mgiuTro400V9lgbVKg/xXMuRX73rkEKX/3wsx+SNT9LLl5raHm3eO3r4hfpDJ93Cf0
 BKZlzRj26vdeMZkFMrj8ah4UFDhX90qAMiEE03cJ27G+NvBXYLrJQOY97/HeUM5eMijH
 6UX3/M1zSxouOmVwgBk+v1qcuslQKvup+7UnJlcbGi5cxgRL47pmpp/uEi+HJW55+a7s
 GPmVUfx3FDVX8f30a7mei5B8qNvlR7o5bT7v3YXwyQqBk3GPwBC5LdkOhE4zdO1jwokJ
 7aMoVFIDAw5IyYECYNPm3Ie+dTNPgZBiRGD5CJBDh4iDLXMx03qf1yanuIp6cr9CEaBB
 txZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688764784; x=1691356784;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9bhdV3/ZBjJ6zVPg9Iih8cCWoJrOfFZpK4OrnmVXllc=;
 b=C1M0sK9F4SYxFCGhJIi+ILpkZ48Tr7mqCGyXk4qEgCUJodlpdMqNHdK0NmWDqdOjRF
 Rmy8WBnnKT/AH4siSY7uYw6dqhBVpAyQosjOL2d+PrgxyM356ggik60x2PTYo/kmNcv6
 8Eq7N7GZ/WKuiI42Ss30T/3Nqv2Vm7WsqH2Hw2EfaUxv+33BKdxc7GSgB4o10tVviLwP
 Qx4YWyjs0vjDwANAOXt8QkqWSxBQFWalGhU45k8+tIa4SQfchOrl7ElGFb2hZdQV89Tf
 vQd/+0lfibLu89WPqXc/D2nICRKrtm25uFV3/anCZo2sRUs3zXQl//N0zpvBEiIMiygI
 Thvw==
X-Gm-Message-State: ABy/qLa/eX5Q0vvWmZjCQuaHsOiTjntwuPQiD5Qupgq8xGVhNj5B5MVA
 6/n6/ti2ts5sPx1q9X1wnMNA1CDAmmZ4Kqx9NTpxIA==
X-Google-Smtp-Source: APBJJlG4s0hPGeDYVugZGBu+uW77B+3XCJ+Zr518KgjvcueRW9jGt5Z0reps4RhCE3pqfkTRE+qLzA==
X-Received: by 2002:a5d:460c:0:b0:314:41e9:9a92 with SMTP id
 t12-20020a5d460c000000b0031441e99a92mr5254460wrq.24.1688764784367; 
 Fri, 07 Jul 2023 14:19:44 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a05600c444600b003fbb1ce274fsm11289480wmn.0.2023.07.07.14.19.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 14:19:44 -0700 (PDT)
Message-ID: <c0bcf176-956f-f8e4-8169-47d797b234c0@linaro.org>
Date: Fri, 7 Jul 2023 22:19:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 20/46] target/loongarch: Implement vext2xv
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-21-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-21-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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
> +#define VEXT2XV(NAME, BIT, E1, E2)                        \
> +void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz, \
> +                  uint32_t vd, uint32_t vj)               \
> +{                                                         \
> +    int i;                                                \
> +    VReg *Vd = &(env->fpr[vd].vreg);                      \
> +    VReg *Vj = &(env->fpr[vj].vreg);                      \
> +    VReg temp;                                            \
> +                                                          \
> +    for (i = 0; i < LASX_LEN / BIT; i++) {                \
> +        temp.E1(i) = Vj->E2(i);                           \
> +    }                                                     \
> +    *Vd = temp;                                           \
> +}

So unlike VEXT(H), this does compress in order?

Anyway, function signature and iteration without LASX_LEN.
Isn't there a 128-bit helper to merge this with?


r~

