Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA28B7D73DF
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:04:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjB9-000361-MH; Wed, 25 Oct 2023 15:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvjB6-00035i-Ao
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:04:28 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvjB2-0006wu-9V
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:04:27 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6b36e1fcee9so51470b3a.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 12:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698260662; x=1698865462; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EvioMEM7/ohEYLjSNwkzhpq7sKHkjjMUIbQK26PVWao=;
 b=S5ez/XoOnCeBoV0r/p+CbamRPu53ZwOh/SPhUPSSVQkZHmv+zr4NpoWLMEzB4+wguX
 ffc0KwnyKttH3WvPDPboryIBswkQ0DHvNO9W8MKCKjyZDQaDUAHwbMCdoiRtzxrMvT/L
 V+7+QRkzBxImLMZwCjHVmYzhzi/BKEqWksuagB6T3FgHUjKoiWo+mKCc31LY4K8TSyiw
 4+VRxzM0kL6NKpduG+2kkxPhFoQTIXZc87qZqPn7kfqH2gp4YZGC88AtS1il7IruASXm
 JENcQJBkyX6VSDA9ql/qoPmj3j4uHl+txzScRJh7GmVtSdCd8uD9PMkn/BreVjGKPoo1
 9VUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698260662; x=1698865462;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EvioMEM7/ohEYLjSNwkzhpq7sKHkjjMUIbQK26PVWao=;
 b=lXR2vDBc9kZsS/StJJbNyNLlxCmR+8iyyE4B0Oxmjm5T/FPEKFmxY/DRBY8zeN7wWu
 4I/Vc4piNuNE8qM8+0wPIWTVVZVpb7eG2nrqqX0svCx4rQH+9ZT1qHA0y3L2CAL4V0nj
 vfJXG21GpFEx0iAGT6ayAD6PZ4iyidcz3RcUXkJRacClxrBJeAN2j2EYYCzHzfaTIPBb
 o/r6UD/ifAC9zjW8cesVn6FqQFZalyfCYDdF2GPbx5Pj5alQ8S4T94YX6B3tycVmNQGQ
 09MOqNpSC1DiurUK5yE6DVkYEoapfJ30lTR9ouPPp/t1jFsJvBoR10ziRyf2/aObd4pV
 8sfw==
X-Gm-Message-State: AOJu0YykY9bv0ItbUUNAHqwrEh3MP0clYmnzlSpycokBwtlvQ83aI/gT
 zzTFfmPNtwHh5EkdkB5eqioH2kQARWR7b7hFQLQ=
X-Google-Smtp-Source: AGHT+IGE7CYhPaqXXU1fUFMIbFf13xn84IoKuDB8OVSFc/4wqZ/1imwIcQ9V8jKJDgoyKZ9wTwju8Q==
X-Received: by 2002:a05:6a00:2166:b0:693:3c11:4293 with SMTP id
 r6-20020a056a00216600b006933c114293mr11055089pff.14.1698260662043; 
 Wed, 25 Oct 2023 12:04:22 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ca27-20020a056a00419b00b006c05374202dsm310697pfb.71.2023.10.25.12.04.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 12:04:21 -0700 (PDT)
Message-ID: <70260625-5981-40f3-a189-afddac2a6dfa@linaro.org>
Date: Wed, 25 Oct 2023 12:04:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add LoongArch v1.1 instructions
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20231023153029.269211-2-c@jia.je>
 <bce33bc2-60f9-41ee-856c-d76682c185f0@linaro.org>
 <1af667c0-f1ba-4538-9aec-8232397dd3c5@jia.je>
 <a1784c3c-b00e-4cb6-a262-96e6cbaa5c30@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a1784c3c-b00e-4cb6-a262-96e6cbaa5c30@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 10/25/23 10:13, Jiajie Chen wrote:
>> On 2023/10/24 07:26, Richard Henderson wrote:
>>> See target/arm/tcg/translate-a64.c, gen_store_exclusive, TCGv_i128 block.
>>> See target/ppc/translate.c, gen_stqcx_.
>>
>> The situation here is slightly different: aarch64 and ppc64 have both 128-bit ll and sc, 
>> however LoongArch v1.1 only has 64-bit ll and 128-bit sc.

Ah, that does complicate things.

> Possibly use the combination of ll.d and ld.d:
> 
> 
> ll.d lo, base, 0
> ld.d hi, base, 4
> 
> # do some computation
> 
> sc.q lo, hi, base
> 
> # try again if sc failed
> 
> Then a possible implementation of gen_ll() would be: align base to 128-bit boundary, read 
> 128-bit from memory, save 64-bit part to rd and record whole 128-bit data in llval. Then, 
> in gen_sc_q(), it uses a 128-bit cmpxchg.
> 
> 
> But what about the reversed instruction pattern: ll.d hi, base, 4; ld.d lo, base 0?

It would be worth asking your hardware engineers about the bounds of legal behaviour. 
Ideally there would be some very explicit language, similar to

https://developer.arm.com/documentation/ddi0487/latest/
B2.9.5 Load-Exclusive and Store-Exclusive instruction usage restrictions

But you could do the same thing, aligning and recording the entire 128-bit quantity, then 
extract the ll.d result based on address bit 6.  This would complicate the implementation 
of sc.d as well, but would perhaps bring us "close enough" to the actual architecture.

Note that our Arm store-exclusive implementation isn't quite in spec either.  There is 
quite a large comment within translate-a64.c store_exclusive() about the ways things are 
not quite right.  But it seems to be close enough for actual usage to succeed.


r~

