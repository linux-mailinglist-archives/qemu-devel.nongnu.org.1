Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DDF79DBFF
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:42:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgC4P-0002N3-0y; Tue, 12 Sep 2023 18:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgC4M-0002Hg-Pd
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:41:18 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgC4K-00016N-KJ
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:41:18 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bc0d39b52cso46688665ad.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694558475; x=1695163275;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95QVNg5HPZWQUU3gv/yGVv9Jo3t2dmNs4n1dgqSbSvE=;
 b=ov8TZdiMlMwap9Kkry8Een8UlsVfn/tMLe7MZzfcfq1mP5jN9vX65/igbcmRXl29AD
 LaLnjNB4uyt/0PTRrXZaPDPk32ffV8OgJWzs5IScPmTgvXNI2JxEy6IlB3czQ1gYxHrn
 oEtWdHRk3qxI3DposaX4Xr0G8IBB8Lb1cT8hw5sRjtfaR+ytuVNBzvqBb//TQsNdiAUj
 fZeaHYwdPSFUm1wZ4zv4Aa9gBGgFA75luv0h3Os8lt1s/dPdp61rUk5fLqGDbhaLiqCb
 gK2aCYJNRDA0YTTXLhT4oA6vdF0twBMduVmpmK329CAVidCr8UPqcYlnJNSTH80+qI+f
 rX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694558475; x=1695163275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=95QVNg5HPZWQUU3gv/yGVv9Jo3t2dmNs4n1dgqSbSvE=;
 b=v18/6gQasFNucQJZ5nYgIPB9OfHqz5uRc6Ir9HCQuCeZnsVCs0hMW6lDjac/eXIvC+
 oRJrmKJ9bFKBNvWQdJST/ceYvSg4J6OjkgU2vy9NVXv0TKQyLOXtDjCxPS/+NGK6ztQ9
 sgQpNu0773XxZzzj9eesXIGRovDBl5pRlFpxAUv+PBpqlPI62FZDNzSnTY45z5eIJ6xR
 d6mgvFo57ZpKDVdWutI3i6VU3XHI1uMz9+TpJWqX2fM9cZEfkMZss8uaKg2UW2vqA+h9
 2YCTrlzfanuYydRdWmz3ZFne1mkZdcCNgOu43MjkGIHI8YusZNTnsMiFMBp89/KRymv8
 DqVg==
X-Gm-Message-State: AOJu0Yy3tCmD4EiieTHqPvqKdtKDYyAaOGLapKUU1cPQ/HOiC37tC0FN
 zta6YrR95kwQYIrYLmUYBLQeQw==
X-Google-Smtp-Source: AGHT+IHzQUMd2Mewmi9j/mlV7jwW4T7lp/m5wO12KHHNti2S0jQ8U98oBpRbLd+BkN1fP97NUaV8xw==
X-Received: by 2002:a17:902:d4c8:b0:1bb:3a7:6af7 with SMTP id
 o8-20020a170902d4c800b001bb03a76af7mr1479805plg.23.1694558475080; 
 Tue, 12 Sep 2023 15:41:15 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a170902d34d00b001bbbc655ca1sm8996977plk.219.2023.09.12.15.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 15:41:14 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 01/12] gdbstub: Fix target_xml initialization
Date: Wed, 13 Sep 2023 07:40:50 +0900
Message-ID: <20230912224107.29669-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912224107.29669-1-akihiko.odaki@daynix.com>
References: <20230912224107.29669-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

target_xml is no longer a fixed-length array but a pointer to a
variable-length memory.

Fixes: 56e534bd11 ("gdbstub: refactor get_feature_xml")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 gdbstub/softmmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub/softmmu.c b/gdbstub/softmmu.c
index 9f0b8b5497..42645d2220 100644
--- a/gdbstub/softmmu.c
+++ b/gdbstub/softmmu.c
@@ -292,7 +292,7 @@ static int find_cpu_clusters(Object *child, void *opaque)
         assert(cluster->cluster_id != UINT32_MAX);
         process->pid = cluster->cluster_id + 1;
         process->attached = false;
-        process->target_xml[0] = '\0';
+        process->target_xml = NULL;
 
         return 0;
     }
-- 
2.42.0


