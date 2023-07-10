Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E08374DB75
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 18:48:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIu2Y-0004K2-LO; Mon, 10 Jul 2023 12:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qIu2K-0004Hi-R0
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 12:47:00 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qIu2J-0004RU-1b
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 12:46:56 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51e29ede885so5894603a12.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 09:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689007613; x=1691599613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hzXuJiN9pCFADU/dX+oImSpOI8tpQKMscKL4VxNjS/Y=;
 b=kG8qIupqPL7swRnNde8pNdHuYnzeJIHnDePL+TCVu6uZNCgQyW6fh9jfIUfqSenAYe
 hOYRycLEihYxTdxcKL7hxe1mW+dmTvlXPE2myFTB/ySZz1BqQIOA607pLcuRTRO0lRY5
 ttfpJyOt8l80RPxJBNRFJyjUlh/g9DNKUV1YRH5S2cP7YEyOIcwDIbd4UcUWpXaWksYb
 R2NZT0GrI564pHxwdl5gJ85JJk0uqGHjHw+fztbBWfxF0ubf22fJSsW4rtT0vUxgsgyG
 KfQ/pKdMh/Blye1/AeGoc4Q1TNEY/Uo0ab/TJzr4gClVuatZzHkGt2MI8vU1vj4VVmAF
 XzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689007613; x=1691599613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hzXuJiN9pCFADU/dX+oImSpOI8tpQKMscKL4VxNjS/Y=;
 b=VYNXHPPaHRtWjz8KPOZoawNXKR0BhDcoqiMmsNtqw517J7LDDLre5E27DykPt7kNpn
 ndFzZqyzSQXLONqfVtMZhgxAcNzgQzdF5fUzxIjD/Ccs+yrFigu1JVxmtNmEIVH/0G5v
 3Wswh57+7sFpEbr9l4+Nhi2lkvWgzgfsblYp7HIsfbdNzT/nxu6LbwnlfTrZn30r1oKJ
 OUv4MSbbGg26NFOWkEN+xLs7rss7E1aDK3zor7RnfWzvgIH6m7K3gXKMk0OsRTdufaAU
 1PFFhgpma9m6FwVCcImMo4CQSU17GioYbi837rNWxy89HxK7YkeHaR8t1O4ptLFEejP+
 +Wow==
X-Gm-Message-State: ABy/qLYs5r8l8zZEcC0Ii5q/AgV9GKyrnJue9rusxLyJGyfVzmDAiPxX
 jjxQhfZkXifsPim2jSwJ0RSHB3f6v3utduitXJDhdQ==
X-Google-Smtp-Source: APBJJlGur2clrAq5y9oUmZtpVnL1NK7jp1eRBU1xEsBwNKfI3D4EFh7CWabTYBAMbIZjnPztdxZT4neRkqcXIW0w3To=
X-Received: by 2002:a05:6402:2038:b0:51d:95f2:ee76 with SMTP id
 ay24-20020a056402203800b0051d95f2ee76mr12232978edb.27.1689007613161; Mon, 10
 Jul 2023 09:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230710152130.3928330-1-peter.maydell@linaro.org>
 <20230710152130.3928330-3-peter.maydell@linaro.org>
In-Reply-To: <20230710152130.3928330-3-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jul 2023 17:46:42 +0100
Message-ID: <CAFEAcA9=8y84p_fFQE1TYa4f=HoL0ypy=sf-sfUXtSRUOjVDaw@mail.gmail.com>
Subject: Re: [PATCH for-8.1 2/3] target/arm: Fix S1_ptw_translate() debug path
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 10 Jul 2023 at 16:21, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In commit XXX we rearranged the logic in S1_ptw_translate() so that

Should read "commit fe4a5472ccd6" -- I put in the Fixes:
tag below but forgot to update the placeholder in the
commit message text...

> the debug-access "call get_phys_addr_*" codepath is used both when S1
> is doing ptw reads from stage 2 and when it is doing ptw reads from
> physical memory.  However, we didn't update the calculation of
> s2ptw->in_space and s2ptw->in_secure to account for the "ptw reads
> from physical memory" case.  This meant that debug accesses when in
> Secure state broke.
>
> Create a new function S2_security_space() which returns the
> correct security space to use for the ptw load, and use it to
> determine the correct .in_secure and .in_space fields for the
> stage 2 lookup for the ptw load.
>
> Reported-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Fixes: fe4a5472ccd6 ("target/arm: Use get_phys_addr_with_struct in S1_ptw_translate")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

