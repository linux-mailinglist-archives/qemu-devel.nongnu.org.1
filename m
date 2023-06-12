Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 687C272D44C
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 00:18:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8pqq-0006uh-Sa; Mon, 12 Jun 2023 18:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8pqp-0006u2-1d
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 18:17:27 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8pqm-0004rZ-Dr
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 18:17:26 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5147dce372eso7220470a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 15:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686608242; x=1689200242;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b0f5TjXlgRyoRtOMkfcy9jl0thKSw7AmRg3kqPelvws=;
 b=h522zqq/PIgZLUffQUjDgZZJ/lrgKZOjiwxvNuveiOJFddL/2sfPW9JJDyrwolSKZR
 V1pbWMpUiKn6da6TV5KlDo/ef9sxHXE51YHEn7YqovbxWQEVbYGV4b+wtVSJ9JIaqp7P
 hl/WEfxjGaqmWb2FPh7lveye96rM1+zRKkgSAD951KarsQMmpL30YMulu/7P9MaZ1zPT
 FC/f0Vdn8n9vFAPDc2SW1OHmxAYMxgrglHBIkxUCAbzlhAGbheYHaeJBssrnsZ4tAfs4
 Us5E/02eDQhGajzAvHbYoIxTyxU8gNFeLtVmUyGsPMZOb5/O+x9pKMBx+aWpNKtGol3o
 6iZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686608242; x=1689200242;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b0f5TjXlgRyoRtOMkfcy9jl0thKSw7AmRg3kqPelvws=;
 b=LVbuUS5KU7JoXEU0YkFthpPF8m0pYQGGJO67CJosW8zAiKCj5QAv6IKX1pTusy4/Dr
 /PZ/5ML1Q/HW73aaQ+BRi/eJznS+aK9VMr4jcUUOh+jzRXFCNVbXswqwQMIPDLJmU4L8
 Rh4N3ApVl3ZHcH36k0OCQsK1QpfhKg1PLgn0k1rjDGMWMnhOM0hffxgmB6QCxTddS2me
 rAhIg31IUz7ssKgd95CWbW4UUU+eDsc5gDz+uvDwUVYTcMV/9xh1ELvfxBtdxtYaTMXL
 EmzwI3PqBY1h2QkUI/szIVbskdMFfCHAQ0MJCqJt9zNcefz0B5Cwr1rfl78Om2CiUen1
 DREw==
X-Gm-Message-State: AC+VfDyftTwCTLEFlnaCPmXxuPDg2Y5Wug0BynpSY9orL8gpGUCvWI6M
 v4vtBDJvQJPum/Cl6eTtbPliaA==
X-Google-Smtp-Source: ACHHUZ6bEjYybbhP0p00KykirhuOMCR5VxWoWQCUXiknBjJsWswQHZmqMU0JPVicqClxKKBiNy4/XA==
X-Received: by 2002:a17:907:318d:b0:974:6176:2223 with SMTP id
 xe13-20020a170907318d00b0097461762223mr12259944ejb.13.1686608242167; 
 Mon, 12 Jun 2023 15:17:22 -0700 (PDT)
Received: from [10.10.0.115] ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 p22-20020a170906229600b009745c628bcdsm5752124eja.93.2023.06.12.15.17.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 15:17:21 -0700 (PDT)
Message-ID: <239a543f-6d97-eb14-ba4f-284093fccfba@linaro.org>
Date: Mon, 12 Jun 2023 15:23:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] imx_serial: set wake bit when we receive a data byte
Content-Language: en-US
To: Martin Kaiser <martin@kaiser.cx>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20230608154129.133169-1-martin@kaiser.cx>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230608154129.133169-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi Martin,

On 8/6/23 17:41, Martin Kaiser wrote:
> The linux kernel added a flood check for rx data recently in commmit
> 496a4471b7c3 ("serial: imx: work-around for hardware RX flood"). This
> check uses the wake bit in the uart status register 2. The wake bit
> indicates that the receiver detected a start bit. If the kernel sees a
> number of rx interrupts without the wake bit being set, it treats this as
> spurious data and resets the uart port. imx_serial does never set the
> wake bit and triggers the kernel's flood check.
> 
> This patch adds support for the wake bit. wake is set when we receive a
> new character (it's not set for break events). It seems that wake is
> cleared by the kernel driver, the hardware does not have to clear it
> automatically after data was read.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   hw/char/imx_serial.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
> index ee1375e26d..44125d5f47 100644
> --- a/hw/char/imx_serial.c
> +++ b/hw/char/imx_serial.c
> @@ -321,6 +321,9 @@ static void imx_put_data(void *opaque, uint32_t value)
>   
>   static void imx_receive(void *opaque, const uint8_t *buf, int size)
>   {
> +    IMXSerialState *s = (IMXSerialState *)opaque;
> +
> +    s->usr2 |= USR2_WAKE;
>       imx_put_data(opaque, *buf);
>   }
>   

Shouldn't we mask this bit for interruptions now?

-- >8 --
diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
index 91c9894ad5..b823f94519 100644
--- a/include/hw/char/imx_serial.h
+++ b/include/hw/char/imx_serial.h
@@ -71,6 +71,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IMXSerialState, IMX_SERIAL)

  #define UCR4_DREN       BIT(0)    /* Receive Data Ready interrupt 
enable */
  #define UCR4_TCEN       BIT(3)    /* TX complete interrupt enable */
+#define UCR4_WKEN       BIT(7)    /* WAKE interrupt enable */

  #define UTS1_TXEMPTY    (1<<6)
  #define UTS1_RXEMPTY    (1<<5)
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index ee1375e26d..c8ec247350 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -80,7 +80,7 @@ static void imx_update(IMXSerialState *s)
       * TCEN and TXDC are both bit 3
       * RDR and DREN are both bit 0
       */
-    mask |= s->ucr4 & (UCR4_TCEN | UCR4_DREN);
+    mask |= s->ucr4 & (UCR4_WKEN | UCR4_TCEN | UCR4_DREN);

      usr2 = s->usr2 & mask;
---

