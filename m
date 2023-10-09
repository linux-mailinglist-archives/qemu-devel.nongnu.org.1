Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8482F7BD713
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:32:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmcP-0004BP-ND; Mon, 09 Oct 2023 05:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpmcJ-0004Az-Cg
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:31:59 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpmcH-0002nU-F4
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:31:58 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53808d5b774so7714937a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696843914; x=1697448714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mabujDx0DSImp/RgYxObckqCXl/9gkN8GQesN9V0wGU=;
 b=k+LYp5qHrb6ghSSMlfR94IwANtYj4Gkb+dgcWdx4MnS78YY55qoaPlRdzwZCcCzbch
 PJLOE2hdlcrC2NuyLFC8pjzYnLdHKStYvT7mKh21fKK1KfScIcrW+mrt5IVHtIVmg14J
 q0ZSta+doBzBgn5S2e71A2aqCwdLHOnQ1iHufavWE3/UMo/SboFRMKw+LlQJb0c947iK
 JSwJ1b+4nZkqBO33fNwF0UfIYOloThe+puqTWjmiOZxlTRowxAYIj/+0PyNQqHgXCmAz
 X78uEYbyNaW/FoeqnvFBxlVBK/VMP6iEUT6P543v7zcwtTSJcRbbI3EwG56oqD8K8Uip
 a0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696843914; x=1697448714;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mabujDx0DSImp/RgYxObckqCXl/9gkN8GQesN9V0wGU=;
 b=ucDHm3GnrdNvtPjfAoBLWzcIkgP15uxwmzGrqxLabbH2VTNMJD+x4MlMXavkY364LI
 /V9wTRS8EGcUNbglN3y9SEkW9GwC3QhfrOm/5B+sJV1JiTCTymMcaG44aSgu6fQfUcJv
 rmfFSRxQwhjFsed7TjPpfGAVszWmH3LCQWGcovuSs9onvTyq5fOwNYhsuuJod8fMHv5z
 5XWzsxHQ6GfELsQ5Z1fQnhnYgqdi4ySAIBiRiF7M7C92FG4Ki3qblfSjb5nGQRIV9aMu
 b4raQwsyI0nJTFfSAuj+mXnD3oAgZK2+KrpYSknx52kmx5YHVosddiM2dThPzj9MIyHX
 YqLw==
X-Gm-Message-State: AOJu0YytbQZUcVMLB64GvdNND//snd08sXW1G4ydnENLascUWtQHyG5w
 3L1LKHXio5Ld1Tn5+erOwj2uyBczNR2xmS5UI+Y=
X-Google-Smtp-Source: AGHT+IHxVlzTMthc6YwYqbWY/VRzxjdyt2Fhmliqx4wRDD7X4jTEo6/pzBGu5DN+qOQ1QRKKKG4yXA==
X-Received: by 2002:a50:ed14:0:b0:52f:a162:f4c4 with SMTP id
 j20-20020a50ed14000000b0052fa162f4c4mr12692315eds.18.1696843914506; 
 Mon, 09 Oct 2023 02:31:54 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 s21-20020aa7d795000000b0053613c8312bsm5907295edq.42.2023.10.09.02.31.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 02:31:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] system/vl: Use global &bdo_queue in configure_blockdev()
Date: Mon,  9 Oct 2023 11:31:52 +0200
Message-ID: <20231009093152.51270-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

Commit d11bf9bf0f ("vl: Factor configure_blockdev() out of main()")
passed &bdo_queue as argument, but this isn't really necessary since
there is only one call, so we still use the global variable.

Dropping the &bdo_queue argument allows to silence this global shadow
warning:

  softmmu/vl.c:678:54: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static void configure_blockdev(BlockdevOptionsQueue *bdo_queue,
                                                       ^
  softmmu/vl.c:172:29: note: previous declaration is here
  static BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
                              ^

Remove a spurious empty line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 softmmu/vl.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 98e071e63b..bc283b9fd4 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -674,8 +674,7 @@ static void default_drive(int enable, int snapshot, BlockInterfaceType type,
 
 }
 
-static void configure_blockdev(BlockdevOptionsQueue *bdo_queue,
-                               MachineClass *machine_class, int snapshot)
+static void configure_blockdev(MachineClass *machine_class, int snapshot)
 {
     /*
      * If the currently selected machine wishes to override the
@@ -688,10 +687,10 @@ static void configure_blockdev(BlockdevOptionsQueue *bdo_queue,
     }
 
     /* open the virtual block devices */
-    while (!QSIMPLEQ_EMPTY(bdo_queue)) {
-        BlockdevOptionsQueueEntry *bdo = QSIMPLEQ_FIRST(bdo_queue);
+    while (!QSIMPLEQ_EMPTY(&bdo_queue)) {
+        BlockdevOptionsQueueEntry *bdo = QSIMPLEQ_FIRST(&bdo_queue);
 
-        QSIMPLEQ_REMOVE_HEAD(bdo_queue, entry);
+        QSIMPLEQ_REMOVE_HEAD(&bdo_queue, entry);
         loc_push_restore(&bdo->loc);
         qmp_blockdev_add(bdo->bdo, &error_fatal);
         loc_pop(&bdo->loc);
@@ -712,7 +711,6 @@ static void configure_blockdev(BlockdevOptionsQueue *bdo_queue,
                   CDROM_OPTS);
     default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
     default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
-
 }
 
 static QemuOptsList qemu_smp_opts = {
@@ -1961,7 +1959,7 @@ static void qemu_create_early_backends(void)
      * Note: we need to create audio and block backends before
      * setting machine properties, so they can be referred to.
      */
-    configure_blockdev(&bdo_queue, machine_class, snapshot);
+    configure_blockdev(machine_class, snapshot);
     audio_init_audiodevs();
 }
 
-- 
2.41.0


