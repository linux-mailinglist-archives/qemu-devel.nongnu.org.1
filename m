Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9AA7B44B8
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 01:54:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmjmC-0004NA-HP; Sat, 30 Sep 2023 19:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qmjm8-0004MT-LR
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 19:53:32 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qmjm6-0007vl-0B
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 19:53:31 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5041d6d8b10so24555836e87.2
 for <qemu-devel@nongnu.org>; Sat, 30 Sep 2023 16:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696118008; x=1696722808;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7UfzjErjTODwvTW2xkD20tjGZ4cTrTpKUNfwuop7eBU=;
 b=Cyc42KfmlbvkmMoPonJcDP6gCfhw0pSTehloWojFQWHrH43WsHW0AKiWcFHSmBBGeS
 6gBUx+n5pNgU0YU0GWSbAFhH3S9cTdIAcY+9YSNBXIKxf/RK0izFkXnauzkrpkA9PuDi
 u0k3pQLh6+Js4YEtSET9bznrwCrhKy/m27ZvgQduaamiuWdn0pE8/pQdfGxhd6hKFGEQ
 ZuVztEUf+mk9+CbxmVGOu1ZVI2nyLP2cBbG15FvDb+v8NtTCLMfypq/s7S+N6wFCzgxF
 Rctk1xjb/s9uigBoUvpf5k1yUsWARNWCpVklE5t4vpuYDG5oLdyQMxsI8oEPUCuKVY88
 JliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696118008; x=1696722808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7UfzjErjTODwvTW2xkD20tjGZ4cTrTpKUNfwuop7eBU=;
 b=wrxYY9MYlqVGAaXiuhPz89a82cVfqvamCUHqij0nNXUgjjvRmWkRw2DLlqPA2ECTef
 MkSUpricH0XtyXPpYXrH6T4xSvesBdHsymM1g95KC/KjAgLYDdWjcfq1uCvjAeIT2dce
 ltTQ+o3xnKw8IgEpQscMYVg+KLjWwnhnFQeI/1kUyFzdcY3gW2A9OHev0BhO2IrkYBa+
 dc2S1qYgmfvyMARfgYaNPxhfUWOciG36ftpA3Xk0kMGhVReWDutHx8EcHjEsHoLZ4Aen
 JzAUYB5lQRmA9dM2lcyhozmrnu2WNh4ga/hbXn+0TDGiORQ9vAMqn5hzJ4qw1aSRKaWn
 mGRQ==
X-Gm-Message-State: AOJu0Yz2qIXkuo7HI6xaZhoWWFctjxs//Y82Xi3Fy9aw79G6KEMlJSIu
 lYV64rNqsyN/GFgWQR/IgXtEL7ohNncW8BVYVE/scQ==
X-Google-Smtp-Source: AGHT+IG3i8Qtf6Z3n7Lvg9mHK+fMiAMqnckr7k+r59YC3Gmfdf9qnnw4JsLWr8C2NaB8t+jgYrMEvw==
X-Received: by 2002:ac2:4ec8:0:b0:500:79f7:1738 with SMTP id
 p8-20020ac24ec8000000b0050079f71738mr5430881lfr.17.1696118008452; 
 Sat, 30 Sep 2023 16:53:28 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-8.nat.spd-mgts.ru.
 [109.252.90.8]) by smtp.gmail.com with ESMTPSA id
 h18-20020a197012000000b0050309ea3a62sm4012391lfc.277.2023.09.30.16.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Sep 2023 16:53:28 -0700 (PDT)
From: Viktor Prutyanov <viktor@daynix.com>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, akihiko.odaki@daynix.com, yan@daynix.com,
 viktor@daynix.com, viktor.prutyanov@phystech.edu
Subject: [PATCH v2 2/2] elf2dmp: check array bounds in pdb_get_file_size
Date: Sun,  1 Oct 2023 02:53:17 +0300
Message-Id: <20230930235317.11469-3-viktor@daynix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230930235317.11469-1-viktor@daynix.com>
References: <20230930235317.11469-1-viktor@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::136;
 envelope-from=viktor@daynix.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Index in file_size array must be checked against num_files, because the
entries we are looking for may be absent in the PDB.

Fixes: Coverity CID 1521597
Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
---
 contrib/elf2dmp/pdb.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index 6ca5086f02..8e3c18c82f 100644
--- a/contrib/elf2dmp/pdb.c
+++ b/contrib/elf2dmp/pdb.c
@@ -25,6 +25,10 @@
 
 static uint32_t pdb_get_file_size(const struct pdb_reader *r, unsigned idx)
 {
+    if (idx >= r->ds.toc->num_files) {
+        return 0;
+    }
+
     return r->ds.toc->file_size[idx];
 }
 
@@ -159,16 +163,17 @@ static void *pdb_ds_read_file(struct pdb_reader* r, uint32_t file_number)
 
 static int pdb_init_segments(struct pdb_reader *r)
 {
-    char *segs;
     unsigned stream_idx = r->segments;
 
-    segs = pdb_ds_read_file(r, stream_idx);
-    if (!segs) {
+    r->segs = pdb_ds_read_file(r, stream_idx);
+    if (!r->segs) {
         return 1;
     }
 
-    r->segs = segs;
     r->segs_size = pdb_get_file_size(r, stream_idx);
+    if (!r->segs_size) {
+        return 1;
+    }
 
     return 0;
 }
-- 
2.21.0


