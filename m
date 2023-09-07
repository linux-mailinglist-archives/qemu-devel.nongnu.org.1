Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3777971B2
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 13:25:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeD7l-0002dK-JQ; Thu, 07 Sep 2023 07:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeD7j-0002d9-Ma
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:24:35 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeD7c-0004Gm-R0
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:24:35 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5008d16cc36so1357366e87.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 04:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694085866; x=1694690666; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cvDq8OTjoRY7zJqoInccQytDGwFKaO+kmBTFqB2b1VE=;
 b=K5Jlz8uDsxb5IzYgeRl+q0ww+tKWctNfChps8OMWLWaDF93pEMe5h+ae1N4e6Uahxa
 M20uNlHzcbX5s4ddJwO/MXcl5llTDaXGZTuFHCl4qjDJGuUpYfnKQCEje5V9dRCTPkbf
 b74z0Oiz7widw8lRz3F4BrONQMtVzJEAuibiDDbAZUj8RIOwRpRrSAcWU1ia9sQFDG4A
 1M5DyODI3e3f/37Np3SXuLutiM3YRbEQIKF1AyX4JVD/Qm0uVAxtSbrbE3gD37oUNJcu
 0WgX93tE3hX2NGb6MAyvORLAqb58Ky5Ozh2LIrDoxNOuUI7t3KQEYojwpjSAB+bwgxQu
 CESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694085866; x=1694690666;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cvDq8OTjoRY7zJqoInccQytDGwFKaO+kmBTFqB2b1VE=;
 b=J1vjdABtXDQs7uXVI7qtgmmjQWpVG6383zQIE3sU0SvYSl3QW4PUPctra8xOW2Xzdw
 yZQA8eSDH0mmWL04KZ6/CIqjmvvHFvmmo6ovr84unWBXg6GI01mdkBMQEGn72/eqahxu
 GUHdTuQvUM/L0Vy5MSY6CiGvJgLcZO0pi9+KczrWH5zO6252kUP2935ZSc/aDYEiwQAt
 OHFyFzYqlvCJQ0/EK3mwHrjX0BIgpxWgN6eBx13fHSyv4a8vljQBagxJWhtAe3PdjDhW
 /WRCInBwYCr8+cumzQeJ8yro6pWcvXXpgBBCfjtJlmPbNUEBTbqXRgCynrv0waH3BucB
 +o9A==
X-Gm-Message-State: AOJu0YxugopqyW9RC+HpXXboFz+JjBUTsw6Ca+V2EaKU8syGJ+HWr/zv
 CfdU/vG4ptoLMeVC4dBuqmL6OA==
X-Google-Smtp-Source: AGHT+IG+OvpOKcr0HHL8ouHwJx2e/MABwAtF5ia6L92Q+f0W8JI0SlUkWPFUKG0uUIxhGgXTHi0Gcg==
X-Received: by 2002:a05:6512:2098:b0:500:ce5f:7635 with SMTP id
 t24-20020a056512209800b00500ce5f7635mr3794180lfr.54.1694085866461; 
 Thu, 07 Sep 2023 04:24:26 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-226.abo.bbox.fr.
 [176.131.222.226]) by smtp.gmail.com with ESMTPSA id
 a9-20020aa7d749000000b005257da6be23sm9758133eds.75.2023.09.07.04.24.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 04:24:26 -0700 (PDT)
Message-ID: <8bcdb2bb-6a1e-c76c-20c3-3999caa86d2b@linaro.org>
Date: Thu, 7 Sep 2023 13:24:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 0/5] contrib/plugins: Build fixes for Darwin
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230907105004.88600-1-philmd@linaro.org>
 <5d0119f5-5175-fa0d-7a9e-1558478997c5@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <5d0119f5-5175-fa0d-7a9e-1558478997c5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/9/23 12:57, Paolo Bonzini wrote:
> On 9/7/23 12:49, Philippe Mathieu-Daudé wrote:
>> - Fix string formats
>> - Link with GLib
>>
>> Alex, Thomas: FWIW, plugins aren't build on CI.
> 
> They become tested with my patch "configure: unify recursion into 
> sub-Makefiles", which is how I got into this business.  So I'll queue 
> these patches and include them in my next pull request.

Thanks!


