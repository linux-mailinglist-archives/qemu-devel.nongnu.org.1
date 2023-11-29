Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0D67FDF4B
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 19:28:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8PHi-0006xF-EG; Wed, 29 Nov 2023 13:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8PHg-0006x2-NY
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 13:27:40 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8PHf-0003s9-82
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 13:27:40 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3316d3d11e1so52401f8f.0
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 10:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701282457; x=1701887257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h7g6Xt7SqNUkovvZBvw7S7CNmc66KixrFa4G4GlHEy0=;
 b=QmjjyEXh3XVmhBMikJC+cNWuYyMY8qg7DS3C5gMZMzFXL376gRGIpw0dJem7w9dFOw
 2jwS7dWYFUvpg09AIm9OaUk7buvyojajwDWds0QQokOY/nA1lJinX6ZckwrWcMAS9mlG
 Jt72O8tjjNP+/DaXpsNAJefAUWLADuYDT31NeN2qrnh3B7QCPGSnOv7dGDpB+tpgn+h6
 bWLWSmDWa7Gg5JwJEnrB41D1pt/wIyAQguO/elWEAyAcE/iz6i29gAkN5dZDzlrgtQlu
 SRQEGkAopm5hovCDOK+L2j1rXAOZbn1oKtS6llNQail/wO0+hLdCnD7VL4VLTYfEkow2
 C71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701282457; x=1701887257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h7g6Xt7SqNUkovvZBvw7S7CNmc66KixrFa4G4GlHEy0=;
 b=nZQKV6EKjR+c4roZFyPr4I6pooYIlGWM1yWcj4vvIruTOjPVdjJW69PpoJXOBVCmVH
 YhttPDvt0DR8l0rLrrajtILn7m7rj6YDrMXJsXxf/FtWNthhNfDZGhtKM1MkACep0w4A
 if/0sfWCiwSs7MsBicJmAQrr7xXZ6xCSIm7X9wuzDUlJUQ9lGZi1LsKNH8/LxJHiMc48
 ksgecEWQ2EH7Kk9y3Zotv9H2H0IG1UWsyG/65xccDSJ+hAxsoTKnxFuhFWNTm843e4S8
 vxa6Ci4Yp9ZVVCQdISAk1QkToiW+xTrdkg9eMqZQu4pjUEoW45TE12JWBnrc4mOOXBGL
 aZ4Q==
X-Gm-Message-State: AOJu0YzwedW6bncwYDV+YV9qdea39IVKO4LIZ5P8g2lgNIPco94ia41n
 h8k9GmmZZIJPei9R2RQCOjyz4yUPU2anD9t1yw8VMw==
X-Google-Smtp-Source: AGHT+IHRJm2dlBuAqbicoxsjusNEyhuXvlLpeh0mteSE05tsC3sC19Z4gyNdwEVJ4/xBSEnVAKv6tg==
X-Received: by 2002:a05:6000:cc1:b0:333:1bc8:40f7 with SMTP id
 dq1-20020a0560000cc100b003331bc840f7mr1598889wrb.14.1701282457279; 
 Wed, 29 Nov 2023 10:27:37 -0800 (PST)
Received: from localhost.localdomain (28.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.28]) by smtp.gmail.com with ESMTPSA id
 m6-20020a056000180600b00332e73f8231sm16764163wrh.39.2023.11.29.10.27.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Nov 2023 10:27:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/core/cpu: Remove final vestiges of dynamic state tracing
Date: Wed, 29 Nov 2023 19:27:34 +0100
Message-ID: <20231129182734.15565-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

The dynamic state tracing was removed in commit d0aaf08bb9.

Fixes: d0aaf08bb9 ("tcg: remove the final vestiges of dstate")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c0c8320413..134ecb907e 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -437,9 +437,6 @@ struct qemu_work_item;
  * @kvm_fd: vCPU file descriptor for KVM.
  * @work_mutex: Lock to prevent multiple access to @work_list.
  * @work_list: List of pending asynchronous work.
- * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all changes
- *                        to @trace_dstate).
- * @trace_dstate: Dynamic tracing state of events for this vCPU (bitmask).
  * @plugin_mask: Plugin event bitmap. Modified only via async work.
  * @ignore_memory_transaction_failures: Cached copy of the MachineState
  *    flag of the same name: allows the board to suppress calling of the
-- 
2.41.0


