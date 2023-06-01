Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D194719111
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 05:12:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Yj1-0004ec-Dx; Wed, 31 May 2023 23:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Yiy-0004eQ-Ut
 for qemu-devel@nongnu.org; Wed, 31 May 2023 23:11:41 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Yit-0001st-Bi
 for qemu-devel@nongnu.org; Wed, 31 May 2023 23:11:40 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6af6f49e41cso426749a34.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 20:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685589094; x=1688181094;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q/e1i1aI2Lw1PxJYuhieDkEezsSMLZepBlWId5J10JU=;
 b=UX+CExZcb10vDJ7BZGn28Lu/G4NB2EXSeuKS6QkM/r0oaQ/lD4i9aVnsCgcIo8HCVM
 RYawVQYyBUpnTa5g1h8uXXsCpBG2CNED+0n3iTP0LlhnOeh+5OUByn8xMXKN67pT3f7i
 WciAs8HtYDfOdqsuQdGmC02qptuIr7Mao1tnxTT07j5qXFR0lU/jNBfhwSPFnvkM1p9h
 8ydMRiKMCMT2OHtUQCL0nEgB8xutSgFAymvNqRPMtb5Da6ivwHRM0TsjFsOMX1085KO2
 vGXFIktJ+ZFZ2raIi9u6yZiLiREYPwT3jrzhq4a/IuQClJleyRuTM5OpYiuJwe1Ja8mG
 dcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685589094; x=1688181094;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q/e1i1aI2Lw1PxJYuhieDkEezsSMLZepBlWId5J10JU=;
 b=RxmOgcYaZTTbJXIeZ6eOwiGdlxMP+0CTkb267AmnaWxOiVVp3HCURhuude5825ilpH
 XUGO4WwWyYbMp+cFSlRgb0aZ1BKkF6I11eZGDhzfxPKlFzvLkQoPNIjBlp09ZjcoK1w5
 ZXPu+j5nXaJBQKrGr+wl7i/eCZZZSBb0zV80UiREnuJX/yN8I/JxaEhMpOpTLBKRa7Ip
 OKSzcCo8okFXE3BnDuCIA/rc+DqxEHVDKjqxun36Rq4G3kXEo6yEJNDRo4NjJYdkYljT
 gSd4hUvSVF6TbG6jgwvM2aVmIl4LJ4zi8A/mjeortWqZOq3eKmczRbo7AuzGuuUzzSoM
 WoJQ==
X-Gm-Message-State: AC+VfDw3PhUKAPif0A6P7BqEUFTDdK/NaYV/ySeBzkOINM7Pgoh2BK/b
 Tadckx7w0eZc3ZhLq/e3lAdC/Q==
X-Google-Smtp-Source: ACHHUZ6Jsyb34AuSrhRCiYX9feOKFgujAaRibyOKBuXoz645cthw2yLV5TfGeQYhbwetUv2vJ9HojA==
X-Received: by 2002:a05:6830:13da:b0:6ac:8801:24d6 with SMTP id
 e26-20020a05683013da00b006ac880124d6mr4235685otq.26.1685589094075; 
 Wed, 31 May 2023 20:11:34 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 v23-20020aa78517000000b0064f71d8adf8sm3950029pfn.208.2023.05.31.20.11.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 20:11:33 -0700 (PDT)
Message-ID: <93d1ce82-72ec-4a7e-a595-600993f6000f@linaro.org>
Date: Wed, 31 May 2023 20:11:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6/7] hw: Simplify using sysbus_init_irqs() [automatic]
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20230531223341.34827-1-philmd@linaro.org>
 <20230531223341.34827-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230531223341.34827-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/31/23 15:33, Philippe Mathieu-Daudé wrote:
> Change created mechanically using the following coccinelle
> semantic patch:
> 
>      @@
>      expression array;
>      identifier i;
>      expression sbd, count;
>      @@
> 
>      -    for (i = 0; i < count; i++) {
>      -        sysbus_init_irq(sbd, &array[i]);
>      -    }
>      +    sysbus_init_irqs(sbd, array, count);
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

