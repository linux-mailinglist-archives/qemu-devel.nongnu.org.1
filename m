Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2D8704F7A
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 15:38:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyurQ-0005Rq-P6; Tue, 16 May 2023 09:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidhartha@drut.io>) id 1pyrsE-0005ud-0H
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:25:43 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sidhartha@drut.io>) id 1pyrsB-0000xi-Oe
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:25:41 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64ab2a37812so4383853b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 03:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drut-io.20221208.gappssmtp.com; s=20221208; t=1684232733; x=1686824733;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DC6gL4A336Rrj+81Wn4CSqITramG+K7uwC7L5/oB9cc=;
 b=ixcIHoXtldCR6jpgtamg65RPYkd+HrupAa19ulvZwZHOBlFyOrZk6tbLaAzFjOPTvN
 YfSF7hEaLEcP0DeqwKGMVT/MrLLyB+B37/kISM/P7+VCgzP4PRG1wUQWQ0fWbq6ndFn1
 3h62sj5It7UzkjhlxgRbAdJsxpXvSMpZHSmMVet2Pl1grNqBBZDsz7TduT981rLyMlXn
 wtWoLi6m/+q3VdBdgB8y8FUI4SgKKHFk4shTYdIiwGY0yK5cE0lhPKD1TYS+5e/f/i/G
 x9vfrLnBCmBQStdjvTiP+IxIBqjy7YL/soAU+4OtloytGpTzOAcexWGnsR4oCpf8fEJY
 nq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684232733; x=1686824733;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DC6gL4A336Rrj+81Wn4CSqITramG+K7uwC7L5/oB9cc=;
 b=MzpzImI3GkFagglTcchrttcgRC7GipfC8YpdSGjqFdVuPLyVeE46PmIhY8L/sIj8Xn
 5CX4Lk6v5pVMoWWIsbcmvonhUCgGukg2AULbGfPu5H0s5N/ivB6CPzBIwcnPuYlDwDNq
 QoVTPK1mhXlo/aHxWmgwWGZPrJ/1qVWVyigB3QbsCWTCAJX5JTidbb8xI7X8+RxvB8vu
 3ZGs41sTJ5k1HtezvUnYMnHS2zns2zdJNDnR7UbMWaF3AMe7wCownYXCDy9FpWeEZW+9
 GxRTEunFRwQxi/FD1srw0X5aSVad8SqAul8yajfOyvrzpNOOsb3yuF2fPBerGfuuFmzr
 WYvQ==
X-Gm-Message-State: AC+VfDye/HSP4QMjTps2A4xxATxlyKvE+P2YhsHlvP3SwP+qfBRJuYM2
 h8LTrToQSxq6X7ou2KYB3PotSI2VyU4qQQKKQazshRuzDYQWBlaNsAvH
X-Google-Smtp-Source: ACHHUZ4NlEkLp+1cXODZAZxLlKBXnRkPgktWQJyLoVH0GrFW+MyhJ5R9nV1ckS5qeDEMlg7yNRHTIgdEdPn4VKDUjEA=
X-Received: by 2002:a17:90a:5d13:b0:252:7372:460c with SMTP id
 s19-20020a17090a5d1300b002527372460cmr22744551pji.4.1684232732991; Tue, 16
 May 2023 03:25:32 -0700 (PDT)
MIME-Version: 1.0
From: Sidhartha Reddy Kaliki <sidhartha@drut.io>
Date: Tue, 16 May 2023 15:55:21 +0530
Message-ID: <CADfM=uvE+DdOAVU-WZmNgiAPom0isN9OFUeky0pPqPbtFmvyRw@mail.gmail.com>
Subject: How to communicate 2 guest machines over serial in qemu?
To: openbmc@lists.ozlabs.org
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=sidhartha@drut.io; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 16 May 2023 09:37:02 -0400
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

Hi,

We have 2 independent devices running openbmc software on each of
them. These devices can communicate with each other over a serial line
using SLIP protocol. Now we would like to emulate the same using qemu.

Do we have any provision to communicate 2 guest machines over a serial
interface using SLIP protocol?

We have tried a few options which are not helpful to solve our purpose.
It will be really helpful if you can provide us some guidance on this.

Thanks

