Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C47C71F380
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 22:15:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ohY-0000XZ-Ev; Thu, 01 Jun 2023 16:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4ohG-0000Tr-Mg
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 16:15:01 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4ohF-0006Jf-6m
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 16:14:58 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f6094cb2d2so13530235e9.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 13:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685650495; x=1688242495;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RTwjXJ52cYMMMPwn1egTM/JD8SYrk+RzexV9ze5nqOY=;
 b=DbAe7OhF4QN7++vC+a+vkFH5yVCKJlI3OKBxNuwtDNkhizqtHSHsTQ03ZEHHQ033TK
 Fqa62i2ZHxNVMSD71YGE5k8H12mdzWRgVeUbniqvIdhnKzeBn7/MsQWYYELI4iRLCtg/
 ANJQJ/klkJ9sSJf1OqqhsYzB6ZQyCshCDXccNaaWfTM1wj4UvJALz82aXHitBuBS/r78
 4olslCnDoAgQJadc2GhXoWO6ArfGsE211oqZNoevcoRt1Z7DxO0FPz+DxDGNGHYjgtFF
 atbpXB9l3TDITP37/FYaK/8RDGdcoohrpqNgHYq777IE73b3j3iHBd/Hg9GfyGjIaF7E
 +Blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685650495; x=1688242495;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RTwjXJ52cYMMMPwn1egTM/JD8SYrk+RzexV9ze5nqOY=;
 b=Ld1N2e5zImYcXMueBKpChTFAyv3M5IPo+lDR3ZX+4B9Xi5hvrd/5lUyipmqMfnS+WX
 QPG+G0lW8j3eikJO7Q2XF7Rs/UIHEqthZS/MfxlAzfympAQd+5oVd6aUwV6kDjuGErDs
 TyNCTUaHh+Yqp2GyCqPvDRzZj5rZBy39OQaVQOvEOXjASR9F7Ga9BWMOgRPQ5yVsw5N9
 U3lO/6czsK7ac12ihd85pdSeM3QZXp2RDF9bStsNtSjIIoNl7OzDxLVb/DSPkLawBt8X
 Ux++VHoRM2FsfylFpBoElXPYjiC1dYJLvNswNt7kwWjFcGAT3fbpNbnFKMKGStMGrWNL
 padQ==
X-Gm-Message-State: AC+VfDxP5d46D5oWHnDGDuMr/OSi5nrj2MYeQANOxUu7B3UUPl8tTvrg
 CbUNgyrH6dl0FYWMJNdPls1GFsI9Pj98NPY+6zc=
X-Google-Smtp-Source: ACHHUZ6mkQpdzMw6MeTI2AV4er+pRk8dow516YsOmO6F8Ko+SRFciQZ+fUs/Gb8C+gy+Jx5z9CgmCg==
X-Received: by 2002:a05:600c:230a:b0:3f6:1a9:b9db with SMTP id
 10-20020a05600c230a00b003f601a9b9dbmr345173wmo.21.1685650495748; 
 Thu, 01 Jun 2023 13:14:55 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.141.224])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a05600c211000b003f4fe09aa43sm3338421wml.8.2023.06.01.13.14.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 13:14:55 -0700 (PDT)
Message-ID: <134de3ce-298b-b933-4436-28fddbef1d70@linaro.org>
Date: Thu, 1 Jun 2023 22:14:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 18/48] tcg: Remove outdated comments in helper-head.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-19-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 31/5/23 06:03, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/helper-head.h | 18 +++---------------
>   1 file changed, 3 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


