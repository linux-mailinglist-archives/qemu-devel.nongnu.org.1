Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AC276912F
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 11:12:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQOvh-0007l1-DM; Mon, 31 Jul 2023 05:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQOve-0007iQ-1a
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:11:03 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQOva-0001PN-Qu
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:11:01 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6bb07d274feso3406662a34.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 02:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690794656; x=1691399456;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=stHb44EFqAwCnYucBnH3WIBdFRhGcLwC/3ZzkYUmkbs=;
 b=Q8tVCvhLOWvSB/8QNgYeM5Z0I8naMqT/1ij7ZGBWEEShascjfRmzwv2u1pBqn2ubZN
 sN5vmeP2lfgflSTXpvqpXdOreoJHokt8swb6yyS75B+4LTx+CIQrm4IeSmZtSudKQig4
 TipXt5nZ9QSOV9bjQClJIDDxKsbE3Xkyk3jLz7jbhRdEjZc0PzGtk8tDDNi+uiNPvN6m
 DrdiYQPyw7evBiMTteSz5y3nHbSucsGiC89/rR94OmJAKEvoVGNzj4jmRtLP9hOwuu0i
 54YGCKyJ6NKp/a3zX+0uqJHbX0ORECl1c/0BikhKb0nMmb/ejbqXwRg+rLyweWpk5oYD
 RYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690794656; x=1691399456;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=stHb44EFqAwCnYucBnH3WIBdFRhGcLwC/3ZzkYUmkbs=;
 b=J/MbJJfcYjc0Z7pQM/Fc0E07AwYV4DfAJcUWjGV1aJRJlUlE7SAK5xUxJPY/ECzBU/
 JP3JrN2AoDXR7PH9SRG6ZSWLhuUIVYicSkGn2HQgtbtFATBYRXDB4Zt+/+ef1m52S1rr
 ZdW+vcBz7ol7oxILF+toRRNjZ6FUmd7SG0rf7J4xUWmst7LlRKF3+55Ms0fh+0X7fPbc
 6iAMsd4FXWIWGTAkZ6t33KwuPTLxdICX8YAYQ7Th1tGu5Zh0epyXqivenFJF9uZ/BjSn
 NNsxajGyMQRQtpUrlmVDDBOnJ8LngZQ+i5g6HzRkb48cjT2Iw7uliwwAP624fndFipMD
 sdbA==
X-Gm-Message-State: ABy/qLbYCmLmbusCJKIKmTN6ka7yAHQaNiDGy366uOaL0e4rJdDME39i
 A601PW4nWr7Hd4+lpiJTcmDtrg==
X-Google-Smtp-Source: APBJJlGbbL4xERGnny20VCy/wPqtT8sQofkZCKoZmTxDqVad9O03Go5TmTeBhf135zuLlLJmb5j+oA==
X-Received: by 2002:a05:6358:7e9a:b0:139:a0fd:780a with SMTP id
 o26-20020a0563587e9a00b00139a0fd780amr5945500rwn.12.1690794655548; 
 Mon, 31 Jul 2023 02:10:55 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 p22-20020a639516000000b005633941a547sm7714752pgd.27.2023.07.31.02.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 02:10:55 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/2] Accompany -nostdlib with -fno-stack-protector
Date: Mon, 31 Jul 2023 18:10:38 +0900
Message-ID: <20230731091042.139159-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A build of GCC 13.2 will have stack protector enabled by default if it was
configured with --enable-default-ssp option. For such a compiler, it is
necessary to explicitly disable stack protector when linking without
standard libraries.

This is a tree-wide change to add -fno-stack-protector where -nostdlib is
present.

V1 -> V2:
  Dropped changes for pc-bios as they already had the option. (Thomas Huth)
  Make the change for softmmu tests in a central place. (Thomas Huth)

Akihiko Odaki (2):
  tests/migration: Add -fno-stack-protector
  tests/tcg: Add -fno-stack-protector

 tests/tcg/mips/hello-mips.c       | 4 ++--
 tests/migration/s390x/Makefile    | 4 ++--
 tests/tcg/Makefile.target         | 2 +-
 tests/tcg/aarch64/Makefile.target | 2 +-
 tests/tcg/arm/Makefile.target     | 2 +-
 tests/tcg/cris/Makefile.target    | 2 +-
 tests/tcg/hexagon/Makefile.target | 2 +-
 tests/tcg/i386/Makefile.target    | 2 +-
 tests/tcg/minilib/Makefile.target | 2 +-
 tests/tcg/mips/Makefile.target    | 2 +-
 10 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.41.0


