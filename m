Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 400617EDC09
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:33:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3WrN-0007ke-LL; Thu, 16 Nov 2023 02:32:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3WrE-0007kA-9A
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:32:16 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3WrC-0008Gu-Fm
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:32:11 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-509c61e0cf4so668961e87.2
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700119927; x=1700724727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rKRj+gqD9RbRLrW7xIbnjjw9rvTVjX8Fk7KPAZ+jtjE=;
 b=OUfMqN9aYe0Vpj984PqHovIQxEwOv4EBPKYRXXtjErEJKx33A5ek7n008/JyB7zS51
 0BYLpEIkoNM00P2c70LMFexERkltL1YY6izVGP5qBUA/eieHN/OZ35kDF0Ee5Qp8KsB+
 1yxurgpdRbp3OuPjcv0dPbBPTRO3g1NhjMFhN7umtm+aUo0Ws3UvuPcq6CO/TElyqLmi
 Dkf4Fy4YEWA4lq9yK5XpeBiHKdfUCWiLu1Ty5vrYfpmOyGXFO0hDohPM01dPZtLMLfJZ
 8xzBJL6GaXayKHbys6zbjuifW5Vm1Hp/iCu6Stm3LvrTgahwAdc8FTOun9vz+9RUAhPh
 QQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700119927; x=1700724727;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rKRj+gqD9RbRLrW7xIbnjjw9rvTVjX8Fk7KPAZ+jtjE=;
 b=pqj06Q7dnSXRsZ2pHYtrLkAux2Qs9A10oYVIg3HU6FXcTuAFuA7xfA284mhcBP7YHK
 q/EUGu+/c940fUGsGFZHqnhjbthDp67VnKooNUolnKmxhb5w3HA71tN/Pxa+Bl+LCnRx
 lm5gWTCsQh3fVvBaP8HLMpk+4HpyB0H28Tja6E+mVoWnlr/nXzp/+sJEfiiw3DL7eiW3
 KFMABwZJ1YCEzWrSsGffZQ0AIF25axXgrT5idIAqgP2GwQPnv2CCRZJeLrRcUU/vzpl7
 xB3NBGfnTnj5iQknZjDVUXO5iaIl9R2vSpQCAVPfoQ3sj6j2Dev1JiG6n2gjOw9hFYpe
 yCgQ==
X-Gm-Message-State: AOJu0Yxp5TR7YXnxZauvLzdKc1QfO6/WyjMtKYV43GaY+hTa2bKmt6Hn
 /Ox/PowvgAILdVFsfXEh/15y4w==
X-Google-Smtp-Source: AGHT+IFTXOYpGlvD7n9O52F9LDNbznSk2KjEzOEIggPc6lPKd+UFOi9BNbWzTy1B1r4mCAeNP5Zfcg==
X-Received: by 2002:a05:6512:20cd:b0:507:f0f2:57bd with SMTP id
 u13-20020a05651220cd00b00507f0f257bdmr9128207lfr.66.1700119927250; 
 Wed, 15 Nov 2023 23:32:07 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a5d4847000000b0032d88e370basm12636420wrs.34.2023.11.15.23.32.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 23:32:06 -0800 (PST)
Message-ID: <88363f15-697b-4b04-ad4d-af0aa5fb75aa@linaro.org>
Date: Thu, 16 Nov 2023 08:32:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2] virtio-sound: add realize() error cleanup path
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20231116072046.4002957-1-manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231116072046.4002957-1-manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

Hi Manos,

On 16/11/23 08:20, Manos Pitsidianakis wrote:
> QEMU crashes on exit when a virtio-sound device has failed to
> realise. Its vmstate field was not cleaned up properly with
> qemu_del_vm_change_state_handler().
> 
> This patch changes the realize() order as
> 
> 1. Validate the given configuration values (no resources allocated
>     by us either on success or failure)
> 2. Try AUD_register_card() and return on failure (no resources allocated
>     by us on failure)
> 3. Initialize vmstate, virtio device, heap allocations and stream
>     parameters at once.
>     If error occurs, goto error_cleanup label which calls
>     virtio_snd_unrealize(). This cleans up all resources made in steps
>     1-3.
> 
> Reported-by: Volker Rümelin <vr_qemu@t-online.de>
> Fixes: 2880e676c000 ("Add virtio-sound device stub")
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> 
> Notes:
>      Requires patch <20231109162034.2108018-1-manos.pitsidianakis@linaro.org>

This is the 'Based-on: ' tag I guess.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   hw/audio/virtio-snd.c | 39 ++++++++++++++++++++++-----------------
>   1 file changed, 22 insertions(+), 17 deletions(-)


