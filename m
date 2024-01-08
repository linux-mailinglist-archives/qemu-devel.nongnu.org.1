Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 687FD8272B2
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:15:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrKO-0004K8-M0; Mon, 08 Jan 2024 10:14:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKK-0004GN-J1
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:14:08 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKF-0001c7-Sv
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:14:08 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e4b499b4aso1418595e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704726842; x=1705331642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2vXh+pSNK2Iht3pnXQCJkC17vaS5mbAQ1w3JtGP+qY=;
 b=oWZf1+8b2crFBvFf7ptRGSu05YyKKtSSPiU95RbOImfmPJc1j1vfOzMmJnJdCxS3m7
 /v7jkt7HcA6/Z+rwNmEKHHgvpNO/m2+XBip9sFqLR14grlw14h+mqMASqcYxKbwBQH5R
 VFk4CBoKDby4sWQ/N1kLLAiAZwz3y2I+kt48PfP1149/rH2Xg2g5o2ltV+IApV0V2FfU
 VMWlXMSPy0+bUisBykangTpzJDhNUnKVmXU6wTQb4UfdCLcAN5GGlwIKxP48rAav5gNF
 /5aEXv0qRp7I7BJXKilSmi6/76e9vNv3on/ot/jLwMPiJfs/zBSJZAdgljm2Yj0PlW66
 /QFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704726842; x=1705331642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p2vXh+pSNK2Iht3pnXQCJkC17vaS5mbAQ1w3JtGP+qY=;
 b=lml8cNW1kJ/o6tLOFO4vs6d5BSQbxJeePBMx/JkuRTKTm9F4ESpPCTrfA9IlTgE5Gc
 LIFhtggV1jqP5OPubJj7Es5wTVCJ82lhbOSvSc4sixeop7gt2KT2eKWmGalW4cUFMMpt
 1OycIgL6R29DsoAi7Yd1yaZ9Pm/v0x8GFGuBUWCljqKE/z9rUsbfOHp0fNx9LNgryXwP
 IadVz9BhbnGjke1EjVHi1BP3uFypGIEyziWOUnjEdiM05Ak8a5c54NT42eQ6WjE5DzCK
 Aeu2fCg5odNrHTgHQE0B475SmNKDgyKEVOJgW6Iwoy2xQYB8TnQArk0ueYIrVaPApQsQ
 EPlQ==
X-Gm-Message-State: AOJu0YwCt1J6Lf8JF5as4p1pyWZ+2h9FI6FdkbU+zejeUuftACSx8ul5
 iXdO+bzo7Wk8JgR0oAY0m+G6bG0LXHVwoA==
X-Google-Smtp-Source: AGHT+IG5MTn0OIHxrxPXOF2NFR8wTrImr7OnpPMnQJRJLZqh+I0ILiYlZPCHNp0xsyhTTeELdNUo0g==
X-Received: by 2002:a05:600c:4e8c:b0:40e:435b:4a41 with SMTP id
 f12-20020a05600c4e8c00b0040e435b4a41mr1573362wmq.89.1704726842394; 
 Mon, 08 Jan 2024 07:14:02 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 cg2-20020a5d5cc2000000b00336c120855dsm8018677wrb.84.2024.01.08.07.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 07:14:01 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DF2525F93F;
 Mon,  8 Jan 2024 15:13:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 12/13] chardev: force write all when recording replay logs
Date: Mon,  8 Jan 2024 15:13:51 +0000
Message-Id: <20240108151352.2199097-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108151352.2199097-1-alex.bennee@linaro.org>
References: <20240108151352.2199097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

This is mostly a problem within avocado as serial generally isn't busy
enough to overfill pipes. However the consequences of recording a
failed write will haunt us on replay when the log will be out of sync
to the playback.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2010
Acked-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231211091346.14616-13-alex.bennee@linaro.org>

diff --git a/chardev/char.c b/chardev/char.c
index 996a024c7a2..48f28881c28 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -171,6 +171,18 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all)
         return res;
     }
 
+    if (replay_mode == REPLAY_MODE_RECORD) {
+        /*
+         * When recording we don't want temporary conditions to
+         * perturb the result. By ensuring we write everything we can
+         * while recording we avoid playback being out of sync if it
+         * doesn't encounter the same temporary conditions (usually
+         * triggered by external programs not reading the chardev fast
+         * enough and pipes filling up).
+         */
+        write_all = true;
+    }
+
     res = qemu_chr_write_buffer(s, buf, len, &offset, write_all);
 
     if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_RECORD) {
-- 
2.39.2


