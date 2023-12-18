Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCA78173F4
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 15:43:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFEpx-0001Xj-Ez; Mon, 18 Dec 2023 09:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFEpv-0001XN-Gz
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:43:15 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFEpt-0003WO-D8
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:43:14 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5537ee0c4aaso271935a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 06:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702910592; x=1703515392; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jT2wYtXckYct+df02E8MEFhxGAHUHfRpaAaDIterAJs=;
 b=Td6DqklxenO2qu1uCTT4TO53idjhoQ2bucZJsn74TipJ7ZWjgwpZ35mWKhcyiaG8Cu
 KsHJYQ2EWNbqiosXWz2/mH0HXse0fJlPUhGzDysTp2aDy5SdmlsX8o2qGUlLbeMd3mCa
 hqnir2eAMRdL4eVtO7zvugjtWY6ibwSJBSAWsN/uOjFOh2peQFWZiDet1GpNaD+gh52U
 6nwumnMqy8sFpsqnZ3rdVXoAuWfEqI+8zR6Ji4f/63p3Di+pBgjxgfKj8ya8ijIPo8mb
 L+4Smtlqu+sXIMwSBMfXhgQ9At8PTKXH68MEanm12P6KhxiaVmFzwq0yxmdQa8zbrJp1
 7xZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702910592; x=1703515392;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jT2wYtXckYct+df02E8MEFhxGAHUHfRpaAaDIterAJs=;
 b=t17rAkXV2BGaQCsJDkXQ5jJ51S4K0RFDckYfOVZsa4tnjmSc1OQl4fL1l8OCxERZaY
 3bOhyisjuVTSyTGoWroYwAMLl8qW1LwXnfRyx6yJMqepRoAoGU7QmJceaYt9Mhflrwjq
 6AMuN+x5EuPeNDK2F1akws2sWbLeY7TmYEK3KjkYO6B0CDYMz/7bSxwjm9tS1+erEzVX
 3fzMg7wW52yyN4tQJGBfuocZ42nH9zux1QzazTVU6Jv+e/GJcjmtT0YcdGgkrpr2BjK5
 GCqbjfRACmzg9IlGtIfcYATt5EkEVY/zM4EOjFvbQIZql1aKXrwAQTbMDK3xgO0XWFSJ
 UG7g==
X-Gm-Message-State: AOJu0YykXg1nLONmD3DSXeAl9619Eq2IgugnVvVhm2J3znmw2ndGjAyF
 F5i1OnvgbPSXL/P37Tmkpvoulq46NF+JJCKASBCUbw==
X-Google-Smtp-Source: AGHT+IGqAdSxcv0COeJnc8G4wUL160MC4N3yXDh4lMCZUfy3cOOjfhbIsAXpSOZiVPVA5Oz7qPrKAiqqmJfacRsuQis=
X-Received: by 2002:aa7:df84:0:b0:553:61c8:5e33 with SMTP id
 b4-20020aa7df84000000b0055361c85e33mr745559edy.52.1702910591776; Mon, 18 Dec
 2023 06:43:11 -0800 (PST)
MIME-Version: 1.0
References: <20231214211527.1946302-1-nabihestefan@google.com>
 <20231214211527.1946302-12-nabihestefan@google.com>
In-Reply-To: <20231214211527.1946302-12-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2023 14:43:01 +0000
Message-ID: <CAFEAcA8H1-Sj34mdOQyoc_7Ut-e5DEKbX8MN4DSxZkxABDGDCQ@mail.gmail.com>
Subject: Re: [PATCH v8 11/11] tests/qtest: Adding PCS Module test to GMAC Qtest
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Thu, 14 Dec 2023 at 21:15, Nabih Estefan <nabihestefan@google.com> wrote:
>
> From: Nabih Estefan Diaz <nabihestefan@google.com>
>
>  - Add PCS Register check to npcm_gmac-test
>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> ---



> @@ -129,7 +198,12 @@ static void test_init(gconstpointer test_data)
>  #define CHECK_REG32(regno, value) \
>      do { \
>          g_assert_cmphex(gmac_read(qts, mod, (regno)), ==, (value)); \
> -    } while (0)
> +    } while (0) ;
> +
> +#define CHECK_REG_PCS(regno, value) \
> +    do { \
> +        g_assert_cmphex(pcs_read(qts, mod, (regno)), ==, (value)); \
> +    } while (0) ;

The standard way to write this kind of do {...} while (0)
macro does not have a ';' at the end of the definition.
That's the whole point of the idiom -- it means the macro
expands to a single C statement, so it does the right thing
if you write
  if CHECK_REG_PCS(x,y)
      goto foo;
without braces. You got this right with CHECK_REG32(), but
then this patch (a) incorrectly adds the extra ';' to it
and (b) has a ';' after the new macro.


>      CHECK_REG32(NPCM_DMA_BUS_MODE, 0x00020100);
>      CHECK_REG32(NPCM_DMA_XMT_POLL_DEMAND, 0);
> @@ -180,6 +254,64 @@ static void test_init(gconstpointer test_data)
>      CHECK_REG32(NPCM_GMAC_PTP_TAR, 0);
>      CHECK_REG32(NPCM_GMAC_PTP_TTSR, 0);
>
> +    /* TODO Add registers PCS */
> +    if (mod->base_addr == 0xf0802000) {
> +        CHECK_REG_PCS(NPCM_PCS_SR_CTL_ID1, 0x699e)
> +        CHECK_REG_PCS(NPCM_PCS_SR_CTL_ID2, 0)

These should all have a trailing ';' like the CHECK_REG32()
invocations. This makes them look like function calls
syntax-wise, which is nice for things like editor code
indentation.

thanks
-- PMM

