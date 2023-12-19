Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BDF8186D0
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 13:00:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFYkn-0007k1-HF; Tue, 19 Dec 2023 06:59:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rFYkk-0007jY-VB
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 06:59:14 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rFYkj-00040d-LJ
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 06:59:14 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6d89f278cc9so1142390b3a.0
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 03:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702987151; x=1703591951;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wmIy6zTEzjyTl8VEi4dEbKyBmtsNUrrQNug4blfuDPs=;
 b=Fks1T5KVQraKzF7chWN9vnVz/KfYeZH/jzFLCAtAEXufIk7IaZwcjcTipWOHn5kwdp
 9bhQQyzq2eGANKPMRnoCfokwTfOCxBujNeveWS9JiybwwkfwmglY1WxqdyzZECCaTbhO
 wnI1gCJHIKKc6w5Xr636p3b0sKOMmNYrBdDz7Gei17qzvQgbSJoSYYosZi7l5qp4OUT2
 EwTZSAJk/IneDrV93OxIFzgbSy8dPDwzZ+LhRP9PRGDjEDaTIxfR+vCvkPjR05LFUmpF
 BZ8q+DVB6fNqjCTNm7ZJbqc8bPsFz9FYW6PkbGvoesI0VnF7ROHzcsbjRwX55c//XqVZ
 k2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702987151; x=1703591951;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wmIy6zTEzjyTl8VEi4dEbKyBmtsNUrrQNug4blfuDPs=;
 b=O3RBZzTI9rZ8D7qxNUu4JRlldHM+xupyj2V1g6cw/T4Ay2qsVTQ9RLpzRBUXzaO4If
 WWr8eujVPwXXy15+psCYqXzvP6Akp5o+klxzYUMOXP7q3sNTVO6I4z+so50R40Oabdw2
 sTfd7Aur74A8QQ0VGI7D+njmHknDmuTh/6WrmwchG1lZCrY/YpZvd6p0uscQYficsgH0
 f61uqXpfft9kxXxlIUGwn4FqGJ72us8Y9RzzJVpU7Sc0kb63Xld2vWochKPhg9n+ZzoV
 ZQP5v2xpeUWsIbxW6E5AT6XI+SlsxJYn/Oqv1fJ86GXfcjR1eoSi0E/iq4FXdfGk4cZR
 E7sw==
X-Gm-Message-State: AOJu0Yw3wR7oca90gZWDlZGvE0O4HubFauE5Rn4b+AA3zO8h2xAXYGFv
 zXBYb4Tum/1MniLG861LtTw1lMyRgLIXS2PIAkoositcRSW1xw==
X-Google-Smtp-Source: AGHT+IHBmER7Rm+8VyrMVdaXlqS41uaIE1Jzseqh3Mtd4vvjRYrozxjJUS+tjjb//HqmRguZPmOSZQ==
X-Received: by 2002:a05:6a00:6c97:b0:6d8:b706:ed10 with SMTP id
 jc23-20020a056a006c9700b006d8b706ed10mr1211868pfb.20.1702987151135; 
 Tue, 19 Dec 2023 03:59:11 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 ey5-20020a056a0038c500b006d5d74cbd07sm4448526pfb.27.2023.12.19.03.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Dec 2023 03:59:10 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 19 Dec 2023 20:58:57 +0900
Subject: [PATCH 1/2] glib-compat: Define g_spawn_check_wait_status()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-glib-v1-1-1b040d286b91@daynix.com>
References: <20231219-glib-v1-0-1b040d286b91@daynix.com>
In-Reply-To: <20231219-glib-v1-0-1b040d286b91@daynix.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

g_spawn_check_exit_status() is renamed to g_spawn_check_wait_status()
in 2.70.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/glib-compat.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/glib-compat.h b/include/glib-compat.h
index 43a562974d80..5f76fbd28e6b 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -68,6 +68,8 @@
  * without generating warnings.
  */
 
+#define g_spawn_check_wait_status g_spawn_check_exit_status
+
 /*
  * g_memdup2_qemu:
  * @mem: (nullable): the memory to copy.

-- 
2.43.0


