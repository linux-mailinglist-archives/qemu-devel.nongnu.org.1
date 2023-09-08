Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF7E7984FA
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 11:45:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeY2x-0001Os-Bt; Fri, 08 Sep 2023 05:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeY2s-0001ND-7C
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 05:44:58 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeY2p-0002gR-9J
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 05:44:57 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so2451482a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 02:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694166292; x=1694771092; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vg9BMQjcSBA9mBWGBwAx75WW9ZFpExtipUaKCo82LAs=;
 b=ZpBTywv+d2u2xABIdH8bew4Dad12tEViNuYwZlqb9oR05lfy6eEinYvFqhQjE3fLVK
 cCYoINqSwT1fWfZE34p3/NBD6kQ+pwY/pM/1ssrB3dWV7rj+UAAY3eAaqxXi0H84YT3W
 q4u3ssgJVVffSPcK9w7eNa/ICmLi9i4bJV1jI9weJGIKaN2bEkJeuvFnp9WNZBIvesP6
 y720sU7P+k/wBcgcp+K4dM9oyq31zYb4JK3XUWPN6v/9/T4VS52nIGbyFtn1Cu1HYOvP
 PexkFMoWjHeyxZurix/sT/BqtEwlPVqxx/kKSvGKOcPNogXiTs1ZFoMhmpWlx4v2Mar7
 o9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694166292; x=1694771092;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vg9BMQjcSBA9mBWGBwAx75WW9ZFpExtipUaKCo82LAs=;
 b=IS8A2JLbCwKO5+iZrmuRr4E3/4AZB4AEaKtHqztwlpn+UoMYVcdw5uOxKSK1RZGrPR
 DbiX9YeAvLoUj55BqRFHejxawV4QCwgYwhAUTiWyQC5Eu/fAaj6hklsThM177s/wBh7d
 V4SiwX1WV9oKmRR3H0O/cO2K6+y2i/Hh/r8nmbn0f/t5zqYriyybynLH7I1rvqyMMMfI
 za8et4DiuxecIkXEAm8DioQzxXbaKsldH34/hz0SuYrjSYpJv9YJOKeDhlKqwi/MnTpk
 4OqIR6NxCZlcNJ8elpY9Zy8FZkkk1Nvsl+2JrXzLoVeAG/rzL8ml344jUhfcJsaTOG+v
 H1cA==
X-Gm-Message-State: AOJu0YxkC7wij+vxIGqhvI8+GPpNmaA3KqkbDknvpviX+UsLdJ/b4zjd
 Yv50gwzst8C5GJuRs2uGAYoN5heRkVkWTr+GV3xinhNWPXOg1pd7
X-Google-Smtp-Source: AGHT+IFVHnD53Y8WZ53atFSyEIwP2RRQRjnnzrOZNgz1enejG3U9ylUcEwf8AVdVOzN5nFZ0DDPaK7K4m+1V126HpHA=
X-Received: by 2002:aa7:c6da:0:b0:51d:d390:143f with SMTP id
 b26-20020aa7c6da000000b0051dd390143fmr1476472eds.5.1694166292712; Fri, 08 Sep
 2023 02:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230907203440.257845-1-mjt@tls.msk.ru>
In-Reply-To: <20230907203440.257845-1-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 10:44:41 +0100
Message-ID: <CAFEAcA8kioEXGor4tMzFPQwX8nPVHso9pQHsZ=ffRapjqsOd_Q@mail.gmail.com>
Subject: Re: [PATCH] hw/display/xlnx_dp: update comments
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 7 Sept 2023 at 21:35, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> From: Peter Maydell <peter.maydell@linaro.org>
>
> Clarify somewhat misleading code comments.
>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  hw/display/xlnx_dp.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> Peter, this is the result of your suggestions in this area.
> Since it's entirely your wording, can I specify your
> authorship too?

Sure.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

