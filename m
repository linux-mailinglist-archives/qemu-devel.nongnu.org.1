Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D64766091
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 02:12:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPAV1-0008RM-5e; Thu, 27 Jul 2023 19:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qPAV0-0008R4-1y
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 19:34:26 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qPAUy-0001D5-FT
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 19:34:25 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4fba8f2197bso2534215e87.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 16:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690500863; x=1691105663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KSbLpaSE+UAqzzlGuBowjxWnHVXq8GMPqVPL807lgMY=;
 b=m95MRWpXiierAa4OwQTdjTUtYLIRYVKH0NFMPi0ZUZw6z8ncm2+8fMTKU5iuH8KPXe
 swtNiPcjc3Jg+eWiQ2aVbYqbKDNiRhJ6eluGS6ZEmI35uNuLzb8WetD2tEsQ5ra7Xqq4
 FcGPRBZArg32V3KkimcZQazaWHgXb2+qrDpFRXO2jcbdHbiBthJMKFusaJpYbGQAeFW/
 T1/LGMy0Pp+0FfDs3+yF8KzwavKpq0wdSIBl4a5Nar5+QJigA8Rp7CH7SApniXYHLzNr
 6JKxsCQgl6fysWWQ1EcB/iYMKfYhyXInW7X0EZFNrTtUVSQLEeK+DS6WOjMoVZpy16fR
 yGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690500863; x=1691105663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KSbLpaSE+UAqzzlGuBowjxWnHVXq8GMPqVPL807lgMY=;
 b=EGZ1aCNaiUrAufi9KhH9bQaCay/TZDiHpp4Dv6hOa0YhCrvsYyl6DxTau0RtmoTEVv
 1WGBcepzrZRCs70VxcoQd45p8fNiAAOycIz0lczHZ8QeAL51vXLRPN4/zR89gbZaT17I
 uK3Afh2snunVFG55BregxFuIugSSGBjf6zgHz6h8adsVSRA55JakqCgPBTUS8Jig3Jcu
 FTPywlRl4kNw+0/LPmMP2RsagShVd1oh2+TaoevJlsR0fQpbd8PXTEhlHkqdCUUZ+w+2
 W1/rEirEF8dC2rxkeMqC0xlVKpmeL0frOGwfrGOVkFMBvhZ03AKgFt3wjUoHoRhCbUi/
 /H+A==
X-Gm-Message-State: ABy/qLYcCaOtXnMiwUTs1lBHcxC8r7YkR/UqCu5BKxEC9x2L1pfiJmUG
 jOPmT4IwiECVu4Kv/LfSH5rkpAUTRoGEow==
X-Google-Smtp-Source: APBJJlGqze5h7e2ZCo2gBJwfiuCrFatP/r5yjjxXS71yyokgrVE7Vy4CQnt8+jA5bnMPMzvP5AH2CQ==
X-Received: by 2002:ac2:4f0c:0:b0:4fe:193a:e15c with SMTP id
 k12-20020ac24f0c000000b004fe193ae15cmr483321lfr.40.1690500862523; 
 Thu, 27 Jul 2023 16:34:22 -0700 (PDT)
Received: from localhost.localdomain ([185.9.78.206])
 by smtp.gmail.com with ESMTPSA id
 h16-20020ac25970000000b004fe0de39fddsm528241lfp.290.2023.07.27.16.34.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jul 2023 16:34:22 -0700 (PDT)
From: Mike Maslenkin <mike.maslenkin@gmail.com>
To: 
Cc: qemu-devel@nongnu.org, jeuk20.kim@samsung.com, stefanha@redhat.com,
 Mike Maslenkin <mike.maslenkin@gmail.com>
Subject: [PATCH 1/3] hw/ufs: fix compilation warning
Date: Fri, 28 Jul 2023 02:34:03 +0300
Message-Id: <20230727233405.35937-2-mike.maslenkin@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20230727233405.35937-1-mike.maslenkin@gmail.com>
References: <20230727233405.35937-1-mike.maslenkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=mike.maslenkin@gmail.com; helo=mail-lf1-x12f.google.com
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

This patch fixes a compilation warning: implicit conversion from enumeration
type 'enum UfsRequestState' to different enumeration type 'UfsReqResult'
(aka 'enum UfsReqResult') [-Wenum-conversion]

ufs_exec_scsi_cmd() returns a value from UfsReqResult enum.

Cc: Jeuk Kim <jeuk20.kim@samsung.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Mike Maslenkin <mike.maslenkin@gmail.com>
---
 hw/ufs/ufs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 1760e0f88d70..af32366c8504 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -514,10 +514,10 @@ static UfsReqResult ufs_exec_scsi_cmd(UfsRequest *req)
     if (!is_wlun(lun)) {
         if (lun >= u->device_desc.number_lu) {
             trace_ufs_err_scsi_cmd_invalid_lun(lun);
-            return UFS_REQUEST_ERROR;
+            return UFS_REQUEST_FAIL;
         } else if (u->lus[lun] == NULL) {
             trace_ufs_err_scsi_cmd_invalid_lun(lun);
-            return UFS_REQUEST_ERROR;
+            return UFS_REQUEST_FAIL;
         }
     }
 
-- 
2.32.0 (Apple Git-132)


