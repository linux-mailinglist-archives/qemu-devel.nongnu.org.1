Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A27CF7EB2A5
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:42:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2uYo-0002fM-KK; Tue, 14 Nov 2023 09:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uYn-0002ds-Ed
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:38:37 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uYl-0007k1-J6
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:38:36 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9e8b36e36e0so339769566b.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699972714; x=1700577514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r7OOTLwbh53U5+FgsPEU5EGeXSv4SaNpAAr4X/+o3UA=;
 b=H7rxLvbB2AwOaYghSB5hIz76RzW9FdSjTZWhMwhbntJ3npIQcFayR3XFH0FzU86yUz
 bbCH5YlLjjh6zbpLqZW31acUquBKH2RI5TQMoP8aVXaxysUG+dABax5xVCYIghhTWwN6
 44fVnofwWMgMGZcCfVjnXvI1Tfs4AZ1vQnB7sU7hRym2vCYN2ONHeTsoQm2W6IqI8k5x
 KQuHcWWvEp1gDOBBKJ7X3pY5AArJyeSwcYEZ9X3q/ebMHmT0RD4qfcgo/NAni5NVsoMH
 OFLzP5tWuFZgTnjUYc680+K8KQlExkuHqD4bHx1gP/Dknywb2qYF+/u7gkrTCRTEl39v
 pG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699972714; x=1700577514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r7OOTLwbh53U5+FgsPEU5EGeXSv4SaNpAAr4X/+o3UA=;
 b=v2eFtb8DSp5Zmu85MW4pxxMG5lAbkAEc2yG5UiO0aJDN7NaNOB0i2s1SlGnWh74hAn
 LpyZxvP0gBS6aaQsRTO3vtW578tmQqv9oZVD1+k5ui/1tDW4TuGPJS5ceY4y9qfd8Zlh
 9NIjjP8xkvSp4mEuyzbBG5Q6mfhoLTYTmAz346q7qFf1hFq5220loTIVD4YImslyroFN
 273jK+mVZg0EzEhzYnCEjmPF5zXjvEtpnbuOFDqTGxyOPuZaLKTLQHHIsvv5Bm/gYIWm
 6bAVtTP/MszI/fMGZfwg5fDNd8HozAhlSye4plI56q86GPfJcVq5uGsf0uqFH5i2jI/f
 aSmQ==
X-Gm-Message-State: AOJu0YxA1XxzFDMYYJJGwYHPlBUJMS0qjuFd2oZ/yvAHwwQiy5MG1tiP
 /FNXYSqoUZnyc6tn7MrUtEKn7g==
X-Google-Smtp-Source: AGHT+IELhzs9bxNKpuVpMav1CIPsLfztJ8ibvFnuauNtaNuW/pX7cLT4uf7lQThdsPSioUMrMZEBQA==
X-Received: by 2002:a17:906:ca5b:b0:9be:30c2:b8ff with SMTP id
 jx27-20020a170906ca5b00b009be30c2b8ffmr7193715ejb.61.1699972713904; 
 Tue, 14 Nov 2023 06:38:33 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 ha17-20020a170906a89100b009dd8473559dsm5543525ejb.110.2023.11.14.06.38.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 06:38:33 -0800 (PST)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 v2 02/19] sysemu/xen: Forbid using Xen headers in user
 emulation
Date: Tue, 14 Nov 2023 15:37:58 +0100
Message-ID: <20231114143816.71079-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114143816.71079-1-philmd@linaro.org>
References: <20231114143816.71079-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

Xen is a system specific accelerator, it makes no sense
to include its headers in user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/sysemu/xen.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
index bc13ad5692..a9f591f26d 100644
--- a/include/sysemu/xen.h
+++ b/include/sysemu/xen.h
@@ -10,6 +10,10 @@
 #ifndef SYSEMU_XEN_H
 #define SYSEMU_XEN_H
 
+#ifdef CONFIG_USER_ONLY
+#error Cannot include sysemu/xen.h from user emulation
+#endif
+
 #include "exec/cpu-common.h"
 
 #ifdef NEED_CPU_H
@@ -26,16 +30,13 @@ extern bool xen_allowed;
 
 #define xen_enabled()           (xen_allowed)
 
-#ifndef CONFIG_USER_ONLY
 void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
                    struct MemoryRegion *mr, Error **errp);
-#endif
 
 #else /* !CONFIG_XEN_IS_POSSIBLE */
 
 #define xen_enabled() 0
-#ifndef CONFIG_USER_ONLY
 static inline void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
 {
     /* nothing */
@@ -45,7 +46,6 @@ static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
 {
     g_assert_not_reached();
 }
-#endif
 
 #endif /* CONFIG_XEN_IS_POSSIBLE */
 
-- 
2.41.0


