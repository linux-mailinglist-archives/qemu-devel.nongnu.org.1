Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C6B76912E
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 11:12:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQOvj-0007la-R2; Mon, 31 Jul 2023 05:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQOvg-0007jL-1j
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:11:04 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQOve-0001Pz-H0
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:11:03 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-686f94328a4so2355463b3a.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 02:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690794661; x=1691399461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0QScuJRMU4ixMa/1gO5xg54HCFVlbOwEsTWMxlZ9iNs=;
 b=R5fBkwEMVaYXMy5KYwHGzehAFl6Wd2lg39Evu6jauf7SCxAkRHWtQaMWcizh3Cpsem
 s2GbeXG+cy4YHr0lArEgaGUyjInoKT+umizX3TMK33aWCbYXRE5Y87jKtGp85KMPepq2
 wXDqV0bDP1U9ckd3EyEUVCXq2QvdZW57RFTyOTSVhyqeLKi/xAZR6k/H53jsuGIa0xpJ
 /AjA3wNGxyee1DuScWTnooROU817g1DZjreT5jDNw8gU147GI7vZB3NepAFFqW4isXLo
 +q73x8e4eSeegKsW8RJ2zkzwQDaXb3OHmEtYNmFRGGMXaPkvKNa/rEuWXS2DXMsqfBNz
 hg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690794661; x=1691399461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0QScuJRMU4ixMa/1gO5xg54HCFVlbOwEsTWMxlZ9iNs=;
 b=J2IB5auhDeey7EljSM1zIrowA9snWL3949JgyRXnKQflQLpTzYz5T7nxdQSQB6xgNw
 WRMdPPiwKjqnFUDti8svlN7QOPaDLkkPY2tqsQx7oyjeC4JL0IEsyTt0JensygRpwG6z
 86B4YMO6m98YfFr2n9IKVibsN0BywP47lqxAEQ6H3tcyRwzKEltwfEMjW+0ACa+4l3CY
 rmLM7iY5AAkvYqG82/1iQw6tSjybHpXj6wvoX9cq6371z8jurmii7qcaWw1h5dNfejU7
 m9vnR0ix/Xy7itJjAjjiNyV5GG/NZ9GxLhECBHXPrdJCcOOdWMu1c3VTZ8fInIM3a8Zf
 Q73g==
X-Gm-Message-State: ABy/qLadu1lu+oIH1+kJIjNAJYRrxGQCGnwruFPbmds/xYTXI+ZTEup5
 7t5FyHaME+FCBVT0a6KdCO5RhQ==
X-Google-Smtp-Source: APBJJlGrOLJqT3pZnkX3SqIn+mqbTJRIWSFx1d0xOGE3sftLBhXpixRdd4Hn2FLKa/wgMbDVsV5Paw==
X-Received: by 2002:a05:6a20:431f:b0:139:cef4:936a with SMTP id
 h31-20020a056a20431f00b00139cef4936amr9337274pzk.21.1690794660849; 
 Mon, 31 Jul 2023 02:11:00 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 p22-20020a639516000000b005633941a547sm7714752pgd.27.2023.07.31.02.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 02:11:00 -0700 (PDT)
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
Subject: [PATCH v2 1/2] tests/migration: Add -fno-stack-protector
Date: Mon, 31 Jul 2023 18:10:39 +0900
Message-ID: <20230731091042.139159-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731091042.139159-1-akihiko.odaki@daynix.com>
References: <20230731091042.139159-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
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

A build of GCC 13.2 will have stack protector enabled by default if it
was configured with --enable-default-ssp option. For such a compiler,
it is necessary to explicitly disable stack protector when linking
without standard libraries.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/migration/s390x/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/migration/s390x/Makefile b/tests/migration/s390x/Makefile
index 6393c3e5b9..6671de2efc 100644
--- a/tests/migration/s390x/Makefile
+++ b/tests/migration/s390x/Makefile
@@ -6,8 +6,8 @@ all: a-b-bios.h
 fwdir=../../../pc-bios/s390-ccw
 
 CFLAGS+=-ffreestanding -fno-delete-null-pointer-checks -fPIE -Os \
-	-msoft-float -march=z900 -fno-asynchronous-unwind-tables -Wl,-pie \
-	-Wl,--build-id=none -nostdlib
+	-msoft-float -march=z900 -fno-asynchronous-unwind-tables \
+	-fno-stack-protector -Wl,-pie -Wl,--build-id=none -nostdlib
 
 a-b-bios.h: s390x.elf
 	echo "$$__note" > header.tmp
-- 
2.41.0


