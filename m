Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B41AC7DF10C
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:20:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyVjG-0001dD-Fe; Thu, 02 Nov 2023 07:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyVjE-0001cf-Nd
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:19:12 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyVjD-0000Q0-4Z
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:19:12 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-54366784377so1252146a12.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 04:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698923949; x=1699528749; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U5w8qmsuzSJNU4CPrveo6BhzOJPzfjxpAznyXKfc83k=;
 b=UVkZZUMz+bsjrhqCN/e9Io+7RGveoQBx3kOmzDlVYUKVm192cPMvz7DVrZ5jyO3W/M
 ATG1w3mql3gvgATjO9eb0Qcoj8A/GQrtQZI6XEnh5JR+HkymGJcAwEhwKD3IbRkBrIt5
 12c7nvXA5k+c6TfmFLQZh1R6R/Z4gyCWbDPdmS3Iy9NP5EJEaYdEfrlcfzNq0uVPX7Q0
 vQ8eTj0qEA5+gYHGIAdFPoA4Xnv4FC3SvGHNXM4F/KvVGcUxUH2U0fiutLWuPOVbVimD
 /djpN9iTysBQRkx4MtWYLJxnw4JTjzpo2XzJr0SugZlfxSPBOD2/WBViVwz0mEFwxXuG
 xVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698923949; x=1699528749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U5w8qmsuzSJNU4CPrveo6BhzOJPzfjxpAznyXKfc83k=;
 b=ujoy+6aXcD9/D2EmzoRYHnrFKC6wf/IrnFoxaWYdti825HrlWX/BetnwS3piEIX3+0
 3Mx0crtSxzkBiobiau1t1IgEAx2zUNNkGiyHU+eX0srBuCvMs+cMKsG7WTLe8QhQb8Cc
 D6XMOTzMt63eSn9vI3Rc52tQ/0uDCg2qqGb3/uefzqgkEQamrOo8Z/+t3IhP3lX9G8Zl
 /t0SPyswaZaVwKSR6oUIOXG3t30H21wdcLHdYx8N0L8wXfrLzmC7FSgC6P+DyvXOUPKr
 +Ddtm8O30c5fo2tBNEQ5srKwey5eKyXCDvtQaxLwuO87dIUq25eA63KVwF1DQg5fS1Uy
 dhKA==
X-Gm-Message-State: AOJu0YyBXmsUyapbFGfe+rlxsSiP4c0pcQVlAFSBZ7MfH603irdGvXFJ
 4Y9uJaFhpBDz51WMvLeH2pBVwC/GUoaQpqzvxKhS/A==
X-Google-Smtp-Source: AGHT+IF/s6NdEgePb/pB4oKhkK4wf2yzt6USPc2V8loutAQ5RNmX6+4LGu+Voy9b2LR7exsYo0Rkk6b2usbFZi9Hig8=
X-Received: by 2002:a50:9fe9:0:b0:543:714b:535d with SMTP id
 c96-20020a509fe9000000b00543714b535dmr6584657edf.3.1698923948872; Thu, 02 Nov
 2023 04:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231030151528.1138131-1-hans-erik.floryd@rt-labs.com>
In-Reply-To: <20231030151528.1138131-1-hans-erik.floryd@rt-labs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2023 11:18:57 +0000
Message-ID: <CAFEAcA_9_5HGi2Q9ROVXECpd+KFZ=dUAcSpic3gaJLPQrrXnJg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] stm32f2xx_usart: implement TX interrupts
To: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
Cc: alistair@alistair23.me, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, 30 Oct 2023 at 15:15, Hans-Erik Floryd
<hans-erik.floryd@rt-labs.com> wrote:
>
> Generate interrupt if either of the TXE, TC or RXNE bits are active
> and the corresponding interrupt enable bit is set.
>
> v3:
>  - Drop patch "hw/char/stm32f2xx_usart: Update IRQ when SR is read" as
>    it is not required

Applied to target-arm.next. Thanks for this contribution!

-- PMM

