Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE3D788DB4
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 19:16:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZaPm-00049Z-I7; Fri, 25 Aug 2023 13:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qZaP9-0003t4-92
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 13:15:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qZaP4-0001iI-IH
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 13:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692983721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+YzmMB/S/E2Gacg+qEqwQW082D9e8RnwqcMgBQtzX4Q=;
 b=ePJ8dzPAVywgqVqYBLAomv58kIGKxMbqY54bmxolMYlI5dcZHRur1tw7EsOf/jFxfJJS0d
 MDi4Gs16U3O2woHnKz5KjmJ7PD/g/+PjTsZFcfl2swH7WfGeaIZr2CRc8VC1If+U468Y/V
 Nh5YnqwTzGwYaTrh5+wZN2t58YfGnck=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-YyIoWrLhNMuFihAuokucsw-1; Fri, 25 Aug 2023 13:15:19 -0400
X-MC-Unique: YyIoWrLhNMuFihAuokucsw-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-7a2836c6d97so43489241.1
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 10:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692983719; x=1693588519;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+YzmMB/S/E2Gacg+qEqwQW082D9e8RnwqcMgBQtzX4Q=;
 b=losC/0ZB60JS+VOtuIcnw0GsqFu3CMkO8fo1IgqlTKTpNPEx8oRbBu33c6e9Hxp7s1
 7o/IsGG65rqM3+qenPZ+78e6A1GyPL6QJNtpozryOoLTg2roHfq7DjIvgireVwMdtqGT
 nRY2/3R8W/Hf3IkhHhaLeZHLgez9KOWCXRcECoY61C16n/N6DS6ZMYc9pwzRU31mYyfu
 aWUQzlrzVo4lMFR9xn9kWudIjNkGCrWblqMdGlizzKKGcWixwtECL/qpI7ebd4mw8YO1
 Qsjdg2SSMyWZQ1kbgOKwwxW2xrD2nNTbDaDlKiIrnuUQ04baz3Fl3sr1Hkp3VDsPd19g
 8D0A==
X-Gm-Message-State: AOJu0YxXYP0R55z27tH0lif4s/EjowTNRWLBiZZQMguVZi4VhzzuYdsC
 zuSagGERaNJHRcAHCq5kpGyYDEYenNpSYpfGoVbpRutArBQY2J46GyIDUneU/8zwZ4wY1CuY5gy
 xw+SMRQCTJ/eAVk5uGKULfAwmzihGKxldFYbwse/jVPck+YvObaMHtAhG0z5/KrJBBogA/ZeV
X-Received: by 2002:a05:6102:3e23:b0:443:e4a4:c2c3 with SMTP id
 j35-20020a0561023e2300b00443e4a4c2c3mr13951104vsv.2.1692983719233; 
 Fri, 25 Aug 2023 10:15:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAVO2mCc87bj8Ppga2FDMCrm4sRRnMx52aElsop9p4C17w6fMVoMiYTyzXObYqiFkMdvQZhw==
X-Received: by 2002:a05:6102:3e23:b0:443:e4a4:c2c3 with SMTP id
 j35-20020a0561023e2300b00443e4a4c2c3mr13951066vsv.2.1692983718879; 
 Fri, 25 Aug 2023 10:15:18 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a0cf184000000b0063cfb3fbb7esm679191qvl.16.2023.08.25.10.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 10:15:18 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 0/4] qapi/migration: Dedup migration parameter objects and
 fix tls-authz crash
Date: Fri, 25 Aug 2023 13:15:13 -0400
Message-ID: <20230825171517.1215317-1-peterx@redhat.com>
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
 tests/qtest/migration-test.c   |  21 ++
 8 files changed, 246 insertions(+), 530 deletions(-)

-- 
2.41.0


