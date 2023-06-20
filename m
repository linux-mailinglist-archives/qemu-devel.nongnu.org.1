Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F15DC736977
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:38:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYjK-0002fK-73; Tue, 20 Jun 2023 06:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYjI-0002f3-Mz
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:36:56 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYjH-0003pu-6Y
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:36:56 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-970028cfb6cso721920566b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687257413; x=1689849413;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O9ga8tYOdAQ6oSFUtJupeoQHlL8OIYMvxoToFtmGYzo=;
 b=TWMMPv06/Q6NrAfgdvq/oJHIrYgspVe0C5tLiLgVUdKIjZ9lGsI1vZ1PoNRBZg838R
 dcic3QlpCT/PSNe7s7sD6GSMqRsQzaSUuI9a7QfU3uQ+qSUXNw+z9u9edYMea/gDg4PM
 xtZcgXBl3OUmrspJ4oNIVxhc1BAxM+UoDpmNu6uGYkyfjLBMcujS8ydD7+84v7il0K2m
 wrWI0+2nVtOb+Ki95ZWMURAuzmn/bS70FmqLzHu5TWpYSh7NdUz8fylmlgdWATU65W28
 1xXOm0WbCoQPOXQTk3WqEJJ8axVQKM7mRW4VsusRCFsntJLWQ8wnJYVA5oBOpoL6qviX
 3kUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687257413; x=1689849413;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O9ga8tYOdAQ6oSFUtJupeoQHlL8OIYMvxoToFtmGYzo=;
 b=K7XazAAVRDsy1NJCJqmoq/HSsN0Z8+CnQFDzk8Wy5WxzsD9dCCipV+q6g/At/mRzgG
 M6mtOV8M4hG7hp+vPvEP8XgJckoPntN/+Sk1v/s6zOUXuQVf4IItXzYYDh3AmkBC85qX
 lLdWozCFhEjC600n1rjgyng8OctmyXfG3YsNssLk5yWNkDE7oVCI4RCAIerA3jVs+Pb3
 g65s+Ug/s8G43XzLOsMEgQo5lJervNzDesfv1DjqM+On/Xcx/NilyiHm7UveRoqf/Axn
 uEquVzZUFaGxJUleo0bbd5zRQDL+nOoIJmUKvvpmsXBNkmrj72+AwGpm38nqFTAKQvR+
 hRfA==
X-Gm-Message-State: AC+VfDxTXIvqDgHFwfo9eiXlAK4y77nyWWYgdm5woD7ODg55pXjqxVFn
 kUtd7cMTUXEDSYfgdOv5m+gHwQ==
X-Google-Smtp-Source: ACHHUZ43EeW4S8Nw1mPjaln1KDNz68O3ORJv0ks0rgG/BhACDkMCbwjuCZ7t7+nifrN/XGzLe066tw==
X-Received: by 2002:a17:907:6d23:b0:988:6526:beaa with SMTP id
 sa35-20020a1709076d2300b009886526beaamr7199192ejc.40.1687257413477; 
 Tue, 20 Jun 2023 03:36:53 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a170906170f00b0098314c30e8fsm1122741eje.46.2023.06.20.03.36.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:36:52 -0700 (PDT)
Message-ID: <69782bd8-7002-e2ea-97b3-3784f1961eb3@linaro.org>
Date: Tue, 20 Jun 2023 12:36:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 21/34] target/arm/tcg: Extract crypto definitions to
 'helper-crypto.h.inc'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
 <20230619155510.80991-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619155510.80991-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/19/23 17:54, Philippe Mathieu-Daudé wrote:
> helper.h is used by all units, but not all require the crypto
> definitions. Move them to a new header; the next commit will
> remove it from the common helper.h.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/helper.h                | 37 ++------------------------
>   target/arm/tcg/helper-crypto.h.inc | 42 ++++++++++++++++++++++++++++++
>   2 files changed, 44 insertions(+), 35 deletions(-)
>   create mode 100644 target/arm/tcg/helper-crypto.h.inc

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

