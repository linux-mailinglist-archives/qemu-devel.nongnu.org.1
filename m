Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D1CB1534F
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Jul 2025 21:16:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugpm4-0005JO-Bl; Tue, 29 Jul 2025 15:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugnoQ-0005vG-7w
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 13:08:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugnoO-0008IW-3r
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 13:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753808902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6JhyUj9fCXNk4/S50myjMuDB10iGQVWrB+81eqq01EM=;
 b=a2EJZUW29BTbP9yUVskkxpUY0ACgjTRZ2BBJKtPcODMFfmupeM6Ahq+pwKEzs6AsQw6NCv
 3PbAjGrZjBXOb20QPcXyrAqbISMPrzJ82CnF3jTG8O5hasdkosaepNNcFcyvfNcobalulS
 u1GLPTIA4Moo/eB9wgAhBu2Eir3c9UM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-QUb_Ik18Pw2_-qKOOGnf4w-1; Tue,
 29 Jul 2025 13:08:17 -0400
X-MC-Unique: QUb_Ik18Pw2_-qKOOGnf4w-1
X-Mimecast-MFC-AGG-ID: QUb_Ik18Pw2_-qKOOGnf4w_1753808896
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B2F81956089; Tue, 29 Jul 2025 17:08:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.29])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D26DC1800242; Tue, 29 Jul 2025 17:08:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>,
 Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 0/3] aspeed: Update vbootrom image
Date: Tue, 29 Jul 2025 19:07:57 +0200
Message-ID: <20250729170800.678363-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello !

Michael provided changes to fix the build of the vbootrom image of the
AST2700 SoC machine in [1]. However, a workaound in roms/Makefile was
still necessary to build ast27x0_bootrom.bin correctly. This was later
fixed in [2].

This series is an update of [1] including a vbootrom image matching
the new commits.

Thanks,
C.

[1] https://lore.kernel.org/qemu-devel/2a89ad4c8f5665d07952a4f1749caa6ec0cd3d9c.1753654515.git.mjt@tls.msk.ru/
[2] https://github.com/google/vbootrom/commit/7b1eb5f7fe6a85a03a1e40aa703a6ebbdb644e31


Cédric Le Goater (1):
  aspeed: Update vbootrom image to commit 183c9ff8056b

Michael Tokarev (2):
  roms/vbootrom: update to 7b1eb5f7fe6a
  roms/Makefile: build ast27x0_bootrom

 pc-bios/ast27x0_bootrom.bin | Bin 15552 -> 16408 bytes
 roms/Makefile               |   5 +++++
 roms/vbootrom               |   2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.50.1


