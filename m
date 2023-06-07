Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE23872599E
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 11:09:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6pAA-00061v-O9; Wed, 07 Jun 2023 05:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6pA8-00061X-RS
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:09:04 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6pA6-0000tt-S8
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:09:04 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f6ffc2b314so2733815e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 02:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686128940; x=1688720940;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EVxmJ0BKqMcVhtDQ/su8wRLKOoCDDlmBuHpFUcx1nnM=;
 b=AIYFDfUSZ/lSdw+H8TOF9I/7C3lgGVskKhB0mDItvs8AbjbhlwyHcdso4HjGeN23K8
 TDO8qBTWO1aenjTgY8nwrGha44d4ydAIcnoViIxrmGmW2H1QfB5As0OLVLK1EfOs/skj
 m6giu2uSuImh+7RKvafXnqQVTY1gxKfKZdr7Xa20q8/rc/oRcEjq8VfhFqZ+2bOnIjSs
 w//OKRR/o9lZMn4NLprPI1OwH64IqPrUCYjJf1e1Qt4Z2e6wUHnA1uy2cYw83Tky+L9l
 /JIUTfzsM2kYqHU4ZEoMmAJnMauD2lGrrx8OUpJQw2hTOWt/W5wmmegzagNEvG/UQtPS
 kh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686128940; x=1688720940;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EVxmJ0BKqMcVhtDQ/su8wRLKOoCDDlmBuHpFUcx1nnM=;
 b=SSn5BVa/naFsqB0jouOMpC1rQ7ikRRb++X7WR48PPsjYpffIvlMCO8qU775cP8GU7y
 8brTMbqAnHMT2e/BqTnI2CzDZ1SeKTfcVrpbBr5Weu6HyqF8j3BYcLDK65/9EQraCUlZ
 GKYFePR87muMvltbXCI2DV3JeW0cJSOHaufgYwW3cuhGlrLi+KMCzerb649ORydZASZW
 A4+V4MgG1mCeClaMb6yh0ijZp/I8PZfLCvAKrAZO4mELZ3FKyunrOykd1tqorYSeHb2I
 4OE1Nn/Ofeq0Ao/fL5kph8uQmHJNpKF7zgea0N+/zI02OWDV1QBBlWNfJKJqB7FAcvkC
 IaBg==
X-Gm-Message-State: AC+VfDwO62hBd08i+P5hVtyqKLJgRcFlXhdIxRJnMTit3Jv2wHXINyCv
 NwhyPnwtHNOP++bTyDotWifuwQ==
X-Google-Smtp-Source: ACHHUZ552ht2q7lQZOaiXPccjqAbaud7jAAC4iUSIf2ekDQzkDaBVdfyB52U+BHSEGifXPTdpvvymg==
X-Received: by 2002:a1c:4b0b:0:b0:3f6:1b7:11f0 with SMTP id
 y11-20020a1c4b0b000000b003f601b711f0mr3708577wma.7.1686128940082; 
 Wed, 07 Jun 2023 02:09:00 -0700 (PDT)
Received: from [192.168.69.115] (bd137-h02-176-184-46-52.dsl.sta.abo.bbox.fr.
 [176.184.46.52]) by smtp.gmail.com with ESMTPSA id
 3-20020a05600c028300b003f7eeec829asm1468292wmk.10.2023.06.07.02.08.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 02:08:59 -0700 (PDT)
Message-ID: <f1c785b1-beac-55e1-7da9-d9a5f1ab77ff@linaro.org>
Date: Wed, 7 Jun 2023 11:08:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] meson: fix "static build" entry in summary
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20230607090336.59424-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230607090336.59424-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 7/6/23 11:03, Paolo Bonzini wrote:
> Fixes: a0cbd2e8496 ("meson: use prefer_static option", 2023-05-18)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 553c8e0b9c5..34d0444ffbb 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4088,7 +4088,7 @@ summary_info += {'QEMU_LDFLAGS':      ' '.join(qemu_ldflags)}
>   summary_info += {'profiler':          get_option('profiler')}
>   summary_info += {'link-time optimization (LTO)': get_option('b_lto')}
>   summary_info += {'PIE':               get_option('b_pie')}
> -summary_info += {'static build':      config_host.has_key('CONFIG_STATIC')}
> +summary_info += {'static build':      get_optin('prefer_static')}

Typo 'get_option'.

>   summary_info += {'malloc trim support': has_malloc_trim}
>   summary_info += {'membarrier':        have_membarrier}
>   summary_info += {'debug graph lock':  get_option('debug_graph_lock')}


