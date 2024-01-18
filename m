Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBB1831D27
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 17:03:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQUqi-0000kZ-LE; Thu, 18 Jan 2024 11:02:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQUqd-0000af-9I
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 11:02:34 -0500
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQUqb-0004lB-C5
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 11:02:30 -0500
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3606f8417beso2326655ab.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 08:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705593748; x=1706198548; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=q9PVY4ICZry6ITKlLjzlvvWiT+Z+5Ew5y3QZQic0tO4=;
 b=YUrSHc4P6XK6c7zUvYpJGBoHxmko0z/ngEjiLLxvQVWmRkDGL32wMtqi7J8cHYF3ZV
 5FxLhskQCu1fff0dkYBuZrAzZx5LJ5wfKaLxzfzy6tUKNKxN/tsPG+Jz8s2ejeIPsndR
 4hHcLbUf8eiK3o/xPhG0dE1OC3PKo5wchv2mPDxV5R7L7owjiT+jibY6a1wVN0IazcrH
 ckBgHTMXsZOsxiQaoyPoiMYAx2fhmcwtpQ6tHmLIF5KlR0b0HlBXys5lFaOZQkvyCdEh
 VhRxwVpnkUijcndduHlFN2d/JEzzP99IdNpQxju2gpNopfYDqTBPuD6vP30lUlTX/zXK
 4t3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705593748; x=1706198548;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q9PVY4ICZry6ITKlLjzlvvWiT+Z+5Ew5y3QZQic0tO4=;
 b=WoXuVaTOT7tab7Tv72TtDDXmhsx9Epq1QA8rIMZTat+tQvz5fXCQbO8FvrmMKmVzOU
 eNwB4MOF5iO3WRmYoM+pmDMim7jRYGpu63ZcZk8Sm+MEo1ACpV379Btr7WXN08Ufxh3o
 Abz+KEeEn1NIDbxC/Mp55qyuQ7qLdZp7RQxxH/Vx4cc9IGa6Q6mTJMsJfK0GBn3oCJQZ
 G689vl64HL9bHZjikvblaN6g0lIKkEUlFdwu6KxGTq5aQKS9QBc7Utt3S4lmx7ak2jYX
 7xv2Lm501C0p7oFX6Yjw0BP6JhWXZB/7pBUYlZ1qfJ0zQBvtHaS+JLd75MhY2smis1UE
 Ztvg==
X-Gm-Message-State: AOJu0Yy/Tn6zeGhVY8DGwp0OVT0Vw/8MvIK6S2sipZrv3gT6uzkv0w1q
 3ljZwuGAf/8lZ5stHfDL7Bz0CSea97kL3k9m7AAE0UU+gJAsUMOR1vmebwh9OSooFM8cIRcjBvS
 MtVO2Kf3lpw1HGhQspSL7vSaK+HH6i0M+jI0=
X-Google-Smtp-Source: AGHT+IG2EneS7CoAUfjaK2Gn4UycsPH/lw8YeSClns3kyAH9F8JgQSHZw3kqr3kVzWLwiv93gn4iUCR9ER+wfCtG+KU=
X-Received: by 2002:a92:c142:0:b0:361:8dc6:30f1 with SMTP id
 b2-20020a92c142000000b003618dc630f1mr783664ilh.17.1705593748221; Thu, 18 Jan
 2024 08:02:28 -0800 (PST)
MIME-Version: 1.0
From: Manolo de Medici <manolodemedici@gmail.com>
Date: Thu, 18 Jan 2024 17:02:23 +0100
Message-ID: <CAHP40mmk4cPk6ZHETfq5BtQxK63A6PiuCKrvv4yyOPBxVTW+OQ@mail.gmail.com>
Subject: [PATCH v2 1/4] Include new arbitrary limits if not already defined
To: qemu-devel@nongnu.org, bug-hurd@gnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=manolodemedici@gmail.com; helo=mail-il1-x135.google.com
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

qemu uses the PATH_MAX and IOV_MAX constants extensively
in the code. Define these constants to sensible values ourselves
if the system doesn't define them already.

Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
---
 include/qemu/osdep.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 9a405bed89..9fb6ac5c64 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -363,6 +363,14 @@ void QEMU_ERROR("code path is reachable")
 #define TIME_MAX TYPE_MAXIMUM(time_t)
 #endif

+#ifndef PATH_MAX
+#define PATH_MAX 1024
+#endif
+
+#ifndef IOV_MAX
+#define IOV_MAX 1024
+#endif
+
 /* Mac OSX has a <stdint.h> bug that incorrectly defines SIZE_MAX with
  * the wrong type. Our replacement isn't usable in preprocessor
  * expressions, but it is sufficient for our needs. */
--
2.43.0

