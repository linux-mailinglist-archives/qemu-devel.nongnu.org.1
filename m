Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EAB8274B4
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 17:10:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMsBy-0006qT-VD; Mon, 08 Jan 2024 11:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rMsBs-0006pt-Ox
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 11:09:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rMsBd-0000p2-Bf
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 11:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704730147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PClD5Oor2PsXPJAq41IliW2ojno69JxVKx4QoYmVwtM=;
 b=avqlV41IEheHcBoYLbBdrEsRV6i2wYdOSNYREoR3T7LuOBO+fEYRF2u/B7ENQssKDMZmtB
 fC6HEkumAffh57C2emJt3O8LQnfhD6AWtpx9vryiyIft66KRwvcaz1Yx6/u965Bde2J98L
 0+Qn0sFpVW5qzoSSFFVuLm8MsmUo+Wc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-f8w619KZM_iAXhEw9iAL4Q-1; Mon,
 08 Jan 2024 11:09:01 -0500
X-MC-Unique: f8w619KZM_iAXhEw9iAL4Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E7971C05144;
 Mon,  8 Jan 2024 16:09:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.194.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 417205190;
 Mon,  8 Jan 2024 16:09:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 194C4180079A; Mon,  8 Jan 2024 17:09:00 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 0/3] hw/pflash: implement update buffer for block writes
Date: Mon,  8 Jan 2024 17:08:56 +0100
Message-ID: <20240108160900.104835-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

When running qemu with edk2 efi firmware on aarch64 the efi
variable store in pflash can get corrupted.  qemu not doing
proper block writes -- flush all or nothing to storage -- is
a hot candidate for being the root cause.

This little series tries to fix that with an update buffer
where block writes are staged, so we can commit or discard
the changes when the block write is completed or canceled.

v2:
 - add patch to use ldn_{be,le}_p and stn_{be,le}_p
 - add/update tracing

Gerd Hoffmann (3):
  hw/pflash: refactor pflash_data_write()
  hw/pflash: use ldn_{be,le}_p and stn_{be,le}_p
  hw/pflash: implement update buffer for block writes

 hw/block/pflash_cfi01.c | 171 +++++++++++++++++++++-------------------
 hw/block/pflash_cfi02.c |   2 +-
 hw/block/trace-events   |   7 +-
 3 files changed, 97 insertions(+), 83 deletions(-)

-- 
2.43.0


