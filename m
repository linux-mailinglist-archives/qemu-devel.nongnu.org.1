Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E33A714212
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 04:37:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3Sl2-00022u-Fr; Sun, 28 May 2023 22:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q3Sl0-00022l-7f
 for qemu-devel@nongnu.org; Sun, 28 May 2023 22:37:14 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q3Sky-0007ve-LB
 for qemu-devel@nongnu.org; Sun, 28 May 2023 22:37:14 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-52867360efcso1689257a12.2
 for <qemu-devel@nongnu.org>; Sun, 28 May 2023 19:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1685327829; x=1687919829;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y/66hfExbGZ3tjBqPhYXz7LQz2FFZ7y3XJ1eS2f/Miw=;
 b=RwFyqwJneec2ncHpIiubj3CTjEcmsNCpF6Rbw6LFnf54VtjWfUpwIZ3so32/SDY5n8
 7IqTfdBh1rFlU4flmXVGvDVzI+UzJ+GSaZQE6IUiOhxB9fA3pQ2mB7DvtjWQ4pyQL5pS
 gbW6gLy9+99FfVhwk5XXB9wVO1I8lxT/quy8Fn8vz/1csZtVvVlMcM7Uw2dm1pCWC0SJ
 7zAEqyRi5MN6CqZiYxLaF9Z3Mc0ABWFXbzsUUwrQsut9/540zrxsOhl3NZYB3TZ7J8IG
 +qhTgCeb+Cu07XZOmLUr+KydawwTqbagSTkNjxW5FSJzAna6w0uqYZ6zQ8E6wJq/slJU
 b+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685327829; x=1687919829;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y/66hfExbGZ3tjBqPhYXz7LQz2FFZ7y3XJ1eS2f/Miw=;
 b=Qt3inn8wnJ/n2nlq5mV2ZdVXT4dhclEWKQNEOc8YXHfBHC/dh0t0UVSfcpcqDe5vLI
 YgpdkZI9tz9hRSbiSGwHBl3hpYVPxWbNFVWm0xdtmKT1QmSGaePFLmB0zEVbskR+5cks
 7Vx7Iu1kbm/S9frKRHOUKToRBVwRXKNyd3R/rz4LARjNrpUbgIJHjs9qwlKsqBi99XtH
 HW+Fjze473gkzrEZJCMTYkUxIph/QTXFN1ri0qwnvdpqdg6bYJ+MFUJMkgNQMCues+Cg
 DhiqZZBHdWfb86xLNxmj8C4cXkWqs9l8z1MvehIg/CNwbr+++768nv/7EG3ji6ZKYVWL
 IeJQ==
X-Gm-Message-State: AC+VfDz+Z0rtI0gcSwTfhYJ7TeVCthE+Hr81vm6IOTYyCPticIFznaLI
 IrWzUe7BnlolKlihskq+X0Mecj/vuoOPUoO8Qz4=
X-Google-Smtp-Source: ACHHUZ7rO+tc18ygsvVBexvFBswve4jSBIXTm0Pl3my3yx6XD9oPj4p2kP7CqgB+2li8kUouLyuwag==
X-Received: by 2002:a05:6a20:54a6:b0:10d:b160:3d5c with SMTP id
 i38-20020a056a2054a600b0010db1603d5cmr8106770pzk.12.1685327829089; 
 Sun, 28 May 2023 19:37:09 -0700 (PDT)
Received: from alarm.. ([157.82.203.253]) by smtp.gmail.com with ESMTPSA id
 h15-20020a62b40f000000b0064d2ad04cccsm5882580pfn.175.2023.05.28.19.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 May 2023 19:37:08 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH] igb: Remove obsolete workaround for Windows
Date: Mon, 29 May 2023 11:37:04 +0900
Message-Id: <20230529023704.9387-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52b.google.com
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

I confirmed it works with Windows even without this workaround. It is
likely to be a mistake so remove it.

Fixes: 3a977deebe ("Intrdocue igb device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/igb_core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 97bb5c84ce..abc9bbe937 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -2677,12 +2677,7 @@ static uint32_t igb_get_status(IGBCore *core, int index)
         res |= E1000_STATUS_IOV_MODE;
     }
 
-    /*
-     * Windows driver 12.18.9.23 resets if E1000_STATUS_GIO_MASTER_ENABLE is
-     * left set after E1000_CTRL_LRST is set.
-     */
-    if (!(core->mac[CTRL] & E1000_CTRL_GIO_MASTER_DISABLE) &&
-        !(core->mac[CTRL] & E1000_CTRL_LRST)) {
+    if (!(core->mac[CTRL] & E1000_CTRL_GIO_MASTER_DISABLE)) {
         res |= E1000_STATUS_GIO_MASTER_ENABLE;
     }
 
-- 
2.40.1


