Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC65D73BBAC
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 17:31:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCik4-0005n3-B3; Fri, 23 Jun 2023 11:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCik1-0005mZ-EV
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:30:29 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCijz-0002jR-1q
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:30:29 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51bec9aaf7bso839293a12.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 08:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687534224; x=1690126224;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mo56cbIAzhclFMowRG10ZzuD9iDal/F8QoPKUNo+8xQ=;
 b=iYS6sRvvbfd+MAINXDxmfsDefcmJRoiqcCa+Z13ZOUN0CoWYMa50157EPw0qw0i3oB
 GATje6f+HTDWnGyctj3p5Xw/NluFnVUjqsvNikQeI6J//Otld2sV6iWMfx5OZgcU9Oh5
 onosmi6hHLXR6nsHxHS4qk/39WNrGsq83z35WaMcdJVaEMJFJ9LWZxH0hIqmuARDHNC8
 bcD3Ovxt5+n0G4S826NHgIh1Tg296yBrZ4CUOdQPlMn7iT7JAjyyNyyW1SEJ8osmAG1W
 yZOrsEXF088rqHWXogUaWx6RSYylgLJuJY/OcW5YO/IOZddbpFqkgmXTFUe6DcMD9oR2
 NwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687534224; x=1690126224;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mo56cbIAzhclFMowRG10ZzuD9iDal/F8QoPKUNo+8xQ=;
 b=WzsIDqhrgtKtxWrchQMTmwxFCkx9/TiumRY7iFJN9B4SoEQiQJkeaMGwM3ENCqdkMg
 8sUZqjv3g22N1o9tNE4+GKAAPEpZLwWBxk4B93Y0HtvtJXsx0522re3ansDbaBmC7qdl
 IpSFsQndv9I+EFkiQgHPeI1K4134F0ArP9exlCGXP+Q2PF829zOhD0T4Te9tE5OHql5K
 omhZJJp6KYVK2IqPjuzAU47Lw/M+LK1rY9FF836ZysFxPk8qnu9uiS86/iPTqSifZvuG
 tql112lWTJ1MxyRwvZr20FyhnOqyxQQZ/U8LhhBNOH7u2J7AkmZewLNYqrZv/Vs/BJRP
 33Nw==
X-Gm-Message-State: AC+VfDygoUcmgF2wG6WlfvS4JYAnFaOlVJOGNyxCtGjmQVjxf/UxMbR2
 N/T60fe4JjhtBG0axOgPgFC9nNdJUXplQJpZVtq5Cg==
X-Google-Smtp-Source: ACHHUZ5mjLOk6U3oPQ+KeyLpmTfg0cjokbBkV7bfs7fa+gV9eamc0P66ZrGJ+Vwyxn+MeDa5IcE12yJEuP+iGoD13yc=
X-Received: by 2002:aa7:c947:0:b0:51a:2c81:72ee with SMTP id
 h7-20020aa7c947000000b0051a2c8172eemr14096804edt.20.1687534223528; Fri, 23
 Jun 2023 08:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230620162024.1132013-1-peter.maydell@linaro.org>
 <87352ifbm5.fsf@linaro.org>
In-Reply-To: <87352ifbm5.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2023 16:30:12 +0100
Message-ID: <CAFEAcA8JD7ZJy+X=pccCHawuuMee9rdW78mReaG4m3R1xXkmKA@mail.gmail.com>
Subject: Re: [PATCH] pc-bios/keymaps: Use the official xkb name for Arabic
 layout, not the legacy synonym
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Fri, 23 Jun 2023 at 16:21, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > The xkb official name for the Arabic keyboard layout is 'ara'.
> > However xkb has for at least the past 15 years also permitted it to
> > be named via the legacy synonym 'ar'.  In xkeyboard-config 2.39 this
> > synoynm was removed, which breaks compilation of QEMU:
>
> Queued to maintainer/june-2023-omnibus, thanks.

It's in my arm pullreq currently on list, so if that gets
in first you can drop it.

thanks
-- PMM

