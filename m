Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D08ED7E3435
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:30:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Cm4-0002tE-KX; Mon, 06 Nov 2023 22:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0Cly-0002t3-PO
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:29:02 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0Clx-0005Rt-90
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:29:02 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-280351c32afso4825392a91.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699327739; x=1699932539; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4poDYHs52w2J1TIzkjHGMV4WHsV8keNHGlQTxGz9coU=;
 b=DgheRYIVLWhcwOySf6Pj4vFzfAkP4dYAQokb6uhfLsrTXpHoZ2MGbdVt7s0fkEK7yZ
 Px+9bd51G6vvCd6hcfhxd5IfysGRoULpnNkzsdsKfZIacWsW6UxAWw1yJS/rr6D56EuW
 pjsW58OyTCeYUcPang3UFMlM3Wp0e6VePTLZcI4wPL/moq/p20PBnPApeDOBATpP6fLn
 or1yesz1i866ljdHQG+4ZmYyG9TunPxLIp988rdNVVV4y61+TRK3mcksxpljnLaeuYxA
 RpcH6l6Og2daRUyA98QNKaPlQFbIsfyIhZrBtOn69OKfuW9pzr3CVw3Cd9O8tU1xxnCy
 IBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699327739; x=1699932539;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4poDYHs52w2J1TIzkjHGMV4WHsV8keNHGlQTxGz9coU=;
 b=A+jff4Of6ck4urWAk9T+O3tQm1khRdM/k69x4HPzuDdxE25ofJISIoILnanv53ugoy
 ZOdwz1gYrVLRA7c47jxhofOng9KkmtGgIBniHZE5qI7HWx2mcY1o/u8omhN/+VEpTIkK
 ZxKQa1yyoq3RuQHAkYg5HCekuy4opmJc5pyoz+gI2H1GSuL7b3xQEhfGv/Rr9ypcGvF+
 rQS+8IUg+NqvVG+U6isj6RDOfBPWu8rK/ovJJFjeqGAmumqIzdA9YYDBSMmThlE0P8sI
 ZKZWGxE4Jck1WhxiVfWPVb+WiH7i4KWtV5UZhxcFdF0E8ZYXOOX/gRPRe9WZ52BqjnaV
 m7Yg==
X-Gm-Message-State: AOJu0YzEapmQQuKr5/q9/vyJ6knxlMMz0n5PBM+1jh9EjAiUfrQh3Bcb
 KBr16H2pVMyYclVWIWGqUe4x7Q==
X-Google-Smtp-Source: AGHT+IHx5Oc9hX8wImJdOCFwcDT4+Wx9KGr5MTJiUzMW/RXLriTLvkw25aJymqR/qlCSZMmWfp3ppA==
X-Received: by 2002:a17:90b:3d1:b0:27f:df1e:199e with SMTP id
 go17-20020a17090b03d100b0027fdf1e199emr32070285pjb.28.1699327739417; 
 Mon, 06 Nov 2023 19:28:59 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a17090ace9200b0027df62a9e68sm6091378pju.13.2023.11.06.19.28.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 19:28:59 -0800 (PST)
Message-ID: <e8bac7bd-b264-4405-aba9-e3531c5e8522@linaro.org>
Date: Mon, 6 Nov 2023 19:28:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/22] default-configs: Add TARGET_XML_FILES definition
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
 <20231106185112.2755262-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231106185112.2755262-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 11/6/23 10:50, Alex Bennée wrote:
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> loongarch64-linux-user has references to XML files so include them.
> 
> Fixes: d32688ecdb ("default-configs: Add loongarch linux-user support")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Message-Id: <20231030054834.39145-6-akihiko.odaki@daynix.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-Id: <20231103195956.1998255-2-alex.bennee@linaro.org>
> [AJB: remove base32 from list]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   configs/targets/loongarch64-linux-user.mak | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/configs/targets/loongarch64-linux-user.mak b/configs/targets/loongarch64-linux-user.mak
> index 7d1b964020..d878e5a113 100644
> --- a/configs/targets/loongarch64-linux-user.mak
> +++ b/configs/targets/loongarch64-linux-user.mak
> @@ -1,3 +1,4 @@
>   # Default configuration for loongarch64-linux-user
>   TARGET_ARCH=loongarch64
>   TARGET_BASE_ARCH=loongarch
> +TARGET_XML_FILES=gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml


