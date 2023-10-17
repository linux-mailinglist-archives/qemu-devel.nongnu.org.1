Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DC27CC2C3
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 14:16:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsiz4-0004Cu-8y; Tue, 17 Oct 2023 08:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsiyy-0004CY-EF
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:15:36 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsiyw-0002Is-ER
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:15:32 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53e751aeb3cso5264338a12.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 05:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697544929; x=1698149729; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RYJFy+a6sx3s6+zSIv8CY0p4W3xeTRNrNo9sBoS0Q1I=;
 b=gJrtTftWA3XtxNABPl/mZohRYda81katRiRgRszQTPNrdL4A6tyra9PF7/FmgWp4U4
 Zlac49RLzzi3Uzd0Qe+wHlBpplNefbor0owOHA65XVnLoEdLvKkCG7imngEfKLBVPyXu
 FZUfDmHijjwt7Lig/3tbG8mF968lAYOX34gXGx66IP/Rq/lrkQ9m1Cx1r+DN5xbW9hh9
 MTU/F2UP8YJ8Ysqtbq40Cc8w4sBVP0dxiH3Xh1apKWZy+jcv4kDZUYz/fJQCRJ7GnAKC
 1RHo64AsKQ3pMc76P/InrZJxoKAgRKDmqHD5+3L98K3vGh08i5R3Kxk4c2o87ZZF4J+K
 V/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697544929; x=1698149729;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RYJFy+a6sx3s6+zSIv8CY0p4W3xeTRNrNo9sBoS0Q1I=;
 b=DFD/aWtnaZSk9LPUCA8FnprQlNyEWmO3TksZMVkr42XNuy4C+X0yMWT7NR+bJwIsOO
 pjJx8ZAKrODEw2mma8hExxj1PlOMLTU7UmeeRQJK8uLZ/B+OI3CYhqJ965eBAnfyD8eg
 KCnANdSrrE6NTjB9xBq+nvCQ/hPKJOVKhZ++YAxDmxtC7AGDXzYfCbOJSOOwQOEMPU/m
 XCsyXX2rPyI9xBEMBJd45leRg05RbpL3MTc/FGUtXbLICotiizeVnkeOjBFXLk2Vx/Mt
 MeVriwM946Abp2wnvesfJxESMox7dokYNNJM1aKsU4DaeC6Qnes2WmHCLXaRmC9y1V0r
 fV4w==
X-Gm-Message-State: AOJu0Yz4ux4scx6VsNP+LL5nmX+ymOlKYWUweV24CDJlbZOfenQRpgLU
 0jAlscAvhJcdYjlHRHSDzefwrmhxVHkQpbLX2n2bQg==
X-Google-Smtp-Source: AGHT+IFrFohaoeVJXzgdVCjVBnTyftrl6MTwgfE6/9BPXMAOGWvWK/OPob4dQh7LMdjndQIllX2J8m/t7bZwQ2wlpJk=
X-Received: by 2002:a50:cc9c:0:b0:53d:f180:3cc5 with SMTP id
 q28-20020a50cc9c000000b0053df1803cc5mr1744853edi.20.1697544928848; Tue, 17
 Oct 2023 05:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231010142453.224369-1-cohuck@redhat.com>
In-Reply-To: <20231010142453.224369-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2023 13:15:17 +0100
Message-ID: <CAFEAcA9cLZ-Q5-oPqSgt2GdR=J4yGo6BD4nWoeNnwj-ZXfBHaw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] arm/kvm: use kvm_{get,set}_one_reg
To: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 10 Oct 2023 at 15:25, Cornelia Huck <cohuck@redhat.com> wrote:
>
> I sent this cleanup first... in mid-July (ugh). But better late than never, I guess.
>
> From v1:
> - fix buglets (thanks Gavin)
> - add patch 3 on top
>
> The kvm_{get,set}_one_reg functions have been around for a very long
> time, and using them instead of open-coding the ioctl invocations
> saves lines of code, and gives us a tracepoint as well. They cannot
> be used by invocations of the ioctl not acting on a CPUState, but
> that still leaves a lot of conversions in the target/arm code.

I've applied patches 1 and 2 to target-arm.next.

thanks
-- PMM

