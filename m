Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DC074569A
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 09:59:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGESy-0003Av-HD; Mon, 03 Jul 2023 03:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGESu-00039e-ST
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:59:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGESt-0001ex-4T
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:59:20 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbc77e769cso35010705e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 00:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688371158; x=1690963158;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TXEiaSaa+GQK89FjGmp0AriQRpmuQLEedTgz1XcxtzQ=;
 b=V4vjh26miDf7wHKVd2bfo8kUN8HDOL2lnlzE96VgRy6tTKgY+1rsWBo0PYnviGNFyb
 N1nuBGI7RvNoacENQhrgn22XVZYm/b4jfvp+MW1KSx/PgdYNb0824FUSR9ifmYAam3Di
 L9HTom0UNvRK1+UNE/2lCVenVnErD2TFBa53hOME8iMri/nux3SF5lD3KqrmTY9VHXuy
 NtV8WzdMPiGgUvmgOaaNyBYkwhidYLpJPMPcxMVsqr1mr9p68HLzokU6l+dGifL4Ycec
 Cz4lNxHLy2cCm/OU+G9yzAhhXGc4f67i72luKjV4wYDKAqwoxv/AEi/+xbVDN7u6rFhM
 KhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688371158; x=1690963158;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TXEiaSaa+GQK89FjGmp0AriQRpmuQLEedTgz1XcxtzQ=;
 b=PaG8HUSrYbY8zyI/D0lL9zW7QMkzWfHiBisgTCV0zPTfpUlMKPYqujFOjqVYcCqXp9
 4F62w5XmaGabFf6qTPNpWQ3EJ8YfJpGfg7beaQ5NbKU5CV0JcDUj0rrF3bP9d+gZFO5G
 zW6Z8bfnQ9Xu2Hh7DQ0OHdjex0hLAP4HWw03C475UVVYRUGiTE6dWiO2WU9pG4cnT6d4
 uDPVs3v+Ney8bn+QBHqwyrOvr96UN8Tucgc+ufhSwPSWDzQJXqkS417SifvfZqaIPkLV
 b2x4WqEfUZXyYxlTmEJmF6AHP2xyQv5GFhT/8MrLxJfHwPNys+05GRj12ulA04wQuAv1
 Eagg==
X-Gm-Message-State: AC+VfDyojOypYxsMMIIxxyyaryoS+dnB8d7FdIvl4n/Qzx0mat2HGU0f
 OqRo7878rdEEHyNTMlYtgWZnCzI1lL/wV5HcIiJhEQ==
X-Google-Smtp-Source: ACHHUZ4GUvCiNlYBlycl+nSd8aap+AQh/q2Es99AJygMh3/kc8wglsn4ByT3ucilfssZ3GH2FMsXdg==
X-Received: by 2002:a7b:ce87:0:b0:3f7:aad8:4e05 with SMTP id
 q7-20020a7bce87000000b003f7aad84e05mr8522933wmj.11.1688371157648; 
 Mon, 03 Jul 2023 00:59:17 -0700 (PDT)
Received: from [192.168.1.25] (91.232.79.188.dynamic.jazztel.es.
 [188.79.232.91]) by smtp.gmail.com with ESMTPSA id
 z3-20020a5d4c83000000b0030497b3224bsm24725891wrs.64.2023.07.03.00.59.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 00:59:17 -0700 (PDT)
Message-ID: <f4351255-9b33-429b-6c7a-acdec258d5c1@linaro.org>
Date: Mon, 3 Jul 2023 09:59:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 14/38] tests/lcitool: introduce qemu-minimal
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230630180423.558337-1-alex.bennee@linaro.org>
 <20230630180423.558337-15-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630180423.558337-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/30/23 20:03, Alex Bennée wrote:
> This is a very bare bones set of dependencies for a minimal build of
> QEMU. This will be useful for minimal cross-compile sanity check based
> on things like Debian Sid where stuff isn't always in sync.
> 
> Message-Id:<20230623122100.1640995-16-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> 
> ---
> v2
>    - minor rewording
> v3
>    - shift extra packages from next commit
> ---
>   tests/lcitool/projects/qemu-minimal.yml | 27 +++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>   create mode 100644 tests/lcitool/projects/qemu-minimal.yml

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

