Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2624D773AF5
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 17:21:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTOVr-000433-AJ; Tue, 08 Aug 2023 11:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qTOVn-00042t-7e
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:20:43 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qTOVl-0002BH-16
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:20:42 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-686f0d66652so5491351b3a.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 08:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691508039; x=1692112839;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j/u4F/+WWeGVZpiBVPat9wzt7nZVukQ+NYp/SgqRs0Y=;
 b=gd8Vo8tvWY2ElEuqcDAEbpLav5hxjAm1PeNAodfwANw4njJKw1bcgwVttBRSETfYPi
 f5zXFJYnOmZuZ0I30S13oPN9GUZa7EzdT60ZWizXZF0qEhqANLlaipZblKvlLIBXMALl
 MgPBnyKYiiT9UxgUAP580agiLBHaW8Kp8YQqDD4/prA8TyXExRP2YtxWjbcGZEFYE18y
 VrxyKoTGRVLyYgbtLInsOoVmU/pYs8uGwj7EFqa+4KjgbSQk+MjnnBoA3WkJYZq2GeOW
 v1bpqCDEc1wR4hPUDFMNTpg2SBBX1FtAo0QiIGg6SCGzRqyUzY8U8hUgNdsDZTWlo6ug
 RTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691508039; x=1692112839;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j/u4F/+WWeGVZpiBVPat9wzt7nZVukQ+NYp/SgqRs0Y=;
 b=SUZS2SJ99SYstAfMfhtTEOMDwB1FGUCrS9LeplykEr6XPHKmAeS7tgGhVW9ggJzhO2
 eANfcFXzXQ2YNrModCUoVRTagl7IC8TMOHD5MX+vAOsgBK9fsiQ9zhjsT8ywkqOrOqgZ
 TSQMkpqjCVfIc2LlZRlfWoFx2X65/GwahI3YHKJp9ZhDnuE+m8V7gJNwu/cGlRyIjiX7
 1WXtBLSN773kX4YghqpPziipqihyCYusAUKCCztY4f4F2Z4AgZz3Ya4vgYrDpgR/kM+4
 xtSDUo5u0Aoy/CMgi9r/mQjyaQ+CpRUnQndyKD3KbCNSMZuCt8z2aod4RbzupzaE9djQ
 Blxw==
X-Gm-Message-State: AOJu0YxQIA+PVxMntDpYOLDv1/lE2nR/v/mojJBD9JWirHgEQI2c9Yr7
 GZD3oamxNfVo8I10DZGjxB4ux2/N+rh+sCHSk0U=
X-Google-Smtp-Source: AGHT+IFoI81J6c+/+uOSmKwfiEULiosbGv63lTUMlHqWhat9YFl+RULIjfZ72hABPGnYLm7btyT1bg==
X-Received: by 2002:a05:6a21:3e09:b0:13e:1945:8873 with SMTP id
 bk9-20020a056a213e0900b0013e19458873mr16315750pzc.37.1691508039570; 
 Tue, 08 Aug 2023 08:20:39 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a62ed06000000b006870ccfbb54sm8228616pfh.196.2023.08.08.08.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 08:20:39 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH] util: Delete a check for IA-64
Date: Wed,  9 Aug 2023 00:20:25 +0900
Message-ID: <20230808152026.100096-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

HOST_IA64 will never be defined since IA-64 host is no longer supported.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 util/oslib-posix.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 760390b31e..f7adb36dfb 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -618,10 +618,7 @@ void *qemu_alloc_stack(size_t *sz)
         abort();
     }
 
-#if defined(HOST_IA64)
-    /* separate register stack */
-    guardpage = ptr + (((*sz - pagesz) / 2) & ~pagesz);
-#elif defined(HOST_HPPA)
+#if defined(HOST_HPPA)
     /* stack grows up */
     guardpage = ptr + *sz - pagesz;
 #else
-- 
2.41.0


