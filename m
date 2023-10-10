Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEA77BEFCA
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 02:35:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq0hT-0005d8-4o; Mon, 09 Oct 2023 20:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qq0hQ-0005cJ-F4
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 20:34:12 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qq0hM-0006n3-37
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 20:34:12 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-578b4981526so3214760a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 17:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1696897923; x=1697502723;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ci4Q1fBlKK/wKKRcTO+K+5sxZzXJvX/W6QQcdDAyX6w=;
 b=RunCZjqNH0p1d0FrYqTjE9257ursWyzgveCAuohFCbTSvorBzxt5xT8s9n2KAGVZlD
 V7hN4o9U2Elg30MO+kqeI+mBm9mioXb7YQl6ptDm5jfPpUOYPQCU40SvFfQPimu6+t7d
 VgTHceGlaG5/c5vXlGKRZGVclU2ILyY8fzGcftPV6hG9sD7yoqu+Eum6R5wCRTk0zMWe
 7Ms4JRWyJnjE+Je81idzKHK2oeBDmTuz4sE84bYjf0+rtN/b378Wb/EzatuhQ8RuALV6
 LWJ+ZwrU9+CaYKp6bfw9llt0GpqnwIE8dQampIJigu1XSPcfXkT2Df9b0WRCGy1NVMQo
 YkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696897923; x=1697502723;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ci4Q1fBlKK/wKKRcTO+K+5sxZzXJvX/W6QQcdDAyX6w=;
 b=sAInTohnNhgUVOoNJ2E6SG9OdZWCZiP+PtJgiPOS6PgSlLT41Gj5H56qOsg2/e7+DQ
 dOYscJvyMnN/ympueY3ihOnhbdVuK/oQzZXMiZyGuczUCTSuI6LVa5nkqq8TBz1PmaiS
 m6/zaWBUFheOhjbGYMFolrbsGGNuevGlvmJn8dPYwTYep2Ey2TOaPzX2JPyr1syg/xy2
 Lvc0r7UgJ/gBwR+kHRDIWfo/PTich1jtk9/YTTE0QQSTA62UMCHv3uF7RQ1HFdpqHyWq
 KQOtnxyYrDr+FxFwNsQY36nNiweuPKSjonZkiduv7Fh+6Hy98NkXT22M2SCG2HGdCSd4
 FKQw==
X-Gm-Message-State: AOJu0Yx0EePh8YCubaQJs+3ar8AfRNledwG4Qb8spBx5EfTSZ4UJ/PZn
 IVUGSUzp+DCX65m3ug9v628x9+FlFobE/iK9vWYhWgQ9
X-Google-Smtp-Source: AGHT+IHEsiDQTpSxmWl5lVmuQyagQErRqHXn6DIcgH39+Zr6dRUYJDWASyuKiDi6brNkTNhE4cg7Ow==
X-Received: by 2002:a17:90a:f48f:b0:268:557e:1848 with SMTP id
 bx15-20020a17090af48f00b00268557e1848mr13268363pjb.2.1696897922624; 
 Mon, 09 Oct 2023 17:32:02 -0700 (PDT)
Received: from localhost.localdomain ([118.114.95.207])
 by smtp.gmail.com with ESMTPSA id
 20-20020a17090a199400b00278f1512dd9sm11849866pji.32.2023.10.09.17.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 17:32:02 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 0/2] Dirty page rate and dirty page limit 20231010 patches
Date: Tue, 10 Oct 2023 08:31:52 +0800
Message-Id: <cover.1696896603.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2023-10-05 09:01:01 -0400)

are available in the Git repository at:

  https://github.com/newfriday/qemu.git tags/dirtylimit-dirtyrate-pull-request-20231010

for you to fetch changes up to 320a6ccc769dc09ae7ad0b4838e322018f334bf4:

  migration/dirtyrate: use QEMU_CLOCK_HOST to report start-time (2023-10-10 08:04:12 +0800)

----------------------------------------------------------------
Dirtylimit and dirtyrate 20231010 patches PULL request

Dirty page rate measurement optimization.
Please apply, thanks, Yong.

----------------------------------------------------------------
Andrei Gudkov (2):
  migration/calc-dirty-rate: millisecond-granularity period
  migration/dirtyrate: use QEMU_CLOCK_HOST to report start-time

 migration/dirtyrate.c | 122 +++++++++++++++++++++++++++---------------
 migration/dirtyrate.h |  12 +++--
 qapi/migration.json   |  58 ++++++++++++++++----
 3 files changed, 134 insertions(+), 58 deletions(-)

-- 
2.39.1


