Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF8B75FBC5
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 18:20:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNyHq-0001EG-KH; Mon, 24 Jul 2023 12:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNyHW-0001Dv-HT
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:19:34 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNyHU-0007Os-V0
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:19:34 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51bece5d935so6927137a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 09:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690215571; x=1690820371;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vYE00vaBdpPYzW+lVPoa6hwTVALv4IpX9tYKH91AyxA=;
 b=bWuWazROaHpa/oSz73vbEvQlRm/UrdydSOY/BpzJc4JvzXzPJuYPTFdqR1UElhHC0f
 A3233P07oFFL2dhCM+v2DMKkJRM1CxawA7xR38jaL0CpKsF0GBFI+urspgMTF6xyZW+A
 tHhWeOVwRKtwoBAUYdH5nKATF5qraMJK6GUdOUFnSVBtJl7gzrQ+o3oYBlKQdon5xyCs
 ejPmx5YO1zAr9QC9PtOuic3H/1vOs0pnwY7EBUUaseGBT0l+uVIKWby0OIUDZBFawrhA
 TUctCJk+NFzFDCcxEwzlfl9ml8gkX92dHJgY0PA5XDSQZ59k7e5G8GzlExi1Wjy4RKsv
 lG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690215571; x=1690820371;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vYE00vaBdpPYzW+lVPoa6hwTVALv4IpX9tYKH91AyxA=;
 b=O27kjIkGKBlWKdPAtTLY2DJjH2Hy3iYIKnVPbt6urpdDMiEByCuhKmKNrQvAN7EHe6
 IS3kplzQY+sPVNgt8UErijZ9a+GoKR3ujthyBda/mxCSc6G8d/8HmNjYf0Cxd0rNssZu
 sYKuC3RePZq+4I3tBm+9YJ3kDUDDRO/fSemxAz+XXAbYM1JW5ARvsyuFmnTevO8Fmjif
 QWGDkoWf5ir53TK2rzcldZf0o1xKFOeBGMHjT4kzty50kzomygyYFKkw1wxSF2iDckha
 9lpUtes1Gu375CXPnh6ETQ9LGMMs7ds6QU85XYaKwXmxIgu45lBfiMRSc9EZYQUn6NkK
 gYLQ==
X-Gm-Message-State: ABy/qLYZBPdD9eXoKGUP48mDfXg1TID4MN0uW73fPxS2k52LeZdFdAAh
 ReNTEL8SCf+EWrCKJA1OW0NANqcsarXS/Un7AA7Q4w==
X-Google-Smtp-Source: APBJJlFf02BVonG2HUdIXhbL25S/G2dZBoKbu+ZJOVT3ohG4Ev3pZASdP2iqoLM7x5EZqPhiipIEUbpKH5QrtPg8oso=
X-Received: by 2002:aa7:da03:0:b0:51e:166a:ac7f with SMTP id
 r3-20020aa7da03000000b0051e166aac7fmr8592631eds.28.1690215571382; Mon, 24 Jul
 2023 09:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230714232659.76434-1-chris@laplante.io>
 <20230714232659.76434-6-chris@laplante.io>
In-Reply-To: <20230714232659.76434-6-chris@laplante.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2023 17:19:20 +0100
Message-ID: <CAFEAcA_kfDP_RpQB=_u46tH6C0pSeB=crv2cBgfrCjLCbWmGBA@mail.gmail.com>
Subject: Re: [PATCH 5/6] qtest: irq_intercept_[out/in]: return FAIL if no
 intercepts are installed
To: Chris Laplante <chris@laplante.io>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Sat, 15 Jul 2023 at 00:27, Chris Laplante <chris@laplante.io> wrote:
>
> This is much better than just silently failing with OK.
>
> Signed-off-by: Chris Laplante <chris@laplante.io>

Makes sense. Did you do a 'make check' on an
all-targets-enabled build just to confirm we haven't
accidentally let any bogus uses of the command in while
it was returning OK for these cases?

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

