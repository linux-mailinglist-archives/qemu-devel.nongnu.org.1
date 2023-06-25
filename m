Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C82BA73D4AB
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 23:48:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDXZr-0007PE-9l; Sun, 25 Jun 2023 17:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDXZo-0007Oy-Ps
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:47:20 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDXZn-00005M-4A
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:47:20 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51d7f4c1cfeso2509539a12.0
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 14:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687729637; x=1690321637;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H5Wyi+zFwzrrGvjg/59bN6GXW/pmA6YeFDYOyatxXXU=;
 b=P6CWl22YnGaMKIInh08tq8+1kF8rABVt4XCm5M/OhKon7CEEuWsEHCcBlHkqyF/S9f
 p8GpUeNN8gAEyEvnAqK6PpCfMoatHAE4jjfU8lDyZ2ovhPKkeU33mWrBkhEE9rry4F6c
 bU9mTW2MeeMmxpwrZtxuR0NJcbCid4OJ1VsY9CaX9bXvzQmtg+LhW4NP0vHn5d9ewpx4
 MKKBTB0bVTQQtcGXnakunBhg45e4KCPhn58GG59GXSMfYh2QnQSy5aPQYmvZLawVDBdF
 0bYkn0hbYmpUdyssXdUp/otVg1mFjBj2qd/S2qZIQRJ2YXYOdV7SSZx0hGbb8hGMDqK8
 6dUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687729637; x=1690321637;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H5Wyi+zFwzrrGvjg/59bN6GXW/pmA6YeFDYOyatxXXU=;
 b=S/ymokmpARB6JiP7tiOwMIpLfaiRb7KngkQbvTt9pNiv4aKBGpuBaOFYYAiHYhfuyn
 vY43XsDi/9H45T4xp1EZ8VmOy44/1x2R/LGdP+bgB9aAt51u8GtBb3D3C/oqc2X3PQcI
 4u8mpIPnRiFxqmjg/5qkDZRLccRtUlgWu4uUiVfEddrsT3iFMQtSqgBzbqW7lQ9tZePP
 Ozg+KRGmBLNYsmOGYz3KESBHEqNBVkabM2SVYSk6Y5plTcN0qy7UNYxiUSCiTqfb68Tg
 n1Dh3Idqu26qj+QnePpkCrwbxv0Gl1l9SDWy5EyHxFKy/peFuEzWC6Dp0zkxZ+DQFgyA
 4ROg==
X-Gm-Message-State: AC+VfDzCVnLpIAMabMPctQNiKljkgzoaYJ4L64bOvgRDRvEivDQeJ95y
 j6tnU6wVcpfb3ch4mv+97m1WMA==
X-Google-Smtp-Source: ACHHUZ5hwqQvgIHu/8xZAZgM6jqslH9uU101+mtgw0ZqcVBwsmnXEz1rT/MObmIeBvqQgNSUjkkLhw==
X-Received: by 2002:a17:907:6088:b0:988:dc8e:2fec with SMTP id
 ht8-20020a170907608800b00988dc8e2fecmr19101153ejc.36.1687729636746; 
 Sun, 25 Jun 2023 14:47:16 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.212.184])
 by smtp.gmail.com with ESMTPSA id
 n17-20020a1709065e1100b00991481e7c53sm643066eju.206.2023.06.25.14.47.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Jun 2023 14:47:16 -0700 (PDT)
Message-ID: <36774da7-41ba-5ed1-2f7f-d15cddd6fb81@linaro.org>
Date: Sun, 25 Jun 2023 23:47:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC v3 03/10] build: Implement libnative library and configure
 options
Content-Language: en-US
To: Yeqi Fu <fufuyqqqqqq@gmail.com>, alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>
References: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
 <20230625212707.1078951-4-fufuyqqqqqq@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230625212707.1078951-4-fufuyqqqqqq@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 25/6/23 23:27, Yeqi Fu wrote:
> This commit implements a shared library, where native functions are
> rewritten as specialized instructions. At runtime, user programs load
> the shared library, and specialized instructions are executed when
> native functions are called.
> 
> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> ---
>   Makefile                            |   2 +
>   common-user/native/Makefile.include |   9 +++
>   common-user/native/Makefile.target  |  26 +++++++
>   common-user/native/libnative.c      | 112 ++++++++++++++++++++++++++++
>   configure                           |  84 ++++++++++++++++-----
>   include/native/libnative.h          |  12 +++
>   include/native/native-defs.h        |  65 ++++++++++++++++
>   7 files changed, 293 insertions(+), 17 deletions(-)
>   create mode 100644 common-user/native/Makefile.include
>   create mode 100644 common-user/native/Makefile.target
>   create mode 100644 common-user/native/libnative.c
>   create mode 100644 include/native/libnative.h
>   create mode 100644 include/native/native-defs.h


> diff --git a/configure b/configure
> index 2a556d14c9..64edbda892 100755
> --- a/configure
> +++ b/configure
> @@ -1838,48 +1838,42 @@ if test "$ccache_cpp2" = "yes"; then
>     echo "export CCACHE_CPP2=y" >> $config_host_mak
>   fi
>   
> -# tests/tcg configuration
> -(config_host_mak=tests/tcg/config-host.mak
> -mkdir -p tests/tcg
> -echo "# Automatically generated by configure - do not modify" > $config_host_mak
> -echo "SRC_PATH=$source_path" >> $config_host_mak
> -echo "HOST_CC=$host_cc" >> $config_host_mak
> +# prepare config files for cross build
> +config_corss_build_host_mak=cross-build/config-host.mak
> +mkdir -p cross-build
> +echo "# Automatically generated by configure - do not modify" > $config_corss_build_host_mak
> +echo "SRC_PATH=$source_path" >> $config_corss_build_host_mak
> +echo "HOST_CC=$host_cc" >> $config_corss_build_host_mak

Typo "cross". Possibly part of the 'configure' changes unrelated
to libnative could be split in a preliminary patch.

