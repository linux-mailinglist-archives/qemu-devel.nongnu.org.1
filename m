Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DC9793A2F
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 12:46:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdq2Y-0006dQ-Ri; Wed, 06 Sep 2023 06:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdq2W-0006cV-5G
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 06:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdq2T-0007C7-PG
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 06:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693997134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KivVqRpe5KN2+Ci3kMr9KmNlhmNtvTwUcH6R6cGFsIU=;
 b=O5PcBsNgBUECcwywwlyAE8849g432XwSd7hVb/0lrS4v7ybctzBo3RTVHRGcQQmj71g2Ye
 qg74oGnporWPAG9Zqz3hPOLNY4auGeeUP8W+S9jPivYNawV9yCvouXFbH/jahR86muLP/H
 jisXSI2i6LBwkr0XZaJvx+5OZzfI6+Y=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-haj5-nTFPxKkNi73tYECoA-1; Wed, 06 Sep 2023 06:45:33 -0400
X-MC-Unique: haj5-nTFPxKkNi73tYECoA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2bbbaa6001dso45683481fa.3
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 03:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693997131; x=1694601931;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KivVqRpe5KN2+Ci3kMr9KmNlhmNtvTwUcH6R6cGFsIU=;
 b=GuF6jU1bK1TVJxWqEq1gLOyyDzvUFAlYmUud3pufk69kUFnNuCSWBpjyiieO7JHA8/
 sspO0lMV5D82e+QjQSNa5cr628g1baw629SxzbaHUsLAnwb4f1TfG1/k2LC/f/gkHpdZ
 NJUC3JvrXU52Mtyb/vnFSOGdHurJDluG7W0K4D48jqz0AF85cbHdjQNpKJ8jFtByEF5b
 cJb87QKpFSvfYGQu306lRDD5XdWrtmxo/wrpRbEN65WC8AjgxVvtTrZBiILMnkjcS60Q
 25/zHTx7fq0H1MlWNqB6S07W8vASAAFGHvSvMpw7qvV5PgwyrHyZIMUDV9JAv1GRCruC
 rgKA==
X-Gm-Message-State: AOJu0YyPNf+/BHcB4MSwNomROakdwJWt8cCItZQS0innEGdBouztR3Sl
 1wAPsqxe8LXAj9mrRUbFxJ7Ax/ZMY/IVLdLSY9y5QVgIw92RYeKVHFt0Rs1b15LSY3pTlPW/JIa
 s5QRlPHgi0/ESqjZTZ2YFYKdOtNVgtMjLyfdkwagIAxspkcLRNBk/9pgDqWMiYZ0epJfaDVcSn1
 0=
X-Received: by 2002:a2e:7302:0:b0:2bc:e221:676c with SMTP id
 o2-20020a2e7302000000b002bce221676cmr1918590ljc.0.1693997131258; 
 Wed, 06 Sep 2023 03:45:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyPIClLV66XAnsLlMl1xx1aJQ6pDs9pu9YbAbZ4jV39MN1PmCh5SgVcjSztp7ghabWil33jQ==
X-Received: by 2002:a2e:7302:0:b0:2bc:e221:676c with SMTP id
 o2-20020a2e7302000000b002bce221676cmr1918561ljc.0.1693997130791; 
 Wed, 06 Sep 2023 03:45:30 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 ay30-20020a5d6f1e000000b0031f65cdd271sm1019784wrb.100.2023.09.06.03.45.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 03:45:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] subprojects: add wrap file for libblkio
Date: Wed,  6 Sep 2023 12:45:29 +0200
Message-ID: <20230906104529.401824-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This allows building libblkio at the same time as QEMU, if QEMU is
configured with --enable-blkio --enable-download.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 subprojects/libblkio.wrap | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 subprojects/libblkio.wrap

diff --git a/subprojects/libblkio.wrap b/subprojects/libblkio.wrap
new file mode 100644
index 00000000000..f77af72210c
--- /dev/null
+++ b/subprojects/libblkio.wrap
@@ -0,0 +1,6 @@
+[wrap-git]
+url = https://gitlab.com/libblkio/libblkio
+revision = f84cc963a444e4cb34813b2dcfc5bf8526947dc0
+
+[provide]
+blkio = libblkio_dep
-- 
2.41.0


