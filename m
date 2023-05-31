Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C39718217
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:38:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4M1F-0002Y8-Uv; Wed, 31 May 2023 09:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4M1D-0002Xc-02
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:37:39 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4M1B-0007Yh-Ir
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:37:38 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f6042d610fso59412215e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685540255; x=1688132255;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LAt85ERankXTfxFhb/QKR9DA66Px2pXHia2WWbDelxs=;
 b=KzL5PhAv7V23Wj+vepmolpYEuGx7pNv0zmTNZqSgrrl4KaWiGs2KXgKYr2lUI7k1GB
 Ennd+jUxzQRh7At5CxTF/JLFOKY+rH01UtpGYRRncKmNhyB9ebVt08mVj1uKmp0u8BSS
 eHKCS8nLhtHsvkgESuCBmzNdfFqyZMZxAWy8HUtRSHJqdbx7zOY3TB5kfzFlPUkBd82r
 e6uxA6L4MMapfdvXymX7RKDQCTPcODCI2kaKGjLjbHJ8dQMECpDEWYoFrA2W8iejLKHl
 JFBDRZ8Qr6PyIk7S0QG3Sci0ABwifg2CJ4Fj54ugBUY76n7WgeDINz0VqAvdmTGm6+iw
 EZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685540255; x=1688132255;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LAt85ERankXTfxFhb/QKR9DA66Px2pXHia2WWbDelxs=;
 b=BKvVd+yWZc+g9+p8VRNUiD7T5VrtGVNl8xnVSZQM2DMmMSs5M/wCRb/FRAt7knN3fD
 G3yjPig3FO/Bdl2tqZkfgFOi3wwLxe/7Jdu1+ol3NY7IE2P5ygudS6ask3fgqoB09VN2
 2hGGGZW8cbDpgLQH7mZOG05QRKddzPXqIjMchozEOzf5YTWEj1qtlakCVCdv1AGGmu2C
 G0/cgiVlTQEop+ICRJvp7bHg1xgYZ4QfpIO85nYuAMOZaEXiU52jcvCCwaBX4L0x4bjO
 Tt8U/pTHkb79I+ULxsJh2B/Ur+vCYR9uYFprI/rbBvQJ/OOB1nSM/pSOwW5Bsxf8Hy2M
 0FKA==
X-Gm-Message-State: AC+VfDx2fI2y2wiqWXbW5NNnDCUnbZx9xYjbE7Yvm0gdndn6X7C/GAtZ
 HxwurBBX2wfOK3yn8HJ7gSE+KA==
X-Google-Smtp-Source: ACHHUZ7eNtXWIDkivMimgwGDZg2OnunBYWPfjHEbE1bSgUo9w5+hcTAkQPhaMOG+7KtGJWKRsQRBzg==
X-Received: by 2002:a1c:f70b:0:b0:3f1:72fb:461a with SMTP id
 v11-20020a1cf70b000000b003f172fb461amr4209966wmh.2.1685540255349; 
 Wed, 31 May 2023 06:37:35 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a7bcd85000000b003f09d7b6e20sm20905530wmj.2.2023.05.31.06.37.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 06:37:35 -0700 (PDT)
Message-ID: <f82b0d95-e644-490f-9edc-7db1b4d28804@linaro.org>
Date: Wed, 31 May 2023 15:37:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 04/23] q800: rename q800_init() to q800_machine_init()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-5-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531125400.288917-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 31/5/23 14:53, Mark Cave-Ayland wrote:
> This will enable us later to distinguish between QOM initialisation and machine
> initialisation.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/m68k/q800.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



