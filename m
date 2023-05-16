Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB637048E9
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 11:18:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyqoH-0007Us-B5; Tue, 16 May 2023 05:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyqoE-0007US-Vt
 for qemu-devel@nongnu.org; Tue, 16 May 2023 05:17:31 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyqoD-0001Qx-5H
 for qemu-devel@nongnu.org; Tue, 16 May 2023 05:17:30 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-50bc25f0c7dso24890059a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 02:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684228647; x=1686820647;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TRYbbbc+Uspeii3LgBJR97n4YGR3zf97bniOW5prRXA=;
 b=FAAOH1RMlHDIx2WOtqV8poimcLLVX2wKWCxzbDKVGgzFR8LbSqTa3uFm3/AuniA16r
 hDG7zoQ0wbVq8x3+r+DG1Sb1hjC9qjcbhxTGg0iTcTPdlRq/nya2sB6RzISZMPjQHfrX
 nAzNldkF+uKUEJkY7/A4Itfd4OYr6hMSMAkG0tsjqNT5EEIfDpTMwVjjCW91qtUOQRPq
 tNGzOXhWk1Q+4gcZJEC/btq5if8juDN2jTWcsZeEuFGnX98wFtZCwdt+3wdrsFnYqhKD
 XwJ+EE4LtzdjFmi9awTUXp02sZPtev/zlEjU6iSUhiUzV4bhasL+HC9QnR7Jt4RLAoa/
 ctIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684228647; x=1686820647;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TRYbbbc+Uspeii3LgBJR97n4YGR3zf97bniOW5prRXA=;
 b=dvrR68WbAw9dARkeWwyuTa+63qCF0vn9cFHtt5NiqkPK67noNOEt/nTECDPKjTzbSW
 UYrJCYeEy9212xuBd9OUxqU+pMNvMQsMRbTlDDSyH9lc5vgaZ1NE2p1FYfHmmhvb3owL
 /tlbuU/NgS9mfwWvQ0d+STJyQpAzFk4ffogF0Sg7I1/513XMSiHsT5AV0Q2J3jb228Nu
 zH2PkmeX6/dceWwCIct9JkRN4KFw4PSRDBsn2868PrLwFVm52l9Uw+rLv3Shadtjme7W
 ssdKNBoDQb611cSCdsWN5e9ijYC/LbAQGJGDbtqGrSUO2Aiwk+hvBTD5vvMbUADdjSVd
 Pt8A==
X-Gm-Message-State: AC+VfDxaLUGEKsBYOp28FKdKmJ4SHCMuPmCYna/GkDkeupvljZUNcJc/
 iLxU6BRz7uzp7i+te56QQzBwlZ3GDk9LEd3SXCa5o9ZSdyZBG4BJ
X-Google-Smtp-Source: ACHHUZ4BfbebvX+gkKylW58gftwjXzh5vMyF/4GdHl+A4MsIQu34BcfPGneWjJdnGz2nyp/ROIi8Yg5S2iEl82t72jc=
X-Received: by 2002:aa7:c950:0:b0:50b:fb85:8608 with SMTP id
 h16-20020aa7c950000000b0050bfb858608mr26831453edt.25.1684228647349; Tue, 16
 May 2023 02:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <CANamGFG1Lq+QSMshgYChj663K=Sj19YEh8WP=HWYM6HBnpRpWw@mail.gmail.com>
In-Reply-To: <CANamGFG1Lq+QSMshgYChj663K=Sj19YEh8WP=HWYM6HBnpRpWw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 May 2023 10:17:16 +0100
Message-ID: <CAFEAcA83RoCWzZD3pOdJndtRYynf7j0GwTEZCfOz6uOv5fybnQ@mail.gmail.com>
Subject: Re: Gpio in vexpress
To: ido berenbaum <ido.ber3@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Tue, 16 May 2023 at 07:36, ido berenbaum <ido.ber3@gmail.com> wrote:
>
> Hi, I was trying to understand the architecture of the vexpress virtual machine in regards to adding new gpios that are going to be external.
> First, is it right to act as if I am developing on a physical board and add the gpios to the VexpressMachineState struct?
> Secondly, which gpio type fits here? I see that for fsl_imx7 it is the imx_gpio, but what is for vexpress? Should I create one?
> Or, can I use pl061?

The vexpress is a model of a real piece of hardware, so the
answer is "you model what the real hardware is doing". You
should be able to find that out in the technical reference
manual for the board / daughterboard.

Why are you interested in the vexpress in particular?
It is a pretty elderly development board...

thanks
-- PMM

