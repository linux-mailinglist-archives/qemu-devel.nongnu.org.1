Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7A8835A0B
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 05:24:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRlqc-0003Qe-H7; Sun, 21 Jan 2024 23:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xun794@gmail.com>)
 id 1rRlqa-0003QB-HM; Sun, 21 Jan 2024 23:23:44 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xun794@gmail.com>)
 id 1rRlqY-0005ah-UP; Sun, 21 Jan 2024 23:23:44 -0500
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-3bd562d17dcso2431375b6e.3; 
 Sun, 21 Jan 2024 20:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705897420; x=1706502220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IJhnjPdUZ+IQEvpj0YfSpo3lIC5cWTiEI3R7rmUUuj0=;
 b=fILeNk7L8i+ufAFcM12FBF+2f7+6X9HgTzIkMg0PZWbByw5NVbeDA1qR7zE10GoNZj
 W4oFIZFE5OZ7PfAej6Twjpz080NbT4Cw3f12aAIUG/3iEz1w0FXNfE39HrM6DRFl0Kf1
 hWFG7V+PHQGPDTF0wPqBldlaxHvzMc185qgQ8WcG1ld6TG0Y9e+GJ/oQo89sekSn+8i9
 oUMTWiMP0lUoq7LIx+9quy7jWJ0SQkpedH7UW5CFcaUgjnumKr3xwmZJBgnQ/YvG/Bnn
 KqSNJ630L1TMK8IB0Kx/K9BuvE7e3h/yV81BVX4xI7gqIzTfCN5rF7nEtpnnCytGPc5Z
 eDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705897420; x=1706502220;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IJhnjPdUZ+IQEvpj0YfSpo3lIC5cWTiEI3R7rmUUuj0=;
 b=sQUVrqrtjc9JrxctlokhPf60crizTQ+dnThOX6ki8SokPQUUzynjyfju+p+SINpbmU
 nJ6fXbsmruaDHfiI3h9UmiSri6KqZHH6BEUH7hNCf1T7nd/AEObGDitR5FbMlCE1BhBn
 a4Wp2u7FeBIFlKXbUqwS5EL+vfAa5xJha9Hut3SQLMZVOnELj6mK+3SZR936h4Be4amp
 NrSbdbuTkm1tzkVzqLw0lBpsjY2GMsNHHSIK9rfnPL0kEA2HWgFmsjdrMujalZfmWplc
 Q8TX7vv8diHx9NfbVXtCMs1HsD4x2z1sPVHn2i25XFsoZpNdpT7nyS7tdami+M7qZRrF
 v5FQ==
X-Gm-Message-State: AOJu0YyXz9Wm2lzVwkr5vsyZXdIMyTzBrapqS077+WE/eul7p/0uC9zA
 pj+d3bHApC4OEyUH4bJgQB72hkB0M9XtqXLIXgfob+SUPjBJlpx6YHffdOt/6+o=
X-Google-Smtp-Source: AGHT+IFt4XNHPN/rha3AeVWe09NSBQc0OSriQ8oKxkLDigwkg/6stxeSKibqMwf+KJ2bA55BsWMrvg==
X-Received: by 2002:aca:1109:0:b0:3bd:8e27:71a4 with SMTP id
 9-20020aca1109000000b003bd8e2771a4mr3963348oir.76.1705897419707; 
 Sun, 21 Jan 2024 20:23:39 -0800 (PST)
Received: from localhost ([2409:8a20:ae8:e8d0:1e6b:fd1c:8c41:31ba])
 by smtp.gmail.com with ESMTPSA id
 l185-20020a6325c2000000b0056606274e54sm7478790pgl.31.2024.01.21.20.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jan 2024 20:23:39 -0800 (PST)
From: Yihuan Pan <xun794@gmail.com>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org,
	Yihuan Pan <xun794@gmail.com>
Subject: [PATCH v2] qemu-docs: Update options for graphical frontends
Date: Mon, 22 Jan 2024 12:22:06 +0800
Message-ID: <20240122042206.25585-1-xun794@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=xun794@gmail.com; helo=mail-oi1-x242.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The command line options `-ctrl-grab` and `-alt-grab` have been removed
in QEMU 7.1. Instead, use the `-display sdl,grab-mod=<modifiers>` option
to specify the grab modifiers.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2103
Signed-off-by: Yihuan Pan <xun794@gmail.com>
---
 docs/system/keys.rst.inc | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/docs/system/keys.rst.inc b/docs/system/keys.rst.inc
index bd9b8e5f6f..2e2c97aa23 100644
--- a/docs/system/keys.rst.inc
+++ b/docs/system/keys.rst.inc
@@ -1,8 +1,9 @@
-During the graphical emulation, you can use special key combinations to
-change modes. The default key mappings are shown below, but if you use
-``-alt-grab`` then the modifier is Ctrl-Alt-Shift (instead of Ctrl-Alt)
-and if you use ``-ctrl-grab`` then the modifier is the right Ctrl key
-(instead of Ctrl-Alt):
+During the graphical emulation, you can use special key combinations from
+the following table to change modes. By default the modifier is Ctrl-Alt
+(used in the table below) which can be changed with ``-display`` suboption
+``mod=`` where appropriate. For example, ``-display sdl,
+grab-mod=lshift-lctrl-lalt`` changes the modifier key to Ctrl-Alt-Shift,
+while ``-display sdl,grab-mod=rctrl`` changes it to the right Ctrl key.
 
 Ctrl-Alt-f
    Toggle full screen
-- 
2.43.0


