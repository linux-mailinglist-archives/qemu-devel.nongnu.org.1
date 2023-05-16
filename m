Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C416D704A2E
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 12:12:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyrf2-0007Dd-Lq; Tue, 16 May 2023 06:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyrf0-0007DC-Tq
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:12:02 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyrex-00059H-Og
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:12:02 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-50bc0ced1d9so20406419a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 03:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684231917; x=1686823917;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WygLdQMdN1rlePQOoCk072TMogyRaOR7qohsfKBqRxw=;
 b=SIyFR7mtlQTKf7ThH/E1qtXvA4cbekko0XfDh+Lzj6yOiKkFS0RjkIdoH2Kkeejjyi
 Nv8qt2kvXL0xwFal2oqhzRkl9nvNrx+n4ZFr8cRUXvxAWzC982i3XV0VYtTi4/J4cBV6
 bC40E1JFthD5vCYOQwzCud+awgS7kyPpWDWIv+9ZhrBaqRH2A5aj1QtZ2Go5Kii4M2BI
 dXLu5PMqX3RAo+yCwKkHOWD8nhjJFjCIaDCtNw2hZ8pl1JypRHOww919+DaZzXb9QSjy
 Y7RsUCDBqFchz5Xe4ZOQybHg55jr92DktKBWFU09q7P6eA/ztlQRUY2TC5MQKQwIorvh
 nc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684231917; x=1686823917;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WygLdQMdN1rlePQOoCk072TMogyRaOR7qohsfKBqRxw=;
 b=dxcK9x5aYZ2EEI+DfB8qCtI+N03y5TOuH3a0Ft/z058g6VwAgYk+nDtvjJ84kaeE4X
 aoqAOADoS1mJ1aL0WcS8HRKg/nKnckWJvLdKLf9edt2yIS2UqvPoDerwimg4Jvgx+qdX
 3kTEfwIDZBW4n5PWTJeHe8bqZcnKmyJK7MTx/rd1UmqkcQO0z2vPY1HN3GRQ4MJyTSjI
 5SHRAIKwdPBuddsCJz667S+crRJeNsrrsRJRHg/gWQN/WHTh1uGpE0sb0m7/2Kjj7mnu
 iKDFMdEB9P8atPL1Oj9j6FnFYt+wwLNocantKf04B0ZfVbjr9+Lk1KEdqs7NoCdxwU9W
 ULvQ==
X-Gm-Message-State: AC+VfDxuk6Y1cave9NuRvIOrNyhZFzbGQj+oPi9wfjxR57Hh72o4xbGW
 +CAZ6DKwGL1f6DBIdcOvmwrV0Z5/Ql1R8ijD4CDMRQ==
X-Google-Smtp-Source: ACHHUZ5vwfzBfjmy46NhXRsE/l5Hs05zY2wx1KBNUzDlCj4d8Z6XmZsKH9Tcwz2WReZ6H88+Qp0iJpyu0xo4e44E5Xo=
X-Received: by 2002:a05:6402:100b:b0:50b:81bf:9e4f with SMTP id
 c11-20020a056402100b00b0050b81bf9e4fmr26011848edu.12.1684231917359; Tue, 16
 May 2023 03:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-41-richard.henderson@linaro.org>
In-Reply-To: <20230515143313.734053-41-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 May 2023 11:11:46 +0100
Message-ID: <CAFEAcA8pLTxuy3WeOsWczd-_ErioQAuRUg9ZbpU2QWhaGKJ7tQ@mail.gmail.com>
Subject: Re: [PATCH v5 40/54] tcg/i386: Use atom_and_align_for_opc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Mon, 15 May 2023 at 15:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> No change to the ultimate load/store routines yet, so some atomicity
> conditions not yet honored, but plumbs the change to alignment through
> the relevant functions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v5: Removed r-b for changes to HostAddress.
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

