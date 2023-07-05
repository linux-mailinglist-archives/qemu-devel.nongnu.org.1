Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 070BA748953
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 18:36:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH5TI-0001Yp-28; Wed, 05 Jul 2023 12:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH5TB-0001VL-Au
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:35:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH5T9-0003aw-Hy
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688574906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IgnogES5gEpoMbV4YVkkqJmUDTPimmEfB1N8BQFJIIE=;
 b=cAHZVIK79QRIbWXsfyObpJ0i2cxavPvXIQS352jZpFIkTmVqPN4Vr/oYbj76QqybFevl7s
 o2J8O0qXv98V/K/Qvmal3DK1hR5EMv5BezCwpHvCJz2u23XVHjzSPmCxRCH4bSMbk8jcB3
 UF50Wdzbb5btijBPbBn85B++nM5fHwk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-1-llH8ZINEqJJXGAtUGW9w-1; Wed, 05 Jul 2023 12:35:04 -0400
X-MC-Unique: 1-llH8ZINEqJJXGAtUGW9w-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7672918d8a4so198141885a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 09:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688574904; x=1691166904;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IgnogES5gEpoMbV4YVkkqJmUDTPimmEfB1N8BQFJIIE=;
 b=VfBY/8e3lzwKJzA/iunUsIuI2xFsmu5i82JxXS5DYXctOds6DhE9w6Qyz8zYxkGJNx
 /nR4gLS/gpRO0yHkienXCf2NBJ0tQ+J0VZwechiVJfRyX+CUT4SriNV+vxbTbgaGmdiv
 9Ffm8KOFjfKSxGNf2FWvDp89oMeyMuWUhU1JsGyNkXvmSOo0CliX9d7kesfFKhYUuk7f
 IwN3ow5mLogzF5ttPwYmZsCOGLe42um1OZfs/NSA0zPmUXERzf51T1ul9vgwf86jA6Mh
 9qmNE2wIuEdNiTzB5dHEVTNq98VaBR8e75iXROYfWJtZY7TlQzqhSs/cpvx2vGkBSaUr
 7/UA==
X-Gm-Message-State: AC+VfDzyzs3aIsikPC16x3z154/ScKUrwjthrV7rmKd1eU16lsmrCaVa
 ud8ShXsti2VpQDRdd1hVuwprQoNELL4nqUWyLpd2xKdEiMuPaIz3gb1+ttjQBnjnoAGIOz54uNR
 ICUEC9uGqKoB3t2ZP8XeNBs+l+8FyTI2qsRB7wHaBoAT2jd0GwERcX2AQ950YMGmA1ZGDo1Hf
X-Received: by 2002:a05:620a:1a15:b0:767:21f1:39cd with SMTP id
 bk21-20020a05620a1a1500b0076721f139cdmr18568454qkb.5.1688574904106; 
 Wed, 05 Jul 2023 09:35:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ774m/3CatDpOv56LfGKAXqVf93ZaWu3fjvkcqFZ7Q0HenvP9cA29tW7FmbV6c4CJdbzw6D5A==
X-Received: by 2002:a05:620a:1a15:b0:767:21f1:39cd with SMTP id
 bk21-20020a05620a1a1500b0076721f139cdmr18568433qkb.5.1688574903727; 
 Wed, 05 Jul 2023 09:35:03 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a05620a12b300b007620b03ee65sm6760094qki.37.2023.07.05.09.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 09:35:03 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Laszlo Ersek <lersek@redhat.com>,
 peterx@redhat.com
Subject: [PATCH v2 0/7] migration: Better error handling in return path thread
Date: Wed,  5 Jul 2023 12:34:55 -0400
Message-ID: <20230705163502.331007-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

v2:
- Patch "migration: Provide explicit error message for file shutdowns"
  - Touched up qapi doc [Fabiano]
  - Added Bugzilla link to commit which I didn't even notice that I was
    fixing a bug.. but rightfully pointed out by Laszlo.
  - Moved it to the 1st patch because it fixes a bug, please consider
    review and merge it earlier.

This is a small series that reworks error handling of postcopy return path
threads.

We used to contain a bunch of error_report(), converting them into
error_setg() properly and deliver any of those errors to migration generic
error reports (via migrate_set_error()).  Then these errors can also be
observed in query-migrate after postcopy is paused.

Dropped the return-path specific error reporting: mark_source_rp_bad(),
because it's a duplication if we can always use migrate_set_error().

Please have a look, thanks.

Peter Xu (7):
  migration: Display error in query-migrate irrelevant of status
  migration: Let migrate_set_error() take ownership
  migration: Introduce migrate_has_error()
  migration: Refactor error handling in source return path
  migration: Deliver return path file error to migrate state too
  qemufile: Always return a verbose error
  migration: Provide explicit error message for file shutdowns

 qapi/migration.json      |   5 +-
 migration/migration.h    |   8 +-
 migration/ram.h          |   5 +-
 migration/channel.c      |   1 -
 migration/migration.c    | 168 +++++++++++++++++++++++----------------
 migration/multifd.c      |  10 +--
 migration/postcopy-ram.c |   1 -
 migration/qemu-file.c    |  20 ++++-
 migration/ram.c          |  42 +++++-----
 migration/trace-events   |   2 +-
 10 files changed, 149 insertions(+), 113 deletions(-)

-- 
2.41.0


