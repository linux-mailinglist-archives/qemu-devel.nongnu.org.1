Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2E1824305
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 14:49:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLO5n-0005Ic-W5; Thu, 04 Jan 2024 08:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLO5j-0005IO-MU
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:48:59 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLO5g-0006sR-UY
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:48:59 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40d88fff7faso4512235e9.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 05:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704376135; x=1704980935; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nFsmOMSxQRF4xQMn8Ad30UpSEl5cLL1zUDbyAwgJsNg=;
 b=NoksNdm/pVr2QQH+Bv1pLo6S1MLrGrgHdv2dpSgLxnGrVuNYMG5cW/+aBLsK3kUcdK
 MOUxW6/m7jsd5sHibKkAezvqKiRg+O9o0/1osptIVOQgNDmqrwH9BZ552zKsQ4I5a6gL
 sCPc3P5s1DfIAVT0sHOKSnUDBVjJom0y1noxiWgS8+HuXn0NzIyS5A7D5lToaLPaCbcC
 OxsYV1nATpaQT8C+ZFzZQ90r7d28z0Bw7j6ioynd/6+6fhFtzg9OrW7XRnd+lQkrBeSh
 UdupZ1qoTHhhRI1X6qUwThYyOLRQ3A60Bv+UUd0wG5XeAfncc4FOKIJNUmfXdiWKF/+p
 ax1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704376135; x=1704980935;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nFsmOMSxQRF4xQMn8Ad30UpSEl5cLL1zUDbyAwgJsNg=;
 b=Nt/C6HpV42gCjvix+R2Jo6ioL7E5cUkpdrgkVLex5Qh4P8v/WTZw9W2o7p2ya6JoAr
 PK7rVqOIO4A508Jg63dEDb8BNrcCi7WHdeA2w7OgGe1aYVEXC3I++5kqGC0dPF4wMiEL
 2aSOqSaNFelb7x1hU6n54eJsTd3hW2ZaMABF032NEYivfNo0ahCa9cEe0gvDF8ad5Sxv
 MZdfAJESy9IQQwb4nwYC2A5CArRrFjR2Ss0pQkv//mDNpTythCKdicPVRodd1NpjXkZO
 gmW+kftBECkBsWc0O8l/9Bopp+2lrD1Wuuz7/xSkwJr32meV+rVICVFiJSqUNE1V4oP8
 /9QA==
X-Gm-Message-State: AOJu0Yy8eOcYkeX3L2W8jqJ+4y4YTr+jwKMAA+H8mUhMwgWI6aNfjAgr
 /4Q8myc2G4ObWlTB5NlRg95kqBkjThc6Lw==
X-Google-Smtp-Source: AGHT+IGMTr95ztbSzh/YordAU0E0GdTIBj+hAJ49Esa+wTcSZgLVNFlx0nvMkROBYJ776JTs5agb8A==
X-Received: by 2002:a05:600c:18a3:b0:40d:2c0d:7852 with SMTP id
 x35-20020a05600c18a300b0040d2c0d7852mr190805wmp.160.1704376135112; 
 Thu, 04 Jan 2024 05:48:55 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a05600c359000b0040d5a5c523csm5820118wmq.1.2024.01.04.05.48.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 05:48:54 -0800 (PST)
Message-ID: <f2d83840-17cb-433f-add9-d7e05448a280@linaro.org>
Date: Thu, 4 Jan 2024 14:48:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/sev: Fix a segfault in sev_kvm_init
Content-Language: en-US
To: Srikanth Aithal <srikanth.aithal@amd.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, mtosatti@redhat.com
Cc: nikunj@amd.com
References: <20240104104820.14422-1-srikanth.aithal@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240104104820.14422-1-srikanth.aithal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 4/1/24 11:48, Srikanth Aithal wrote:
> Propogate error code using errp in sev_kvm_init.
> 
> Before fix:
> qemu-system-x86_64: sev_kvm_init: guest policy requires SEV-ES,
> but host SEV-ES support unavailable
> 27747 Segmentation fault      (core dumped)
> 
> After fix:
> qemu-system-x86_64: sev_kvm_init: guest policy requires SEV-ES,
> but host SEV-ES support unavailable
> qemu-system-x86_64: failed to initialize kvm: Operation not permitted
> 
> While at it, also fix two more locations.
> 
> Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
> Signed-off-by: Srikanth Aithal <srikanth.aithal@amd.com>
> ---
>   target/i386/sev.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


