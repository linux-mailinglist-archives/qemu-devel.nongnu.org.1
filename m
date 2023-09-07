Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E4B797195
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 12:52:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeCcR-0003fV-1L; Thu, 07 Sep 2023 06:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeCcP-0003fE-ES
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:52:13 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeCcN-00050Y-A2
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:52:13 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-401d2e11dacso12869225e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 03:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694083930; x=1694688730; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lM5ZR2t4izRCDwuDhc+Nvx85tqpEJIVA1mFji0UE9rc=;
 b=U3WAM5TqXC3UWXppRuFtjhdEQ0D2ihNFOIvWM6lciya3QTMmsxva+ryI3Mf5maM9Dk
 AYj3w0UN+8z5e4D4zJuOKjtpEN87J+1ImjDInHPowBfRWqJEvw2jjfdwifprVW90v18u
 AEJqcMSiaHDntr4SoIWZ2VSm4BlQF01A5dpf6AfLEcXxV7pacJAx7Nd+yTf35NDHIu6n
 8xjfBwU9hHcWFtG2HpG3Gl20h5iUTdG+MHKm1HabQjreA+pblZVXBFht3L+mAqyIRP36
 28112g4ByGl8j0WJp1KIP9esXkI7KwNljYG/VS0VeIszxWBXxnlP5Qq7zuFl+vWCFNMI
 C1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694083930; x=1694688730;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lM5ZR2t4izRCDwuDhc+Nvx85tqpEJIVA1mFji0UE9rc=;
 b=WIk5Wv4NkLFGF5PPX9plxmupynJVVfMvHHteF7YGGQG0AS/tn1JivOF2vVXDVS4T6x
 CGVFQiMTLXhu9HiTyaq0zdAzHb+knt1Gu/GDQK0//r2W9oGnLvOz6FPYkvZs9i9Zb13i
 1cy3sGF6zBrGK2AqH04P57vE7T2w1okXuNF4MBZtVc8vhv1R9LhoUI9VGxMU3KXqU1k8
 y14BGQSpOxFmj6U/eauO3XR8WfQLb+7zT05SxxXitBfi/rX5bzf7PHqsmMwhm5ZZ5AFc
 yfZ1CRnFyby2zeRt64EVyLcZl0ttzv2VrNI7eJfiKAsVBQB09DWEiyRhKkNFI+wAhh3h
 x9gg==
X-Gm-Message-State: AOJu0YwAl5y6D+6Xg/wJPNk/SWr8VYwxpTq5NbUBNz1eOYE1AkZnQFas
 e7PHflO9ZWgnudrwMc3czHY70OKFNUEXr+41aFY=
X-Google-Smtp-Source: AGHT+IET9LIA/Rkp2XxjoC46ErLrhnEVUK+J+kW1di1Z41DSl1mPFHWXUEaoImytmGBHaIH4uLncGg==
X-Received: by 2002:a7b:cd0e:0:b0:401:c1e2:f74f with SMTP id
 f14-20020a7bcd0e000000b00401c1e2f74fmr1923939wmj.15.1694083929813; 
 Thu, 07 Sep 2023 03:52:09 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-226.abo.bbox.fr.
 [176.131.222.226]) by smtp.gmail.com with ESMTPSA id
 18-20020a05600c249200b003fe1a96845bsm2165921wms.2.2023.09.07.03.52.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 03:52:09 -0700 (PDT)
Message-ID: <bfbe2dc7-bb55-fb3d-3f54-c9b7ac9c79d6@linaro.org>
Date: Thu, 7 Sep 2023 12:52:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] contrib/plugins: fix -Wformat issues
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20230907103403.471248-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230907103403.471248-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 7/9/23 12:34, Paolo Bonzini wrote:
> On macOS, compiling contrib/plugins incurs several -Wformat
> warnings; fix them.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   contrib/plugins/cache.c    | 10 +++++-----
>   contrib/plugins/drcov.c    |  2 +-
>   contrib/plugins/howvec.c   |  4 ++--
>   contrib/plugins/lockstep.c |  6 +++---
>   4 files changed, 11 insertions(+), 11 deletions(-)

Eh we crossed :/ The diff is my series pass checkpatch.pl ;)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


