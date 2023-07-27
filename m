Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E03766085
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 02:09:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPAV5-0008S4-Sx; Thu, 27 Jul 2023 19:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qPAV1-0008Rb-7E
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 19:34:27 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qPAUz-0001DE-EF
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 19:34:26 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4fbf09a9139so2661728e87.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 16:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690500864; x=1691105664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4x4X9HcXunJY2e/nTLa6Qqic/2+/FjTj0qiz3rIHmF4=;
 b=CTpJzr6ZhDKw6AEuyW0jKtUK8PJiWuER/FSeczcFs543Wr0QknoRVpOwvzwe3DkBuS
 Ia93iGwUp4veX0RdBsKySLQK0LMoswt/whpt1Rhu7Cp67Cx2N59cgRNkcZn+yKlOpZcO
 CbrtBLVRmBS8n5jPZLfWIN+7lDuBkMkBMxqyXrEs1i3Q5vfGxhHYH2qg94K39eMVGqoA
 OnMWn1BHGdH3Tkizf5fzsHanEVzfeCjeDi7iYaZME4nnyDymmWEBCSc+oXKi4DNWI222
 0A1a812BoGHSqVNhckf9ctjoGwQiPtA2+LRqeIRhengKUfIGk5HjzRdM29auZDXRzQF6
 ytJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690500864; x=1691105664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4x4X9HcXunJY2e/nTLa6Qqic/2+/FjTj0qiz3rIHmF4=;
 b=EGQFIP8kF7KrrSWc5a8bncttcgI9TKwSZjjSpYDdEK6h5aMCZkX4vWUNGxcSmifTLG
 utLK+p2iZQgTWoJX4IQJ3vCNBF3AZaWdMDd4l0EK8ntwP8IwuQRVNVOO2CPn2MMl8ngx
 5w0TUYwu0POk4VQUzKfVbFyB8ZSENeqewO40I/DEeLwv1rFUs/2FlIKJ8DRagmQZhRR8
 h9VwJSji10bCfMCprMD1jboXFfwvj8rgvzy4iB14jR/bgBzjS24H+8gU5J0wWMNE+jmW
 VzdcAMDYQ+OUxVh1Z3rxYx5WOaCUt4a1n7UnHzcqk2bHRFYxPl/LrJlr1hayOgcRNGzp
 486g==
X-Gm-Message-State: ABy/qLbz9B24F6bZCiNU+cZ9UbgIkXvK7/lrn+NX4GPmB9ZoQW2tkRrD
 fg8pL+ZQ9GtmZG//PPsF4wB6APzrX4mzsg==
X-Google-Smtp-Source: APBJJlETZWji3DBlt44VPf2FKGtVKZsFRyjHu24EX01WXtEumJ88XWHWekFZ4+r7vO2STEO8gAqwNQ==
X-Received: by 2002:a19:7401:0:b0:4fe:825:a081 with SMTP id
 v1-20020a197401000000b004fe0825a081mr376145lfe.45.1690500863403; 
 Thu, 27 Jul 2023 16:34:23 -0700 (PDT)
Received: from localhost.localdomain ([185.9.78.206])
 by smtp.gmail.com with ESMTPSA id
 h16-20020ac25970000000b004fe0de39fddsm528241lfp.290.2023.07.27.16.34.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jul 2023 16:34:23 -0700 (PDT)
From: Mike Maslenkin <mike.maslenkin@gmail.com>
To: 
Cc: qemu-devel@nongnu.org, jeuk20.kim@samsung.com, stefanha@redhat.com,
 Mike Maslenkin <mike.maslenkin@gmail.com>
Subject: [PATCH 2/3] hw/ufs: fix compilation warning
Date: Fri, 28 Jul 2023 02:34:04 +0300
Message-Id: <20230727233405.35937-3-mike.maslenkin@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20230727233405.35937-1-mike.maslenkin@gmail.com>
References: <20230727233405.35937-1-mike.maslenkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=mike.maslenkin@gmail.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch fixes compilation warning, since argument to ufs_process_db()
passed to find_first_bit() that expects unsigned long value.

The exact warnings are:

warning: incompatible pointer types passing 'uint64_t *' (aka 'unsigned
long long *') to parameter of type 'const unsigned long *'
[-Wincompatible-pointer-types]
    slot = find_first_bit(&val, nutrs);
                          ^~~~
warning: incompatible pointer types passing 'uint64_t *' (aka 'unsigned
long long *') to parameter of type 'const unsigned long *'
[-Wincompatible-pointer-types]
        slot = find_next_bit(&val, nutrs, slot + 1);
                             ^~~~

Cc: Jeuk Kim <jeuk20.kim@samsung.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Mike Maslenkin <mike.maslenkin@gmail.com>
---
 hw/ufs/ufs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index af32366c8504..b0656e47598e 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -267,7 +267,7 @@ static void ufs_process_db(UfsHc *u, uint64_t val)
         return;
     }
 
-    slot = find_first_bit(&val, nutrs);
+    slot = find_first_bit((unsigned long *) &val, nutrs);
 
     while (slot < nutrs) {
         req = &u->req_list[slot];
@@ -283,7 +283,7 @@ static void ufs_process_db(UfsHc *u, uint64_t val)
 
         trace_ufs_process_db(slot);
         req->state = UFS_REQUEST_READY;
-        slot = find_next_bit(&val, nutrs, slot + 1);
+        slot = find_next_bit((unsigned long *) &val, nutrs, slot + 1);
     }
 
     qemu_bh_schedule(u->doorbell_bh);
-- 
2.32.0 (Apple Git-132)


