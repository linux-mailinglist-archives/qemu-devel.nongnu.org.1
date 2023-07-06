Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 157F574A288
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 18:52:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHSDS-0003dS-BQ; Thu, 06 Jul 2023 12:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHSDR-0003dI-4k
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 12:52:25 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHSDP-0002jn-BE
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 12:52:24 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-991f956fb5aso113095166b.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688662342; x=1691254342;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ikuNgDWY6W9yyr9/ymfDu+WXJaFVezLGC2wIptEcjKs=;
 b=LeU3/k3lY31XvBpuYPBFChcwj9lA/zkGh6Bk647NpptPpG3dtPfb3oz+h3punUMZZy
 uYuiE3Qmvg8WTlEzDJZ88Rz3LTCtxwPgoh17wofMfD8I2jopeziq7haMzcdUU9+xoDNo
 qXSLu/hKaaAavV/MGT6mB92lnzfyf18X6KrUd/T0MMMvMtEpQBa/jGorN0EZRqNCHjcS
 R5+bfr9QdPonlIYF6Kg0a6SCYEq0YxtugZldfA0BoHiXnrNoQOKKPpwNvTuCpXHwdKb6
 Kmjxj8SWpbGbafg95+sRGDyblL+1LBUKrcx4eWd1cEHnptVf2XijsiZlrcSX7+vpTlNx
 JRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688662342; x=1691254342;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ikuNgDWY6W9yyr9/ymfDu+WXJaFVezLGC2wIptEcjKs=;
 b=f4qPPdzLNZoAzmsgyOIkGgQxxGU70oOaHn15dVtAFpF8DgBxxeX8obd6VdYXitEsSB
 HG4wrx+fxhnCWubDAEoF+r6W0/wlPlVxsOQHbpmxQBQxSOeJix0GiG9eWJX7MqMKATfu
 m7qET9V60eoH2LHDe7eT9LpvRBHfC03RgarMwkczSfeeS1Xva0ouPzP28oNTbDQ379TI
 uJv10qgO/hEh5COr2FZN301EdDIiLcDUfHj90QLtk0/anCyaeTykScUPOTAU3KQITBaC
 8ksGyZzdlv4sYOotwmWZtWO+BULE9N0NAzIKansmkoNAs0jiyPJMLMv2kvej+mGjQ1Pi
 s+Nw==
X-Gm-Message-State: ABy/qLY6vFutvvaW6+OQq5pXg1IQ8q/alqmR/RMc+3PaPVKdV06uhccD
 1OhhMpkfmduuh02dz2TeergbMg==
X-Google-Smtp-Source: APBJJlEfBLerxO0sf6S+7zMzDl7QNc74JV0hrSKb8uCQoVFhg9QJnR+Jf0pMbhhLl4yce6cHS2YXMQ==
X-Received: by 2002:a17:906:116:b0:988:7d1:f5a5 with SMTP id
 22-20020a170906011600b0098807d1f5a5mr1925834eje.28.1688662341791; 
 Thu, 06 Jul 2023 09:52:21 -0700 (PDT)
Received: from [192.168.1.102] ([176.187.199.225])
 by smtp.gmail.com with ESMTPSA id
 a13-20020a1709065f8d00b0099364d9f0e2sm1037663eju.98.2023.07.06.09.52.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 09:52:21 -0700 (PDT)
Message-ID: <be80fac9-dad2-bd46-a1e3-646f56337dea@linaro.org>
Date: Thu, 6 Jul 2023 18:52:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] tb-maint: Document #ifdef..else..endif correctly
Content-Language: en-US
To: "Richard W.M. Jones" <rjones@redhat.com>, richard.henderson@linaro.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
References: <20230706134314.907591-1-rjones@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230706134314.907591-1-rjones@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 6/7/23 15:43, Richard W.M. Jones wrote:
> It was hard to tell from the comments whether the code applied to user
> mode (CONFIG_USER_ONLY) or system mode.  Fix the comments on the #else
> and #endif directives to be clearer.
> 
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>   accel/tcg/tb-maint.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


