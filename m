Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1FC7166F9
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 17:28:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q41Fq-0003DH-Pt; Tue, 30 May 2023 11:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q41FY-0003Bl-9o
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:27:04 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q41FQ-0001H0-Rm
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:26:58 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5147e441c33so8405465a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 08:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685460415; x=1688052415;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/gxDi1RsgSuoNmvm9nfhOkd5m/ryRRdkW+qkoPWFDO0=;
 b=ZwIBOLwZ4+rAU2GGWzNaS0IjZ+X0Jepyovpwh/yCtLJmEbbSHp4f1lwfhkQLmkfy+O
 wqM+XDYTYEgBqfgm5rj/SPmOerk3A3sU98KmSnefX0MVS5xQTfQnblgUvIahI+mT5Tv7
 x4vRXvmwt/puPp2PezioUrqrNSRctGAJJTlEA2yePBZCtcBWtMEQF1ZQendq3Jv9M1kc
 mhBjhskUwP0OJI4iyaE7EOlTOJvCjkdbygTqAV+VS5mJ8/kPH+jbt+BSTTiEVoWNiYbW
 t0OF8GKQptBrfEnOwL9VPcpX5LP8hKnH0y6EjckzqNyUpFxgTQne0GvN68/nOVxLWMJC
 gAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685460415; x=1688052415;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/gxDi1RsgSuoNmvm9nfhOkd5m/ryRRdkW+qkoPWFDO0=;
 b=cXAphDHQCrKdHfVRnQjd0DgRDbpEmQCoQ38lhlC2ytwKCqmI2pKaoIZ8tyFC2O0WLh
 E/rQb13VZNDjEur8zXwQOlhmE0nLQfkRiKNlyiYjaIWZr6OTsMdOtKDRFlEOR7APJW77
 IOF1nK+DYZnVMOUmD9n+RXNm4+/AVwmlKlGrFRAF3wSIt/+1FnjubMOEXtpGs0q1AEKY
 naWcyBfqUACJ0g2WX8v2C30UbilZpaaBLByR2ugNSCb7E7A180dkCbo09wRC4Qv8/IyZ
 zQfQIS21OUPp8stnRz6OGs6epG4KRjRzHtf5LntB9Ty3lXVqlSoeh/CkpriWYp03mP/Y
 9ROQ==
X-Gm-Message-State: AC+VfDxyRiZ7F04JZPhMRKC/SoJ6RoQbKLUkG4aMw90hLQJwfAqpOGXd
 d4qXTTYwkYW8VYZ2mp1VaQGlOsppjcj1L4BUiA5btQ==
X-Google-Smtp-Source: ACHHUZ63eJUaM3H/W59bsewzKdyIr6xpT/IEdcr659tkbCZV2c+UISO4ENxVWAYydHsZ2779Bbylu73Jaf6apH4Ifjg=
X-Received: by 2002:a05:6402:26c3:b0:4ea:a9b0:a518 with SMTP id
 x3-20020a05640226c300b004eaa9b0a518mr3187511edd.17.1685460414788; Tue, 30 May
 2023 08:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
 <20230525232558.1758967-5-richard.henderson@linaro.org>
In-Reply-To: <20230525232558.1758967-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 16:26:43 +0100
Message-ID: <CAFEAcA8tMZ6cYP7uzVwX2u8pThgT6TkgjcG-DfG1BFE_1RN3_g@mail.gmail.com>
Subject: Re: [PATCH v2 04/20] target/arm: Use tcg_gen_qemu_ld_i128 for LDXP
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Fri, 26 May 2023 at 00:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> While we don't require 16-byte atomicity here, using a single larger
> load simplifies the code, and makes it a closer match to STXP.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

