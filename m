Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F04B982C12E
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:55:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOI0P-0007HW-6v; Fri, 12 Jan 2024 08:55:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOI0I-0007GP-4Z
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:55:22 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOI0E-00021H-Mk
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:55:20 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-558c781d311so835253a12.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 05:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705067716; x=1705672516; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t3yXr39w0RagCQMRTOSe1h4lFkE8h199jl/KjFwvJA0=;
 b=sjrn5hTuMXcxC3C1eOIFyTF3joe/VV5Nuh2WA9bc/8CjY0l1NgDZ6GXAvM9TWzw1/6
 Wf50o1fz5lS+/hSUG5weUAoppkPZzX5JUmUxOWj8hqmrLaHf0vgIxxPN5IWLNXfOyMvl
 jfiVHBfty/ZATQOzrzgQxUA0uUXC2BzMLV/hDfTFV6ckGeIORZ8yMkrrRwITJeAWywxe
 P588LA4Kb+YP8YzJ7HeDzBCvna1I7kvoiJ8LIOEHgTMguYjtghCzwXQkUeqqeAIF8Kwl
 cV2KXFEsW0VuueQIx1cuLj16sUNyQcAnRq8rgppfG+rWYAdSrCyYUfBNM++WnnatqnhS
 ltXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705067716; x=1705672516;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t3yXr39w0RagCQMRTOSe1h4lFkE8h199jl/KjFwvJA0=;
 b=b/LY0vWcbBifBKFJMLFUh4H4vkQGLn7NOYon6nX3kNzj4CAULZ+oLw7Mhjkq9toj81
 tmDQyByKUKCQnRr3bE+JrjghrbGq6MwylKL1VBqFAVATihOrR8uyqSvAeN0K6Igvh15N
 aEu5D9ghyRUS4Wb4vy7h1Bnjjd8CN280kkoiztEAJyC8mqGpSlaDZZ8rWdidpfR5KZbW
 PQgm6+drRr6Yi2+mNWLou/2rRbIiy2MIsRW1U79t/A3zJ/Lq4szrVRHrdl3SjCKkJ4gu
 p5C15YbfvqDZVRPEY+dAYPE+S+nFMRakkqHgeMbFq+3evvYqLm9bitjjOKOH3q5obN/b
 7+9w==
X-Gm-Message-State: AOJu0YxzHKKw1PEkCG5onk2pWV2Iesx8sFKDYik7FC/NinCssfaQaONn
 2ynR20IB+8C8E2cv/t2fUZjYIw35/TbrzWjVCsy+TQfdDPV9xw==
X-Google-Smtp-Source: AGHT+IE+nHMVOJizBcOMzpBw4EJRdXPJuFaR8vAVXDkouIJ6GTALMQ01WKH9SY1fHXOAajxeL9KUVHB4lkfvF+260qg=
X-Received: by 2002:a05:6402:1d1c:b0:557:aa16:1e44 with SMTP id
 dg28-20020a0564021d1c00b00557aa161e44mr659617edb.79.1705067715881; Fri, 12
 Jan 2024 05:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20240111051054.83304-1-gshan@redhat.com>
In-Reply-To: <20240111051054.83304-1-gshan@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2024 13:55:05 +0000
Message-ID: <CAFEAcA8k_Z3yLzTTxNhozd2yS7PSyKFp123F9S0ebDtxkZC=6g@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: Consolidate valid CPU types
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, philmd@linaro.org, 
 richard.henderson@linaro.org, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Thu, 11 Jan 2024 at 05:11, Gavin Shan <gshan@redhat.com> wrote:
>
> It's found that some of the CPU type names in the array of valid
> CPU types are invalid because their corresponding classes aren't
> registered, as reported by Peter Maydell.
>
> [gshan@gshan build]$ ./qemu-system-arm -machine virt -cpu cortex-a9
> qemu-system-arm: Invalid CPU model: cortex-a9
> The valid models are: cortex-a7, cortex-a15, (null), (null), (null),
> (null), (null), (null), (null), (null), (null), (null), (null), max
>
> Fix it by consolidating the array of valid CPU types. After it's
> applied, we have the following output when TCG is enabled.
>
> [gshan@gshan build]$ ./qemu-system-arm -machine virt -cpu cortex-a9
> qemu-system-arm: Invalid CPU model: cortex-a9
> The valid models are: cortex-a7, cortex-a15, max
>
> [gshan@gshan build]$ ./qemu-system-aarch64 -machine virt -cpu cortex-a9
> qemu-system-aarch64: Invalid CPU model: cortex-a9
> The valid models are: cortex-a7, cortex-a15, cortex-a35, cortex-a55,
> cortex-a72, cortex-a76, cortex-a710, a64fx, neoverse-n1, neoverse-v1,
> neoverse-n2, cortex-a53, cortex-a57, max
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: fa8c617791 ("hw/arm/virt: Check CPU type in machine_run_board_init()")
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2084

-- PMM

