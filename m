Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBA89249B5
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jul 2024 23:06:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOkhC-0001Zi-Co; Tue, 02 Jul 2024 17:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOkh3-0001X8-Cg
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 17:05:41 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOkh1-0007k0-Fh
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 17:05:41 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52e8037f8a5so4592043e87.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 14:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719954338; x=1720559138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E2mdgeeKEiy+s4B/PAKsLCcO09jDDi9sxAyEzud5PGw=;
 b=AOOgmvxPREY+ENVlsYqLX+agQftqtpeE+Wrr4BmddSEntVc11jOFpVGEReTRViw2QN
 AjnsMDLVhry58qVJn7kl32KhHgG+0QHekCK2ijGlxhBgmWjuXsWXu2MCu1Ya+0ew25XG
 Wuz+c6eCGpmnb5Lb/Z4u4c2I3gDqLujcxnaVVOcmbsMLYbo3zHshx2oyCOPZrH+xtiqt
 zY1V7PO6gM806i/PCPSMHELO5nrHOwXZGWPH2beE41Z5DcTiVB5c1qcqkhY4FjSEH7Fb
 5Ba7higXw0AlK3MEFaEQqJw+YPuDX4g5itSzWyAQTM1nD+B6mREjaLArRmjIcOL5xwEb
 Kc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719954338; x=1720559138;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E2mdgeeKEiy+s4B/PAKsLCcO09jDDi9sxAyEzud5PGw=;
 b=fCWEH9nWc+hJfKBDlbfUeqG/iKYzAcll7pYS9rNZgrfaVJRsRQTtpdp6rWFJIsKDaM
 ZSKfMU//wPyyWnJNIUyDr10wdfe437CHC8doDLtVjRhepHZrv0BQBM6fwNKsfFrsdfBd
 /46Gd61x9YfyWL68oVYWXo7pDs9wb8YrgocUO+8iZcN71jMd+q2FJ+yuIvTrQO6ljZsG
 GzH7C/b2zHKHtHKxD41JATkoUef3Xdyx7ctR9xl2qDteGeM75UAjgvK0GmcOacrLW5Xv
 Bx2vZCNUIs3Ab1ZIcVvHZDPzwVc+9bx6DD49Q4MAC8f5nMRuxM5TrUfiUlBBAL+y3o9W
 9hlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2Eoc2Vflt+hyhwaZWZ28UNWrw83vbpC0FEC4CNGkMSXIlGo7gorREkjaZNwjpiEgGkCnxihQ9DHohJ1/qW+H4MN+Jvqk=
X-Gm-Message-State: AOJu0Yy+r85FrZPoWq+3UgT9wWBwYYMXJ2q9Dt2hlO2eQU0DPyMEettu
 TgmbiUUkaxzyVKWl7hV+t3W6xqmqqO8U+MVDcZ4klTR8L7bo00H+XIoHKAY=
X-Google-Smtp-Source: AGHT+IH9iAAgCUsNk62sVKzUPLdTVe6gbH9Cx2pDC2vSvXp4p0k+xzJNuBBNMtCMiWQAVrTj3FjcHQ==
X-Received: by 2002:a05:6512:12cc:b0:52d:a55b:fa9d with SMTP id
 2adb3069b0e04-52e8268cf32mr7368896e87.38.1719954335377; 
 Tue, 02 Jul 2024 14:05:35 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c1018sm210780175e9.40.2024.07.02.14.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 14:05:35 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Zheyu Ma <zheyuma97@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2] hw/virtio/virtio-crypto: Fix op_code assignment in
 virtio_crypto_create_asym_session
Date: Tue,  2 Jul 2024 23:05:19 +0200
Message-Id: <20240702210519.3061098-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=zheyuma97@gmail.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The assignment of the op_code in the virtio_crypto_create_asym_session
function was moved before its usage to ensure it is correctly set.
Previously, if the function failed during the key_len check, the op_code
did not have a proper value, causing virtio_crypto_free_create_session_req
to not free the memory correctly, leading to a memory leak.

By setting the op_code before performing any checks, we ensure that
virtio_crypto_free_create_session_req has the correct context to
perform cleanup operations properly, thus preventing memory leaks.

ASAN log:
==3055068==ERROR: LeakSanitizer: detected memory leaks
Direct leak of 512 byte(s) in 1 object(s) allocated from:
    #0 0x5586a75e6ddd in malloc llvm/compiler-rt/lib/asan/asan_malloc_linux.cpp:129:3
    #1 0x7fb6b63b6738 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5e738)
    #2 0x5586a864bbde in virtio_crypto_handle_ctrl hw/virtio/virtio-crypto.c:407:19
    #3 0x5586a94fc84c in virtio_queue_notify_vq hw/virtio/virtio.c:2277:9
    #4 0x5586a94fc0a2 in virtio_queue_host_notifier_read hw/virtio/virtio.c:3641:9

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
Changes in v2:
- Fix the whitespace in title
---
 hw/virtio/virtio-crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index bbe8aa4b99..5034768bff 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -205,6 +205,7 @@ virtio_crypto_create_asym_session(VirtIOCrypto *vcrypto,
     int queue_index;
     uint32_t algo, keytype, keylen;
 
+    sreq->info.op_code = opcode;
     algo = ldl_le_p(&sess_req->para.algo);
     keytype = ldl_le_p(&sess_req->para.keytype);
     keylen = ldl_le_p(&sess_req->para.keylen);
@@ -224,7 +225,6 @@ virtio_crypto_create_asym_session(VirtIOCrypto *vcrypto,
         iov_discard_front(&iov, &out_num, keylen);
     }
 
-    sreq->info.op_code = opcode;
     asym_info = &sreq->info.u.asym_sess_info;
     asym_info->algo = algo;
     asym_info->keytype = keytype;
-- 
2.34.1


