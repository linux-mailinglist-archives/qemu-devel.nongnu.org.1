Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0758680C45E
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 10:21:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCcTN-0000Dh-36; Mon, 11 Dec 2023 04:21:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcTJ-0000Cm-Cz
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:21:05 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcTE-0005vI-Ci
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:21:05 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-336223afe64so521725f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 01:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702286457; x=1702891257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=djPxrJrlceejDSikdH1s/unMablwdP1SJY1GE8A/HP8=;
 b=ESWnbTPTA/e3HA0NImMaifftJdpRargnNUqzIDKrgCawsaCiWdgA8lq+vqc7zR2kG6
 uJOyE5w2oMJr/Cl8HWRQDrCZDhUd/U+wc31jZhtS9V8kfg2/JMEVEJeQGsNMinENnyNr
 HcXHnj8gnIdF/WH/PkWIn7WSw7nS1sXgn8QKYJeWs+lIkCj8dmRG/OEftnE2gzvdElSN
 ZxeiXsciZrm1qOqZ08iKlMJ24wjOtJKz34kGhNrxdhT/gTq/khchVtrlE7MX8/cAUMJl
 HVwCIYrXChwoNlhLad7Mw+1AZ/Nj8192g0lpN/C4tXXxJrAdzSxY8MIvKhknE8cQM/Lb
 oBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702286457; x=1702891257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=djPxrJrlceejDSikdH1s/unMablwdP1SJY1GE8A/HP8=;
 b=TonNVePWKy4E2vQKeuQW4EW3eYOfVlA9l9Tf+ThaCMauSpNRQ6Alloo8etOKeT1gSR
 2hQxwfWSxkvjHcdQ2UvYo6fP/WAvEu+8aya6EZ4ZMIUEeOwtbgGhx/0nB1kjZsUyKIcC
 hZxBheALdKA7t1eA4JmFobJmHEDGvWT4CWJPMWV2PSwPruLgqYoYeR/FG+l6zgvVX/Xi
 Fo+EwnVTOYtgxx6m6Z7jHFMRAc77kuFKFg8T4SDQt3DvBIQ1gup1wFZ+LiVaqp30L8X6
 jATiAD6VC6ixY9h9PM1NC2uWj0wTn+hBlTX5Y75ATj9pmUuKoG5VRKG5IjzklsWjFA++
 Rzww==
X-Gm-Message-State: AOJu0YzdIU/VhzsOs5GU1T91y9vDQxTqdqMaCiqzOl0f6EptwQBIuDq/
 EvcPgJCsUGJgXFHAipwqTwV69w==
X-Google-Smtp-Source: AGHT+IGS3pSh/Ew/L/1uXThjkFS9eJSrBkUdnR6OdDxQ6CXfPfqu/y47DaudMOpKBWsvR7SWrpzeqg==
X-Received: by 2002:a05:6000:110a:b0:333:5258:68ef with SMTP id
 z10-20020a056000110a00b00333525868efmr2461607wrw.68.1702286457301; 
 Mon, 11 Dec 2023 01:20:57 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o13-20020a5d670d000000b00334b35754bdsm8087864wru.24.2023.12.11.01.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:20:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7D44C5FBFA;
 Mon, 11 Dec 2023 09:13:47 +0000 (GMT)
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 16/16] replay: report sync error when no exception in log
 (!DEBUG INVESTIGATION)
Date: Mon, 11 Dec 2023 09:13:45 +0000
Message-Id: <20231211091346.14616-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211091346.14616-1-alex.bennee@linaro.org>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

If replay_exception returns false we can only trigger an exit from the
main loop and hope something unwinds to something we can process. This
seems to be the point where execution diverges in the replay_linux
tests case.

DISCUSSION: Maybe this should be tightened up to check the remaining
instruction count?

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 replay/replay.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/replay/replay.c b/replay/replay.c
index 665dbb34fb..d283c1353d 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -209,11 +209,12 @@ bool replay_exception(void)
         return true;
     } else if (replay_mode == REPLAY_MODE_PLAY) {
         g_assert(replay_mutex_locked());
-        bool res = replay_has_exception();
-        if (res) {
+        if (replay_has_exception()) {
             replay_finish_event();
+            return true;
+        } else {
+            replay_sync_error("Exception not in log");
         }
-        return res;
     }
 
     return true;
-- 
2.39.2


