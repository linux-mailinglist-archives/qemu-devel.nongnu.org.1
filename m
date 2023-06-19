Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DE6734C1B
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 09:08:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB8zS-0005DH-TR; Mon, 19 Jun 2023 03:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB8zI-0005Cw-4g
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:07:45 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB8zF-0005Zr-Ty
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:07:43 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f906d8fca3so15499955e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 00:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687158460; x=1689750460;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=62S0LlFlNOX43/mbw7wYaFf9c540WjdLnRpMuil/NfM=;
 b=NANwwwQiNf9XsiElG7ZU5aRh2rWu9e9amcRZWaXZYgiyZVGqDCMgBvDddTucS9z7DK
 alp5phJocf0mdMMyOd46C6G3gB2NxI1UHhy0+xKnfAXFMizhUJ8+EZZooY8XRH/3YSJ5
 jTmIXzn9tmcGw4bFFV5JEivf1ceTkxmRQxTlptNytSOoYJemsn7i5jLTAhgKW9R1iG5H
 iv4erg8CgFuIGH5ozGgywR8v5qO5kXgmx4Vx5u/EVlGMJeqMELanrD12V6Ipwgu3AdX+
 J/dctOIj9yptK5n404zhtdUbk/l6Njpf+YkvCpYdvuQ4lBdkRYhQRQXryqZERknAmWoB
 MjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687158460; x=1689750460;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=62S0LlFlNOX43/mbw7wYaFf9c540WjdLnRpMuil/NfM=;
 b=kKpzqz7Kod8K2Kw+Do3NMmDv1g1aQQD28YXD5suq4UDWn3rX04iaspiekMM7TKpaXy
 W7cJ5IDsfu1q+Qm/8ck5szpfgRXmF7mGbkVi9EefcVPov1J0j6I4IBkXdoni45kHvXqo
 8CDXAhNfEw6Hwdqlx+LgL5J0b+OghtFzCo8f0Yp5GKbLK4uz35RYfI8T/C8w2AEwoG6o
 V9rICho2wzpJVq/nvvk7O19/ZmJaoxchD0BrEEzQPy/ef1utOw8q2g2touWN49zE6pKO
 SZnRxGBMfkkqsJHyLD3xnxxLNuAUkSQwkd6evSItO9Bnpd3lKBvPGkf6jc/uGSjfWMRg
 PXhg==
X-Gm-Message-State: AC+VfDxTlduuKFJzflZi+bbU6BHl/PJyX/tU/gh558WADqy6duX0cEA4
 8SvKeSCKQ4klpBP3LpJMl28cAA==
X-Google-Smtp-Source: ACHHUZ7NVPLhPKz8qnCW3lnzI91JIkiLpusALb7kIe5RbuyRyUFE5fQzLe/zGdfKCb53lB9X3Qe41A==
X-Received: by 2002:a05:600c:2650:b0:3f8:1f52:f3a9 with SMTP id
 16-20020a05600c265000b003f81f52f3a9mr5811536wmy.23.1687158460395; 
 Mon, 19 Jun 2023 00:07:40 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 y19-20020a05600c365300b003f74eb308fasm9550690wmq.48.2023.06.19.00.07.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 00:07:40 -0700 (PDT)
Message-ID: <9e7b2d1f-b6cb-83fe-7445-3e3cdfdbcccc@linaro.org>
Date: Mon, 19 Jun 2023 09:07:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/6] utils/osdep: Introduce qemu_close_range()
Content-Language: en-US
To: Bin Meng <bmeng@tinylab.org>, qemu-devel@nongnu.org
Cc: Zhangjin Wu <falcon@tinylab.org>, David Hildenbrand <david@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Nikita Ivanov <nivanov@cloudlinux.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Xuzhou Cheng <xuzhou.cheng@windriver.com>
References: <20230616152737.23545-1-bmeng@tinylab.org>
 <20230616152737.23545-5-bmeng@tinylab.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230616152737.23545-5-bmeng@tinylab.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/16/23 17:27, Bin Meng wrote:
> +int qemu_close_range(unsigned int first, unsigned int last)
> +{
> +    DIR *dir = NULL;
> +
> +#ifdef CONFIG_CLOSE_RANGE
> +    int r = close_range(first, last, 0);
> +    if (!r) {
> +        /* Success, no need to try other ways. */
> +        return 0;
> +    }
> +#endif

What about first > last?

close_range will yield EINVAL, and your other fallbacks will burn lots of cpu.


r~

