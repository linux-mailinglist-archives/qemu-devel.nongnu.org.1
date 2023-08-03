Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0204076EEB9
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 17:54:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRae8-0004Sd-UV; Thu, 03 Aug 2023 11:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRae6-0004S6-5g
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:53:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRae4-00040A-QY
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691078028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xZiOMJMcmxkeIVMUe8RXq2vZaPMXPYVUP8mn+kwjia8=;
 b=SCn7si4PO3nRx69ATPzcso+xdlB7fXZ9pKkZOJOZ/es9G8PYm83A9iPTYrnOXYsn3sUklp
 kJ5/uyN34OngKaHWwRPUA8yrIUkkGxK2ruCfJCHsEtIbsxrmULisnl0Ad3iZW/TDGej3xZ
 VVFtkUk09ztmr7sf/ZTq28wiFWYs67Q=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-GX5z1hWuMRGOHiQgPep-0Q-1; Thu, 03 Aug 2023 11:53:46 -0400
X-MC-Unique: GX5z1hWuMRGOHiQgPep-0Q-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4059b5c3dd0so2671481cf.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 08:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691078026; x=1691682826;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xZiOMJMcmxkeIVMUe8RXq2vZaPMXPYVUP8mn+kwjia8=;
 b=MeBIMbkSr2szVuIcV6Xiu04YOYFVUbBOoBxXh08pMGcZxouM+UNTW4QU+lBwjsZ96J
 npP7bai2ARGkZ7PEdc2Z89/7uMWTL4rrpyp4gZyA0Kw0+apweZsWycBpSkK/qyHqCZEY
 mPf7r6bRKIMbD+icjtpeykNPiHVlPUc3kLtv86HvamBz58BfDoMKYOBraEJKCS08nzgO
 P0kURhAmNsKAZjw92OdgdJGKNPrZEsIiKeE7BPWu5ovYAiiZ9kYR6UTIl/XwJ3ClBaTh
 0bP2XOnSt8HZyYL3m3WGvJVMutmhuJcApUfQQnP5ggIhUkUQ9Hnic5iQYEjJyEXz/NBg
 XjtA==
X-Gm-Message-State: ABy/qLavH9tJbCUn3VEKl7hGJoDY/76HgXL1zQ94QjQ355FEoubMEJ+1
 92H9rF3r94nGCZgNSRDpqXNSU/c/YdJ90Pcmty3YYWZiDsMFsbAKSBzKUq+MdQj8Y5/zX9jLy/p
 g1oJmzEUISfntucYpDkRe6sA/iVQdvwQ/jf4EasM4tk6X6YHrpGVxeItjIxLVIXuVMhsLbi2s
X-Received: by 2002:a05:622a:1828:b0:3f6:a8e2:127b with SMTP id
 t40-20020a05622a182800b003f6a8e2127bmr20045127qtc.5.1691078026103; 
 Thu, 03 Aug 2023 08:53:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHGaYY57zfTLIddHySK328hEZbgw1O5SUYZREH1Z6/SoW3v75Fyx2h0+llND5xFUFCMleiMsA==
X-Received: by 2002:a05:622a:1828:b0:3f6:a8e2:127b with SMTP id
 t40-20020a05622a182800b003f6a8e2127bmr20045104qtc.5.1691078025776; 
 Thu, 03 Aug 2023 08:53:45 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 iw2-20020a05622a6f8200b00403f5873f5esm23682qtb.24.2023.08.03.08.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 08:53:45 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhiyi Guo <zhguo@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Eric Blake <eblake@redhat.com>, Chensheng Dong <chdong@redhat.com>
Subject: [PATCH for-8.2 v2 0/2] migration: Add max-switchover-bandwidth
 parameter
Date: Thu,  3 Aug 2023 11:53:42 -0400
Message-ID: <20230803155344.11450-1-peterx@redhat.com>
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
- Fix wordings, reindent qapi doc [Markus]
- Added a pre-requisite patch to dedup documents in qapi/migration
- Rename available-bandwidth to max-switchover-bandwidth [Dan]

This is the v2 series to add the new parameter to guide migration
switchover calculations.

For more information on the new parameter and why we need it, please read
commit message in patch 2.

Please have a look, thanks.

Peter Xu (2):
  qapi/migration: Deduplicate migration parameter field comments
  migration: Allow user to specify migration switchover bandwidth

 qapi/migration.json            | 297 +++------------------------------
 migration/migration.h          |   2 +-
 migration/options.h            |   1 +
 migration/migration-hmp-cmds.c |  14 ++
 migration/migration.c          |  19 ++-
 migration/options.c            |  28 ++++
 migration/trace-events         |   2 +-
 7 files changed, 80 insertions(+), 283 deletions(-)

-- 
2.41.0


