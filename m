Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DFD73CC37
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 19:43:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD7Ho-0008Om-2f; Sat, 24 Jun 2023 13:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD7Hm-0008Kr-06
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 13:42:58 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD7Hj-0007Z4-Lc
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 13:42:57 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fa23c3e618so23392815e9.0
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687628573; x=1690220573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lnzdpi/SMqQKnah+FjHhFaYorhth+hVWT4q3k+G9Eas=;
 b=Rl+gIz/1qET6eDxSMKBlhgEu7TmyZ3qVvdZ/pF7ESuaDiAgqa0TRaV3uHvFx81SIeJ
 qV48l02FA5t/FTKOknHNBLfCx5Ba1eIp6WEdUkWmn7UkdBYryX6Psh7GsUfx5W+xyxkL
 3c8KjhetLy0GIjWOUWB3ntdnDUeOwr94g+1P+m5shTihxl+S6wUTSEMW3Qlx3DI6NP2l
 vrLr9dXR9+akQkWnsGaMqcGp/3u5JivD0nZdZrXF6pZOBFyTPj2x9FDEPXRcn+qIk9nD
 5gqJesBceAKK2qgsqePd5rhjrvRO65NK/VxnJZ9g/MTCIDd+ugMpSpYXChqlyNwCrEuQ
 lcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687628573; x=1690220573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lnzdpi/SMqQKnah+FjHhFaYorhth+hVWT4q3k+G9Eas=;
 b=gbqersA2tTAjGEoeHYzbVZLAy2Lk2/aVIGGxd0UAQj4jBQh1M8ZGmJ8VYiFH3RbxPW
 C6HV0txz5RzfPv1duoNvPaUoqFA9abYFs2h2tYiy12cbJx8uAK8VA+e1mWcainq2fQED
 5BFhSqyuu1GQHYJlCivflsDlinTF7AtjfSaBLprRrCYeW8yKSheeqvzK469H50c5edHo
 n4LBuPsyQuqcBBbUA3YdMVjW3OUHRifVA7Qg5iZ/pkyNn4b/1aAYGhGav68+pcVHRJHn
 uXIx1ckNpvjmbyS5R9S1Uji2wOgknNyUY36JEULmuX6Rj3qCH8UM4ll8eMJI34ZFht/y
 oj2w==
X-Gm-Message-State: AC+VfDxOQH2WIPzXQvuIdFqQLJ2gq+kDmyFGEvg+PhoE5umoEsWtCqPM
 6Uc4KLSboGT1o1IyNCSqHjLPXXU9iJwYdtgKKHk=
X-Google-Smtp-Source: ACHHUZ54XAa6Du/8XTOzNhZjWrdIxzwHN95ahuIY8Dglo2ED7aclOY9r3VnonPY6Q+CxQ2enFMDFBQ==
X-Received: by 2002:a5d:4c49:0:b0:307:9702:dfc8 with SMTP id
 n9-20020a5d4c49000000b003079702dfc8mr21407001wrt.48.1687628573655; 
 Sat, 24 Jun 2023 10:42:53 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.217.150])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a05600c290500b003f9b66a9376sm5651642wmd.42.2023.06.24.10.42.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 24 Jun 2023 10:42:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, xen-devel@lists.xenproject.org,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Reinoud Zandijk <reinoud@netbsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 12/16] accel: Remove WHPX unreachable error path
Date: Sat, 24 Jun 2023 19:41:17 +0200
Message-Id: <20230624174121.11508-13-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230624174121.11508-1-philmd@linaro.org>
References: <20230624174121.11508-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

g_new0() can not fail. Remove the unreachable error path.

https://developer-old.gnome.org/glib/stable/glib-Memory-Allocation.html#glib-Memory-Allocation.description

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/whpx/whpx-all.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 410b34d8ec..cad7bd0f88 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2179,12 +2179,6 @@ int whpx_init_vcpu(CPUState *cpu)
 
     vcpu = g_new0(struct whpx_vcpu, 1);
 
-    if (!vcpu) {
-        error_report("WHPX: Failed to allocte VCPU context.");
-        ret = -ENOMEM;
-        goto error;
-    }
-
     hr = whp_dispatch.WHvEmulatorCreateEmulator(
         &whpx_emu_callbacks,
         &vcpu->emulator);
-- 
2.38.1


