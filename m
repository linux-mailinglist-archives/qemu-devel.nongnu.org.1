Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7247A801043
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 17:37:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r96V6-0005gi-Ii; Fri, 01 Dec 2023 11:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r96V3-0005gI-22
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 11:36:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r96V1-00062v-2m
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 11:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701448577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WFOkWKRkZpusXO7wo38sF7DJOPZZOkLidfN+xLAfTgc=;
 b=DB4o4NJPHRRKokQFtT7mxW6sL9COXlZYG63h3N+HahprYn1PIOhhmqxRtzvGLHzj4OtO6D
 C146G/5KeYVFwCDCbdpPyOuYigUt7wtvyL0EVO0PfWiHGCq9cJ90+hwymVVQJtxWCFaoDz
 jMrArpwdJCXnsiROaDC6SjlvE5HZWNs=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-WORBfVEuNgigAxzjhjkJAg-1; Fri, 01 Dec 2023 11:36:16 -0500
X-MC-Unique: WORBfVEuNgigAxzjhjkJAg-1
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-7b35d293a41so61583839f.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 08:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701448575; x=1702053375;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WFOkWKRkZpusXO7wo38sF7DJOPZZOkLidfN+xLAfTgc=;
 b=aTKVz4XYyjYKH2wNN3Rd/0sYcSzlEMnPx5jcFi7sch0lfMtpFDXMnkQVz92M9iXJUw
 8aOAJbpW080EM6qhLXHxD3w7aFK+hOgfpXBL7BQZNDljH5F7DKk2oKsLbKzo/1jibsPr
 m28RydtEnz2y+osGNtQK3sY8iO3CRngvWCrFfxN12VPn9wYiXYBL44LskhvDsV9sFIpO
 cdfvmVIGL4NT0/Io1+6/mAYYtLKh1wKABAMVnWNZFVhQ5eDbuIajCVZ6egRoAmFzlF6s
 jAr5uSqSHtUbFMuSgLr6S5iW5mH0vUXeiFXUS7pBirklqm24YcD01URgUtQ/Fys0AY+w
 e/9g==
X-Gm-Message-State: AOJu0YxLL4eZTqws/Ftcu6kSm9Z8D3ffEo+yeEuTp6shsPK85EivKupE
 hz9icjyRJLIOhwsHylQP/xIrowzNNQ4DMu8scLL6jpu3IGwuFkTuwD4P7bcLcI06scouDC+wwjX
 Y7rjSMcNJFtWzknm3stIBUH9n18K+TUK/S1N5AZPJW2x3XShPoYiOmX8QJDaq1P9FXLLgE6y8
X-Received: by 2002:a05:6602:2bd2:b0:7b3:e4a6:45d4 with SMTP id
 s18-20020a0566022bd200b007b3e4a645d4mr10238013iov.0.1701448575733; 
 Fri, 01 Dec 2023 08:36:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7UfshLNhrOovd+rv7WAK9dYq5qIWgq9hvpr1i5TL4McoKsWXmPbqLxt6NR1DGXuLh41GiOg==
X-Received: by 2002:a05:6602:2bd2:b0:7b3:e4a6:45d4 with SMTP id
 s18-20020a0566022bd200b007b3e4a645d4mr10237989iov.0.1701448575390; 
 Fri, 01 Dec 2023 08:36:15 -0800 (PST)
Received: from x1n.redhat.com
 (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a02a808000000b0046675345998sm932421jaj.96.2023.12.01.08.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 08:36:15 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Het Gala <het.gala@nutanix.com>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>
Subject: [PULL 0/1] Migration 20231201 patches
Date: Fri,  1 Dec 2023 11:36:12 -0500
Message-ID: <20231201163613.1371497-1-peterx@redhat.com>
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

The following changes since commit abf635ddfe3242df907f58967f3c1e6763bbca2d:

  Update version for v8.2.0-rc2 release (2023-11-28 16:31:16 -0500)

are available in the Git repository at:

  https://github.com/xzpeter/qemu.git tags/migration-20231201-pull-request

for you to fetch changes up to bc1d54ee51367955b50786323ee5a6bd8c0f0034:

  migration: Plug memory leak with migration URIs (2023-12-01 11:01:28 -0500)

----------------------------------------------------------------
Migration patches for rc3:

- One more memleak regression fix from Het

----------------------------------------------------------------

Het Gala (1):
  migration: Plug memory leak with migration URIs

 migration/migration.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.41.0


