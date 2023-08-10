Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A68777765B
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 12:57:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU3LE-0006yF-Cl; Thu, 10 Aug 2023 06:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU3LB-0006y4-KY
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 06:56:29 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU3LA-0002Qn-4O
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 06:56:29 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-313e742a787so417620f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 03:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691664986; x=1692269786;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yhaX84RDn1OkPvRD/9u7esjDwSQ7IUekHGDTiYQScsQ=;
 b=s343pqcA19eapzgyEjqSDfR6svRKwwvl+BrVGqo8rLLvvH9x2eDg68ozTmsGJ6bSUD
 QbwiNRzOIeC0XxZsfBgejvuXTGfHK4ZHoKwysggZBSkWtI6oxqH0/zwfHru9g5IiS0Nf
 +fuutyVN9tUulhknqFBKBupZxKQhPQ0d4j2SGId52Q2uP+ciEsFlrMP36mrHmltNpKkM
 KwizKmxb3DVLfG4yR+c3Vg19JMH+t3p/W7PEQjAl2f+N7lKreL/Vbp7Y0WV8V8ukm2kK
 6pPUEUhnPfVdkMdeBZnE9vUL6mHQi8oPF6idJ5dp1VYtx4+AY30Uuws1+CfJDQ4OEnND
 b2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691664986; x=1692269786;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yhaX84RDn1OkPvRD/9u7esjDwSQ7IUekHGDTiYQScsQ=;
 b=cHRZiQb0vO3HrgSQINcD6odZ31eQTXnE6YGjltMCrSKtRrWFwuAc8B1Hn/0WkdQydG
 wObmCCi8nqeW6SLW0rDrpXUAw1Z//Ln+vLYTe6GXCid5h9CHKE/8wEtq4acwvmZwRMM5
 ybCQvQsYEqh79OQg2Y13bTuMqkk9oCiuN2ccmqgetHyMdLCQOIFP52PUJOdy+dw61Glc
 Pxj7hm+GQGHdZEN7AEhUFaUSbSu68r2ovvYyPnZLtc2wJ0Y9v6eJRc5BGvnljfknKGSD
 0K+XD4PunlrqPa15ccTaJ2PVuw3Ws0ksBljvT1okpKX2nb2Iuwhs1NrJWDAu2OrzW/ma
 y9fA==
X-Gm-Message-State: AOJu0Yx4x6cWKrZ/LypyOBuH57TVN2PVGTOj8HCgOJht3eSiMkBBzp60
 NM6/EEiKFj1set0Ih8Gvflo3tlymp63cIakq35w=
X-Google-Smtp-Source: AGHT+IG9c/vnHXeplvaor+zbZry3KAPYASf574rKzeiZHj7AWx4OaQZpldehNFFA6zyf90nzg+Zrvg==
X-Received: by 2002:a5d:4990:0:b0:317:58a4:916f with SMTP id
 r16-20020a5d4990000000b0031758a4916fmr1378422wrq.33.1691664986655; 
 Thu, 10 Aug 2023 03:56:26 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.65])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a056000010b00b0031431fb40fasm1797214wrx.89.2023.08.10.03.56.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 03:56:26 -0700 (PDT)
Message-ID: <f61ff7ff-44a2-14c3-da08-755c290c75b7@linaro.org>
Date: Thu, 10 Aug 2023 12:56:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] thunk: Delete checks for old host definitions
Content-Language: en-US
To: deller@gmx.de, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 pbonzini@redhat.com, laurent@vivier.eu, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Kyle Evans <kevans@freebsd.org>
References: <20230808152314.102036-1-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230808152314.102036-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

Helge and myself sometime run the tests on a HPPA host
(testing the QEMU tools). I guess remember John Paul
also runs some on Alpha (so Cc'ing him).

Helge, what is your take on this?

On 8/8/23 17:23, Akihiko Odaki wrote:
> Alpha, IA-64, and PA-RISC hosts are no longer supported.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/exec/user/thunk.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
> index 300a840d58..d9c131ec80 100644
> --- a/include/exec/user/thunk.h
> +++ b/include/exec/user/thunk.h
> @@ -111,8 +111,7 @@ static inline int thunk_type_size(const argtype *type_ptr, int is_host)
>           if (is_host) {
>   #if defined(HOST_X86_64)
>               return 8;
> -#elif defined(HOST_ALPHA) || defined(HOST_IA64) || defined(HOST_MIPS) || \
> -      defined(HOST_PARISC) || defined(HOST_SPARC64)
> +#elif defined(HOST_MIPS) || defined(HOST_SPARC64)
>               return 4;
>   #elif defined(HOST_PPC)
>               return sizeof(void *);


