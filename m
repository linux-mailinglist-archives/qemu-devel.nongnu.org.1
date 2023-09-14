Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 239847A09CE
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 17:54:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgoep-00012S-03; Thu, 14 Sep 2023 11:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgoel-00011p-3O
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:53:27 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgoei-0007nx-TJ
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:53:26 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c0c6d4d650so9937645ad.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694706802; x=1695311602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VW0seTdjEBZufmuDlKj3ShatillH4T0HkLHJ0NM4rfk=;
 b=NyTH9ecAPVWyeeWHiJRagmD4G+eprJm/KcpAKoMi1nF0lvzCwm7VQqLwg8Ff5smpsk
 wI8/Y0T7yzidlQH0yWhhpDD3TLMQ9Agsi5wUP18Xv7KTV+N9takaQIKp18E1Uej66IzH
 uhYaXVEBA1Hq2AdhXVu4BaA57mg0e+bYjQ/1hdyAQ/rPgp73gR24zpSc/XGDxsUBe2Th
 NZ+tZYEPSybWLd5McsV0xvg36zZ9ZhlfAbtO3PVNeod0CvDeZLj7ppdbwKCHXZkfYWIY
 l3oZ5pTs/b8AMHtkODGVCjDhYqz/v6vyGmC7+8eTkj1R7AGMe+fk3T/3ScR7F4ACvS78
 raMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694706802; x=1695311602;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VW0seTdjEBZufmuDlKj3ShatillH4T0HkLHJ0NM4rfk=;
 b=dKCUn7AcTW5BblBo8TawURb1XhlnsnXuH+ouPFJWkleV8++6r7Kb/nuEbwoHiDhFj9
 1NW4oXCf6Kvz7ks0cUYOOBDo6782WouzIUsUIKjKzP9yjaCDB+LEhduII8fPM+3DcXAV
 KysOjTVxo/BMvo/NX/poQqjUdDXWme4n3DNu/IM76lxZxX3W6gIL5RqVxW3fw4Nu4IfQ
 R5Ro7eOPaeUs3xoX8xObve/nuYewYx8FKr/nMVT1ygIglTv6NCP2zskzeN+IJDTgGHvZ
 SMRPSvvN6s5K64tLNTDGn8TZcn8swwIDW+bZxvCoVMyhxOb481ZX6xEkhOXNJLbXRUcm
 F0Rg==
X-Gm-Message-State: AOJu0Ywdf/ewd8GsbZkYJi7DHSBKjfBauZjTinewUiWtpD0pQhYyg/eR
 tRBD4d/V/9gYhNGEkla9whAC1A==
X-Google-Smtp-Source: AGHT+IFIJ0cO6uEjbiemAjLIqFqzbPsYqlw+vFElanumMenWmFnyBEJxxjVoBu3V3mJaDGfQOBgBdA==
X-Received: by 2002:a17:902:b697:b0:1c3:d864:d6a8 with SMTP id
 c23-20020a170902b69700b001c3d864d6a8mr5669061pls.23.1694706802366; 
 Thu, 14 Sep 2023 08:53:22 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a170902968700b001adf6b21c77sm1761478plp.107.2023.09.14.08.53.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 08:53:21 -0700 (PDT)
Message-ID: <ef057c7f-6340-3f79-88e0-605171e2ac97@linaro.org>
Date: Thu, 14 Sep 2023 08:53:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/3] hw/arm/smmuv3: Advertise SMMUv3.1-XNX
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, Mostafa Saleh <smostafa@google.com>
References: <20230914145705.1648377-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230914145705.1648377-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/14/23 07:57, Peter Maydell wrote:
> Peter Maydell (3):
>    hw/arm/smmuv3: Update ID register bit field definitions
>    hw/arm/smmuv3: Sort ID register setting into field order
>    hw/arm/smmuv3: Advertise SMMUv3.1-XNX feature

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

