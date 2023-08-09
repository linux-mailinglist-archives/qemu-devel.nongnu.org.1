Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B08776A1C
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 22:36:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTptH-0004LR-Gt; Wed, 09 Aug 2023 16:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1qTptF-0004LJ-ID
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 16:34:45 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1qTptD-000146-UP
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 16:34:45 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fe2d218eedso1693815e9.0
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 13:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691613281; x=1692218081;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3dsODYW+B5PeLwCUlqIs9FYG3OHgKJCzKu7xEC8wIc8=;
 b=hW9E3IX9wf97YKGDHfwB3jFrCMpwwqOXNM3i3PfllzmjJz8tEGuzJhMujNkzQdRUR0
 PtfYy7ZHWutsciy3hOEGoV2WyLB+fOsYSLl94zBpdg3aWq4cKF0hZN5YSr+rOMLqMugY
 HNHWzSmIKAngdZlfZS4xHXm2Fj1h0vLSZTknF0p82sLXQR62H4Hl7TojHRnS46cxIdaD
 vMxv1QXAKJARP/tIWCt/f6IFx7/yc9IK5JUzRwX0IWi3dyFzBhuzHg+ZhmI1Xr/jMBPm
 m838MXwLXwDE+RXoDW6SBpk51THqr3sOp5y35oKc5Mnb+L8xGI7DgSsQkr8ZGc+Mtu7f
 ISPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691613281; x=1692218081;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3dsODYW+B5PeLwCUlqIs9FYG3OHgKJCzKu7xEC8wIc8=;
 b=L44XKfCT6+jDg/O2nSqyr6TtCCCjMMfkfAoRsEr0s9ezzercqKxyps36uKmOJcCiUR
 92xLW6ELpnK6lW4UgYFqHPIr/MvxyYO5C6m8A7INO+WSSgIbJtNP57LbaawVsDBPehsx
 h4S1JNdRsgtVrV/PxCzFquAKhdKPMJBLXtiF95pyPyj6ezmTrKpFJfzEiXp3gAMnNMcY
 F+C6Y/xWbvxJvXzb64IeU/6Sk/e3WlIdvmFxjtLzrkZtlHRPhYj/Kl9lpRHKSf75TG06
 BVoNpDScyiuBWgFmJyU3DcZJYPukM3/iMP0G5NoOG8FTxreJ2JOgxHJlHR2jdqF0ybqI
 ZJjg==
X-Gm-Message-State: AOJu0Yz7EbyzbWZAzPIvZOafaMDTL7O/uhmtCQEcH5gNNJzborXYjrl0
 /emJqD5S+x3f9qInSVAZLut8oE3WUS0UZw==
X-Google-Smtp-Source: AGHT+IFXAa1vBwVp+ZsO6/j3NWEctf8Lb6pCECuRIYEh/p4sREeImKfJ8iUAdFTiks7YSIYWfHd9fA==
X-Received: by 2002:a1c:4b0b:0:b0:3fb:ac9c:e6f with SMTP id
 y11-20020a1c4b0b000000b003fbac9c0e6fmr167613wma.38.1691613281375; 
 Wed, 09 Aug 2023 13:34:41 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 fk3-20020a05600c0cc300b003fc05b89e5bsm8412wmb.34.2023.08.09.13.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 13:34:40 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Stafford Horne <shorne@gmail.com>
Subject: [PULL 0/1] OpenRISC FPU Fix for 8.1
Date: Wed,  9 Aug 2023 21:34:31 +0100
Message-Id: <20230809203432.424071-1-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The following changes since commit ccdd31267678db9d80578b5f80bbe94141609ef4:

  Merge tag 'pull-qapi-2023-07-26-v2' of https://repo.or.cz/qemu/armbru into staging (2023-07-26 07:16:19 -0700)

are available in the Git repository at:

  https://github.com/stffrdhrn/qemu.git tags/or1k-pull-request-20230809

for you to fetch changes up to 765fdc1e8355d4bae563b3b185c5f9d079384164:

  target/openrisc: Set EPCR to next PC on FPE exceptions (2023-07-31 22:01:03 +0100)

----------------------------------------------------------------
OpenRISC FPU Fix for 8.1

A patch to pass the correct exception address when handling floating
point exceptions.

----------------------------------------------------------------
Stafford Horne (1):
      target/openrisc: Set EPCR to next PC on FPE exceptions

 target/openrisc/interrupt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

