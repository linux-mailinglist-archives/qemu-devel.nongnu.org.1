Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 602A18263F5
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 12:55:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMRkY-0001c3-0D; Sun, 07 Jan 2024 06:55:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rMRkW-0001bm-HY
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 06:55:28 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rMRkR-0004oe-Nc
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 06:55:28 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d3e6c86868so8163365ad.1
 for <qemu-devel@nongnu.org>; Sun, 07 Jan 2024 03:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1704628402; x=1705233202;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4uRq7C9ZUE1eAcpVbzP7nNiWmwJQwxB+eLzHwmIPY48=;
 b=yUYulyVlhFjl9IQ2ooRgwS1VMBe7Jhxv/AAFSQjZ30c2Oid//3qKJLClmY115uDpvX
 HxAiaSWo2Ufsr1ylhoKJO4/R5/lN3RJk0lHHQMfd3D8SwUZF+ASDPGh6zxhRrXZfnDV+
 xCAIdwVDBKmhpBUj0QvWIdobXaKnHsVVLmkZC9wCJpkWtlyQmPN4WHiTbY8RIrnW55Ze
 5jPft+IsDIFGIWAW2+NIspmMjxirw9cAe5zdSWuxnSjzCVeVVDv7kiN23IL0QObeK/Dj
 bZuIlBSrLJjZ7mzrOvEuDgcjJP5zVNK92vwd1GMH4DCzLuAj07AiDRv3924HSWj2TSXf
 I49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704628402; x=1705233202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4uRq7C9ZUE1eAcpVbzP7nNiWmwJQwxB+eLzHwmIPY48=;
 b=VU7NP7lcWW86ZNRNenVaKBrr8Faw596CaunoeBivWn5J9/6/teesL6atHwxyLHHngW
 Js8BFpwqr67MVh0KDpsfx0MYLfFVoslaLwTPPkMH0ry0U8FkPhtrQsarIGpnE/3GhQzC
 lKEb9RBZCJoCDNDdHD6NpcQ5/DPfiPzm5NA5RVhMQNFh6ZeYKtt/kDvF6Ie+Ozgk2mBY
 pI108IiduSev59PXBHS4fbyJdv2BgiAcqvOcUNV36HqCKEZgSYiXfv0HD/DrrdvSPvSF
 lLMaE3jM+Inb5ZrfNcStv+4W9BZFmEG4+mD7EZPJvYmi16PiEeK2akq09YYJ9jjxGj2T
 kSYw==
X-Gm-Message-State: AOJu0YyNhH/NLRaHikxxBy+ePRpHuxfcpU1x4bjq8gxrLP0K4FyhIGit
 O9vrv08MZ+2o1ZXCsTtDAmaOXg+/uY9KkPMamZmEeY5v1PY7xQ==
X-Google-Smtp-Source: AGHT+IHdIfgeYZEiF3tTWfQsB1ak1gzEwGCgnN1O1v57XzzETiid0mUahyz1as9XLGZV4OIdOngZUQ==
X-Received: by 2002:a17:902:b489:b0:1d4:9c06:1807 with SMTP id
 y9-20020a170902b48900b001d49c061807mr2254254plr.47.1704628401535; 
 Sun, 07 Jan 2024 03:53:21 -0800 (PST)
Received: from localhost.localdomain ([171.216.79.156])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a1709027c0500b001d4ea1b6a2csm4082694pll.32.2024.01.07.03.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 03:53:21 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v2 1/2] i386/sev: Sort the error message
Date: Sun,  7 Jan 2024 19:53:10 +0800
Message-Id: <c34aaa8055cd09b17f7abebfb2d1397331f7d5c0.1704626686.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1704626686.git.yong.huang@smartx.com>
References: <cover.1704626686.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Prior to giving the caller the return number(in the next commit),
sorting the error message:
1. report the error number on the ram_block_discard_disable
   failure path
2. report the error number on the syscall "open" failure path
3. report EINVAL when a prerequisite check fails or the command
   line is invalid

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 target/i386/sev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 9a71246682..96eff73001 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -923,7 +923,7 @@ int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     ret = ram_block_discard_disable(true);
     if (ret) {
         error_report("%s: cannot disable RAM discard", __func__);
-        return -1;
+        return ret;
     }
 
     sev_guest = sev;
@@ -940,6 +940,7 @@ int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     if (host_cbitpos != sev->cbitpos) {
         error_setg(errp, "%s: cbitpos check failed, host '%d' requested '%d'",
                    __func__, host_cbitpos, sev->cbitpos);
+        ret = -EINVAL;
         goto err;
     }
 
@@ -952,11 +953,12 @@ int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         error_setg(errp, "%s: reduced_phys_bits check failed,"
                    " it should be in the range of 1 to 63, requested '%d'",
                    __func__, sev->reduced_phys_bits);
+        ret = -EINVAL;
         goto err;
     }
 
     devname = object_property_get_str(OBJECT(sev), "sev-device", NULL);
-    sev->sev_fd = open(devname, O_RDWR);
+    ret = sev->sev_fd = open(devname, O_RDWR);
     if (sev->sev_fd < 0) {
         error_setg(errp, "%s: Failed to open %s '%s'", __func__,
                    devname, strerror(errno));
@@ -981,6 +983,7 @@ int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         if (!kvm_kernel_irqchip_allowed()) {
             error_report("%s: SEV-ES guests require in-kernel irqchip support",
                          __func__);
+            ret = -EINVAL;
             goto err;
         }
 
@@ -988,6 +991,7 @@ int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
             error_report("%s: guest policy requires SEV-ES, but "
                          "host SEV-ES support unavailable",
                          __func__);
+            ret = -EINVAL;
             goto err;
         }
         cmd = KVM_SEV_ES_INIT;
-- 
2.39.1


