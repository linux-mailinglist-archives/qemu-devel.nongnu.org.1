Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 568EB825F95
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 14:03:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rM6It-0007M7-Jl; Sat, 06 Jan 2024 08:01:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>) id 1rM6Ip-0007ID-UB
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 08:01:28 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>) id 1rM6In-0000Mm-Rb
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 08:01:27 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by zoidberg.rfc1149.net (Postfix) with ESMTPSA id 184D980024;
 Sat,  6 Jan 2024 14:01:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rfc1149.net; s=smtp;
 t=1704546082; bh=RJvvnhjvxoEAnWeYCtkVFpTmcZtxDnQbTiEs6bho4fU=;
 h=From:To:Cc:Subject:Date;
 b=SE83JrsM8vpsXkJAOBNq6EIo8mzR7O3w8x2iTDNquHoKwkCZg0zB4jQPEmBIOt1o1
 hOeHs0d+t6et5ndnsgf+lqF6UgQpq2QOAUoNDgyplAJhOtPyidqhkny9HnUb11DiMN
 C2CdVozNeM91Fwi6MdyxZQltXG33cHoyCpYR20JdylYPMEhWwAew+hApdW2GgwGCOZ
 O2IW6duHWPF2uTP2h+KzdC2T8buDfhYdmeEcxHxLYmI8zbyAHlkG+6N3OfU0jIqY2x
 SmlHof/2aTh+X8nd0R+JmJb8nqfBRq9Kn5StsjNZw24Fbf7NkWRn3lQW19U4KVQQnu
 RIDYKrTnotnPQ==
From: Samuel Tardieu <sam@rfc1149.net>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Samuel Tardieu <sam@rfc1149.net>
Subject: [PATCH] tests/qtest/virtio-ccw: Fix device presence checking
Date: Sat,  6 Jan 2024 14:01:21 +0100
Message-ID: <20240106130121.1244993-1-sam@rfc1149.net>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
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

An apparent copy-paste error tests for the presence of the
virtio-rng-ccw device in order to perform tests on the virtio-scsi-ccw
device.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
 tests/qtest/virtio-ccw-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/virtio-ccw-test.c b/tests/qtest/virtio-ccw-test.c
index f4f5858b84..7a5357c212 100644
--- a/tests/qtest/virtio-ccw-test.c
+++ b/tests/qtest/virtio-ccw-test.c
@@ -85,7 +85,7 @@ int main(int argc, char **argv)
     if (qtest_has_device("virtio-rng-ccw")) {
         qtest_add_func("/virtio/rng/nop", virtio_rng_nop);
     }
-    if (qtest_has_device("virtio-rng-ccw")) {
+    if (qtest_has_device("virtio-scsi-ccw")) {
         qtest_add_func("/virtio/scsi/nop", virtio_scsi_nop);
         qtest_add_func("/virtio/scsi/hotplug", virtio_scsi_hotplug);
     }
-- 
2.42.0


