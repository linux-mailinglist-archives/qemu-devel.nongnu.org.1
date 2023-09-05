Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F55F7925B4
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 18:24:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdYq9-00056U-I1; Tue, 05 Sep 2023 12:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdYq7-00055Q-JF
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdYq5-00064s-1a
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693931018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4Xz6phWhixlOZhephj2f8m3Ovo2op5zC6sCMbTkR/dc=;
 b=dd3VLE2eTYyCL5MIHICKqbUrTr9z3d9yyk90gNGhcXJetcZvfCiNhYOYSTwQPtx4upSST1
 sNUtTsVzURYv8h9Z9IBF225IqDz1VkuuM6Q4qgyp0R4fYooBoj9NY31o4kmpe+O37wtzzu
 LzgXBqB88IEfitLWXEZhtzq0YtRh1M8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-aVnghz8-ME6LTKjZooNq0Q-1; Tue, 05 Sep 2023 12:23:37 -0400
X-MC-Unique: aVnghz8-ME6LTKjZooNq0Q-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-64a4269ca98so7317796d6.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 09:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693931017; x=1694535817;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Xz6phWhixlOZhephj2f8m3Ovo2op5zC6sCMbTkR/dc=;
 b=NyVAdGr0RpTAlUoYFMyId4/6iTG3xmFycse8qjENbKzqsMPzfdKK4ZxrBlYCy9UMp6
 dN5ZSlFDwTtf+Q0RZ2+0GtQ/FOn9zjmBHrHiy2LfU3Vlhm/yksk5mvXl4q+9BXzkGLI+
 AB/mbe7B+Dm5T3hal9tzK3TkgK/ycN3kC9aVuJwbCBauG4wQjuTrnVCIpWHJu/sSgHMP
 wYTonoXpz9XWGdld8P11L3Z72LoEG0k2ZgrT2XkOEq/LVXoNEMSFBwvrq9TxrtrbfP77
 /Z4qFYs2A4oAiyQtn2KJxbCpOf1qq4q3rTiEXQWitCfAKNUdgsnE88IHSxXYitxgxwna
 1APQ==
X-Gm-Message-State: AOJu0YwOuifYQPIO3i9KIw3aBO6gWMnru6xuievAEgpdjw7+/79eFMge
 mZXg8w9uwr5Dg/PdLkJWqujJZRuydULbbbwn6kWq2NlkWgIg0kWmgG3C/9M7TJbmO9fAqyK2c7T
 widFw9Ptkfj0Lrs8BO1LIw+dWBEGsCdfQMQ0qpygNXjANs14hE24dfIiV0O0U8np84SMA2XOk
X-Received: by 2002:a05:6214:dc5:b0:651:8b27:f1f5 with SMTP id
 5-20020a0562140dc500b006518b27f1f5mr15454497qvt.6.1693931017070; 
 Tue, 05 Sep 2023 09:23:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpcQ9Voxy6lKofRpxQvxIxY1JdNhlSngUs2lChTnJN5JXh+7r1QC1wF/tQ+wXJLXB2K1b/eQ==
X-Received: by 2002:a05:6214:dc5:b0:651:8b27:f1f5 with SMTP id
 5-20020a0562140dc500b006518b27f1f5mr15454470qvt.6.1693931016620; 
 Tue, 05 Sep 2023 09:23:36 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a0cf1d0000000b0063d281e22f1sm4581675qvl.17.2023.09.05.09.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 09:23:36 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 0/4] qapi/migration: Dedup migration parameter objects and
 fix tls-authz crash
Date: Tue,  5 Sep 2023 12:23:31 -0400
Message-ID: <20230905162335.235619-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

v3:
- Collected R-bs
- Patch 2: some reindents, use ARRAY_SIZE (Thomas)

v2:
- Collected R-bs
- Patch 3: convert to use StrOrNull rather than str for the tls_fields
  (it contains a lot of changes, I'll skip listing details, but please
   refer to the commit message)

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

 qapi/migration.json            | 370 +--------------------------------
 include/hw/qdev-properties.h   |   3 +
 migration/options.h            |  50 +++++
 hw/core/qdev-properties.c      |  40 ++++
 migration/migration-hmp-cmds.c |  23 +-
 migration/options.c            | 266 ++++++++++--------------
 migration/tls.c                |   3 +-
 tests/qtest/migration-test.c   |  22 ++
 8 files changed, 247 insertions(+), 530 deletions(-)

-- 
2.41.0


