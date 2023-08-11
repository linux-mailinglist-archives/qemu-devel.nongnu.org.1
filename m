Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDEC778EB8
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 14:09:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUQxF-0004Ui-OQ; Fri, 11 Aug 2023 08:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUQxD-0004QR-6b
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 08:09:19 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUQx9-00037J-4U
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 08:09:18 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4fe0e34f498so3062801e87.2
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 05:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691755752; x=1692360552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f519i4IzIrPT4DfUdbMMnoDh8gDWGEPx3By6NW7ZTfE=;
 b=RiQ5NBTk7I6KOk426n6c8ooaY88cB33mL83tS7nPJ5I6knRk/IHHFBqGtBqJLVBSoG
 wVGcbwJi5xJMEanS1TgDVqPsIMiMYqY4yJnBqyTXzPqEh/7V9aocOT1IyVix0gbyBmA6
 /oDEDVc6xGqAUdE+4eUsWwcsfc25RXcLmtELvg+sqQUsg2zshP2/IPWE6XugCKBx8qMn
 +LA7T5aF13B53YJuF9ZdqN3vE9002XZXPrCf21G0oB7PApl9uPf7y/r6voqn5FTso/HK
 GPPGF0LqtJwkUzEu+S3HnFQk/2E4/OEowx/p5LuNSdJvzosmmSfTvhwXqjlWyKX0mHGx
 jV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691755752; x=1692360552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f519i4IzIrPT4DfUdbMMnoDh8gDWGEPx3By6NW7ZTfE=;
 b=cdQiJiOxRK2RrOb2lgM+nMB/C4R1M/4+bPYOEuYeEv1Bx3DITs15Zc+TBaTs4+cqzc
 dDAajkxvrw0z8pmFsHMK0l3wmb4ZZVUXmUH0uVE1c9Ogo16oP+0xDE3G6BrYCEm5e7VW
 zEzXEQSgkRwEN5VPrKBoSUxKWqECinSNcvw4P55S04r5nSTYGikok4U9qgrbVs3aGtAz
 e6frnRbig1E6My+8cYw8gPecz85O6AJXYmpmT38guzPjAbWaY7iSQfdZxHDuJ+cvDG9q
 03tvoeHBqCkZYTdp1Nx/0V04YJaJ9kiaQSKczxKbwSwyS7lilAbb0Dk9PdLlADLkbwDZ
 4HiQ==
X-Gm-Message-State: AOJu0Yz+p00z6rV0UjJ2M7DbFTunpBLobGSn52+CIfTrP+dqV/orwb4b
 4OVbfN0nH4l5WSXmNHb7iOPJuO2vlyxAprJeaViNmg==
X-Google-Smtp-Source: AGHT+IGhFxWfle4GG6E3Tti92i2irn8GAMObTk3ein2Eova+CF3E0ZFijGQ5DPRVzavxE/T31Q5rLKgAsepdGQ/RkgY=
X-Received: by 2002:a05:6512:b84:b0:4fb:96f3:2f4 with SMTP id
 b4-20020a0565120b8400b004fb96f302f4mr1432995lfv.51.1691755752212; Fri, 11 Aug
 2023 05:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230808031143.50925-1-richard.henderson@linaro.org>
 <20230808031143.50925-23-richard.henderson@linaro.org>
In-Reply-To: <20230808031143.50925-23-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Aug 2023 13:09:01 +0100
Message-ID: <CAFEAcA_u7vtVRz3XqFULH=a+iXVGvu-XERg482jh5OhhRrf7cg@mail.gmail.com>
Subject: Re: [PATCH 22/24] tcg/i386: Clear dest first in tcg_out_setcond if
 possible
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On Tue, 8 Aug 2023 at 04:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Using XOR first is both smaller and more efficient,
> though cannot be applied if it clobbers an input.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

