Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8456678B93A
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:12:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiYv-00087o-58; Mon, 28 Aug 2023 16:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYn-00087U-8U
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:05 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYl-0007Nn-3l
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:05 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9a2a4a5472dso779246066b.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253401; x=1693858201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3DrY2drMITN1M+I93LgIZwfu7VR/2IaNaUCsMyK3Qs=;
 b=ObadcteVjd/Re/6c0+rrcCOBhYMx6g323Vm1TlcarSnCZlSG4t8qm6NS9J8uw4nxUH
 /ual7NkKDUmXNZVA6JlUnnjKH43sVZPc8mvCONTDj0F73bpAavosehJn67Ylq3fPtDC8
 LC/lXb4GEp5QlRZfXCXZ9DCLGtwJvKEsmqtKAQsV47DLS9B/SNrlDUJc9Sj5zsHu56X/
 XOM9a0leJpkLF7P4SOPF7PuxsQu/yDIjiy4AiV8uH/uDZWetK2p1N5LbeazRoVpQ0k9l
 xv3prMDwS6zHUdkGUpGTwW5Vlr9nWzxoKfr6EML65dIcGTu0b1q9KRXwVxhWpTK9mZmo
 /dQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253401; x=1693858201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D3DrY2drMITN1M+I93LgIZwfu7VR/2IaNaUCsMyK3Qs=;
 b=gllpCEVXXYWzRGPTKOonsCN1r3hZ5kKgpt93Unhj+MdCFmO6lmk/De8lNo+3l/XFui
 JTmQU+qU2I7LzJsh9dtTkrlxgLl5nlRXgZ0gTPcw79AWmgJCptM6byc625UPVK+5E6Od
 YBjMTm3ojZdb2gev7QDJV3yvtj7EzB606R+WnumI5V5j1lxEndikxu6ezABDTwGcskKo
 gb8UNHDusq7sb+i8E6Ku6vMweu915g26WVCNoKMfBwkT714iu4V7e417xZgxwDcX7YWT
 lBPlUBnjaXGsm3kPU5VnTYU+KMZwCzxPiUTb0qJ+mO9AZTR9k/xje8/jzJgwaf127QUa
 DV6Q==
X-Gm-Message-State: AOJu0Ywp96XVTODJyjkyPb3Qr70aMrZko9kSH5yDDb8Vhm3mjLYw90ci
 a9qr2FyfLydfda7vCLxaqOKcs0YHa5AVjw==
X-Google-Smtp-Source: AGHT+IGNs6ERLdiW902NBvc+5SwYVlpnQ9tovL0gfpTT9i3ISTWmMI05VL6Z7VeQb5Xsv0/64ChEsg==
X-Received: by 2002:a17:906:8a49:b0:9a5:c95b:45e3 with SMTP id
 gx9-20020a1709068a4900b009a5c95b45e3mr109306ejc.26.1693253401416; 
 Mon, 28 Aug 2023 13:10:01 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:10:01 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 08/32] bsd-user: Implement target_to_host_rlim and
 host_to_target_rlim conversion.
Date: Sun, 27 Aug 2023 17:57:22 +0200
Message-Id: <20230827155746.84781-9-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 bsd-user/bsd-proc.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
index ae2e636bb3..12e43cfeca 100644
--- a/bsd-user/bsd-proc.c
+++ b/bsd-user/bsd-proc.c
@@ -81,3 +81,36 @@ int target_to_host_resource(int code)
     }
 }
 
+rlim_t target_to_host_rlim(abi_llong target_rlim)
+{
+    abi_llong target_rlim_swap;
+    rlim_t result;
+
+    target_rlim_swap = tswap64(target_rlim);
+    if (target_rlim_swap == TARGET_RLIM_INFINITY) {
+        return RLIM_INFINITY;
+    }
+
+    result = target_rlim_swap;
+    if (target_rlim_swap != (rlim_t)result) {
+        return RLIM_INFINITY;
+    }
+
+    return result;
+}
+
+abi_llong host_to_target_rlim(rlim_t rlim)
+{
+    abi_llong target_rlim_swap;
+    abi_llong result;
+
+    if (rlim == RLIM_INFINITY || rlim != (abi_llong)rlim) {
+        target_rlim_swap = TARGET_RLIM_INFINITY;
+    } else {
+        target_rlim_swap = rlim;
+    }
+    result = tswap64(target_rlim_swap);
+
+    return result;
+}
+
-- 
2.40.0


