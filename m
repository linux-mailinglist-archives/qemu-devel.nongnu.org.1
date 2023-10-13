Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1D07C81DA
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 11:20:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrELP-0004RP-7E; Fri, 13 Oct 2023 05:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrELN-0004R5-D4
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 05:20:29 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrELL-0006fd-Pp
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 05:20:29 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53dd752685fso3314354a12.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 02:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697188826; x=1697793626; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PzA/o1mqLZWhWgE5bPSaUnGXXWtkY7CixflE7pLoS/A=;
 b=RuHsGfC9brwO8xheEBmG8/UvNpM2WHYX8dGo6o2pfaubZdH1fVduhNaiA2HxM9fLT0
 5S8SYoQKAJe4Xbju5RDuF4ocI/pO93V3tzb0h17bqUeSN9yL0tST2f110QkLWzml28Ca
 RBfs2+wj+/Oa+g/HcYfyuSrpDS+AHJ9Y1/F1Zi5Agltquz5enhSXKs+7ZcG28BGXCMe7
 DiPHB3BYdlB1/tNTQXb5CQqk5W7qZ4ksWPff5rk/pR9R0aiDr1zXXFhlCyd0y3SuOd1O
 MvKZM3wM0LXwtgk4FMAzDtYfwQv+TiAbnoVY1YsrKESeBrPoMiTmMwju4oHHpiQ7+xga
 nl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697188826; x=1697793626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PzA/o1mqLZWhWgE5bPSaUnGXXWtkY7CixflE7pLoS/A=;
 b=I9Iutn/8bMn2PmLeUwjWB9E4uW0Lg3UmrhqBn9MlgertLGKuC/7dUo6JazboTfzzmD
 vugk6Wu44at6IqqWDroJaHjZX0WpCXjNzfjAhy0tGpmC9iB0A/AglKceHxb+JTFsPTih
 j7UW5JODaCLAffD+td9haVNccY28hlFVCTkHU5+eQ9U8IMb+m226cxK6AIRF20nkgkZm
 7x/iThQtSmrfo1K0reAXSmc+pbyXryVuVatSFB0mVY+MHZeKjDzMSALJr2x6ikIYTJZW
 K8dvLZqo5pfppD1L+MjumckQk7ROnzLDREeKjgE6LkbtcbC4kx4k+J8jvQbI6aPCeUrd
 U/5w==
X-Gm-Message-State: AOJu0YzUDX5SXuHV6U4wOsEACeEyMZp24H/yb6R7Qf7Y2bCw27OaNYgB
 8RWU7uLuY08JjPWnNmorfw8yjzuyhQOVM7Mhpfgxn8aKcRSXTq8u
X-Google-Smtp-Source: AGHT+IFVvsiENqc4thJX5K1r0SnW/EQm5ROzI7KPoLaJdXSPdy/RBS1AhXMlRSzFjxBtEvezsH03kyOJjomzTp7jI34=
X-Received: by 2002:a17:906:cc2:b0:9ae:5db5:149 with SMTP id
 l2-20020a1709060cc200b009ae5db50149mr23290286ejh.35.1697188826248; Fri, 13
 Oct 2023 02:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
 <84a6d743b5ff71c323cee718412e2a67084b9237.1697186560.git.manos.pitsidianakis@linaro.org>
 <01971536-5a3d-45b0-99c2-b3583dbb9584@daynix.com>
In-Reply-To: <01971536-5a3d-45b0-99c2-b3583dbb9584@daynix.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 13 Oct 2023 12:20:10 +0300
Message-ID: <CAAjaMXYjgKapC4h4cQTQAuq=GVkUCKp0iYkrpiLFVGFkbrFcwg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 57/78] hw/net: add fallthrough pseudo-keyword
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
 Vikram Garhwal <fnu.vikram@xilinx.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52a.google.com
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

On Fri, 13 Oct 2023 at 12:11, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> > diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
> > index 4525fda383..42f19618b1 100644
> > --- a/hw/net/rtl8139.c
> > +++ b/hw/net/rtl8139.c
> > @@ -2447,8 +2447,10 @@ static uint32_t rtl8139_TxStatus_TxAddr_read(RTL8139State *s, uint32_t regs[],
> >       }
> >
> >       switch (size) {
> > -    case 1: /* fall through */
> > -    case 2: /* fall through */
> > +    case 1:
> > +        fallthrough;
> > +    case 2:
> > +        fallthrough;
> >       case 4:
>
> I don't think you need comments or pseudo-keywords here.

That's correct, it was a stylistic change. I can remove them in the
next version. Thank you!

Manos

