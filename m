Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 462187F6A51
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 02:56:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6LPM-0007S0-Ul; Thu, 23 Nov 2023 20:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r6LPL-0007Rm-6M; Thu, 23 Nov 2023 20:55:03 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r6LPJ-0002CX-Ln; Thu, 23 Nov 2023 20:55:02 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cf8b6eb13bso8514575ad.1; 
 Thu, 23 Nov 2023 17:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700790899; x=1701395699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0J3kfUApwkxX9Zc14ulBPLKVHaQgxTKBvXoqbfNts+c=;
 b=I877FQsgoUiFmbAaQqYpizAj6ILVA/9dKWJba7x2AxXT5Xfftkb+Bx2pd4OMCrjfOI
 E4xbgRbkZn9+G4AmnnIv0OoIXvuVTBwakDAK9weH6EWClS2k/TVRoLsIHNbWA7037ycG
 IbM95r2f8teNSknNHhGoiDPwqQxa4dX6rfDGOPUS2ZHg2mkvn3mN+DOxhM7xayoqmJ1S
 Mvj6Kgm7CCKA6CqhVMDW1Vl9IC8n8V4wc0eRnYFV3mRtYj0o6yvQxif5APYRm7QwfAuv
 DpvyDeKee+YKqGxnRq95K7ihFreg0RsRb5B3CKjQEQpqryTN9i92doqRtGAkxZ+Ps7P8
 rD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700790899; x=1701395699;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0J3kfUApwkxX9Zc14ulBPLKVHaQgxTKBvXoqbfNts+c=;
 b=rnMpYksPJMTplzdbUQbSHTF1JxqrJKrU9/7wLoHPD28KBqG3/Ivrbm2KF5aIrZ3j2W
 pAhwe1yovr0QQWu0VtepxZOjFoc9uznXGxR2CBkGexo5lWt04354YQL/+HvlIwy18xHk
 yVklLXEkIhziBqPEu/5hUExfp6NKtISIAEL2Cy2NCa6ERo9Kx/cp0LUW4+FHL61wBkVq
 gjpcdw8B6bscfhomlcR4uAcBwdlQTlRzBWu/tC8nWOTsCFYmPkdtvRR6ts7VNneL5kYc
 BGVi/SZZVZrpomSHgIhkYv0fDN2/c2xGDlqjTN8PbdYnvmjol5F/0yWQLmzr1xF1qUsT
 BGSg==
X-Gm-Message-State: AOJu0Yw2Z/aDNCiF3R1UH+YlUrxguXoteHRKQZjDOwiTclA02VzfP5zv
 LuBp0H0Gc22RAnM/KzMcGa50HyM52J/l7A==
X-Google-Smtp-Source: AGHT+IHtQRWYgHplGgqAsp730h1vqU7vgvVSpyEXgMatqBbSqT+jhqI6wcAAft3dxRGaUlvv/UhWfg==
X-Received: by 2002:a17:902:ea0c:b0:1cc:5920:1d1c with SMTP id
 s12-20020a170902ea0c00b001cc59201d1cmr1274599plg.48.1700790899498; 
 Thu, 23 Nov 2023 17:54:59 -0800 (PST)
Received: from dhoffman-NUC13RNGi9.hsd1.or.comcast.net
 ([2601:1c0:577f:e480:7a45:b229:928d:88fa])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a170902680600b001cc51680695sm2041481plk.259.2023.11.23.17.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 17:54:59 -0800 (PST)
From: Daniel Hoffman <dhoff749@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Daniel Hoffman <dhoff749@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH] hw/core: define stack variable to NULL to fix qtest with
 sanitizers
Date: Thu, 23 Nov 2023 17:53:12 -0800
Message-Id: <20231124015312.544422-1-dhoff749@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dhoff749@gmail.com; helo=mail-pl1-x633.google.com
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

This was the only failure preventing `make check` from passing with sanitizers
enabled on my configuration.

Signed-off-by: Daniel Hoffman <dhoff749@gmail.com>
---
 hw/core/qdev-properties.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 91632f7be9f..4caa78b7bc5 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -690,7 +690,7 @@ static void get_prop_array(Object *obj, Visitor *v, const char *name,
     uint32_t *alenptr = object_field_prop_ptr(obj, prop);
     void **arrayptr = (void *)obj + prop->arrayoffset;
     char *elem = *arrayptr;
-    GenericList *list;
+    GenericList *list = NULL;
     const size_t list_elem_size = sizeof(*list) + prop->arrayfieldsize;
     int i;
     bool ok;
-- 
2.40.1


