Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7672882BEE1
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:06:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFLI-0005fR-Rf; Fri, 12 Jan 2024 06:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLA-0005YZ-Le
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:44 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFL7-0008Tz-E3
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:44 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33765009941so4991698f8f.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705057478; x=1705662278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PuBv+tjjYyX/4wybca/v00Vtc3kwStjz3AWoQ1ArRxc=;
 b=wyq/oX6eKbho+QbKQ1rxwnncg/pI+1uD5liFjVTRg5cCy+NGazvHmBGXKSP5EcXjpM
 UeAvaeCsupZ4V4ww0SDHL2dfSjKxYpEMqn+7z7n24JYlWYl/MbnREqdZjaWxKdiOkAm1
 g+y+SAZj2vVwnYzknLT0YxZcFrUq6audBUAlBczykdkSrdyaIXYierXnAtO3H5DKCNyk
 x0VxhmVUgYkC6esrr8Hm3rx9ISxHetudTJG20xe+pJGFKZe/bRPZlfPlimxot6f9liQL
 yKnRYOUDa9IITL9JAmyHvKHixvj77mA92L58np06rFuoLrQrCNAZDwX0Pw230SfXRa5S
 SdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705057478; x=1705662278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PuBv+tjjYyX/4wybca/v00Vtc3kwStjz3AWoQ1ArRxc=;
 b=AbFN7C5NRUUQffIVs5iMGr0U2uwbZOOWWrKTuxWiQyoy6vinkFGwSa2H/wzbOzWIYg
 s0+rZuIrlsQ3LUql0szI2HSSCMleoociNd3KiBW+ctfbZpZumUsdiT4ZwJcpn9XxAaJ0
 Fw4uns/imt4nzIc/+3B6vUijOU3oBqeNbWipuE6hEFVJ9qcQjDk+Yj1g4a8/zCDOGkIz
 UDTcQzTQBW1KZLCkD0cw0OVXiIa6PkJmefQTFtUlL1jEn6oVgbL3TfM2o5nvFo748e21
 RQOsdm0Hc/vIcw/+FeRQPOEwVymIcDmFnVFI8FFx3UfOueyxHtzm7l/ufHiCxI8Jmg4x
 mIKw==
X-Gm-Message-State: AOJu0Yyj70jSYsrmpQRm0mCXC7N6pqLlPq3BLi4LlQ4Mipg5jejdeo6J
 91GaLB/XareKzZAWgP1kf+fe7XZoxQV5Mw==
X-Google-Smtp-Source: AGHT+IGbQuk6POLM8cxr7zqiCsayNJdOK1YHp5aSWlH5Oi8N4gAaQM7Kvf2fzp4dWrgkdmm3cu2iEQ==
X-Received: by 2002:a5d:65c7:0:b0:337:767f:c989 with SMTP id
 e7-20020a5d65c7000000b00337767fc989mr636755wrw.12.1705057478759; 
 Fri, 12 Jan 2024 03:04:38 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 s27-20020adfa29b000000b003366cf8bda4sm3566784wra.41.2024.01.12.03.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 03:04:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3C0005F7AE;
 Fri, 12 Jan 2024 11:04:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org (open list:Overall KVM CPUs)
Subject: [PULL 02/22] tests/avocado: use snapshot=on in kvm_xen_guest
Date: Fri, 12 Jan 2024 11:04:15 +0000
Message-Id: <20240112110435.3801068-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112110435.3801068-1-alex.bennee@linaro.org>
References: <20240112110435.3801068-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

This ensures the rootfs is never permanently changed as we don't need
persistence between tests anyway.

Message-Id: <20240103173349.398526-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

diff --git a/tests/avocado/kvm_xen_guest.py b/tests/avocado/kvm_xen_guest.py
index 5391283113e..f8cb458d5db 100644
--- a/tests/avocado/kvm_xen_guest.py
+++ b/tests/avocado/kvm_xen_guest.py
@@ -59,7 +59,7 @@ def common_vm_setup(self):
     def run_and_check(self):
         self.vm.add_args('-kernel', self.kernel_path,
                          '-append', self.kernel_params,
-                         '-drive',  f"file={self.rootfs},if=none,format=raw,id=drv0",
+                         '-drive',  f"file={self.rootfs},if=none,snapshot=on,format=raw,id=drv0",
                          '-device', 'xen-disk,drive=drv0,vdev=xvda',
                          '-device', 'virtio-net-pci,netdev=unet',
                          '-netdev', 'user,id=unet,hostfwd=:127.0.0.1:0-:22')
-- 
2.39.2


