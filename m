Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3010D805FA4
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 21:43:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAcED-0007OG-Dj; Tue, 05 Dec 2023 15:41:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcEB-0007Nc-Gh
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:11 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcE8-0002EA-PZ
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:11 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40b595bf5d2so65698105e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 12:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701808867; x=1702413667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D71TFDBoZSdjXR+fUZGSwmpZbsB3q4P2AJtXODOh0vA=;
 b=CfhvIoLvm6C4u8JYHJkEo9h8OZLpydaCw8nutPNe+2enYO/SVX1MyEdXXGIndiZo3D
 c60p5g5J3nJSkDaFkjTAoqxTogkIvYjmDBGCs6hdp0xBMACFTg3+LxUs5m0nBHJVI1CH
 9QjDVC64ayw5lBIUNiO0piuC2sPMVsJTltSRkY3G7H+CVgP1eFgB5OySXbUHQI1tDu2F
 kcPhSkNi9UrC0w5J5NGNO/4axHJwOh0lSQtKbgriGmAfjqlq3XtbShHfJC02vPRSReKI
 i752FpP9OZIGom3GsTmKDft8lrKd2W1GdxkiYnimhroIZKRa0zFe917cTat0B5Khut/x
 pPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701808867; x=1702413667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D71TFDBoZSdjXR+fUZGSwmpZbsB3q4P2AJtXODOh0vA=;
 b=riLz9iOMF24sQIKKaNZFIojAQKaJXsBIz0e2EDhLVKqX3GIH2rIibAkWEnfi1FlbR5
 AUwFENGC+68mou/FrxbtWwAS1bu8CNVyF7TSBM/WVTdhHMvEkGTIPgfOOWGRtcIZwguY
 hb53FmzycjN1g3ht476VwDesGy11QPckD7ffyWGZVeuWUwiH7hAjLY+4pa7793npNife
 zV1FImy5UC6QgntJACtlmoo07027oYAjZGV4UbXm5IfF/3ODm1xC75VrmZcj6GvlqlKb
 aCeK+MVFwjKdQx+SkYl5Fbg12Gy83MeDkdB8gbOhH4fQ1h9dqDZN/bpO8M0aopkXODXu
 Bktg==
X-Gm-Message-State: AOJu0Yyc3qbDPpwE9R85Cp5aGvBrsK3b7wXvvNLw22UpPCh0ilmQb5jc
 imc0IRh9HWQXCwY/WW8dIklXJQ==
X-Google-Smtp-Source: AGHT+IHxEj5vlrVRGgfPHHAl4A8Z0zJluadJIz8SgvfdQ9SP3Kzygy2jQPUtZdFMLVahlNBmiOh74A==
X-Received: by 2002:a05:600c:d7:b0:40c:9d4:4bd9 with SMTP id
 u23-20020a05600c00d700b0040c09d44bd9mr615321wmm.237.1701808867219; 
 Tue, 05 Dec 2023 12:41:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h15-20020a05600c314f00b004083a105f27sm23057211wmo.26.2023.12.05.12.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 12:41:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5BE1A5FBBF;
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
Subject: [PATCH 04/11] scripts/replay_dump: track total number of instructions
Date: Tue,  5 Dec 2023 20:40:59 +0000
Message-Id: <20231205204106.95531-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231205204106.95531-1-alex.bennee@linaro.org>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

This will help in tracking where we are in the stream when debugging.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/replay-dump.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index 8b9f914534..2212b09322 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -150,10 +150,13 @@ def decode_async(eid, name, dumpfile):
 
     return call_decode(async_decode_table, async_event_kind, dumpfile)
 
+total_insns = 0
 
 def decode_instruction(eid, name, dumpfile):
+    global total_insns
     ins_diff = read_dword(dumpfile)
-    print_event(eid, name, "0x%x" % (ins_diff))
+    total_insns += ins_diff
+    print_event(eid, name, "+ %d -> %d" % (ins_diff, total_insns))
     return True
 
 def decode_char_write(eid, name, dumpfile):
-- 
2.39.2


