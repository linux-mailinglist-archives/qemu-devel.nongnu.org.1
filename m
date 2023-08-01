Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A21A76B5EB
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 15:33:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQpVA-00051a-Jm; Tue, 01 Aug 2023 09:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQpV8-00051F-Vq
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:33:26 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQpV7-0001IZ-02
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:33:26 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fe1a17f983so24039625e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 06:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690896797; x=1691501597;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sCAq8iCMq3AgaS8QJXLrEnfDEuGyUVO5RxWII8VYXEU=;
 b=n4oHl9+6sm7qlpyQ+9uikHSEt6S4MN3wVFvITKlY6H4KWiHjti7zVi5s6GTqcUIYpc
 U1eGlP9PQBM/F/puqaj86XHJZhw0Wjtqxs8RbPHAgYsPIsuwBvHn8ulP0VhhnOgcQzUE
 ipYYserqK0lB+UsRNmSO3koxrn9y+q2N3CfsGvepIuezVB3Os0LURR7lBP8Ok20ETpgm
 y8YW66lNVkKhpvjCPPzvj3b33lgKtRoNrJCRYYcOgKuxxiS7WEsFD+0UtcUYZTAZCv/K
 pPRf4LbGYkcmRdKC+RSoWwE2B5imeJVZcZdIqQEzcKVAwUUBc8S4SWwZ2/jsi7+Hll2S
 jm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690896797; x=1691501597;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sCAq8iCMq3AgaS8QJXLrEnfDEuGyUVO5RxWII8VYXEU=;
 b=Skvhk3LkTeXM/VBnsfG0mfcvLeMtt45NdQy0RFjpxi/+weRIRabEuWJd49oLLP/yca
 /ll1dGAMSwZylxeqsIt+mynuW/L4BO/zdlW+Sozklc2ScI+kfIVJdzgRLgD6Jx2hSGcH
 JC8zi5ZaTOKVCKRclu6hORqKwzNM+rG/USqd8DzeaLQPALvO7YeBAYCyh/mNgg2ZXUgS
 nLH6nNX7L2ZiSUNhs4VZgNKOBLRTCrA+EIf8J4aC3VA7+rxLpthkWFvwSAePWDtpe4QL
 o+Q1jc/qydeuUcuCu6S/n2tPZK11V2vJlYsD5XuKzNyYBEFDhaNWeVwWix1dUaoXgwMK
 JaQw==
X-Gm-Message-State: ABy/qLZ4gQLIJBQk9WgEarePCzDgw21a3RN9r0INHXePfb/anFW/cKOZ
 ma7sLXk5Ja4OBAnhGa3f1sM22A==
X-Google-Smtp-Source: APBJJlENsEbfR/co73PqEVmS4NfYWAhAq9URweSyXzwocAQ5ZFx6lVfPw78RkAdfvEJ+B35APXu2Yg==
X-Received: by 2002:a05:600c:2287:b0:3fb:b008:1ff6 with SMTP id
 7-20020a05600c228700b003fbb0081ff6mr2429844wmf.0.1690896797272; 
 Tue, 01 Aug 2023 06:33:17 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a7bc8c2000000b003fbc9b9699dsm14131162wml.45.2023.08.01.06.33.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 06:33:16 -0700 (PDT)
Message-ID: <74d75da0-3a0a-2c15-43f4-6915ab1677cb@linaro.org>
Date: Tue, 1 Aug 2023 15:33:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] vmmouse: replace DPRINTF with tracing
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: zhouzongmin@kylinos.cn, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20230801093928.309361-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230801093928.309361-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 1/8/23 11:39, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/i386/vmmouse.c    | 29 ++++++++++++++---------------
>   hw/i386/trace-events | 10 ++++++++++
>   2 files changed, 24 insertions(+), 15 deletions(-)


>   static uint32_t vmmouse_get_status(VMMouseState *s)
>   {
> -    DPRINTF("vmmouse_get_status()\n");
> +    trace_vmmouse_get_status();

Isn't it useful to log the status here? Anyhow:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +
>       return (s->status << 16) | s->nb_queue;
>   }


