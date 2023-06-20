Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C348D737028
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:18:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBd6Y-0003YH-Bs; Tue, 20 Jun 2023 11:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBd6V-0003Xk-W4
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:17:12 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBd6T-0007Sp-If
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:17:11 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f955def3a5so672544e87.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687274223; x=1689866223;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OARQ/7QfiqiX+Bxa6mYaTqotwlXDmJmfcHJYvlZU4Y0=;
 b=JG6Hiv8ez+py1Dsb3r2Vwu6LUC1dd+egFoM7jO6MGOieIOHchJ9bfIHjwJ4De6vZRi
 e3Jrkhht1ug9WiNmpgD3CJrb9zOPHqVAV+6ZPiEIiUL1/I/n2KL692hZUVk1ntTQpOOG
 frGRw1uASjY2eN7wI9rFBBGVElbJtyrbqOiX2ebBbRveGYOXF/Qyw8r3dLBjgyiPINtt
 8ACVth7VpUjuo4NichUmOxNZnqMdZk3s4+PwyVivdPNJAEX9o1qAyzXd7cGsIMd8YRvJ
 FRGz4y8gF1GpKPw3KV/ZTrvAuGrJTGTV77vjgXNVCzvzu25C3lhsB5KIwanO4uExAyXW
 dLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687274223; x=1689866223;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OARQ/7QfiqiX+Bxa6mYaTqotwlXDmJmfcHJYvlZU4Y0=;
 b=evNBvKRBZI+WFcIkDt4Un+/ievX4d4BziSS9yUGrskSZPtqp9QonwM3YB38/dgHW+O
 ZV7Il0KD2LVIisj1PZ8kJzHfvKAw9ZGGKf4CSfbpo3wLzNOCi3Ao1ghVdSgzN/URlY8e
 W67FZeQUHAQArPiBaqpIPqHyLYSuN2tkVuHc7ctP5okqvOjj6mXGnPubvD8/Oso/Y0bq
 Ihq0+eJfbMGSKHlIvairwv3ngj/ZMkvwSTzFgdaBIlL9R1OgP1Mg2HTg5Z8ATxgEB2mT
 wtm+0WipU9qRfQvyrDILpDAjGOkILApkZm98pNFc9EfmTzgkR18jfHJZ+9njpcmoqp5K
 O0ZA==
X-Gm-Message-State: AC+VfDxGAT36WfTtMlW2gPPxV0D+zcx8OC1ni0UUYjeCKtA4cKYa+UPi
 C6IXM1Qfpo1J2uXb+Wy+3eY11iLpwCvx3AXa7b2cGQ==
X-Google-Smtp-Source: ACHHUZ5s9wu5EF8HIP1Rl69u98rS63/P/jiOuybUj9mCjzs2XkcXc5tPMAMkNDcJ8bHnK7LlWhajIpJ5QJOgHVJisgU=
X-Received: by 2002:a05:6512:465:b0:4f4:db9f:6e1f with SMTP id
 x5-20020a056512046500b004f4db9f6e1fmr7025153lfd.12.1687274223559; Tue, 20 Jun
 2023 08:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230620150335.814005-1-alex.bennee@linaro.org>
In-Reply-To: <20230620150335.814005-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2023 16:16:52 +0100
Message-ID: <CAFEAcA9jWuxVVb-+rbv4dEF+0_P1+5z7Z6HQajGv5Jg3yje11g@mail.gmail.com>
Subject: Re: [RFC PATCH] qemu-keymap: properly check return from
 xkb_keymap_mod_get_index
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 20 Jun 2023 at 16:04, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> We can return XKB_MOD_INVALID which rightly gets flagged by sanitisers
> as an overly wide shift attempt.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  qemu-keymap.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)

Looking at the code that works with the mask values
we are getting here, I think this ought to work
(if there's no AltGr modifier then the 0 mask means
the key state will be the same in normal and with the
altgr mask supplied, which we already check for).
Did you eyeball the output, though?

Also, which keymap runs into this? Is it every keymap
for some new version of the xkb data (which would imply
that the problem is that the AltGr modifier has changed
name), or is it only one specific keymap that happens
to have no AltGr key?

thanks
-- PMM

