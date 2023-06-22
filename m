Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A815873A5B0
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:10:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCMt1-0006E2-34; Thu, 22 Jun 2023 12:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCMsm-00068O-M1
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:10:04 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCMsk-00010n-Th
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:10:04 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3094910b150so7581997f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 09:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687450201; x=1690042201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0HtP5OMiHV1uHyCREuOsPgXLNdWuwc5y+seBeAIuir0=;
 b=fD2yFKYVUSbELRWkgGW0danFEJd49UvIoHVUaoL+iV8IqYQvNfiml31iLxtBJeKK+2
 BhYPg4qUhHRzjckRgaA9Y7ICZhNcCZMhqc202pVq8XOrpxWtk6WoH7hxA67ck5XYCSA2
 a1mUXkxpR3fQsnOmFzfz0iq4qYue5q1tdAT5/kH9rAuDXlR9gqshBZLvQbP2e7xh87Rz
 116ue4dKX7z8nRG43aPZMWOGjKu3Mtzz5LGCpfwr8CqoismIj/q6QyBXeNO1kiC0U6lz
 /+jW94I7TghlhujpjnaWLHWAqKt+jU29K9hKNOv+XTxyLGAUr4jy4FnAEonFW8sot8W/
 zLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687450201; x=1690042201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0HtP5OMiHV1uHyCREuOsPgXLNdWuwc5y+seBeAIuir0=;
 b=bUD5J9/23eMSbYAqpt3133bVUQZ54f5BINQMCq0/EvFul6JhGHHaqPstxc2ujYGUPq
 EdRO2vsBEqa4NPOi7SgZwSExM2YGlktF0oXg3ezkoohbAO7xZ4QiPiwnBt9iWp6aQ4mT
 CRNKy6hD/d0kvIYa1oWlEtDYN0wwM8LACE1LXEB1XBvVl6RJ+4axlQt0fAL/9oFI06a/
 uCAEjgZ2ocBJvVOvhSh8ratmzfY8Rg6FgxWyn1a4FnRqwJnECmuWGVAvq5Zvq92lVZzB
 W0Ijz/dGwdVDvAYn3XvQAIDScD8aNMkNGP9CEhu08EIwg4Z5Zv/jg2oqzuAf1NPhEBT9
 BsXA==
X-Gm-Message-State: AC+VfDxpjkDwkRAN1DZI6x8+CLkTwkvb5g+BBo0h9BcVSCSwvgTLbx5T
 Nwak8dllXuRRdgLK9PGJ7lKMwYXbMctcB++fYu7jrA==
X-Google-Smtp-Source: ACHHUZ63Fuzhm8d41+KEQTBgPUOc0gqnijkCpCOihqOKQVjSB4IS+fg+O0ZMGvIAchJ0HLw7tqsoww==
X-Received: by 2002:adf:e611:0:b0:309:fcbe:748a with SMTP id
 p17-20020adfe611000000b00309fcbe748amr17046247wrm.11.1687450201085; 
 Thu, 22 Jun 2023 09:10:01 -0700 (PDT)
Received: from localhost.localdomain (230.red-88-28-3.dynamicip.rima-tde.net.
 [88.28.3.230]) by smtp.gmail.com with ESMTPSA id
 18-20020a05600c231200b003f9063fc3cbsm15728619wmo.44.2023.06.22.09.09.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jun 2023 09:10:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Durrant <paul@xen.org>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Eduardo Habkost <eduardo@habkost.net>,
 Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 09/16] accel: Remove NVMM unreachable error path
Date: Thu, 22 Jun 2023 18:08:16 +0200
Message-Id: <20230622160823.71851-10-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230622160823.71851-1-philmd@linaro.org>
References: <20230622160823.71851-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

g_malloc0() can not fail. Remove the unreachable error path.

https://developer-old.gnome.org/glib/stable/glib-Memory-Allocation.html#glib-Memory-Allocation.description

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/nvmm/nvmm-all.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 50b96ced45..0588a328ae 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -943,10 +943,6 @@ nvmm_init_vcpu(CPUState *cpu)
     }
 
     qcpu = g_malloc0(sizeof(*qcpu));
-    if (qcpu == NULL) {
-        error_report("NVMM: Failed to allocate VCPU context.");
-        return -ENOMEM;
-    }
 
     ret = nvmm_vcpu_create(mach, cpu->cpu_index, &qcpu->vcpu);
     if (ret == -1) {
-- 
2.38.1


