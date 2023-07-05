Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD7D748808
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:27:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH4Pw-0005k1-80; Wed, 05 Jul 2023 11:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4Pt-0005gD-1w
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:27:41 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4Pr-0004yf-DP
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:27:40 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2b63e5f94f1so11443461fa.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688570857; x=1691162857;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qwnkgetev1KB0rzWA9NREXqYVq6GTHJnqsshlco6sxA=;
 b=pfpNCMfCpybgObI63lxGKWkKa1LHj/GN+9+TsMZPII0Fu+C6Slvcs5gLmnhM7leIIL
 VRVL7xAtHyFkmqfQWDt2RclVlIVNrqZdGVpNxdCO1IFa0PLJZz3EW1ohsjivGel258os
 E2lrMDycDU9A027O7kipWTmlSwTbOPvO2VdkdySjukbJod9lZU2wtt+wrx5m0BGLfbm9
 o7k+QpwPraYs1xpcsZJPyuBN7q0fEblYIkP5DqnlpV410jGRuR3EwECKVwUmeeaSJie9
 n7gaqag9ampO1GVohPpSTrfXS+I1H0Zx3IWv2mMdivRbT33omg6wXXcHkbOha2PlQX1Y
 b2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688570857; x=1691162857;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qwnkgetev1KB0rzWA9NREXqYVq6GTHJnqsshlco6sxA=;
 b=DGxJ4EHxq3+SCobADYa/xRjufraWwV2uC3FG9QMRCJOLnAF7MO2tVOfdBzgOWX68Vz
 qga5kWcjzbormf4jMwIPOAeI3mPxD6mbAzVi7A62WjJsKocdbBSpGDWyEWzkMVOfMTYO
 SiZt6XTf/9Wgetb9iQLUYjoZTh1goKTHyZ7L+O5djqFSGz9THnTqVjPsdsdFo2o8mAe3
 csTVfYL/PnIzLAlecJCYK6yGzilvjDJ7aAgZwNmMMIyyB3FjKDSQgXIgcjBcEUiSl6ji
 FPW725L4kbdZPYSebH0sttZ3QjecVuPaarLFEsJg/1c/6EbeIXEKbUAvXqG0eh1nNLKQ
 2WAg==
X-Gm-Message-State: ABy/qLbILaBCftFzCTfjs3OTEVH+uVftF7OeFggU+/TcagiGrvVlqcs8
 5ilLG3Vz+HZOMca990l6SkO3UA==
X-Google-Smtp-Source: APBJJlGiBqccVf8lJCJh1c2z6gD6hL9htpktBKmq5g3w9rhdaoK8LeNtwxqpLe8C9YXlA7o4vVC+sw==
X-Received: by 2002:a2e:8613:0:b0:2b6:da61:d5b9 with SMTP id
 a19-20020a2e8613000000b002b6da61d5b9mr1041568lji.14.1688570857579; 
 Wed, 05 Jul 2023 08:27:37 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 w9-20020a2e9989000000b002b6ea4ed1f0sm1737015lji.14.2023.07.05.08.27.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 08:27:37 -0700 (PDT)
Message-ID: <1a834dc8-88f0-ecb0-c0b5-b3dbe2b9bc38@linaro.org>
Date: Wed, 5 Jul 2023 17:27:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 04/19] hw/timer/arm_timer: CamelCase rename
 icp_pit_state -> IntegratorPIT
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>
References: <20230704145012.49870-1-philmd@linaro.org>
 <20230704145012.49870-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704145012.49870-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x235.google.com
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
> Following docs/devel/style.rst guidelines, rename icp_pit_state
> using CamelCase as IntegratorPIT (PIT is an acronym).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/timer/arm_timer.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

