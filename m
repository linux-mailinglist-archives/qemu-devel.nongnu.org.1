Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B59D74880C
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:28:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH4Qi-0006aF-1I; Wed, 05 Jul 2023 11:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4Qg-0006Zn-LE
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:28:30 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4Qe-00055i-Dr
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:28:30 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2b701dee4bfso9737931fa.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688570907; x=1691162907;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0IBAYmuY+LbwBLAajo03q3ectmCFo8tJaMl4CWIj3kM=;
 b=Yb8BU34VzgAe6K1+oV/qBJ/8Q0KFf2dVJzpDba8vJP2rpURgKipgR08lMSIFy5ovsq
 gNzD11LgacFI3g7tHqJsZ2whaSmBNTlus6tfImi2J/VXFdBeGF3kephTKmjBRwXMZZ/H
 RQ1gYmdpHxVriSOXlAs+MvASsdEX3ATiYAdY2DmoRpHnU/MLPWm/xC0/h98uN5hqwJl4
 yvdLn2/OZiKMee78M2ByRYm3dJpFsDM+R1eZL2trqs+SYqRA6+shzhRtMj6vn+HyeizG
 J+bvPjJVWrzFyWAHaYajRPRIqcjmFEsYLJfVACpufDbCcwceFwY8r0ItSPH56BZ7TkjK
 kJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688570907; x=1691162907;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0IBAYmuY+LbwBLAajo03q3ectmCFo8tJaMl4CWIj3kM=;
 b=VqPaHyi60npCsi0Or45UljzvXHUtB3KP0IxglJwGY3zSkqHwlHlg4Ulu8xRuDuOBRo
 1sLsbx4g43rGLzTfDSUze6C/vyTkUytRC/LuA8IhjtPpVSzRAklC75zL+1KTgF1lGtGQ
 99rSWVKIJkyb73/QBQCT3CD6KjxGJEnYbsFqV4zKyJv3kvY7zOEfHMIuM19RX1rqUA3r
 EKT9oeGWiJNd/QSMqLnrScFtsZRpMMt0MUC5qNbJnV3KPldXo/aeJ34bOUwXF+C/sade
 +Md4+Rrm5C5GQJu9ltaS+WLJpm5Ol7rCXzlqPZoTdUnXczkMGD4ChzxRQZWhiRFwDJT2
 RSWw==
X-Gm-Message-State: ABy/qLZmf4hzbQGFxkX3tgr9ItjMNCx4pW6OhJ44nybxtsNxK5q2Ll9T
 VozZ1zqIo2UIwBjUtM7lIwbgAg==
X-Google-Smtp-Source: APBJJlE1s0pFeuvP8NgXzA0KkagNjas1bGAv5NcGNKHiZTPmu8r0mls6oa92cXBsQoNpEuUEkcdIsA==
X-Received: by 2002:a2e:b703:0:b0:2b6:df15:f6c3 with SMTP id
 j3-20020a2eb703000000b002b6df15f6c3mr9237827ljo.39.1688570906676; 
 Wed, 05 Jul 2023 08:28:26 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a2e9d4d000000b002b69b44fd52sm5959691ljj.5.2023.07.05.08.28.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 08:28:26 -0700 (PDT)
Message-ID: <f2d70708-16a5-120f-0ca8-5598fc7b377d@linaro.org>
Date: Wed, 5 Jul 2023 17:28:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 05/19] hw/timer/arm_timer: CamelCase rename
 arm_timer_state -> ArmTimer
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>
References: <20230704145012.49870-1-philmd@linaro.org>
 <20230704145012.49870-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704145012.49870-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x233.google.com
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
> Following docs/devel/style.rst guidelines, rename arm_timer_state
> as ArmTimer.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/timer/arm_timer.c | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

