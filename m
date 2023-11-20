Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E017F1B0A
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 18:41:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r58GA-0000A8-9c; Mon, 20 Nov 2023 12:40:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r58G7-000072-CP
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 12:40:31 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r58G4-0005Lk-Tq
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 12:40:31 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5437d60fb7aso6831105a12.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 09:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700502027; x=1701106827; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zniXinmm5mT1NKcggD6m6tjOWoFpPePq+zVwIUa5EfM=;
 b=EC/ebZ9i2WgEm8SzRrgkrNZk0f+m2yM94ZCowpOT+i4J0kB+XaKQccY0qPTMGldp9o
 V3QxvQOfl4m5HbAsdjLtbtlywvNu5fLsehRtGxjq1dCnVhd/uQDIR4CmKIl0Bqcxrd6V
 T/iSRsb35nzYtushJM9qBtMBJ8u6pNp+eV+v7MeV5LWDOs/AQgXYDCl0lps9Y9rlUsRD
 PHLLflO519RRmSNqiCg9Ppm+IUhUidYwq/9sHM1KQJEwj/MmbVq1hvH30cca+XxRDczb
 X/BAgAky8OratFtk4BUeXRds70h8ZSqYp5XMNlFYUIJZquBpU2WaxCYcCe5XX4c5djZN
 3kNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700502027; x=1701106827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zniXinmm5mT1NKcggD6m6tjOWoFpPePq+zVwIUa5EfM=;
 b=mUt8hqliwb5+ow+qbSTnHX32FLp0HJeVeEw5FmSfWomvNQO2Q57Uarb2xZp0ROEmsV
 +fUvstYOfY+uWYJCq2F3DTAvnNqi0TDtk3aG9VIkbdiZwgAEUrDu9VrVa2GtxXMF1ywo
 lJVOyLdd+c94WnbKGSm+EASyMy0/F6bmj1Sb7q7/YYsFiuauBDDl7plJfOM00HFECQkz
 /Xvm2f61bmxhWnQpsd29eTo+FDR3iLyZEY1nPn8OIZN/4sZq/5+Qtndga6bIC1RnGcb9
 UaL4VQ+3kPvO0OKhXpIG2wybAHnvMOsPGcQKXt2ydOIVOf9CUAQiVlIz09p5oR9zKx2F
 B9Fg==
X-Gm-Message-State: AOJu0YzTpMhR+7tybyijSA0OuQDoXVez1lR/sgQjhM4qyWL+oN9jo1/N
 B6E98ApEOxbtaw50rMNOJM5dkvk4vO8kQDp5aOgr89hVsUkvbJ65
X-Google-Smtp-Source: AGHT+IFGbhw9r7Suug1BnyDg/5tK3X9WtK5syXRMQy/HlIyDXNeoeakeWROGvfkLN03F0p7rJ3WUeUUWxiIRPtL4pVQ=
X-Received: by 2002:aa7:d616:0:b0:543:5d2e:a9c3 with SMTP id
 c22-20020aa7d616000000b005435d2ea9c3mr87058edr.20.1700502026943; Mon, 20 Nov
 2023 09:40:26 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_koyJSR_7kF6TByA_rm2nJQr-8UnXrtu3JqwgpqUEctw@mail.gmail.com>
 <20231109135439.1297135-1-leonid_komarianskyi@epam.com>
 <baafd137-58de-42e9-9f06-c7f7789d4b77@epam.com>
In-Reply-To: <baafd137-58de-42e9-9f06-c7f7789d4b77@epam.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2023 17:40:15 +0000
Message-ID: <CAFEAcA_auQOuPyZMbGd2G6ePn60nnPLtm5N+jRGz1bTvsg5Scg@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Add overflow check for gt_recalc_timer
To: Leonid Komarianskyi <Leonid_Komarianskyi@epam.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 Dmytro Firsov <Dmytro_Firsov@epam.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Thu, 9 Nov 2023 at 15:14, Leonid Komarianskyi
<Leonid_Komarianskyi@epam.com> wrote:
>
> Peter Maydell, thank you for your comments.
> I apologize for so late response - returned to this issue and now I will
> answer faster. I fixed the commit according to your recommendations,
> please take a look at the new version.
>
>  > There is also a comment or two from me in the bug report pointing
>  > out that the handling of wraparound is also wrong in the other
>  > half of this if(); we should look at that too.
>
> I read this topic and as I understand changing the other half of "if" is
> not related to the reported issue. Since it affects running virtualized
> setups on arm64 QEMU, e.g. Zephyr
> (https://github.com/zephyrproject-rtos/zephyr/blob/main//boards/arm64/xenvm/doc/index.rst)
> maybe is it worth merging at least this change?

I feel they're really pretty much the same thing -- when we
added support for the timer offset registers we didn't correctly
update the arithmetic that calculates when the next interrupt
line transition happens.

I've just posted my version of a patch that I think should
fix both halves of the if():

https://patchew.org/QEMU/20231120173506.3729884-1-peter.maydell@linaro.org/

Thanks for prodding me into looking at this issue again -- I had
somehow got the mistaken impression that it only happened in
some weird icount sleep=off situations.

thanks
-- PMM

