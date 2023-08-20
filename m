Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99507781E6C
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 17:05:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXjyg-0001Br-Ke; Sun, 20 Aug 2023 11:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjyc-0001BP-Dc
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 11:04:26 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjya-0005RR-7n
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 11:04:26 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68a43131e82so306243b3a.2
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 08:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692543863; x=1693148663;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m977GCXJdBvOjIWWVArq9pjVdZTfIqFJrhQfC/9R/ls=;
 b=flTIxgazJD7JTYClZvutcUTY8tV/ppT8Dlz+xS2pB5c5ur7MCfPYdwsF8am4UWdgy0
 594lh83Jd6SHAOABRxnq83oV/xq7kZkVRSetWsdUfw61ajDginEXNJWHMXDFdoMotDqt
 EruBywyE8bBF70R41VYJXbGPjiBUMmeBJk+Xoki4tYXPQkxdB02FNzbpkP2Ooe435XHY
 5vMYfIgdZ0fY7Kv8HMWxhJqqpMCzC+Wsxyb5XXMNKkweseg+OwzqvqNdqU0NCue8AGjg
 Tg7+iw7DPMb/0Cu09889LLzBTLPMa1NfNq+0aqDF+OK6jLJ8s7gvMCEqL/ckpz+IbBNY
 gGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692543863; x=1693148663;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m977GCXJdBvOjIWWVArq9pjVdZTfIqFJrhQfC/9R/ls=;
 b=jHjgjg/M0ll3AA0ilpdjvTgcbxhsx7Jy4U2cc/kUc2I+q0DZkyeEtHkCp+IQ/N0wFQ
 IsZ0SS5sobTWJ7WFcmqLlRYAZsj8Nn+TNRQabARNExhmEQNHGdLv2+9eM3Kwl8rGPsYh
 LUEjTfoxNmWlGI7SfWKo9i0LS4/EYAdLZI0Sv3aGltUJl64/HAyKukVqJ5vavX7hfcpO
 iOpVhbB1H+nB0+jKvH5+we46qvNzmyCRRqGTJGSHiH6fszW4VyKiLwZPKjwzGL/6q1Rr
 QRNqlshsvvIROcUdKhG3/Qa/CLVFdOv3CCKv1iAAD4wYpY+R3alwWB7bZzHYucHmG93/
 7CtA==
X-Gm-Message-State: AOJu0Yy1nOPcr9+j8ELxm1B7GXmEIF7IIbr+9cYid5HhGnXDuVb2VgI6
 4/z0gEFoqkwtCsFTGtT18gVBlA==
X-Google-Smtp-Source: AGHT+IEmCc2R29RmgKQVn0SZtUBmhgJnezb3P5yrhMCUlW4UKhYEzE3ikrn71EoisYqhDkptLxtNoQ==
X-Received: by 2002:a05:6a21:6da5:b0:13c:ca8b:7e29 with SMTP id
 wl37-20020a056a216da500b0013cca8b7e29mr6276677pzb.12.1692543862727; 
 Sun, 20 Aug 2023 08:04:22 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:347d:4d37:bdd7:f5e5?
 ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 a9-20020a62bd09000000b0068844ee18dfsm4535210pff.83.2023.08.20.08.04.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 08:04:22 -0700 (PDT)
Message-ID: <7262295e-b98c-448a-a864-fab81e05babb@linaro.org>
Date: Sun, 20 Aug 2023 08:04:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 18/22] Implement shm_open(2)
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Kyle Evans <kevans@FreeBSD.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-19-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230819094806.14965-19-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 8/19/23 02:48, Karim Taha wrote:
> +#define SHM_PATH(p) ((p) == SHM_ANON ? (p) : path(p))
> +    if (arg1 == (uintptr_t)SHM_ANON) {
> +        p = SHM_ANON;
> +    } else {
> +        p = lock_user_string(arg1);
> +        if (p == NULL) {
> +            return -TARGET_EFAULT;
> +        }
> +    }
> +    ret = get_errno(shm_open(SHM_PATH(p),

Again, SHM_PATH is not needed, because the condition is handled by this IF.


r~

