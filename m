Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D4D71842C
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 16:06:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4MRg-0000O3-1a; Wed, 31 May 2023 10:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MRe-0000Nj-3F
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:04:58 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MRT-0006ZF-H7
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:04:57 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f6e1393f13so43962435e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 07:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685541886; x=1688133886;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RxhR/DyY8yQi+QxVJygV+w6JwUe1tsx8e6Je+gQnxS8=;
 b=JnPtvT54tEPDZ0xPdYbQVS/E9Hnzk5Rw3mZH779dCefdmBbDHEFNtI/h5WUPKerlV+
 nWXY7ybgEcNXFEI9Wacrd5KTt/cODGfv7Mj6z+mkqUUEKhXWCMlwRJxGnWAoo8gZOSTQ
 zRNZGKnwNeR6yLJL1ycfXQFesrarBbUBSt87jG2stttr9yu4jXpHyzoCgRbzb+779cdT
 EFeHs3m08KRCax2uk96Fmla415vC2wNbLrMeVqdylT1scM2lxvTx7d4wDIMRrkWMBMvq
 SjRyhMeIa2AfIpM3avbuyAymsLi04eJQF9xR2yyNjQ9vX5qfkyeuhs95NX4CpdNCo3ig
 +6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685541886; x=1688133886;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RxhR/DyY8yQi+QxVJygV+w6JwUe1tsx8e6Je+gQnxS8=;
 b=MKGjQohrY7uAwTOYp7KymH0AtPisrWSatljR61t1Ywq1ee58SfJ+j+Z95NLge0CTvW
 Lu+3QZhO3d6MHFZiCikzVkzNRXMcMz1k7YuOZWdmbX/fFnxzZp5RHFDnNKIm0UgljrTo
 12KDnkVzDbdLIrbJndYH2AKfZHHdlboVcJ8iuq6sVg3XxejtcpLYjQrvJkdJ8aH5J3HY
 V76l6E8H2PzUQuuY7KT6mPlH19372KrBh6aOAsZcSpFYxgqXyB0Z0oDsUz7hvSRCTmwT
 Vo27AW016PxSAWHiBMH5MCMy/xnRfWOjWFA4OFRWvpAj3LEAVipHnJ2YW+1RFGaQ17//
 mcSg==
X-Gm-Message-State: AC+VfDybLS+wWkU+TT7AKj48NvsmZNMKBXnuhxme7epCm7994pJiDDwc
 +2WWJLmtzkTdvTL9qDXoqWjLIQ==
X-Google-Smtp-Source: ACHHUZ7/iNGYNS5VL1+XALrhoNwMNg293i7tZ3MQlWLl3CFKLl597UMcJ7UTk+8W+DFSuNI8sNTihw==
X-Received: by 2002:a05:600c:2186:b0:3f7:5d:4a17 with SMTP id
 e6-20020a05600c218600b003f7005d4a17mr3852595wme.4.1685541885869; 
 Wed, 31 May 2023 07:04:45 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 q25-20020a7bce99000000b003f4268f51f5sm21089690wmj.0.2023.05.31.07.04.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 07:04:45 -0700 (PDT)
Message-ID: <128d27a8-a2e4-6dc5-d32d-f1b4a671959c@linaro.org>
Date: Wed, 31 May 2023 16:04:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 11/48] tcg: Split out tcg-target-reg-bits.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 31/5/23 06:02, Richard Henderson wrote:
> Often, the only thing we need to know about the TCG host
> is the register size.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h                     | 12 +-----------
>   tcg/aarch64/tcg-target-reg-bits.h     | 12 ++++++++++++
>   tcg/arm/tcg-target-reg-bits.h         | 12 ++++++++++++
>   tcg/i386/tcg-target-reg-bits.h        | 16 ++++++++++++++++
>   tcg/i386/tcg-target.h                 |  2 --
>   tcg/loongarch64/tcg-target-reg-bits.h | 21 +++++++++++++++++++++
>   tcg/loongarch64/tcg-target.h          | 11 -----------
>   tcg/mips/tcg-target-reg-bits.h        | 18 ++++++++++++++++++
>   tcg/mips/tcg-target.h                 |  8 --------
>   tcg/ppc/tcg-target-reg-bits.h         | 16 ++++++++++++++++
>   tcg/ppc/tcg-target.h                  |  5 -----
>   tcg/riscv/tcg-target-reg-bits.h       | 19 +++++++++++++++++++
>   tcg/riscv/tcg-target.h                |  9 ---------
>   tcg/s390x/tcg-target-reg-bits.h       | 17 +++++++++++++++++
>   tcg/sparc64/tcg-target-reg-bits.h     | 12 ++++++++++++
>   tcg/tci/tcg-target-reg-bits.h         | 18 ++++++++++++++++++
>   tcg/tci/tcg-target.h                  |  8 --------
>   tcg/s390x/tcg-target.c.inc            |  5 -----
>   18 files changed, 162 insertions(+), 59 deletions(-)
>   create mode 100644 tcg/aarch64/tcg-target-reg-bits.h
>   create mode 100644 tcg/arm/tcg-target-reg-bits.h
>   create mode 100644 tcg/i386/tcg-target-reg-bits.h
>   create mode 100644 tcg/loongarch64/tcg-target-reg-bits.h
>   create mode 100644 tcg/mips/tcg-target-reg-bits.h
>   create mode 100644 tcg/ppc/tcg-target-reg-bits.h
>   create mode 100644 tcg/riscv/tcg-target-reg-bits.h
>   create mode 100644 tcg/s390x/tcg-target-reg-bits.h
>   create mode 100644 tcg/sparc64/tcg-target-reg-bits.h
>   create mode 100644 tcg/tci/tcg-target-reg-bits.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


