Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88067777EAA
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 18:56:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU8wX-0008JJ-2t; Thu, 10 Aug 2023 12:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU8wV-0008Iw-F9
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:55:23 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU8wR-00040k-TJ
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:55:23 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-686efb9ee3cso1022628b3a.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691686518; x=1692291318;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8JLrsi72dJaTqD97zah1hf72b4FSENd6+9ETRpnla5Q=;
 b=q0ryHXKNCcr22ezNw6NtoiLbaDgXGAzHKJ9/GSzOsMYndZcSp8W+jkkewTG/r53Ju+
 sXPn46nenuxlfqfb5nOPVGnU7Zs/P5uAdontyZn3vwgQBgOnpoXW2Cm471dqf3OatYZT
 8+14Q7oYJkJ3++4PFVlqcXGCI7WEs8rBaipBhUZFOTS+GcjGirvHtDzmHcn+JLHLwF26
 1G8c6GFKmWYWRSUR/BYYpmyvGjxqQ4c5Zj25XtAwNN61Pr4EsWvScqg6EjaQI6cGwygw
 sVPK0N9s66byBbc6FDWY8EOG0xkEb2ffVKRmKulUXIha3cRlpyVAszfe9z91HxBXMUcC
 zhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691686518; x=1692291318;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8JLrsi72dJaTqD97zah1hf72b4FSENd6+9ETRpnla5Q=;
 b=IXCsf6c/F1Kgx8WJk7nx9r0F/ULd7yCImG34mef0Pl0Ui5RSYKOfj+HaC5ns131F5q
 /LyfjhbuEVYiAYBhQP/4HUsxzp6zu3a//6ABTfomvYLqZib+6UyFQ1liVweh1NUl5z+n
 FyozaBmlBxrVrfqCucPGaaAUJ2IkEuXnGfnpCYYEX7k6C3lDjSqkPr/jwUGKF9NJCRIT
 BSct1tagEOik1uxKvovtfbQLOqAPHQP5BbA1T3hW4YTlqrc+QyIInkUgC01bA0jlHxtn
 lXExXBYTaSv8Nl651gLFA/bbmVXIbFR5q0gWv6MdBH4EjSBIzKXNfWM9fiI1w3avFd/N
 yRgw==
X-Gm-Message-State: AOJu0Yy6VSNVvo50OtLVKlpRUHkfqcgzfr/4tERzuOWYUc895C34Juzs
 OWy1uG0YLCLoTFCSuDNtWKNdSQ==
X-Google-Smtp-Source: AGHT+IH415Ra330Jz3myJREplW7JYGYKyJmrd+XPHdKLj2evW2fF5axCjyAp8dGh/2fi8AEcdmxsZA==
X-Received: by 2002:a05:6a20:bf19:b0:138:1c5b:24c3 with SMTP id
 gc25-20020a056a20bf1900b001381c5b24c3mr3191086pzb.49.1691686518281; 
 Thu, 10 Aug 2023 09:55:18 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:9e4d:b830:d4fd:9164?
 ([2602:47:d483:7301:9e4d:b830:d4fd:9164])
 by smtp.gmail.com with ESMTPSA id
 g5-20020a633745000000b00563da87a52dsm1774337pgn.40.2023.08.10.09.55.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 09:55:17 -0700 (PDT)
Message-ID: <6dbafe59-f7ce-12f6-e8c7-eefc7665f598@linaro.org>
Date: Thu, 10 Aug 2023 09:55:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 12/24] tcg/aarch64: Implement negsetcond_*
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
References: <20230808031143.50925-1-richard.henderson@linaro.org>
 <20230808031143.50925-13-richard.henderson@linaro.org>
 <CAFEAcA9dqnaqGrLz804UB8zHSnbCEWwhv1nzvdt_j0CS3=mCSg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9dqnaqGrLz804UB8zHSnbCEWwhv1nzvdt_j0CS3=mCSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On 8/10/23 09:39, Peter Maydell wrote:
>> +    case INDEX_op_negsetcond_i32:
>> +        a2 = (int32_t)a2;
>> +        /* FALLTHRU */
> 
> I see this is what we already do for setcond and movcond,
> but how does it work when the 2nd input is a register?
> Or is reg-reg guaranteed to always use the _i64 op?

For reg-reg, a2 < 31, so the sign-extend does nothing.


r~

