Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 698367B260A
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 21:43:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlwth-0007vC-BL; Thu, 28 Sep 2023 15:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlwte-0007tz-VC
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:42:02 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlwtc-0007wE-Fa
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:42:02 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-690d8c05784so10697564b3a.2
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 12:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695930118; x=1696534918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=H3nrARKQhc7VC8DlZQXwJCKngWtw8wQPS0KJ7TUH4ig=;
 b=HHxfpdY2Hjo12pNqYlp/ehZ2KgN0IqCzXBUfq5SqCjpCXUSRefNpEoofS0wNrP0gfj
 F/zLEJf7CLSEwS5lnmUWXTP63uC+ZKWkZ6WhyLf9Ya6gj4uN4TmZCJ4o8GJ83CFOGk+V
 LlnGtq4Y8MsBjoFDxu/GNk64X5rWXBbINn23Kyoz5lWnTkmZCc349qIBvZRdbKLXdVze
 FyfZaKaKBf5L/MKLlf3rBZH9+Bu4xV8XiCGRT85bV9TpbnXu9Rg8HJk7RosMRE8LTKFs
 p+hJ/KTEBa6ABMg3mAZW28mRWSFivEKqYvbGaqoehDnBWDSdQ0teNI6/AI9e9++wUS2s
 uGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695930118; x=1696534918;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H3nrARKQhc7VC8DlZQXwJCKngWtw8wQPS0KJ7TUH4ig=;
 b=OlD5FnouRr3pK1mRWdYVpBPuc1nq0NouZzm5YXafFZ6T3awAwO3HzDYkYC2eagbH0P
 leZAo9mdO57gcBPdzKa/+tzzMfg+X+XEgRy9TKRCW6t+WNMDUIIYrycwAZcYfPK9uQc5
 V5G4+SeJkJ24yzZIkgsHNuVNZBXe9rJv8DIREJF7c0Arj1W+xNq6HKKTtrYtb3vPAIUx
 BNyUBfze0j1v5VurKIiZ7H+xcSVLzjWPh22lnATX1LPabpSnCe20yd2CNIdvHH55CWW/
 mSh6BnWRkCqN37l9Dp8hA2qMSYlybp5XSk3LhJtWTmX5SKe35DiFNRDjDzBIFcG8rqbV
 41eQ==
X-Gm-Message-State: AOJu0Yy0O3W3TJevT797o5+MbJRy+p6cpSlCXF7dx7lrY94ncnd5vItC
 MVvJtqJVHF6muaYgxQbNXO+SGNR93fS/RZFefQo=
X-Google-Smtp-Source: AGHT+IFSudI/+7l85TDqjhuEgGh5w809+y50tzDhFdFb1DIXNlcDtVj30bbbWabmeDrvpQtzd0/tiQ==
X-Received: by 2002:a05:6a20:5490:b0:161:5ea5:fc0b with SMTP id
 i16-20020a056a20549000b001615ea5fc0bmr2489838pzk.16.1695930118247; 
 Thu, 28 Sep 2023 12:41:58 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x23-20020a170902821700b001b80d399730sm15273450pln.242.2023.09.28.12.41.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 12:41:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] tcg patch queue
Date: Thu, 28 Sep 2023 12:41:50 -0700
Message-Id: <20230928194156.237351-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Mini PR, aimed at fixing the mips and ovmf regressions.


r~

The following changes since commit 36e9aab3c569d4c9ad780473596e18479838d1aa:

  migration: Move return path cleanup to main migration thread (2023-09-27 13:58:02 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230928

for you to fetch changes up to 18a536f1f8d6222e562f59179e837fdfd8b92718:

  accel/tcg: Always require can_do_io (2023-09-28 10:08:13 -0700)

----------------------------------------------------------------
accel/tcg: Always require can_do_io, for #1866

----------------------------------------------------------------
Richard Henderson (6):
      accel/tcg: Avoid load of icount_decr if unused
      accel/tcg: Hoist CF_MEMI_ONLY check outside translation loop
      accel/tcg: Track current value of can_do_io in the TB
      accel/tcg: Improve setting of can_do_io at start of TB
      accel/tcg: Always set CF_LAST_IO with CF_NOIRQ
      accel/tcg: Always require can_do_io

 include/exec/translator.h   |  2 ++
 accel/tcg/cpu-exec.c        |  2 +-
 accel/tcg/tb-maint.c        |  6 ++--
 accel/tcg/translator.c      | 72 +++++++++++++++++++++------------------------
 target/mips/tcg/translate.c |  1 -
 5 files changed, 41 insertions(+), 42 deletions(-)

