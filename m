Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1989B748821
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:35:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH4Vv-00010I-9Q; Wed, 05 Jul 2023 11:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4Vo-0000zy-EH
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:33:48 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4Vl-00075h-BJ
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:33:48 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4faaaa476a9so11123081e87.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688571223; x=1691163223;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Y1KsBqnihIP5maK7G9rJTqSvtj7Gzi7rL7r9S6vciw=;
 b=kejo1v0BZInk5LneCx65/36/IUqrbGMKNnILnQHDM0eOG6m9jGNkIVsjcXpL7yFhbv
 mTo/PXySUNVRXI5y+LRgKmAfJuIRH2Dd4s9YFGWdlnedOLiUxaL8+mn0Bnxbj9s8kT3L
 rV4j3WcHHgPLohxZzEkXnNiwQiYl2R2SSiHG0rkvztvpGfIiEqJp5BhkeV5Nk9DZUpfk
 vcBpzH8V4nIvw4wqnapVgas/1412HJl9tJTUqqO/eT4XblEgs6lOx9lcIxPajetGirf4
 MHN1ooisrhtvlTl0hWMEqAoMPRQJ5lx7WkYPBwz+38wGT1rLTAo9c7DS37YFejRz9fos
 kkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688571223; x=1691163223;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Y1KsBqnihIP5maK7G9rJTqSvtj7Gzi7rL7r9S6vciw=;
 b=E33vcUNMweV5lv5H9Eez1fEZgZVGfkAyhND0mdFXWstyeziiI/pAuYius2nXqaf/es
 S/FTKUeAccEd2ZDjakR1IzLCU6k2MeH2rXkC5AaW1/VLPadM+r9oL3WQF8/dEhkS3208
 +km/doaKiHEXhssWqxIfmM0eoyme77rNnL9I/5pr1FuS8ZoQcjQu+7fTfSx/CQvyG/BA
 CyKIDg/D0qvgckxGBaQoB2TrPWlwLVcPPN7uUmBQlTTt2ZyLMCpfze51cQxIBXlJZzWK
 XeoS0zAYuLR1Umk5pW0gHz6K/qh2ilTeCm+lX0ntnHeAf2YscTLC5pA0A4yZiDfcKple
 8O+w==
X-Gm-Message-State: ABy/qLbJloPZXKxRq8H0iKLz4OIpSm/OgW9QGDQqiK0iizuChfbYLWNy
 4zOJg67lrskW/QzWy0kCvboOSw==
X-Google-Smtp-Source: APBJJlGfanuxncTRl+YylybrHvVvK+yXYWBypUEfUBftcx8ve0julL/RwveYKMJdlg3L1Mh6ht9uRw==
X-Received: by 2002:a05:6512:3703:b0:4f8:7551:7485 with SMTP id
 z3-20020a056512370300b004f875517485mr9265758lfr.5.1688571223111; 
 Wed, 05 Jul 2023 08:33:43 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 o4-20020ac24344000000b004fb8118a1aasm4407267lfl.274.2023.07.05.08.33.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 08:33:42 -0700 (PDT)
Message-ID: <c341e2e7-c84f-fcc6-eec2-37730d4badd3@linaro.org>
Date: Wed, 5 Jul 2023 17:33:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 06/19] hw/timer/arm_timer: Rename SP804State ->
 SP804Timer
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>
References: <20230704145012.49870-1-philmd@linaro.org>
 <20230704145012.49870-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704145012.49870-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12a.google.com
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

On 7/4/23 16:49, Philippe Mathieu-Daudé wrote:
> Following docs/devel/style.rst guidelines, rename SP804State
> as SP804Timer.
> 
> Suggested-by: Peter Maydell<peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/timer/arm_timer.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

