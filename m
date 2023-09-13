Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B6579E3A6
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 11:27:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgM8m-0007l7-Hu; Wed, 13 Sep 2023 05:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgM8j-0007kl-UX
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:26:29 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgM8h-0000rS-Gs
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:26:29 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-401da71b85eso71541605e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 02:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694597185; x=1695201985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yLISRO2NpFaWpuzAOfeLhFfzsbM5UOXgPxP4XVkK9rk=;
 b=xGQ3om/TK0+wDmDNkv3tU4ktsad2/nEaijVu8y4bdncwMA9ALGpRbjyPnyC2+BjLro
 dDwor3VvB8WBFYnDOP++zUZ+xSECzdOHC4q8kH99oPrwhBPdY2v+nGPqpPaXQf3AYzrm
 hpPunoDxSXTAF/qD8QEqCGAMFoV454z7Ue6W7ROJHShzrkkqU05+epB+CAYeucz/YlRp
 oCSzCjcIuv5h0k1+rdWrdoa71hJLvGkXoL89Am/OTcpOz3KwMjAS6bImNM/liZF/iEyW
 p8pIklxq08sav3Bu9kDbwTK9JqHEGlw3xZSDCYHAMgPdp/e38U05Q8dTQWCTo9e0Wufz
 Rmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694597185; x=1695201985;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yLISRO2NpFaWpuzAOfeLhFfzsbM5UOXgPxP4XVkK9rk=;
 b=Eig+sPfG0NAvnU57A0On8iz7dSsNhHzk7EPgO9f5JLE5JZagamPc2a6c/wzAS+hXyp
 QYUdtBDEQsCKWo79X+xWH8t7pCGNAK7hcjQop4RUnF9i+1vCQTV/dFkNQZhXEva7TAsR
 BB68PZyGOEXtxPIZUPe+2+rxA+0mfZXhMCmX58FhIBzX6kZISox85lHG4q2L1XQvpxKL
 sRSfPkkhN6ad/1VhFVsy3LtO+cvblRdbAwP5R834WQ3UEZQd7jVREqKV2vi4BxvBRBlH
 EPfQT8sp/RY0QQmQ71kUCEgyhAguD6PC9/gzGH1l2IPj/RaevdKFfkUZYJxGZATunp2z
 iatQ==
X-Gm-Message-State: AOJu0YwSnIqUYLT+O/H9gFimzJonUP6Qtke8zJJ1B0b2lzV5/HDT1Erj
 3gzFjTvA+x4V+XI29T4wiThatg==
X-Google-Smtp-Source: AGHT+IGMHC9p6kuHQ8IbOAh5/8MheSazUleuAXtpc8L9LVHcBmReZlslzrUEi5/yuLbJlDxqT7pHtA==
X-Received: by 2002:a7b:c3cc:0:b0:3fe:1232:93fa with SMTP id
 t12-20020a7bc3cc000000b003fe123293famr1612854wmj.22.1694597185677; 
 Wed, 13 Sep 2023 02:26:25 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr.
 [176.131.211.241]) by smtp.gmail.com with ESMTPSA id
 r6-20020a05600c35c600b003fbe791a0e8sm1530210wmq.0.2023.09.13.02.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 02:26:25 -0700 (PDT)
Message-ID: <6cee629b-c1f6-7466-7881-4cc5296f497d@linaro.org>
Date: Wed, 13 Sep 2023 11:26:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v4 0/3] target/i386: Restrict system-specific features
 from user emulation
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230911211317.28773-1-philmd@linaro.org>
 <fabf2451-e8ad-8171-b583-16b238c578e7@redhat.com>
 <111b9277-59b6-7252-6ddd-13edff9b2505@linaro.org>
 <CABgObfaz+Tdb6YzwbAeRH=zdXtzVK7VLFv2Lc-MxQMAxbhwnfg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CABgObfaz+Tdb6YzwbAeRH=zdXtzVK7VLFv2Lc-MxQMAxbhwnfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 12/9/23 19:25, Paolo Bonzini wrote:

>      > However, the dependency of user-mode emulation on KVM is really an
>      > implementation detail of QEMU.  It's very much baked into
>     linux-user and
>      > hard to remove, but I'm not sure it's a good idea to add more #ifdef
>      > CONFIG_USER_ONLY around KVM code.
> 
>     Do you rather v3 then?
> 
>     https://lore.kernel.org/qemu-devel/20230911142729.25548-1-philmd@linaro.org/ <https://lore.kernel.org/qemu-devel/20230911142729.25548-1-philmd@linaro.org/>
> 
> 
> No, if we want a small patch it is better to replace kvm_enabled() with 
> CONFIG_KVM, and also follow Kevin's suggestion to make it fail at 
> compile time.

For target common code (shared between user/system), CONFIG_KVM is not
a replacement for !CONFIG_USER_ONLY, since it can be always enabled;
which is why we defer to runtime check with kvm_enabled().

> Having stub prototypes was done because we expected the compiler to 
> remove the dead code.
> 
> Paolo


