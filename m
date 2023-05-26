Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E80713037
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 01:05:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2gTF-0000MC-3x; Fri, 26 May 2023 19:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2gTD-0000Lt-Ao
 for qemu-devel@nongnu.org; Fri, 26 May 2023 19:03:39 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2gTB-0005iU-I5
 for qemu-devel@nongnu.org; Fri, 26 May 2023 19:03:39 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5289cf35eeaso1943073a12.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 16:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685142216; x=1687734216;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6d1HxEApZ2y5Rsy25Mk/iPvMkQL/YxKASTcNKv4W/tk=;
 b=M872gMC+5XL4sN4P/ir5pK3Y80BopWKxfGx31RcMdh8Fhpv+eFj0cke8KbWlXoIkC6
 xwXltcVnZ/0wfnWneT2NwrSyRPDE3ZQVNOmRkb/chu62kd82BmqBRBnh5kPXoXFHKR2n
 2QcE3cU9SKdXMH9C5HNKEe6gnSCpTdqKqKkFrXNlDE19JwoI9AK8cLdO1HnJOL+4eQMM
 BmA6iVwhkCtmcpF1EU0LW4wLP0CISh9uxtLWVXuc7bzly/1zeFKdKytA0r/7KH+jUrHO
 QW2gnsMXcLQQdnQjhVdLKD0IMW2NtXRMD5kmiI5voIvsGcMI1Dcg//Ozgrb+BE+2BjVP
 XEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685142216; x=1687734216;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6d1HxEApZ2y5Rsy25Mk/iPvMkQL/YxKASTcNKv4W/tk=;
 b=gHHDAR4XO6EgVSG/F67Q5voDtNXa4M7o8JTfU+a7jTFoFCSWMoUN1q7OUYljpdKiAX
 x2EEH3yHK1VnyroSxuexYnT55LUO7C5R0Fz9X8lnXzPInitxwz1fU8eMKVvtm7tdu4bH
 neE0WkN0f4M/eOWm5KhLJblmrY2norkXWZJr/e9Gy4Yx7O+GxSF3MuxOWOAiwK+gs/P2
 SUAtVOmLeM8Z7Kpv0Ef6QLAlQRcU23pw4eDj7iWjxK/CLQ4E0dGXFFZcM5qCK/ZOTzLG
 wmoQoVb0Kwp+PPkxOu18WZjiP2IGSa5GgYkIWTBW4ZyysP9Gcx6YxCoXx5B7uARtCc2I
 eDxg==
X-Gm-Message-State: AC+VfDx28V9/f1jO84g+KCp0mPL5sHMU7/QBr60IiBhpWYVtNZZ8x9m0
 n9XpB9EVF2Cl/fouRqkkkAEsVA==
X-Google-Smtp-Source: ACHHUZ7gmCxuUzKFdeVsbr0+bxL9XuXh4imB/OOULLF4vf5DMxlbz4VSaBdP/fDK4gChoDa1n7ASJw==
X-Received: by 2002:a17:902:ecc2:b0:1ac:750e:33d6 with SMTP id
 a2-20020a170902ecc200b001ac750e33d6mr708898plh.23.1685142216088; 
 Fri, 26 May 2023 16:03:36 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86cc:4482:68db:2c0f?
 ([2602:ae:1598:4c01:86cc:4482:68db:2c0f])
 by smtp.gmail.com with ESMTPSA id
 y15-20020a1709029b8f00b001ae0b373382sm3714123plp.198.2023.05.26.16.03.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 16:03:35 -0700 (PDT)
Message-ID: <f50688a6-4458-e87c-6009-67e022690b12@linaro.org>
Date: Fri, 26 May 2023 16:03:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] target/s390x: Fix LOCFHR taking the wrong half of R2
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Mikhail Mitskevich <mitskevichmn@gmail.com>
References: <20230526181240.1425579-1-iii@linux.ibm.com>
 <20230526181240.1425579-4-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230526181240.1425579-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 5/26/23 11:12, Ilya Leoshkevich wrote:
> LOCFHR should write top-to-top, but QEMU erroneously writes
> bottom-to-top.
> 
> Fixes: 45aa9aa3b773 ("target/s390x: Implement load-on-condition-2 insns")
> Cc:qemu-stable@nongnu.org
> Reported-by: Mikhail Mitskevich<mitskevichmn@gmail.com>
> Closes:https://gitlab.com/qemu-project/qemu/-/issues/1668
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   target/s390x/tcg/insn-data.h.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

