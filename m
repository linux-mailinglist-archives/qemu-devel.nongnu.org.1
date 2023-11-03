Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E04BB7DFF53
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 08:03:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyoBp-000636-BB; Fri, 03 Nov 2023 03:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qyoBj-00062g-6v
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 03:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qyoBf-0000ua-AO
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 03:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698994904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=J9zawrpA5xIsvvPzacvF9Z0p7AhDM3PTZ8bnbz22bg8=;
 b=RhUnsfZJxBsIulQhV15CzibT6rwp3IGzUvADMpUQACctDrsH2c8gEUAe2FN7pgJWI4hwPD
 TIgHO+vqeFN4Fa/ZF3F2akniR4oNsnEia1JghjG7Sszx8AmERwJL+ABEjBeVnAI8p65kDw
 Dgshvj4Ps1QyCVqe/pjbwNTEzUsFW1E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-EvQpInKYP7a_7T_lqW1Zhw-1; Fri, 03 Nov 2023 03:01:41 -0400
X-MC-Unique: EvQpInKYP7a_7T_lqW1Zhw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3A5B185A781;
 Fri,  3 Nov 2023 07:01:40 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 643A62166B26;
 Fri,  3 Nov 2023 07:01:39 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 richard.henderson@linaro.org, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PULL 0/8] Dump patches
Date: Fri,  3 Nov 2023 11:01:28 +0400
Message-ID: <20231103070136.437557-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following changes since commit 6c9ae1ce82b65faa3f266fd103729878cf11e07e:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2023-11-01 06:58:11 +0900)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/dump-pull-request

for you to fetch changes up to 4023839757b2c01e0350ce92902c6f74dce7d011:

  dump: Drop redundant check for empty dump (2023-11-02 18:40:50 +0400)

----------------------------------------------------------------
dump queue

Hi

The "dump" queue, with:
- [PATCH v3 qemu 0/3] Allow dump-guest-memory to output standard kdump format
- [PATCH v2 0/5] dump: Minor fixes & improvements

----------------------------------------------------------------

Markus Armbruster (5):
  dump: Rename qmp_dump_guest_memory() parameter to match QAPI schema
  dump: Fix g_array_unref(NULL) in dump-guest-memory
  dump: Recognize "fd:" protocols on Windows hosts
  dump: Improve some dump-guest-memory error messages
  dump: Drop redundant check for empty dump

Stephen Brennan (3):
  dump: Pass DumpState to write_ functions
  dump: Allow directly outputting raw kdump format
  dump: Add command interface for kdump-raw formats

 qapi/dump.json        |  24 +++++--
 include/sysemu/dump.h |   3 +-
 dump/dump-hmp-cmds.c  |  21 ++++--
 dump/dump.c           | 158 +++++++++++++++++++++++-------------------
 hmp-commands.hx       |   9 ++-
 5 files changed, 134 insertions(+), 81 deletions(-)

-- 
2.41.0


