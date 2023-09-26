Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5799C7AF417
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 21:25:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlDgI-0008Tj-Vf; Tue, 26 Sep 2023 15:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qlDgF-0008TT-0c
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:25:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qlDgD-00029n-7k
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:25:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0A6E81F749;
 Tue, 26 Sep 2023 19:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695756307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JKOKBhT57MVl9BDREKbRYpPBO6CGATfdJZDtO5lOybU=;
 b=G4NqDgGT5Z5b4U6Uv1COsgxkFWtZF5/Dq5CPmK/m2VECyaTtHDku53UrBMrMetRL1imNEj
 uhPA1TYhArweV7AbhWcb74UVD5SThR9wHv/9TRc0Qr5P0Jg2SPCszScTMd6iLlerIjNs4W
 dliJRx4YKXK5JOTnrBhH1AEihq9Cir0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695756307;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JKOKBhT57MVl9BDREKbRYpPBO6CGATfdJZDtO5lOybU=;
 b=03ULzx+jn8NSOaDY1YgEjs8DMOJv8jAb/4g7yzSfvH+7ARZp7/HWjUP3CbBPd7wVWwlSyB
 4PwJ2cLv3v3tSVCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5564313434;
 Tue, 26 Sep 2023 19:25:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8w5+CBEwE2WCdwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 26 Sep 2023 19:25:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Dario Faggioli <dfaggioli@suse.com>,
 Vasiliy Ulyanov <vulyanov@suse.de>
Subject: [PATCH] optionrom: Remove build-id section
Date: Tue, 26 Sep 2023 16:25:02 -0300
Message-Id: <20230926192502.15986-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Our linker script for optionroms specifies only the placement of the
.text section, leaving the linker free to place the remaining sections
at arbitrary places in the file.

Since at least binutils 2.39, the .note.gnu.build-id section is now
being placed at the start of the file, which causes label addresses to
be shifted. For linuxboot_dma.bin that means that the PnP header
(among others) will not be found when determining the type of ROM at
optionrom_setup():

(0x1c is the label _pnph, where the magic "PnP" is)

$ xxd /usr/share/qemu/linuxboot_dma.bin | grep "PnP"
00000010: 0000 0000 0000 0000 0000 1c00 2450 6e50  ............$PnP

$ xxd pc-bios/optionrom/linuxboot_dma.bin | grep "PnP"
00000010: 0000 0000 0000 0000 0000 4c00 2450 6e50  ............$PnP
                                   ^bad

Using a freshly built linuxboot_dma.bin ROM results in a broken boot:

  SeaBIOS (version rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org)
  Booting from Hard Disk...
  Boot failed: could not read the boot disk

  Booting from Floppy...
  Boot failed: could not read the boot disk

  No bootable device.

We're not using the build-id section, so pass the --build-id=none
option to the linker to remove it entirely.

Note: In theory, this same issue could happen with any other
section. The ideal solution would be to have all unused sections
discarded in the linker script. However that would be a larger change,
specially for the pvh rom which uses the .bss and COMMON sections so
I'm addressing only the immediate issue here.

Reported-by: Vasiliy Ulyanov <vulyanov@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 pc-bios/optionrom/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
index b1fff0ba6c..30d07026c7 100644
--- a/pc-bios/optionrom/Makefile
+++ b/pc-bios/optionrom/Makefile
@@ -36,7 +36,7 @@ config-cc.mak: Makefile
 	    $(call cc-option,-Wno-array-bounds)) 3> config-cc.mak
 -include config-cc.mak
 
-override LDFLAGS = -nostdlib -Wl,-T,$(SRC_DIR)/flat.lds
+override LDFLAGS = -nostdlib -Wl,--build-id=none,-T,$(SRC_DIR)/flat.lds
 
 pvh.img: pvh.o pvh_main.o
 
-- 
2.35.3


