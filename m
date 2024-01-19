Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4C28330CF
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 23:41:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQxXV-0001ov-Oh; Fri, 19 Jan 2024 17:40:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cr@cristianrodriguez.net>)
 id 1rQvhr-0006E3-OM
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 15:43:16 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cr@cristianrodriguez.net>)
 id 1rQvhq-0001FF-8J
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 15:43:15 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d3b84173feso2219845ad.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 12:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rodriguez.im; s=google; t=1705696992; x=1706301792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qMK/ck443NPgefUDvFscXSZM/Rq7JLfVBhMQHA4hX7A=;
 b=gS9GIN8Y1VXi8H990wu3uj6qpp4iSXg0A+crQOfTKuJrZVmheqMdstrqdLYiUEx7jY
 6GdJ3btL7EcMBr4SHocvy2hBhotDypWILfjwItyybKyIzzjyQE4jOUu76YRRPeH7OjkV
 zRIJ4UNNjXEUCnrNkhsCm0MeZ1X8FtqrKPxXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705696992; x=1706301792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qMK/ck443NPgefUDvFscXSZM/Rq7JLfVBhMQHA4hX7A=;
 b=CbPKyHvlxFc2mM5zHQ9DebZABxf9A7Fp9rBceG+dPT9BqMbYuamT7n6GUM/T9m8pIe
 33vkowTQpimgTj5PQNhiDMJWP/OHrfTkbIloRGBo3YB/bDbtSM8sOG0W5suF1ca7dOD0
 1YpRN7Qxyh5JRFGzetBTcC1GxwTOqQify31KouLR7W1H5R3iatMg9xmHG0C83KqPLiXB
 EiO3zWhKP4Gnc2a4bs5uVJp9eG5XoDU8Pz/guKGydIPGqDjueHpBDgdhdurxI++y1bFc
 9HEMS+CeHvS1TC5i8RCgW/HZGAxZ/fNoYgOCbyOvomos3WI7F0oZJWND/cMfL+3pSsYh
 yp0A==
X-Gm-Message-State: AOJu0YyevsfMc6h0Cwlnr7Q2FAKw8RTV63XaXIkv71q/R18+CUIwH3F2
 /925ceqUY2lfWVZoqbl3WNtgDFAVCU3RpPjvtugvRKeUCerbt/nq9dtoWoH96RJq7EJhBgyrws8
 =
X-Google-Smtp-Source: AGHT+IFGddQpT5Im6muq0/7O3cZq7KKVTA9Iyw1BMMXbtGt9wNQVKh236dSOPmX8hl+SwXzaIDPQPg==
X-Received: by 2002:a17:902:d34d:b0:1d5:f258:ad3 with SMTP id
 l13-20020a170902d34d00b001d5f2580ad3mr970483plk.0.1705696992296; 
 Fri, 19 Jan 2024 12:43:12 -0800 (PST)
Received: from tumbleweedvm.. (181-162-59-228.baf.movistar.cl.
 [181.162.59.228]) by smtp.gmail.com with ESMTPSA id
 i1-20020a1709026ac100b001d538ee9ff3sm3398278plt.183.2024.01.19.12.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 12:43:11 -0800 (PST)
From: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <cristian@rodriguez.im>
To: 
Cc: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <cristian@rodriguez.im>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH] crypto/gcrypt: prefer kernel as direct source of entropy
Date: Fri, 19 Jan 2024 17:39:40 -0300
Message-ID: <20240119203950.6434-1-cristian@rodriguez.im>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=cr@cristianrodriguez.net; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Jan 2024 17:40:38 -0500
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

gcrypt by default uses an userspace RNG, which cannot know
when it is time to discard/invalidate its buffer
(suspend, resume, vm forks, other corner cases)
as a "when to discard" event is unavailable to userspace.

Set GCRYCTL_SET_PREFERRED_RNG_TYPE to GCRY_RNG_TYPE_SYSTEM
which must be done before the first call to gcry_check_version()

Signed-off-by: Cristian Rodríguez <cristian@rodriguez.im>
---
 crypto/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/init.c b/crypto/init.c
index fb7f1bff10..0c3fe6a841 100644
--- a/crypto/init.c
+++ b/crypto/init.c
@@ -60,6 +60,7 @@ int qcrypto_init(Error **errp)
 #endif
 
 #ifdef CONFIG_GCRYPT
+    gcry_control(GCRYCTL_SET_PREFERRED_RNG_TYPE, GCRY_RNG_TYPE_SYSTEM);
     if (!gcry_check_version(NULL)) {
         error_setg(errp, "Unable to initialize gcrypt");
         return -1;
-- 
2.43.0


