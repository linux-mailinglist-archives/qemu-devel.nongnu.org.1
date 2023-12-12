Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F7680E910
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 11:26:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCzxu-0000QN-6W; Tue, 12 Dec 2023 05:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rCzxm-0000QB-JD
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 05:26:06 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rCzxj-00010h-ST
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 05:26:06 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-54c671acd2eso7293789a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 02:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702376761; x=1702981561; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5N+XvE0OAYnHKzLxcb8b/+ggdMaxe5/J5G5uh9SBrOM=;
 b=kR290JDx3HGiBurYeO0k3PQy7ifxbuurQrIveKOchrVBovshvHfL3AV6JTIsWB0Jan
 2rcyUZvpwIRBNZlIo/A3qpTfAPBfvaU2m2ewX97fIfpJyTZqMk3xNwfYaaZxtPg3YUtI
 GkvnqUKZqg1Ht4rQUufMFlakJGJCtRAXD8e8nAmwDu3874FPCJaUuCzW3YeoiEYYQfLc
 TVOrTZV1QpNQkd1P0YgnuIcO1Hw5dcoWk8/f3vUeKqyxK1puzSgnfhjqIlgqrUKYfEHm
 LL2FvU96re1eZ4JGIKjl6W72zB0VX2xskqp+DEzuUoUxnC6gXopzlnLGHC+/QxXNQD41
 iUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702376761; x=1702981561;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5N+XvE0OAYnHKzLxcb8b/+ggdMaxe5/J5G5uh9SBrOM=;
 b=vJ5tH5pPHtgpdxsLcu8HMhANoaxl5n6WsDWosTx4NbOqM8X0yl5EcHlijGjF/8Bb7J
 7v3/Ef5FYN/CqAgBmt/QHdya/ZoGuTR+oHmD3+WtYC9olt1BrYLN+gT8TnvaU/UiN75y
 5ZCVn26p/rsYVvmg1TJdknNAtcUlyNP/2TfIvEbc5iRs2cyEAdDOwKuyXwW0D+AwgmIK
 j2eR698f1GfsK+/z6pJeE6hhZP6RYJ3nj6pEjw1EBqauUgUGHF6IBQTbWCvtF7nKo2n2
 vSXEZWrpp3der6VHUUa+I/+d+W2qHiEZp1y0SCNCAQDumIt92xVO0C0EN5fBuvsi2hRv
 WDAQ==
X-Gm-Message-State: AOJu0Yy9vuOpKFKn5vPEAXMW0stRieUzhfbsNv+Zli15UjHYiXeQqZW6
 x+mMjoeEBIUWxvXyRdfZAOmGQOf8de6HTFas7sX9aQ==
X-Google-Smtp-Source: AGHT+IG8j2fZaxHA52hkab63U/G9ef4nYL5dkjIILBT8ubMGXBFurwqJxgx/c0mtFcNwaehZf0u7jFONzrzoQ0BlSuY=
X-Received: by 2002:a50:cc0b:0:b0:543:5c2f:e0e6 with SMTP id
 m11-20020a50cc0b000000b005435c2fe0e6mr3700325edi.17.1702376761055; Tue, 12
 Dec 2023 02:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20231211071204.30156-1-tomoyuki.hirose@igel.co.jp>
 <20231211071204.30156-3-tomoyuki.hirose@igel.co.jp>
 <CAFEAcA90fJgPGAjO0c4a=G+ge9bp1piVw40zt_rNHEoCTc_ngg@mail.gmail.com>
 <CAFS=Ec=fNB11TWWoJ847mF8v6=MkEefcMROwEyPQo9pceipNJg@mail.gmail.com>
In-Reply-To: <CAFS=Ec=fNB11TWWoJ847mF8v6=MkEefcMROwEyPQo9pceipNJg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2023 10:25:49 +0000
Message-ID: <CAFEAcA83J==kC5qUZBw8jE75iy=F0ojUKL2uvonU0RZ7iCqjSQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/usb/hcd-xhci.c: allow unaligned access to
 Capability Registers
To: Tomoyuki Hirose <tomoyuki.hirose@igel.co.jp>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 12 Dec 2023 at 01:43, Tomoyuki Hirose
<tomoyuki.hirose@igel.co.jp> wrote:
>
> Thanks for comment.
>
> On Mon, Dec 11, 2023 at 10:57=E2=80=AFPM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
> > We should definitely look at fixing the unaligned access
> > stuff, but the linked bug report is not trying to do an
> > unaligned access -- it wants to do a 2-byte read from offset 2,
> > which is aligned. The capability registers in the xHCI spec
> > are also all at offsets and sizes that mean that a natural
> > read of them is not unaligned.
>
> Shouldn't I link this bug report?
> Or is it not appropriate to allow unaligned access?

The bug report is definitely relevant. But depending
on how tricky the unaligned access handling turns out to
be to get right, we might be able to fix the bug by
permitting aligned-but-not-4-bytes accesses. (I'm
a bit surprised that doesn't work already, in fact:
we use it in other devices.)

thanks
-- PMM

