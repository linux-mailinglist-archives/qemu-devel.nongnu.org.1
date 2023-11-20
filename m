Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F957F1F3B
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:34:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Btg-0000vv-5L; Mon, 20 Nov 2023 16:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Bte-0000ve-Da
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:33:34 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Btb-000396-Tb
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:33:34 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40b27b498c3so1308845e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516010; x=1701120810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3R2bk2+TIy0U91qpyefgUOXYaNCg17GUPUMA/PpOZ0=;
 b=Wjdo8LXTJVtWVNM7cf4DD3DmNfX1hWErdwZCCu9PccWQm3yMMHmUFkW+buausZipmQ
 Cks/JK2/bl1sAvsbfBdpn0RBD51tgagCvxHP4NbcAGiqXB1FZmz5iTuUI7vS+jVhRbFm
 jMUvhOK+/kzz1sS+POgnZWRZD4S5IP09pC1sFgzpI7u37K6IkIaDbbma1aF2RzXjjqH4
 tUwGp72RGhA5apPitaoq4dRWJV/BsJiPKxTIf5pl8HUsobeFrU1w5ZmlxqsZr7g9EKLt
 l4UcFHIBTqO23kxZ2tNQmTcXrlYPV9BgSn1D3GT8BD2lDDOMmsuhe+tOQgv3/Sb++5pf
 C/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516010; x=1701120810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a3R2bk2+TIy0U91qpyefgUOXYaNCg17GUPUMA/PpOZ0=;
 b=UCEs/dGkA9NYid079cXY0cG3dzJkUJsXBsnPhLYYt8ZFEOe3lyNyBH7dFcZB+tvq/h
 WaGrjgt6ZhyYw3s0NGU3EPS1FTVD/rIdMmG0Ga1X2xOZlyB83o51/65JrqZPrujgP6e7
 wfe/qaavHILyzRAhp2HJdfNnY6Bgyq6rNw0NZz5Vf587DvFGBmR5fh5jeKzah9yVljlA
 +tGd45e3SkFGmpepmpiAzq0plo5wbHe36nzpbyFj+W2QgmRiZIuTxY9CVBboK0tM9kdz
 vE9uvGSrI5u3L/hrEFMLxu4KwiowJAZdOrRVIbp115x5A+uT7b4nsKagAn2w7cltWPP6
 iqTw==
X-Gm-Message-State: AOJu0YyQTpSyL7QRjWUGa/pGUMBEYu2sVEl4WW/2+uB3ObGwyAmlkChf
 di3xgytRwQYDg553QpLaFwE0aoMa9CnemToYkuk=
X-Google-Smtp-Source: AGHT+IF4Fu/EHZIo8KqkEPLn1ulASCMhy1UyZQ70zwysYhCk8FlaAqB80HRdcHL78ePjqfq/OB+LbA==
X-Received: by 2002:a05:600c:1ca4:b0:405:359a:c965 with SMTP id
 k36-20020a05600c1ca400b00405359ac965mr6739626wms.4.1700516009941; 
 Mon, 20 Nov 2023 13:33:29 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c3b9200b00407efbc4361sm19623645wms.9.2023.11.20.13.33.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:33:29 -0800 (PST)
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
Subject: [PATCH-for-9.0 02/25] memory: Have memory_region_init_ram_nomigrate()
 handler return a boolean
Date: Mon, 20 Nov 2023 22:32:36 +0100
Message-ID: <20231120213301.24349-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
 system/memory.c       | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index f038a7e5cf..4140eb0c95 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1288,8 +1288,10 @@ void memory_region_init_io(MemoryRegion *mr,
  *
  * Note that this function does not do anything to cause the data in the
  * RAM memory region to be migrated; that is the responsibility of the caller.
+ *
+ * Return: true on success, else false setting @errp with error.
  */
-void memory_region_init_ram_nomigrate(MemoryRegion *mr,
+bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
                                       Object *owner,
                                       const char *name,
                                       uint64_t size,
diff --git a/system/memory.c b/system/memory.c
index 313dbb2544..337b12a674 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1574,13 +1574,14 @@ void memory_region_init_io(MemoryRegion *mr,
     mr->terminates = true;
 }
 
-void memory_region_init_ram_nomigrate(MemoryRegion *mr,
+bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
                                       Object *owner,
                                       const char *name,
                                       uint64_t size,
                                       Error **errp)
 {
-    memory_region_init_ram_flags_nomigrate(mr, owner, name, size, 0, errp);
+    return memory_region_init_ram_flags_nomigrate(mr, owner, name,
+                                                  size, 0, errp);
 }
 
 bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
-- 
2.41.0


