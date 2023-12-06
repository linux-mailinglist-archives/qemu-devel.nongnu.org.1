Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFC1806E03
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 12:31:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAq7h-0006ch-Qu; Wed, 06 Dec 2023 06:31:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAq7W-0006cJ-Hx
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 06:31:15 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAq7R-0003nP-LT
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 06:31:12 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a186e5d1056so86953866b.0
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 03:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701862268; x=1702467068; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Imppi9Pq8P36kkbfEJTSLR15Ur0J4eec9q/Byc30MdA=;
 b=hzel2SOR8Uv6jxwvFuI2F9GAcTCZEorH097g9tHUUnj0p1j9bNFyBCcAIr6zjNj6ur
 5Ber3gJK4atlYJqKJEVkcgaZ2qPdv6cjq4Rcy+zVOPVyBXAKXiibWq7cq3b5EoyLS2pK
 i+sWk3CMdeJIPxqJwHIOLtQmTFvE4uS+dS4xH+Fahw8KkLQaYpHIcJ2PL8yHzKU1tz3c
 gsD/8Ggh5C4M8YzajYyX/0vcHTuKfVu7iUSUERJiyFYkf2dhIpKqxLoAL/VKXUGxlIjZ
 uNoPd7NWBQUXD6lE1UdcS7Fo0rn8k5QtSbXeDLFOtT8et/NrB2SnffXvXRkGEv/hMPzx
 PdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701862268; x=1702467068;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Imppi9Pq8P36kkbfEJTSLR15Ur0J4eec9q/Byc30MdA=;
 b=VMB0xnIngJ2XF6pVe/KuhuvAWuZ0WU8y/hiRwWUdSWCiEoXVe3lJKyr86UAuGw2zWm
 uNqUSzISxs0h0/SRtRAh3N9b/C4wkWG8pO9MSD8RsuldjmE6VevkguVcPez3czy2YHSX
 tuHmZUejwIhfAQNnPfMkhiPNq7Sk1fKjAimvwdyXdwkLhBtz91VNHPgk2SRZGKuqXDW+
 U/m9f45gKdJHL0CZv3rthBtesSnAERtfNBQQewV8uFXB4EevAG2D3oVmggofqrXPw7+Q
 KO3gPDA9LQ8NXQPEfnLoPeg1GLfjr+lS6n3T7e2fBGnmzZbtj6Uhf3A8BdrFwubbgRzR
 CFqg==
X-Gm-Message-State: AOJu0YziWa3eQDg2dIQvq9GjqUHV1FnGWIo8jKkEYthYpU4khcxywACt
 9XyWDT4RVlnuFqTyFu7NHNDOdgE9fn5kYhKK7qc=
X-Google-Smtp-Source: AGHT+IFLP0ujosMaiteJ8h42NJCMm59I32hOK1DEBwDJhrZ/rSancnNGXTwdZsKNz769EACrWw4wVQ==
X-Received: by 2002:a17:906:408e:b0:a11:4dc3:d0ce with SMTP id
 u14-20020a170906408e00b00a114dc3d0cemr392919ejj.63.1701862268107; 
 Wed, 06 Dec 2023 03:31:08 -0800 (PST)
Received: from [192.168.69.100] (tal33-h02-176-184-38-132.dsl.sta.abo.bbox.fr.
 [176.184.38.132]) by smtp.gmail.com with ESMTPSA id
 d15-20020a170906344f00b009eff65e6942sm8139263ejb.197.2023.12.06.03.31.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 03:31:07 -0800 (PST)
Message-ID: <500971ca-b373-4d64-99a5-9f8aa218cef2@linaro.org>
Date: Wed, 6 Dec 2023 12:31:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] replay: make has_unread_data a bool
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
 <20231205204106.95531-8-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231205204106.95531-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 5/12/23 21:41, Alex Bennée wrote:
> For clarity given it only has two states.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   replay/replay-internal.h | 4 ++--
>   replay/replay-internal.c | 4 ++--
>   replay/replay-snapshot.c | 6 +++---
>   replay/replay.c          | 2 +-
>   4 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


