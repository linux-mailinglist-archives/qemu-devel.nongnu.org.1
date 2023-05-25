Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0787108CE
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 11:26:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q27Da-0001xt-B5; Thu, 25 May 2023 05:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q27DY-0001xk-Kb
 for qemu-devel@nongnu.org; Thu, 25 May 2023 05:25:08 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q27DV-0002wp-QC
 for qemu-devel@nongnu.org; Thu, 25 May 2023 05:25:08 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51408729f43so1614504a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 02:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685006704; x=1687598704;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RDfsHZitQ7OP4kbbEpEhoTb/n1FiyPiJ808O9a7a8cQ=;
 b=QdrWsUsqjgYxMVbbyR+s0ENmWu33GAk9tQyFLmgzyVw1R2h3KCyPBGhBaispUaz6WJ
 En/mA7Hs5//oRnCbyuMYgoZg1xVNA3UcF0+BBs6FwVyYtAypjkuDaWUVqsKbXIa89Yf1
 c6laV4Ljav6tvmY8xLfX+MXZPl3cluBPhbugecYwzYKDdSJtlvr9H+UmcVSUqOF/V7O6
 WZj7iSBrpVyw3izY6EurVAJuAJ6Np7CByb8c5OLUnvGXhrRf+C2DJC3wN4PEnnxjME7Z
 n//bt0cw2xSzmGBRmMYXMUJWTQfhXgLdTRyntBR1GJrxGZw4lR9awUTjEv+ppFvUgqE0
 GEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685006704; x=1687598704;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RDfsHZitQ7OP4kbbEpEhoTb/n1FiyPiJ808O9a7a8cQ=;
 b=cBKK+GNfJT6CrqbqeIHUKdJmYfXz6N6ZiNd3G2WWNEwwCy1qiliM8b2sIAiku2ChXg
 AlxJjaevIac22RYPracgknyctM9MltTRzDHveV1SsTZ6nwCCgmwvgvI1QJNztvP5wp0y
 rgJGFWt9Jo/lh+zfSKF/fT3r7ogG+k33PiXbIi35qfwT+QIcznimjwouTh+ooOfaVLx3
 c070dfRwmjqmOvznn5jKnYhfA4ZGJguARvG3Zhp73j/V9pPgNekZ6vH7xBO9HJY5TwRa
 M6ktI24COSn95t/q9pMYYetRa8m75t6jdeDyxZqTAVvtCnLoSlE/MCiM9QmsEYJLWvKk
 XVAQ==
X-Gm-Message-State: AC+VfDzZgv/wn3krN4FAsEPJm5qcszLTF52Xz31KuzNH+CXgmziYAG/d
 jtY17T4thG6/Wr6EmH9wufdG+zCI5uGUWi1nhMXopBB26m+dHrkk
X-Google-Smtp-Source: ACHHUZ6/txISf4m9JjNpZN5OSPwqVud8QBzdMWk9HHfaqy0x6qrbolmkznTqLUa3tfIcffdsrMV5NHSqGVdTo5L1uaI=
X-Received: by 2002:a05:6402:50d1:b0:4fc:97d9:18ec with SMTP id
 h17-20020a05640250d100b004fc97d918ecmr1770246edb.21.1685006703943; Thu, 25
 May 2023 02:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230525064345.1152801-1-lienze@kylinos.cn>
In-Reply-To: <20230525064345.1152801-1-lienze@kylinos.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 May 2023 10:24:53 +0100
Message-ID: <CAFEAcA_oP+cJL-HdzrS+R83=z8pYcrK-A3Aecm7NChdR4O3X1A@mail.gmail.com>
Subject: Re: [PATCH] Update copyright dates to 2023
To: Enze Li <lienze@kylinos.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Thu, 25 May 2023 at 07:45, Enze Li <lienze@kylinos.cn> wrote:
>
> I noticed that in the latest version, the copyright string is still
> 2022, even though 2023 is halfway through.  This patch fixes that and
> fixes the documentation along with it.
>
> Signed-off-by: Enze Li <lienze@kylinos.cn>

Whoops, thanks for catching this. These are indeed the
only two places that need to be updated (compare commit
fd50a00a57509 which was 2022's update).

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(One day I might try to get the copyright date to be
defined in one place rather than two...)

-- PMM

