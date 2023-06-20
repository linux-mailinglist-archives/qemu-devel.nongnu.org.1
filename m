Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABF8736358
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 08:00:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBUNu-0003vx-RA; Tue, 20 Jun 2023 01:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBUNg-0003tz-NC
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 01:58:22 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBUNf-0004DL-5h
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 01:58:20 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-51a20138617so5980126a12.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 22:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687240697; x=1689832697;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2xcBAdwII6yzsWBjXS29yhfUkfOz3aLh72vXGr5+6UA=;
 b=lgFSgJJLMoTg2aDOhHg9Rn5QTdCdYuc3Q3AFg3S2oxnJ4z/oV4B4vVsuRk0o5zrjZa
 IbQpIqLPZ91fEQRtHZaXutk1BDpgnYPPUFg0JRUWuIJ/R0GguwcNKe4a8SXIiAtmiqlo
 EQQP1zYmr74TQX3eucXkRxUYm9Mn+4Of/yIOXl+xZHFtkKkDx/OntHznuUVmYMpstktB
 +/hPH0Fw9OEqOYlR8R1L9Jc34sm7cz55cjj+Aug0DQ2vYmQ33qNJyjl3MQE5r67TOSNG
 XOWm1e14/npRTEzI4fyTr/4VpM8J8Ve+B7n5pxCRrXMdqv04VTtGEtiQn6+pazWOWadi
 VWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687240697; x=1689832697;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2xcBAdwII6yzsWBjXS29yhfUkfOz3aLh72vXGr5+6UA=;
 b=Gz8KhCrw52jFVGDzmtlSowXaugLIe2XnR9GIJt/RGNfPYipemxJ6yAozwYaXzyEQ+2
 ZwAXRZprzo999Kn5RTLXusGTEXn11Z4ixL3e9ukyAG0BsaYtDT/B9ANaOdcj4XDMkmDV
 BJvAJR623LS9/rqjoH/ZYHbMR/wVxsQwDfRongzTLwU2a0jy2h6XSqLUIVPuUaSDxAhM
 dw6eJkRDYHrkKeuhI/Z6mMjrz3FNaTv0LHb4II0xDfzpxqBbXBQ5MtFPeMl6AW+oldD+
 NLgeu3WkY/lZeZHDVejONqROqAjyhmo4OHNehYCbrlliCwTzNm4a18uvEgSkQs96xXwG
 MPTw==
X-Gm-Message-State: AC+VfDyPRhE9QmTc9Syles8RObyRE2Tfv2jk6GcmLWSSiDggrYX1Kd4i
 jk41ho1KzssfuU484tF/GOEjPg==
X-Google-Smtp-Source: ACHHUZ4zukHqu+GGT1rXm2Pbjps8VyWC+0oxhyyBXqgXBObRjYcMF7D4Vp6zTXj5up5AXb4BRfdRKA==
X-Received: by 2002:a17:907:16a2:b0:982:9a9f:d43c with SMTP id
 hc34-20020a17090716a200b009829a9fd43cmr10761085ejc.48.1687240697414; 
 Mon, 19 Jun 2023 22:58:17 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 fy25-20020a170906b7d900b00969f25b96basm682646ejb.204.2023.06.19.22.58.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 22:58:17 -0700 (PDT)
Message-ID: <5bfd2c65-882f-eed6-4988-9d717271a617@linaro.org>
Date: Tue, 20 Jun 2023 07:58:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] ppc/pnv/pci: Clean up error messages
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20230619233636.57452-1-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230619233636.57452-1-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 20/6/23 01:36, Joel Stanley wrote:
> The phb error macros add a newline for you, so remove the second one to
> avoid double whitespace.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   hw/pci-host/pnv_phb4.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


