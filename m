Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A669075FC11
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 18:29:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNyPu-0000Sk-BN; Mon, 24 Jul 2023 12:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNyPs-0000SP-Gc
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:28:12 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNyPq-0001AS-Qp
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:28:11 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5221cf2bb8cso3482615a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690216089; x=1690820889;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vo/wILO7UfRlNhwEo6vuFx8mjtaTXH4Q0zLfmJL48W8=;
 b=cuPFntYlYIYx5HQlLrKakkk6sgatjeDfSNhxXDXYC83JBKGW6lLi9dIPCr0pdsLeIi
 Rrdu08wcRquM+7DA9Y/0516Pq6VHLtbrguLvHW0rXuw7LERrT0irOipfh0xIKxNwFcqb
 PnDSDaaJmNGo8y2qtdZJ9FeZKNn/1keFybfaBPOxihAmrQe1TtsBrQobogkI4ZiZ2wAW
 Xdkc3Xo/QmA6tYcCch97Gr0gBM/eusqbBfYBPpN5Rh8Doo1ahdQ8YstwgIHEBEVcpeo5
 Sb56OQ8PGkWwaBatRzUYRkWMD0ngLiNf1fi0/hARy7gKBSODkIBDcZIsy6ip4aRlaUK0
 x2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690216089; x=1690820889;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vo/wILO7UfRlNhwEo6vuFx8mjtaTXH4Q0zLfmJL48W8=;
 b=QOz9dBS14CyrxiqxVwoYupWKJZktsuM8zwzZdPvxcgl5WVX07QVtoNEi7kg8Kn4kxq
 Vris7CKwXaaZr8QygD+8Z+uzT2KHywCJTUldOv8AILYhuhAodzXWRp/WpVPJ+sI/AFTF
 5UNng4gTuhJ7KIHsAbhG/QOctZxrwPx8Wh32lFlS5+Ojf/beD07kXfuar/+CbsYXFgrT
 NVu0yRiH1+f4si1+fGTx/eDL5Rg5RX/bqO/ixUycJwfVCKXPRNvG1dExzeNBDY+MfHi2
 FbjG0apr/vcRhHd4to5rLzf8YP5APosSS6tKfosPibrXo0TdYK5t0EPHNR5ypbSLIhIZ
 fH6Q==
X-Gm-Message-State: ABy/qLZDTZtChAKRWsPBHOJvTfkB352PonSi134OcCKcI4O/sStfUd8R
 0bauQku7Zs63oPCZdRFTR42YH71EDw8NwQICyzQ8Yg==
X-Google-Smtp-Source: APBJJlGtg03GmVpRAC5lWD+3jXyTV5HDmZlXpbn73fiFQ/IRxsWad23+LKMTH4jZ9Q7NYKaJCxhXutXRch/CZx7CobU=
X-Received: by 2002:aa7:c1cf:0:b0:522:28b4:11f2 with SMTP id
 d15-20020aa7c1cf000000b0052228b411f2mr4226830edp.3.1690216089286; Mon, 24 Jul
 2023 09:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230714232659.76434-1-chris@laplante.io>
In-Reply-To: <20230714232659.76434-1-chris@laplante.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2023 17:27:58 +0100
Message-ID: <CAFEAcA_gGia=ckyv4=XHNX4=VHJJ=rmVGXQbdnOAGv5h1rzLzw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add nRF51 DETECT signal with test
To: Chris Laplante <chris@laplante.io>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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
> This patch series implements the nRF51 DETECT signal
> in the GPIO peripheral. A qtest is added exercising the signal.
>
> To implement the test, named out-GPIO IRQ interception had to be added
> to the qtest framework. I also took the opportunity to improve IRQ
> interception a bit by adding 'FAIL' responses when interception fails.
> Otherwise, it is frustrating to troubleshoot why calls to
> qtest_irq_intercept_out and friends appears to do nothing.

Thanks for this patchset and especially for the work
improving the qtest infrastructure. I've given my
comments on the different patches, and in some cases
reviewed-by tags. (Where I've given one of those, you should
add it to your commit message for the relevant patch under
your Signed-off-by: line, so that when you send the version
2 of the patchset we know that those parts are already
reviewed and don't need re-examining. If I said "make
some change; otherwise Reviewed-by" that means "make
that minor change, and then you can add the tag, etc".)

Do you have the parts of this feature that use the DETECT
signal in the POWER device, or have you not written those
yet ? If you have them, you could send those too in v2.

-- PMM

