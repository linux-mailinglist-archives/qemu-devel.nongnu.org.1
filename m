Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A25FB745A74
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:40:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGyK-0004o0-QH; Mon, 03 Jul 2023 06:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGyF-0004nV-5I
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:39:52 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGyC-00064C-OG
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:39:50 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbc12181b6so47292275e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 03:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688380787; x=1690972787;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PZo/lR7wmWVemZe2PpxDbZs9pyaBFzVGuifmTW1w/Oo=;
 b=dW1NHCXwtf/4gevXj8tpypAAR+3m7FpbKFHSG6sM4RnW6BvLPh2eLn0uS5wlrZ+0HS
 /fnPW/ayOk3ArJct68MvIgGCvWDlTHW5ReL48pySXhEFxe1aVxMb4Y5utymQzPOaAJNN
 PvsvymtMCOsgEw870vASTiYxbTjMLGyK2uxVUnXcLFa7MjhZZ2Z1EP6djNaQPm1ai3tE
 llfBl6Vo4FR+lCJ8LcuvJ8pf7ONZQvbToUua9hBbIEA+n1FnkA9g4iE47Lvtnko81WSd
 ZRHZ1bFRIkY1V/CwQr823vpNn0s2J1/enEJqikOF8JsujJuYCU0K+orjizNccA3M4/mI
 QT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688380787; x=1690972787;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PZo/lR7wmWVemZe2PpxDbZs9pyaBFzVGuifmTW1w/Oo=;
 b=D5g1uQ7EYUgfJFJ//7I8kc3Dm5/rn5wkP4RFoXWAdd4Ks67toemLYO70hrdoTFJLET
 kfB9dJn2h7/9h+HJWap4UgXEPMzLt3eDvIwgn4ZTUsNArZswkjlsg3bRBe5gvgKD8xf/
 B84uWDCMTf2LElkVPyDsRI0i69PfJnXvaRm/3jgXSmLslJtLm6TxQNzOGaidnJzNOZvc
 NLJ7ICzfCtrt0bDGFr4gG//KC+KRVjpdQl+PAv99wjYRghO7qp9K+mmtxnqODqBv0WzI
 WtRs7yBxa+kxetO4VM3T5eU7C60a1Jn/75OlvIiuWG813Tkk38Bh276CQG39Ew8xa/rc
 B9nw==
X-Gm-Message-State: AC+VfDwmAtpbNSBbMltliBX2wfC2CUjeJQpfweVUgtlGJJREW7aXMnDz
 pqwoQ73azBbP9n7JuAjp9Fljyw==
X-Google-Smtp-Source: ACHHUZ4ZHHAz5YlkH+wnptBDHirI9vPu10ufHjbY4FlvfwUXTV9++6/JtkK2B/SrRY0lZnVDYFAdAg==
X-Received: by 2002:a7b:c8c5:0:b0:3fa:99d6:4798 with SMTP id
 f5-20020a7bc8c5000000b003fa99d64798mr8825057wml.37.1688380786882; 
 Mon, 03 Jul 2023 03:39:46 -0700 (PDT)
Received: from [192.168.1.25] (91.232.79.188.dynamic.jazztel.es.
 [188.79.232.91]) by smtp.gmail.com with ESMTPSA id
 z11-20020a7bc7cb000000b003fbd2a9e94asm5298921wmk.31.2023.07.03.03.39.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 03:39:46 -0700 (PDT)
Message-ID: <771e8e39-9d49-411c-68e5-81e3b6141fe8@linaro.org>
Date: Mon, 3 Jul 2023 12:39:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 09/24] linux-user: Implement MAP_FIXED_NOREPLACE
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: mjt@tls.msk.ru, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20230630132159.376995-1-richard.henderson@linaro.org>
 <20230630132159.376995-10-richard.henderson@linaro.org>
 <87y1jxiajm.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87y1jxiajm.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

On 7/3/23 11:51, Alex Bennée wrote:
>> @@ -544,7 +544,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>>           }
>>       }
>>   
>> -    if (!(flags & MAP_FIXED)) {
>> +    if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
>>           unsigned long host_start;
>>           void *p;
>>   
...
>> @@ -608,7 +615,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>>                   goto fail;
>>               }
>>               retaddr = target_mmap(start, len, target_prot | PROT_WRITE,
>> -                                  MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS,
>> +                                  (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))
>> +                                  | MAP_PRIVATE | MAP_ANONYMOUS,
> 
> I thought we always MAP_FIXED because we've already jumped the hoops to
> work out where in the memory space this allocation is going.

We have not, no.  Not here, anyway.

> IOW I thought the MAP_FIXED here was an internal QEMU implementation
> details rather than reflecting the guests wishes.

As I read it, MAP_FIXED was here because we'd already checked for it in the IF that I 
retained above.  But now we're checking for 2 things, and must pass that on to the recursion.


r~

