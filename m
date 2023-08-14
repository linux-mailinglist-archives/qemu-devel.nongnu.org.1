Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D103277C35B
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 00:20:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVfuz-0003DL-5J; Mon, 14 Aug 2023 18:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qVful-0003B9-9q
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 18:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qVfuj-0005k1-Ny
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 18:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692051592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wKBtLeED/xp3ZTeUljti9wsOtYW8Yz4jbcUIyV2xPfU=;
 b=RK1dI3ydPnG23EJcGW+YdpPvM5vPSHU/sijLYgQEVjyxDlePq/q1Grq78zuQCce6w3P+FK
 ZRlV4EBqwuoYhZQajahrdh1w36h6E3VfCbUERG4EZmpnUAgOC2UKVhpOqRloUEJmaCXZMh
 6Mx/UgQLZQQnDmNHJfCbmBFJDxilD/Q=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-ZbFM6w_jMXO-JIbzrAor6w-1; Mon, 14 Aug 2023 18:19:50 -0400
X-MC-Unique: ZbFM6w_jMXO-JIbzrAor6w-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-76ca3baaec8so133290085a.1
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 15:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692051590; x=1692656390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wKBtLeED/xp3ZTeUljti9wsOtYW8Yz4jbcUIyV2xPfU=;
 b=jlYUEZOqL2eJCycqqz/tUq0m21oNsng2goNKzLtlPy5URf/kX0Psug30QfFX5Xy15F
 gckB+6Cl7OQEqIvc8EXKT081UX1oGVKevop/UM682s8bpPkgv9R/H3lEVjn4B4Uwt6oa
 QcN/WPADmL/F57goaFvwDVNiudcwKouulARhyrDanaPfq1+t8tIrQJDX4G8mFLJJ87FL
 qqI4W8WvpwPAV+gNRaW7ZGPpFaJ029wTeUa8e/PTDv3oIGCi6WQqXNE8JG0M2cwlNeKh
 b9qpT5C1/LP3UrG3Lqxs3X81yxiPo2gnaWvc55BRNSJPOv5EPsxQPNqNtyxY+UouSNr0
 EkRw==
X-Gm-Message-State: AOJu0YwHwIPldtJThBIhvhuDBU0sZnPakJ51bi+Ul2DFgUT8skVvJGm4
 jiQ6v2BSpDdVGRRTFG1lQ2IlnH1cqP+JY362G/w2bhee4VKkhuwNFhEuL5x8kbG2wkbtEjX8qBI
 YpIHx8Oxz4hvgeVVtNdQYeJRNdOeK4lOmjfgHDdK2HVeiA8lyXgfRfERzAr4L6mZrm0YqR2DM
X-Received: by 2002:a05:620a:3952:b0:76c:cd9d:5edf with SMTP id
 qs18-20020a05620a395200b0076ccd9d5edfmr13736309qkn.6.1692051589790; 
 Mon, 14 Aug 2023 15:19:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU4whDv3VkKQdlO3tZCRU5tV20RwXYY/J/SrnTmQegcv2opC5wwAd5birLip1+m1nTkyFjjQ==
X-Received: by 2002:a05:620a:3952:b0:76c:cd9d:5edf with SMTP id
 qs18-20020a05620a395200b0076ccd9d5edfmr13736286qkn.6.1692051589421; 
 Mon, 14 Aug 2023 15:19:49 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 s22-20020a05620a16b600b0076ca401d8c7sm3324978qkj.111.2023.08.14.15.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:19:49 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH for-8.2 0/4] qapi/migration: Dedup migration parameter objects
 and fix tls-authz crash
Date: Mon, 14 Aug 2023 18:19:43 -0400
Message-ID: <20230814221947.353093-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Patch 1 fixes the tls-authz crashing when someone specifies "null"
parameter for tls-authz.

Patch 2 added a test case for all three tls-auth parameters specifying
"null" to make sure nothing will crash ever with 'null' passed into it.

Patch 3-4 are the proposed patches to deduplicate the three migration
parameter objects in qapi/migration.json.  Note that in this version (patch
3) we used 'str' to replace 'StrOrNull' for tls-* parameters to make then
deduplicate-able.

Please review, thanks.

Peter Xu (4):
  migration/qmp: Fix crash on setting tls-authz with null
  tests/migration-test: Add a test for null parameter setups
  migration/qapi: Replace @MigrateSetParameters with
    @MigrationParameters
  migration/qapi: Drop @MigrationParameter enum

 qapi/migration.json            | 364 +--------------------------------
 migration/options.h            |  47 +++++
 migration/migration-hmp-cmds.c |  19 +-
 migration/options.c            | 191 ++++++-----------
 tests/qtest/migration-test.c   |  24 +++
 5 files changed, 136 insertions(+), 509 deletions(-)

-- 
2.41.0


