Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD2E836406
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 14:09:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRu2V-0000QT-Ft; Mon, 22 Jan 2024 08:08:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rRu2T-0000PP-6I
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 08:08:33 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rRu2Q-00014x-Cf
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 08:08:32 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 57B5C40C80
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 13:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705928907;
 bh=yviA7/+UMxsnToKwTGCWASxAcfmJt/l+CZbA5p4HzL4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=gz1HVx8CUHxNVSEXlzbB4j5bR/WL4lZgRkxpjXz8mr12r2lnHOWUZ6FVb3Zzz5u0J
 RUNy36XRIHFH2PrQKhwlvRn7cM5Vd5ouIxGDI+zNWiRIKod/0VLhJc3R4UTbij++i/
 PdhbbdjFtQXEv8ltQ/oh8XaTiUhfejMUGKdLj3d2hregVBWVvEglNGj14PpJ+GFb8x
 bqe8AqNOmpkck7NwFzC3fI+ykp2dH5jGfrb568kdTQu5v/DVtNm5IbmquYuPSoPC7x
 gn+mnJGeDhOsbC6KWCKuJJB/YLr4dkqfEUXFC6hf6LlckCUnO31PAdz8Vh5pXuP+iI
 qli5qo77h0DOQ==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40e435a606aso24459585e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 05:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705928905; x=1706533705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yviA7/+UMxsnToKwTGCWASxAcfmJt/l+CZbA5p4HzL4=;
 b=SpeHaae5AJ/6OYq/8TumGecDNXgOlYGbGWig//1tYTmGPAv0GK+Ezex4z/vSn47ns5
 VKXIJ2gWI2LhmJwO3C8JIZGXK9p4RkIx0yT2buGUVBPjDOiMihGUF1V0Yvpd3CUEytGm
 /cau9NbvdzC3eflkEV5Hq9XKUH9u1gObFdPKo1+6wktcPV1sLdyzznY6Cn1He3W24wgX
 5NbngqyDuXFS1VwnT7fykvC6b4J+GtoLB3pwfHGeftw2ZjaCmrzzzr4ZFbFBD5thApFk
 tlPYr+z6VI3qQ5jcQFip1S03L1V72MPwzu2LWMuFHXZqGoNl5Gc1ThnSatIaZpELgSw0
 0GBA==
X-Gm-Message-State: AOJu0YySBkBtWp150MzE353FTC+g6Wfb9Sma1KD1hQzl6/4kHurAa5KH
 FXFeLlUx1mF/YL+L15/alNwGJbmke1PcbwOewtsKoCXvuocvmBJPqge3fOT9YOs2c8HttZbLPL9
 59qgRdrV6Z77ohUXtoHe7czyMihqv/xQkMklmw7wzU7ZhhGqKPBqWl1d4JWyh7KojTkse
X-Received: by 2002:a05:600c:5195:b0:40e:a217:1706 with SMTP id
 fa21-20020a05600c519500b0040ea2171706mr2791812wmb.50.1705928904860; 
 Mon, 22 Jan 2024 05:08:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGr51h6Pavea92G2vCyT4+7dd5/0CCUpbJ9footdmkB/SFIdJT6xkOSGzBaBJI9yext4mYtcA==
X-Received: by 2002:a05:600c:5195:b0:40e:a217:1706 with SMTP id
 fa21-20020a05600c519500b0040ea2171706mr2791796wmb.50.1705928904489; 
 Mon, 22 Jan 2024 05:08:24 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a05600c445500b0040d62f89381sm39214456wmn.35.2024.01.22.05.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 05:08:24 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 4/4] qemu-options: enable -smbios option on RISC-V
Date: Mon, 22 Jan 2024 14:07:58 +0100
Message-ID: <20240122130758.74051-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122130758.74051-1-heinrich.schuchardt@canonical.com>
References: <20240122130758.74051-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

With SMBIOS support added for RISC-V we also should enable the command line
option.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
v3:
	no change
v2:
	new patch
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index d90bdffc7a..935aec7cb9 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2697,7 +2697,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
     "                specify SMBIOS type 17 fields\n"
     "-smbios type=41[,designation=str][,kind=str][,instance=%d][,pcidev=str]\n"
     "                specify SMBIOS type 41 fields\n",
-    QEMU_ARCH_I386 | QEMU_ARCH_ARM | QEMU_ARCH_LOONGARCH)
+    QEMU_ARCH_I386 | QEMU_ARCH_ARM | QEMU_ARCH_LOONGARCH | QEMU_ARCH_RISCV)
 SRST
 ``-smbios file=binary``
     Load SMBIOS entry from binary file.
-- 
2.43.0


