Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 691C57EE141
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 14:15:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3cD1-00005W-80; Thu, 16 Nov 2023 08:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3cCq-0008Lu-CH
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:14:53 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3cCo-0002Dm-JM
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:14:52 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5435336ab0bso1238376a12.1
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 05:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700140489; x=1700745289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i0PGe71PXVAUO8kr839stx3fGDJiHTEO+jgSGCO/uGA=;
 b=DV1sAPgjovdYMM3nKt9LYNblPxUSbFex4klJE9Kdi4lT4qIe5RuuwGJBy0FLeFjzfj
 AmqtlDpdjRm9d+xm7CdJdP7CSWCq4bSHXXMmx/z6g3bv6o08ofBA+iSW9g806JJaEVCu
 vcxC3l898/uXG3rlbQt6N4NDheuVBxAU9MVGAkDvmWMqL/YLhXdXkL7Qfks2xM/zzeYH
 tCbtKLyfNE6qLP5bdkEaKi7i0SDkJSx6UJPHxOe9xzCxT/25H1qNyIxjFre0oKxH9fE5
 db588IoyJL3jX6pMCB9TxDzBhCwJxaKnsFvsEHirLCW1DfYuW8Blex5yG+u7zpGoCBke
 NcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700140489; x=1700745289;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i0PGe71PXVAUO8kr839stx3fGDJiHTEO+jgSGCO/uGA=;
 b=TRVpABH2LXrYqzBLgWEUpV/5Mm3088k4Qx5R+ZYuQcOHkkDJC4buBq9a1S3Xmbuk4b
 s+8ZmFhMnjGqdNtNESBfE2pjJ5EptF+9pjHpFqGEvDtbt9Hhv4bolndChWQCb3d0nCVg
 iec6YjQz12I4mpoNR6+BYaEhc46VLkhaqq0G09NGXAwoXVBbohIXFzqcUc4lVNaRAn2p
 5wo9oH3Wu639UJGN0aBYifCz6QpcG+ll2A1lfr8nIedJy4Kwb91fx/RYvjw8+uRRCTm+
 Rzr5Ge3RMcMXseVgoA7zZCMOwYaHbSua2dW/uCdYllvu8TSaG9kOlbD55/S24I2JLAZ3
 0MwQ==
X-Gm-Message-State: AOJu0Yykv1Jpz8G2WeA+heGE5Qr8cqBmH7VUocN8ZOb+4f1lDOwT3Pvy
 0uMFHQR8DWyTop5RvCDrrgdY2Q==
X-Google-Smtp-Source: AGHT+IGS/rCj5T19UY+smh61A0D0sCrhP+ZVsmJexhxrl0VwigAMinZUVctkTQs4t+A4J8IQV4tIhQ==
X-Received: by 2002:a17:906:7e10:b0:9db:dfb0:a35f with SMTP id
 e16-20020a1709067e1000b009dbdfb0a35fmr12927227ejr.18.1700140489254; 
 Thu, 16 Nov 2023 05:14:49 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a170906080a00b009a193a5acffsm8415558ejd.121.2023.11.16.05.14.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 05:14:48 -0800 (PST)
Message-ID: <4d48a1c5-381c-4c49-8454-861c29a2449f@linaro.org>
Date: Thu, 16 Nov 2023 14:14:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] ide/via: don't attempt to set default BAR addresses
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, kwolf@redhat.com,
 jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 balaton@eik.bme.hu, shentey@gmail.com
References: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
 <20231116103355.588580-4-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231116103355.588580-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

On 16/11/23 11:33, Mark Cave-Ayland wrote:
> The via-ide device currently attempts to set the default BAR addresses to the
> values shown in the datasheet, but this doesn't work for 2 reasons: firstly
> BARS 1-4 do not set the bottom 2 bits to PCI_BASE_ADDRESS_SPACE_IO, and
> secondly the initial PCI bus reset clears the values of all PCI device BARs
> after the device itself has been reset.
> 
> Remove the setting of the default BAR addresses from via_ide_reset() to ensure
> there is no doubt that these values are never exposed to the guest.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/ide/via.c | 5 -----
>   1 file changed, 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


