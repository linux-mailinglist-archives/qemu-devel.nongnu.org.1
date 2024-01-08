Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E73A827622
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 18:16:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMtEC-0000hu-Si; Mon, 08 Jan 2024 12:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rMtDq-0008NQ-3x; Mon, 08 Jan 2024 12:15:35 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rMtDm-0008GT-Oh; Mon, 08 Jan 2024 12:15:33 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by zoidberg.rfc1149.net (Postfix) with ESMTPSA id 9303D80027;
 Mon,  8 Jan 2024 18:15:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rfc1149.net; s=smtp;
 t=1704734123; bh=HNiUK49oZHkgFUxKn3Q0TQPjJMoqu+JCF9gCepiQyYQ=;
 h=From:To:Cc:Subject:Date;
 b=j2swym7YqzuhxYGZ+V+2XQdkwiTL0vVYwTolcVPr23uAS8/UaAFlcfw+FyDoi7spy
 hxmKigPoO4Eny/cYwCYmI9dVUgPsi5/QMMnf+wJxVKuaXfY6kU9qk+rI5H5WvgS0ES
 e9MSl/Bo3w7gZ1RLARmt521oUpP97yYpEY0BVoMtSGZjoqm4bqjZN8xGQ8tECa0JVr
 WDek2NU1hMQPtTzak1jdzOQipHls8FXHkPKqvsdht7RHUQEZRkWHBJZRdf3ZByZ9/9
 tEYwbp7NVpBdXz0X1/eVLnpPnT9nFfiAyKXQF7tfI2CKOykTb28oCsQnN+kila1Byk
 3flIwIVRuIeGg==
From: Samuel Tardieu <sam@rfc1149.net>
To: qemu-devel@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, devel@lists.libvirt.org,
 qemu-block@nongnu.org, Samuel Tardieu <sam@rfc1149.net>
Subject: [PATCH 0/2] Deprecate the shix machine and the TC58128 flash device
Date: Mon,  8 Jan 2024 18:15:20 +0100
Message-ID: <20240108171523.2487291-1-sam@rfc1149.net>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The shix machine was a research project started around 2003 at
Télécom Paris. Preliminary support in QEMU was added in 2005
back when the QEMU architecture was less structured than it is
now. Unfortunately, the support for the shix machine and its
peripherals, such as the TC58128 16MiB flash device, has never
been maintained as the research project used the real machine.

This project stopped around 2010 and to the best of my knowledge
and after consulting with the original author Alexis Polti,
I propose to deprecate it in QEMU as well as the TC58128
flash device which does not implement the QOM model and still
contains debug fprintf statements.

Samuel Tardieu (2):
  target/sh4: Deprecate the shix machine
  hw/block: Deprecate the TC58128 block device

 docs/about/deprecated.rst | 5 +++++
 hw/block/tc58128.c        | 1 +
 hw/sh4/shix.c             | 1 +
 3 files changed, 7 insertions(+)

-- 
2.42.0


