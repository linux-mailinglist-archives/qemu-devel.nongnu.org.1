Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 234D77F6581
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 18:34:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Db1-000446-7X; Thu, 23 Nov 2023 12:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6Daz-0003x2-Cq
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:34:33 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6Dax-0001Qy-Ok
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:34:33 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2c50cf61f6dso13463991fa.2
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 09:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700760869; x=1701365669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ga/ctq7wtLLO8DBQq8FXYJC7uPEM2Wr720WzVAYdG/4=;
 b=adCIpmI6AUlr1EaFDoz5Rl4m0fvOOttGjq5nZZLmWuTNyn3/0i6jiyzlKVQzZj9MWV
 SDtbc2UX29JGtWYxrs3CmBGI73gxTFf4jz5AB+ggpGn6yu/RXpSa+NlD0WqPhWgBKHhY
 LX20Llfdu7q5MlMxR+4oqejTpIhPqyzDtrkDxA9VmZQzpxrPuMLntZ+EOfjSlaESO3/H
 FUk+73YWxE3H8mACUCn2ocOy5lUe5H81IzZ5wb7SnmaSDclWsNgfcSKQ/towibJKI9xx
 b7OVGkPdJtHWbqMiSBdtkNcvcJqLhWnV4ldl0dV7qOuoKx+uIN/IkAYP7OYveZXqL5W9
 xCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700760869; x=1701365669;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ga/ctq7wtLLO8DBQq8FXYJC7uPEM2Wr720WzVAYdG/4=;
 b=jk51fzVlVbTh1g+C93J6ge7Qa8OMD2FK9qKbSq9JlKzreqFArDjAWkf09F/DmlWGpn
 EUa2JzeXHIyqHhPTqoiTuPIHeCNuNXIO07RAismbvRVlj3AQO1gt9mbw9OWPujfIMFVk
 yoXhO1W6lU02kn/4Uo0CeP911WUmDU63evCWDnjh6j003kBimLybNUdTLGBv3hO14qXN
 MCYOTdxK6t0BicmrB+6BtJGL5bIIWtXY0KpQ7NAs32e7V6P3VK5zErSx052XPAILCgPM
 eiFjDF3QJEBcQ+/iOyB3m5CShAjIR4QDU8oEcSgUBMmppzS2JONtvqBujJAfxylJEhZh
 e9Kg==
X-Gm-Message-State: AOJu0YxQSiJgg+oE8bIErGpEnUc/f8/6BFj6e7xxvwMMXdqOHKEzJcog
 QlufViz1JWdIPfgFzsBXZcbkrw==
X-Google-Smtp-Source: AGHT+IFueYayfmcGlspwcQZC/n0E3w5G+6UUKhgA6i0te3pUj8HFqtxbWSrRQYUqKLP6ePQ47SVWsw==
X-Received: by 2002:a2e:97d8:0:b0:2c8:83c7:4046 with SMTP id
 m24-20020a2e97d8000000b002c883c74046mr49386ljj.26.1700760868943; 
 Thu, 23 Nov 2023 09:34:28 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 be7-20020a05600c1e8700b00405442edc69sm3305072wmb.14.2023.11.23.09.34.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 09:34:28 -0800 (PST)
Message-ID: <ec96f592-63ae-424b-8f6c-dc8332744f8a@linaro.org>
Date: Thu, 23 Nov 2023 18:34:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/21] target/arm/kvm: Unexport kvm_{get,put}_vcpu_events
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-20-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123044219.896776-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

On 23/11/23 05:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h | 20 --------------------
>   target/arm/kvm.c     | 20 ++++++++++++++++++--
>   2 files changed, 18 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


