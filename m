Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E47B2800746
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 10:39:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8zwv-0003mE-Ar; Fri, 01 Dec 2023 04:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8zwt-0003lW-Hk
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 04:36:39 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8zwq-00044c-IA
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 04:36:39 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32fdc5be26dso1341582f8f.2
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 01:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701423395; x=1702028195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JqE1WlTC8iW99lEPTJa1X2LXMjo5z4bbux1ltP+LwY0=;
 b=jYG0BzAUW8y2xu8GKnwNVwu56t5I4Vg6uNrXisDywfWAm9vmo9g0d9511zhWvqCL9U
 5H+rXrx/z0InyyDPEnd+nkJXcOHCXaCDC9J9GpJyPNTONiUqs+qQqs9bXdjbxQGMnpJo
 pLIUZXc0idPd/8UgVcBd8tUmG1HjfkO1CVqXi3DbEDNz5tdNvEl1lLGRqXF7A2T7BzSc
 lxJOYkx245b4V3gZg2Raz3UU+MrLGa/D4puX2EVyPJCtto6pYDXk58JJnFcSvHATnrzJ
 MzD9/dcjjBZDkPoaQHIIXHGPL/9dHMq3GgEO1+F0sB87thOqWV/fd4SQKYu4w2S7L0KL
 xxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701423395; x=1702028195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JqE1WlTC8iW99lEPTJa1X2LXMjo5z4bbux1ltP+LwY0=;
 b=dgT/IYeuNbdKgdngy32i0OfasNBFTTHuT1C9sP+fWeTAdVSH9gizvKDYS/5BbnRHLO
 AkgQZVReyKheRqkZyxrAYsA+ROjiu7Js6O6mpzvrNB/sAFnMnDzAwqcOWcOwH/k1dCsU
 WX1vk8C0Uf3tocmtEItq5CQKAGf2wqh3JEOL4ZiVwmDU4ajrAaGXVWcVXa7ZZcf5uEya
 AjKTV+l87EaaJk17fgF4WMfnynN0BNDq0B6R6bMFizWsKtABkbLMVjokeiL7Hg0eJSAd
 lUwZGC7ua9rZFnKNFKy5MUIl0tu05S3hDafzi57QIIerK5BHUWn4/4extw5Yu1K1kryD
 Z2Dw==
X-Gm-Message-State: AOJu0Yz/P3LYfjTFnHGTg3H/zxxsmkO2587FGKhaEPJRwuOROPmAEXqY
 FZhX6He/+giWPndo/qD4V451Bw==
X-Google-Smtp-Source: AGHT+IER/CKsUSEWIkP6vRxQYgrFsmUbwNnLxNvGU7RfJ6gGg8Fak4smXm6eRbHa+tV2NC5C7EidZQ==
X-Received: by 2002:adf:efc4:0:b0:333:2fd2:8130 with SMTP id
 i4-20020adfefc4000000b003332fd28130mr545320wrp.77.1701423394671; 
 Fri, 01 Dec 2023 01:36:34 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 w18-20020a5d6092000000b003142e438e8csm3690050wrt.26.2023.12.01.01.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 01:36:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 015925FB61;
 Fri,  1 Dec 2023 09:36:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Eric Auger <eric.auger@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Cleber Rosa <crosa@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luis Machado <luis.machado@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 1/7] gdbstub: use a better signal when we halt for IO
 reasons
Date: Fri,  1 Dec 2023 09:36:27 +0000
Message-Id: <20231201093633.2551497-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231201093633.2551497-1-alex.bennee@linaro.org>
References: <20231201093633.2551497-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

The gdb description GDB_SIGNAL_IO is "I/O possible" and by default gdb
will try and restart the guest, getting us nowhere. Report
GDB_SIGNAL_STOP instead which should at least halt the session at the
failure point.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Luis Machado <luis.machado@arm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/internals.h | 1 +
 gdbstub/system.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 465c24b36e..5c0c725e54 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -24,6 +24,7 @@ enum {
     GDB_SIGNAL_TRAP = 5,
     GDB_SIGNAL_ABRT = 6,
     GDB_SIGNAL_ALRM = 14,
+    GDB_SIGNAL_STOP = 17,
     GDB_SIGNAL_IO = 23,
     GDB_SIGNAL_XCPU = 24,
     GDB_SIGNAL_UNKNOWN = 143
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 783ac140b9..83fd452800 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -183,7 +183,7 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
         break;
     case RUN_STATE_IO_ERROR:
         trace_gdbstub_hit_io_error();
-        ret = GDB_SIGNAL_IO;
+        ret = GDB_SIGNAL_STOP;
         break;
     case RUN_STATE_WATCHDOG:
         trace_gdbstub_hit_watchdog();
-- 
2.39.2


