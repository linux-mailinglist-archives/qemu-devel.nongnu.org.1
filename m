Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEF7742A32
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 18:04:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEu6L-0001JN-Fp; Thu, 29 Jun 2023 12:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEu69-0001D5-Uh
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 12:02:22 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEu66-0001iT-66
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 12:02:21 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso884480f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 09:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688054534; x=1690646534;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9YAU/rvGGYg7OeBZOQ9232GFeKjs7qr+fwrW3NFCu68=;
 b=HcxkB5ZFVK3baNvYbxmEy2J2yiHX7teLZhIPzVn5EE8sUR1lwPUtXPuUK28RTLSYTs
 g6yw5iyfUXMgFNs1+NENK4CAhKjHMnczVqhYpT+mM95RAcqrrOmrJXAj3Pe2fLu3XdN+
 o1rkQZpKBYhcYZ7k5KF5TpjtE0IBGYBvZC3/2cES65qgBbhOk/LjrTH/nPLI/9R8O1nU
 xTVoBzeMc3Rsb37Xv6SqH1Z3hZkhiHaYyV1rbNc0OwTFS9FrFoSKoiJGpW7Zelc3tBsR
 XfA5Q199aeClGNax7WYil+F8BlYLhKn9oe2Aaf+tQzpmn/UIMAXH+C1LXTarB7MJSQ/D
 Gbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688054534; x=1690646534;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9YAU/rvGGYg7OeBZOQ9232GFeKjs7qr+fwrW3NFCu68=;
 b=E3GiyhI3fJNsel9lkNsdLVDkrU+KhUIPLX9YzFdR5l2dtIN5fDmQZ0bzRrtRDzkCXd
 y+RoTVPMwzXVC/TAInCuQ2rPfscnrtb7uzP25R8x11cJGIUsvHt9aa1A/bFBU1jVRZqX
 ITOEj0ElLvljyx59pnpGyd9NEH9kLNDJLvajAjgxs817dmCxwsGc1fHgOodzD1ZaRBlh
 ubpdSXyf78EqqCxu9u2PxwcmXWx3XPobhMv8s4In/+VLyHSllqzbdimgbBec+V9wIWCd
 1AQdfLn9aN3KcBIB71uQTB7aymbuFEQ6UVOfhjVl+HJ8As+07IcU7Eo1+O1Pw3royZa1
 9uQA==
X-Gm-Message-State: ABy/qLbi8ZBoj5guZU+LjwKRA3r7DCek/i0Ysx6ZlqYLtRuPMvtqKiAl
 qiPkuX4wge1k+bbMPRgsg3oo/g==
X-Google-Smtp-Source: APBJJlFsg1ijubPmiW2oVl2w8TQwZPbkADBp4Beg5diizCudZO3xT1KeSbVGmnsnllogncnuUNKqWw==
X-Received: by 2002:a5d:554a:0:b0:314:1f1e:3a85 with SMTP id
 g10-20020a5d554a000000b003141f1e3a85mr84793wrw.61.1688054533662; 
 Thu, 29 Jun 2023 09:02:13 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 y19-20020a05600c365300b003fa8dbb7b5dsm13081658wmq.25.2023.06.29.09.02.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 09:02:13 -0700 (PDT)
Message-ID: <5787edb5-35e4-2fd9-c4c6-1cc09ca5bc2b@linaro.org>
Date: Thu, 29 Jun 2023 18:02:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 05/37] crypto: Add aesenc_SB_SR_AK
Content-Language: en-US
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
References: <20230620110758.787479-1-richard.henderson@linaro.org>
 <20230620110758.787479-6-richard.henderson@linaro.org>
 <a2173165-9bd9-fd1e-a778-07bdf6379659@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a2173165-9bd9-fd1e-a778-07bdf6379659@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/29/23 17:45, Max Chou wrote:
> On 2023/6/20 7:07 PM, Richard Henderson wrote:
> 
>> diff --git a/include/crypto/aes-round.h b/include/crypto/aes-round.h
>> new file mode 100644
>> index 0000000000..d675d2468f
>> --- /dev/null
>> +++ b/include/crypto/aes-round.h
>> @@ -0,0 +1,44 @@
>> +/*
>> + * AES round fragments, generic version
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * Copyright (C) 2023 Linaro, Ltd.
>> + */
>> +
>> +#ifndef CRYPTO_AES_ROUND_H
>> +#define CRYPTO_AES_ROUND_H
>> +
>> +/* Hosts with acceleration will usually need a 16-byte vector type. */
>> +typedef uint8_t AESStateVec __attribute__((vector_size(16)));
>> +
>> +typedef union {
>> +    uint8_t b[16];
>> +    uint32_t w[4];
>> +    uint64_t d[4];
>> +    AESStateVec v;
>> +} AESState;
> Should we change the length of d from 4 to 2 ?

Yes, definitely a typo.

r~


