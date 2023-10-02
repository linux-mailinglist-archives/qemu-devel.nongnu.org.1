Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5CE7B500B
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 12:19:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnG1J-0006GW-Em; Mon, 02 Oct 2023 06:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qnG19-00069D-7B
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 06:19:12 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qnG17-0000PX-79
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 06:19:10 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1696241945; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=rwCbXxUGzyUIBSsS3oBnYJh8uxszl0wDeVcNGnveQZrUCwyyLvWh/QbngKO3FjoHnu
 oTxXIx0kQfU6Cc/6UCbmqyBPrc4T10qhgILQ+sExE0ff8tFopxgENYwiJcfs13txgvSx
 gS21vG6Az13CTq0H56uL5lgoECDtVnvpYfTtzOv+6WsM/DQDLueb8SbogpHywhBL2Wz/
 YXSP1fysl+hFwx3emVVhyNS9N4qzyxhSArCvt7vkIghXCBzBl4gMEd9YMyP8F521wWDb
 lerQ6ZWGBQwU5nSpTlAhGpsu6w9KDAp9vibXX6e+hI1dYt56MgBt80+PMvSUsCgQABVU
 JiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696241945;
 s=strato-dkim-0002; d=strato.com;
 h=Message-Id:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
 bh=ExubsMd8NERAcsXAGc3/1T7CVko08roUKViwVGdL+fI=;
 b=Z4O/y/oPkkuo2Um+rn0/YgLHoPa2jD9uFbjEDqutglAN8VFCiGdhNJL6Jf4rrOGww5
 Otbv7V/yK+hELDcHGDA7zgF4zBObs5lqrIRLKxCjnrhAWhyNrQTaNlvZRIqUzDH7OaU2
 A9PxysMY0RdFqw6kefZCAGBSUZiyLw0o7VAwZckmWSoPo+XzYGgYa+9sJoFxkO1GOcPp
 G3TO6sG7uoi3/yuM/dDE3hIQdoRBcyHQFXKRYyA9sPWu/c7P+v5QsPSS/JwdgUlAIcc5
 6SfxwTnqjEAaPcycJVFgzwRrDXoKdtCbocvgxqV1epi1fhAYu898jFYdB9HXl0vgxttk
 PixA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696241945;
 s=strato-dkim-0002; d=aepfle.de;
 h=Message-Id:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
 bh=ExubsMd8NERAcsXAGc3/1T7CVko08roUKViwVGdL+fI=;
 b=SYHSpi6ITo2qu1RIwyTMp7zCmKxoVjEJhJ+t+XUehGUr7i7BC6TMtmcUXOxc5C1aFA
 GU5R8/mrBXRbbUi9RidDn8QqPAvX1QgT01h4R2NPFfM3lqEQToKgnFDWzoEMzE0om8lD
 s666KnE9gHdzhY/2NeZIuGcbXRwOVHRHbCCpTXb5enikD/KSJMmKf0e/sl7WYn06cVza
 Xu3rm4emt/Ms4hT9W8NifYpxbeFzrV0gqXNGvhxVWSF9qwwPWv288bCH48UnRW1beWUx
 IqzGJLY9eqz8+Jp4AfzX36BdYtSeXS1ZxPIHotnzSwbKIExSQPt9G/RYvfFAicj0ccb1
 zzrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696241945;
 s=strato-dkim-0003; d=aepfle.de;
 h=Message-Id:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
 bh=ExubsMd8NERAcsXAGc3/1T7CVko08roUKViwVGdL+fI=;
 b=njc8elYa2SnHyLtaPG+D29y+5iS2JAJWpLqfuuFhvkV0wjPdcKCsYkAdohiMBPStew
 jmPtB64XgA7WGoZA6LCQ==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0mv9coXAg4x9Fv7Gp4ttOis9PG2JMIe0pr/QE053bd5klrGAg=="
Received: from sender by smtp.strato.de (RZmta 49.8.2 AUTH)
 with ESMTPSA id C041b2z92AJ5oYX
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate) for <qemu-devel@nongnu.org>;
 Mon, 2 Oct 2023 12:19:05 +0200 (CEST)
From: Olaf Hering <olaf@aepfle.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v1] roms: use PYTHON to invoke python
Date: Mon,  2 Oct 2023 12:18:44 +0200
Message-Id: <20231002101844.13799-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: none client-ip=81.169.146.160; envelope-from=olaf@aepfle.de;
 helo=mo4-p00-ob.smtp.rzone.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.518, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

python3 may not be the expected python version.
Use PYTHON to invoke python.

Fixes: 22e11539e1 ("edk2: replace build scripts")

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 roms/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/Makefile b/roms/Makefile
index 6859685290..67f709ba2d 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -147,7 +147,7 @@ skiboot:
 	cp skiboot/skiboot.lid ../pc-bios/skiboot.lid
 
 efi:
-	python3 edk2-build.py --config edk2-build.config \
+	$(PYTHON) edk2-build.py --config edk2-build.config \
 		--version-override "edk2-stable202302-for-qemu" \
 		--release-date "03/01/2023"
 	rm -f ../pc-bios/edk2-*.fd.bz2

base-commit: 36e9aab3c569d4c9ad780473596e18479838d1aa

