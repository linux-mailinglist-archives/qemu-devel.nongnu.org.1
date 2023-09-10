Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6202A799C36
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 03:00:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf8nm-0001PD-BO; Sat, 09 Sep 2023 20:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf8nk-0001MI-JV
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 20:59:48 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf8nh-0005jU-Dt
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 20:59:47 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1d5a8cb70d3so197435fac.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 17:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694307583; x=1694912383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hcz/FRXj/OqHEouAC/Ou6n3mo7ASSWU/Z8sT86xS8r4=;
 b=PlA8dhOgjztzaNSOvMJ6/wuzirB8dEYGpKVCHy8QVYfEYLFFr1cG7LZvr3Qh3ISrmX
 ieMoHQx4GAOBsrGHoHrra2xZyMWJ0rjkCbdBcknZFqM6NJsTBBjuIuFfGRwe7tEecFpx
 L7xk1NiZAQtbiZbvEAJD5efxP4jjGRlPaljQef3az3hGwvHkNrxnwFX2+sEpHk0Yq43L
 FViD17zg4pybkn8KcYYf46pL6itSVbCVEFpeIMl/CHLUotnH5y0hd+Gf0G/q6RmlGvxC
 gNQhlpEi36DIUSVY7x8693Q0QMk3gx6mt/sAfMz8IcPdIW5YlQN1HQaOsGfiTGVlAhmG
 hbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694307583; x=1694912383;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hcz/FRXj/OqHEouAC/Ou6n3mo7ASSWU/Z8sT86xS8r4=;
 b=a1DzNhUx/inz0TCY+DCKCjWdQvYNal8ePfpCYSV/WNyG9SYUz9kiz/8hiwMQgkHpVx
 +06deD9x3Zou96pS4Rq8bc4JULuVFnlDiTunzzWJwFvdIBju3xSi7+F4EDTWzHFzmkq4
 60X3+cqpG1nfzZ55UvP2iJuMcLqnVOFcd5e2+x4ygXjIODtiASqPq2WTGF2pNgoSFxRR
 Fn7qudlHRe+WWnFC3An6Yf5t0c88i+96OnsCd5v9jBJjxmUXz/i/yUHDUIXutmf81VmY
 bdueFRMB7aapsGeuXt4nxhkzBOgc4OGTWHU2OO4VcaJYrePGk9X6p8TbyHv/A/W/rFVW
 Tg8A==
X-Gm-Message-State: AOJu0YzjWDx2r9zEpXtynGCNF+CLEu6rQtY/fBvEj/90kHTVdpUqCCca
 URjRDC5gip2sG3M+3yo/rsip+Gy7JHp3ERdK2AI=
X-Google-Smtp-Source: AGHT+IFuXeOscF+/vGExE5//cF+KxhMJQGJP1gwaVry8BjmMyfk8CwUDWLUE/aWPXW7cubnRXwFHKw==
X-Received: by 2002:a05:6870:6389:b0:1d4:d016:22a3 with SMTP id
 t9-20020a056870638900b001d4d01622a3mr8341245oap.7.1694307583057; 
 Sat, 09 Sep 2023 17:59:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 gc7-20020a17090b310700b0026b50d9aee6sm3300959pjb.25.2023.09.09.17.59.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 17:59:42 -0700 (PDT)
Message-ID: <e37c3840-812e-7283-7877-f723895ebb13@linaro.org>
Date: Sat, 9 Sep 2023 17:59:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 07/57] target/loongarch: Use
 gen_helper_gvec_2_ptr for 2OP + env vector instructions
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-8-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-8-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/7/23 01:31, Song Gao wrote:
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/helper.h                   | 118 +++++++-------
>   target/loongarch/vec_helper.c               | 161 +++++++++++---------
>   target/loongarch/insn_trans/trans_vec.c.inc | 129 +++++++++-------
>   3 files changed, 219 insertions(+), 189 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

