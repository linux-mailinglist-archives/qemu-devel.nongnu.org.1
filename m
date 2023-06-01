Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AA8719B47
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:55:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gqb-0000p7-97; Thu, 01 Jun 2023 07:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqS-0000jK-88
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqP-0000Jx-S1
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685620313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=U/5Y08bf5hAARTSr72mcZVRcCgcW9clYal7g/ThHdh4=;
 b=a0+PgETjH0lYT0LSjSAUnvhEP+p2VWD+ZNC0ldl6s9+Ur6bu93xMEesq2k+SlPSsmtMdEv
 S30IpOgqJZe3d66uKhoGePGBVPN6/PNF8hwEOfHzWqWj8pzckXzSFLh7vIpps/n42KYoNJ
 fd0o5YapM3yum+uIfWR3h8hPMIIMHAM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-HQBcezhKOSSMQUAOGZCXKA-1; Thu, 01 Jun 2023 07:51:48 -0400
X-MC-Unique: HQBcezhKOSSMQUAOGZCXKA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9715654ab36so51577866b.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620307; x=1688212307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U/5Y08bf5hAARTSr72mcZVRcCgcW9clYal7g/ThHdh4=;
 b=jtHwc9W1kSloNORV5u/VqAg+LKM+kLdBEqcoPfHy9y3DTDOgs3w/iHp9rH9/rMmq6O
 PhO5KDEJq/AQmkTLPpL+vHcq6TqmGEzus0jq0C+1B/e8wmH1gZGMEailzxQlDKIu1t5/
 1z0r0aVh6H5MCW9ZMqTfqJ14P0Vplw7nswCJ3kRBzQRRX3gpKqUucAFRq3ydUg5nWwmi
 OgoYlaeYqH7x/A4/vaWpn5v5tH6FkCDcRo6rmrUZJKZsoVhfDGhgwfIOes75NyV7j8lJ
 NJDyAiGtOFy8nlBB1KHQMOgRj0uxHHq5L7ZsraJprbG1ugSmzzKDRMkwh2mcLEnYP0D+
 +HkQ==
X-Gm-Message-State: AC+VfDzsyn+SrURlx7EOm/8WXSiNeSwDtSh1ZuPzTA65vBpNKQ6IxTyT
 AaQwtDx/zXGcoeQsaAdbXQjHcBQ/YcviPYKTHEehmh3mJUqdUms4zJjyrciiOWcRJg4OE8UHuMd
 QUDavQX1C8pUB55vtE6SAIoxXcfzB33PUs1N1YgHeIVzPjkFyFaUvPViRrfrzvoD+eA/Tf58AIk
 E=
X-Received: by 2002:a17:907:320c:b0:96f:f98c:ac71 with SMTP id
 xg12-20020a170907320c00b0096ff98cac71mr8101393ejb.67.1685620307096; 
 Thu, 01 Jun 2023 04:51:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7KiIzkDeVkptbKD4DRobqGiRPALeHkVE6TgwZuNL4YKP3eO2D7k5wVWMUBS8ql4xOmMhgogw==
X-Received: by 2002:a17:907:320c:b0:96f:f98c:ac71 with SMTP id
 xg12-20020a170907320c00b0096ff98cac71mr8101371ejb.67.1685620306789; 
 Thu, 01 Jun 2023 04:51:46 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a17090603c700b0096a68648329sm10392895eja.214.2023.06.01.04.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:51:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH 00/12] block: more fixes to coroutine_fn marking
Date: Thu,  1 Jun 2023 13:51:33 +0200
Message-Id: <20230601115145.196465-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

*** BLURB HERE ***

Paolo Bonzini (12):
  file-posix: remove incorrect coroutine_fn calls
  qed: mark more functions as coroutine_fns and GRAPH_RDLOCK
  vpc: mark more functions as coroutine_fns and GRAPH_RDLOCK
  bochs: mark more functions as coroutine_fns and GRAPH_RDLOCK
  block: mark another function as coroutine_fns and GRAPH_UNLOCKED
  cloop: mark more functions as coroutine_fns and GRAPH_RDLOCK
  dmg: mark more functions as coroutine_fns and GRAPH_RDLOCK
  vmdk: mark more functions as coroutine_fns and GRAPH_RDLOCK
  vhdx: mark more functions as coroutine_fns and GRAPH_RDLOCK
  qcow2: mark more functions as coroutine_fns and GRAPH_RDLOCK
  block: use bdrv_co_getlength in coroutine context
  block: use bdrv_co_debug_event in coroutine context

 block.c                  |  11 ++--
 block/bochs.c            |   7 +-
 block/cloop.c            |   9 +--
 block/dmg.c              |  21 +++---
 block/file-posix.c       |  29 +++++----
 block/io.c               |  14 ++--
 block/parallels.c        |   4 +-
 block/qcow.c             |  30 ++++-----
 block/qcow2-bitmap.c     |  26 ++++----
 block/qcow2-cluster.c    |  24 +++----
 block/qcow2-refcount.c   | 134 ++++++++++++++++++++-------------------
 block/qcow2.c            |  20 +++---
 block/qcow2.h            |  33 +++++-----
 block/qed-check.c        |   5 +-
 block/qed-table.c        |   6 +-
 block/qed.c              |  15 +++--
 block/raw-format.c       |   4 +-
 block/vhdx-log.c         |  36 ++++++-----
 block/vhdx.c             |  73 ++++++++++-----------
 block/vhdx.h             |   5 +-
 block/vmdk.c             |  55 ++++++++--------
 block/vpc.c              |  52 +++++++--------
 include/block/block-io.h |   7 ++
 23 files changed, 323 insertions(+), 297 deletions(-)

-- 
2.40.1


