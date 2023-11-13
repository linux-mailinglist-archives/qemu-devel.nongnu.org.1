Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7777E9FE5
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 16:23:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2YlL-00028y-Oy; Mon, 13 Nov 2023 10:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2YlJ-00026Q-41
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:22:05 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2YlG-0003Jd-OE
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:22:04 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9d216597f64so705796766b.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 07:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699888921; x=1700493721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24ML07HsEvOYl+DuxzoZlUZnhAFy4fscEFWSzx7VWys=;
 b=nG22BWFuZcnBlblgHlRLLEe2IVUdaAhNL1DUHJ+N/Bbl+wUBwObPc15u6XyuWiUvGR
 gap1AfBIIOXM80dYf+PZTH7DwynaHQnl+TEN+b11wOgCT3Cur1iOwLJTqxp9BWSWIlis
 t+dUqKNKjcN/khRVHLnW4u2uKaoe6smakQBwqgwFmfqFCV1PJC/YL22CbMqPfBsL1hBk
 896lp4OCt4TlRwyUQUJ9mDRK1YgkFmfwR7BC0C3mccNEXfAnbS79aUiJUTZExemxpM+5
 rs7jvnSXa9cDTCQ2ehE/3Gbx4YAfqX2aIx5zCyTIghJs9IzdIrun8AJIH0zKB+a3OkTc
 WurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699888921; x=1700493721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24ML07HsEvOYl+DuxzoZlUZnhAFy4fscEFWSzx7VWys=;
 b=XthXuXxlSjoMzW7M+a+7/ZRisuPZXKAd104qJLqhBkwpyArk3BLA1r8wiMU9dt4SFP
 4U+2bPWgMlg6l6e4nrP1nhkSxHMvgASz/KMYHX7RGj0I82lFFcFIYIdjm+OxKdWlHIJX
 pgJSbweLkMRJoJZTnfKhsV9UOJ1s8J5J3noj79xv9Uv+Lk5TXxq6+39kNmqtCDPD80ou
 +hi6vs3CRN73wAJvZGgTL3LNOywEynHm1vQQfkIkA/EvvUdrw5yH3rmo9h+BMoQbuo/S
 xjVWyueyuj5Ddy+Hv+/Xn6fnekvVEDKoIKesxw8l87S1qhcQ4TT8uhg9E69L8fBHOTEQ
 qN9w==
X-Gm-Message-State: AOJu0Yyg/cPyFcAclzAp+eMmcaUJuAZh+vBmh+r/VtXmAJ+LNbdun9FH
 jqqSqZXiFXtKCkS4UKntwwtH/A==
X-Google-Smtp-Source: AGHT+IH+PnzXWjrgKP+WWXsdazo2lewjVqkzA92vUb1Slw8L1D+s00HazVDZsJw73hj51Hyp7Aw3PQ==
X-Received: by 2002:a17:906:5fc6:b0:9e6:5132:43e5 with SMTP id
 k6-20020a1709065fc600b009e6513243e5mr4860965ejv.16.1699888921215; 
 Mon, 13 Nov 2023 07:22:01 -0800 (PST)
Received: from m1x-phil.lan ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a1709066c8a00b009dbe08bc793sm4269124ejr.18.2023.11.13.07.21.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 07:22:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Woodhouse <dwmw@amazon.co.uk>,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 07/10] sysemu/xen-mapcache: Check Xen availability
 with CONFIG_XEN_IS_POSSIBLE
Date: Mon, 13 Nov 2023 16:21:10 +0100
Message-ID: <20231113152114.47916-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113152114.47916-1-philmd@linaro.org>
References: <20231113152114.47916-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

"sysemu/xen.h" defines CONFIG_XEN_IS_POSSIBLE as a target-agnostic
version of CONFIG_XEN. Use it in order to use "sysemu/xen-mapcache.h"
in target-agnostic files.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/xen-mapcache.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache.h
index c8e7c2f6cf..10c2e3082a 100644
--- a/include/sysemu/xen-mapcache.h
+++ b/include/sysemu/xen-mapcache.h
@@ -10,10 +10,11 @@
 #define XEN_MAPCACHE_H
 
 #include "exec/cpu-common.h"
+#include "sysemu/xen.h"
 
 typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
                                          ram_addr_t size);
-#ifdef CONFIG_XEN
+#ifdef CONFIG_XEN_IS_POSSIBLE
 
 void xen_map_cache_init(phys_offset_to_gaddr_t f,
                         void *opaque);
-- 
2.41.0


