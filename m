Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 927BB726954
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 20:59:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6yME-0000cf-7j; Wed, 07 Jun 2023 14:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q6yMC-0000bV-8O; Wed, 07 Jun 2023 14:58:08 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q6yMA-000364-QR; Wed, 07 Jun 2023 14:58:08 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-52c30fa5271so3028524a12.0; 
 Wed, 07 Jun 2023 11:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686164284; x=1688756284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w3KPnsNEoOEhqEKbEl/TQJNAtJO+JCcv80sIEkTHTUc=;
 b=MNgNdNh/MlqPaUtUB88sTZdWkluH3NxTPFVheNlEROa85M8V6wvO/IRYhfZ9caRs+L
 UbG+j6rd1mky9ngIdtudcX3EXKMHywHvvDY5xcDtmtmJ8YeTNkd2ykyM6tDnt0iONJTt
 J7VMrpHbkezgXPKs/JHEGphTN0QiSBNiumOJyxO9RotcgJqLSG+bMPTwx/IlMX0aMFSZ
 nQ60b/0lrj/0OOHq5SaS2KJOppaDHOo/7LjReF2VwY8XNfLGQFUuDyNZIPmAPdJcwg02
 TM1y0aaKRZmM5Bu3FwJxl7m1g7Cmc2EmS/NEwIXTtFxMFNolVTGiO/wpHED/sf/kBvmz
 UP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686164284; x=1688756284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w3KPnsNEoOEhqEKbEl/TQJNAtJO+JCcv80sIEkTHTUc=;
 b=VoZsM7SXEoWUmhTnz26KoDiEp8FLCdDB1Okbh/WlhTD/o03OVlccrH79uFntkDN8eC
 jz346EMru5WUteEI5AXfZPCEba92VYbnhkJmyx37SH5YV5E5RZtbHpSEm2Y45O1RcsYs
 Uq1T1hBM5ymLnCDG3P4LoC52D4at9J2DPdpj5AEKrzEPDs3/qoJdJJvlzCJfH/PYDrt7
 hq0QEYZuNeBoTTsxiPgucbumd5+CUMbZDKXlw5SpxsZ1xo0MjWiiukBi+PYcW+ESmDMt
 QZcOXKJ/OzwkkejOinyl7+NeiqLlB0oGtDmo+B0zR9laz5TeP6F7esHHE3sThzWCJOCB
 MHGg==
X-Gm-Message-State: AC+VfDwWQiJ6QCnJMYjQcqEX85lUzWJeG/pUVmV5o65CYJ2NFwhFSJ4O
 9H/0zL+fpfcNoYBmK+2FroPpsopW9A8EBHj2
X-Google-Smtp-Source: ACHHUZ67G02fkdZWL6+zSdlgTzgwZPQ3+s/E6SLZk5QPBBkZP1sElzGW6xpREqY5ipEq3mRw64r1GA==
X-Received: by 2002:a17:902:d716:b0:1b0:4a63:3099 with SMTP id
 w22-20020a170902d71600b001b04a633099mr2990995ply.50.1686164283346; 
 Wed, 07 Jun 2023 11:58:03 -0700 (PDT)
Received: from fedlinux.. ([106.84.132.130]) by smtp.gmail.com with ESMTPSA id
 y20-20020a170902ed5400b001b034faf49csm10725845plb.285.2023.06.07.11.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 11:58:02 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, dlemoal@kernel.org, Hanna Reitz <hreitz@redhat.com>,
 stefanha@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 dmitry.fomichev@wdc.com, hare@suse.de, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v2] block/file-posix: fix wps checking in raw_co_prw
Date: Thu,  8 Jun 2023 02:57:41 +0800
Message-Id: <20230607185741.4238-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=faithilikerun@gmail.com; helo=mail-pg1-x52c.google.com
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

If the write operation fails and the wps is NULL, then accessing it will
lead to data corruption.

Solving the issue by adding a nullptr checking in get_zones_wp() where
the wps is used.

This issue is found by Peter Maydell using the Coverity Tool (CID
1512459).

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/file-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index ac1ed54811..4a6c71c7f5 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2523,7 +2523,7 @@ out:
             }
         }
     } else {
-        if (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
+        if (type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND) && wps) {
             update_zones_wp(bs, s->fd, 0, 1);
         }
     }
-- 
2.40.1


