Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A8876B85C
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 17:18:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQr7f-0004Yr-A6; Tue, 01 Aug 2023 11:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQr7e-0004Yj-4n
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:17:18 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQr7c-00019b-Hn
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:17:17 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4fe0fe622c3so9056605e87.2
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 08:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690903033; x=1691507833;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iCQmOl8m/H/MvfqMVXE49omcRJ+TNZnfWjjbXSUJUWI=;
 b=KqWzCYKD1a1eKemOJzyIQ6ILUwGkh8AJu665Yk53OHCdeGi58T6K5wwALflvpHVoiZ
 LdNTQUIEqIKbV4piRvu1SBDmYyDL/f1P9s2+zpd0x9jhLtTgOjdJeEtFvZyyMHSS4MlA
 VBmxhfh3n5ZJo13Em5Jy2dv6ryenIu858uJ03RVwVb/SSa3VKpx7Wb+VI3xuJrWCltsn
 eYFiIhpIsRitOfnm93hRtu0LTaWzvR1KLIBNApIWqKTWSE5MWrQi2YAgraNP53STtepv
 AfopZMG3h56Z1Th0o8QTbw3Bgb3v3OILfK1aEJpciKT6QLUDQvDjydEx4duqnsRAvqY8
 hLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690903033; x=1691507833;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iCQmOl8m/H/MvfqMVXE49omcRJ+TNZnfWjjbXSUJUWI=;
 b=jnI/dSA9+NPC7wkSwNrnSry0qPstsFhgSY07SCGH1+ophHM73SFPSYo2TopiFjB4O9
 8qe7B+YuSqBej8uKFAuPapC1t/v0dnGUPaEe7Zs91PNSU8ylBcSo91WSSfMgzUa1y5aw
 HuK2uZHnRNNvsyQ2uYo/cf4fVOcSWpd9oIm5BErcM2+1LY4dROlBNliUQWId0eY6ejYj
 86WXnYL3Jz7c/3SJfownlvS31yxUTic8vrrZNkY7HIiL+GMwgZj0AjP2pmP1+z71dADk
 9TaVtaUbGFJrpfvnA+4uTBxKGmd8zWJ+mOKhFARi4pvQ/v4Een9HsBxk01LL3YwyCuSl
 PDAA==
X-Gm-Message-State: ABy/qLbsmL9R9RR1sWL2AvzbuxOTC94jMgYKPVU03yYcauTtjNsX+d7P
 BTxHd1iwtn1qeV6Z2C39pkDdEr01q0Ww0bicttK4lw==
X-Google-Smtp-Source: APBJJlHrNbiI3LdX/hsUZiMeMheUfo9XBia7xSVFYwUEsGsCoxVhHUvyCtsA2s+Yl5eKYJIO10RQfxAA7LwNr2wgsWQ=
X-Received: by 2002:a05:6512:158e:b0:4fb:9469:d659 with SMTP id
 bp14-20020a056512158e00b004fb9469d659mr3186107lfb.23.1690903033486; Tue, 01
 Aug 2023 08:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230731224106.292845-1-keithp@keithp.com>
 <CAFEAcA9xAeSpn6g66di95RihCyUxfo4hys4LRD-uJrYXd9RVuA@mail.gmail.com>
 <87r0omol1r.fsf@keithp.com>
In-Reply-To: <87r0omol1r.fsf@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Aug 2023 16:17:02 +0100
Message-ID: <CAFEAcA-WHHn0-PfJ8vTgZL5xjvR+=n1_We3v7uRT+Phi6DzsMg@mail.gmail.com>
Subject: Re: [PATCH] target/nios2: Pass semihosting arg to exit
To: Keith Packard <keithp@keithp.com>
Cc: qemu-devel@nongnu.org, Chris Wulff <crwulff@gmail.com>,
 Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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

On Tue, 1 Aug 2023 at 16:10, Keith Packard <keithp@keithp.com> wrote:
>
>
> > says that for HOSTED_EXIT the exit code is in r5,
> > not in a parameter block pointed to by r5. That
> > would imply that the correct change is to use
> > R_ARG1 rather than R_ARG0 here.
>
> Ah, thanks -- I hadn't managed to find the actual standard yet.

Yeah, the closest to a "standard" we have for nios2 is that
I asked the Codesourcery folks to document it in the libgloss
sources and put the URL to it in a comment at the top of
nios2-semi.c, given that there's no official spec and the
original and main guest-side user is libgloss.
m68k is in a similar position only without the URL
in our source file :-)

-- PMM

