Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F109E80092D
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 11:58:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r91Db-00024E-Bw; Fri, 01 Dec 2023 05:57:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r91DT-00022t-39
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 05:57:51 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r91DR-0004N8-0j
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 05:57:50 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40b4746ae51so18612795e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 02:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701428267; x=1702033067; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DNRPfE3nS0S9aFqg9iDHO3DZDtkZRObv/JYi45WTizo=;
 b=OS4mdo4Lj/VuiDkyuJ8pP7AoGJ+LB4MvndeQC76qwYg6pMVxvTPXUtNCheP8+pN7wd
 oj2eCn7x3tPULtb3wEllBO+XI0eNFWQYgO1NkdLwQcRjZFUIK6H/Pb4TUjs0B/0aVW/R
 AQJ4gWT90ywIOTcHGPW1jfPIJc2d+K600DCYr9lgNWCFt5nFfLf4290xHyQs+b7J27W6
 MdvTLvKQjxoUp4A9EfCFHK1UzC+WljLjOxYayPlOJ/h3H83Lu5TilP7ZQ4E+vpE4mIK8
 mAE9tEoHXCeBHuiIJV4C6c9gbqk4Wmde8/tnDX9ym1vyApAYtPgOvkJ930jjBwNz9hpc
 WBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701428267; x=1702033067;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DNRPfE3nS0S9aFqg9iDHO3DZDtkZRObv/JYi45WTizo=;
 b=Fhda+OkklFy6SqrILa53qY7ISJxBCHBxxQuLQDZruTjK4zCI0oRlXXhqhrlf2oQiGK
 qSCdO0tP+L3ARu1zQ/6LaXJTWnjwrTtwCEHp9HEPKIIA3mJER91mIm8fGHc2RgOVirN7
 eg2oC/cf53X71Y9JSsblSTOy6nhD5pqYdTbRSWWNJK6fSiLA+Te9xcXNvcn4lcZfWIf5
 V+OVew4wVzG/pGA/MHVrAb02xbNFJjtIvrGkVquq9Q/MMT3SUscNM422KnbKlEYPoffD
 aFfv5NFBMeYgSsfFNY/aaziCDuqEihQ8L1qAjiQVxbFB/kNDH+sQsUdWwDio+hCGCgqe
 RIbg==
X-Gm-Message-State: AOJu0YzqhPyMHb7YV/ysjF58kDzJgBapnVKTPJqkQIRZJu1I53TQ/chf
 I9krOphgg8VI5q0qbCs+mgObpQ==
X-Google-Smtp-Source: AGHT+IG5WsuVWqCIgmlBCmfkg0OkVxgbaNYeOvgP60jLLTkRjCX0PiXTtDD6TLw1h8mkc5t5EJEyrA==
X-Received: by 2002:a05:600c:1709:b0:40b:5e59:c566 with SMTP id
 c9-20020a05600c170900b0040b5e59c566mr332467wmn.144.1701428267367; 
 Fri, 01 Dec 2023 02:57:47 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 a13-20020a05600c348d00b0040b5377cf03sm8725717wmq.1.2023.12.01.02.57.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 02:57:47 -0800 (PST)
Message-ID: <83046c42-1df3-499e-b202-b123391d39cb@linaro.org>
Date: Fri, 1 Dec 2023 11:57:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/9] machine: Improve is_cpu_type_supported()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, b.galvani@gmail.com, strahinja.p.jankovic@gmail.com,
 sundeep.lkml@gmail.com, kfting@nuvoton.com, wuhaotsh@google.com,
 nieklinnenbank@gmail.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com, vijai@behindbytes.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, shan.gavin@gmail.com
References: <20231129042012.277831-1-gshan@redhat.com>
 <20231129042012.277831-4-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231129042012.277831-4-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 29/11/23 05:20, Gavin Shan wrote:
> It's no sense to check the CPU type when mc->valid_cpu_types[0] is
> NULL.

This case is a programming error, right? We should simply:

  assert(!mc->valid_cpu_types || *mc->valid_cpu_types);

> So the check is skipped for this particular case. The constraint
> has been taken when the error messags are appended.
> 
> A precise hint for the error message is given when mc->valid_cpu_types[0]
> is the only valid entry. Besides, enumeration on mc->valid_cpu_types[0]
> when we have mutiple valid entries there is avoided to increase the code
> readability, as suggested by Philippe Mathieu-Daudé.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   hw/core/machine.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)


