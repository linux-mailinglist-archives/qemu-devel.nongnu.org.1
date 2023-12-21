Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6A781BCA5
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:10:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGMXx-0003EA-WA; Thu, 21 Dec 2023 12:09:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1rGMXv-0003Dz-FP
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:09:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1rGMXt-0002Bb-59
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703178555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4gXAnVlqoInl27fTq6iZXoPgQPej20JIdR4Mdw7fjSc=;
 b=Vc5Q3Ffq1olqdsCmbj46LvgKvkcx/tQtMxj5ccgUY9gJFvYDDtnfedT7YcYRxKxe1MLyQ2
 VvLlmc8yYceIQV7shhaZ1NYQIj4Qazrn/fF0IWPqlh/WPMqBgJIaHds0ky9mSWx7XPR0dL
 zLlAui7TSY+DslGFURSPGZRDWbceNY8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-N6pbo_T0MJCPXrMseIO3aA-1; Thu, 21 Dec 2023 12:08:03 -0500
X-MC-Unique: N6pbo_T0MJCPXrMseIO3aA-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1d3f8ba12faso9903545ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703178482; x=1703783282;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4gXAnVlqoInl27fTq6iZXoPgQPej20JIdR4Mdw7fjSc=;
 b=bnwWGODx8VngJsVQVLZDENxqRS84MO4dUFTmWSp4s2YKCecD0CSjUrPIdVVDsE8QEz
 1fa5JmLx5OF1JUsPQkhZDKEJVL0wNff6LZWdj6kfsi7gurMnocTWX7aoQPa8GK1rcE60
 /Vc73kbR6TAyHRz5dwqzIvyKuZGcBNhAGEUZ5o35OrOG30wG/KUYtrRrIiw/H3qR9JHZ
 6gGK3oGjmNUNA/OK2vaEZfifcCLi3mh8zQBH+b0kOByEv32W3O3+nDbjuduc2ISrfgVM
 dQ90OO6FyEBUtTf2uV8awCyO9K5e0AkAcyOwJKKYq0V7KtTw6D5ZLu345fshu7o7S3bS
 VGuw==
X-Gm-Message-State: AOJu0YxbCoo9z7D4fyhKgq9xt28dY+3QIFLcmZ2CtyBFwKpJe7KA/ZDd
 FLB/zEgrARknPE5M75koyZrB0lA/h73zRktRzwaeOGUCvVLbsfp3H5QOZ/otH3t8r1E20NbOYAJ
 yfm1nnnx0AjC4J8A=
X-Received: by 2002:a17:902:a384:b0:1d4:b4a:9cd5 with SMTP id
 x4-20020a170902a38400b001d40b4a9cd5mr1033270pla.48.1703178482582; 
 Thu, 21 Dec 2023 09:08:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwxyoOf6U0AYAu3I+h46ANZVjlxncaDXhRl064tWCzI08E9gUzavO4S4rQCZu1ydqhwJjTBg==
X-Received: by 2002:a17:902:a384:b0:1d4:b4a:9cd5 with SMTP id
 x4-20020a170902a38400b001d40b4a9cd5mr1033248pla.48.1703178482175; 
 Thu, 21 Dec 2023 09:08:02 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a170903234100b001cc8cf4ad16sm1863625plh.246.2023.12.21.09.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:08:01 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Li Zhijian <lizhijian@fujitsu.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: Remove myself as reviewer from Live Migration
Date: Thu, 21 Dec 2023 14:07:34 -0300
Message-ID: <20231221170739.332378-1-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leobras@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

I am currently focusing in kernel development, so I will probably not be
of much help in reviewing general Live Migration changes.

For above reason I am removing my Reviewer status from Migration and RDMA
Migration.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 695e0bd34f..d998cf8e5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3342,7 +3342,6 @@ Migration
 M: Juan Quintela <quintela@redhat.com>
 M: Peter Xu <peterx@redhat.com>
 M: Fabiano Rosas <farosas@suse.de>
-R: Leonardo Bras <leobras@redhat.com>
 S: Maintained
 F: hw/core/vmstate-if.c
 F: include/hw/vmstate-if.h
@@ -3362,7 +3361,6 @@ RDMA Migration
 M: Juan Quintela <quintela@redhat.com>
 R: Li Zhijian <lizhijian@fujitsu.com>
 R: Peter Xu <peterx@redhat.com>
-R: Leonardo Bras <leobras@redhat.com>
 S: Odd Fixes
 F: migration/rdma*
 
-- 
2.43.0


