Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD58724E33
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 22:37:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6dP1-0007AN-Ut; Tue, 06 Jun 2023 16:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6dOa-00079r-LJ
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 16:35:12 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6dOX-0005gz-Hq
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 16:35:12 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-39a3f165ac5so5638815b6e.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 13:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686083708; x=1688675708;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0JBotc/qIEtK+5N2qBf6KHpPBVmCH9Jae5s8Nn7fNcA=;
 b=T4g697jyUs5bOxQF/NRjXCs1NQXMlAysB9l+qvPTmTgEnfcb8gWi7x5MglOJRGEwJm
 csc1Dvl0vFoowiSshu0OxYsEl4no61gdpkhoKsNi2JU3D+MT0eMymdvEXAQb/fuES8Fl
 lbABdOBJVPAvn31MMGq0uLbtg5qDVLgBYu8CKXa0eY8nlk4DWJKg+BOJ9aE/C0XnEOjQ
 2neKh8/4GgGl3Ayf+hXg0LO9VQ8HpDAX8UTrssmgGK7oT3aQhhIBUhQQWhL7DhGultTb
 iXbjLkaECHfKienmYxrW1Xnj2haRftCgATGd0G10FAj+H2JuZAQ5NnQ7iZWnqNFMVFSG
 BMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686083708; x=1688675708;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0JBotc/qIEtK+5N2qBf6KHpPBVmCH9Jae5s8Nn7fNcA=;
 b=X+AOpc2ffLu/I27eINLVv3QtOeKAQxPqGWglefRLMJbDf8/WEevbggT9B0H6MqjmZE
 dmbmjwBl8ZtPqfgOyn/XRFHFCJCony0PHxMpU3HjTYcBoBtDNVDLMc5u+7AV8S4gtcyH
 pZ163xW7BU3Yq9FdUaS6G7RtqMqEMwT0+drGMiNeJJGkGwZ74GJ6hvX4S2wVUo6VJRmS
 kKCW8DxsDpY6G7eRNehtfsx1CnvxZtriZPri4zhccFe5fBddrE3FMnNKXyW60KMHkYNK
 sY3+tFMA/0Oo9JouejaSEP/FLpLFHyMuhl0yhVZ6GwZy27HCrHEUxruVxnqXBHFrNtvC
 NoOg==
X-Gm-Message-State: AC+VfDy7Lk6xmnCnl9tbBbjW4JaFZOiO6hz6agt6r5ld+f0bRMRrk6tW
 BSvNITkvquzfMRZh0hfpkjrvcg==
X-Google-Smtp-Source: ACHHUZ7h8cByxn2DsjX6R4chZAfxaLW42HX09YlN1im6nCnvXhftA/NsEkHAATzBVIkeSCAEdBEx9g==
X-Received: by 2002:a54:4588:0:b0:39c:4553:9644 with SMTP id
 z8-20020a544588000000b0039c45539644mr3016392oib.42.1686083708137; 
 Tue, 06 Jun 2023 13:35:08 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:b7fa:ce59:1445:805a?
 ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 d18-20020a170902aa9200b001b20dc1b3c9sm4441343plr.200.2023.06.06.13.35.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 13:35:07 -0700 (PDT)
Message-ID: <dbeb72bd-ea92-a68b-e663-fe2b41525957@linaro.org>
Date: Tue, 6 Jun 2023 13:35:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/8] linux-user: Add "safe" parameter to
 do_guest_openat()
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20230606132743.1386003-1-iii@linux.ibm.com>
 <20230606132743.1386003-3-iii@linux.ibm.com>
 <ad49111a-5dd9-671b-f18f-009a7eae73b0@linaro.org>
 <3c3df53d22f6f122cd389a9ed748c1655f8d77a6.camel@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <3c3df53d22f6f122cd389a9ed748c1655f8d77a6.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/6/23 12:29, Ilya Leoshkevich wrote:
>> The only concrete objection I have is the change of API, which could
>> be fixed with return
>> get_errno(openat(...)).
> 
> I believe both openat() and safe_openat() return -1 on error and set
> errno, or am I missing something?
Oops, no, bad memory on my part -- I thought safe_foo returned -errno.


r~

