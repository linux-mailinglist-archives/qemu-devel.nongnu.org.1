Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F23277C7F1B
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 09:58:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCyW-0003mE-C1; Fri, 13 Oct 2023 03:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxo-0000gS-DN
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:52:05 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxR-0005Bl-Pj
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:57 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9936b3d0286so299221266b.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183500; x=1697788300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZujHeHq70xM9MPj8kQG27kLbICCwKFbj8+Ro2luQ6VY=;
 b=mDxEdh4dfYE7uqecmq5SCTkEPwgklVuH9i5yVqnK9g5+jhkaxh2Sp4CbekUhbQj2ZN
 sK6zQCsZRVbfLH6Ukwu0AkkVyoa5DPs2I4flMi0gPOgLzyH+2Sow1BXBkXoatbxQGEz3
 KABrqpCLxPhFgFCh1YTEDgpETUQMCCxAzGgtLVRk619fSP7X+bsXPgsVetC6O5VL/ND5
 5PKX6xwxrGHgBpzRJfbbCm2EEdFWg/9nJzg6BHj5dhJyTUqT8ideCcvCKq9eJ8I9d36d
 m2hGn+uIJzseqRXmMruJFCNolXyL2Wut9lKmljXNTDtB0PlDjcc/1DNxo1Kvo8T0pY9o
 ePSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183500; x=1697788300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZujHeHq70xM9MPj8kQG27kLbICCwKFbj8+Ro2luQ6VY=;
 b=CFXOY/3zJnUwG41s1Ra6wJcFkkLDkI1tSf7pI0YSRQOXLfqI17mjR8ljChE2v/Hccq
 oDs6+zDrVBRpTDKcIf35UmvjpLon6ndbtSilZmNWNYudhS1gEYL3P+SXtjSWzpuK5tkw
 K0oW28aBuNiNx8+JM60TA9s0shHB+Q2kzyOUxBvP0OrKyDhyGm58zaoyp3q3uzmLGYHk
 Nk3JaQ5yOzgIFJxo5yEw9l98Vu3n8bFhfv552Ok0fZ4HtxH71Cg6a4nnXQSDUMKspRYs
 mkw2lkjg4y86G68J3j32uXQF+jk5OyYpz9nZe9laZGvUfz0jDWVw2lc+s9E8cO++1Ynv
 W5qg==
X-Gm-Message-State: AOJu0YxM11fWC44bVsTrAxp6GTE1aEkb6suSLUkrcczgZVkWGhGrxNDT
 r6T22lwcPrKrpKELYKISjugnoeqH8LCLxjeVPdM=
X-Google-Smtp-Source: AGHT+IE8DMw6oP6TzKYsBeRKbpb9M1/f1E61quzLhsweUdptU7rOg6GedZxmWUwO74Vze7fg+m4BvA==
X-Received: by 2002:a17:906:9c1:b0:9ae:5aa4:9fa with SMTP id
 r1-20020a17090609c100b009ae5aa409famr23419439eje.42.1697183500151; 
 Fri, 13 Oct 2023 00:51:40 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:51:39 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [RFC PATCH 48/78] contrib/vhost-user-scsi: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 10:48:03 +0300
Message-Id: <f5ba45aeb80d3f41af2a5e2c87e8b212a7435670.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


