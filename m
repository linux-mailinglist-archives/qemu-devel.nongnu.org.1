Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D85D5A5BB6B
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Mar 2025 09:59:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trvRU-00069y-9m; Tue, 11 Mar 2025 04:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvRR-00065p-Dt
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:58:25 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvRN-0001LS-6N
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:58:25 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so1341032f8f.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 01:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741683498; x=1742288298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kZ8adRosDdix3VcOBPGB20W/hMkmp68cBdi+zCji6U4=;
 b=dKgPqLCwwga/7Ov0+A6X6dXcDR17wEKK0DGDadXKQt+f9Awc7ZSauVjCJxA//ORWfn
 Y4LyFXb6DY3s/mRN7CZjHjFB5Pe5KcOpmSXQ2Sdpc+0sU8Qn3ylyu0mr1AlkAmGI256i
 0C0diAyen8D4bzCv83K2j5uMLVUmfOQ2izu4XCUYQfO1Jh7xedCYxKGR8I7O6rkF+1It
 /GlRAw1zLpnYv1RzrajoT7vGbIbaJJdZnDp2SngLtBjXvU9XdMUhgQM2oADM1O7SR49w
 MB4mHqtNMqXdCzUwinggN5plmpZJQRaY3DcRIsu1nQu1i+jg4aarx+jIwIDKb79ygpYZ
 eB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741683499; x=1742288299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kZ8adRosDdix3VcOBPGB20W/hMkmp68cBdi+zCji6U4=;
 b=OABFu4awHCagNgCtSIHa1lzV/LCq8h+4cOWr8GPsCSrYyErbrwIfYRgdkdZ3DTGEEc
 0ISM44NxLj4Tsk3x4Pn7FqotikyN9UYUdx3oHHAoxwDxvoPB5B0yY8d8GBytNySIJZ7a
 Bd3MnsWbXrZ1Jl0PmEfIQS3S6t+75QYIsoM0qEJx5ASmUd6S59xvInvR5UCykz4B0D4b
 IPlDvNbnA9M+FrkUxuwyFegSgkjHcD8WO9aiCcqTvpQICUsI1b/I6ggieTE5MSxqdoLn
 K+M5c+v4GhGWpLHAbTPS5vKVfN+SN0tCp1wtEHc+W6WUg80jnmsNdg8BPZlHb/v5tF5H
 QCLg==
X-Gm-Message-State: AOJu0YyhX6ObmuP1yZfWiZP91E/j9bQuzKfosHq8jnlbxTCCsCYMh/Ax
 eIldWxejg80diKyPApcMXcbMn57PZS7xHKlz7D5WOLw4oru/39+vADWYGo+PQbIYgb8VsjA4E+M
 gVhQ=
X-Gm-Gg: ASbGnctUQpwByGhW6Bg7pDRh4BSbxWdLSNMLKWkavgVLsSd0jyBN3QHkr/QB6VNstDu
 jG0JDwtLNRq3IjRkJ+oIknkdcsMsiwi78Q8lBnQbAk3dmlBtTNVEIQQgLGPJ9wLOhHT2uibpTAy
 Hetnq6pOHOnU6YRgPU77i1FQbsltr8WTqXUfb8sDnuFcSJ8p7CNkQ7P650RChjRRnjf7sdIsVp6
 JVp0c8iQ/2TBt82NfrHvdg7hMHIJgrl9Eis4FAxvfTax37bE7hmhvnNxRcPkAcxg7i3aR3QS04O
 oXmZ+fs9qaLjtGl7sjKm6++dlNaICbeAtCyRkVRCD8ocSzbihrq70zVm2PAMvDixCmjNFDUfkfU
 BCOODkiWn2q8lfnaO1MQ=
X-Google-Smtp-Source: AGHT+IEJ1eivaeWrcmtxK0p+xX1SCCCFUJhl1MmKRak+t4kFuxpghmb+PGetm1V6SK2rBa/vnU+uzQ==
X-Received: by 2002:a05:6000:1867:b0:390:f987:26a1 with SMTP id
 ffacd0b85a97d-39132d885bcmr10640726f8f.29.1741683498453; 
 Tue, 11 Mar 2025 01:58:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2b6asm17720469f8f.66.2025.03.11.01.58.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 01:58:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PATCH-for-10.0 v3 6/8] hw/vfio: Compile more objects once
Date: Tue, 11 Mar 2025 09:57:41 +0100
Message-ID: <20250311085743.21724-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311085743.21724-1-philmd@linaro.org>
References: <20250311085743.21724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

These files depend on the VFIO symbol in their Kconfig
definition. They don't rely on target specific definitions,
move them to system_ss[] to build them once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20250308230917.18907-5-philmd@linaro.org>
---
 hw/vfio/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 8e376cfcbf8..784eae4b559 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -14,13 +14,13 @@ vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
 ))
 vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PLATFORM', if_true: files('platform.c'))
-vfio_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
-vfio_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
 
 specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
 
+system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
+system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
 system_ss.add(when: 'CONFIG_VFIO', if_true: files(
   'helpers.c',
   'container-base.c',
-- 
2.47.1


