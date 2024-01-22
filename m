Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A21E835E63
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 10:43:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRqpE-0005Cy-Gy; Mon, 22 Jan 2024 04:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rRqpC-0005Cj-Kv
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 04:42:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rRqpA-00028g-VE
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 04:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705916555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XVtpCFlPt48Q+vv3Mui+abb5mwZeZl3tFSitFxa9WdM=;
 b=QU13wS8d/aR3X30OBMEtJUguXErd7lleP78FNKtkQIrGBsKN7Wx/UklW+f7ll35wXS8541
 Haj1gKJjgG5hsSyUl3uQmYV4bh6J1rKXIhTVrAY4or9zvUxh9pRkPLS9C1Ros8X5azFkr+
 WV0iO7N2DUVmJCDSef7K5VUn5mO0YlY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-65wSNBISPeaCQpqUsi_3ew-1; Mon, 22 Jan 2024 04:42:33 -0500
X-MC-Unique: 65wSNBISPeaCQpqUsi_3ew-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40e439092a0so9666685e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 01:42:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705916552; x=1706521352;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XVtpCFlPt48Q+vv3Mui+abb5mwZeZl3tFSitFxa9WdM=;
 b=vYtjBxhk+ERPI16/xQ+UaabmfR61ozZVqahrEjmA4ODFidra6OLM2w6SBwGNDTsXwx
 RFFBSauBM94VBaZTCXZVCnrQ2CeVXToL4Vc001dJvrbkTfOt1SWEKFsKPOEerJxmTOJU
 fPbticidCS697LCBF5ho36wUVCXZW914KqaEGqT1fZ9EnRCAlXkXgdua3JJhbiVAuxj+
 41eT9TOkRY8vFh4tXlP9r6aF3tOc5k9G/1HxJN+6O69CLGjFOmfi/E7F5NzAXKnutEXr
 zA+qgcp10D8aO99wHiA2r2Ts1c6dKIBrO+7ZhnS/ugLwBw8f97lGbEoLmWqPnNMnqJuf
 aLcA==
X-Gm-Message-State: AOJu0YzQvoa6J7Ue3axCmM/atUtZZ2G+C4dP20M1+AZidk4gpmb6Sq5+
 rqw8Nl//xK1hL2W2UerqphbL1snK9gaozXCaTbmS+JpBPd+YlyR8IxIBlqHR3X9M/D+UWsLw0ue
 u2v3Xxd1cu+5eZN+SOwOpphidmaBSfxInteV8vdCHgWFo1kbbR/7HRDPdsPPNbc2bXmnwItZxo3
 Lb8YTLPYdvuOQw0rvVltDJLY9vJX80wtJWSCRc
X-Received: by 2002:a05:600c:4f4f:b0:40e:a259:72af with SMTP id
 m15-20020a05600c4f4f00b0040ea25972afmr2100333wmq.28.1705916551965; 
 Mon, 22 Jan 2024 01:42:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbZvwCI8gok2HVk8kQWj+XZT/8EoYmQV8846ytQXxuEK2j6F0xb5rY8TYz8UWD5eHaoHa/mw==
X-Received: by 2002:a05:600c:4f4f:b0:40e:a259:72af with SMTP id
 m15-20020a05600c4f4f00b0040ea25972afmr2100326wmq.28.1705916551544; 
 Mon, 22 Jan 2024 01:42:31 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 ay2-20020a05600c1e0200b0040ead97f70dsm2930169wmb.24.2024.01.22.01.42.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 01:42:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/xtensa: require libfdt
Date: Mon, 22 Jan 2024 10:42:30 +0100
Message-ID: <20240122094230.283653-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Always allow -dtb in qemu-system-xtensa.  Basically all other targets require
it if it can be used (including for example i386/x86_64).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/targets/xtensa-softmmu.mak   | 1 +
 configs/targets/xtensaeb-softmmu.mak | 1 +
 hw/xtensa/xtfpga.c                   | 9 ---------
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/configs/targets/xtensa-softmmu.mak b/configs/targets/xtensa-softmmu.mak
index f075557bfa9..c394df73034 100644
--- a/configs/targets/xtensa-softmmu.mak
+++ b/configs/targets/xtensa-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=xtensa
 TARGET_SUPPORTS_MTTCG=y
+TARGET_NEED_FDT=y
diff --git a/configs/targets/xtensaeb-softmmu.mak b/configs/targets/xtensaeb-softmmu.mak
index b02e11b8200..517b4c3e12d 100644
--- a/configs/targets/xtensaeb-softmmu.mak
+++ b/configs/targets/xtensaeb-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=xtensa
 TARGET_BIG_ENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
+TARGET_NEED_FDT=y
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index fbad1c83a3f..3c93cfffbaa 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -357,7 +357,6 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
             cur_tagptr = put_tag(cur_tagptr, BP_TAG_COMMAND_LINE,
                                  strlen(kernel_cmdline) + 1, kernel_cmdline);
         }
-#ifdef CONFIG_FDT
         if (dtb_filename) {
             int fdt_size;
             void *fdt = load_device_tree(dtb_filename, &fdt_size);
@@ -374,14 +373,6 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
             cur_lowmem = QEMU_ALIGN_UP(cur_lowmem + fdt_size, 4 * KiB);
             g_free(fdt);
         }
-#else
-        if (dtb_filename) {
-            error_report("could not load DTB '%s': "
-                         "FDT support is not configured in QEMU",
-                         dtb_filename);
-            exit(EXIT_FAILURE);
-        }
-#endif
         if (initrd_filename) {
             BpMemInfo initrd_location = { 0 };
             int initrd_size = load_ramdisk(initrd_filename, cur_lowmem,
-- 
2.43.0


