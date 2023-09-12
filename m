Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E76779C74D
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 08:59:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxLx-0000NM-4k; Tue, 12 Sep 2023 02:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxLu-0000KJ-5g
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:58:26 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxLo-0007RX-Ts
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:58:24 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-26f3e26e55aso4148987a91.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 23:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694501899; x=1695106699;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95QVNg5HPZWQUU3gv/yGVv9Jo3t2dmNs4n1dgqSbSvE=;
 b=BExj3Mwr+t6oVjUxfHXNY59BdT6gAVocQrKbf5bmMwlTmxLoRIQOF2xqPk84TRto/i
 ElvoYzPCFVcc1nK+ueMYmXRngLhg5fVr6W7F14htwY/ZXXXgqeIxs68CbxVdOOdCzSRH
 HIJ2F+rD/SHpZfO439W4/JvNgL05M85JMidzNfcpoi2mOx/xePI5RnS0jkMWy3+1oSOl
 rxYK4YsBfyUT9JZ0wbvT2V7/Ci/OKbkVGLF3Ad2JUG1LWsivXi9oZwKksaUUztHXm4iN
 yc0vO2t5nIUyjH/r5IRe7Mt4e2Ov1F3OzU4bNmne17Ml0wlyjlj43rVoi8w0kC0U/Lkr
 XxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694501899; x=1695106699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=95QVNg5HPZWQUU3gv/yGVv9Jo3t2dmNs4n1dgqSbSvE=;
 b=D2lNa70e2yRxIDLfZ+sLHjYzgAGceyIVlQVICIrvU5O39Q9hX4HiXOGr0tw/uU5ea/
 NecunSElsNeEGmT00zVDs99/tBRoD8bC9lbtcjAtV0Z7u85pTFJeGEz6IIXOIF1w+gfy
 9STIDizLtGiqzYz4ePZNjzZDjW3CxCCFO7BcnoT95A3bAkL2o/uFAJKIUlYGUciJ4+GE
 i1acjOAc619LUV/L6H6ExjEQr0pnK/+C4qwplymmof2O23x1PqMt2hsY/f17kgAgdD4q
 TDey+3emomlVoiXGSIWRsTo4dFxGuHbS46MNHxBrKVNOjsyq2CuBYM4eCj/e8Gty18yr
 MvYA==
X-Gm-Message-State: AOJu0Yw5dwFefriW2AIva69a8/v8rv3Rap0/DEd2toJ3FQScln+zbfhk
 VdYjvbXMmmoTC8FGeuxw9Q9lHi1+IsrfsosY0Zg=
X-Google-Smtp-Source: AGHT+IEYdAUwOFXmuQlEYsLpfeBlNpCUKVA7JrtlQPqTCHSrEHBb92xLEVqp/PC16xG+5EaVx7ty5g==
X-Received: by 2002:a17:90b:3910:b0:26b:5ba4:4948 with SMTP id
 ob16-20020a17090b391000b0026b5ba44948mr9838725pjb.12.1694501899736; 
 Mon, 11 Sep 2023 23:58:19 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a17090a2ac800b002696aeb72e5sm9315058pjg.2.2023.09.11.23.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 23:58:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/11] gdbstub: Fix target_xml initialization
Date: Tue, 12 Sep 2023 15:57:56 +0900
Message-ID: <20230912065811.27796-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912065811.27796-1-akihiko.odaki@daynix.com>
References: <20230912065811.27796-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1033.google.com
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


