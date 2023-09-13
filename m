Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5624779EC40
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 17:14:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgRYE-00089X-Bk; Wed, 13 Sep 2023 11:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgRYC-00089K-1j
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:13:08 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgRY6-0007LG-Cv
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:13:07 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-52a40cf952dso9186456a12.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694617975; x=1695222775; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZjKZvGnFxvDQvHIZfbjbcWD8bPLQiTCbgtOjbOYgwG8=;
 b=NWKLjYqffoEa8F3JmEkmBsM9y9VhVj/JazLvrVrnLRVfPnJ/yjpohyYqHSum7jLHeR
 cU1EUJuNfotd20BhBYL92dVDuPTtlzTegPtVcV8ajxKBZjd31pVOS1Ac0IXvc677y4oF
 aXd5S0LZwxKuYdvWPqafrghHIPy8zQmgNRbrMWncyBRcmczSUBRKrbHbHBEIVS5kPvCn
 H8u8SoklD+WBI/1z2xuPcQaNyuWOAbIsbADbn47LskjkrWj+aYNtJFh539571hGgzb07
 sbf3Kl5sTAwZlWtj1TUXaXK54v0ckFjG7+tg7EET8UCTpYkVncZzJu2DnaRf6t4pChTE
 Hk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694617975; x=1695222775;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZjKZvGnFxvDQvHIZfbjbcWD8bPLQiTCbgtOjbOYgwG8=;
 b=vS8DkqyAWVZgdanO0eZF8ZkQ4muI3mFfDSeLrioaV4nlF5na78c0+N4OOW1SX31EEY
 v3i1wNMrKK+823NtQsBJTQOoybiVu4tzVMAWUyFZn627pSIY9bVh/caW6N9zfvdY6GDI
 XDUjkILFfZqVyx+QWEJKWZBoVsbev85UNXdw3T5xWkiVInoN1mV6N+a91XbNmfV2AeYp
 ZbrWVJYBuh0gNHLcz1qAkzVSGU2v/pyRZzGhQ4V0UpDyA3i7afL7hvrzWPrB6loeL7pr
 epO5eKPNuv0KbVO92M+8tKZ3g0x0FjyI7kkc5Avo2SWSbiQ0xUsQTZLlXOCD5U0gaqnj
 0fbw==
X-Gm-Message-State: AOJu0YxPLrsf9vuXq5ceI48fvFD+vMcQbLyPHjKOI05/VgbZNbOcCOtk
 owiib6RTc3re9mXePDD3Va/ErnxrzRpEeD0Emzk=
X-Google-Smtp-Source: AGHT+IHmqzTFAkPEHnRTJG8hWimgeX7x5NvkRLw3oh9fF+XlKfitkCvyt4zORcGPHWOv7Q069qrvZA==
X-Received: by 2002:a17:906:8444:b0:9a1:c352:b6a5 with SMTP id
 e4-20020a170906844400b009a1c352b6a5mr2261308ejy.69.1694617974967; 
 Wed, 13 Sep 2023 08:12:54 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr.
 [176.131.211.241]) by smtp.gmail.com with ESMTPSA id
 e22-20020a1709062c1600b009934855d8f1sm8603823ejh.34.2023.09.13.08.12.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 08:12:54 -0700 (PDT)
Message-ID: <00162fc4-b3c4-3889-51cb-4145b15ea371@linaro.org>
Date: Wed, 13 Sep 2023 17:12:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 1/4] ui/console: make qemu_console_is_multihead() static
Content-Language: en-US
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20230913144959.41891-1-lersek@redhat.com>
 <20230913144959.41891-2-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230913144959.41891-2-lersek@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 13/9/23 16:49, Laszlo Ersek wrote:
> qemu_console_is_multihead() is only called from within "ui/console.c";
> make it static.
> 
> Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com> (odd fixer:Graphics)
> Cc: Gerd Hoffmann <kraxel@redhat.com> (odd fixer:Graphics)
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>   include/ui/console.h | 1 -
>   ui/console.c         | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


