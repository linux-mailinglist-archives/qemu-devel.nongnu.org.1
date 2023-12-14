Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DAB81336C
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 15:44:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDmvR-0002ul-AH; Thu, 14 Dec 2023 09:42:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rDmvN-0002u0-ID
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 09:42:53 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rDmvL-00009l-Sa
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 09:42:53 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3364a5ccbb1so464234f8f.1
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 06:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702564969; x=1703169769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1SWxyyNzlsjwPy0q/4QbwRxuffpVyZhHt3UlcyYmbr8=;
 b=a4CQJGMCUQZO0XoGp0Xtm7OekR5ZVr6yBwyIWX9TBVJj54vc0ZwOggwFPQoEAnnVgg
 SjbXZgHW18J5/rA3YkNtBcNYKTV4aNKbyO+nQxZat1KitqA1HXu3raczm6hBt8Yry1jv
 8b0oZNaQDdQiiojpuITkZ5NvlMEECmutRLj9anJ+Sp2dBM4EmV2q38JX6+VKXu09dSki
 peOJl1xksaEK5BP55wCnTlK51t8NdzPq1C3INJMiz/mnxwODJhe4JZIw4y5CdcuEZA2O
 FRsu/sUaPSbUKiCua7/LCXlaElQihoqYkISYDrDtucIpcv1U4bxyRGSDPg+w+J/yNzrP
 hKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702564969; x=1703169769;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1SWxyyNzlsjwPy0q/4QbwRxuffpVyZhHt3UlcyYmbr8=;
 b=fi4w50utfdcd5XYhtcKbgnt+PJyOLoiayQAiF48m7JhlOxA0sA345wxWbqd/Kv6ccz
 y/BvzuB3yQVACGApXSmYRKwM7qxdUb9E279lflNxMBZdPC0K/ujYLq7jYPJkG3TGw8Mr
 fsL8ihCFDsbqrK7yEid4zebZ63SXfZ9y5q6IkmQOTRav+yWxpkX/ba/+sMwCW0Rgudv5
 2K0Aw8tbrGjUkDy7hjVin0YB0J1J4z6chyxX6xS/19/m1R5JMZ1Tbx66gCnw+ZKu7e/R
 gt6ClR26Kg5225TiOehrOD/EhUjXllSujIbEpikpxxSs5nkfo79jnlJRk9+xYI77F8Ev
 rGOA==
X-Gm-Message-State: AOJu0Yw0uuyzGmH0EawsxQzsUrH7epytHfvAlNCVlpE5xAjHR2plCtkb
 iURZ2Z0uWCL9tsksvqog0nsl0g==
X-Google-Smtp-Source: AGHT+IEtM4YWr1SY7BR4AadjmbL/DehKmBeFshSqCwIBI4qLY+SQ5PNZW7qIchr7zPwTRbVn9BMnuA==
X-Received: by 2002:a05:6000:1b86:b0:333:5247:be11 with SMTP id
 r6-20020a0560001b8600b003335247be11mr5103718wru.119.1702564969390; 
 Thu, 14 Dec 2023 06:42:49 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j4-20020adfea44000000b00336471bc7ffsm1917888wrn.109.2023.12.14.06.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 06:42:49 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A4FC25F7A7;
 Thu, 14 Dec 2023 14:42:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org (open list:Overall KVM CPUs)
Subject: [RFC PATCH] tests/avocado: avoid a copy to support read/write rootfs
Date: Thu, 14 Dec 2023 14:42:43 +0000
Message-Id: <20231214144243.36887-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

While the test causes the rootfs to be updated we don't actually need
to persist anything between runs. Avoid the copy by enabling
"snapshot=on" for the drive instead.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/avocado/kvm_xen_guest.py | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tests/avocado/kvm_xen_guest.py b/tests/avocado/kvm_xen_guest.py
index d73fa888ef..f30313e6cf 100644
--- a/tests/avocado/kvm_xen_guest.py
+++ b/tests/avocado/kvm_xen_guest.py
@@ -57,14 +57,10 @@ def common_vm_setup(self, readwrite=False):
                                           "367962983d0d32109998a70b45dcee4672d0b045")
         self.rootfs = self.get_asset("rootfs.ext4",
                                      "f1478401ea4b3fa2ea196396be44315bab2bb5e4")
-        if readwrite:
-            dest = os.path.join(self.workdir, os.path.basename(self.rootfs))
-            shutil.copy(self.rootfs, dest)
-            self.rootfs = dest
 
     def run_and_check(self, readwrite=False):
         if readwrite:
-            drive = f"file={self.rootfs},if=none,format=raw,id=drv0"
+            drive = f"file={self.rootfs},if=none,snapshot=on,format=raw,id=drv0"
         else:
             drive = f"file={self.rootfs},if=none,readonly=on,format=raw,id=drv0"
         self.vm.add_args('-kernel', self.kernel_path,
-- 
2.39.2


