Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0DB831D23
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 17:03:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQUps-0000Mv-Bs; Thu, 18 Jan 2024 11:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQUpm-0000Lz-OF
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 11:01:39 -0500
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQUpk-0003NJ-Bt
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 11:01:38 -0500
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-36082f3cb06so65402955ab.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 08:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705593694; x=1706198494; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=x5X4YcT9prlABXPd8UKGf6RGtzL8oql6ecMJ7mRJ9VE=;
 b=PbA00OF5InbzRm1gbHRTctEX+WFEihfmAqfuGA3zyjHaZ7j6lPi0Hvg4rQAeL8UbE9
 xNqC/tWPzOR5jtHMNajVSedCJfZtyyrkQsyM30PDW4TljMtw5K5vdTAdoxgbsw6KXg+5
 GBhHA6TlQ9PQ2sBFLVdsrhgkiNIgbqdXoZRAVeKi77cAdDoDe/7o5SdD7t7rNEMJX1Xu
 FB+xpYs+YfrRMB6inAkF9GFIoi13/9VeIi+F2y7Qbm3fUkz/c/DcMV7cJn/MCEsueala
 hXqtvLKGfJvfvaa9ENT2mTZiR4hiaLO432b1aWH9WDOKX/eQRo8GPKpRjEF/qN8bGEQJ
 rwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705593694; x=1706198494;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x5X4YcT9prlABXPd8UKGf6RGtzL8oql6ecMJ7mRJ9VE=;
 b=X3a9TcWEZPi812S3zfRYAnPqmv5m67Wkr8B/6dAgMB38LfJwUOa5yHmDnw5RFZSagD
 jtcHh5qs99W+WgMRRBZIAkf2PI84I1yrXWJ36dwfO2DCYOB7choUQq39+GPvkT/l/TJm
 lW6D1Wk3NgjfVFHseLDjN6VGjlwOeS4p3rySWgfmIwD50KtPu3YRlp1iYQsgHPeiTojc
 JT8Sosrq6tqpQMKciyFi+CcV5i7sBt9Hvixo50/fz/e2/t0GbIQjO17nBrsCr9Fi2nWn
 N4gKgvCL8NU3+llLVvCbU41yytRguf6CIx1boDbOBa/A1SW+IC2t2REXVKJ8aO5sSn4G
 2FeA==
X-Gm-Message-State: AOJu0Yzlobwa28J0Iw6k81ELMCpcH+0Y/qLrAh53wOF6GG76x/elru1q
 H45kFFxxjNnAp6sAptNr3V/yIBDihl1kDC6VvZOQAxf5xYMdxYrwE2BG4aMxUw1kYlGH0I2yIfc
 BUGvbK7iAbSqdFJdpZz5VAj7flmxyapxve6I=
X-Google-Smtp-Source: AGHT+IGxzzOb7+KLoimOZjsiX+6NuXZmSHhU2x4CwXQQHguN6QDBBlWWidzQlTKJsCKg+HQAzEuecJjOgTZ75KWSNPQ=
X-Received: by 2002:a92:cb47:0:b0:35f:ed80:9c7b with SMTP id
 f7-20020a92cb47000000b0035fed809c7bmr1167817ilq.44.1705593694691; Thu, 18 Jan
 2024 08:01:34 -0800 (PST)
MIME-Version: 1.0
From: Manolo de Medici <manolodemedici@gmail.com>
Date: Thu, 18 Jan 2024 17:01:29 +0100
Message-ID: <CAHP40m=UQ=F1-Vy4-wR18RjqzF9o+8UOjgpUsrTU8QXn=7eAeA@mail.gmail.com>
Subject: [PATCH v2 0/4] Port qemu to GNU/Hurd
To: qemu-devel@nongnu.org, bug-hurd@gnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=manolodemedici@gmail.com; helo=mail-il1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Recently, a testsuite for gnumach, the GNU/Hurd microkernel, was developed
that uses qemu. Currently qemu cannot be compiled for the GNU/Hurd, as such,
this testsuite is available only for GNU/Linux users.

This patcheset allows qemu compilation in GNU/Hurd. With this patchset applied,
qemu can be compiled without any special configure options.

Please review, thanks,

Manolo de Medici (4):
  Include new arbitrary limits if not already defined
  Avoid conflicting types for 'copy_file_range'
  Add the GNU/Hurd as a target host
  Exclude TPM ioctls definitions for the GNU/Hurd

 backends/tpm/tpm_ioctl.h | 2 +-
 block/file-posix.c       | 9 +++++----
 configure                | 2 ++
 include/qemu/osdep.h     | 8 ++++++++
 4 files changed, 16 insertions(+), 5 deletions(-)

--
2.43.0

