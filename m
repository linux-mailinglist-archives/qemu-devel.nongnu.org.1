Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6887E2068
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:53:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzy9s-00078c-0f; Mon, 06 Nov 2023 06:52:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy9q-00077P-6e
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:52:42 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy9n-0006cc-Qw
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:52:41 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32fb1c35fe0so1950946f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699271557; x=1699876357; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ExO0Fs8YeM9VzNso1RrCMwRqdhhOnWSbgYPYG52EB3o=;
 b=lB479w7O2FfAGb+wW36mQmgNRaIljJZ10ngFZFZhi/Aibff+8HCIpKCUfqcHayIf1+
 KMGW4PnS/pPy0gX1yN4mY1LBA7tagz+MBQSXjH6uD7Ya7UMZlrnskFPOC51EExKya+4/
 F9XQOxT4XR3+g7ZyiML4ZAAduAjwWPa9OoYt6ZJONPYuimYeQst5jD8f/zH97ujFGyiz
 ZIrjaOe8+vMrCRTBwVNGUbOb+mPkkDwuL0I0rpYvnqUzu5kD5H4GkDo3qybFLMtvf+1C
 H6CW1iUjyjTbKS8yeInXfRNCxiZ0HgClgL64db3wfSzlnQYwhaeOTLC2f3m0P+6OQAhc
 XDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699271557; x=1699876357;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ExO0Fs8YeM9VzNso1RrCMwRqdhhOnWSbgYPYG52EB3o=;
 b=Zss4526nLFNTciS5CkkskwId31jc7XHSR8hJDLUti7zzzazspH+5IgHT6Eic4Dgo2o
 Nub0mGPNY8hsnqbKR4I7N2OKM7/giNsWFnxC9uSMm7x/C9Y73AArKhOouH8V8Z5gBrOi
 wJUUxHub5pTPQrP5v2RM29daXwn1fKyjxkpuHxtLec5waBeC2ZwbYnB8RyoGXgLA7bSV
 Mcs1vyE+/AJYggowWBEJP+aLigZ+AH9jkjsDiSZdODosnhN+LpZHG90Hkmi6OTdzTyX0
 Ldk+wjbs3hrcigQwOo9wvhLUyJhr198P7F3HGQZXyFqkGMr2OcDfL+2C0q4jOwXsQPcJ
 H4oA==
X-Gm-Message-State: AOJu0Yz8/KIe6Ztb6vxQX9GLJwpqyakP1r3pdPKz1H8U5dVmc3vgAhK0
 UGg1OP9i6/39gdoRPvl6SFd/G8KbrtMJU57frvI=
X-Google-Smtp-Source: AGHT+IE4f4TtFXcFiMmIhLmfDsDtgtr1emLmyZ6vsc3DCKcol5kKjyWjOHXqdMX0yViUeN9oU/Vw3w==
X-Received: by 2002:adf:d1e8:0:b0:32f:7d50:267e with SMTP id
 g8-20020adfd1e8000000b0032f7d50267emr23960776wrd.9.1699271556853; 
 Mon, 06 Nov 2023 03:52:36 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 g2-20020a056000118200b0032dcb08bf94sm9260507wrx.60.2023.11.06.03.52.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 03:52:36 -0800 (PST)
Message-ID: <fb485028-8cfe-6de4-d91a-9ca46c3f4f2a@linaro.org>
Date: Mon, 6 Nov 2023 12:52:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 46/71] hw/pci-host: Constify VMState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-47-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231106065827.543129-47-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
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

On 6/11/23 07:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/pci-host/astro.c      |  4 ++--
>   hw/pci-host/bonito.c     |  2 +-
>   hw/pci-host/designware.c | 10 +++++-----
>   hw/pci-host/dino.c       |  2 +-
>   hw/pci-host/gpex.c       |  2 +-
>   hw/pci-host/gt64120.c    |  2 +-
>   hw/pci-host/i440fx.c     |  2 +-
>   hw/pci-host/ppce500.c    |  6 +++---
>   hw/pci-host/q35.c        |  2 +-
>   hw/pci-host/raven.c      |  2 +-
>   hw/pci-host/versatile.c  |  2 +-
>   11 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


