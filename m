Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ACF80725A
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 15:26:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAsqx-0003OS-5t; Wed, 06 Dec 2023 09:26:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAsqu-0003MU-9w
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 09:26:16 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAsqj-0003wH-9E
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 09:26:11 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-54d048550dfso2723855a12.0
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 06:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701872761; x=1702477561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=969M4ThTsIABLSVj+C+PJad4gKG6kky8YByk7WTveoU=;
 b=QmKfuYE01N1z6i4bbeiL5fhSxmcAw2FYYXCBaMf/G9uSSMVthxmwck0Ip6Btlr6lFv
 SNNS+eSwqN9rYgWaGJ368YGV8N5dgxAI8MBFsPNJB+sSqXOW1EZUjwCZWtylvxPnc6+h
 DrEebbwaoRVdO4pIhcVJCab9vsKBY8BYCKtIdLbPhUv3hvtBCS8JmCXBT1K22M9EouwJ
 KyShiz97EakNXviRMbIfpQDyTR43kXk2yR8g1qVoJPt+nii+lOSWnVIoQ9rK+LjmmcOB
 DM3kQWKXRUfosjoWOAUWywranA/GKCgOKKzhSn3Hck+9Ur5ILwTav3GG4zYej8/o1AA9
 r9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701872761; x=1702477561;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=969M4ThTsIABLSVj+C+PJad4gKG6kky8YByk7WTveoU=;
 b=gVEzxNN2q52W1gTqLJgdNG1CIlAy3A73MROwr/F3UNkZSW8UeH4DrbyDJK94CKSBdZ
 lm+ER9sjxX46kj3h9tDCz/zjfKfdLa5LMHHPlZDhImNobz6GyMbSJ3AgCRjI0jqQruV7
 e3AwQ2xT7i68osy+ZSLJRnMq7A0f3V42m9XebFIaELzL0dRN6U+wVcLw1gCGAqHMZfm2
 2S/mm4eYhs1AP8YOWf0J3bQK6GNxn9NbHAMhTBfxZOkg78duwNwSaTWHsYpQei7qGH0X
 Q3cpl6m7s913O0EqAQTC9Xa93NBaodVCrzVrDytXmuOSf+R4CR+7g3jjgt+rbENZPdBu
 ozeA==
X-Gm-Message-State: AOJu0Yzf5DukQl7sA6Tx3j60UYemye/M+4uBaQiAdNgH2tS08nYhqtcv
 9qlaAPhkQZpup5mD5lk4N9ed3g==
X-Google-Smtp-Source: AGHT+IGoAzq6z6lD5Mpqyv3lJ7rc9v84cYoJYIsbfi/P82fq+CxzhTO04Ex8aI1wj4UV6Td1xXzyPw==
X-Received: by 2002:a17:906:1b02:b0:a19:a19b:423a with SMTP id
 o2-20020a1709061b0200b00a19a19b423amr501891ejg.165.1701872761126; 
 Wed, 06 Dec 2023 06:26:01 -0800 (PST)
Received: from [192.168.69.100] (tal33-h02-176-184-38-132.dsl.sta.abo.bbox.fr.
 [176.184.38.132]) by smtp.gmail.com with ESMTPSA id
 dk13-20020a170906f0cd00b00a1e04f24df1sm463264ejb.223.2023.12.06.06.25.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 06:26:00 -0800 (PST)
Message-ID: <5eaf9e91-0a23-481c-b908-e037420c73ce@linaro.org>
Date: Wed, 6 Dec 2023 15:25:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] chardev: force write all when recording replay logs
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
 <20231205204106.95531-11-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231205204106.95531-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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
> This is mostly a problem within avocado as serial generally isn't busy
> enough to overfill pipes. However the consequences of recording a
> failed write will haunt us on replay when causing the log to go out of
> sync.
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2010
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>   chardev/char.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/chardev/char.c b/chardev/char.c
> index 996a024c7a..6e5b4d7345 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -171,7 +171,8 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all)
>           return res;
>       }

Please add a comment explaining why in the code. Maybe simpler
using:

        if (replay_mode == REPLAY_MODE_RECORD) {
            /* $explanation */
            write_all = true;
        }

> -    res = qemu_chr_write_buffer(s, buf, len, &offset, write_all);
> +    res = qemu_chr_write_buffer(s, buf, len, &offset,
> +                                replay_mode == REPLAY_MODE_RECORD ? true : write_all);
With a comment:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


