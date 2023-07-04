Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A37E7472A9
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:23:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGfzZ-0004Wa-JB; Tue, 04 Jul 2023 09:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGfzP-0004SC-Nq
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:22:43 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGfzN-0007zl-Cw
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:22:42 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fafe87c6fbso8700251e87.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 06:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688476958; x=1691068958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vAMnyiMorzcHURg4qxEa6kQulnu9dC4YyPQVn8sMTLw=;
 b=PdpNgnN121Ac/KxhnfFQPJ2XHtKIHd7D2Li8MBLD1leu6G51X7CGnv8dE7HgyaE431
 b+uiXjmd55ZC6PYTZ32X4BwBO/ajM3PKOiwF0skLZwD56yZBB8/2o9z9YKAENz2+OLrX
 zftjE+9Oc9BvJo+ENJboELvoqGdDJQkwJodCR3PPxcYNNE331lznjM1axy7vK4VqpdZu
 1T7Ve1ipR4OaS56zy8hvF+lFoseUa0IHejMe1Y5eSS1FYH11WSo2sgSial1MWPnzoePI
 J1YIp7oF142LfJ1E6Gf6Dy06iN5sbszG2aqxX+FErjcfiVHr2bI4hSpGKGkhPjcyP3Sk
 jU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688476958; x=1691068958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vAMnyiMorzcHURg4qxEa6kQulnu9dC4YyPQVn8sMTLw=;
 b=ZJFePVg0yUWb4MOVkj/9UzVb9hfKXxsaUR6XD6AkyT/tx907zCEERdrWc/EhtP/7Pm
 j+XRou9OP+z2DUTBOFz3IAqBKExa+ePh6z9mx8g1GSUSI+EbbcCDxox+J2UjwZ7z8WOz
 ZRZvmXJYfYEmG46XKv0ftbgYFtMiMSETFqdzQihC1zHJhytL7bm6mI+h3G1oOukvwB6e
 sGL45NTPaCs+27lUWcFhubQc7LM2D27FByoZqujRlsrU7n0FrjEYIUzZj0eQbb5iVD9u
 gOPQWRkJhOtBbEFHXH1yZ8apDAYK4wu97NdyGiubGAqRMiQhrmoMWTYvjFbx9atHOLT8
 r54Q==
X-Gm-Message-State: ABy/qLYe1nmgYfYAHYPY/1EdBo3pZSjluT+1qcRfhdFE7VnXjiaipP/d
 YeLWJ2YSErX2yjyfy8reUbfl5uNUfRA7vwLAMYw2uw==
X-Google-Smtp-Source: APBJJlFpdTqq3omr+uGPUdx0oymTASdQ7oY+Sbu3+NI0IqMjRiEw+3vzvAaD80sfOcGkqKgJsD0wdhwHmhq9q7Vszqg=
X-Received: by 2002:a05:6512:2815:b0:4fb:893e:8ffc with SMTP id
 cf21-20020a056512281500b004fb893e8ffcmr11000733lfb.17.1688476958394; Tue, 04
 Jul 2023 06:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230628110905.38125-1-akihiko.odaki@daynix.com>
In-Reply-To: <20230628110905.38125-1-akihiko.odaki@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jul 2023 14:22:27 +0100
Message-ID: <CAFEAcA81c0tnHfsMfafO0+hTViYJO3XuLryJKzPco7k_7M2ENQ@mail.gmail.com>
Subject: Re: [PATCH] hw: arm: allwinner-sramc: Set class_size
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
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

On Wed, 28 Jun 2023 at 12:09, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> AwSRAMCClass is larger than SysBusDeviceClass so the class size must be
> advertised accordingly.
>
> Fixes: 05def917e1 ("hw: arm: allwinner-sramc: Add SRAM Controller support for R40")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> --



Applied to target-arm.next, thanks.

-- PMM

