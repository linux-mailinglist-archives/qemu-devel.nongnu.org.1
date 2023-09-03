Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A19790A6A
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 02:51:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcbKC-0004Sn-FB; Sat, 02 Sep 2023 20:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcbK4-0004Qu-Hu
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 20:50:41 -0400
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcbK2-0003R0-DF
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 20:50:40 -0400
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-64a70194fbeso1985466d6.0
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 17:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693702237; x=1694307037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h+e5JunHHsMxHyVJi/qGIVflXCU/agUNU5QObTtCk9A=;
 b=W3idI3RpJSNMLBiZ4hzuYkzIv5OomCoK9b7fAgjdkC0lyfhl9ZrOwiHXqlIHkwRwSh
 zbrPqykrK2HS4KOcVHvqK/sClfLkZCQ0ZGMwuTlNhnkQMs3gXRJpOMgfj+EaHf8NxeH4
 PTZtF1V1JMe4p2tv+CsT/CQFfoV+L+zpsCmS8tctLMfk+SYrncHdbqFELBcWOeXhLa+a
 rBkwnEmllRfWxkDlTw5iF9N7gIM7bHkSGneM6f9J8cemU7DiRqS6gxVD7qe4g2xhcjpY
 u4HXM1ycB2YbR5DqTfj7PQMM0U/Hd32/0cVAYLV7DTE0wH2gkp0UJiQixYtjVDBf936N
 JmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693702237; x=1694307037;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h+e5JunHHsMxHyVJi/qGIVflXCU/agUNU5QObTtCk9A=;
 b=QQegZA8leJannTxbU4ocKIlgCZaTQZsBuZ7jYZLrvL28mGhd54EaAXutWAfFS1648f
 UcNsmdNNw2QR3TqQhXIdZVpcEnjLowMQcMXlBH7l8fPFuzz3toP+/0r0XieDih1IrVaG
 bf61Uw/FdMX8QKsPsV3cvepAXRl+edYbGbgT3F4rgf/PgwwYXcnVCXmMr/fCPgCmMT59
 0g282rhhwFa2wOakZSu+Wk8QypxZWQOatWvWrUVasvWXdg+bqkCGYQPRiNxvTFPcUfc3
 uIGzjqh5eqn2Yb1tEXzUnaJ9YP20TE9BmlV34HAVxF03ISI3z8f/am9kXzv0VR/F4cQr
 S6Bg==
X-Gm-Message-State: AOJu0Yx+adUz5gOM4VjytcLCKBhnxpNsiQBKYSF3lts137gVeX/c+pKB
 bc6s0bY7QfXbgvRjg3CZNoSmbp+eNQVwDVwRFh4=
X-Google-Smtp-Source: AGHT+IGQwx5xy0BkEPrKsvoioDonjIkBF6fksHmGEUndRMF8ZNKFcvr6kMH5KFe+s9nttbAnMPRJJg==
X-Received: by 2002:a0c:8cc4:0:b0:64c:60b3:2709 with SMTP id
 q4-20020a0c8cc4000000b0064c60b32709mr5865512qvb.12.1693702236733; 
 Sat, 02 Sep 2023 17:50:36 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 q18-20020a0cf5d2000000b0064743dd0633sm2499761qvm.106.2023.09.02.17.50.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Sep 2023 17:50:36 -0700 (PDT)
Message-ID: <72961b8a-3d13-9ed9-6855-d4e8886844f2@linaro.org>
Date: Sat, 2 Sep 2023 17:50:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 04/16] tcg/loongarch64: Lower cmp_vec to vseq/vsle/vslt
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20230902050415.1832700-1-c@jia.je>
 <20230902050415.1832700-5-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230902050415.1832700-5-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2b.google.com
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

On 9/1/23 22:02, Jiajie Chen wrote:
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   tcg/loongarch64/tcg-target-con-set.h |  1 +
>   tcg/loongarch64/tcg-target-con-str.h |  1 +
>   tcg/loongarch64/tcg-target.c.inc     | 65 ++++++++++++++++++++++++++++
>   3 files changed, 67 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

