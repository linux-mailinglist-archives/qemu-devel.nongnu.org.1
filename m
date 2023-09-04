Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A55C791BAB
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:34:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCWR-0001al-3s; Mon, 04 Sep 2023 12:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qdCVy-0001Zm-PI
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:33:28 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qdCVv-0003Xk-Pl
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:33:25 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4c0so3539070a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693845202; x=1694450002; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xycqdc9Ymk7oe+LUm8seOyH13Zq99UAqZnrpB2/jxM=;
 b=fhWDpKzOMbeQN/gvNJLBhhBc0O7m/pqefvhyMrGrv0CXVAzEbjd3P65hou9HIaN2gd
 2XezmaKw9jjw9zx69Lt6pLNVz1D0/v1q+d6SAM3LYs1mGXlknnLKb7oKQk/fjOT4kv45
 1Klto5U9bNpM/1kto7rLwBXH50Qy3cx7ansGklFZPsC5B/MsWYw/aq+KCKiWudk61NQi
 ngnFEXltJvdjhJE5abKGfF08tQwxkompyStcT+iwg+/fk13jJmdVyQ6stA2vmC6l/BUN
 ZsinWsgzOtJYo07pi4MdYumsgjJgcYC4PgfWvM+WWbiYSTV8ffPVpxQ39xv/EO8/Gfib
 X1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693845202; x=1694450002;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+xycqdc9Ymk7oe+LUm8seOyH13Zq99UAqZnrpB2/jxM=;
 b=ArvFK9Kr8Le/7hk2G867e00V1c9HxP8YDCHOUQtRh2bxCPAh9Iv0C+qZdaTF0d7oIq
 Sk+60nn9SqpMtk17pqhjdHA2WkyiXbkdyyYnWXmf3Gcdr1dJTeA8HsyUN/4dGL9wM0Qs
 oUVXmjJncSRmPzuJBWyTct3GNUAtQoakin94tl9R3RZi+uXGkLI821PUUuCXf3s5YGj+
 43ULICvHZM1JLRq3hDtEYNlR4ukkV0TUw0UbTCThKWZT6O+tWS8gA+RRLr7nmuRcnQ6K
 7dPF9VWIjLEKjwB4srHV24n48nfrZmGZr6H8k/segeqOl1LCtsHTgc/wnaNeJXfSwsRj
 PnbA==
X-Gm-Message-State: AOJu0YwPllcWJUaLobtBSZk1c+f8Ae+evYKCVdBZyWldvF8fS6RtbozB
 UFP77Q97MzCcK9cUEPaR8gFnVA/2KMrbWpY9LdEkvg==
X-Google-Smtp-Source: AGHT+IHeTsq/5/sJevtTr+8N2zJtdQ3Q54WcY5+MlnoUFC3XKgfwenX9fbCAsZpYeuwZdkJC/jklfXn8fEIYXwzTQAs=
X-Received: by 2002:a05:6402:51d0:b0:529:d147:e9f3 with SMTP id
 r16-20020a05640251d000b00529d147e9f3mr14848201edd.5.1693845202418; Mon, 04
 Sep 2023 09:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230904162824.85385-1-philmd@linaro.org>
 <20230904162824.85385-3-philmd@linaro.org>
In-Reply-To: <20230904162824.85385-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Sep 2023 17:33:11 +0100
Message-ID: <CAFEAcA8jO5Ktqf4ND79=Di=BnuOPjp+Hw+TM9fN6UNj-M8-POw@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/intc/openpic: Clean up local variable shadowing
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, 
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 4 Sept 2023 at 17:28, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Fix:
>
>   hw/intc/openpic.c: In function =E2=80=98openpic_gbl_write=E2=80=99:
>   hw/intc/openpic.c:614:17: warning: declaration of =E2=80=98idx=E2=80=99=
 shadows a previous local [-Wshadow=3Dcompatible-local]
>     614 |             int idx;
>         |                 ^~~
>   hw/intc/openpic.c:568:9: note: shadowed declaration is here
>     568 |     int idx;
>         |         ^~~
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

