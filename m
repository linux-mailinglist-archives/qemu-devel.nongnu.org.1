Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 684A27A1A82
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 11:26:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh55m-0002P3-57; Fri, 15 Sep 2023 05:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh55j-0002Ok-Bv
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:26:23 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh55d-0005iu-Tw
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:26:19 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9ad8bba8125so256225166b.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 02:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694769976; x=1695374776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l9ukh1h+4L0kAc4ZaM/lzzLnBl5UDroNP1+I7XM4rRk=;
 b=ojb17reAkRQv9DvyLQCVXkT7NFk/mXQZXA4iI8hNSL3a9dY0VRgV8I4EmgnrrKFw95
 7p713Q7XimkFrETZMLrArZTeOmcE5U+4BjEzUc9FsQUri8ZKyKyMVgXPRwJRdrw0bOhr
 WvO2fmeEud9dOt8pPWE60wS4U1EvW5mvaCklm0ifG5XABvPnNAO6IyMbovFJsWKYQ5/b
 2JwwzZ0+4+k/ldWLUcgPU6Hu8I2NWdZFxAPmlldU7mnFWsMLeqVXy8wQkxfi4jDD2tdx
 g9CvhKBM88o97n3MAnO3XYiBIFs0Q/C9OErhIAL7F0kMf3ulqIrLI4nDBQH1eO/rKUmD
 tYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694769976; x=1695374776;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l9ukh1h+4L0kAc4ZaM/lzzLnBl5UDroNP1+I7XM4rRk=;
 b=lUcsvfV9tk4Urzg/dI8VOQo9juAgblZ/Uw29G8wR9mssYUQAkRyMZ3NpO2p2IYSapr
 rPBc+50ePr1BR937cYDmuBKKWk2H0r5i+JJiBchmXGwd6pqvl1NT8eCtVxguSp9v4iLc
 gOoX8PMYa2JFRzM5gJddj9/aR9GwJ/L3B4L7yRf2QDQzAXNjInX6R00pMjoLoiIipQJ3
 B/yiT1xilfm3O21AzaFAEUHt7g4rxjD/gu1cvvtgHH7JGwWTbzvx0W6qqMb/4cYOdQYF
 mPkk2+f+ASS9yhMLWeXa+JKkt6EjQJAX5o9+qjj/ZD3E2yt7jj6CtKHyA9YVYiwjNkVT
 U43Q==
X-Gm-Message-State: AOJu0YykVascdWbBct5oaSldGFA8pmDxKg3/ek9NMvuKgli6W+CLY/dK
 9xvXKNYRkAbAtaOSVe4thf1cYeCYPAZXoTCNZhs=
X-Google-Smtp-Source: AGHT+IFwlbP82U00TuVcOINKE/9IZStoVckxiVkJKn2wG2AwShiRJCfeL+taditkOiJXjwAR2qcTow==
X-Received: by 2002:a17:907:2e02:b0:9aa:1020:8c36 with SMTP id
 ig2-20020a1709072e0200b009aa10208c36mr947639ejc.27.1694769976237; 
 Fri, 15 Sep 2023 02:26:16 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 u5-20020a1709060b0500b00988e953a586sm2145619ejg.61.2023.09.15.02.26.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 02:26:15 -0700 (PDT)
Message-ID: <ee6a71f4-67bc-fee0-d08f-e98a29df4bb8@linaro.org>
Date: Fri, 15 Sep 2023 11:26:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/6] accel/tcg: Hoist CF_MEMI_ONLY check outside
 translation loop
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230914174436.1597356-1-richard.henderson@linaro.org>
 <20230914174436.1597356-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914174436.1597356-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 14/9/23 19:44, Richard Henderson wrote:
> The condition checked is loop invariant; check it only once.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/translator.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


