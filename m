Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6487A21FE
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:10:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhARV-0003Nw-19; Fri, 15 Sep 2023 11:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qhARJ-0003HS-HM
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:09:02 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qhARD-00029D-Ar
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:09:01 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31c3df710bdso2082234f8f.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 08:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694790534; x=1695395334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ODBQ1lRWFRqN+1C2qyimy7vJFOa6KXmE7+4RiDeBuo=;
 b=zGOEaIPmSn8BaOw8q1kBbaL/FklbHxMxGOh5+lGt0leQfYgMtTHYgUxJl9X3dVLx7o
 vgx92S0BfRrPVGLoWi8jk/1uryIhbf9kM0JLxC/SyzE4s2nr0TFi06PJ7szX5OgiXwBx
 BcOP6gOTiWKQT7iUQofcMyX9So2S28ALg2LP81vfqvLGuNylKyqbgrR7UaH94OdNUlKR
 9EQjJuvLTfdymOTD5aSLldZHyVikfFed+bGaBYVcSI6BxS46F2BaVFyFCmEnRSVyCdvA
 ozf0AZD/eZPSKvtQy49q7xIttjjzrPXfJ3QgvpuHrqJXX7Ex+hWp2kOUFU6jh7IiTF6n
 9UBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694790534; x=1695395334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ODBQ1lRWFRqN+1C2qyimy7vJFOa6KXmE7+4RiDeBuo=;
 b=kKWSLNyGfJCZihHVT0OdnwvcMF9kKqyH69T1J2lPhUtOHaXvG3wHhtaqAMa+GbQaWH
 5DJMDv08HzXOwXn+qQ28kHMzlSZhX08hD9R9+HNoQpuN8nH01bnzE7MOwY9GMzssdmIY
 y3P85KtJtqGsl6GXnJcP0SAKDbTl2pocGM4pw7CllUvKYTCKAplfesA8jSrqYZ7fEy2f
 bEYoNwTsxkQCHyG5vnQqBS8H6EZUp4ERUUlZiWASnx+IrUWOXtsekdhOTY+yCtWqRBF/
 n26YomhKf1wKPu4iBYJJ/maOq5Z6AwyuURfU/eC/9rW/5UXCxiijsSZvHGV43LRs8ATn
 1mRQ==
X-Gm-Message-State: AOJu0YybDMPg60Gw0Hw/Gz4nrU7thPdUVLQsUDnVCGl7ZFUjCcxqF70q
 /wZq4wOMxdW5R0/QFuyR0gNMAw==
X-Google-Smtp-Source: AGHT+IFSARjg74SrDEenopMLZJb73Ny5yxylkiCPdD9re5ISVvGDQ3o2I3VXIO6Z94lgR0p9GqphpA==
X-Received: by 2002:a05:6000:a1a:b0:31f:facb:e1ba with SMTP id
 co26-20020a0560000a1a00b0031ffacbe1bamr283441wrb.70.1694790533714; 
 Fri, 15 Sep 2023 08:08:53 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a056000018700b003176aa612b1sm4653970wrx.38.2023.09.15.08.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 08:08:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 79AFC1FFC0;
 Fri, 15 Sep 2023 16:08:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 5/9] qtest: kill orphaned qtest QEMU processes on FreeBSD
Date: Fri, 15 Sep 2023 16:08:45 +0100
Message-Id: <20230915150849.595896-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915150849.595896-1-alex.bennee@linaro.org>
References: <20230915150849.595896-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Message-Id: <20230914155422.426639-6-alex.bennee@linaro.org>

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


