Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2E28A3384
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Apr 2024 18:18:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvJap-0000Qd-M1; Fri, 12 Apr 2024 12:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvJaj-0000Pw-KL
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 12:17:33 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvJah-0006aJ-H7
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 12:17:28 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1e2bbc2048eso9397655ad.3
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 09:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712938644; x=1713543444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=USoFStEqNXqZnRqMSDJ7Q4ksTEbQBxRG0TPfOFM2CtY=;
 b=Tc8WBqkLIcT1ZsKFCTg2/7cD1d1p9c/h9HHohi8tZqqqyM75jmtuI1in1wU2pvsxzk
 VGWJUseUyQV/BjtVSH2oJ7lqaIe3PbJG2CDj9nFjk2+gpKlOFpb4Jtpy3nC7OrdQKcMr
 6bTUaIT8GeID0wZVM7zr8+6yX3gMpMGzPAycGElDK6/dx24pN14u5UBRNr9jAVWBq3/k
 wawI9xYIWbaovWhnJN27fJ+QkiXsKyIuMbniuJUJ4UU61M1+nnW9fj9hVjfDlYv6y5yr
 OXWq6UnRepTCmy+RjFtHCfrZY2XH8Y2ptL3sjXwKpUxiJLflq3zrDUajsQxqeUg5QNZR
 +8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712938644; x=1713543444;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=USoFStEqNXqZnRqMSDJ7Q4ksTEbQBxRG0TPfOFM2CtY=;
 b=tZbaTfFdyQam3JSGYEs3FZw6z6VzK6ox6n8yeebEWH2m5R4QrpWWOrXflY1WdfvDqg
 +qdDH4AM+Is8qqL/hme4cRiBwv+VHMp9UqijGESgb3prAyOCj+m0S6W9aQNNIINJd6Px
 nNI1RkLlGmu8RuBAlPEVptuYbvlppzu1oWK0/Vwm2SKW+XK/i7PZMw7rU1mC3P1zCyww
 UeKzsf9tZg1vQxSfGKpixLv6o346uNZIBcn8saMF8CSUbRkCaJ4+sCC6TyUIIYdDxDUb
 +X5uiYlrc00WBso+z6X811ju8tngSj+vsoyYCfKB5jjvNeA2IZwP06Sp86dVkAXYo6Xm
 T27g==
X-Gm-Message-State: AOJu0YwWkK7Ft9oD/+mFn3C4qBZSQIjrAoBllc2Ww8Fp1QSEhkewFSTK
 AXcoYVwSSEn585WVd/boZSB1Mfw+eVW3PPB+yHJ1amJ7omzHk9itPpUsE0pPjts=
X-Google-Smtp-Source: AGHT+IEodbjFP7FO7ia+7vCP80/7g4ic0sKRsN1Wcb1qnj2wATUvmhVgvP70/O+a8lPQR5o/E0NHDA==
X-Received: by 2002:a17:902:b287:b0:1de:f91:3cf3 with SMTP id
 u7-20020a170902b28700b001de0f913cf3mr2573948plr.55.1712938644386; 
 Fri, 12 Apr 2024 09:17:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a170902f54b00b001e420abf8c1sm3169196plf.165.2024.04.12.09.17.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 09:17:24 -0700 (PDT)
Message-ID: <21265e46-637d-46db-81e2-c2ae948e312f@linaro.org>
Date: Fri, 12 Apr 2024 09:17:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/51] target/arm: Add cpu properties for SME
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20220620175235.60881-1-richard.henderson@linaro.org>
 <20220620175235.60881-18-richard.henderson@linaro.org>
 <CAFEAcA8pQ9dZXh1sghqGmuVRubFkn2HQpRnzDSGQpkUSKGg+jA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8pQ9dZXh1sghqGmuVRubFkn2HQpRnzDSGQpkUSKGg+jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 4/12/24 04:36, Peter Maydell wrote:
>> +  4) Disable the 512-bit vector length.  This results in all the other
>> +     lengths supported by ``max`` defaulting to enabled
>> +     (128, 256, 1024 and 2048)::
>> +
>> +     $ qemu-system-aarch64 -M virt -cpu max,sve512=off
>> +
> 
> I just noticed this while I was trying to understand the
> SME and SVE property documentation -- the example 4 here
> is in the SME property examples section, but it's changing
> sve512, not sme512. Is that an error, or intentional?

Error.

> In the SME section we say that all other lengths default
> to enabled, but in the SVE section we say that the
> smaller lengths default to enabled but the longer
> lengths are disabled. Is:
>   * the SVE part wrong?
>   * the SME part wrong?
>   * the behaviour deliberately different for SVE and SME
>     vector lengths? (If so, we should say so explicitly to
>     highlight that to users).

The behaviour is deliberately different.

See R_JRCSH and especially I_FQKMN:

     For example, this means that the set of supported SVLs might be
     discontiguous and might not start at the smallest permitted SVL.

whereas for SVE, the implementation is required to support all powers of 2 up to the 
maximum (see e.g. the text for ZCR_EL3.LEN).


r~

