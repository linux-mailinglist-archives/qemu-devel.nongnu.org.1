Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1BA81B3D6
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 11:40:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGGRn-0003hn-0c; Thu, 21 Dec 2023 05:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGRh-0003ft-G3
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:38:29 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rGGRb-0003qE-TE
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 05:38:28 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-336746c7b6dso476816f8f.0
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 02:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703155100; x=1703759900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qzxoAeOdiga+52AiTCmsWe8ywFNoeoZ5ZVuxsnjrTLU=;
 b=gDyRIMMmzg8a8Lpp0d/LZz6q79ZRZBTg78Ld4g3Y1Ce711K1KijmxNgpe/zoL6XQRb
 ABQLFFDhAmx1ImjZPu4fh7lXeFWqcZ3yRPVU+bvuH8jLNCh4gGgv73bcQmNy7Mpk9R2t
 VJPLTUwSP7HKvNeo/VpzZ8y1SKChl6VkD5rnIBe62l5mGNZqeRAZwo+gYsfcr2ZbSOnA
 bnkOVzK91ZRDLkfqNPyqmQ+vFfzDnOfIOHFGRpQolmzw944Cb5hwv5TBEVEDUIevljAA
 Dvzufu5aBYlZGNOL9QrOATQKT2GnIH0tliAOk/VSTWxy3MpZiQElpfksNXjDSw5bIYSy
 YPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703155100; x=1703759900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qzxoAeOdiga+52AiTCmsWe8ywFNoeoZ5ZVuxsnjrTLU=;
 b=PpJ5ZuT0LNS/VC+HP3sQcnS2ikqMoxQM91VNKGYQcfEl7W0Nw6D9RQMXPax0jGp/xZ
 YRojF70sl/OxG5k6SHvQf5y2FZ7xN/LazDHezj42MWmYF66jazHWlEIDNn+tyGpjgk5t
 Hu0eoOdFqXdCeL4SwKq/Sr06vGg+aQ3voAYdXFzLoWcx2LbymcT/FMxm0h4awkOP7dDY
 /4g45whfQDteX8SIo2iXWhREsRS2b3bjH18ceJskTLARlnX0NwjEPQh/3ZCZLQLZkgwE
 jB/DczMRZTNscXYRZ9/Eo7ZbFie6fl6XlCYtg9oI2kmZXHDZ5u6lictkIP0Fmzit2zP0
 DVpA==
X-Gm-Message-State: AOJu0YzjMbDMrHk5faJgsFYPYlBiAIXHxuFTCMtvlM4d3T2M5Vwv3aRp
 BviXve83WRgYa4A4LECsCGNZew==
X-Google-Smtp-Source: AGHT+IGEPtr1hXboAnkM1kRksQtInSnZ2jI35ee+E47oqVqOC7jqs/eRFR/CZjbl0DDaumndGsscIA==
X-Received: by 2002:adf:e3ce:0:b0:336:751a:70cc with SMTP id
 k14-20020adfe3ce000000b00336751a70ccmr630653wrm.18.1703155100131; 
 Thu, 21 Dec 2023 02:38:20 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v16-20020adf8b50000000b003366f4406f6sm1699383wra.97.2023.12.21.02.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 02:38:19 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 25CA15F8C3;
 Thu, 21 Dec 2023 10:38:19 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Brian Cain <bcain@quicinc.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Cleber Rosa <crosa@redhat.com>,
 David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-s390x@nongnu.org,
 David Woodhouse <dwmw2@infradead.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Bin Meng <bin.meng@windriver.com>
Subject: [PATCH 02/40] tests/avocado: use snapshot=on in kvm_xen_guest
Date: Thu, 21 Dec 2023 10:37:40 +0000
Message-Id: <20231221103818.1633766-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221103818.1633766-1-alex.bennee@linaro.org>
References: <20231221103818.1633766-1-alex.bennee@linaro.org>
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

This ensures the rootfs is never permanently changed as we don't need
persistence between tests anyway.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/avocado/kvm_xen_guest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


