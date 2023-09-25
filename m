Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A877AD93C
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 15:36:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkljf-0000b2-IQ; Mon, 25 Sep 2023 09:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qkljd-0000au-NP
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 09:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qkljb-0001k9-Rd
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 09:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695648886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oyHQ0yc2ntAcG5ylNzBeG2HhHHmRnG0Chte0nFlWRjU=;
 b=XpClFh8c78Bq+w6LKRx393P0dEK93/ZgMpK2hEPwZQhigO7s9oDS3WJnn4ywHbSDiJbEPM
 3s5eU/yuafXMcjHBY8PiqTXJ4/hzdbFGnk6K4Ch4TpUy0ZUuaoEd4g+uYtn2vjc7Bq3vsn
 vrMxnDj6C+56rWRN7k8vXtuB+tHg1kE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-tT_5T9ugMXmBdiydujJ9rQ-1; Mon, 25 Sep 2023 09:34:44 -0400
X-MC-Unique: tT_5T9ugMXmBdiydujJ9rQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-774292de453so102416885a.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 06:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695648884; x=1696253684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oyHQ0yc2ntAcG5ylNzBeG2HhHHmRnG0Chte0nFlWRjU=;
 b=OGQe8Suhc20cYv0OvNs2uITTCXuOIYf9C+oG0PWIk7owUevJKYlDgJ1FRiQ5fRjDRL
 qz9yFgsmvUxIYzQCQQ1NAjpyf+RtraEAlXN++pzaLX9oAPqeKIOvYnHpMUJPGnMMtLpB
 TUtgpdxLz0WmUu1dGPv6hW2kijZzCENY4A9Ird2F8hIXZMWgg6S48k3KBrqpcx1Mc43B
 f+dcn585SJ/fKAfKB06R9t/zFAdTYlZ7jkH0Z4Yg3dxxGQzs8N17S9cYJQS/5SUU6vqz
 RSjqHVeWb3eM7lmRp1orKnOKz7BqZG9HeKwW3OFcYt3if/wZ+k3o3/QZ08qKa7A/aYrP
 N+DA==
X-Gm-Message-State: AOJu0YyjiU95LEGTo7HB+iVvLI/kVBMW8z1rbfcDKtACJM4Z8OlFHkUh
 reGxqU2t7W690k98lWteKIoFZJySuNgsfTNLRs7QABpwgYXiCJTGbjNobbVmahJrOF6ByXcTWm4
 xoUrmGk8BsWYVLcSTeQS1ct4ACB++YpJdwXKLq7kBrahmyFXasvZiaKU71N1VOUGxggS9gH0P
X-Received: by 2002:a05:620a:1aa9:b0:772:5267:3ddf with SMTP id
 bl41-20020a05620a1aa900b0077252673ddfmr7705620qkb.2.1695648884002; 
 Mon, 25 Sep 2023 06:34:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHguWvBrV/uE20Bxh2i8kXehQmsbbYusW5v7snnlxgBid0la49eE3KUAHburwzOwv4QDHvvaQ==
X-Received: by 2002:a05:620a:1aa9:b0:772:5267:3ddf with SMTP id
 bl41-20020a05620a1aa900b0077252673ddfmr7705595qkb.2.1695648883649; 
 Mon, 25 Sep 2023 06:34:43 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 t12-20020a05620a004c00b00767dcf6f4adsm1679043qkt.51.2023.09.25.06.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 06:34:43 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] MAINTAINERS: Add entry for rdma migration
Date: Mon, 25 Sep 2023 09:34:41 -0400
Message-ID: <20230925133441.265455-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It's not obvious to many that RDMA migration is in Odd Fixes stage for a
long time.  Add an explicit sub entry for it (besides migration, which
already covers the rdma files) to be clear on that, meanwhile add Zhijian
as Reviewer, so Zhijian can see the patches and review when he still has
the bandwidth.

Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
Cc: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 355b1960ce..f6b21da753 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3217,6 +3217,11 @@ F: qapi/migration.json
 F: tests/migration/
 F: util/userfaultfd.c
 
+RDMA Migration
+R: Li Zhijian <lizhijian@fujitsu.com>
+S: Odd Fixes
+F: migration/rdma*
+
 Migration dirty limit and dirty page rate
 M: Hyman Huang <yong.huang@smartx.com>
 S: Maintained
-- 
2.41.0


