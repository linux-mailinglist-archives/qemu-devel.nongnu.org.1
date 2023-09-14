Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E623C7A09E0
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 17:56:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgogH-0002Dk-1n; Thu, 14 Sep 2023 11:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgofw-0001XY-IO
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:54:40 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgofn-00087l-SK
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:54:40 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-401d80f4ef8so12536835e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 08:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694706866; x=1695311666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZcF5/gSkiSoxCO096FcHnSr7utgTrP+2NsmOiiXXQE=;
 b=Jk2Tne8B38sri77kpoUBAy54D+qM1MvfhPmzYGIrVqbAEgdDdW8E1sxUR8tywyNazh
 YTzTqIzUET7Zptnv6GJFLXVJNYjdfAZQ84okWmzQr/AGM1yTC/1tYwE6keetUavyOrbu
 Fqsyj/tkIuSUI3XhvyKIdEQOSUrZSh8iv8FEpyt6XZTIBfLyrqTXO6wGwkLkYZasHApY
 Ti0wmRIoTpqLUiL+VPYZsjdGL/JJ14iV6HtdNxKrc9ZhgtaKOpPZaAXpLwxMe28/uNTz
 BGE0j80MY8jJbLhYVKo2BIagER4ohw7wLF5MvLgYarfitgzR0S3mwtC76Nis1l6QUQ3o
 ryXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694706866; x=1695311666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HZcF5/gSkiSoxCO096FcHnSr7utgTrP+2NsmOiiXXQE=;
 b=rDaddXZbzJHbkK0AuzyfoY6LzTSAb61rsbkolxwRkHZCprIyK7ndMhKxb+dtxHAFLw
 ObwjsJGwhuM9LrTy0HfPGxe0BCzEWsQv2ws91JUMB/HF59Mn+AAydMPLnKZvt4Vvpofn
 vYeXrbLXmTh/5Ddlxs1wUgEy3JCAaXcOgKAY+e5J+QXmhq8e4hpu5XEkBbstYA8bo60s
 QEVyalKMkAGyBpSVRc7EUV/NcFfTKdidAHFcJwSGWg0zorSTceGES4G3YIshw1X+ndcB
 hF4BwHCPv+pv/VQccjp4f9LMhWzROc+roR/gDlluZ85IPE3YRfo1Yxjc2Y97b3IklKz7
 13Vw==
X-Gm-Message-State: AOJu0YwkOhUW8pxWhTrLRUL+H8ei8eotB/OiE/Aa0qa1UxJM9Ja3MjDV
 7SeaOVrVv4x8ywEvVIoL10MBEg==
X-Google-Smtp-Source: AGHT+IG/tWW5Z2q7tX1z8PC6AZIIPCnI37Nw9aQAgY35Pug38fIRKdo9NA7kJ9g/TC0ogzHdJlsczw==
X-Received: by 2002:a5d:5148:0:b0:31f:a682:d27f with SMTP id
 u8-20020a5d5148000000b0031fa682d27fmr5416472wrt.67.1694706866513; 
 Thu, 14 Sep 2023 08:54:26 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a4-20020a5d4d44000000b00317e77106dbsm2075765wru.48.2023.09.14.08.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 08:54:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 02D6A1FFC0;
 Thu, 14 Sep 2023 16:54:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 5/9] qtest: kill orphaned qtest QEMU processes on FreeBSD
Date: Thu, 14 Sep 2023 16:54:18 +0100
Message-Id: <20230914155422.426639-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914155422.426639-1-alex.bennee@linaro.org>
References: <20230914155422.426639-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

On Linux we use PR_SET_PDEATHSIG to kill orphaned QEMU processes
if we fail to call qtest_quit(), or the test program aborts/segvs.
This prevents meson from hanging forever due to the orphaned
process keeping stdout open.

On FreeBSD we can achieve the same using PROC_PDEATHSIG_CTL, which
gives us the equivalent protection against hangs.

Signed-off-by: "Daniel P. Berrangé" <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230912184130.3056054-3-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/libqtest.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 34b9c14b75..b1eba71ffe 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -24,6 +24,9 @@
 #ifdef __linux__
 #include <sys/prctl.h>
 #endif /* __linux__ */
+#ifdef __FreeBSD__
+#include <sys/procctl.h>
+#endif /* __FreeBSD__ */
 
 #include "libqtest.h"
 #include "libqmp.h"
@@ -414,6 +417,10 @@ static QTestState *G_GNUC_PRINTF(1, 2) qtest_spawn_qemu(const char *fmt, ...)
          */
         prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
 #endif /* __linux__ */
+#ifdef __FreeBSD__
+        int sig = SIGKILL;
+        procctl(P_PID, getpid(), PROC_PDEATHSIG_CTL, &sig);
+#endif /* __FreeBSD__ */
         if (!g_setenv("QEMU_AUDIO_DRV", "none", true)) {
             exit(1);
         }
-- 
2.39.2


