Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF556805FA6
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 21:43:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAcEN-0007SD-Ey; Tue, 05 Dec 2023 15:41:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcEI-0007RM-Di
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:18 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcEG-0002GK-5m
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:17 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40bd5eaa66eso43531445e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 12:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701808874; x=1702413674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xzTR452wuPoh7u/eWoDkJGpRh65Bnf4qmyQcBOguNFQ=;
 b=tawdAkP4wGZb6jY5J+FfTqmk5/+hwJKuk9oVf91ADpOdIN89tC72SBwD0QA5aZNIoT
 7vU3/Ap8haNaHJyFKuRZ9ft99RT0tM+J9NCRRkSDhkCh01s55UcS4Opij64qR3BKpGFf
 3ju9F3k0sjnhmLkTJv39W4lj1EyL5zqYAgiDWXXtkxZi/i28JrOpB3KDdGmuWmM+KTV1
 vZzSFE3QBZ+XlQpFhn+vpuGCmQ/cUGAw1WVb1wAsB535nUJfEkgRI8ZCkyNfcb5TOXsR
 RBMed36HKuScm1E1EwZZtnB6wIBOfTF5tE9bmyx4u4wCPAidNlVak+Aoo/iXNcvj4ZFH
 Sngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701808874; x=1702413674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xzTR452wuPoh7u/eWoDkJGpRh65Bnf4qmyQcBOguNFQ=;
 b=niqFmOT+SFq/9/GYSoJXlmGePNoO5InzC2OyLEYFGV81eBcEVM4yTxZfGrZ8hsfJwJ
 yCYrWIUZyuLjZHpUQIiPj+R8WFP4tBoD+Hy99M5lBl5IfbgfSoCC8Iq+kr+xmDab/7e9
 +wQV7+QwtijX6nWKjzZjmow2uIZkJwKXnMj46btauhd0HxR8mgAFW9vDrXSWqjXpleL4
 DTioZto8YIR/1px3yIef+CsWc0YI9MIpMR9ZhtPwmlY2KU+A0tx7PJ6deVqXoF6jkjB4
 ERP0cEaI4Y5GSj6+wHcI2pqiu4lRMmRzzfC0GXg3Fa9ps0XLcpAmYut9mx5CzjoA6Bbi
 8Rwg==
X-Gm-Message-State: AOJu0YxDQSbYlEdx5J5E+Vrt9XdTeDHopbDJTY6QmkxaS/F2fnBdiPcx
 2+AWCjFiL5a8X+VMxmr5yfDdYg==
X-Google-Smtp-Source: AGHT+IHPcOZ8muQoN5EDIB75kf+fvnznTcxJTXaSe2YuvBxWs8kN2dCyeBSyq803Drfhp+Ajx9Ec+Q==
X-Received: by 2002:a05:600c:2d4c:b0:40b:5e59:e9ea with SMTP id
 a12-20020a05600c2d4c00b0040b5e59e9eamr988487wmg.137.1701808874602; 
 Tue, 05 Dec 2023 12:41:14 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d22-20020adfa356000000b0033332df65absm12350639wrb.50.2023.12.05.12.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 12:41:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D2F715FBCC;
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
Subject: [PATCH 10/11] chardev: force write all when recording replay logs
Date: Tue,  5 Dec 2023 20:41:05 +0000
Message-Id: <20231205204106.95531-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231205204106.95531-1-alex.bennee@linaro.org>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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
failed write will haunt us on replay when causing the log to go out of
sync.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2010
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 chardev/char.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index 996a024c7a..6e5b4d7345 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -171,7 +171,8 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all)
         return res;
     }
 
-    res = qemu_chr_write_buffer(s, buf, len, &offset, write_all);
+    res = qemu_chr_write_buffer(s, buf, len, &offset,
+                                replay_mode == REPLAY_MODE_RECORD ? true : write_all);
 
     if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_RECORD) {
         replay_char_write_event_save(res, offset);
-- 
2.39.2


