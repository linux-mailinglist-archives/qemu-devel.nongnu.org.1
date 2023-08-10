Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AA777764A
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 12:53:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU3Hb-0005Vn-OD; Thu, 10 Aug 2023 06:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU3HZ-0005VQ-5W
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 06:52:45 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU3HW-0001iz-PN
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 06:52:43 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbea14700bso6734675e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 03:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691664761; x=1692269561;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y/9w02R35o8paskBq9Eq4I+p0Z+ZTZo1vzHmpjcAteg=;
 b=K3JpOhi9ur51SUZ1znIiPLrpU8wKIChKGhRC8lEQpI8nmEX9mttnnLr0+WiQwrU2p/
 3dD2pEA2fv8/neBXcLiv5T11ObA5eVojm584h+LBU09oPTBSBAewilgyJQaQfuWPRpYk
 q9DHhIAXtklNjimN6OQ9T8GGq6laHukjWgcZL9C8LhktbrSD47knrfJxQqksuPmpp21X
 pkNFA2TRLqv2J0MVz8jBs2NG9HbmWT+JTbvTAuavxN9ur3gI4+IszECoxofd9jxHFUUe
 hi6u3LuVPbK7o6lgL3z1v0lzdM0DKw6i5R/LVhIRY33tKfS97tRAaWLpukNQpp5s4EmW
 GbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691664761; x=1692269561;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y/9w02R35o8paskBq9Eq4I+p0Z+ZTZo1vzHmpjcAteg=;
 b=HqwmBspxnp+Gz3K1B0RtLLHhnRSYd6IxxE76dT07YURSm4IG/mJyQyiFVFGLFPzEUQ
 k2Dn+o9/lqJf9Rxu9fei6okq3Oq/5k5Wf0b3VBfuwxphwXpn9LXAsuJ0rBlEkHHrgSnV
 R6BDRVqrRtKtgHPeLyPkvuwa448A0qgFNoAkREw69X27lYe8D38CNRBw7bYPDBgUsLL1
 CvLuFxxmyUvcKfZioJxMQqc/HI9fvpSLLj2Z78ED10R82+mLNh9OpeMiQO0UwAok9e73
 Jpaw3P2eCIVBop5+K5b7EC3Hsi20XorSHwBOiaXThpDkrGAOeHhWPmdj+eYO7eg6Sf6K
 pwjw==
X-Gm-Message-State: AOJu0YyhGGLsgdwBpiI8h/i6YDyXAX7RwAovnItKgzpscNWQhCu0DKYO
 Ibyq+eZXv/zUgJGMYXGkvGof2A==
X-Google-Smtp-Source: AGHT+IHyhAjOG81FxvhUkmaC/kQAt3F87Q68mFZYxvqRkxgKmItsMFh/JZ065+3l+NPvFWLTxxySrA==
X-Received: by 2002:a1c:ed12:0:b0:3fc:21:2c43 with SMTP id
 l18-20020a1ced12000000b003fc00212c43mr1539923wmh.13.1691664761313; 
 Thu, 10 Aug 2023 03:52:41 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.65])
 by smtp.gmail.com with ESMTPSA id
 v23-20020a05600c215700b003fe1ddd6ac0sm4649256wml.35.2023.08.10.03.52.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 03:52:40 -0700 (PDT)
Message-ID: <9787ecab-dd93-8b7c-9eee-eaf37717e501@linaro.org>
Date: Thu, 10 Aug 2023 12:52:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] util: Delete a check for IA-64
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20230808152026.100096-1-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230808152026.100096-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 8/8/23 17:20, Akihiko Odaki wrote:
> HOST_IA64 will never be defined since IA-64 host is no longer supported.

If you send a v2 removing the similar definition in 
include/exec/user/thunk.h, please mention this is since commit 
b1cef6d02f("Drop remaining bits of ia64 host support").

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   util/oslib-posix.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)



