Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B457E03E5
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 14:45:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyuSK-0000ZE-5H; Fri, 03 Nov 2023 09:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyuSI-0000XA-6E
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 09:43:22 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyuSG-00089Y-9m
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 09:43:21 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50939d39d0fso2697126e87.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 06:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699018997; x=1699623797; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IYnlTVJGZbW/5iq63BGoN+7roxf+37ZtkPDAGvl8K1w=;
 b=LgumCssSu6fYlABw4nBfWaZWavaaXZgoDtdlpUpnAecgfA5nYPI7DVmN2Gqx6/HPRW
 QZMDtr0kTVbNiSwJrZ4kYhrS67amWnYhpz6R4S+LRFU7upR9Pdzt+0lFnKbGF8tZzZuR
 CjXLNblSOYkx7Z+7YR8c0RyTzAoj6BAAt59TubgjbwF+cxoXuruPuxSkRa2GNOPJgsiD
 q2gJTaemx2B2VajW/t/hK8TC6wmZlJr22qrWoYn6GpmEez0YzYbmp5M8fmPZ5ReLvu03
 QBxP2aW0MLqNxhlpNsOfp/Q4OIn6+V4tsUA76oYcFwvPcGrn5pE+VqaAqIzwir20tfoY
 1XXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699018997; x=1699623797;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IYnlTVJGZbW/5iq63BGoN+7roxf+37ZtkPDAGvl8K1w=;
 b=iTVTYaVd0yJVUXZyBJtVWHlSoHdpJfwH2FZ3pifFyF6IiubwigxRBHkKoK4UkCt0tv
 uQe62ZDUWcUzPTEPPZId022GlzlGUYU1YWrkFfs+G4hc11uAkoIUU93+Y1hbTdrv9h4r
 4eTkjSdKZHVblBrJNQeJv+HkaMwNespyGTskSmGwsb3+I64l5IGRgDcg/mKmgOWdYB7Q
 LW81qY71qpqqP2y2ENZsmQ3dbwVLopVIgF1JfYtxaTxQwzie1GCIq0vQ6A7rmrVTc7E3
 Zgq0ilKzeMsuFVF2IYnvutldMxN9JmchMHnWNl9fdRuHMBjvyytfEFAEtByVYo+hvh3Z
 lRyw==
X-Gm-Message-State: AOJu0YzL496xbOb3Ww3UwvCcyNY9YCgS62GLhk69cuXrU+0c7I0vGuLm
 NmtLYCOwvzcy1R7lnWeefGaN9QvCu8xbcFJc3tK4Yw==
X-Google-Smtp-Source: AGHT+IFO2+pHfHG6Kp4Cs2caNvDyC1QdJsHJqxruGOnxekGq0mZLoiXpCIBY6TRUk7GNugMGZmPHj4Ml4VUcjZuXw+g=
X-Received: by 2002:a19:f51a:0:b0:503:778:9ad2 with SMTP id
 j26-20020a19f51a000000b0050307789ad2mr15426559lfb.19.1699018996939; Fri, 03
 Nov 2023 06:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231020074501.283063-1-dbarboza@ventanamicro.com>
 <CAKmqyKNdRzBg_Y=K1AKyo3JnVhN2n_XEF4hu6GD8pC+9-QeKqw@mail.gmail.com>
In-Reply-To: <CAKmqyKNdRzBg_Y=K1AKyo3JnVhN2n_XEF4hu6GD8pC+9-QeKqw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2023 13:43:05 +0000
Message-ID: <CAFEAcA_oriuA5WNEL_XGVHWA-vwbF7_GVqswt0NiwqE4xb4ycg@mail.gmail.com>
Subject: Re: [PATCH] linux-user/riscv: change default cpu to 'max'
To: Alistair Francis <alistair23@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, bmeng@tinylab.org, liweiwei@iscas.ac.cn, 
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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

On Mon, 23 Oct 2023 at 02:15, Alistair Francis <alistair23@gmail.com> wrote=
:
>
> On Fri, Oct 20, 2023 at 5:46=E2=80=AFPM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
> >
> > Commit f57d5f8004 deprecated the 'any' CPU type but failed to change th=
e
> > default CPU for linux-user. The result is that all linux-users
> > invocations that doesn't specify a different CPU started to show a
> > deprecation warning:
> >
> > $ ./build/qemu-riscv64  ./foo-novect.out
> > qemu-riscv64: warning: The 'any' CPU is deprecated and will be removed =
in the future.
> >
> > Change the default CPU for RISC-V linux-user from 'any' to 'max'.
> >
> > Reported-by: Richard Henderson <richard.henderson@linaro.org>
> > Fixes: f57d5f8004 ("target/riscv: deprecate the 'any' CPU type")
> > Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>
> Thanks!
>
> Applied to riscv-to-apply.next

Hi -- did this patch get lost along the way? It doesn't seem to
be upstream yet.

thanks
-- PMM

