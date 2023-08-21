Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AB1782416
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 08:59:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXysO-0005i8-8m; Mon, 21 Aug 2023 02:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXysM-0005i0-0R
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 02:58:58 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXysJ-0005iH-RH
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 02:58:57 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fee17aebc8so16578235e9.0
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 23:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692601134; x=1693205934;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QFxbZiO/pT5PxVpZG1W7UCcNVdbtz6GnfGPZpI3G7cE=;
 b=H64Nl6vqpscqJfGE08UkDEzmVgRJPvXmeEqoiPHzvQLmeX7S2OFK4+Gn171UHh2+JV
 UZabJ6fNN7HNTjnjB1DovbPyqU/z8jJjJO1253jfF+g34/JQRm1HH98UiDgTTgPxBVrR
 uwZGjCTH1qw5UR5lVcyEyC5BWGJWAn4aKnsSxS11JpwJ1nRi2Oi68NORBQOuW9wbNPAb
 Sjb6t9dgxv0iaVntfLlJIUUzZ0OS4Eo7uOaKFGBTTjCFzjz29x+1IJXYHs+E+FSGKN61
 PIfVEvGbBoC9YEaZFpT4un2veoBSyaiZ6N/lDDIRU2+At55uhBy9hs4h8L+L/0A8iic1
 GlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692601134; x=1693205934;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QFxbZiO/pT5PxVpZG1W7UCcNVdbtz6GnfGPZpI3G7cE=;
 b=CsKkPVYfKlTvEZkGo+/ocLsLRxl87/iEY/NFo3si8okZgwDSiTJw8W1E16MQzXz3GJ
 7slLpYMJ5wx6x6ps9Ml8qmKTki9MhscUEhxkElQD9Dk+veobyINJwJFXDfZYHpiKN21k
 o3/lquB4XZ3B74X8YWxhBMdMepngLaEGNQIL5UWewgIa2QDNXZlk+z0x1l1yQSjTzwpY
 IW5NEvnYl/RJxG6+RWVKjLokaKk84JlTirRg0nZ8vdwUrt8IZx+RVJfoso73v2aXmap5
 eRneUuQVV1qKjXidV+BSXcF9Ak0s4LsCwcKORz0OgOtNSk6GTwK1tETrTHUdIUDZrWKr
 +Log==
X-Gm-Message-State: AOJu0YwEY1tcU+Sx/PGf26t38Mf21eE30MZU8ARxm3R+1MTghgWLk37m
 HIFOfsTvuj/GGBJAfCPD1XQ37j1P9Qk8iDhFkL8=
X-Google-Smtp-Source: AGHT+IGnR0y47SGch/ejKIeFs2YbAUn7q7jGDePNgJtf1k7NeZRIikTuwh0bV+tCBeXbj1Lg5Wk8Og==
X-Received: by 2002:a1c:7c0d:0:b0:3fe:dd94:2af6 with SMTP id
 x13-20020a1c7c0d000000b003fedd942af6mr4308748wmc.12.1692601134205; 
 Sun, 20 Aug 2023 23:58:54 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 k20-20020a05600c0b5400b003fedcd02e2asm8599166wmr.35.2023.08.20.23.58.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 23:58:53 -0700 (PDT)
Message-ID: <aec247c0-8fc9-465c-774f-00a47202c6a2@linaro.org>
Date: Mon, 21 Aug 2023 08:58:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 26/33] linux-user: Deprecate and disable -p pagesize
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230818171227.141728-1-richard.henderson@linaro.org>
 <20230818171227.141728-27-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818171227.141728-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 18/8/23 19:12, Richard Henderson wrote:
> This option controls the host page size.  From the mis-usage in
> our own testsuite, this is easily confused with guest page size.
> 
> The only thing that occurs when changing the host page size is
> that stuff breaks, because one cannot actually change the host
> page size.  Therefore reject all but the no-op setting as part
> of the deprecation process.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/main.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)

OK, but missing updates in docs/about/deprecated.rst
and docs/user/main.rst.

