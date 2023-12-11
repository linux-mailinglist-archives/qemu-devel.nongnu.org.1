Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D5780C42D
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 10:16:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCcMU-0001RW-3N; Mon, 11 Dec 2023 04:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMR-0001Qc-Mw
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:13:59 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMQ-0004MC-5E
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:13:59 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-333536432e0so3999348f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 01:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702286036; x=1702890836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jMhVIXqtIwGitOVNFv/q8yt8hGURWr68L+NA/7+kuZo=;
 b=eodwA7y2MaCqylSPffVz7WjYDgNPuw/37KHNYb8dnB3JwWJ717EWnzHGGXwI7mEgEK
 Q+Z8vpGG7B7fHONaabLxJ3M89IzgVESJAQUAT+xWZnqbDY+ta348WiNkB/UOJiXcPtzy
 NPNS350ePu62pONVsMLl0KZh1CzNylQDIhaTtLqx8CD1avcCVh+4g1Nn3lTPJCoMCleM
 QAWKjS54VvqimdOhjogCQqOQI8OuhfA3y7BDXEZBOeNX2mAw0+cMa/q4usi8AoCHGYyl
 a0G+OGCDqqeOLoNR1GInZzxPPXbTdPNVFUQvD0bw1s+bTbY0HnWvcrgLgceujnr0iyP1
 yiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702286036; x=1702890836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jMhVIXqtIwGitOVNFv/q8yt8hGURWr68L+NA/7+kuZo=;
 b=vZA39zwUvbH2HfH+wallNMuYhzUrWGp2N2+E4HFl9ycHNjQZNdfxBL3nQhYEX50qdk
 +ZrKEutL3C86NvdqqzVpqZ2AHdbMu2OnW2zoJpqWMsiv/tbd5Jn7PWeqtQ3R1nRuoz6g
 Tf1krgsufF+MvvdSZ/bRSo495FkPM3B1BTONdKs4RzAZZ9Yswm/yZaKvGvVoFg8HXK7X
 OlqnYRhcjLhSvO8xMqiOaNnPVFLjJaFw98Pvi0plmLIWZbkhFkwGNuP2vqg2sUDNd0YK
 d/wf/HdPgWfKLHiiRrrMYkPFUpHHAqG/o+mM9wil0Mq8S2BIMtQhAHV+YJSzUrJgrXSu
 tXyA==
X-Gm-Message-State: AOJu0YzdNPhkpcg/ghTTXjx4ozRhJmIAs7aBtCVg1ZOWuPK+lLNkl3b0
 cAGF41HyZPut9FS8HMxNbct2Kg==
X-Google-Smtp-Source: AGHT+IHvyqCOj8o51x54r03mL0JPQPmYP3oaHXd+zJWEMxO+XESmEcVMxwUlhB9pEDQ7xbGm42s5xg==
X-Received: by 2002:a5d:698b:0:b0:336:989:1baf with SMTP id
 g11-20020a5d698b000000b0033609891bafmr2085634wru.40.1702286036331; 
 Mon, 11 Dec 2023 01:13:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o1-20020adfe801000000b003333c06fa79sm8121030wrm.71.2023.12.11.01.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:13:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F2F315FBC6;
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 10/16] replay/replay-char: use report_sync_error
Date: Mon, 11 Dec 2023 09:13:39 +0000
Message-Id: <20231211091346.14616-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211091346.14616-1-alex.bennee@linaro.org>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

Now we have a centralised report function use it for missing character
events.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 replay/replay-char.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/replay/replay-char.c b/replay/replay-char.c
index a31aded032..72b1f832dd 100644
--- a/replay/replay-char.c
+++ b/replay/replay-char.c
@@ -113,8 +113,7 @@ void replay_char_write_event_load(int *res, int *offset)
         *offset = replay_get_dword();
         replay_finish_event();
     } else {
-        error_report("Missing character write event in the replay log");
-        exit(1);
+        replay_sync_error("Missing character write event in the replay log");
     }
 }
 
@@ -135,8 +134,7 @@ int replay_char_read_all_load(uint8_t *buf)
         replay_finish_event();
         return res;
     } else {
-        error_report("Missing character read all event in the replay log");
-        exit(1);
+        replay_sync_error("Missing character read all event in the replay log");
     }
 }
 
-- 
2.39.2


