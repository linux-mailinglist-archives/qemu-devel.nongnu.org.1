Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA72704165
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 01:26:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyhYp-0006ud-LY; Mon, 15 May 2023 19:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyhYn-0006u6-Ic
 for qemu-devel@nongnu.org; Mon, 15 May 2023 19:24:57 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyhYj-0001eD-UM
 for qemu-devel@nongnu.org; Mon, 15 May 2023 19:24:57 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6434e65d808so14191632b3a.3
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 16:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684193092; x=1686785092;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ErmvmWZRvra71DStvOlkrRkcQHRr4QERu5Rb/NcH9Ek=;
 b=KwV1gm05spJzW9sPKWzgxiHq4Sf2tcNqz7PbleaFwreHfhTa9Etrttn9LliC5TWOlP
 kT4SOfO38ld9cSCkOHSIKaeEAAvnIRmXHWzy2h2xxU1OKnKgiYMb+gdcM9mymkzmD4d7
 nLxWqR+rZs0DvlNG6WlHT6x1w26yLxTXIt/m6O051H2ZmS46MhVVQfSs4N/HTcWF6Ing
 AV6ZNbdCrPbiTxc+JojyHq13sT4Y90gEkJWYEO5UBdAp74OyMuIYiBJExf7BOcnZBu79
 prPJSpFvyx9/f3vPW4+fxdw3c1EkY4srzBCyUAACoiYn3HSzpPZzoXwjV4ogFSIGcD7t
 YFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684193092; x=1686785092;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ErmvmWZRvra71DStvOlkrRkcQHRr4QERu5Rb/NcH9Ek=;
 b=Y9Ued/c6aOW6JJtcmiNM8p75q73221IGsgOfXcYe02WNvX4og9T0BF15wkhBmJ2NhA
 1VUaCdMu1YqaAt0db4T0LTEpnH3j+dNM8zCufD8BcPANegFgc0XaXPb3llNadwrRYddp
 WiScduWzez245hS9mLRZUpbdSLaY0RQytDw7KHIaJGYclY2bpg7EEgeGcLKEKSugEygM
 dtG9Pr+iLICSLWJJcc04RDfxqGwEb8+cdpKNaHG3/aJfKJeGJR8Bn2kN6sf8xszHl1+u
 omJ9QRvCwWMSbvF2SiNhRLjKEhEaHxaLlX0y5CqmdMkwRadiZTqynQYUf0gp1b0wg/Dp
 eCoA==
X-Gm-Message-State: AC+VfDxgGkVxWFgcgfI0b8qcCoPraJBwWdZOEiPVLSVSeYQb/9Nfiiwv
 Kll2EYrycSS8Epu2kSI2Nub9RQ==
X-Google-Smtp-Source: ACHHUZ6aVLeCz8/8NT9MndLZRdE0l1uYcSLZSC6h+BL9CvA4LB4RhPnFXx06L8Lr5uJdtyHpwOGerA==
X-Received: by 2002:a05:6a00:a21:b0:62a:d752:acc5 with SMTP id
 p33-20020a056a000a2100b0062ad752acc5mr48912601pfh.32.1684193092114; 
 Mon, 15 May 2023 16:24:52 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9902:96ac:8d8c:4366?
 ([2602:ae:1598:4c01:9902:96ac:8d8c:4366])
 by smtp.gmail.com with ESMTPSA id
 r19-20020a62e413000000b0063799398eb9sm12285075pfh.58.2023.05.15.16.24.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 May 2023 16:24:51 -0700 (PDT)
Message-ID: <9b20442b-72de-7323-ca0b-c66e49a4c4d8@linaro.org>
Date: Mon, 15 May 2023 16:24:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 02/54] accel/tcg: Honor atomicity of loads
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-3-richard.henderson@linaro.org>
 <CAFEAcA_KaYWE+Yh+vberVqk6hV=3R1Xm2V2Po+jrS54i6S1Quw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_KaYWE+Yh+vberVqk6hV=3R1Xm2V2Po+jrS54i6S1Quw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.811,
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

On 5/15/23 09:43, Peter Maydell wrote:
>> +static uint16_t load_atom_2(CPUArchState *env, uintptr_t ra,
>> +                            void *pv, MemOp memop)
>> +{
>> +    uintptr_t pi = (uintptr_t)pv;
>> +    int atmax;
>> +
>> +    if (likely((pi & 1) == 0)) {
>> +        return load_atomic2(pv);
>> +    }
>> +    if (HAVE_al16_fast) {
>> +        return load_atom_extract_al16_or_al8(pv, 2);
>> +    }
>> +
>> +    atmax = required_atomicity(env, pi, memop);
>> +    switch (atmax) {
>> +    case MO_8:
>> +        return lduw_he_p(pv);
>> +    case MO_16:
>> +        /* The only case remaining is MO_ATOM_WITHIN16. */
>> +        if (!HAVE_al8_fast && (pi & 3) == 1) {
>> +            /* Big or little endian, we want the middle two bytes. */
>> +            return load_atomic4(pv - 1) >> 8;
>> +        }
>> +        if (unlikely((pi & 15) != 7)) {
> 
> Why is this the unlikely case ?

Ug, it's not.  Assuming random distribution of misalignment, this is 6 of 7 cases.
I'll remove all markup, as it doesn't enhance understanding.


r~

