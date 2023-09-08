Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4FE79880D
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 15:44:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeblm-00013t-T6; Fri, 08 Sep 2023 09:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeblk-00012C-SO
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 09:43:33 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qebli-0007Rt-FG
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 09:43:32 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-529fb2c6583so2774188a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 06:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694180609; x=1694785409; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nRX8puxy9wVPB8+ZeOjrrhi7EZjOnzEgpEc6gfutF4k=;
 b=JYX1myjOX3C3SK7bNdq0MhrKy088qn/Owrm1WP3h9rR5bi3mzn62uwmlNd0CQWbruJ
 HJE5l89j7bRm11vPalMtY81ZF00KqrpBZ8TbijRm/xUy2egzZ/Y5JUBWP5ubrsfWg5Ck
 yaz5A2Ag3c3FMh/Is1S5HuWnAI6oa2C3OcRBOkcmfkaaGKVxZlXd9rQqjUizrELdBrFd
 I/Y5zGE9T7giXM7i8CjSjfDLAC6RyfuM4rD8ihjNcCgLESvPwaI/ZRhZ8pbzJJDthdxu
 qNGzMcnwjsaoNPHPrrBTCRdOppNGdySMylP296IX1pxG8egaHICrbAblcPFml2ziXN72
 hJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694180609; x=1694785409;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nRX8puxy9wVPB8+ZeOjrrhi7EZjOnzEgpEc6gfutF4k=;
 b=aJTZKVQzBS6eZ1+Mff/4q/i4wTi5qtME4P+7NEdfVJ9mf3gZJvs9esmec39w+vNcki
 2pWMJIgMCTyxufy8lb2XwXoNPjBzpIMbYs6V06qZdL/bHNelc7d2vkYqgno1KQZLkxZ4
 pn5ednxjGBUTjOWXSMouU8ywwmWbMbVZ9ZEzntnXuLz33W+guItmtSahDWgSYAPmKPWB
 UrK//yLlgmG+941u6zm5uFdP3FeCsJqcYfOxW0w/XwFQW3sntusPrjWNcwiZYs5EnmdM
 ek3auzwuUzeMsNDJJbFJdozfZwXxzJeGUzUgFDr75TDYxkzHhcUI4JfekdLF7oLCNZpV
 /r2w==
X-Gm-Message-State: AOJu0Yz2c4hLYuzu/n/waevD7HD2JKRj2GYILwyBBS/8aEWPqWiq0Wq/
 wTUVof3hqa2v3/Yg5h4z8bIiU1t8u0Mdc7OXAFni9xP41qc8jChc
X-Google-Smtp-Source: AGHT+IFHz5aTHgmzhZYBqLuPYygUlmKoazkdpFGFlA81GAfwtjM287Z+6/SF8dvMJF0akBfOAdOy6mfc32eMU5In5LM=
X-Received: by 2002:aa7:d1c6:0:b0:523:b37e:b83c with SMTP id
 g6-20020aa7d1c6000000b00523b37eb83cmr1999743edp.37.1694180609036; Fri, 08 Sep
 2023 06:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230831232441.66020-1-richard.henderson@linaro.org>
 <20230831232441.66020-6-richard.henderson@linaro.org>
In-Reply-To: <20230831232441.66020-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 14:43:18 +0100
Message-ID: <CAFEAcA9q+ie0Fuaeu4RVU=wX8+JEw=u+i-YuSkW-j+rjPkeUOw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] target/arm: Enable SCTLR_EL1.TIDCP for user-only
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Fri, 1 Sept 2023 at 00:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The linux kernel detects and enables this bit.  Once trapped,
> EC_SYSTEMREGISTERTRAP is treated like EC_UNCATEGORIZED, so
> no changes required within linux-user/aarch64/cpu_loop.c.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

