Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0656D7A5DE0
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:27:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiX0W-0007d7-MT; Tue, 19 Sep 2023 05:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiX0U-0007cu-Ui
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:26:59 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiX0T-00023y-CX
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:26:58 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9a64619d8fbso719143066b.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 02:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695115614; x=1695720414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CvRkateWKGghAZIfopB4iDeP8dh02ZUSRDMgLXzAsSw=;
 b=DwVJuphq3KuW1ySB5tscZ0k06kaagLtp9qYtuYd1oGWOVG2qgOGd8G8QUYQi5e5gz8
 wxZd163Zgob4EC5BYf4WV4Hp6XdfVwIBVOXJvjwlUbV5mrJcLrwxmZV62XR1QGRJ3hr5
 fdZiXG7qrIXjCHTSZ7QRwehKOZEyDakwfOu9luEI1bWJnH057qFxpaVeO2WPwbVdv4Xg
 sD6BimKOczCkxBKxg9NB6/iCGLyjf3wzClcBkvIKy5fZjh6hEHI66+fBrZNXQgWAJz95
 zR95lWm5F/AxCV+DG9ZvhQjDuKyiCf7yaZsh44KoS8QqeNpLhjE1XE/AlQLWlGVKwXWa
 amqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695115614; x=1695720414;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CvRkateWKGghAZIfopB4iDeP8dh02ZUSRDMgLXzAsSw=;
 b=clnJC2x4+m1fH5Q6vdFme0luDinDyNkZ0Cq9xW6+vSK8NH1k4U7m3c1J9jTU+GxO2R
 c3AMOiLlVes5s/Y95a5v1gGjF4r6Vx1Bopiqv5Oe7InVysDnKlS1mlD2KzMUjgvAr3Pn
 xZd9kT9/A1WTdJeLIUrUqTxNwaPCxKuzBRhBg8lyF5c1Mf4FfLvP6GTOnmqfPgneXK8d
 YdKwOypQ9VFe3xgZOcl0lHuTT2VWAqgacF1CBpUXINWrLytQuUfatdEVyfSgJ1mVZPaf
 K2Cq7d31D5BuPoKeQr+yuK8GQxCYSSdGsLMI9Uk8jpJomZwAyHfzViaLOnqUo/xaKVp6
 YDmA==
X-Gm-Message-State: AOJu0YzVvwQC6KuhcFNFPyp9dbPI4Kosej2+pPaaO2ITfaBjSQbupf1c
 MwabrKL31+BhwZNauuQ86dIeEZ2nhHNtQ0C/fzQ5Lkoj
X-Google-Smtp-Source: AGHT+IEqprqbHQlEfxOVIfz7cJt5xzAuSwhwyQVgFGRQMpaO1vkbOgTHWl7+f+385Fsn0luiyYqq8w==
X-Received: by 2002:a17:906:538d:b0:9aa:338:4a0f with SMTP id
 g13-20020a170906538d00b009aa03384a0fmr10741037ejo.72.1695115614139; 
 Tue, 19 Sep 2023 02:26:54 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 n26-20020a170906119a00b00997cce73cc7sm7464752eja.29.2023.09.19.02.26.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 02:26:53 -0700 (PDT)
Message-ID: <dc531dfb-38e8-d4f7-4e52-0d7f02db9d26@linaro.org>
Date: Tue, 19 Sep 2023 11:26:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 5/6] accel/tcg: Always set CF_LAST_IO with CF_NOIRQ
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230914174436.1597356-1-richard.henderson@linaro.org>
 <20230914174436.1597356-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914174436.1597356-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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
> Without this we can get see loops through cpu_io_recompile,
> in which the cpu makes no progress.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cpu-exec.c | 2 +-
>   accel/tcg/tb-maint.c | 6 ++++--
>   2 files changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


