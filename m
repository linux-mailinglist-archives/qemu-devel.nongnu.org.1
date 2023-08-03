Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C421776EA02
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 15:23:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRYHL-00053m-Dm; Thu, 03 Aug 2023 09:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRYHK-00053e-1j
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 09:22:10 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRYHI-0002eG-5o
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 09:22:09 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4fe11652b64so1662862e87.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 06:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691068926; x=1691673726;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XkEoNrGj4MxU4lbhNxctuYoVXCP6gtmRLrqZfPBUW+g=;
 b=UTODm5blmU5pEVxhlXArvq++7f43fqaMdgk8Hsm+cAdoI0aB7m7MsfdGEYsHD5EPaE
 UwVqNBumZmPhW+Z6uOzOXHd06tB6RYX9pXsZ3zF3FYuJQpsj87X9rpdqt45fSmCOp6BS
 O5SF0dCAXswMnHAQiNUBjxRAhKGGgk4k8vPpxUpf5DzjEtBGF/b0lHbV5zNwjsMYaJHV
 oL8+5jB9hF8Wk0CfMay/C3qJMgv6sx6SA/8FS6etLRqwjxQgiPXIaek1rVVgwNcm0Uv0
 PTdpmI8KR2Bi+Ui2ycJlVJSxxgomlNOEnlEDWqNTjJbkG7zjdJRiUnwZQkLnXf3SOU3q
 GdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691068926; x=1691673726;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XkEoNrGj4MxU4lbhNxctuYoVXCP6gtmRLrqZfPBUW+g=;
 b=HF0aObFf8hRyzMMw5s8XsnZpN5ODfDMAbJIMcghtwEX4XDekEmJFLO8lIK+oX6RqQ9
 in6FzoLOM5KC+avOBD3Ego+hZ7nBzRhK8xXV8WyswxR7CDZ5mI2GE0RsObrvQXafXlmV
 fH2zgTUdLPf0E/tVpXkL0wsZRJ++hU4ZCf8Nv0C6xriVjMpjirj8e4YJNpGRLX8EO8UL
 zgFPvvgV813OZtCydPp88ajba+vNsJ+zVatw275xlyShGx58x7YNHnRRT2CWU8+jX/S+
 O0angxP2UK9ti2SP8n6Hs7GzGbBtmHOyh7p28+L78krafn7/JggADPqWkxKyMZTLJ1TS
 wT2A==
X-Gm-Message-State: ABy/qLZTphfikwcOGp5S/8xcsnvV5MGKQ5kxUaBUMyFLveq4XSbrW7zH
 aZMIGydypn4zY2QUgL/y7ljzXx33xtZ165YFevVZew==
X-Google-Smtp-Source: APBJJlH5pyv3Gj+qRT0ByIRpegP21rzsYyEmLPCItsMIaW7YSQmCRAWP3itPe1nuDNVM1LU/aNJEqCnsCOq3GuYYihI=
X-Received: by 2002:a19:6418:0:b0:4f8:6e6e:4100 with SMTP id
 y24-20020a196418000000b004f86e6e4100mr6831548lfb.52.1691068925563; Thu, 03
 Aug 2023 06:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230728160324.1159090-1-chris@laplante.io>
In-Reply-To: <20230728160324.1159090-1-chris@laplante.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Aug 2023 14:21:54 +0100
Message-ID: <CAFEAcA8GsmK5iOm7L1UNgSZL7jY=+-nk+atQqaMLyn6j7+ippA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Add nRF51 DETECT signal with test
To: Chris Laplante <chris@laplante.io>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

On Fri, 28 Jul 2023 at 17:04, Chris Laplante <chris@laplante.io> wrote:
>
> This patch series implements the nRF51 DETECT signal
> in the GPIO peripheral. A qtest is added exercising the signal.
>
> To implement the test, named out-GPIO IRQ interception had to be added
> to the qtest framework. I also took the opportunity to improve IRQ
> interception a bit by adding 'FAIL' responses when interception fails.
> Otherwise, it is frustrating to troubleshoot why calls to
> qtest_irq_intercept_out and friends appears to do nothing.
>
> v2: https://patchwork.kernel.org/project/qemu-devel/list/?series=769532

I've applied this to my target-arm-for-8.2 branch; as
the name suggests this will be to go in after we release
8.1 and development reopens for 8.2.

Thanks for the patches!

-- PMM

