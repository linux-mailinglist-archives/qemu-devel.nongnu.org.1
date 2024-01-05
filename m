Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AACB8252D4
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 12:28:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLiLK-0002M0-Pv; Fri, 05 Jan 2024 06:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLiKT-0002DG-MO
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 06:25:37 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLiKN-00009s-Uq
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 06:25:33 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-55692ad81e3so1625637a12.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 03:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704453924; x=1705058724; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Is4syUN7/x4EQqrOo1gZAChXmkcXmDSsZeHA4i+iDlA=;
 b=YRFymV++TvwhIwDAO1KmemUWPGG3BcD+dYC1VHUO9KRzdNUVqv/AdMszlWewSeA6A9
 VeNpuV8RZeschzeRxU+4VyLZOKZgGhsIzvUyguzVN8XVzvz4aEcKTUn7CkuPGeePhRqB
 WVUHUjJdf2F7BJov6sEsRJNTXkEPOzMNALkVh1DnefzCe7knGg6uCWRBX+nC7duDYcg6
 /IV24d1bT0pdCGCn4sLLr8lD4s9KB3tTqE3g3UxKPr/RnOJTHtGudj1g46oh94HC5IRk
 rYkGJOkXxPrb+I8fqBZfC+2r9AMB+6E8ffg0GbD0Z/KGNJcow30je6mbUacPgbwqudxm
 TJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704453924; x=1705058724;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Is4syUN7/x4EQqrOo1gZAChXmkcXmDSsZeHA4i+iDlA=;
 b=eBq9mRurRwkSipr40Qs74e4WvrXL+AYNJBHPFaoGcIb0R7udHj2rTQRiQlitjQIQS/
 AMYMBw7KqVumEs/1FsVR+HWy8OpbwqW/adxBE0uqsTz7ZxCGmDvfVUt6Mvvxv08sP7lO
 BtYYqHyNBEwmOuqTUfmjSOimBcFIyJJUZsFXHnqn8fmCT85Tj1VX3T9G+ed7PrEcclj+
 g+ZsdhBUhJ/sv9QeZnu3nCjY669GU24wg/Tyj+B4ETfkhGYDfzoMiyU6Z0yXTsFFA4QB
 J8uRCym8+Nkg5UVdVCIV76duCO3mzSUcCN7z9fkzw+pY3DgVb3TzTAVe7Se826UpeLCv
 C/TA==
X-Gm-Message-State: AOJu0Yx5Xu9A87dwadhyux2ZZEAONOO4TZ0V0QJ3s2aR53j+tuUXeSGK
 m5CDsLxDdWsDR1wpoInRfzkVCIv9qsodtTS+wKhUzfZt3SQ=
X-Google-Smtp-Source: AGHT+IHpCIkZfu5KLVyqWILUye3jxXVpRAqBjzk9sKICRFXYusg6dCiQxOHSXn9y/GzD5kWeTTJ4Yg==
X-Received: by 2002:a17:907:c9a5:b0:a22:ebf2:1edc with SMTP id
 uj37-20020a170907c9a500b00a22ebf21edcmr808537ejc.16.1704453924310; 
 Fri, 05 Jan 2024 03:25:24 -0800 (PST)
Received: from [192.168.69.100] (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 a17-20020a1709065f9100b00a2471bb0d11sm781882eju.31.2024.01.05.03.25.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 03:25:23 -0800 (PST)
Message-ID: <55b93d1e-646b-43c3-ab05-d58b968b9b34@linaro.org>
Date: Fri, 5 Jan 2024 12:25:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] intc/grlib_irqmp: add ncpus property
Content-Language: en-US
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20240105102421.163554-1-chigot@adacore.com>
 <20240105102421.163554-3-chigot@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240105102421.163554-3-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

On 5/1/24 11:24, Clément Chigot wrote:
> This adds a "ncpus" property to the "grlib-irqmp" device to be used later,
> this required a little refactoring of how we initialize the device (ie: use
> realize instead of init).
> 
> Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>   hw/intc/grlib_irqmp.c | 30 +++++++++++++++++++++---------
>   hw/sparc/leon3.c      |  2 +-
>   2 files changed, 22 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


