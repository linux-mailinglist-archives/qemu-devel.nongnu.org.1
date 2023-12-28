Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A056081FB8A
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 23:27:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIyqa-0003rD-WB; Thu, 28 Dec 2023 17:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIyqT-0003qu-SR
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:27:18 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIyqS-00022P-CV
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:27:17 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6dc026661efso1265220a34.2
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 14:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703802434; x=1704407234; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g8V9RtEPfE9a2NowJYXa7h96ufNOaYnkZpMOIOh2mXw=;
 b=f5hfLsV7vkEcNTDEJrciKMSfmFdXIRlHgB69dRudc0ovSZQjivZZruZYj6jyfCR5bf
 4K+Es5XuNK5e37eOCCCeWOS13zD9XrcDqna8FxnZ06TwfaXeAzlqh9rlbkKeTPAyOOov
 FNn3+4GwvF88U7uNPyNgoyCmr7cKFLYqThxmvwass7WwPFUSJ6udyatef0H7k1JXSNyO
 n7cXwQEOd6Q5y4I7xGCPWXLvWqhPK8UbNHjLvQahdsvMiLUkX1J++E38R3jR4RxPKxjR
 oW/OFSE5ZdMH4ekRoKQud09G6TOEMZ5WoQ2/vlCgI8iipUaZjk8SqXSXIWDKWI2FdFQ8
 oK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703802434; x=1704407234;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g8V9RtEPfE9a2NowJYXa7h96ufNOaYnkZpMOIOh2mXw=;
 b=DM9B/fa+VHzLCPfR+eFWdeSjtimliHsq7kiR56fMIEAaz3G8Nl8p+2Enq5GtyKctW5
 tecCik6sboo1jsjitbGZKQ+nfQHPDIN2b8A11Cx2qYPXcBP5aIrvYoC80gsJ8tPcxGr1
 mNB7/EZeAECrf4Mkx0BXy/9DK2iFoi9aCQsmVMiaAVCb+Xi0PYVkk9PYsvpWbkKocbiD
 lI7H0Tpn9G9ro0B1Dyr9wlggaDHMTlbe3hArU34qzOvIUbgGFVQVPdQscgIT5BOOniR+
 BpaD8UhxyDjebaJxe3hwDGS76wU/sU2kwvhrD86fQLBd6S4fdx/muoj4HFfK3og5mLzd
 BAhA==
X-Gm-Message-State: AOJu0YxCzqqJh3fMw87sLiatRPtYJ4kMnrH6p7yWRc4ncvMQae9Tko08
 0qa+rGRg+zM2F3PE8mLZyF0JFY9wlWJjzQ==
X-Google-Smtp-Source: AGHT+IF7ZUgNlMjO4hHgt0zpM435VRAQdec+RQkueX1opcTSRp7kHegGX2ibjgSoEweV2s8wDQsE2Q==
X-Received: by 2002:a05:6830:1541:b0:6dc:1ce:1d92 with SMTP id
 l1-20020a056830154100b006dc01ce1d92mr3288752otp.42.1703802434584; 
 Thu, 28 Dec 2023 14:27:14 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:324d:cbc2:5f8b:3a9d?
 ([2001:8003:c020:6900:324d:cbc2:5f8b:3a9d])
 by smtp.gmail.com with ESMTPSA id
 b16-20020a63cf50000000b005aa800c149bsm13411244pgj.39.2023.12.28.14.27.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 14:27:14 -0800 (PST)
Message-ID: <2db42636-7c62-4338-b7ed-b1d7eae83451@linaro.org>
Date: Fri, 29 Dec 2023 09:27:09 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/22] target/i386: prepare for implementation of
 STOS/SCAS in new decoder
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231222181603.174137-1-pbonzini@redhat.com>
 <20231222181603.174137-19-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231222181603.174137-19-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/23/23 05:15, Paolo Bonzini wrote:
> Do not use gen_op, and pull the load from the accumulator into
> disas_insn.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

