Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E017B6426
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:31:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnant-0001oZ-QK; Tue, 03 Oct 2023 04:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnans-0001nb-Ar
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:30:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnanq-0000Ft-Qb
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696321849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oM/kNXmOf7pF5c5aEMrfjCntn3rClcCDEzkX2duHLEA=;
 b=fpPJUiQKB9bc3J/z2xn/i7gvqIHcQ43WzH+falPUPg9oDAdD2NqfSTiWoLQ+3mlOz/xy28
 YuyiH0qdM/SXFn4JyGuNJDc5kZxyAfNFe94FDXquLesJYm2h/DuVL0JEWSSRhwvI4s1Yc1
 YgrFl7G/QfJ0DHcydoNHPHz/uVnAMao=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-fwiANM_qNM68dGsq_RdSTQ-1; Tue, 03 Oct 2023 04:30:48 -0400
X-MC-Unique: fwiANM_qNM68dGsq_RdSTQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9b2e030e4caso400426966b.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321846; x=1696926646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oM/kNXmOf7pF5c5aEMrfjCntn3rClcCDEzkX2duHLEA=;
 b=RDZIdHGoY4xa++JUjMRK8Xk9wNVwjppUaMZ/XerHPNskRimrA3YkptrKYkUQUhRyKL
 Wli44putUYhNVoYvn6HzjZxWY7KwSIfWwzucdRrXjnWawl4bmpHdKQXzm874OKiCacnZ
 3WS+8czfhBjfJrl6T3z3B3VyLT+aEzzwcxtb/D3PtVvZD0ZqkO4d/ri2B7cM93+e4mWJ
 UELR/wEw+mEUNTG0UWjXY6XZJOxKOXwpbNWUK9J4UGKa2e7nD9Gi7ZFZOP2/9KQFolS1
 zt1ldPfPtYc+pLi2x8Czm6N9IehrYlLXXSAhHBwCkZnpZDhQIZxSB3KlBjk2AP3PW6Pc
 dPOw==
X-Gm-Message-State: AOJu0YyfQdFRiljwnavcS3nCPOEnuSIDSDFeJVoYYRdvIgiasbS5oHcb
 omQIBGx8+qx2CX3Lq8LhJTOku7ksz+r34sKbZU52GJF2Oq80j2jZgDT6U+wMbqOIXdpU+bbvUvy
 GnlP5TaecfA5Ozb0rEawhmVpvlj3QlCsc0VgTEKz5t/3HO3GAy4GMP978SIYlLquyCD5DK0chQ4
 8=
X-Received: by 2002:a05:6402:51d2:b0:533:5d3d:7efe with SMTP id
 r18-20020a05640251d200b005335d3d7efemr1813909edd.6.1696321846468; 
 Tue, 03 Oct 2023 01:30:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3HBkf/spAPCWg2buADvp8XJgSosJn5mNjPkpxijnTnpr+wawUqquGx+CMLe/IM6grUfrflw==
X-Received: by 2002:a05:6402:51d2:b0:533:5d3d:7efe with SMTP id
 r18-20020a05640251d200b005335d3d7efemr1813891edd.6.1696321846102; 
 Tue, 03 Oct 2023 01:30:46 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 v18-20020aa7dbd2000000b00535204ffdb4sm486394edt.72.2023.10.03.01.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 01:30:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Vasiliy Ulyanov <vulyanov@suse.de>,
 Thomas Huth <thuth@redhat.com>, stable@vger.kernel.org
Subject: [PULL 01/24] optionrom: Remove build-id section
Date: Tue,  3 Oct 2023 10:30:18 +0200
Message-ID: <20231003083042.110065-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003083042.110065-1-pbonzini@redhat.com>
References: <20231003083042.110065-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20230926192502.15986-1-farosas@suse.de>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 pc-bios/optionrom/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
index b1fff0ba6c8..30d07026c79 100644
--- a/pc-bios/optionrom/Makefile
+++ b/pc-bios/optionrom/Makefile
@@ -36,7 +36,7 @@ config-cc.mak: Makefile
 	    $(call cc-option,-Wno-array-bounds)) 3> config-cc.mak
 -include config-cc.mak
 
-override LDFLAGS = -nostdlib -Wl,-T,$(SRC_DIR)/flat.lds
+override LDFLAGS = -nostdlib -Wl,--build-id=none,-T,$(SRC_DIR)/flat.lds
 
 pvh.img: pvh.o pvh_main.o
 
-- 
2.41.0


