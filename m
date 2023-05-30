Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF9F7169FE
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:46:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42Tc-0007Do-IE; Tue, 30 May 2023 12:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q42Ta-0007DI-Sj
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:45:38 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q42TZ-0003b1-DX
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:45:38 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-514859f3ffbso6267335a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 09:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685465135; x=1688057135;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U9OoVmtBtifVAPYAGHIqRc0QgCbKza8ZHU5d3UDetPw=;
 b=XmA+yJ6gkyDQtrUJg+tIBnvEuJDXtaltHae3LjbK493BdUh2tEFzAxoerRlItgqNoW
 NCYwdk/ndwroxqKPRjejTNTG8DpXqH85oFGwxohVD5riCD4m1dSXm0XwgRb7Tml1qhBP
 QfA5JQwguxguE6Isq5mN8ZlAZBG4qhBpikIPqjt3Vgxl287pdTmWyQtDkfEVHZQT+TkX
 H8vNXvNncP9RqLxuH1l8ZosWfJAaE8+0GhclHPIffW7aVWFELUoHRmN+DaNSerACFCtW
 BH3/ra2NQtRBv8PN4tsa2nToxOZm+GmZbH9V9IOhBvMubW3/BmHvbBj7HPtc7m+7MAAZ
 JL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685465135; x=1688057135;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U9OoVmtBtifVAPYAGHIqRc0QgCbKza8ZHU5d3UDetPw=;
 b=OGVt4x8gSGrYm8JZxXm1H9U9ta1JlYtwMHmRRLACDgXSYM85FQBSY+S6xJYkq02/C8
 2rjWxngsZxAcnV9yn9NClYa58HZRiA/V0M3HEw5zR3MGTb2Eidc+b8d3JM3a2qXEC8QB
 9v41Xfg7gmM4vq8Z1PYCIw/pkvFmd3N+M1UtDXECZdkC5vfuysdqjEA2/SMuYjUAURg8
 HXYOQj6RzIXjdFSraX2/OEZGAd1pMdDsrczaxefEnQ0Tt318Kk/7+X9TGAWV0tFpgCbf
 i9gLF4WO5NhZyZAWZ/kTo2r1ORnzNzQ6vrSmwCsV5QSPn5xqR9sOs15IlajYs+MDOUHN
 ssXA==
X-Gm-Message-State: AC+VfDznyGTwJDhJrbNwEfxyOCIH9Pt/fkT9eLhlCd0Gkuard8Ow9p4R
 cbsFNMVmpUeX4XTI8hXnZtlPNPzemX/zFiKV/mjVGA==
X-Google-Smtp-Source: ACHHUZ7TERjs//ikShUkljz4dhSu5wn4zN09q3RO4LOjTbUYSeq61GbNT97Na1QbkLo5/eaB5sHqJS118px5XPIadMY=
X-Received: by 2002:a05:6402:7cd:b0:504:b6a6:cbe0 with SMTP id
 u13-20020a05640207cd00b00504b6a6cbe0mr1956712edy.12.1685465135479; Tue, 30
 May 2023 09:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230530135204.2903761-1-ardb@kernel.org>
In-Reply-To: <20230530135204.2903761-1-ardb@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 17:45:24 +0100
Message-ID: <CAFEAcA-RwXQWx4RhMhWk_xQLsJ0a1+MDKDXyKHdCmguqsuNKzQ@mail.gmail.com>
Subject: Re: [RFC PATCH] target/arm: use x86 intrinsics to implement AES
 instructions
To: Ard Biesheuvel <ardb@kernel.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 30 May 2023 at 14:52, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> ARM intrinsics for AES deviate from the x86 ones in the way they cover
> the different stages of each round, and so mapping one to the other is
> not entirely straight-forward. However, with a bit of care, we can still
> use the x86 ones to emulate the ARM ones, which makes them constant time
> (which is an important property in crypto) and substantially more
> efficient.

Do you have examples of workloads and speedups obtained,
by the way?

thanks
-- PMM

