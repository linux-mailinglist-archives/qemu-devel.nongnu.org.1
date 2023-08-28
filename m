Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6807C78BA38
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 23:26:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qajjG-0005Um-O8; Mon, 28 Aug 2023 17:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qajjE-0005UQ-HE
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 17:24:56 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qajjC-000449-7n
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 17:24:56 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-401b3ea0656so33389375e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 14:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693257892; x=1693862692;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+2/mSJnE23di/guQDqFnzAv1rjKxm12MorlzV5MKFf0=;
 b=Z0+I2X0PbbksvU8HJMomPYwAmLaZ9WghWl7Lh6TA4uk4uzNyZEPszkMD/kCv3C1p66
 XwArQEXGpthrncfqZNO50V7mKgp1E4hNA/GYAKVrQ3ft1w0St8bIsdNR/la2klfERTFy
 9W5ayyHB8av3Foqw5cI/hmpL/VhI4Co5B9TYkjV+ug4optkob2xav22TC/KA/pIEpm7q
 T12E8cjDErDt+Ido7rmmBantSrmqbrac8gGL6aid1F8IRwqj8IgOl16Mb/CursuLv7Qw
 UA1zN4zM7Qs6QGdHXb41Yy94PY6TyFKcbg5swPoS/Jq8EqEWHANoIkXCI/2REkJcUztk
 qswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693257892; x=1693862692;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+2/mSJnE23di/guQDqFnzAv1rjKxm12MorlzV5MKFf0=;
 b=jS5XKgEOR+5jnALjwCuOabQJo4qxzltoLnHAdFDCcUjmUTCCNLQ9/HVhYfqVMOgCMv
 BEaYMoZlP2HcJuIZVaKP1H0F6gXq+DTIbeX2srH6ijQdH1Gj/ZdaGH2fLPMXdEpwa18X
 MbXYsEG7cMEXcWxDErR9WKv0kzd5FEQ19ESCLh4wONxvkJwEoVale9SLirQD2XnIdSOA
 sFt9WpLtlDa19q9mxU3riY03GOIKQfMSV1Cv9IYqkQrq3GmqToFMQBT0EzZg0hxj5HSk
 m1DU9+tEt0x/iBrhjluTunWXKK2wPdrPTsoagrjhm5+ABhoAdUjfPVSUW6FVFbq5O8xw
 fl4w==
X-Gm-Message-State: AOJu0YxTXaIXboBUbue8UK849b1ykTlH31QIwzeamC3wCZzPm2iwg5HN
 GrggbjumneDoqbdou/tOvI5+AA==
X-Google-Smtp-Source: AGHT+IGBbrVjvXnP9hguI/iU3YJHEjcBT60X21FiKfu0PlDiV5wIh5pwrQ5xzSGY4PVhHBom/aczNg==
X-Received: by 2002:a05:600c:b44:b0:3fb:a100:2581 with SMTP id
 k4-20020a05600c0b4400b003fba1002581mr21435960wmr.14.1693257892093; 
 Mon, 28 Aug 2023 14:24:52 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a05600c210b00b003fe2b081661sm15076549wml.30.2023.08.28.14.24.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 14:24:51 -0700 (PDT)
Message-ID: <1ae263db-4687-142b-17df-0bcacf41e308@linaro.org>
Date: Mon, 28 Aug 2023 23:24:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 02/10] accel/tcg: Split out io_prepare and io_failed
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20230828185550.573653-1-richard.henderson@linaro.org>
 <20230828185550.573653-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230828185550.573653-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 28/8/23 20:55, Richard Henderson wrote:
> These are common code from io_readx and io_writex.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 77 +++++++++++++++++++++++++++-------------------
>   1 file changed, 45 insertions(+), 32 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


