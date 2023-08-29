Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C7778D05D
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:23:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mt-0000hW-3A; Tue, 29 Aug 2023 19:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb6U0-0006K6-Tf
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb6Ty-0000c5-3D
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693345360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ma7jT+zJF16KwzZKiyjDu1iJXb4w9cRPgsIM+RKxb0w=;
 b=AEYsRtSCGpS+2FWQV2b7TgCbUUoy2R3UmAS7bu8hTM4zFep2UP8NsmUciWVfK93T+iYTya
 biqhYMJkSUAZMnGoChDjNuziDIiXtYRqx8SIjZ6LImfLtqNKFKFe8pDcksy7PzHp8DC5qV
 BxlPvx+/hGm854QWZSUj10t9GTnq6kU=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-HqgFnswLP6ipq6KnQnjcQQ-1; Tue, 29 Aug 2023 17:42:38 -0400
X-MC-Unique: HqgFnswLP6ipq6KnQnjcQQ-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7a4ff742b97so165418241.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 14:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693345358; x=1693950158;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ma7jT+zJF16KwzZKiyjDu1iJXb4w9cRPgsIM+RKxb0w=;
 b=cn+fC0bYaxuja8zpMuHqRhJFybeI9h3g9FqYOQbPgppTMsbt81d6Usa7UeDaRO6uo1
 HouJpe7q12wdHRcofL9KBzsEtCsuse842hTCUVGFm4PG5i97cs9iy1851wKLy0jHgkg5
 xblbIk4zuUpI+c4/8voJb93zI1ZgB3kZuukM577KT60/cEGNw9lUq4Uqu1cR3QKkKes5
 KoFsbGTqWg4mHjBlEnrqsSw+i2LutVi24btuglNcXXDxxBRh5heEkaxlG6VaGwTEMAeA
 VwWQhjeQF8WXv1KQcA61r26m/r5Z/IisZpoJ4OIGjRaIBc+tqEO/vYr2DgjVViyRnRdc
 uJNA==
X-Gm-Message-State: AOJu0Yx0V9To4jDGgYt7SnStxlrae3Qu+WbzkwB2B+i/qsD/pXaXAV8V
 /47160mKNBBkS4u3up+ZlZiPNhsdDleYyPoyKgRUuJnjmJqKodOha7I+10FsrEpl/zQRxZqkjIA
 y9ne99h8/oYb0Q4abLcweCQdfp5T3/SvQ/XVcQMiEp9RI9Y8cyecuPBy3FGqbrjA1CN5ydQ8v
X-Received: by 2002:a05:6102:f8a:b0:44e:82c3:54c1 with SMTP id
 e10-20020a0561020f8a00b0044e82c354c1mr486237vsv.0.1693345358106; 
 Tue, 29 Aug 2023 14:42:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkFpeDbqNm5Kr+WQyxfmbmlirkFHecQ7XOQYgoxwoSouiuHimuK2uuC2jzbNDDansUoMp+Vg==
X-Received: by 2002:a05:6102:f8a:b0:44e:82c3:54c1 with SMTP id
 e10-20020a0561020f8a00b0044e82c354c1mr486224vsv.0.1693345357693; 
 Tue, 29 Aug 2023 14:42:37 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 b18-20020ac86bd2000000b0040f8ac751a5sm3260343qtt.96.2023.08.29.14.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 14:42:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH 0/9] migration: Better error handling in rp thread,
 allow failures in recover
Date: Tue, 29 Aug 2023 17:42:26 -0400
Message-ID: <20230829214235.69309-1-peterx@redhat.com>
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

This patchset supersedes below:
[PATCH v2 0/7] migration: Better error handling in return path thread

Another note is that this might conflict with Fabiano's other patchset to
fix postcopy race conditions, but maybe not.  If collapse, I can rebase.
Let me send this out still for early reviews.

I dropped the last patch there (which wasn't clear on being beneficial)
from last version, meanwhile added three more patches to address an issue
reported from our QE team that one postcopy migration can stuck in RECOVER
stage and never got kicked out.  For more information of that problem, one
can refer to the last patch commit message.

Since this one covers more issues, I renamed the subject, and let me
version it from v1.  I still collected most of R-bs from Fabiano since last
version (patches 1-6).

Please have a look, thanks.

Peter Xu (9):
  migration: Display error in query-migrate irrelevant of status
  migration: Let migrate_set_error() take ownership
  migration: Introduce migrate_has_error()
  migration: Refactor error handling in source return path
  migration: Deliver return path file error to migrate state too
  qemufile: Always return a verbose error
  migration: Remember num of ramblocks to sync during recovery
  migration: Add migration_rp_wait|kick()
  migration/postcopy: Allow network to fail even during recovery

 qapi/migration.json      |   5 +-
 migration/migration.h    |  25 ++++-
 migration/qemu-file.h    |   1 +
 migration/ram.h          |   5 +-
 migration/channel.c      |   1 -
 migration/migration.c    | 230 +++++++++++++++++++++++++++------------
 migration/multifd.c      |  10 +-
 migration/postcopy-ram.c |   1 -
 migration/qemu-file.c    |  17 ++-
 migration/ram.c          |  77 +++++++------
 migration/trace-events   |   2 +-
 11 files changed, 248 insertions(+), 126 deletions(-)

-- 
2.41.0


