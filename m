Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B6070847E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 17:02:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzf8B-0004Wi-Hg; Thu, 18 May 2023 11:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzf88-0004Vy-Rm
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:01:24 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzf86-00072f-MB
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:01:24 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-510d6b939bfso3335362a12.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684422081; x=1687014081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BSokkkJ85wC0FcYBWg/iT24aoJnqpk9wFzh4rzt5yKs=;
 b=zwTZgJPNHby7cD/BE506ne1HZJjH2xZ3avsV/6wZoGgT884zUVKieNTIJUw05ATTjT
 XSiX5JLcHnJNEb3HcwqnCjPHwg5/u/1Muh0U7Cpk9Szz0jTRF7aYHZYHsNvWcvo4hKq0
 wd0e+AI2Lsi6TOSJ0E5GuxRVH70SeX+cRIF4Sx1ZCOwByuc0fCIfTNH5MPdHGGEj+Z1o
 V/XvntpES6VdlP6vVU6vG2rIkwSA6jFSBSfKXHlBDL9LDTyUYgI3RhZfg+uCUrATz04L
 K4/7KNH/eZiqLpEaDQaflRIi8zkUby3oDDfZwzLqgPET4JRb/1kzfrxBun/uxyvKLXwB
 MTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684422081; x=1687014081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BSokkkJ85wC0FcYBWg/iT24aoJnqpk9wFzh4rzt5yKs=;
 b=CTRNsEFW4i4luezcVkILxsRyfq5t5qkyNIGXmQc0BYM60rGFqr35EoEZapEpdFb4X3
 zlaUCJFET4Iz4C/xF/J8D8vqHRwGxfwkHKN+BL3IZV7lxrOJ3iXSc7ICpmNA7/pJghi9
 PvW/ArgxgP1AgibPMOifLFFoqpoiIcaXMDVRnV5D1VeBb2k3naAU+ZquA03oYok043qc
 upnk2/SdpfwZYAIBPXN3fzJ7ptbxxphQTl1h0yHL+9qUdUZaU/N9Gc4I6Fv/NSUig930
 NACxCNLOl9tbTcbbhSkFKClDWMk5XljWhcJE4CdEnKdoYqk0dYrM0MHKBhCxvxFO1sRs
 vCNA==
X-Gm-Message-State: AC+VfDyDYs+3sLI7Pa6Jmtb1Sr30euPHEC/dLfe1sMbhfmUsKoaDDL0Q
 Auv3aow2zVgRdON3JPFacmtmQyBLrl3bjblkvKN/4Q==
X-Google-Smtp-Source: ACHHUZ5/lw98kNr8K0Ai71v9WHdaXpPG8XuT7zOsRbJbKqvIEDhhxRQKuRbiqXY3MyAqkG3t/H2ySMHX+a2o9BXlKNo=
X-Received: by 2002:a05:6402:205b:b0:50b:c89f:f381 with SMTP id
 bc27-20020a056402205b00b0050bc89ff381mr4809103edb.29.1684422081002; Thu, 18
 May 2023 08:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <CANamGFG1Lq+QSMshgYChj663K=Sj19YEh8WP=HWYM6HBnpRpWw@mail.gmail.com>
 <CAFEAcA83RoCWzZD3pOdJndtRYynf7j0GwTEZCfOz6uOv5fybnQ@mail.gmail.com>
 <CANamGFFb_zwkAe0+VRfj7daL0CSs4-hS5SX-GRSmG2kJJCLV0Q@mail.gmail.com>
In-Reply-To: <CANamGFFb_zwkAe0+VRfj7daL0CSs4-hS5SX-GRSmG2kJJCLV0Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 May 2023 16:01:09 +0100
Message-ID: <CAFEAcA997nsVLYbhsXQ+vBnN-=gPmm=9fTmrbysqszgUcsx4uA@mail.gmail.com>
Subject: Re: Gpio in vexpress
To: ido berenbaum <ido.ber3@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Thu, 18 May 2023 at 15:36, ido berenbaum <ido.ber3@gmail.com> wrote:
>
> Oh, I was under the impression the vexpress board is not based on a real physical hardware like virt.

Yep; the motherboard part is documented here:
https://developer.arm.com/documentation/dui0447/latest/
and the daughterboards are:
https://developer.arm.com/documentation/dui0448/latest/ (A9)
https://developer.arm.com/documentation/dui0604/latest/ (A15)

> In any case, In my workplace we use the qemu for our CI testing, to prevent the need to use our hardware for logical tests.
> The thing is our SoC is not implemented in qemu, and so we are using the vexpress as it is similar enough when considering the core structure.
> But, as it is not identical we need to make changes to make it fit our use cases. For example, add a gpio.
>
> Do you think we should use a different SoC as a base for our development?

If you're just doing local hacks you can do whatever
you like. Upstream we won't take changes which don't
match the real vexpress hardware, and that didn't include
any GPIO controllers.

If the guest code you're running is expecting to run on
your actual SoC you might consider modelling it, but
this is a fair amount of work.

thanks
-- PMM

