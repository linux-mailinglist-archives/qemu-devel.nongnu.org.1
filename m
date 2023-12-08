Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF14F80AB93
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 19:04:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBfCk-0007sG-0p; Fri, 08 Dec 2023 13:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rBfCi-0007rp-Hm
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 13:04:00 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rBfCh-0003VP-2j
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 13:04:00 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6cea0fd9b53so1803120b3a.1
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 10:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702058637; x=1702663437; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Ms4tiPC1ZmN8F70HyZxgZ/fRIv9iz33jofa2pZkHOo=;
 b=Tq/0qDc+htTbtIVJbMiTPreM4dP4I8P8osXh8WAacgaxc2RJFp0qp+7ZJ3FRbda9TP
 Kmy1avuM8IhnN0Jho1E8jwKBUfeXy7f6cvoXr5hLxKEGM1auWW5Ysqe9lj1/xtVh/gIZ
 crJyVh2bIh+fdwVnIAgwkIvKeG8AiArnFuEiDdufnjOHcbbwoEBEKWmiYZVSbld+JYHK
 Dj5U2pOVf9Kuqdk44WmpzS4E8+O951PsI5+kbYlSrfQAAvWno2P/LWYCTJymK6VM0ZRq
 HwomP37P2CzHA5h0NgaP07cpvxsOW1Nx11Aa2Kd4efN6+a3dGS00TrGRrq4JPN8WZjr/
 9aYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702058637; x=1702663437;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Ms4tiPC1ZmN8F70HyZxgZ/fRIv9iz33jofa2pZkHOo=;
 b=u8zW+5Hjdn0chSlqgKovSJAvN0p+swD1AOXUaepVwL5ZwBirBGne/kmQli2/fueJS9
 9Ni6n5v349AKb/CjvvSug4rbGT7hu/7pkAIsYAtOUtIZbFr/TBiiZMEbLNCuJqALpad3
 Ddzf57WJBMPOwl+S/7b4nDVTgPVyb1td6kUb3Bx1Da8R5ITL/U+X37VLG0hUKsjuUjGx
 Z4g+emB1rdcUBXRtvN8kta2/ulBHasgeq11wd6vqFrfS+SOBVPv3OMVP+sK6Mj4jYcrs
 52lb2cB+z7Kbh+4JUezYvsSZWGurCiHdZJLyJQBeCzxg4XM61NAxxfOtOl8UHOrLrv+k
 TYZA==
X-Gm-Message-State: AOJu0YwDtifRS3clvshtb44cDRQtANZgrciAGyB/5mJkJKQoERDkEIXR
 U5VwUHDSJjv100wBFysRiHzizQ==
X-Google-Smtp-Source: AGHT+IGtXimq8gzef3Nn4mK57YdtSFt8Ok2ka2KUWFuwinLIFr3rN0dtXkRv4JEKD3ViBf4eElC5CA==
X-Received: by 2002:a05:6a00:6714:b0:6ce:379c:ced1 with SMTP id
 hm20-20020a056a00671400b006ce379cced1mr356172pfb.59.1702058637479; 
 Fri, 08 Dec 2023 10:03:57 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 n24-20020aa78a58000000b006ce4965fdbdsm1867520pfa.116.2023.12.08.10.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Dec 2023 10:03:57 -0800 (PST)
Message-ID: <d728cf97-e2c7-452a-ab32-64c14aef9113@linaro.org>
Date: Fri, 8 Dec 2023 10:03:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] sysemu/replay: Restrict icount to system emulation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Fam Zheng <fam@euphon.net>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231208113529.74067-1-philmd@linaro.org>
 <20231208113529.74067-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231208113529.74067-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 12/8/23 03:35, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/sysemu/cpu-timers.h |  2 +-
>   include/sysemu/replay.h     | 11 ++++++++---
>   stubs/icount.c              | 19 -------------------
>   3 files changed, 9 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

