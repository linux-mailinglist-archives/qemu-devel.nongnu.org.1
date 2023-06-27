Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E963A73FCD1
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:25:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8hI-0003aN-Dn; Tue, 27 Jun 2023 09:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE8gr-0003Mq-Dl
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:25:09 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE8go-0003pF-5I
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:25:03 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b5c231c23aso49559691fa.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 06:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687872300; x=1690464300;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dQHDRlFineNoCnz4Z3ZK9n6oCPa7bU0x+13uDq/ABU8=;
 b=Wb989pH6c+OPuN+BND9I0L0wDbbX/SqZdhrV+ESnCDOJ4f8a5E+UgdrGN57S9UNqY3
 bPRI9S3udXfOgQ78iSlll40d1ByHLjwp9eNHA4BtWIFNJsZg8WF3C2X9CIFTrMb1JvEW
 ZcT8aiX4YxygvUsi0mPdU+E0k7bpn2RTZM0Nj41LVbphoScnMDhVxEnm23btZr9oh9mi
 uqDOlLzJs8LT/j+gM6gdcQsxxRB5fnYXxfdI4tkyOasVFQ/mOwS1VG5ZdZVuect2Up7V
 /EkJekW1qh+opG9oAqQ7Xa5PhV1m+wXgpcCQtF5OH+tpWAifJFuH/MYMNCdJQfuIEV0D
 bvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687872300; x=1690464300;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dQHDRlFineNoCnz4Z3ZK9n6oCPa7bU0x+13uDq/ABU8=;
 b=XoJOMO8Dutq4/nvE3m26ysJwbfIvDuhL8uIB9EZeOKH33egMrvqGfy7UsLLJS+mS2R
 r9UCt95LdKQhESgl3nxw9ZPFKfZ7IePXMRjxCp9lFYD7WTG7OJoN2UiUGOkULHRqvxg5
 xbuCXr1Z50wOos4US1WkOiA88izHTfC6RMIAXPMJFWTVjQ87cWM/XPKmggtpbqPuKRHi
 JVe5A5U+4BG4DL2lNa6eFVVwqeusg34+E1O6d2WF41yu65lDxCm+ZAXWur0gdI+IwQG7
 wXf4GxINlSyTXdMpV4yQlVHRG9BdA9YQ9JQaRxuxoo0V/3KwZGWaI/fT8topjTV2cBrn
 gYEQ==
X-Gm-Message-State: AC+VfDz9rx6q93usixFFLrkCnEYBOVZoD/8ZaMFx6WuKOxU+PM+9zfBy
 Fu/hkZvv0XC+u3YLzaECkdNCxKD7lV751LMg7j/B8Q==
X-Google-Smtp-Source: ACHHUZ4uDrJQ0U1VWLjvY8hpR19Wi5Q9uZgb3nxjVdhZGGrAobI98J9mzcpXrwzQn5BAMCw1WDcu0dv9k3he9YewQRQ=
X-Received: by 2002:a2e:6e07:0:b0:2b0:573a:3c69 with SMTP id
 j7-20020a2e6e07000000b002b0573a3c69mr20842698ljc.23.1687872300001; Tue, 27
 Jun 2023 06:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230622151201.1578522-1-richard.henderson@linaro.org>
 <20230622151201.1578522-5-richard.henderson@linaro.org>
In-Reply-To: <20230622151201.1578522-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2023 14:24:49 +0100
Message-ID: <CAFEAcA_5DtgkisLOQS+ToYb1obbh06vawzxZKnpG+_9+tSMorA@mail.gmail.com>
Subject: Re: [PATCH 4/4] target/arm: Fix SME full tile indexing
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
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

On Thu, 22 Jun 2023 at 16:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For the outer product set of insns, which take an entire matrix
> tile as output, the argument is not a combined tile+column.
> Therefore using get_tile_rowcol was incorrect, as we extracted
> the tile number from itself.
>
> The test case relies only on assembler support for SME, since
> no release of GCC recognizes -march=armv9-a+sme yet.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1620
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Should we cc: stable ?

thanks
-- PMM

