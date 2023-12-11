Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C41F80C425
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 10:15:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCcMM-0001OS-Pm; Mon, 11 Dec 2023 04:13:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMK-0001NY-C7
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:13:52 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMI-0004KY-QS
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:13:52 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40c39ef63d9so19403055e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 01:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702286029; x=1702890829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVVly0H15LIWjWS01fDgkj5/Woj14MblOWkoYW39ooY=;
 b=i5UbGTXHODBUGLqyqLC7LWeSV3tCBnRgXymAntVnyN8jBk8ou0k87evEphCcxAbiT/
 f9nfT8jhuvqfXHo9z6Xv9WgJh+FvW0JsFeduXYcHvwsm8SYR0iQQsolFsbqBdDtRNhM+
 pybb6hRze/lSz7o3XkOsGUWhpqbLWiUOvgKMTaWrHFBpHM/msFr3YOK/dfjWEJ2wf5+x
 ar/+WwqIkQOKFmGwPZBkHoC1XDCEcjmiwj3+4tXhALG4IVio4HdxR9MGXqskwjJjeFyd
 0n4BTiTipGVLZUreLw7BPk2Tp0KExcUlY0RL1SVier8NQzjjF98dT/h9wdZuQFjGAaTm
 vjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702286029; x=1702890829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eVVly0H15LIWjWS01fDgkj5/Woj14MblOWkoYW39ooY=;
 b=B+yqchkU+ft/Sty0IEMgTacccAgwPbTnqafKWmNojSzbxINNXI6zYyd3sA1988TXqV
 4GOZW/lXhtZdKhJQGxCM0LkB3cJusJCuSeHAXHoqJsortyC9ifuRcO0IQmmTpO6IYfPZ
 EAaIz4neXNWt8Gv1We7riWFul5u1M5xSeyiD2IVxEOO5JiQC9xKW7Jp1RfXx2dJbblo7
 hDcdqJlgAxemlO5CTlPgzlZwoSlYurCopzCdhAQ9tBYsLqt06V/sEd3Gl4AaCbF8iODA
 f3b1lIT4JNP9w2zHXGgyB4Afg7sIAdYAGC7ZLPiDRLmehpf9N9jACyCQUM91g4etGKuD
 r3BQ==
X-Gm-Message-State: AOJu0YzRJQKtkk3uFGSuDR0yaqHcvSlk9SywYzTlcmrMHFHALlwfJMI6
 5IlhYPdiFy+OgERiiUr+M+4OEA==
X-Google-Smtp-Source: AGHT+IFH7mVtyfatRfHwMLDK7YH5lhJ1suAIF/qb2JFjjDeC6Pkja9lhuE2lhfD2bBVOhgNGx9Lx7A==
X-Received: by 2002:a05:600c:4749:b0:40b:5e21:cc36 with SMTP id
 w9-20020a05600c474900b0040b5e21cc36mr1865686wmo.97.1702286029081; 
 Mon, 11 Dec 2023 01:13:49 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l6-20020a05600c4f0600b0040b45282f88sm14493487wmq.36.2023.12.11.01.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:13:46 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 444275FBDC;
 Mon, 11 Dec 2023 09:13:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH v2 02/16] tests/avocado: fix typo in replay_linux
Date: Mon, 11 Dec 2023 09:13:31 +0000
Message-Id: <20231211091346.14616-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211091346.14616-1-alex.bennee@linaro.org>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Message-Id: <20231205204106.95531-3-alex.bennee@linaro.org>
Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


