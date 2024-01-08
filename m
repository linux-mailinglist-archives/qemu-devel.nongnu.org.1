Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AEA826D61
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 13:03:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMoLZ-0001hR-8G; Mon, 08 Jan 2024 07:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMoLW-0001gs-Ie
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:03:10 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMoLV-0005bq-0h
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:03:10 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-336990fb8fbso1695382f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 04:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704715387; x=1705320187; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zpymm/kt3CHzXmb7fCv0GtjP6/svBoF6IF2skQ/PclE=;
 b=Nus1EJW5PtDhVmkZVmUOwTmtEO4w5LsJWs88dHd8qt1h3Cexl7R+TIMaaLukV/7Fay
 p+0VjeN8HQ1GOP/PWOElCKxc4ng+2s9ceAWrlnixMWAywNMfauSm4pmmgdw5r0/2JOYu
 ReKhwb3AlLFxXO5yKlW3/t0wq2CPS8+bcagyprNg6o74JPpDaJRNR03CEjYg2E/fcckW
 5pQgcSPML8lqQ5bb0TsUyqocJaIC/lqQW4s99nqdbDb3XfoTSX5DHA4udd3LkdjrR0dH
 Vevv/1Z7q85Qvvyg7czpumePDXd+qzeChQSQoB5RjblxGl1aBbgq+hO+zvY3yZrRDETa
 tQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704715387; x=1705320187;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zpymm/kt3CHzXmb7fCv0GtjP6/svBoF6IF2skQ/PclE=;
 b=LwQai2j6jyZ0f8NbRQqGDuvqpj9/JWiP/O42TrBnEIuo/yD9PcUw509kliItzNtUjY
 Dbp9qK2bnLo4kLvVW7lAuRp5s04HX/NYk5olYV6Oqzt2RVCd1y7Cd/dwnQKDDHpb5j78
 z/tW7D1JBqkBagTdb50TJ4F+oa94Vgo19fcq9K0YaMOf/76OxiDNe0d1+kWV/YaUVrLv
 MLtFXxnvajCNL0iBUNc0YGezHRl0DYOCBbBbyr2O+00Rvv/HbHSD5TP2+E+vftgyTddp
 ADtkvfsVEaHpaSO2E7nM7muk2nFtv52QXT0cRVbnWfSMGC+L96Gxv7owYU0HEquvWALY
 fEFA==
X-Gm-Message-State: AOJu0Yz4R/F+PwcYCqlfJ57m2C3Mf0nhQ0uMdI/qfz8Vou9tgNSzxGCA
 /8ln8leq0nDtuk7rFkqZvHwfUTxgyF+o9s6jTDzAZj2rUdY=
X-Google-Smtp-Source: AGHT+IG4AWKp+4MA+E2hTaQLuUMbYXqp7gs8YxvhhAA+UGtO7eaAHJuvrXoIPAhSHcxKfym7cCjzDw==
X-Received: by 2002:a05:600c:6907:b0:40d:88bc:a896 with SMTP id
 fo7-20020a05600c690700b0040d88bca896mr1859077wmb.62.1704715387557; 
 Mon, 08 Jan 2024 04:03:07 -0800 (PST)
Received: from [192.168.1.102] ([176.176.175.62])
 by smtp.gmail.com with ESMTPSA id
 bg11-20020a05600c3c8b00b0040d6ffae526sm10813708wmb.39.2024.01.08.04.03.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 04:03:07 -0800 (PST)
Message-ID: <0ba00ce5-0b4c-4e43-890d-9ebe6ecca6bc@linaro.org>
Date: Mon, 8 Jan 2024 13:03:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] hw/arm/armv7m: alias the NVIC "num-prio-bits"
 property
Content-Language: en-US
To: Samuel Tardieu <sam@rfc1149.net>, qemu-devel@nongnu.org
Cc: Anton Kochkov <anton.kochkov@proton.me>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240106181503.1746200-1-sam@rfc1149.net>
 <20240106181503.1746200-3-sam@rfc1149.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240106181503.1746200-3-sam@rfc1149.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 6/1/24 19:15, Samuel Tardieu wrote:
> A SoC will not have a direct access to the NVIC embedded in its ARM
> core. By aliasing the "num-prio-bits" property similarly to what is
> done for the "num-irq" one, a SoC can easily configure it on its
> armv7m instance.
> 
> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/armv7m.c         | 2 ++
>   include/hw/arm/armv7m.h | 1 +
>   2 files changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



