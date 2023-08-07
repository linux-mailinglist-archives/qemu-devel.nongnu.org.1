Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCDB772A4D
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:16:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT2td-00052v-3c; Mon, 07 Aug 2023 12:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT2tP-00051x-Gp
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:15:39 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT2tN-0006ZN-Jv
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:15:39 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5230f8da574so1858660a12.3
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691424934; x=1692029734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NTzGMqsBG76+Mj9TCM0lCzACEfbqMAiSZLU5eXNdJVQ=;
 b=nnns/hNN4KcrSBXQdb6Q2FoVEBUR4WTxCaMuvQg4N5BWyNrBe8RPPTLadWsRa9Gvgz
 C6Mm1NRu8BUzf10ICG4tArWD1zkCr00hALO5whKhpcAwRchHDrJrOxtxIjUY198eCqCi
 +Yx1UoFvTOmSChMhSp8uL4RC92DY65+0VMFRSEnmONBbKCo2lj8EkJJhsMWf+LRKbIOH
 QQiMJozeirMAcNu2Wdkf7gFHUTKVla3tkrVr9zm0x6pjh0/vpzFp8KXlESBl18TRA4jQ
 /L1nrqwCW0XGjVhxohkLqVKON/+qw3Y6jKMJxGb3uHYI0vlWRZHJVa6enIS9mlD06NPH
 5CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691424934; x=1692029734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NTzGMqsBG76+Mj9TCM0lCzACEfbqMAiSZLU5eXNdJVQ=;
 b=diP6ayS+7DRTGRynmyLZT+J0/iAAjRhjjYGS2d0fpRqCf7Rs1R2U5+KGASx0xTb7ns
 7/d9P4kddnCo3dE6OD9/VwZ+jT8K5eon62dcPPPwFkTMeF/iSYyZAmNZhXVat0+bDviG
 7hgyt1JLmydrea89cQyCj67os0fE5S15vIBxsRrdK3PWj6R32rvN+ylHwN5CU1kxkOkq
 0Qa9cgCQq9SZ6RShHC7LolzgnMpiAhKCw043e5itmYD4foTw2cfQteD5FypelN1MQbY4
 WiXEOsrJwPKbGOH2q948AdT/TUfmKdLP0Kn+/kkphlpLFYFiqHZKGlxA+c9qqnHhzfFE
 eiEQ==
X-Gm-Message-State: AOJu0Yzty24IyT1e2aGlq2gstywqlS5y9ESQLoZej7hMAtEoTWW5Useg
 lX226Wutw6KVw7yP/FhOQYL5QO8yj69NnLvRxJZtHXPAvLi0qsMC
X-Google-Smtp-Source: AGHT+IEKNCX3P8XaeacQ9HyuR1PSqvOAOmb+kOkWADMx1WICBEA7CWjIwmTZp2RyJ3wWLuPbjsMay0YchcUDudpXbqY=
X-Received: by 2002:aa7:d8c2:0:b0:523:2274:91cb with SMTP id
 k2-20020aa7d8c2000000b00523227491cbmr6897090eds.12.1691424934674; Mon, 07 Aug
 2023 09:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1691010283.git.jcd@tribudubois.net>
 <0f53f1ec92eebc4cfa7acd6b170a9d1f6ef754b1.1691010283.git.jcd@tribudubois.net>
In-Reply-To: <0f53f1ec92eebc4cfa7acd6b170a9d1f6ef754b1.1691010283.git.jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Aug 2023 17:15:23 +0100
Message-ID: <CAFEAcA-A7+XbACR-91b--fGfUcjv+boRzZEr=FM3WS5T3EuMAw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] Add i.MX7 SRC device implementation
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Wed, 2 Aug 2023 at 22:08, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
>
> The SRC device is normaly used to start the secondary CPU.

"normally"

>
> When running Linux directly, Qemu is emulating a PSCI interface that UBOOT

"QEMU"

> is installing at boot time and therefore the fact that the SRC device is
> unimplemented is hidden as Qemu respond directly to PSCI requets without
> using the SRC device.
>
> But if you try to run a more bare metal application (maybe uboot itself),
> then it is not possible to start the secondary CPU as the SRC is an
> unimplemented device.
>
> This patch adds the ability to start the secondary CPU through the SRC
> device so that you can use this feature in bare metal application.

"applications"

>
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

