Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2F97C80B9
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:50:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqd-0000sO-0e; Fri, 13 Oct 2023 04:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqY-0000hx-HW
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:38 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqV-00017B-Ef
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:38 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-307d20548adso1689189f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186914; x=1697791714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IsmYddvsN6EQQNGHU8aHCTqFxBTD35fmPEeBO4eL5ks=;
 b=WTkfQAGKsMDq7oStO1kjwqIEDA4UWBjpJPAPxETjWusEjtFSmzZqiPJ3KOXFclpa1y
 8qqlbHf1I1gEX8CpY5Qr2v6VIlzZIBWA7brDp/3DqI7sszpUgUcLLSmebs8s9XN+3sNj
 AyIKFdTz60EYUVAHe/gyu2dIGnkkjKVBeMLYI98lDQoVW1r/qGVmXbrBLD5LI73ndWuq
 na9KHEnEGUXC4cOSQ0MitAdtQpwuIO7bAZ6/Vv88rBlPBCCE195BBP5zcarWxU0mVHOk
 OBMlMQSFgBqtvPTQeAmVl5Pw8zTVT2STyf2PpOtSpihj6m7ZYnJPKadPJKVW7vi4cl1e
 g/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186914; x=1697791714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IsmYddvsN6EQQNGHU8aHCTqFxBTD35fmPEeBO4eL5ks=;
 b=v69ruFRBJWJG6bDrGJM7jNB2TqWe6AT98I6txjFj6tw307PwU8TM26OZqR9YMcg8Ye
 H5GJ2bbfPbZGFr4gIzmYj5RWl8HfEZ8SyymrKUa8b7felmXuWAJ52t2042v6ehIaPIaE
 X95jR0EcwSpmpIl//E7PYntCuc6JeXgxp+I8e20Kklr8FUPyY20obbOQGhTn3tyhg+6/
 wy5FcSO04Fc6nWrGfaZT/lxPaHm/QQ0H1mAr/oU0/ZZnhsVeNFLB0L3v8ZoIQ/srf61g
 n51vJHjvkW9t8Mj+HKBCMKD/psIEpXrOoinnTFc5tvzMWih2TT+jXtPNToDKr+8MAeCN
 KvwQ==
X-Gm-Message-State: AOJu0YzHkX14N+3f/YsK5PSp8rbhdaqpKdSVqNgEORfRKadndC6tm6RG
 A1mOPw+cSLfe2K4ucq8zLgY1znA69BlYTjarfxc=
X-Google-Smtp-Source: AGHT+IGbBbaEEsyKD+rtnaFQL+oHBPPBMDVU0SlW59WxnYRasFNL4hFKiqETnt65PnySqt8Ni8huYA==
X-Received: by 2002:adf:f54d:0:b0:32d:8c90:cb28 with SMTP id
 j13-20020adff54d000000b0032d8c90cb28mr4236473wrp.45.1697186913885; 
 Fri, 13 Oct 2023 01:48:33 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:33 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [RFC PATCH v3 48/78] contrib/vhost-user-scsi: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:16 +0300
Message-Id: <6eca13bc88f2f17ae6a5761bd857ebe87145b104.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
index 9ef61cf5a7..71076f579b 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -112,7 +112,8 @@ static int get_cdb_len(uint8_t *cdb)
 
     switch (cdb[0] >> 5) {
     case 0: return 6;
-    case 1: /* fall through */
+    case 1:
+            fallthrough;
     case 2: return 10;
     case 4: return 16;
     case 5: return 12;
-- 
2.39.2


