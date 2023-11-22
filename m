Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 184697F4B38
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 16:42:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5pLC-0007ur-6Q; Wed, 22 Nov 2023 10:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5pL0-0007tq-JU
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 10:40:29 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5pKu-00045h-D0
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 10:40:23 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-332c7d4a6a7so2094372f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 07:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700667618; x=1701272418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0MmxizoVULEHvcDoDg29H4cq14WrT7aMuvWp4hNqXio=;
 b=P9hxDyt38WK2GSSTOrjflU2Ivw17ZRZDg0Co3moECscGEt1II3hN7qzCZ5UBcxT/Ha
 6eNcuWKyWBbJy9hsaa/jEh4oP/3i2sTNnv3UNY+koScqBRM7BocltUSnp6axo8wuAe8X
 K1LyoD/g95sWQUBwcIrbeCh+PJoEM8LRaNOAipHblYpJbB/8KSjbGXl76jg4ULY1kdQ1
 eQ1SCGHdKvRijo8yElVgMmuS+/ARaFti+IB20RclCLXSf4vn7bHrZ3sYz2VZpLkAfklG
 rBzzeM6On2BLrT5yn7+YKfqVwaAnwOIfPQToS7zws8ME7ogJwn4puHT6+nK0vXR+QNQz
 W02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700667618; x=1701272418;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0MmxizoVULEHvcDoDg29H4cq14WrT7aMuvWp4hNqXio=;
 b=Iu4Yb7/TCTMDMuVolqTceyZIZUB4hUiswdzuKJRug1vM/9QDu1I2J5KVFD1eau8AYb
 +O35VAsfoCd4X79Y8PfZoE5qb1U3aNGD2VqUAUTvrCeA/fPeFMTg0Gw04G4aMofEbaWo
 Ubs5Zx8yriR/xhv+bNhc5naOHEfsUfLhuwACtrGakl8FFyt04cJWXyothLE1oBQr55Qk
 hYXqrQHaD3CQIxEjF2pkRcFRC6VGhAj6v9pqNI0sQ94+Jo4a8YJp5yD310kXHbUHsuzf
 GRNevx6Dsn8luk3E5LLEB4Z0yvBv66LGmmJ78V6uEDnes8pQ3uKkRAIqaCToeIP/zhiy
 tS5g==
X-Gm-Message-State: AOJu0Yxn9xZyZENhsNB1YnUE21WUi+jjGWelRtEF+M5lHZZbF8OtjDdJ
 akZ2WWN2RmL1V8YRYq+YmGYklA==
X-Google-Smtp-Source: AGHT+IHabVPuiJGFznxPXnYb/epwp/UicxbMj7/KBeoJsqKhRNjiJhGeDIBh8qUz+ow6XlG5jEeLaw==
X-Received: by 2002:a5d:4e06:0:b0:32f:a5af:99ca with SMTP id
 p6-20020a5d4e06000000b0032fa5af99camr1690588wrt.69.1700667618219; 
 Wed, 22 Nov 2023 07:40:18 -0800 (PST)
Received: from [192.168.69.100] (pas38-h02-176-184-5-64.dsl.sta.abo.bbox.fr.
 [176.184.5.64]) by smtp.gmail.com with ESMTPSA id
 g23-20020adfa497000000b0032fb7b4f191sm17761587wrb.91.2023.11.22.07.40.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 07:40:17 -0800 (PST)
Message-ID: <a5c301b8-1558-4493-aa74-344e9deebdd2@linaro.org>
Date: Wed, 22 Nov 2023 16:40:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu] meson: require 1.3.0
Content-Language: en-US
To: ~akihirosuda <suda.kyoto@gmail.com>, qemu-devel@nongnu.org
References: <170066514685.13745.10445790352432092776-0@git.sr.ht>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <170066514685.13745.10445790352432092776-0@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Hi Akihiro,

On 22/11/23 15:52, ~akihirosuda wrote:
> From: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
> 
> Update meson to the latest version, to fix
>   `ld: unknown options: --version` error on macOS
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1996
> Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
> ---
>   python/scripts/vendor.py                    |   4 ++--
>   python/wheels/meson-0.63.3-py3-none-any.whl | Bin 926526 -> 0 bytes
>   python/wheels/meson-1.3.0-py3-none-any.whl  | Bin 0 -> 976361 bytes
>   pythondeps.toml                             |   2 +-
>   4 files changed, 3 insertions(+), 3 deletions(-)
>   delete mode 100644 python/wheels/meson-0.63.3-py3-none-any.whl
>   create mode 100644 python/wheels/meson-1.3.0-py3-none-any.whl

Should be fixed by
https://lore.kernel.org/qemu-devel/20231111152923.966998-5-pbonzini@redhat.com/
(which uses 1.2.3 instead).

> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -18,7 +18,7 @@
>   
>   [meson]
>   # The install key should match the version in python/wheels/
> -meson = { accepted = ">=0.63.0", installed = "0.63.3", canary = "meson" }
> +meson = { accepted = ">=1.3.0", installed = "1.3.0", canary = "meson" }
>   
>   [docs]
>   sphinx = { accepted = ">=1.6", installed = "5.3.0", canary = "sphinx-build" }


