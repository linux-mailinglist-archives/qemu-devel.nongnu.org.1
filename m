Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F410C7CCDFB
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:26:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqeK-000059-O3; Tue, 17 Oct 2023 16:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsqeG-0008MU-DT
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 16:26:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsqeE-0000jC-P1
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 16:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697574397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+KsKH/bpCWhclFAEmGZh8xjWoMiL+kj46L+n6X11r8E=;
 b=QTB4Mq1o1bISSTEUC3Yd5k6fzLSMhSo9f04Tjd/IDMtw6of+FXcXijf0aq1jUMHlO1HxPY
 W7v7AEcxf8J4lb2vDaG9bS9OpiFRAw3HhxFPzeTefhHGJtNmFRkj/RcNWSdsnCnZ8/mQ1r
 ++74CNwifv9KcLwOw4kPZjrNgjvdMQs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-pC3c-PIyPE-gYr1C6XEycg-1; Tue, 17 Oct 2023 16:26:36 -0400
X-MC-Unique: pC3c-PIyPE-gYr1C6XEycg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7756d0fb11dso103348785a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 13:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697574395; x=1698179195;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+KsKH/bpCWhclFAEmGZh8xjWoMiL+kj46L+n6X11r8E=;
 b=Z3i9XB2/v0elxi/MFuH6s50sVHekJYhB8KLE2HyeZ2WfhY4jufUnGE1Si2FHvG7E0m
 WiSST19Xa3zwSKXK1twv29SHZzKWRSslpOYiQdcEi7OphXvz8BgO7rsXWk1f7F0TQ7Cj
 IcMy2TKfGYFcHM1WCv4jiocSFKC/7rSXAB8wamj7+Z8TbpHeWsDlOjczPFQy/FMclBRO
 jlVJRGq3557tgFfCbtKUYltU2HrIolhY8SIxmzbbs+6zrIhix5azzZxo/hIKLbEIJdt/
 nu1rXvzSrmHA3yWWIMuThtULVK+iZfYP1xSIgJ2zLNlhW7jncfe3kPXqIsFC22LkWEqK
 LSXQ==
X-Gm-Message-State: AOJu0YzHY8V3crl1wODzpPoF8RSJCqLgs9KFj4ut846sG7SByW3BX1aG
 uy//JQJxmNlEAmeoYtGGVuz5l1koDV63vz4tE7wUHplGtjjONKmPQl61zOMd9/o2afMSR4ymqYM
 PuHD3fhu9j/bTOSLusZ6I+k+dbfS+TgdooN9nDivDuJs2vkrT5MNbNYELMYtnKfkl/cV8CSEl
X-Received: by 2002:a05:620a:8cb:b0:775:7921:732e with SMTP id
 z11-20020a05620a08cb00b007757921732emr3384115qkz.3.1697574395469; 
 Tue, 17 Oct 2023 13:26:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWn42LNJ1mJqrvg7sAWWrQYc/5dvK6JSBfpDlsciC1zbZ6UDKXAmiXgVQPn7ChaL+OIObTkw==
X-Received: by 2002:a05:620a:8cb:b0:775:7921:732e with SMTP id
 z11-20020a05620a08cb00b007757921732emr3384092qkz.3.1697574395129; 
 Tue, 17 Oct 2023 13:26:35 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 s17-20020ae9f711000000b0076f16e98851sm931879qkg.102.2023.10.17.13.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 13:26:34 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v4 0/5] migration: Better error handling in rp thread,
 allow failures in recover
Date: Tue, 17 Oct 2023 16:26:28 -0400
Message-ID: <20231017202633.296756-1-peterx@redhat.com>
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

v4:
- Some patches merged, reposting the rest patches
- Fixed a bug in the new test case reported by Fabiano
- Try to keep close_return_path_on_source() return a value (even though it
  still fetches from migrate_has_error)
- Two more patches added to cleanup retval of rp thread functions

v1: https://lore.kernel.org/r/20230829214235.69309-1-peterx@redhat.com
v2: https://lore.kernel.org/r/20230912222145.731099-1-peterx@redhat.com
v3: https://lore.kernel.org/r/20231004220240.167175-1-peterx@redhat.com

This series allow better error handling in the postcopy return path thread,
so that we'll start to store the errors in MigrationState and can be seen
from query-migrate later, comparing to before where we do error_report()
and never remember the error.

Meanwhile, it allows double-failures to happen during postcopy recovery,
IOW, one can fail again right during RECOVER phase on both sides, even if
RECOVER phase should be an extremely small window.

Please have a look, thanks.

Fabiano Rosas (1):
  tests/migration-test: Add a test for postcopy hangs during RECOVER

Peter Xu (4):
  migration: Refactor error handling in source return path
  migration: Allow network to fail even during recovery
  migration: Change ram_dirty_bitmap_reload() retval to bool
  migration: Change ram_save_queue_pages() retval to bool

 migration/migration.h        |   9 +-
 migration/qemu-file.h        |   1 +
 migration/ram.h              |   5 +-
 migration/migration.c        | 190 +++++++++++++++++++++--------------
 migration/qemu-file.c        |   2 +-
 migration/ram.c              |  75 +++++++-------
 tests/qtest/migration-test.c | 102 +++++++++++++++++--
 migration/trace-events       |   4 +-
 8 files changed, 261 insertions(+), 127 deletions(-)

-- 
2.41.0


