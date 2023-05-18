Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF224707CB5
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 11:22:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzZqH-0005XU-Hd; Thu, 18 May 2023 05:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzZqF-0005SF-2q
 for qemu-devel@nongnu.org; Thu, 18 May 2023 05:22:35 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzZqD-0003pa-DK
 for qemu-devel@nongnu.org; Thu, 18 May 2023 05:22:34 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-510d967249aso2365489a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 02:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684401750; x=1686993750;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i5jTWXJi2UPok0eMhr2rV6h3aRqWJ5z1zbkl3+0NiL8=;
 b=ETUTCu34oDgDecl5/p7JN+DugWxjHBOuvrYxdXEAGa8DPw0tt5kkh5HHoW3ET8TSsx
 alMSu3fccfH1EswjbN7lK4rH4HHLeF7bAlbx6Yl3JWsipZE3KF2RZCSDh1bhCqqmm2R0
 mvH+s9ais7hEj0a8RvftsPPaD/NZVhwseLaSnlpJ0/4qQcM1j3gTOTBLaic6QTW7JOKp
 UlLf/leO7wsOQaonSBLyebCHJ6kehFJ0Mz0itcv0/VLNuI4T9GoiQMv6669TL+uot+Fe
 UFrZtFX/x6KxhXGWJAeWcLh7GkB6y5UudodZMHGmCtSANgsWg4Zt1VuqLwerdYzjuvKU
 XeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684401750; x=1686993750;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i5jTWXJi2UPok0eMhr2rV6h3aRqWJ5z1zbkl3+0NiL8=;
 b=ESYHPofP8a6xEwZn0afuPWdpiL5tY8t1p0CoNgtxoj/Oiy7GoogYjKnNSJrVRO+jGI
 TfLl+iZ5y0wXkvpk2bKEDoRCJfe6NISgP0T3nl25/6nejSyP/CbMKY+P0OpaDESgHfET
 gS0Cn7Pl8n4Y/ejO5HKAkj2S0Q4R71il7kkv9C5InIo5zO3EnfKQRZlSukJA9T5bIR7o
 KpydeqxP+k+5hN4xiT+8BBmnIffwpc5AHBKW45KHA7pwZi6L+3V98pc5GFqcGkNDCkFj
 dqIRchgkXelZ4FfYi0kX5r4G6EDzZnqFDqMd/cPuC0jucWPuJs7g154B8BFKd0muI1pK
 zFnA==
X-Gm-Message-State: AC+VfDwH22RDGs0Vcc/lKh0CN4qJ0AimA6cpWYzB4sRThhkIhx9xTVg0
 Wr9GmyQ4fNYq96MSmnuHaPPcKwEaOS/lshfQYBx/ApOGo8I4vUxu
X-Google-Smtp-Source: ACHHUZ7GtlUNuU+TETSo4dpptVVvgDsSGZJmC63OHlNIzLAFzZuv6cdE3Tg0xcXvoVIiChDkYR1OXVs1sS2V4TRRdWI=
X-Received: by 2002:a05:6402:34e:b0:4fd:2b04:6e8b with SMTP id
 r14-20020a056402034e00b004fd2b046e8bmr4882392edw.29.1684401749719; Thu, 18
 May 2023 02:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230517174520.887405-1-pbonzini@redhat.com>
 <a7f23b7c-879f-36db-dabd-1891bda766e5@linaro.org>
In-Reply-To: <a7f23b7c-879f-36db-dabd-1891bda766e5@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 May 2023 10:22:18 +0100
Message-ID: <CAFEAcA93JsM+XkWnQ=SzR94k9eHVvfV_NnFeOtpdv70TLpUa9w@mail.gmail.com>
Subject: Re: [PULL 00/68] i386, build system, KVM changes for 2023-05-18
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 17 May 2023 at 21:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Failures:

> https://gitlab.com/qemu-project/qemu/-/jobs/4304958508#L2551
>
> /usr/lib/gcc/aarch64-linux-gnu/11/../../../../aarch64-linux-gnu/lib/../lib/libc.a(init-first.o):
> in function `__libc_init_first':
> (.text+0x10): relocation truncated to fit: R_AARCH64_LD64_GOTPAGE_LO15 against symbol
> `__environ' defined in .bss section in
> /usr/lib/gcc/aarch64-linux-gnu/11/../../../../aarch64-linux-gnu/lib/../lib/libc.a(environ.o)
> /usr/bin/ld: (.text+0x10): warning: too many GOT entries for -fpic, please recompile with
> -fPIC

This is really a bug in the host libc (more specifically, how
the libc.a was compiled), isn't it? We've only previously seen
it when trying to build the system emulation binaries statically,
but it looks like it's finally reared its head for the usermode
binaries here. IIRC it basically boils down to how big the final
executable is and whether you get unlucky with what gets linked
in and what order such that a reloc in libc ends up wanting to
access a GOT table entry that gets assigned too high an index.
Still, given the prevalence of libc that's been compiled -fpic
rather than -fPIC, we probably need to deal with it somehow.

Side note: why are we linking against -lstdc++ ???

-- PMM

