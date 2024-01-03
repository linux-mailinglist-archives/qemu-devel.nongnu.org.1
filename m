Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6FE822C2D
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 12:33:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKzU4-0003p2-KB; Wed, 03 Jan 2024 06:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKzU0-0003oh-Q2
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 06:32:24 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKzTv-0001ln-9t
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 06:32:24 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ccbf8cbf3aso96504311fa.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 03:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704281537; x=1704886337; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Uw11SI08AfTXeQE7SXpzipR7L2b7UEXTXmofT03JLU=;
 b=df/yCP9lj6Q3UTCHjzr3zkwO2EgEt26PnErO6PRpRXN8uhkyxLL+N8q8nbLdZlh+Y4
 p7j/uJrSIEx54zseaA4hCVUX4GbNj0ZQYUEBxP2zzBtC4DiD4GVIowqIQDiXMgsDhFC5
 kkWRzg68VukjAEQu7Qqj/Nu+YH1NTD6RS3XWeIOtRAzw6mIuFqRDbr1rGr9pY7XFpTQN
 Lak9dzA/pVk+VXv1RWQYK3HJYPGA6skGt5aLIARp+wO8uBVQ41rCQzZTGDmusUA54S1b
 dgsQhtP/Y8oLRSprTW2nLVwtZz3+qKvwQb10xN9fgpk9eGfRU+mrUX2q23iF24BwkIXd
 pcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704281537; x=1704886337;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Uw11SI08AfTXeQE7SXpzipR7L2b7UEXTXmofT03JLU=;
 b=CKN1c4qROfUN6/bybx3BB2M+Oa7UFirQa//N0U95l7ulpdzCAY677kt8DihF7O+VTr
 n4Rojkz+U81pSLSkqc+Y8cAlg3jT2m5s5IG1QuM7xuxubH+Oh03i3YbNjbzX7O/I+QEb
 ILliqkmydjKTUVhs1YZBLJvWQdR75FVWw+UnjoyXIoUMs7SZSn4JOCuo+1bcseYOPrfs
 o+DMumSD+HPwm8gj/kgDd2cMaphE4C3Kn2M2lYwgVMaemBzDX7+7WxxrJT3YJxnDstfn
 cLHen8W/1cIIOEkkMeGbsoTnXfk219dIoBmNHPUp1aBzmvC96gXFgeRfFCOPu1lFEli4
 2R2w==
X-Gm-Message-State: AOJu0YyqcuIbnHetL5m1v4wfEIBhYpQoS9Dtbcm7s2wk9Q1T/WM83zU2
 lLinjSAkEuSNZw9tvmggahNWs8sMp4bXQg==
X-Google-Smtp-Source: AGHT+IFbclPYLG3EQIABvqS+Urv9s0DG419U8bS17o+85hN0la+BNJibuON7BMmYuZeZ/m6YLj3I2Q==
X-Received: by 2002:a2e:a68a:0:b0:2cc:5864:f3e8 with SMTP id
 q10-20020a2ea68a000000b002cc5864f3e8mr7565247lje.98.1704281536823; 
 Wed, 03 Jan 2024 03:32:16 -0800 (PST)
Received: from [192.168.69.100] (tre93-h02-176-184-7-144.dsl.sta.abo.bbox.fr.
 [176.184.7.144]) by smtp.gmail.com with ESMTPSA id
 c9-20020a056000104900b003368849129dsm29757242wrx.15.2024.01.03.03.32.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 03:32:16 -0800 (PST)
Message-ID: <3eeb7394-d138-4a27-b2d3-0b6aeb9c5205@linaro.org>
Date: Wed, 3 Jan 2024 12:32:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial] audio/audio.c: remove trailing newline in
 error_setg
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Martin Kletzander <mkletzan@redhat.com>
References: <20240103111800.250151-1-mjt@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240103111800.250151-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/1/24 12:18, Michael Tokarev wrote:
> error_setg() appends newline to the formatted message.
> Fixes: cb94ff5f80c5
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   audio/audio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/audio/audio.c b/audio/audio.c
> index 8d1e4ad922..7ac74f9e16 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1744,7 +1744,7 @@ static AudioState *audio_init(Audiodev *dev, Error **errp)
>           if (driver) {
>               done = !audio_driver_init(s, driver, dev, errp);
>           } else {
> -            error_setg(errp, "Unknown audio driver `%s'\n", drvname);
> +            error_setg(errp, "Unknown audio driver `%s'", drvname);
>           }
>           if (!done) {
>               goto out;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


