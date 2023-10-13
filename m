Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AED7C8110
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:57:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDr4-0002t9-PT; Fri, 13 Oct 2023 04:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqb-0000xt-T2
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:42 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqa-00018L-94
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:41 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3248ac76acbso1572582f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186918; x=1697791718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GUWaMDSwbAcLHuD73n+AR7UDChmjT7lRbW5sA+PBxLA=;
 b=VoB/5+upp31e/TuAt7l7JQ2dzuWuNZ4sBN3Hqjyr3imoapBacGyyMczD5XfQ2nhPz4
 FjkY8N26wcb0Ag72qIjPcOUt7XsKpxVOu5ndGo5HuMUUyD1xjucs5+gnmfdYoifbRJLi
 mDbioMCBQ2OcK6nbLtLCYG4pmbPDJehPytMuNRBiZl8n1Yo1NRnMIbrk+hmntbmV6h3W
 P813Yc+3MW3S8z4hT2IA0k7aRghkzIwZ/rLmK2TTrh5elnWKX82TbPEWZsr30yErnb/+
 Dsi4aHzqzGyA/yV6vQmFJlZPl5jTWsjrDqDCQX72YOfv0e0nmeoi8UrbzmchQrcgtCEr
 pF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186918; x=1697791718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GUWaMDSwbAcLHuD73n+AR7UDChmjT7lRbW5sA+PBxLA=;
 b=aMG6xltEQFR1U270mYx1HRbXWmoOFMDlM9sgPQDUmhdo4fEMkCESFcodg9pvvr090H
 gmhjfV365ltScTmGeMottuIwRwC0BtESDH4xXj8w+nwF4vbJrzdypwCAIqTd7FnvIha7
 ifV9M/niOb2yegiS6xUhb48bOxkNVRubS+Ik/Cwfs9AeA7bUEU0hfJ8XHUVqOWOxHZb0
 Qe72Tn4lpmNcyA+TpS9FBDxR/Tz4leP5y+n9ScXK++lmoRJy4FowPRCGKhYlLx0/Q4+j
 4IThFw1bXCEkY/q7kXcBLwAOU9ag7xqhgSstEbZuF9yl2qtCZ0sZNXjgEzoulJ7/mTJr
 4DTA==
X-Gm-Message-State: AOJu0YwUKS9PXvWc3LieafdIgBuEf/Yz7tnJrctaRYYkj3wBwgX8qDXq
 Uxulb97Ouo2yST5Jc2awy9dQvfDYwdb2/c4fCGE=
X-Google-Smtp-Source: AGHT+IGwh0JON/41nACnEjY2NNupxoL5kIVx+jgWv9EwiqIRnwgmgTNlEI8JaFQgmGQQWPMu6C6GPg==
X-Received: by 2002:a5d:680b:0:b0:31f:a259:733 with SMTP id
 w11-20020a5d680b000000b0031fa2590733mr21231988wru.20.1697186918787; 
 Fri, 13 Oct 2023 01:48:38 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:38 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v3 51/78] chardev: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:19 +0300
Message-Id: <4533539e04d5bd44dcc1d97f00422e9d78c3c7cf.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 chardev/char-socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 73947da188..1562e066a4 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -564,7 +564,7 @@ static char *qemu_chr_compute_filename(SocketChardev *s)
     case AF_INET6:
         left  = "[";
         right = "]";
-        /* fall through */
+        fallthrough;
     case AF_INET:
         getnameinfo((struct sockaddr *) ss, ss_len, shost, sizeof(shost),
                     sserv, sizeof(sserv), NI_NUMERICHOST | NI_NUMERICSERV);
-- 
2.39.2


