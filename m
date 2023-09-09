Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E27799A9C
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 21:40:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3nG-00063R-N0; Sat, 09 Sep 2023 15:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3nD-00062h-PB
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:55 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3nB-0003Gk-M7
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:55 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-403061cdf2bso4049325e9.2
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 12:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694288332; x=1694893132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OZEC1ZYlBLAP67Is80EF8jMl+TZRE+zpwkU48kNd//c=;
 b=NApqYBsMVF0FTv+uf+wl7zYbMRqySMWTkREF/xhkYNxoNCu2vwnXap0Ew8INHLWDKz
 Ry2whC5W3rP3cDwHzj+D3Hgwi7sw1xxEddFMtQaPbjT2Wx8UadOIDIbVvqCEix5/o64Q
 BduvtZrEqi72Si5z2IZISn00b17h2yuaScI4yH8EqD7zo7ZA1wz89H+isD6HIYwz3PQu
 dd/q+0attkEKaG6pnCqD/IfCvr27KJZw6cgjT0W5xIKW1rQkAEG2bpsZljjypN1wys4q
 GuejvKin8yjsIaj3Y2OYnhUINpGq9NIcIG+zmTcvL8wxxk2ycxPt2Mi57sBpnaZZOvZH
 7c6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694288332; x=1694893132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OZEC1ZYlBLAP67Is80EF8jMl+TZRE+zpwkU48kNd//c=;
 b=NDBYDbuKnCXH11rC94LD3ZAwHq5wjrRGi81vtX8Fxervtq2/vzEolUo4Vxne5w7xjj
 KLtjOUdL/G+ubgx6t4XiYk48KjzsOTrBGgsjsVyWh8itymHstcV25hb9aGfXbjcVUTlV
 H1z27feW9z+cqvKXGzB/KKLt+PbX8Sngqjs0tgk9DvkYclCXi0CJlK5nKoLPMYisVPRt
 +bQL+Su0/SnAIB9A3XRq6ML1X7m+iybv2eF3mTCM+LYahNqlzh6VHFZXuxzXS1vzL/50
 0W0qVPIqvGF+4P3H7h6HkW7emwrCpkSKPvgVFjQRk8Qte1LI2jNy7SEIxSg9tD5vSEFr
 cwIw==
X-Gm-Message-State: AOJu0Yy0G5r7icYfpEgzPDHgaiTuXY+yS8TP3wvkIXT2t4reOxtwl5i0
 XN7RCD/G9A3qT8dLO1NmhUreVQT8CR4=
X-Google-Smtp-Source: AGHT+IE7RTfunizxfLWKiax/VuH2O8W9q+p78lk01wPakKVIb7rQhbeBNviW+2iN8/0vfzR/rpH0ow==
X-Received: by 2002:a05:600c:364c:b0:401:b705:ebea with SMTP id
 y12-20020a05600c364c00b00401b705ebeamr5379163wmq.12.1694288332117; 
 Sat, 09 Sep 2023 12:38:52 -0700 (PDT)
Received: from karim.my.domain ([197.39.250.27])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fe4ca8decdsm8612812wma.31.2023.09.09.12.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 12:38:51 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 23/23] bsd-user: Add stubs for vadvise(), sbrk() and sstk()
Date: Sat,  9 Sep 2023 22:37:04 +0300
Message-ID: <20230909193704.1827-24-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Warner Losh <imp@bsdimp.com>

The above system calls are not supported by qemu.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 18 ++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 12 ++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 8e5f22da5b..847773fc8e 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -419,4 +419,22 @@ static inline abi_long do_bsd_shmdt(abi_ulong shmaddr)
     return get_errno(shmdt(g2h_untagged(shmaddr)));
 }
 
+static inline abi_long do_bsd_vadvise(void)
+{
+    /* See sys_ovadvise() in vm_unix.c */
+    return -TARGET_EINVAL;
+}
+
+static inline abi_long do_bsd_sbrk(void)
+{
+    /* see sys_sbrk() in vm_mmap.c */
+    return -TARGET_EOPNOTSUPP;
+}
+
+static inline abi_long do_bsd_sstk(void)
+{
+    /* see sys_sstk() in vm_mmap.c */
+    return -TARGET_EOPNOTSUPP;
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index fe0968773e..9647249e90 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -567,6 +567,18 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_shmdt(arg1);
         break;
 
+    case TARGET_FREEBSD_NR_freebsd11_vadvise:
+        ret = do_bsd_vadvise();
+        break;
+
+    case TARGET_FREEBSD_NR_sbrk:
+        ret = do_bsd_sbrk();
+        break;
+
+    case TARGET_FREEBSD_NR_sstk:
+        ret = do_bsd_sstk();
+        break;
+
         /*
          * Misc
          */
-- 
2.42.0


