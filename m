Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B86C773152F
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 12:26:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9kBF-0001FB-Gr; Thu, 15 Jun 2023 06:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q9kB2-00014M-5Q
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 06:26:09 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q9kB0-000862-DY
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 06:26:03 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4f76a0a19d4so2174356e87.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jun 2023 03:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686824760; x=1689416760;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tWNh5l5zansgkYD8JM+QZqpVlxfmhmpr1H7kB5PRlzc=;
 b=OZBY5bTGLwXNlKlniFuBR+MU4SI5z0PtB1i3oWBTykgh9LmJD/q3UowGwIFi2sIc1z
 dnHb+uJRdV8KTRMrawf1flu6tZlPOcvdZVfxD1eEQ58fFDSVzFtybBKpVN79y1fKqPG6
 HYeTm0E9vVY0vpTU/p3WI2L90nsFIEeX/lu0UlM/XfKoMAf7wQbmR52/+aS3VH0rAb9p
 xqEEknGC4IcKMoMcUAwRy575B/tjCzup0tfrHBS5GvYt6AY9WQt0z3dGU8GBo0MpfZlw
 gvLJau/dCl4Icxl3i43x9HS/fSXQhAv8F4WWRu3vLk8AhRuBZgm7GqKybl0fZKzV+3qg
 DV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686824760; x=1689416760;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tWNh5l5zansgkYD8JM+QZqpVlxfmhmpr1H7kB5PRlzc=;
 b=PjW/Kc/U/uQXrwYCFs7DSjGkUjyB7r+uFkAZQWviWIOizfdqUeoyjvtYTbAc1QCnJ+
 aLZF7FIwhFqKh9N/8WEM2/9GzQHFKswX7pehypow5bxhIyyxRcM0afyk48tmQq4+a+vE
 UkXUmALu5uNGBOUJUU2Uw9qUgD+Ki+r8vTGDMwFR3xqWdsvTZi+wEqxCMKGLI0GAmA3W
 Sx73TV4W/gh/PJMUU/RYUbm3HdUy/+GNaKVz85CANrq677a0B7f/4wAGSXeRIZHVkSFB
 mvFi5tEm3zpKkRr+UQzynWKxvcMbpKZbl7oTX/RasPR+sY+2inTU8JehcJmtGSxqCALm
 p8Bg==
X-Gm-Message-State: AC+VfDxSElfnQ7u0+k2E2KBoHZ7kFY7eQCMEZY38gIg3Jj/g+905UkEm
 Stplr25UgWrPuIdb7X9stTeTDw==
X-Google-Smtp-Source: ACHHUZ4nwkraB7Q2Yo9AZ6t9G0Wi7nRVdJ3LcoSvKUE1x+PpKP5+OsGTe9ImmmOIdJ4ytXHflma/EQ==
X-Received: by 2002:ac2:5307:0:b0:4f4:b864:1da0 with SMTP id
 c7-20020ac25307000000b004f4b8641da0mr10462407lfh.15.1686824760445; 
 Thu, 15 Jun 2023 03:26:00 -0700 (PDT)
Received: from [10.14.201.118] ([213.175.39.66])
 by smtp.gmail.com with ESMTPSA id
 jw23-20020a17090776b700b00974630b1e85sm9180146ejc.155.2023.06.15.03.25.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jun 2023 03:26:00 -0700 (PDT)
Message-ID: <8622a181-95e5-b2df-d09f-77c8c45718f1@linaro.org>
Date: Thu, 15 Jun 2023 12:25:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] hw/riscv/virt.c: fix typo in 'aia' description
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 qemu-trivial@nongnu.org
References: <20230615092148.612875-1-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230615092148.612875-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 15/6/23 11:21, Daniel Henrique Barboza wrote:
> Cc: qemu-trivial@nongnu.org
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   hw/riscv/virt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


