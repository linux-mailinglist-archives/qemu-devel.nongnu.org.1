Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0FE74AC7A
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 10:06:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHgTP-0000Du-1t; Fri, 07 Jul 2023 04:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHgTI-00007H-Gy
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:05:45 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHgTH-00070J-1P
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:05:44 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3143493728dso1605405f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 01:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688717141; x=1691309141;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JNWJ6qTkIaBtPvohxYHXruJi0qfMpcHpbdOP6aVByLw=;
 b=AAgI0l2OotGpRpFQdHooudWktc7+FhpmEbF9dJwZnmkGeQQOYJIzTdeaplyLwNHH+A
 YE/pnqjSGKdJVm/2M57G6ZtcTPSJqaQN2AhtJ9npaXVhhlUgMvMMQNzlnWOsTVOqxjwM
 4jsAFYrsRhuUCHyYxpASwqA8OZmGzxAqPenf1dhXPGBUIQPAw8tqNUtTfwTeMGMgu+mz
 P9GbbSxgZ+gJ2PpWeKV6A2fxA5e74cJOKRABO0WH2V7zjlJBC0t46RPNMZUYk8fF4Q9+
 JjhPB2onELbjPGXb0oExUmJ5OBkIoQSxBhztF4FwIpImEqLn4newqdi8zMz5bZB5gqbo
 Gpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688717141; x=1691309141;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JNWJ6qTkIaBtPvohxYHXruJi0qfMpcHpbdOP6aVByLw=;
 b=Q1b/2szNheJdtVrXqp2j3uO40bITvIlOC0mOl3KTlQBZQy9Uhe0rMMcio0I8llaUpm
 yCW7+UkzCvFCdKu26A47TgktVNLJl/BNE1rOiXgmWSJaphBNlGUA5ikJJo7xlWsC1Oy2
 dFcPbqfaRo13k5P83uNFBEWyMI/mXiC7ItwwQksNP8CmPe9/iBW8We2QDZTpKYahUtYm
 WrhNmO8tgDw9DrMetOVHyiGzJI6eyj/DiKf+WMJhrJ4acQMxvmmNEFaacw/dV3gRnMWK
 UGOH5lBtKouw5Z8G/nZUIfAE0S8wTj5PDx/5My+5IJnrf8xDmouGbVgEBuWJAaQomtSo
 WFQQ==
X-Gm-Message-State: ABy/qLYmwqSZaQEwRd3XmW+DvrT0zS5Xc4cqKl2mVX2J17qssXc9LWSF
 i3ef5Gu/4926Y4Uq1MzXyCKg5ZFZG+rnMaymf4g=
X-Google-Smtp-Source: APBJJlFJTPbYP5gxybMK5y0TSVyImah5c9qVn4PxDVxfXFxP5F83v3DHqQmBuJ0qGg1yKB2wbOSwMg==
X-Received: by 2002:a5d:654a:0:b0:314:3aa5:d285 with SMTP id
 z10-20020a5d654a000000b003143aa5d285mr3472205wrv.11.1688717140718; 
 Fri, 07 Jul 2023 01:05:40 -0700 (PDT)
Received: from [192.168.82.227] ([91.209.212.56])
 by smtp.gmail.com with ESMTPSA id
 b8-20020adfe308000000b003143c06135bsm3774503wrj.50.2023.07.07.01.05.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 01:05:40 -0700 (PDT)
Message-ID: <b61fedbe-b7d8-e354-430d-db593151912e@linaro.org>
Date: Fri, 7 Jul 2023 09:05:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] accel/tcg: Always lock pages before translation
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: rjones@redhat.com, peterz@infradead.org, arnd@arndb.de,
 naresh.kamboju@linaro.org, anders.roxell@linaro.org, daniel.diaz@linaro.org,
 ben.copeland@linaro.org, pbonzini@redhat.com, Liren Wei <lrwei@bupt.edu.cn>
References: <20230706170537.95959-1-richard.henderson@linaro.org>
 <20230706170537.95959-3-richard.henderson@linaro.org>
In-Reply-To: <20230706170537.95959-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/6/23 18:05, Richard Henderson wrote:
> +++ b/accel/tcg/cpu-exec.c
> @@ -531,6 +531,10 @@ static void cpu_exec_longjmp_cleanup(CPUState *cpu)
>       /* Non-buggy compilers preserve this; assert the correct value. */
>       g_assert(cpu == current_cpu);
>   
> +    if (tcg_ctx->gen_tb) {
> +        tb_unlock_pages(tcg_ctx->gen_tb);
> +        tcg_ctx->gen_tb = NULL;
> +    }

Ho hum, fails for user-only, since there is one tcg_ctx and this cpu didn't necessarily 
own it.  Just a slight tweak needed, I'm sure.


r~

