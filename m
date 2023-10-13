Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B487C7F18
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 09:58:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCyR-0003Tv-VP; Fri, 13 Oct 2023 03:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxg-0008Uo-SR
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:56 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxR-0005B3-0z
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:55 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32d834ec222so1726420f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183498; x=1697788298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IVkjMSxl3+eH0Gmp46frWDOQAJV2R3z1peLcSt42xWk=;
 b=xpd2khwl+Fu+4IsRWVD4NxgtryZYrH0JOF5pRXCsduFgy2g1gaYA5JoPZ7aNXw/J+W
 kTT4caeqJN/4s+JfoOOibPakQnjyyM9Ktgk8OCK3PcDGLS67bdfD5Tv/VnKcrEI6PspX
 aagkqcqIQCM6NC2qh46/YO0mkp5fLOTcVANg1SaRBqvbrt0If09pfy5K8qwH6ny3lH9Y
 uXdgzRJbvwoyo4KDN9uVCrQUpo6EGbq8ITNe0OT0XvJX0tStrH/La8cNO6Sf4mP7NS/T
 SpAIILlwO2JyeNSFBNxzu/WPZ5IDW5GaMtm9ttFN7pO30vvwh/H3AN4bRgMr6PvVrvpY
 X6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183498; x=1697788298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IVkjMSxl3+eH0Gmp46frWDOQAJV2R3z1peLcSt42xWk=;
 b=AYTmyZmkMfJjrBagUvmLVoG1zb6YeVPhLIo4FL6iV59SfWLQnkfSAfdyBaeKIWVmGx
 Tk0xmUVyWamT4TDLAu67b2Hgmw3Nhzo3bAbp9amupxV0B2rgUP3SCttvnzy8DKBodUnc
 J1S8GbgplFRaONt2d6oUdV45Sb34xlwIHUO6aTi2+rLWmfw7c4wNSe2Q77Si8YRyYLII
 ULrT5QKvRDNx/oRCYt8CZo4kWLuN4RePHcmxfDg2e0y3Cu02NUdDG8v73lkwy/SFlQhE
 aYbIOgiqoC0YdVRWeHI/JXqXqCYpq54Fijc3guJhUxQXwwB3XJlxHZoO5qDXzoOkAPs1
 nXUQ==
X-Gm-Message-State: AOJu0YxH1a7hdqH1WzN/izFFvdwfV4VoS3vz1bBA8OGiZeXdtWUUAfXE
 T9PamCDcQnyZxPzsxprwSVlwEA1E4zk0I+FfxeI=
X-Google-Smtp-Source: AGHT+IE+qo4uk22vmXxAlH7ch0LQ5AbwFHMNdg424x7xhLcmXXMFwynga+WiFS9Yhrbf/uilitvpqw==
X-Received: by 2002:adf:f94c:0:b0:32d:a0a9:4785 with SMTP id
 q12-20020adff94c000000b0032da0a94785mr20256wrr.7.1697183498496; 
 Fri, 13 Oct 2023 00:51:38 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:51:37 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [RFC PATCH 47/75] contrib/vhost-user-scsi: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 10:48:02 +0300
Message-Id: <b9b8043e46c25e0c209c2f96e9b8b44f40133fc1.1697034504.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697034504.git.manos.pitsidianakis@linaro.org>
References: <cover.1697034504.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
index 9ef61cf5a7..71076f579b 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -109,14 +109,15 @@ static struct scsi_task *scsi_task_new(int cdb_len, uint8_t *cdb, int dir,
 static int get_cdb_len(uint8_t *cdb)
 {
     assert(cdb);
 
     switch (cdb[0] >> 5) {
     case 0: return 6;
-    case 1: /* fall through */
+    case 1:
+            fallthrough;
     case 2: return 10;
     case 4: return 16;
     case 5: return 12;
     }
     g_warning("Unable to determine cdb len (0x%02hhX)", (uint8_t)(cdb[0] >> 5));
     return -1;
 }
-- 
2.39.2


