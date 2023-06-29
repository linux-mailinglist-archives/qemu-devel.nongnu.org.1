Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F3D7429DE
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 17:46:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEtpm-0002Yi-LZ; Thu, 29 Jun 2023 11:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qEtpU-0002R3-GT
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:45:09 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qEtpS-0005ax-M2
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:45:08 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b7ef3e74edso5184485ad.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1688053505; x=1690645505;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LALWh4Y1VVifjAGs/krRnq2qH2nbx4alOQ4RpbmVsrg=;
 b=RRhNXvDV+bHXqUMe+yGWueo9Y+S55u+3y56NfG5QS94M/1i7HLuiS5+AgnugcP/x0f
 4lJo2msnTv1osp21PmcNdvOvzf9SQi2V+UHj+lS0amII32s7hj66OVn9y2REl7a6tE3K
 4WztKcJaQTR46UFSMlshJULP23256B+ZSZdebbGA2TSafQfS9W+7Q3GvvdVv4HPm5Y+C
 0S/DYNvklvtWh445WLw4Lh1oPJuHp4eTLoQYZKIstl+9kzgr+Eh1VbRem3VsZfBZ2X2M
 CC5pUBbD39nxMJkGmD5FNcT7+of2tt3t3U2UeZBbOeSfh+GT1REUGiRcfi3KzAPM4V8p
 Ipmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688053505; x=1690645505;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LALWh4Y1VVifjAGs/krRnq2qH2nbx4alOQ4RpbmVsrg=;
 b=BbegPdKAQb438RLD6ZxAcvpyU+7uASvukV48cXtFsTLXd9R3ZsUDZBNeFhjDpseHea
 DtSgE5708vrkefmXcn9o22E29xjSq2AiTMj+ZwYdd3FeMBJBpgbPAw9Xua4QHwFxfvYY
 cblS4BdorHFTOrIgPwXyLJNcHgb74QS0qDiSik7D2b89GNKvqpKR0pNltMr/oyLcQ6mu
 ZAMl19Hav2BpsIA/QNIGh6qA8GX1xqzKyFUdkZf+oQbozbSlNlIZUCapei4xGCE+j+9O
 FHl/AcMVMsKwxEspD/gUBYb4TJ+eDjPFwrk7DNIfhH/RmvqUj3voKKcAe31h2Pwcwfke
 HnZw==
X-Gm-Message-State: AC+VfDx6+vBCiZj0Q8F4Xa+5+uBDINUslN7HbFA0Dkzo42e20X64lLyR
 UHLmtTkYE8BlsuuXn5bstjpFdA==
X-Google-Smtp-Source: ACHHUZ7OA5HTLkqrhKgis0eZ8MP2tZYiPLLk/LGhRRgZO1w3/jNGDEMm38KQrWzgwsrY7sNC8sN5jw==
X-Received: by 2002:a17:902:dace:b0:1b3:c7c1:8ded with SMTP id
 q14-20020a170902dace00b001b3c7c18dedmr13433215plx.27.1688053504932; 
 Thu, 29 Jun 2023 08:45:04 -0700 (PDT)
Received: from [10.11.0.74] (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 2-20020a170902c20200b001b03a7a40e7sm3650793pll.19.2023.06.29.08.45.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 08:45:04 -0700 (PDT)
Message-ID: <a2173165-9bd9-fd1e-a778-07bdf6379659@sifive.com>
Date: Thu, 29 Jun 2023 23:45:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 05/37] crypto: Add aesenc_SB_SR_AK
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
References: <20230620110758.787479-1-richard.henderson@linaro.org>
 <20230620110758.787479-6-richard.henderson@linaro.org>
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <20230620110758.787479-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62d.google.com
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

On 2023/6/20 7:07 PM, Richard Henderson wrote:

> diff --git a/include/crypto/aes-round.h b/include/crypto/aes-round.h
> new file mode 100644
> index 0000000000..d675d2468f
> --- /dev/null
> +++ b/include/crypto/aes-round.h
> @@ -0,0 +1,44 @@
> +/*
> + * AES round fragments, generic version
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (C) 2023 Linaro, Ltd.
> + */
> +
> +#ifndef CRYPTO_AES_ROUND_H
> +#define CRYPTO_AES_ROUND_H
> +
> +/* Hosts with acceleration will usually need a 16-byte vector type. */
> +typedef uint8_t AESStateVec __attribute__((vector_size(16)));
> +
> +typedef union {
> +    uint8_t b[16];
> +    uint32_t w[4];
> +    uint64_t d[4];
> +    AESStateVec v;
> +} AESState;
Should we change the length of d from 4 to 2 ?

With regards,
Max

