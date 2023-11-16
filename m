Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D917EE15C
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 14:19:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3cGT-00055U-FH; Thu, 16 Nov 2023 08:18:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3cGQ-00055K-T6
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:18:34 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3cGO-0003OO-S1
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:18:34 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32f7abbb8b4so556408f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 05:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700140709; x=1700745509; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AQMAcbSu31U1JED8s6UkwhvDCXN+9znOjBPPtUVipNI=;
 b=jFwIG9/k84EFjIb6xo2WncIH6fjdZ5+nmXq7Kg4iAJ4K4qmhfA056IFZ99O41NPXoa
 vp2P1yrNKa++VInXf2+gfxTosHwkfGJN1t5LbuiP1zg8sR23bbkbWKaOfa7OlsXPzA5D
 R5ViDlUJnpGVoZ0dawGpiRR+HfFJJfZj0jeG274ZE9CgW+u0JeKA66cWjBs+BryYho3V
 thRkjhNbRYuubMF+EAmPkdZPLmD5RvVfebHYR73Xc4RpLm9Z5s+zDS6sERyj2lmmqSok
 14kzn9RTAn9su700qQa0zmFAOH1dUVJ+2oRyPphNpr4Y82PhQPR8S8Q5jbFZuyVFQckX
 cXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700140709; x=1700745509;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AQMAcbSu31U1JED8s6UkwhvDCXN+9znOjBPPtUVipNI=;
 b=J+tB2zmRIr39iRyJovfxm0WcpSAvNoOMPZ2OPHRYtgV/wLGr2LNvk8pf/AjMMchnhl
 YbTJ8ZMypObJD+9JDldgsZid//98g6+wJXAc2ebQLW6VgpcX3UcAKH/xOwJfFBSiJSGS
 QsvC2v7XbD5XUQV/6pwLeCLOr4DW0x529Eh3Kc64eIdqFcYy1VnKCHbEBqIh7JyLP02P
 Hwd2OYridbqdPp5Q5E5XBZ6qBz/6XceaUPTy5jOfoH0hWx6NdbtqlMbIm89ytDi5jsX9
 nrnqN4BlCR5Bt6NQNuRO0NKgA3BL5gadjb8pUqq0H1q5D8O9KmdfPfoi/dYfCmLvIOSY
 nbzA==
X-Gm-Message-State: AOJu0Yy826soVkSyvQR3hAHSnErjJsXiSOKdFfssJ7WO32lnJX9+1OqU
 HYb8irl3Rz1ZW7A4Y+AEa/SC7A==
X-Google-Smtp-Source: AGHT+IGnQ8wvmqxKeohdJUSyeJcAAhh1xxk70uqfZbyEySC/1lcericWHXuAhQVngvOTZh0GISqkrg==
X-Received: by 2002:a5d:4c85:0:b0:32f:9268:be5c with SMTP id
 z5-20020a5d4c85000000b0032f9268be5cmr1581940wrs.56.1700140709366; 
 Thu, 16 Nov 2023 05:18:29 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 w3-20020a5d4b43000000b0032cc35c2ef7sm13618360wrs.29.2023.11.16.05.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 05:18:28 -0800 (PST)
Message-ID: <52024c40-1bff-470d-97c9-9c6f8b653670@linaro.org>
Date: Thu, 16 Nov 2023 14:18:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/audio: Fix logic error in hda audio
Content-Language: en-US
To: zhouyang23 <zhouyang23@xiaomi.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20231116075019.296115-1-zhouyang23@xiaomi.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231116075019.296115-1-zhouyang23@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 16/11/23 08:50, zhouyang23 via wrote:
> Commit b7639b7dd0 introduced a logic error about mixer and nomixer.
> Cause use micro_mixemu when there is no mixer in HDAAudioState, but
> use micro_nomixemu wehen there has a mixer in HDAAuditState.

Cc'ing Marc-André and Volker for
https://lore.kernel.org/qemu-devel/20231105172552.8405-2-vr_qemu@t-online.de/

> Signed-off-by: zhouyang23 <zhouyang23@xiaomi.com>
> ---
>   hw/audio/hda-codec.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
> index b9ad1f4c39..87bacb3bee 100644
> --- a/hw/audio/hda-codec.c
> +++ b/hw/audio/hda-codec.c
> @@ -857,7 +857,7 @@ static void hda_audio_init_output(HDACodecDevice *hda, Error **errp)
>       HDAAudioState *a = HDA_AUDIO(hda);
>       const struct desc_codec *desc = &output_nomixemu;
>   
> -    if (!a->mixer) {
> +    if (a->mixer) {
>           desc = &output_mixemu;
>       }
>   
> @@ -869,7 +869,7 @@ static void hda_audio_init_duplex(HDACodecDevice *hda, Error **errp)
>       HDAAudioState *a = HDA_AUDIO(hda);
>       const struct desc_codec *desc = &duplex_nomixemu;
>   
> -    if (!a->mixer) {
> +    if (a->mixer) {
>           desc = &duplex_mixemu;
>       }
>   
> @@ -881,7 +881,7 @@ static void hda_audio_init_micro(HDACodecDevice *hda, Error **errp)
>       HDAAudioState *a = HDA_AUDIO(hda);
>       const struct desc_codec *desc = &micro_nomixemu;
>   
> -    if (!a->mixer) {
> +    if (a->mixer) {
>           desc = &micro_mixemu;
>       }
>   


