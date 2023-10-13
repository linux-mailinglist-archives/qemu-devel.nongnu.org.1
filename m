Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF2C7C8007
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:23:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD54-00053D-5i; Fri, 13 Oct 2023 03:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4s-0003Vd-NT
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4q-00077d-SX
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:22 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-405497850dbso18952585e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183959; x=1697788759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZujHeHq70xM9MPj8kQG27kLbICCwKFbj8+Ro2luQ6VY=;
 b=AZG6DPzpIFDnnYn2G56y/WLk6g6wtZ0fVA0xLuKiB1zqlLzCO/H+yDImS2mLlKzrli
 KcDvEkQp8TJw2jirq1p1pCD2MMd/j3NU+Zr5KQKhO0Nrd3sMPjnaCzioMcpUZumxp34E
 D96SlCAfWOmrD4OU9kIo3mPgpDtFv/Di1+iaY8Rg/w4AltnOH9xKN9ZA3c6y2hwGXkh+
 cCl0Ax2ocyZTl0kY1AO4bU0Ea5ajMJNtUEHdcgihrhaUA9MZP9xW3LTNZD0vN0yyo9/P
 wdxl7T+HYl4fR3KPYlpqjbCPN8XLXK+M+7X+LlF3St1SuOcEoV9ND2Kephz3+vjqaAhs
 vxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183959; x=1697788759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZujHeHq70xM9MPj8kQG27kLbICCwKFbj8+Ro2luQ6VY=;
 b=U8IdbNlz+icchQecNxcfAR6vftgdCIqsfWQQ373N1MHW5qCWyn+za8Jt3FqbtgPg2j
 jJQem9MrZvl9buXY3k7aOn1ylGyOk3+vHPI65HwZLv7rt0iGBjMnSGCdvEr7oKBfv42k
 yG2pkUkFoiR9CTuf8+HvOhOdm9TOO4DtOPhQN0SDq6nVqCrqD1pmFyTn873jjF/KP+1v
 Loi4hswHDOhV5yAtNdgjR50HBHFBNjTq9+JCWAwnzYAQbxue5iVmoAOVPBRh+UAioqqM
 kyD7XR5Cg8z/yrXMh5cHJC94uw+6XLXr3TkYHf1rTn9bFptqGGQtZeH4W3rbGEI8pcYT
 5xzg==
X-Gm-Message-State: AOJu0YxXA3vofmymi9gIFpAkmolDPt61OxEIEUncfENrsvisAZ7jTixM
 KYKeuTvjPOjcS1h3n9LkHfaYFnCg9Ko3ee94U7Y=
X-Google-Smtp-Source: AGHT+IFCQjt4pPr3IG0FGLToBw/HjV1PWhiOVU6X3+7lE7B4dnV8YWs76BY1uAOD6Ve9myzgzpOBLw==
X-Received: by 2002:a05:600c:22c6:b0:404:7659:ba39 with SMTP id
 6-20020a05600c22c600b004047659ba39mr24085927wmg.16.1697183959109; 
 Fri, 13 Oct 2023 00:59:19 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:18 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [RFC PATCH v2 48/78] contrib/vhost-user-scsi: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:15 +0300
Message-Id: <f5ba45aeb80d3f41af2a5e2c87e8b212a7435670.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x335.google.com
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
@@ -109,14 +109,15 @@ static struct scsi_task *scsi_task_new(int cdb_len, uint8_t *cdb, int dir,
 static int get_cdb_len(uint8_t *cdb)
 {
     assert(cdb);
 
     switch (cdb[0] >> 5) {
     case 0: return 6;
-    case 1: /* fall through */
+    case 1:
+            fallthrough;
     case 2: return 10;
     case 4: return 16;
     case 5: return 12;
     }
     g_warning("Unable to determine cdb len (0x%02hhX)", (uint8_t)(cdb[0] >> 5));
     return -1;
 }
-- 
2.39.2


