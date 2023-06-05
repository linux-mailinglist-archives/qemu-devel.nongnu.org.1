Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F05722C1E
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 18:03:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Cfl-0000eI-EA; Mon, 05 Jun 2023 12:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6Cfi-0000Nm-Bk
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 12:03:06 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6Cfg-00056j-K7
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 12:03:06 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4f6195d2b3fso3063869e87.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 09:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685980983; x=1688572983;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XpnGBKz3w05l1nCZrcmPeB/1cPStoAENROljWzGn0p4=;
 b=fz+6qdWCUqFxBy1Jtg+hQ5t3d6Nn9QTOtplGHKooqNpXT7XgrW8U7E2wRJvS1GLcL4
 Oi/6KCyM8yz5HRq51vvsZYtibFzgPoOHmctEO9Y3CF7yzNdndFlWDJfK456FStpFHdSw
 a0BtxruU0SxRtVzNUURSvS75a3O5K+rkmpW/IZP7IACkEDbv0Ej34qOghp19jHJzSNJn
 UQFEPw0vcAz/axgdx6OrWXorEPcBt+IV9R7IXnx3Eubxo9tswO/+3F3wfqBUKQZ8cDTi
 b5Lx0l7NC2mURdzoAAqihNjO2wQHJ/wvtkueMJ2FjeQM9G8mfN01HZH0SGB0t/cidaAr
 /A4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685980983; x=1688572983;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XpnGBKz3w05l1nCZrcmPeB/1cPStoAENROljWzGn0p4=;
 b=jpEq2YR+0OhenCiryMCaJ5etp3dFXsxYq/4RSVrqtDHapQmlI4sVMOQinLY6i2vYRN
 cEORdtXrn/6g4sRTw0rgwsWD3OOW1GyfzPucfy+gZmHrilfflHqoIpgEy90ITiN1GhK9
 IfR3zHE3H8TcHUQxoUjP2IOunzXzHYPwhS2HDljmjAMs0W68/K3c3GWU05gnlG4KyxNk
 L7+ER2wE7BqmCZCS+qOhhhBwV9LTqW/Xb8pUjzZNN/SQzkYstoqOyjS7OsE0EvBxV1l6
 8QH7hJ6s6PeTLUtBAg59nlQ+qzK3zOHTLso3zqIx13y5orVbRs+8KdY+C4DEcX9fSHGo
 bkzg==
X-Gm-Message-State: AC+VfDxKyszk3GtmzCLvNq6CCgNZdfCwuxebqM2zqbWjQxrr0nZdXvFr
 tlG2FUT/ncqzpIhSUrJPKTRMjG3YEPxB5qAEf7E3dQ==
X-Google-Smtp-Source: ACHHUZ5yw/VT3S0PezHZ9lmRCfNanzBmwoXcDmrMZbbRaMWw2RGQv/9+/l8Dh1BGVgGaDtUDAtqLtdKvaQZbkKnqV4Y=
X-Received: by 2002:ac2:4c21:0:b0:4f6:2229:b6d0 with SMTP id
 u1-20020ac24c21000000b004f62229b6d0mr2645575lfq.40.1685980982860; Mon, 05 Jun
 2023 09:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <DS7PR12MB630905198DD8E69F6817544CAC4EA@DS7PR12MB6309.namprd12.prod.outlook.com>
 <87f06ed0-3ad2-6b14-6819-03a35e179682@linaro.org>
In-Reply-To: <87f06ed0-3ad2-6b14-6819-03a35e179682@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Jun 2023 17:02:29 +0100
Message-ID: <CAFEAcA8xVgcUfmphur8OV3U72ErdbPVO5gjRkoD2dnjsZ3umYw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: trap DCC access in user mode emulation
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Zhuojia Shen <chaosdefinition@hotmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
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

On Sat, 3 Jun 2023 at 05:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/2/23 14:43, Zhuojia Shen wrote:
> > Accessing EL0-accessible Debug Communication Channel (DCC) registers in
> > user mode emulation is currently enabled.  However, it does not match
> > Linux behavior as Linux sets MDSCR_EL1.TDCC on startup to disable EL0
> > access to DCC (see __cpu_setup() in arch/arm64/mm/proc.S).
> >
> > This patch fixes access_tdcc() to check MDSCR_EL1.TDCC for EL0 and sets
> > MDSCR_EL1.TDCC for user mode emulation to match Linux.
> >
> > Signed-off-by: Zhuojia Shen <chaosdefinition@hotmail.com>
>
> It would be nice to define the fields of MDSCR properly but either way,
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

