Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AD0747C48
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 07:15:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGuqM-0005UE-AW; Wed, 05 Jul 2023 01:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGuqI-0005U1-Ls
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 01:14:18 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGuqE-0000C5-C3
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 01:14:18 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbc244d307so74138005e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 22:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688534052; x=1691126052;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XYFksPaw0oKlAzw3IfrSE54sJ24AakA6BmtogPcwkFQ=;
 b=ijw5Vf+RbPaXE2GN7G/0WEG9u3N9x690aCji4P8bwkSwHkUbUj6pMKTJZiRSFfkBuq
 4/P59W/AVusMJd//8d1byYO0AzMiixGgBAt2BBIVxmlifRF+wKOcKv54mGR4zcPrSoz4
 GjkB+ViBNE30k8zxAIS4312mIn8FaOzeax5jrADc8bOtYQa0jvk/bnlkB+679Tpd7HSM
 hRdqTgtw/X0wBSQQWJpUZOIW9MCFUfJCiH2YqfDPgTM1RlZ4sm17yV4s3ufJXUfTDwSd
 yGbYA02E+WWBYQ3+S0G7kPv7g3NcirlEvmw0CDcDq+wGtZ9SNqUyp9QZD14skc9iJ3T/
 HBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688534052; x=1691126052;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XYFksPaw0oKlAzw3IfrSE54sJ24AakA6BmtogPcwkFQ=;
 b=XkGT8lZKllkg3/EcRiBsQt2zII8XjRClOioq9uhefNYVvEUNFsOcK8hNSbG1u8oM/l
 FS68IKaV/R9LDVD1F6F2U9jZUfbjThrbijzx7jj5zAT2sp/IKjGMl4bnqr5VaZFgD5I0
 RRPDcZRODF8xSevpiCJx+0g3ofMSKzIhCqPPlN8QbjwzJIM05h2OswKPJuevps3/vLtN
 4GTOeSjcLKcDh1XgXo0aW9dSOihY5Wm1mvAYuC+6fDrqBAtlkDGEk6fsJhIoG+eeWYaq
 6khLUigZ0fobouZioE2qdsMhMmXlSdaVptwyWtR4u7cynhXo6Hu3CXM6LlXsgbbSScaP
 bUag==
X-Gm-Message-State: AC+VfDx0yYvEAb2EL1cruyOc9IlhX9tDyyYRKgQYiofN92Pz3uS3jSq2
 IjVNR8nKevlCY4LTLlZpMpU6nTiNxUF8cD/X9xC6Rg==
X-Google-Smtp-Source: ACHHUZ4WhWx7hzgIZDnp8NrKkHTIEox8Bk75D4kUusBy7DNc2LsdPrP5oBjr79qv08UoYrBW34QsTQ==
X-Received: by 2002:a7b:c315:0:b0:3f4:d18f:b2fb with SMTP id
 k21-20020a7bc315000000b003f4d18fb2fbmr14630225wmj.8.1688534052627; 
 Tue, 04 Jul 2023 22:14:12 -0700 (PDT)
Received: from [192.168.1.25] (91.232.79.188.dynamic.jazztel.es.
 [188.79.232.91]) by smtp.gmail.com with ESMTPSA id
 n5-20020a05600c294500b003fbc0a49b57sm1001932wmd.6.2023.07.04.22.14.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 22:14:12 -0700 (PDT)
Message-ID: <d2142c8f-4ae7-ae3e-da84-7d7ac376457a@linaro.org>
Date: Wed, 5 Jul 2023 07:14:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: intermittent clang sanitizer failure during 'make check-tcg':
 null pointer deref in IntervalTreeNode
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA8AzdKw9BH_6757U-P3zCWTdyiVCAa7GB8wcjOF4wdE3Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8AzdKw9BH_6757U-P3zCWTdyiVCAa7GB8wcjOF4wdE3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

On 7/4/23 18:20, Peter Maydell wrote:
> If you build QEMU with the clang UB sanitizer and do a
> 'make check-tcg' run, it can fail like this:
> 
>    TEST    vma-pthread-with-libinsn.so on aarch64
> ../../util/interval-tree.c:751:32: runtime error: member access within
> null pointer of type 'IntervalTreeNode' (aka 'struct
> IntervalTreeNode')
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> ../../util/interval-tree.c:751:32 in
> 
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> ../../util/interval-tree.c:751:32 in
> make[1]: *** [Makefile:181: run-plugin-vma-pthread-with-libinsn.so] Error 124
> make: *** [/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/Makefile.include:56:
> run-tcg-tests-aarch64-linux-user] Error 2
> 
> I only saw this once; when I re-ran the test passed...

Hmm.

The 751:32 reference is "left->subtree_last".

Three lines above we checked

         if (node->rb.rb_left) {

but then read it again within the IF

             IntervalTreeNode *left = rb_to_itree(node->rb.rb_left);

I suspect a normal optimizing compiler combines these two reads, but UBSAN does not and 
thus the check and the use race.

On the to-do list...


r~

