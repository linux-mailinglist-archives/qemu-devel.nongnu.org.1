Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C398247BC
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 18:49:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLRow-00059K-IZ; Thu, 04 Jan 2024 12:47:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLRov-000597-5k
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 12:47:53 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLRot-00056W-Eq
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 12:47:52 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40d60c49ee7so7294845e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 09:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704390469; x=1704995269; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+iedyH9LefDyczHaZZmS91YWm8XgnFT7BMGFNI0x+hs=;
 b=XpMihfgFPO0lq5j7sg9PubLc7LMFqMw5KYdtKZ2R75oYL6q7av2xRI3SFMHYUhq/v6
 lpsEorXB+k4/PvOWafCNMso/kjWSa1eOtSBGMwRikkta8VdPOii0jxIIyVJpaaXLvx30
 Bp6YDjXpDgxp6/ebVB5//DJKAhpMKsVb3j2y39CMuLH1o4kCVHZmbn26m4KYMdnLAfbZ
 lGuciRBVo8CGJmDNMb0oAFO8mf7lZheREwGLen0uYGdP5iBZBRgM4WcDG+7U6ciS+kks
 TmP3fR9rf0oo844VK/Jp4nmTDnbdiUvVkYgPS11jFDFQN8Zg51MjZVHKLTBHrBq11mMA
 i/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704390469; x=1704995269;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+iedyH9LefDyczHaZZmS91YWm8XgnFT7BMGFNI0x+hs=;
 b=DhGS9Oz/06+/9MTrklUsgCN55Nre2eFb5nLQg3yoRgRILpZSn0IEDxlfM0f1FVH5Wp
 g995+nuO+SOnkcTxvBYTp6Hb1lUrdGq1k9l3WWTS/uDiPbLra5LTOuIWh+Tib4RBGnWY
 zY3FTD1oB51nRUHRW2Vx1heAsfA6MiC9u5mzjk51R408/ZVkGYoucs883b5vbszwoz4A
 kxnez6HawUvho2cIYSJG8woNMFpejtGmTxoBCFknUAnpaPaTP8mrmQ2i4Me0Qgtp2XEi
 oasq0GIb9ZCTH68AwlCykQygV3wXdZlyQdAD4YJry66ad+pL6Brb4EmROSok7d+Dk8mN
 rPaA==
X-Gm-Message-State: AOJu0Ywm9GXgzK4ZXZ9ki9rUq6S4cyuc2Bs9L72ptpQw6RPQ82RWSRIa
 jrYtf/m1uLupGfyekw9fnaOe+qsyIoNqCA==
X-Google-Smtp-Source: AGHT+IG//x1tGvoqhhJ+Ty7JANxdni/kiqjzVLZF903hH3xPWu62kDg2YBHBOD16uhGKFPg9VTCrjg==
X-Received: by 2002:a05:600c:3ca3:b0:40d:5597:c7e9 with SMTP id
 bg35-20020a05600c3ca300b0040d5597c7e9mr526474wmb.95.1704390469536; 
 Thu, 04 Jan 2024 09:47:49 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 bg40-20020a05600c3ca800b0040d87b5a87csm6287458wmb.48.2024.01.04.09.47.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 09:47:49 -0800 (PST)
Message-ID: <55ed443f-2918-4656-ad2e-cc2e2fcd4d16@linaro.org>
Date: Thu, 4 Jan 2024 18:47:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] qtest: ensure netdev-socket tests have
 non-overlapping names
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240104162942.211458-1-berrange@redhat.com>
 <20240104162942.211458-7-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240104162942.211458-7-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 4/1/24 17:29, Daniel P. Berrangé wrote:
> When naming glib tests if the name of one test is a substring of the
> name of another test, it is not possible to use the '-p /the/name'
> option to run a single test.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/netdev-socket.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


