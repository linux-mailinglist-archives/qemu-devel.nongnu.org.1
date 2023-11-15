Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CDB7EC0BF
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 11:32:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3DAv-0006cO-Qf; Wed, 15 Nov 2023 05:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r3DAs-0006cF-QP
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 05:31:10 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r3DAh-00016z-A6
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 05:31:10 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c509f2c46cso93935241fa.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 02:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700044257; x=1700649057; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iIZz/ye7u6KbEjFTQznTg1nQegrXOWkaci8BCgPMsgI=;
 b=zYHURx/AaJuO7Jw1UtGW6kfYzWC7MDrls/9O25S4mcM+zpEIfjHSV1howaDyIzTkVK
 VfPG73XBrs4pBHBSCrmx9JQ1Syas7gYDLv+n7gRx1STwxdyU0jJeWrxdwZtGzvfUuQdB
 pkQjCPZJwxELGzfJPrUMZayhUI+Q4EXHwiR/7IFjsm51veRsTCi0atdHsCgkUMuvDvpj
 4jTEOanjch9gPFc0XzopUJUonTip6AtTk8dIC5KaE8ydSwUwVO/iRfr3yaITq4GzNsML
 vHww3nDJn8CNf0Yp8GuM3vudFXxZH60EHjtbVouH9G8p0QUCWopLpisdgh09SV3hUIWc
 1A8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700044257; x=1700649057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iIZz/ye7u6KbEjFTQznTg1nQegrXOWkaci8BCgPMsgI=;
 b=fstdd2ppLbbHc5SXfNZjgTu6cf4eosHJEfGWAkB4PHqdynYpV0sClp9HVeTM68Rc5O
 rmrUKnMRj6HDHX6DbPzNXUn0LNpflVjwrr37hrhb3dnJqHlTc7nN2tB6jVxNQp63Nuz2
 ZNQknx72X7niKVrgZvpsstPw63cELGYYQ6TbTgXtPibjDwNzuieotycgI+VBYUzi6Be6
 fIe8nZxiP1hzurAvr7CB8Xo9LtEnFGDsTjykxT/6QaHnXZYcdz9OBacCwIAESLD78X01
 UhpOe7eHSUNZEmKhc+C+8LP82g4zElR2W/U1qwnpmAd1XKzYP/gZe+dBORbhlUYMAIg9
 8zwQ==
X-Gm-Message-State: AOJu0YxREyHYFMO05nEoXgHAhsiGMFeFUfcKrBAibrADOEN3tzaEwFvj
 PLFHqumrsHiuyC3nh51b4obNQrod0m7Qpl51Ft7qMA==
X-Google-Smtp-Source: AGHT+IHSPUGWsYxOMVxpwKs5yX90QfCWv+0s2UUX3eu4VBAhFplrQD89aAnwI7LoWlebJ78LweWXD/0dcWap9vWQDPQ=
X-Received: by 2002:a05:6512:3b8d:b0:503:2555:d1e7 with SMTP id
 g13-20020a0565123b8d00b005032555d1e7mr12389369lfv.45.1700044257076; Wed, 15
 Nov 2023 02:30:57 -0800 (PST)
MIME-Version: 1.0
References: <20231114205507.3792947-1-venture@google.com>
 <bc43ecb5-f93b-4288-a6e1-624aebfcffcc@linaro.org>
In-Reply-To: <bc43ecb5-f93b-4288-a6e1-624aebfcffcc@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Nov 2023 10:30:13 +0000
Message-ID: <CAFEAcA89CADp4FhwHd2O_7F07OfwpFZCb534jOjSK4uUt+sqfA@mail.gmail.com>
Subject: Re: [PATCH] softmmu/memory: use memcpy for multi-byte accesses
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Patrick Venture <venture@google.com>, pbonzini@redhat.com,
 peterx@redhat.com, 
 david@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org, 
 Chris Rauer <crauer@google.com>, Peter Foley <pefoley@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 14 Nov 2023 at 21:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/14/23 12:55, Patrick Venture wrote:
> > Avoids unaligned pointer issues.
> >
> > Reviewed-by: Chris Rauer <crauer@google.com>
> > Reviewed-by: Peter Foley <pefoley@google.com>
> > Signed-off-by: Patrick Venture <venture@google.com>
> > ---
> >   system/memory.c | 16 ++++++++--------
> >   1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/system/memory.c b/system/memory.c
> > index 304fa843ea..02c97d5187 100644
> > --- a/system/memory.c
> > +++ b/system/memory.c
> > @@ -1343,16 +1343,16 @@ static uint64_t memory_region_ram_device_read(void *opaque,
> >
> >       switch (size) {
> >       case 1:
> > -        data = *(uint8_t *)(mr->ram_block->host + addr);
> > +        memcpy(&data, mr->ram_block->host + addr, sizeof(uint8_t));
>
>
> This is incorrect, especially for big-endian hosts.
>
> You want to use "qemu/bswap.h", ld*_he_p(), st*_he_p().

More specifically, we have a ldn_he_p() and stn_he_p() that
take the size in bytes of the data to read, so we should be
able to replace the switch-on-size in these functions with
a single call to the appropriate one of those.

thanks
-- PMM

