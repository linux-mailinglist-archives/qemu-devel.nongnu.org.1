Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D31E37B1D26
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 14:58:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqa8-00017c-V7; Thu, 28 Sep 2023 08:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3IHgVZQgKCpUEAz0zIJI5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--plabatut.bounces.google.com>)
 id 1qlqZp-00015E-HC
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 08:57:11 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3IHgVZQgKCpUEAz0zIJI5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--plabatut.bounces.google.com>)
 id 1qlqZo-00011s-4x
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 08:57:09 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-59f7d109926so159029647b3.2
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 05:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695905824; x=1696510624; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Puu8I37xVpYahsOAAGkvd/Km2XPYF5T2bftP83WPWhM=;
 b=H4foMKFJnJY4Upu60V8IOYNxT3RLcw8WukRK8eooQpp0G/JrETjon1aexekU7JwZQp
 fYE4xlyKn784Io4inWjZ+ZPdg+uVEstivwa4KG9gNebMOPNdhCYiXyhKv2O/+y3lISMe
 w6Pjccl87nDomtqjwOY0hrvLvO4aPuwFG7nVeVl1CySzQeFN/9X3Adwh3zOmrvPDCS2X
 1fILzdZ6D8NQ89VWjtTIkPJxKBe5zbVSn/BruBGwNItmrgpUwuf9mxeKyzH6CSh5dqJY
 t/DDyRh8YmctgYjRxS8GjKEwU430FwOZ2i1K7nKLRHCIPWxXT90uwfjsf+oobwRYlI+O
 caqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695905824; x=1696510624;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Puu8I37xVpYahsOAAGkvd/Km2XPYF5T2bftP83WPWhM=;
 b=cENrJHhb2crje3CsBx3yqgnVWTTiWkoO2tY+cFBe/xyeEMDg1knH7ZuCIXNksmEId7
 BTlv35mApt3uaHUUhJSsENuRUXvKrBIotS1CT0krLDL1cf5lIRT1o8TWPBBRPY24Py0m
 P/0XPdQU1S3WUd1J6iMeM/8Lg8GV+Mvxn8M7P3q9eYa3sS/PZ4LSQbirWXejw5GGIMUo
 +fZ6/YTkn9Og2og+rpjsBvCshOzRG5tw/S78T27G1Klo8WwzDqDOdcKRAJFYdS15V/8z
 Nt34Wh+WOQ+W/D8ORJxzJ0GFtXsJ/hMrv2R1XJqk2Pg7zI0nhPaXoetED//S6gWSkTsk
 sA/A==
X-Gm-Message-State: AOJu0YwZqFVXEqquDhQymkx7sUfYw81RpLzwqFbuzscdK8dUe7Ar11Fk
 zvEhsDPQyA9ihcknudygqlIkV+tP4t/TgA==
X-Google-Smtp-Source: AGHT+IG3qDWrWedhBeS1RRB0tQuAoGDsRZo1bc61MSsxdTmJsbgcNSxgKIFn6K9+qS2LjNnjopJsRCdTa+bwaw==
X-Received: from plabatut.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:7f2a])
 (user=plabatut job=sendgmr) by 2002:a25:abaf:0:b0:d7b:9830:c172 with SMTP id
 v44-20020a25abaf000000b00d7b9830c172mr18048ybi.0.1695905824694; Thu, 28 Sep
 2023 05:57:04 -0700 (PDT)
Date: Thu, 28 Sep 2023 12:56:59 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230928125700.1504442-1-plabatut@google.com>
Subject: [PATCH] Fix compilation when UFFDIO_REGISTER is not set.
From: Pierre Labatut <plabatut@google.com>
To: qemu-trivial@nongnu.org
Cc: Pierre Labatut <plabatut@google.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3IHgVZQgKCpUEAz0zIJI5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--plabatut.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Signed-off-by: Pierre Labatut <plabatut@google.com>
---
 subprojects/libvhost-user/libvhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 0469a50101..d4a2eab883 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -629,9 +629,9 @@ static bool
 generate_faults(VuDev *dev) {
     unsigned int i;
     for (i = 0; i < dev->nregions; i++) {
+#ifdef UFFDIO_REGISTER
         VuDevRegion *dev_region = &dev->regions[i];
         int ret;
-#ifdef UFFDIO_REGISTER
         struct uffdio_register reg_struct;
 
         /*
-- 
2.42.0.515.g380fc7ccd1-goog


