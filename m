Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E28FD7ADE9B
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:26:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHW-0001Dn-S3; Mon, 25 Sep 2023 14:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHS-0001CJ-Qz
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:02 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHP-0007Hd-Sj
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:02 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4054496bde3so53072745e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666358; x=1696271158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8NgIQuhS1pWjXF2WQJZ+g0h0EHjHQYwR2fjodfnfROY=;
 b=HaHy4kgnI5RQBZInNMicEXkHMpj/04PyhUEWMRziMJueRTtifBVrd80Sca29e6eX8l
 CfEi+cReHOodSLceH0ghpMOcSgCyhxSC/ajMmw4rZX5qqt3SpIh7nMX7ZaIRQjLWMHVP
 +wZ1zyWFBWJOlNRHAv6uCaHMx6shY3Fqx28aCTpDeGGjRczk/fVMyc+RoZGmGAfDQMmH
 v/gjbJii36z6NdHgJALwIoGqbsuLn1GiQBAuSCoChUPJMMjYaq4pXXQpiN0puznIU2K+
 /1DNpeFq2yYDjHKPPM8bPLeWzXjcUNy6oEJ3/1IKmkNQFdI6QpyQhE3RB7gOPPMuI61/
 Gr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666358; x=1696271158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8NgIQuhS1pWjXF2WQJZ+g0h0EHjHQYwR2fjodfnfROY=;
 b=bV1aEc94lTYwu8Vm3imbKnuR38n+Q5D02cFziPdE7Cmkeuz9DitVNz4VmCWFhBgi91
 9Uh+WSBnenGqqRBhIXeVLr6eoxdSb3/v78xdyAYLGOhK5xSXaCXb6JZuQEwXW1jMK/WR
 V0C3mYfU8LimIFVwQst1lFbt5qGlII6TsTwVIZf1+Z38VTHVmEEqBviqIjkrEQwA2457
 5E+zEeWMETEGfzY1fuo9P36k97RzoNCbFXukXUj+yx+fGIqrmEeh1i1doijv39dVWVqo
 /DGwNxriYCyZF5RvTDbruM4speZBM/52D8nd/vbR5Pm1VCcNnDHsmeSP6GpFDpN5EbC2
 mmrg==
X-Gm-Message-State: AOJu0YxLWSYxt76XBravKQ4CkhV7aVoji/B0BQkXne8by0lq/BREx8pN
 8UN3FBjtUXrtcU5HCX+AARY8/cuMT2k=
X-Google-Smtp-Source: AGHT+IHRyj/YD2I3GFwx2hw34y/o9RgqA2T75SICF+xjNWSla6Bj6PAFBd06/MAcuepCRPcoXSudCg==
X-Received: by 2002:a7b:c390:0:b0:402:f07c:4b48 with SMTP id
 s16-20020a7bc390000000b00402f07c4b48mr6283145wmj.28.1695666357683; 
 Mon, 25 Sep 2023 11:25:57 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:25:57 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 05/28] bsd-user: add extern declarations for bsd-proc.c
 conversion functions
Date: Mon, 25 Sep 2023 21:24:02 +0300
Message-ID: <20230925182425.3163-6-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/qemu-bsd.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 bsd-user/qemu-bsd.h

diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
new file mode 100644
index 0000000000..b93a0b7fd5
--- /dev/null
+++ b/bsd-user/qemu-bsd.h
@@ -0,0 +1,38 @@
+/*
+ *  BSD conversion extern declarations
+ *
+ *  Copyright (c) 2013 Stacey D. Son
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef QEMU_BSD_H
+#define QEMU_BSD_H
+
+#include <sys/types.h>
+#include <sys/resource.h>
+
+/* bsd-proc.c */
+int target_to_host_resource(int code);
+rlim_t target_to_host_rlim(abi_llong target_rlim);
+abi_llong host_to_target_rlim(rlim_t rlim);
+abi_long host_to_target_rusage(abi_ulong target_addr,
+        const struct rusage *rusage);
+abi_long host_to_target_wrusage(abi_ulong target_addr,
+        const struct __wrusage *wrusage);
+int host_to_target_waitstatus(int status);
+void h2g_rusage(const struct rusage *rusage,
+        struct target_freebsd_rusage *target_rusage);
+
+#endif /* QEMU_BSD_H */
-- 
2.42.0


