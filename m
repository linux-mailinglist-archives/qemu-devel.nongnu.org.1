Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 666477C47FD
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 04:50:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqPHm-00043I-GZ; Tue, 10 Oct 2023 22:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqPHk-00042U-2i
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 22:49:20 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqPHf-00069i-7Q
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 22:49:19 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9b95622c620so1154207266b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 19:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696992553; x=1697597353; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HOAc+Yugb0JuhHnv5juNVIob1lXpqQjvaRvUb2774Wc=;
 b=kiMn8HQ4DtxH/Bci7RZHBFKxZE4O/WNqH5pDytNDQGWHC63x7beElK9FrMNXH4zM1V
 mVAq5WIi4rqJTwIe0wHvVmCNjIYAlOaHmqRn7/YQyFgVdRQbb1h7ACSK2+BfIzjYSpKC
 uNbV/mDOYEHGWoFXMn1/YyfQcSwF3QeJmNVygTXizeCU6xz0o+D+kvJfNaK9gIGtHDqk
 84b2MHRaO/CQIM3gbEo2AVZyJLxyJpHkpplhlsR7useDkEMooBl9ibEoOGEOm3RLsw/C
 iOFxHlZf9HfK0l5sLJQFrMXAWeD2uWrDpNvZfSB9n8dgFOLDA1ntzv0+mSdIfTsVuoMv
 WwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696992553; x=1697597353;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HOAc+Yugb0JuhHnv5juNVIob1lXpqQjvaRvUb2774Wc=;
 b=B+tU2EuhoVK3OBLcXohxaNikRwMJkF5hONsPrvRscT/YYPk11yCG07hb4vuR2KG7gf
 1mv2Zre5JErLiGPkLboLMrocNktaWVjRlSDezKzVRjZD3D0mAZ9SdGhaRCfFNxFBtD76
 /E/1rrspM7c7V7q2RLzxM2Ff+vhvPPZTte1Zrwzz85OXesMAUvvHFFl3T2tUyvJLUkys
 shcaVOmtEfyRSKburnafkZRTgdXMEB4EzHzk29yyciO/s9dikCx/V8pUA2MecPBcSMx8
 5oZVIPA/cHlT8In/EypuNibh6rR8dR7VEtylorEEURKbV0EfAkPuMVKpyP4B4hnwBSFJ
 9hCQ==
X-Gm-Message-State: AOJu0Yw9MtX57mG9V/aOSyerj/VrZW/idTwRLQW6jF++8IHw0YVBuZiD
 s3JK31kGtji21xEse6Xio0bXbQ==
X-Google-Smtp-Source: AGHT+IHFdWWhMk0OJuxTKpO/nYBQVV445eYMat6xH6hGjl59202x6AmOMMCGX0anMfp1DZY1QKKgtA==
X-Received: by 2002:a17:906:7485:b0:9ae:5fe1:ef03 with SMTP id
 e5-20020a170906748500b009ae5fe1ef03mr17221309ejl.67.1696992553367; 
 Tue, 10 Oct 2023 19:49:13 -0700 (PDT)
Received: from [192.168.69.115] (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 u18-20020a1709064ad200b0099d0a8ccb5fsm9250376ejt.152.2023.10.10.19.49.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 19:49:13 -0700 (PDT)
Message-ID: <eedf1c54-715e-8cd8-177f-2b68b2e6af42@linaro.org>
Date: Wed, 11 Oct 2023 04:49:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH QEMU] tulip: Fix LXT970 PHY registers
Content-Language: en-US
To: ~disean <di.sean@protonmail.com>, qemu-devel@nongnu.org,
 Sven Schnelle <svens@stackframe.org>
References: <169674973699.6685.14097094770329042160-0@git.sr.ht>
Cc: Jason Wang <jasowang@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <169674973699.6685.14097094770329042160-0@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Dmitry,

On 8/10/23 08:54, ~disean wrote:
> From: Dmitry Borisov <di.sean@protonmail.com>
> 
> Fix incorrect MII status value (0xf02c).
> 
> Use default values from a 21143-based board:
> https://www.beowulf.org/pipermail/tulip-bug/2000-February/000485.html

Thank you for your patch!

Cc'ing the maintainers for this file (you can get them doing:)

$ ./scripts/get_maintainer.pl -f hw/net/tulip.c
Sven Schnelle <svens@stackframe.org> (maintainer:tulip)
Jason Wang <jasowang@redhat.com> (odd fixer:Network devices)

Regards,

Phil.

> Signed-off-by: Dmitry Borisov <di.sean@protonmail.com>
> ---
>   hw/net/tulip.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>   mode change 100644 => 100755 hw/net/tulip.c
> 
> diff --git a/hw/net/tulip.c b/hw/net/tulip.c
> old mode 100644
> new mode 100755
> index 915e5fb595..43e8f4bcb5
> --- a/hw/net/tulip.c
> +++ b/hw/net/tulip.c
> @@ -415,14 +415,15 @@ static void tulip_update_rs(TULIPState *s, int state)
>       trace_tulip_rx_state(tulip_rx_state_name(state));
>   }
>   
> +/* LEVEL1 LXT970 PHY registers */
>   static uint16_t tulip_mdi_default[] = {
>       /* MDI Registers 0 - 6, 7 */
> -    0x3100, 0xf02c, 0x7810, 0x0000, 0x0501, 0x4181, 0x0000, 0x0000,
> +    0x1000, 0x782d, 0x7810, 0x0001, 0x01e1, 0x41e1, 0x0001, 0x0000,
>       /* MDI Registers 8 - 15 */
>       0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
>       /* MDI Registers 16 - 31 */
> -    0x0003, 0x0000, 0x0001, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> -    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> +    0x0000, 0x0000, 0x4000, 0x0000, 0x38c8, 0x0010, 0x0000, 0x0002,
> +    0x0001, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
>   };
>   
>   /* Readonly mask for MDI (PHY) registers */


