Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA40E7EA59E
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 22:53:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2erp-0005eU-2x; Mon, 13 Nov 2023 16:53:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2eri-0005e3-6F
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 16:53:06 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2ere-0003jj-W6
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 16:53:04 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-53e751aeb3cso7628632a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 13:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699912380; x=1700517180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1cfqOQxFSILDkSp2DTNj1jhl1bOT+HIOtitrRoDIf0k=;
 b=J0H0mk07PlzyJHH5VN2YNsECD/O+qREo33FhqQ7PvOZaPt4llYz4hdvKYlJV/awM4U
 reulD/xITWbydRWvRZ+/sIP53nrdSGgr/W5DAfkZIbu9psL8w+hT8cl8b2a06H33hydc
 WcywbnJXKiWjKl1TRoCfj4/xlkMqrS+wpSuSw6x+zggL0wyilFiwjk9djjUnopatBTaz
 rNONEFsfYEFlYHd+HG04oLKgOzWKn2KNk4PG71sR+X2tR7LZNYY6EMP0wa62f2S+amHv
 KZJz0q4qEsglgPHtBtnhOprMuC56BhfSktTAIeI85R/8ehYsRFunxdk/iuFZr5I2Lpp+
 wdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699912380; x=1700517180;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1cfqOQxFSILDkSp2DTNj1jhl1bOT+HIOtitrRoDIf0k=;
 b=OtkibL30UIDWIcoiW9zl5Z2XYkrfS3ip36KfwB8XgYiSc38R5u/GjQzyI7gvRkuepb
 RN8WjwSGzNkbUi9zSQpTRBlikbFMXhvfZsG1FFIeSrjRpXAlwvXQ5TiGzq2GnpzybdCl
 5mbHSPUaYBOTOAtHhwoXxyPZeoi/KZY96rX58fa8gOD1zNQ+KWikDCw0qqw3abHOpRIF
 HC/75xlu9J98zejFwy375ppMTiruwP4Y32Hc3qmjp3T5ifpf4rUDYCX2rbf77HcxtxId
 4M0iRk2qNGmrDmuRa/AirGF3T4Oc/gEohrISEfPTyFGLWdOHLghLrd8aLwJm253uaN3E
 88FA==
X-Gm-Message-State: AOJu0YzUfQTr88FXCW6C9NC/8hnciCmHRf0fs1j9B2f7BkhedbquwV9L
 enLK8OsBojNYsLMhvEZNaKclnw==
X-Google-Smtp-Source: AGHT+IFgk0wOX3sN9GDkUC0DYL2DIEi8fIc5KpMCLkLhpgtd29TZ/sEwFdlJ7KwcEBLpHrAglSLFpA==
X-Received: by 2002:aa7:d699:0:b0:543:f7f5:83e5 with SMTP id
 d25-20020aa7d699000000b00543f7f583e5mr5615282edr.29.1699912379812; 
 Mon, 13 Nov 2023 13:52:59 -0800 (PST)
Received: from [192.168.69.100] ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 m20-20020a056402051400b005333922efb0sm4215687edv.78.2023.11.13.13.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 13:52:59 -0800 (PST)
Message-ID: <cc03e6fb-a60f-44c0-ac74-3491128db420@linaro.org>
Date: Mon, 13 Nov 2023 22:52:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spelling: hw/audio/virtio-snd.c: initalize
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20231113212033.2457365-1-mjt@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231113212033.2457365-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

On 13/11/23 22:20, Michael Tokarev wrote:
> Fixes: eb9ad377bb94 "virtio-sound: handle control messages and streams"
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   hw/audio/virtio-snd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


