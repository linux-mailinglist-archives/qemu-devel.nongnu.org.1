Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8517EA0B4
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 16:56:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ZIH-0004O5-F1; Mon, 13 Nov 2023 10:56:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2ZIF-0004NK-Ng
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:56:07 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2ZID-0000y9-CV
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:56:06 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-53e08b60febso7096099a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 07:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699890963; x=1700495763; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MvPb0jatI4SEhhMgXnim2zi6Mqbd8Bhz2toTegdoltg=;
 b=HdBxD9lgvyOJqvrJ6T79k7N3I5PKdnizsExe8WI8ZTG/hp+gKWYoyAP14AOEcQR5pr
 IQRh+MH9zcLLsApWbmQPMgZ5H7uDBXUcsWXxVON001PQ036Kn2Iv/s7Sckk7C55nMfiK
 tGI6bA2tUlqNyXGMGOxkh1mZPHDJCWwdIFfeD7EUUE7FgxgxSX+JMatJBkF9JXar/xtU
 07aBNpCGh+gzkgBxC5TH/fYcIit0NA65/OGMeEVWo0ly6aqcFXfyG3gNQBowVjfysnrN
 BfpqcN5lz1R94VYR6artScwf+mmGIkhtwTPXdA00oqXJERZmQJgFDBs7fA9aac8QGVCd
 Tw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699890963; x=1700495763;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MvPb0jatI4SEhhMgXnim2zi6Mqbd8Bhz2toTegdoltg=;
 b=XQ6dhZNQSIRpBCrel/3kr4AAtyFtDFI5JWiBSZmYY+yZaK/YvAd8LTClnuqJboAB6N
 +OfbvY69570v3g2fJYafq6IF+cdvLmorwsRPS1/gQLtBShZqe6rdbdHFQSJZMDuS0uTr
 nw+bp+DJvJjuzYDLVhOHBQ7nXneSnmc26SY25vQ2TQOGQiCOLG5j+3d+8Qr7WBTKBQN9
 logDXMIyVVsU5hG4itI2lJDCW1yqESjHivYO9EvKTso/V/JAnhMIllHmqEO5EcMCOxpz
 /LlaAcd9DR4IDIaUvo5nQ06zE0d/Jx1X5UP4NBS9gJNzXwAY8cDtgSCxWA4sxUcQkUKV
 +vVw==
X-Gm-Message-State: AOJu0YxeRO8m05wqlWeRF1MXrT5dqmU3zQYVyEte499+96a2XarBN9Yg
 DTCazqH9tF8XT8jAmkQVEOx7rw==
X-Google-Smtp-Source: AGHT+IFrtGKbXnyIMTE8hVDL+C13IIwDBK5DXtswSRwVlTRMlG+0QvyZ2GDUuCrbSW1Y3QxEp/VYig==
X-Received: by 2002:aa7:cc8e:0:b0:53e:467c:33f8 with SMTP id
 p14-20020aa7cc8e000000b0053e467c33f8mr4822569edt.20.1699890963778; 
 Mon, 13 Nov 2023 07:56:03 -0800 (PST)
Received: from [192.168.69.100] ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 a25-20020a509b59000000b00544817db5b0sm3867029edj.61.2023.11.13.07.56.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 07:56:03 -0800 (PST)
Message-ID: <beaeb7e1-e049-4fc5-84d1-d021b9f0b96a@linaro.org>
Date: Mon, 13 Nov 2023 16:56:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/mips: LOONGSON3V depends on UNIMP device
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20231107140615.3034763-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231107140615.3034763-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

On 7/11/23 15:06, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/mips/Kconfig | 1 +
>   1 file changed, 1 insertion(+)

Thanks, patch queued.


