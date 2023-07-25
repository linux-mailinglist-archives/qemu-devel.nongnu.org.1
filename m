Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C63AE7618E5
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 14:53:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOHWN-0002sZ-2N; Tue, 25 Jul 2023 08:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOHWI-0002sN-9P
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 08:52:06 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOHWG-0006br-ND
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 08:52:06 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fd18b1d924so44007425e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 05:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690289523; x=1690894323;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i7zHu7SSh0MD8kRumj0AWzzP6eSPN+HtUFdM1kHS/Vk=;
 b=ER3NEnUGjbk3GvFhxRdEnCCd6cbyMS3hMBgjxQtERqCNf93pOnNAmawoMRxhVmoE1Y
 T+bXkMJ+t2ALA0vJoQGAk7XS87X7PTrHbJAJXCTzsJMQOgPzGaUjwgQ+8UYQpDNKCnFZ
 SXNHHdozTqH33NHOITs4zs3GTaUyZTPiyOuCZI7+TW8vP2ODWvXqIAmqK4aWhD6OHfO/
 wb8q5nJUvsc7wcN10WHtryzPPxyJQT2ZGE6arYlpBjLav1B54w67R6ImtPtKeXK8g8Ad
 7uchdANFAbNGDegAwlW9cwxdLqQwWphKdZ4qMs1AAzGRwdCA2iv8h5gJnpNcne83QKvY
 ui6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690289523; x=1690894323;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i7zHu7SSh0MD8kRumj0AWzzP6eSPN+HtUFdM1kHS/Vk=;
 b=VYPa6UWfehzO6QbHlefm7GDViCzCHUAexu8aSBVf3A+qCIzdO0wMeLu9h7c1xFhjMc
 xBax634y7nIq6n4lVLV38lIjEnshTP+pkDXju0XOsMgMMkS590D8esI+ztxtKs3vn1Pw
 tSeczuCZgc7V09dAkz4EYE3duPrkABWY7pxfVq9A2R1+suW6errmBniO4TvSNNKXUoBB
 cfLHU286nsbMAbg3pPJUt3fidX1tmf0ZQFtGtz0EIDEInHa7qnbpI7e5jPHZJjYdagiI
 /vnCrzBFONiqwFmV0WXP2Nh05/B/HNemNDGyyPd+YZQVQl0ILExufJN64y0/dpGolx5e
 zhGg==
X-Gm-Message-State: ABy/qLYgxSl8orf6zbfgDefaLsS/XaZoSCg5FhXdpacTefqvce7B+nwN
 pQArpampEIKF/8aAONxTLAyu4g==
X-Google-Smtp-Source: APBJJlHvrZJzPfP16v1Xw4OydWJJqnyFctzS8d5B7YXh1DVKJW4RiWGrUmkfG9TM9jQJZstuobUr1g==
X-Received: by 2002:a05:600c:22d7:b0:3f8:c9a4:4998 with SMTP id
 23-20020a05600c22d700b003f8c9a44998mr8215531wmg.28.1690289522991; 
 Tue, 25 Jul 2023 05:52:02 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.203.142])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a1cf70b000000b003fbacc853ccsm13221552wmh.18.2023.07.25.05.52.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jul 2023 05:52:02 -0700 (PDT)
Message-ID: <76919f7d-62df-6320-84fb-80b00d2890a6@linaro.org>
Date: Tue, 25 Jul 2023 14:52:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] ui/dbus: fix win32 compilation when !opengl
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: thuth@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
References: <20230725112540.53284-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230725112540.53284-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 25/7/23 13:25, marcandre.lureau@redhat.com wrote:
> From: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1782
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/dbus-listener.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



