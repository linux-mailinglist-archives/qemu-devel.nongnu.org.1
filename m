Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C6B729F98
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 18:04:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ea6-00087E-Tk; Fri, 09 Jun 2023 12:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7ea4-00086D-EX
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 12:03:16 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7ea2-0006zy-Pf
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 12:03:16 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-656923b7c81so1604921b3a.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 09:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686326593; x=1688918593;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EKq5/zYXjgqKyg2tR+7n9nw3iU5rjMdY8wAwlEd2Chg=;
 b=oEpQ6yw0F0Yt33h4EmO9Y1ofIFMYNlMSW5n5qbJHIW3O+OsqKpq5/67xRowQ+QIe7G
 oE6bnNkwFVDkO/fyaG0KtgS1DknSAWhVhLTD/cYtx0TTU2EZdCehIifAH8EsnazEWyrD
 IAYCzdIRhEN5RS8a6kc2VAIX1Qmb/iEKfxEa6Ugsichz24KjuMg/4sZEpi4iBjYskXXo
 WTSnoPAJVUJs7H7pUVFauHQoiwhRxSkojvrT22cN0q6VuearQ5WJE+A+XFI5utfRdQlv
 UZ5xFFhpbrZ4qVwTuEuSQpvh/K9MbmjFob+sQceem0KVOPeS+oB3ta4q2lT3HoLjQNbx
 JN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686326593; x=1688918593;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EKq5/zYXjgqKyg2tR+7n9nw3iU5rjMdY8wAwlEd2Chg=;
 b=hKd/phCzd3gRjDa47RXnw51j7m8vFrPcJIuIXOYHUl1Oc6V6ZdLEI+s0Tfoj5Z2eJ1
 9rqBAm3evWJQxGKo5EapqXlme9CF+xPb1yC4xDg8i0B2fUtN0rXbYyaaiRanq7XuPdm0
 rbyBG8X1E69fM0IOVAl2wlXksKAN8cZQyX+TBmy6pf+k6ipWCcPkyKc+jIhOyeYKxnJH
 1Qd5RPLTzuu8CEihWm7p8gHezF995MhSS8CAzr26x4RWqUTDFZOK/AcIvs1cDFg4Fjlc
 CmDg1Cr8SkR80Hw7XFawAC4gAPdk5EUEpVC6I5hQ/5hyWjw9yZlgBMAShfqfo0rpdX20
 oJUA==
X-Gm-Message-State: AC+VfDxnaITfrVFtU0tJtdjHstGGxL9lyhzspHIvwDFDojm6QtOq1SJ+
 cNpdVxIArwep8akgROytinVJjg==
X-Google-Smtp-Source: ACHHUZ6uE+z5jKOBr/z4WW+RYOTzhWNUIqy6dVC0Y1o2PVDbUsgob/dlN0YK+6EIZD5OoitT3VkYJw==
X-Received: by 2002:a05:6a20:3d26:b0:106:c9b7:c932 with SMTP id
 y38-20020a056a203d2600b00106c9b7c932mr1370952pzi.1.1686326592666; 
 Fri, 09 Jun 2023 09:03:12 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:20be:c4cb:f609:8cca?
 ([2602:ae:1598:4c01:20be:c4cb:f609:8cca])
 by smtp.gmail.com with ESMTPSA id
 128-20020a630686000000b00502ecc282e2sm3151831pgg.5.2023.06.09.09.03.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 09:03:12 -0700 (PDT)
Message-ID: <8343e06a-12bc-b9b1-75ae-79d69fb2ebac@linaro.org>
Date: Fri, 9 Jun 2023 09:03:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: arm: couple of finalize_memop related oddities
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA8CsmTHXDf80fP_wAXG8_5J-AUeJqMRH5Nr23cF+ST8TA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8CsmTHXDf80fP_wAXG8_5J-AUeJqMRH5Nr23cF+ST8TA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 6/9/23 03:47, Peter Maydell wrote:
> I noticed a couple of finalize_memop related oddities while I
> was rebasing my decodetree series:
> 
> (1) in disas_ldst_reg_imm9(), we calculate a memop, but then
> when we call gen_mte_check1_mmuidx() we don't pass the memop
> as that function's memop argument, we just pass size. Everywhere
> else that calls gen_mte_check* functions passes memop. Intentional?

No, looks like a bug.

> (2) disas_ldst_reg_roffset() and disas_ldst_reg_unsigned_imm()
> use finalize_memop() for both vector and normal register
> loads/stores. Should they be using finalize_memop_asimd()
> for the vector versions?
> 
> (3) disas_ldst_multiple_struct() and disas_ldst_single_struct()
> use finalize_memop() even though they always load/store
> vector registers. Should they be using finalize_memop_asimd() ?

Yes.

Everywhere that uses CreateAccDescASIMD in the pseudocode should use finalize_memop_asimd 
for clarity.  (If size is never 128-bit then it will be same as just finalize_memop, so 
some of those places were not actual bugs.  But definitely unclear.)


r~

