Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FE4805FA0
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 21:42:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAcEE-0007P0-91; Tue, 05 Dec 2023 15:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcEC-0007O7-6r
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:12 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcEA-0002EQ-K9
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:11 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40c09dfa03cso31556255e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 12:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701808869; x=1702413669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HnFX18BuXkPwEMWcuTq2Q3z2S7wJ2zXOceAR+u2p7TE=;
 b=C/zvzn2z68MiVokrTzVTcNKkYTYNW/laIB6VRsVmB5klgvMZGnr2UKyZ9KGxLME3ly
 38SRMyU1WsRVQ/d+kODZJ4lqC/T++qFwBgFCw1LNelboQWnOLgC+U8WxuaWWPB/2JJfQ
 Ye9CQYZ2mo7fSHcZGN5qiLDr/by7/RJ3jAxiPwB6AWrZ9n7a4lyKbZRqmliGTXgx+geG
 Fy2oExp775UNMYwSevFpGWyzElvuyndSsjCqzEMnybz5Al2huwZb18Z5MfUM7EXGL/N7
 13sHWYW8eY3UcG/GmfNL/5EWP6nCvtZAeS45t9NJJmE3gKRaGmMPbyPuXFZpoxgW/m/x
 ZTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701808869; x=1702413669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HnFX18BuXkPwEMWcuTq2Q3z2S7wJ2zXOceAR+u2p7TE=;
 b=f0J7b32a5DdzCp2fUDGPnACfHR8xTQ1HM2NiPfMXUxAoG3xoyDbBvWeEWUGx0AezY+
 22X0n8nBZXsgkxAIe2stjn8UQxyBiIB09991A1U9zIOUoKimuk/DvR36FoBqXfJlS5YV
 RptQLwrVHDiyUSUgdAiaWsevm7Ov61bp/Cn/FhgVH1TYSFRuB851dlXlf+DN6QbAC6oP
 xl5GVd4M+8d+izEgP/c5lAAlJ+PbMf2PUIW3drbKTLHhj30EAxzNN1w4p4+5Af5bKF+H
 qGlUAl9wczfAAhYBZKBR09g3iEoZELwdQ+tJpLXFC1xIv9Ssx5622shHlJQPCtmEmjku
 SKIQ==
X-Gm-Message-State: AOJu0YyOHKGp9dLig0zV2lU+CVISF9y/nNT4LXtQ5ukRnGdYG0l6EG0/
 6dxI5dm+Bkyz4VwpX2LzylXEjQ==
X-Google-Smtp-Source: AGHT+IFJpklvP6g04jJJpb+7+0Oj5B0xCde8nfpqjWCZ/RUUzBniFVUXHJxtFRU3W5onv6ha3ANRUw==
X-Received: by 2002:a05:600c:190d:b0:40c:ddd:5758 with SMTP id
 j13-20020a05600c190d00b0040c0ddd5758mr1018069wmq.12.1701808869333; 
 Tue, 05 Dec 2023 12:41:09 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p11-20020a05600c358b00b0040b360cc65csm19806102wmq.0.2023.12.05.12.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 12:41:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 380EA5FBBA;
 Tue,  5 Dec 2023 20:41:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 02/11] tests/avocado: fix typo in replay_linux
Date: Tue,  5 Dec 2023 20:40:57 +0000
Message-Id: <20231205204106.95531-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231205204106.95531-1-alex.bennee@linaro.org>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/avocado/replay_linux.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
index 270ccc1eae..e95bff3299 100644
--- a/tests/avocado/replay_linux.py
+++ b/tests/avocado/replay_linux.py
@@ -94,7 +94,7 @@ def launch_and_wait(self, record, args, shift):
         else:
             vm.event_wait('SHUTDOWN', self.timeout)
             vm.wait()
-            logger.info('successfully fihished the replay')
+            logger.info('successfully finished the replay')
         elapsed = time.time() - start_time
         logger.info('elapsed time %.2f sec' % elapsed)
         return elapsed
-- 
2.39.2


