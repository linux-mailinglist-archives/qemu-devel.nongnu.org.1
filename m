Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BFD741B2C
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 23:51:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEd3R-0001Ke-Jc; Wed, 28 Jun 2023 17:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEd3D-0001IO-9R
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEd3A-0008Nj-P7
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687989006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2DsfWd7Fa9WcpkxAwkh6SnMn5nZKHfrdT3I8gYB0qu4=;
 b=C2iHp85vNscO6zsmqXMJdKkBRhCCBU7r/3Mvk1V9Gv2uLEzFj/ff4YvtdBx1axoNimEnB8
 o550aBgDC3fK713J8+iP9T1ROiY3LNtMksCHRLW337/rikun/vuSvGn4FWfOqoE7LCvuik
 9yuzbICGCGVlqB41/ipklX90HdGLiro=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-blkXDMrgNmWWjV7TOmr05A-1; Wed, 28 Jun 2023 17:50:04 -0400
X-MC-Unique: blkXDMrgNmWWjV7TOmr05A-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7672918d8a4so782585a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 14:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687989004; x=1690581004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2DsfWd7Fa9WcpkxAwkh6SnMn5nZKHfrdT3I8gYB0qu4=;
 b=Cdzf1tamrqBkpaAItUoz84obrKpfkxLx3u7ZRkIWtYajUTZpk+MSJWN1X8ZBtAZZYT
 9yDy0tR0twOIuub35Osw2fqlFybPZMNl4sk+Ki884gstqITWz/I/H5dXFyaf/kSQLKJs
 glzLsiZ8jLp+v7mC4iKRiSuL6acMPXPtX8kNts/ya81iXStxRNQZt+ghoEeHJZPUpOd0
 NG8h0UDL2E8L9yBaC1Yn4xNSCK95OuGUAxmm/82249+FeTt/OXFlhYn5194nbo7qf5+B
 XYphyOv8n3LON3VcRiEiWKsIQQB43rscwjBYP/IsQcBazipEt0tFT4Pv1IBl90KkJszh
 +nzA==
X-Gm-Message-State: AC+VfDwKaAM0NLMmjuoFbsXLnZnQv2Z93COJKyrnkMnXHLlcqJjfNwwf
 nLKJjNhmjVgdyGn+UG8AC3q884kwoc/ZYc512bm/PBAI9aF/UcfmwKhRF/l/m6xyUP2KnYo1sK1
 6MxVEZfwtB+ETH6NsePhcjAM55fCJVxvqATt1BtzLsTZK6dCNmXW23F9g98I7rREHhryB/b4y
X-Received: by 2002:a05:622a:d4:b0:400:aaa0:a4ef with SMTP id
 p20-20020a05622a00d400b00400aaa0a4efmr10706413qtw.6.1687989004300; 
 Wed, 28 Jun 2023 14:50:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5oMGVk1NqxxgUUtRQJnedAV/9SQBKQJHqHbn9a2Hy3/1tVOMtgw/Y5ESZJAW0m+bna9vSXMg==
X-Received: by 2002:a05:622a:d4:b0:400:aaa0:a4ef with SMTP id
 p20-20020a05622a00d400b00400aaa0a4efmr10706391qtw.6.1687989003976; 
 Wed, 28 Jun 2023 14:50:03 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 w29-20020ac84d1d000000b004032d9209a0sm255552qtv.50.2023.06.28.14.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 14:50:03 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH 0/7] migration: Better error handling in return path thread
Date: Wed, 28 Jun 2023 17:49:55 -0400
Message-ID: <20230628215002.73546-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
  migration: Let migrate_set_error() take ownership
  migration: Introduce migrate_has_error()
  migration: Refactor error handling in source return path
  migration: Deliver return path file error to migrate state too
  migration: Display error in query-migrate irrelevant of status
  qemufile: Always return a verbose error
  migration: Provide explicit error message for file shutdowns

 migration/migration.h    |   8 +-
 migration/ram.h          |   5 +-
 migration/channel.c      |   1 -
 migration/migration.c    | 168 +++++++++++++++++++++++----------------
 migration/multifd.c      |  10 +--
 migration/postcopy-ram.c |   1 -
 migration/qemu-file.c    |  20 ++++-
 migration/ram.c          |  42 +++++-----
 migration/trace-events   |   2 +-
 9 files changed, 147 insertions(+), 110 deletions(-)

-- 
2.41.0


