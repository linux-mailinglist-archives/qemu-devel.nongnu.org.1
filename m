Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6D47DEC2C
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 06:16:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyQ3t-0007Jl-4h; Thu, 02 Nov 2023 01:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyQ3m-0007Hd-Pv
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 01:16:04 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyQ3i-0001pH-5B
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 01:16:00 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc3388621cso13683275ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 22:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698902155; x=1699506955; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KSs7wB9zucMgPimtZgaZxTvpHjGFkYI/Q2u58f1JcSA=;
 b=A6ffur96RRFMkb+U/J4AH1iicfaHoG0ipmiZweC277fY7IFsHYVpGmpyRQGhK1UXe9
 FTIxia4Rg/kmdO9fibaXJ0/SKq5dlPSwGZN2qkjnVvrJHpCvImlik2KV1cXz5cOJ4fas
 EV/Nq1CzjQheL6jfGNaCudWoXyyjHETYeIzyRvYfepXRBz77xonrkW+gGTxN4qMdPE3n
 Sp6cZN10im/lo1RlskX0RLKHdoCB21oAil9ozTZq7s4G2HHaGJr40gcL0caj7K/puJqd
 9rpvvO01lE3T6SIMpeidkbCXg7JI3MSIBJ/oQDqpnJ5vfVNNZm5i5HtfcaDTY23azEF1
 qH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698902155; x=1699506955;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KSs7wB9zucMgPimtZgaZxTvpHjGFkYI/Q2u58f1JcSA=;
 b=RvngNCaysLvacCaPC3ZMhnvKdLU+ZukzPZri1c5PNXOFxWALxMMsAGT3ZwH9AR0GMk
 s85okFJmF1MTZlTeEXmK/EiKJpeyZY7DLY3PzlUatmSkAKVvDNJjQsoOr9iwNYAV6XHR
 nxZctex8aaalFIuohVpuuiYoh8kdWylctky9eFHJ5BZWlZklTRVS7mK4VO4EGyR9msAu
 ljGQvxs5+Aofjf3HRHuY859lNpT6SF3D/HMZxyG8ERnpiYj7DpOyNZCzyUdfEnrToZJc
 Vi1X6Sn75yQcSfv/8qWitubeeq4sepAXZh7hWUNQA3Pwo8KFmpl7gWn4FD0BuEKl34hb
 GdMg==
X-Gm-Message-State: AOJu0Yx36vofrnTYtR6fV+fSZaLa5PXpJ/IxdKXeF62KGE7g0FA8pPzL
 5Mv3FF+AQPt/5T24HTV0j679srh5+DrW28avAUA=
X-Google-Smtp-Source: AGHT+IHJutdSw9fEEvTdS22IrsYyzpP+7PQIVWDzWBDfBZJwwdtcNyejNWMzlVrhp2khDLbU2FLzqQ==
X-Received: by 2002:a17:902:e844:b0:1cc:47c1:c2cb with SMTP id
 t4-20020a170902e84400b001cc47c1c2cbmr7565352plg.2.1698902155408; 
 Wed, 01 Nov 2023 22:15:55 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ja11-20020a170902efcb00b001b8a00d4f7asm2126740plb.9.2023.11.01.22.15.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 22:15:55 -0700 (PDT)
Message-ID: <1aec60ea-99ec-4d87-89e2-b35f79f8fdf7@linaro.org>
Date: Wed, 1 Nov 2023 22:15:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 31/33] hw/arm/sbsa-ref: Check CPU type in
 machine_run_board_init()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20231102002500.1750692-1-gshan@redhat.com>
 <20231102002500.1750692-32-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231102002500.1750692-32-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/1/23 17:24, Gavin Shan wrote:
> Set mc->valid_cpu_types so that the user specified CPU type can
> be validated in machine_run_board_init(). We needn't to do it
> by ourselves.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>
> ---
>   hw/arm/sbsa-ref.c | 21 +++------------------
>   1 file changed, 3 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

