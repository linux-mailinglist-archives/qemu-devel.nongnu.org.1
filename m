Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D26C07EB277
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:39:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2uYk-0002bM-8g; Tue, 14 Nov 2023 09:38:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uYg-0002aU-KP
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:38:30 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uYf-0007iM-3y
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:38:30 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9c773ac9b15so803904366b.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699972707; x=1700577507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7bjOOh298/gVm20zFogtcW7Ag9vjCtjGY9z1KnDRo3U=;
 b=cX1/q5wPI0mDPKtHoJZD9Qucuxvwf7jEbEbmK9eeh+o/x0Xbie7b4I707qwViObxSx
 e2jGmlbjAU/hRYuatqBYz5uehdGcHHVsXUfE96NmLU08rBcufkG2fw3uv26GS1aB+g6I
 LePBE7onYdPVYsDjGuzn9MkERgbw5jZBsQn2uTWAVre+haYdLxxNu3bYmtNtb/7U1nqm
 3Gr/gWwAJO+Z2d+XNL3HdfbwX1fh+olwvoOyuNARW9lfiX5WDuzzAvsV8kdPLE5CzkHc
 Vh/Yru6rQfIhINCrjkbTmffyQuCdS1/+uOYpHF2Vdnnmsn4atKh9CaM9JumroPAZ4mTP
 TVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699972707; x=1700577507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7bjOOh298/gVm20zFogtcW7Ag9vjCtjGY9z1KnDRo3U=;
 b=lDFQmcpKlFB2J5zWG+pGTGzm2PU2ubEoRhxkDj8PY15Ww7YNFMkOGx/8u6OXTRV1/w
 Mx2t2CyP14+t91+akyLkg1kaUKdRRLh9G0jwXqMODl2NyoccUxZPRFi8qKxW9vaLBdEV
 NXLwfKOxyXR+o9u9ZyR7M8e0EdW2SR9JL2gyjSBRb660avI8MjscNHxueLay2KXUQS1X
 q9UcOqtcAW+HiHk7iIq9yvJ9qqwkmxpc1J6Kq4GT6B1/tcPa5KJxoKguPIhGODsRfN3l
 6CXXzs4bWwwrnSVvrA8fomgUDzuemobhEhwJ7obQCQauC0f6uphx3hiaPXVMqXl+4Btn
 Qn7Q==
X-Gm-Message-State: AOJu0YwJX/m+XAEbK2QeI7XaFNXZWBxNwZ7+NKpx7mbeanjJwpKgvpBm
 5OZukM+pyIq3fdspHt2Ar8obLw==
X-Google-Smtp-Source: AGHT+IGmC/f0NBuJq3lX6zmQbmq53YN/p3zW7ekfEdUOO96zzY8Hw2NKquJgt5a7Y31IS7pqqhAiDQ==
X-Received: by 2002:a17:906:e084:b0:9c6:64be:a3c9 with SMTP id
 gh4-20020a170906e08400b009c664bea3c9mr7562718ejb.39.1699972707580; 
 Tue, 14 Nov 2023 06:38:27 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 v21-20020a1709064e9500b009df5d874ca7sm5636254eju.23.2023.11.14.06.38.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 06:38:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Woodhouse <dwmw@amazon.co.uk>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>, kvm@vger.kernel.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH-for-9.0 v2 01/19] tests/avocado: Add 'guest:xen' tag to tests
 running Xen guest
Date: Tue, 14 Nov 2023 15:37:57 +0100
Message-ID: <20231114143816.71079-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114143816.71079-1-philmd@linaro.org>
References: <20231114143816.71079-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

Add a tag to run all Xen-specific tests using:

  $ make check-avocado AVOCADO_TAGS='guest:xen'

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/avocado/boot_xen.py      | 3 +++
 tests/avocado/kvm_xen_guest.py | 1 +
 2 files changed, 4 insertions(+)

diff --git a/tests/avocado/boot_xen.py b/tests/avocado/boot_xen.py
index fc2faeedb5..f7f35d4740 100644
--- a/tests/avocado/boot_xen.py
+++ b/tests/avocado/boot_xen.py
@@ -61,6 +61,9 @@ def launch_xen(self, xen_path):
 
 
 class BootXen(BootXenBase):
+    """
+    :avocado: tags=guest:xen
+    """
 
     def test_arm64_xen_411_and_dom0(self):
         """
diff --git a/tests/avocado/kvm_xen_guest.py b/tests/avocado/kvm_xen_guest.py
index 5391283113..63607707d6 100644
--- a/tests/avocado/kvm_xen_guest.py
+++ b/tests/avocado/kvm_xen_guest.py
@@ -22,6 +22,7 @@ class KVMXenGuest(QemuSystemTest, LinuxSSHMixIn):
     :avocado: tags=arch:x86_64
     :avocado: tags=machine:q35
     :avocado: tags=accel:kvm
+    :avocado: tags=guest:xen
     :avocado: tags=kvm_xen_guest
     """
 
-- 
2.41.0


