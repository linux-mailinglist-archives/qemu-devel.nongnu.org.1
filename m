Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6B17F1F44
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:36:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Bvj-0004mJ-UL; Mon, 20 Nov 2023 16:35:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5BvR-000387-6u
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:35:26 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5BvH-0003rz-T8
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:35:23 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-409299277bbso17767055e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516114; x=1701120914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fJ1tGChnS+y/+vqRU30qRdlKveuA7pm7ifWNUTeCbQ8=;
 b=LbtoaCYOXYyLmbo/ul88SjSjs3XWMMEu3I2lWuwfdJBQphPhEAAHhlSJgRJKeujnzr
 4FXCGNKKmCE90yLmYWun6eOdTLmSG3D75998b1uNou53O14Ywmz1s6rfESHodNcS3lZU
 8UEt8+MexczjZfXo8wf16Af4WuaMeQGUVQHwMOntqfNXR8YszlpPsjd7ncslIcpHj10e
 mjfdlVO76QuVpGAPLy1nIUaS/JXmCRVFofF0h+DQWB94Geu7Z9UrDXjvs8t628FB1vgM
 mlD9oDTNRkoBXhv/ZuAWXhoDPv9hHkKOF6XM4Rwk77ZRGKKZSBLzAMsUSQHAH3SwKxKL
 6J0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516114; x=1701120914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fJ1tGChnS+y/+vqRU30qRdlKveuA7pm7ifWNUTeCbQ8=;
 b=A3MqigkomR+ae37wxzBGoxJA13sHXInKEY7W7Ym5IgWM42fQjJXYuLcEHiXM2IpjUp
 kuipOtqX6O71HpMDvWec7oNEN2oIoKd43k5oKCkr3T6XszkCFxhIFVoEMTjl6NrNNGsd
 +fXu34vmGaROhMfK40yxt9+q5SHUby+M1TNuA8l1lsRdKIEVleiwkmNan1ADWaNRFqf7
 NBIAPLvFwYZW1oGLSHqqfYUakk24JBk8+TUUdnprK63MuBfPj0aN+S6rQLoI8ze048ka
 LE2GQBezJPWk+AE22wnrACEVNlBGoJ0NEV4i+eEGGwZR35oZs3R+bUajJE1kK0FdsBWZ
 45eg==
X-Gm-Message-State: AOJu0Yy6wRrR7xwghtJRTrrhzKYJ4jGDOUZ87+Zuko5wS14vs6+OBz6U
 nNeoKq4rlMdUsSQP3SrdRdZhgFH6WQ2+RRotJOc=
X-Google-Smtp-Source: AGHT+IHiyGUFpX5jt4b5PB+6jtg/LgCz8QOHMl5gjegIOzgQkr8+STUiUx9FhC9lOhjhooArH7Zzag==
X-Received: by 2002:a5d:464a:0:b0:32d:9a1b:5d79 with SMTP id
 j10-20020a5d464a000000b0032d9a1b5d79mr5092751wrs.33.1700516113920; 
 Mon, 20 Nov 2023 13:35:13 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 i11-20020a5d55cb000000b003143867d2ebsm12261018wrw.63.2023.11.20.13.35.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:35:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH-for-9.0 12/25] memory: Have memory_region_init_ram_from_file()
 handler return a boolean
Date: Mon, 20 Nov 2023 22:32:46 +0100
Message-ID: <20231120213301.24349-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Following the example documented since commit e3fe3988d7 ("error:
Document Error API usage rules"), have cpu_exec_realizefn()
return a boolean indicating whether an error is set or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/memory.h | 4 +++-
 system/memory.c       | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 218b35a849..2034a48544 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1376,8 +1376,10 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
  *
  * Note that this function does not do anything to cause the data in the
  * RAM memory region to be migrated; that is the responsibility of the caller.
+ *
+ * Return: true on success, else false setting @errp with error.
  */
-void memory_region_init_ram_from_file(MemoryRegion *mr,
+bool memory_region_init_ram_from_file(MemoryRegion *mr,
                                       Object *owner,
                                       const char *name,
                                       uint64_t size,
diff --git a/system/memory.c b/system/memory.c
index f424282526..4a36779ba1 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1633,7 +1633,7 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
 }
 
 #ifdef CONFIG_POSIX
-void memory_region_init_ram_from_file(MemoryRegion *mr,
+bool memory_region_init_ram_from_file(MemoryRegion *mr,
                                       Object *owner,
                                       const char *name,
                                       uint64_t size,
@@ -1656,7 +1656,9 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
         mr->size = int128_zero();
         object_unparent(OBJECT(mr));
         error_propagate(errp, err);
+        return false;
     }
+    return true;
 }
 
 void memory_region_init_ram_from_fd(MemoryRegion *mr,
-- 
2.41.0


