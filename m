Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8086A8312C9
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 07:41:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQM4H-0002m6-EW; Thu, 18 Jan 2024 01:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xun794@gmail.com>)
 id 1rQM44-0002ku-Rj; Thu, 18 Jan 2024 01:39:50 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xun794@gmail.com>)
 id 1rQM43-0002XA-2N; Thu, 18 Jan 2024 01:39:48 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-6d9af1f12d5so10198304b3a.3; 
 Wed, 17 Jan 2024 22:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705559984; x=1706164784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GR9pOvCXwXpLyLM6JJ5YnP4raOMjph+ANW69uOoX1L8=;
 b=mageH97FqluYoU2zjSG9MoWVXaIuEQ1XhltF12Vub41TKZDW4pPIkjAYwMybVpJNpQ
 iWZ58iXiYnqgykmGPy6KREWQF5GLQPZzTB3vv5bPuYIvpeYe+zXrkP/Fh0QHFGcum3w7
 wRCTK7aJuiC4DVPKmH5ADx2+q+XccLNblV9t2CeMuj0xceL2+36m+8CMGX11HRHyaT2G
 xnQ5eRyRn/FAWI6njQCIzr8gxiBkGGSmztzv72ie+J4KDfvWmIHgHiYoYhUTBzqkVbqn
 WPt9fy/dj9Ch6K4ygf5qeLeqc4p2oA3ZWmhTizYr5wA/7iqLMe7xPVT850txO7tM8CrM
 qyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705559984; x=1706164784;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GR9pOvCXwXpLyLM6JJ5YnP4raOMjph+ANW69uOoX1L8=;
 b=coRCjfsD/PUX9YerofI4wvtzEh/ewrHUMRuESmJAbqDiHULT3LZpX5Ngq6ArUUhiL3
 3XplSfVXRFGt5JEiOf7yGjP1hSjl/4QgeAzLPsRSMj3mK6RVwgIZf7NX28fM9ltdfgIh
 TsWdh1USklZlaSZkKltX7VWNouT37unArH6FVbzNXQEyaeNv7qMVpA9ar9T9AQweKW2u
 fyQv4lH8qT95YM8nbN7IkJCnD7i54i69w0hqmeZ6zSV4EZm5D4VNsBKGSioNzd/0SuF8
 L0O5Y+ipmC771mvY4QWJyIky88OfGMYpsnxppBbWWLYEZlUUCjvpHA4CAR2PUCDFZ87q
 Iv/A==
X-Gm-Message-State: AOJu0YynAsTJxu2Yx6956iqDM1K6jikwaVgVZKZEBz9HdaKIVZMUbwDj
 yy+ANt+Rgypf4v6GrfwPGNeK5bLCWFz7HLEd7GVcNtXTLqBNQj8xiNVKmvAqVlA=
X-Google-Smtp-Source: AGHT+IFk683oCZdZNIX1ZWMZJq/ENFtW5HqiRvwlrmKXRnPc5icB6Qa6i90hKZHJP6XEFNFlLASPOw==
X-Received: by 2002:a05:6a20:7d8e:b0:199:a6cb:20ab with SMTP id
 v14-20020a056a207d8e00b00199a6cb20abmr484703pzj.123.1705559983639; 
 Wed, 17 Jan 2024 22:39:43 -0800 (PST)
Received: from localhost ([2409:8a20:ae8:e8d0:1e6b:fd1c:8c41:31ba])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a63d74a000000b005cd945c0399sm748552pgi.80.2024.01.17.22.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 22:39:43 -0800 (PST)
From: Yihuan Pan <xun794@gmail.com>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org,
	Yihuan Pan <xun794@gmail.com>
Subject: [PATCH] qemu-docs: Update options for graphical frontends
Date: Thu, 18 Jan 2024 14:39:30 +0800
Message-ID: <20240118063930.190918-1-xun794@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=xun794@gmail.com; helo=mail-pf1-x441.google.com
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
 docs/system/keys.rst.inc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/system/keys.rst.inc b/docs/system/keys.rst.inc
index bd9b8e5f6f..44698e301e 100644
--- a/docs/system/keys.rst.inc
+++ b/docs/system/keys.rst.inc
@@ -1,7 +1,8 @@
 During the graphical emulation, you can use special key combinations to
 change modes. The default key mappings are shown below, but if you use
-``-alt-grab`` then the modifier is Ctrl-Alt-Shift (instead of Ctrl-Alt)
-and if you use ``-ctrl-grab`` then the modifier is the right Ctrl key
+``-display sdl,grab-mod=lshift-lctrl-lalt`` then the modifier is
+Ctrl-Alt-Shift(instead of Ctrl-Alt) and if you use
+``-display sdl,grab-mod=rctrl`` then the modifier is the right Ctrl key
 (instead of Ctrl-Alt):
 
 Ctrl-Alt-f
-- 
2.43.0


