Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D1F79AB65
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 22:54:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfntl-0007hj-Bg; Mon, 11 Sep 2023 16:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfnti-0007gs-KQ
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 16:52:42 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfntf-000166-6O
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 16:52:42 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-99bf3f59905so611700866b.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 13:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694465549; x=1695070349; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jZK6J0Iw+GRRfVdiIGlnNRot0/j+/zYmp3yZ33I+GHo=;
 b=qVHP1GyBAaVoAc+yM4ga4E9jMYVaOajxjP2s5d/g/BgOogbw0lW8mif9/VPmuEDQu0
 1NfnSNBtwxrGfozjyC/uttzZfH3lZFDLKo26YslNX8FoUxIDZfZms1dvpVoX/Izr54kd
 fIc8CNczJSmf4/3XdqFybuCaZqjCBnurMahr//wQSA8SDLs1z3Z6xIZkPEFvGJGm7W/y
 P9G7SIgjr+qZ2lHkfnpdK8/PFuqipsfTmkzGi6dOl/FyXgTm8nFQc+VUhFiIBcNE1ceT
 q325+c9+f/Ajhydo8DeUR3S1OGNV9W1i1JNjUFyIYNTAQYf9/VRpxk/gT882UfsU39Z5
 9PBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694465549; x=1695070349;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jZK6J0Iw+GRRfVdiIGlnNRot0/j+/zYmp3yZ33I+GHo=;
 b=FbgwQhmwi06/AS++kCVua5i9HTw/8qacrymMYxQ6uLMKxJV3RpqpIvs0/X3WH+kaUb
 kcNweLxcgmGELMKtj93Vx5GWN2x8rDMys1sKhR3K6VPY/NgOD+jGGG9IEqtzMjrdq1fI
 tomimlcw9siSYg5iazqJj7YOjAdljMEzJTInacITcdfe59TElTaExg/e3ir4MP8urvpk
 DleSnQvpxJjeUBn6SFLzJjIv6+GD4VWzTyZEAhM8l13vhUZyewYNNoyRNMgk1xtOAcEE
 xHqwm+ZHY3syUsS2WxHSGqyqc8GHo7u4FCpQYAF7IYjuEqDMvP/qoAD8vkUVRXagql+s
 f8XQ==
X-Gm-Message-State: AOJu0Yw4jzjJ+x1zhVre9Chg3tWU+OKF2imKMSFqJXP8UKM9gHqljA6j
 YbZnfDThoXBI7FxYC6ozlMbeHg==
X-Google-Smtp-Source: AGHT+IHBvsD9nNxkH8mjsEDoIAyeQT1cOH/8PIZDOB/5/vy7riwF7ocs7Yz9prVRqK1nq4rSN5E6hg==
X-Received: by 2002:a17:907:7750:b0:9a1:dd2a:c2c6 with SMTP id
 kx16-20020a170907775000b009a1dd2ac2c6mr7842535ejc.8.1694465549458; 
 Mon, 11 Sep 2023 13:52:29 -0700 (PDT)
Received: from [192.168.69.115] (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr.
 [176.171.221.76]) by smtp.gmail.com with ESMTPSA id
 lc15-20020a170906dfef00b0099bcf9c2ec6sm5845889ejc.75.2023.09.11.13.52.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 13:52:29 -0700 (PDT)
Message-ID: <131c1f7e-c67d-e223-d461-adea4d655d80@linaro.org>
Date: Mon, 11 Sep 2023 22:52:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 09/11] hw/rx/rx62n: Use qdev_prop_set_array()
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, peter.maydell@linaro.org,
 pbonzini@redhat.com
References: <20230908143703.172758-1-kwolf@redhat.com>
 <20230908143703.172758-10-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230908143703.172758-10-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

On 8/9/23 16:37, Kevin Wolf wrote:
> Instead of manually setting "foo-len" and "foo[i]" properties, build a
> QList and use the new qdev_prop_set_array() helper to set the whole
> array property with a single call.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   hw/rx/rx62n.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


