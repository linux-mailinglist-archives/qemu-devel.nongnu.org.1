Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5B3820A9A
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:53:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrUT-0006TA-In; Sun, 31 Dec 2023 03:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSd-0004xW-AY
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSb-0000o0-Qv
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kh8OWWf0NAryij9+hJzgKp51iNY438XSufgVqsjBc9A=;
 b=RMngxOAx/LSSAgoMPz2N7RsiNRSYGyJOqQGTbCEc1hoFNNeuspSR/hxqbLszqp1YiwSE+y
 Y99lMOwvVU9QAXYGiycykVSaQZ+vuojnF0z9gp3CODlWPxMpAD0k94+/EOqZ+vBMLI/4d6
 0rz37c+mTTzyVhym8xXg0Hk3qVNXPC0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-L-rEmMt4Oku_kt76VVllYQ-1; Sun, 31 Dec 2023 03:46:14 -0500
X-MC-Unique: L-rEmMt4Oku_kt76VVllYQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33697ddbf63so4675813f8f.3
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012373; x=1704617173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kh8OWWf0NAryij9+hJzgKp51iNY438XSufgVqsjBc9A=;
 b=nml1IZBDit85osHvDKpqToa6/5wxf+3qJBMu0yRWYs5gSjiJKVMizUc/xtrTWK/Ema
 UqRp/27v+G26222MiXFq92/rVpS9DHvmYVXCV/Jwvi3Om+4jzWbvipy8rVrYSGm2eYFk
 0nu22G01XTptCYg93MOWKTSMGO9n73PJ90QAJbWwQUbypDtcsOREhZOl78c9F8ZbpsWi
 SJYaZ3NiaYtcLYbo0Kp2zqGvPTZ/y+9IMfzZHSLBudwHtu0cexWj+lBqa/7/3Lg7a3s+
 Dsgm2YFwSUzJn5Jo6F/oEkXO5V8cBPI8BZNSzIqPj+STfz3RRBqUJfXQvR3a8v5WhrGn
 oFEw==
X-Gm-Message-State: AOJu0YzNDE8NSWG590cYFdiXoVp1+SK3tjaOYsAW1r2Tk1y5RrrxR58A
 9sNpne5ITSNyuxJ2d2FP08mPI5nRmZFmr54ov6jc4oqPOFB8smQ+e1BkRJW5WSB5bZRR0mzjPS4
 I+rV5GbgKYLvp1orEvcCmwUHdvvUOTzeG1E/v33jrQP/bKKZPgaKYLcbf9Xg0i+ZQviQPtvLIaj
 3AvyHFG/c=
X-Received: by 2002:a5d:4849:0:b0:336:8f9f:c69c with SMTP id
 n9-20020a5d4849000000b003368f9fc69cmr8007901wrs.40.1704012373435; 
 Sun, 31 Dec 2023 00:46:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHra2AF/awlVSIGsV1+oVQxclrzszqct6DyV1RsvSLWTKI/np5kcT4QyV8HjfHqgyrWRUYUhA==
X-Received: by 2002:a5d:4849:0:b0:336:8f9f:c69c with SMTP id
 n9-20020a5d4849000000b003368f9fc69cmr8007895wrs.40.1704012373154; 
 Sun, 31 Dec 2023 00:46:13 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 c18-20020a5d4152000000b0033609b71825sm23023523wrq.35.2023.12.31.00.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexandra Diupina <adiupina@astralinux.ru>
Subject: [PULL 24/46] esp: check for NULL result from scsi_device_find()
Date: Sun, 31 Dec 2023 09:44:40 +0100
Message-ID: <20231231084502.235366-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Alexandra Diupina <adiupina@astralinux.ru>

Add a 'current_lun' check for a null value
to avoid null pointer dereferencing and
recover host if NULL return

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 4eb8606560 (esp: store lun coming from the MESSAGE OUT phase)
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
Message-ID: <20231229152647.19699-1-adiupina@astralinux.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/esp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 9b11d8c5738..d2cae79194c 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -292,6 +292,15 @@ static void do_command_phase(ESPState *s)
     esp_fifo_pop_buf(&s->cmdfifo, buf, cmdlen);
 
     current_lun = scsi_device_find(&s->bus, 0, s->current_dev->id, s->lun);
+    if (!current_lun) {
+        /* No such drive */
+        s->rregs[ESP_RSTAT] = 0;
+        s->rregs[ESP_RINTR] = INTR_DC;
+        s->rregs[ESP_RSEQ] = SEQ_0;
+        esp_raise_irq(s);
+        return;
+    }
+
     s->current_req = scsi_req_new(current_lun, 0, s->lun, buf, cmdlen, s);
     datalen = scsi_req_enqueue(s->current_req);
     s->ti_size = datalen;
-- 
2.43.0


