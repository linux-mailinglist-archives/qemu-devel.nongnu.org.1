Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E70C8254C2
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 15:00:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLkj1-0005ap-RG; Fri, 05 Jan 2024 08:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rLkj0-0005ad-A8
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 08:59:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rLkix-00039h-U9
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 08:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704463138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0hof9TN+rxDXuxoyt0Vciyfx0KPFFfZq+/jydNyxF7Q=;
 b=BkS/qtwmuefd3j17RfcwsnUzN1YNlwapvhbeJhhnJqFM6/CfOubgM0JW2SLycD6tEQ1x9q
 i5ba7zXbAKFTypjrVJ35G42swD9GORS4JtfphSuetIh0hnq2ExoBzGMZ8tPc+es6TzmGnt
 fsGrJ9Qp4b80po8Uh9L7ZTfsUFq32kA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-BNBNowR1MmeOnp9XB6nE1Q-1; Fri, 05 Jan 2024 08:58:56 -0500
X-MC-Unique: BNBNowR1MmeOnp9XB6nE1Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A25788CC40;
 Fri,  5 Jan 2024 13:58:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B64E1121306;
 Fri,  5 Jan 2024 13:58:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 203AD18009E5; Fri,  5 Jan 2024 14:58:55 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 0/2] hw/pflash: implement update buffer for block writes
Date: Fri,  5 Jan 2024 14:58:52 +0100
Message-ID: <20240105135855.268064-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.679,
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

When running qemu with edk2 efi firmware on aarch64 the efi
variable store in pflash can get corrupted.  qemu not doing
proper block writes -- flush all or nothing to storage -- is
a hot candidate for being the root cause.

This little series tries to fix that with an update buffer
where block writes are staged, so we can commit or discard
the changes when the block write is completed or canceled.

Gerd Hoffmann (2):
  hw/pflash: refactor pflash_data_write()
  hw/pflash: implement update buffer for block writes

 hw/block/pflash_cfi01.c | 132 ++++++++++++++++++++++++++++------------
 1 file changed, 93 insertions(+), 39 deletions(-)

-- 
2.43.0


