Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40170705253
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 17:36:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pywhY-0002i1-Db; Tue, 16 May 2023 11:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pywhW-0002hU-8y
 for qemu-devel@nongnu.org; Tue, 16 May 2023 11:34:58 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pywhU-00081m-RK
 for qemu-devel@nongnu.org; Tue, 16 May 2023 11:34:58 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-510b154559fso555518a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 08:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684251295; x=1686843295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jU0td6g3mE7lml4bS7aOHyXUtlzCJZhqRiZSBio2fU8=;
 b=ZWDyl2bM9RSn2d24g+xRuvS2uHvJ4vNicw9NHDBsfn8rjPgvTID8niUhG5Wunt8vRA
 RK0bciQoHme5+zEgSYS59LgaELmpBEcnl5nGWQXnUrXmg0z42lkdheXF0kIXgHXoVbM/
 xywIglwbJqPV9U9h0y6YhsMrqYQL7r5DxpN9vcX8mwtvW0QuZlL6mLQa6U4r2YstwrXt
 dvq8pQeC+Ug0ligFrww3IotR1yJ1C9bZ0stTv8MqUyuYFfyAYr42GtvwVWmmiuiqStvI
 dhRQq5VawqBpv8sLWCK/pLUTj72M/0wIkTxGgX2fps+KGS2F68GJaezSty9BcFjlwwUU
 UfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684251295; x=1686843295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jU0td6g3mE7lml4bS7aOHyXUtlzCJZhqRiZSBio2fU8=;
 b=OJRQO4kfJ64cVeAd0BCoWd3iFZs5jbWtnbz/2BArNEDhVe3EVuaCGvuD1tZg9izFPT
 GlDFGYJzNxKAZWcMROw4r9909jkqpIb7pFuz5iznAQhCUwx1IdlQkyJsDHg2lunAUeUO
 lKBwZDY+p+C7M9JROHtnZrIg8HAwndZSuDCTJ0W+OxMHrW7r4UF7CgA5SX1FVz2F79n0
 p0GzBZ59IoullUnCl+f9gA+sm9+CZ4vb8akT2hqxfPzMFj3vpbqoBr8WdFkJQbxn/ZfA
 JLGi1uNCK4pA9+vK8OtVqs+fz7/fTK/38dNJDOmmLiyDvHfwjGqMVIlkjP2TcAUXDkry
 ZCkQ==
X-Gm-Message-State: AC+VfDwuIFYAUmO950DZmE+RPfz/NKmjJZr1USjuudPCQDfud/evu8vb
 1O5yzATqtLitazCKHo3qMMhc5iMt7dQlQIHsuq+TesxXZ7ojcq7x
X-Google-Smtp-Source: ACHHUZ7RDa54QYSZqjl+9xdpr6urxTGwq8ZjlRIOQA3SPy+QK5xW4sEPf0yM7gv0/uBdh8cn1CrrIGpBAQrLyk7tMG8=
X-Received: by 2002:aa7:d54c:0:b0:4fd:2b04:6e8b with SMTP id
 u12-20020aa7d54c000000b004fd2b046e8bmr32481538edr.29.1684251294779; Tue, 16
 May 2023 08:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2a4uxjURNAUcMemWj+mJOvNjgHbXQ-KgiRdRghByM7pBVROw@mail.gmail.com>
 <875y8tbt2y.fsf@linaro.org>
 <CAM2a4uyhfJdDjvk3+VfTtwF=h4WBC+MiMWq58LTSwi0s2-nHkg@mail.gmail.com>
 <87ttwcnvqk.fsf@linaro.org>
In-Reply-To: <87ttwcnvqk.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 May 2023 16:34:43 +0100
Message-ID: <CAFEAcA8HST4nG-ogs7TeVxQ7YtCikP8PjutDLLxc4dLC=CchpA@mail.gmail.com>
Subject: Re: Resources on deeper understanding of Translation blocks
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Gautam Bhat <mindentropy@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 16 May 2023 at 16:27, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Gautam Bhat <mindentropy@gmail.com> writes:
> > 3. Do you have more information or a visual diagram of sorts for
> > TARGET_PAGE_* and PAGE_* and the relation between translation blocks
> > and pages? Also how
> > should one handle where architectures don't have any paging?
>
> All system emulation is handled by page size because that is the
> fundamental granularity of the softmmu TLB which looks up a translation
> from guest address to offset into the memory region. It is not directly
> related to if the guest is using paging to implement virtual memory.

Also, each target defines a TARGET_PAGE_BITS even if the
target architecture doesn't have the concept of paging.
This specifies the minimum granularity at which you can
change things like r/w protection on addresses, so if your
target architecture has an MPU that might affect what
you want to set it to. If yo uhave neither an MPU nor an MMU,
you could look at what granularity/spacing typical systems
have between devices and particularly between devices and RAM.
If you have no pressing reason to set it to something as
a result of thinking about all that, then 4K pages is
probably as good a value as any.

-- PMM

