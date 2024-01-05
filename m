Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A569825740
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:55:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmRM-0004Vt-73; Fri, 05 Jan 2024 10:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmQe-0000WW-NX
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:48:14 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmQc-00052M-EM
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:48:12 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-336990fb8fbso1224171f8f.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469688; x=1705074488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwNOMMIAYzGSLWabz4mQJXWqt1PJzQTuexNMmuOK734=;
 b=zTpWELjazCjgv0efnlE4zgCZ6HMfKPlhg7nalHCtNUcEufcNlCWuRjuP6LJ9uo75Ur
 +ULrhv/L//U7gescR667EK9aNhCAPgAS8DWNrKeVSbPTXSLugeLAee/nUj3nl4cEBez/
 F331TfRBGXG4m0zMU6p+k6Nh0HmUpU0NP91eJFH1AGeyRcyX2GNwnhPpWO9ksIBaZlps
 eR+BMefEpXYEBfigksRECRFsDbzf+JDqMOeGJVmHb+MRGf37TATqYwxecIizGM5M+ZD3
 7TxuOS9ny3tgcLdMuthxk+SbODKAIGH7osJoZBxrlUBgL/0xxDSVgVPbryjwvtywRgcy
 kFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469688; x=1705074488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rwNOMMIAYzGSLWabz4mQJXWqt1PJzQTuexNMmuOK734=;
 b=ZGca/5HBoc+Q/9fXmWFSsAz3bwFx6DhyuyAz9pITAZRACkH3FuGjGiOpfS057LKHJu
 5VrJInZyWjMuN4NhRcrLMefk2ZZkKCHQxnhYSHX3U9R5HIiP/Z3uMyq0jojKf+Gycpae
 gTqA7/hIUxmpr+E6fvPygt7euOh7nGOoE7KE63BEZJjMKyQ1Kgg+oN3CSQL9JFFUKEP5
 z+bL7NG/TwhOB9zF747SMcWVKvDAjeF9iqXsO5wWexxsCmeESpJWNjNC7PPLmGjItnyB
 obuTpjxXuV58xxcNWxiva5rQiWmEtw4LyWwoWQyDXk7J56j/jvwEB/cwDsf+AUM0hBDk
 F4+g==
X-Gm-Message-State: AOJu0YxjYS25e+9Ps07VuH0N7sUCvB0GKMsTXN87JoLe2LEy7+zR4LyZ
 VH59wzfiKhrbhDI+U5ESKVUAxmum/5iCMHc6KZYQfN4TRYM=
X-Google-Smtp-Source: AGHT+IE3AwHJlxhlvMqgvF8M8h0KfKHRXRjT1nqeu0wbgl9Vs7yTQ8aq+uC0QVut0myi6CcQGNipwQ==
X-Received: by 2002:adf:e0d0:0:b0:336:e366:471 with SMTP id
 m16-20020adfe0d0000000b00336e3660471mr1336264wri.58.1704469688486; 
 Fri, 05 Jan 2024 07:48:08 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 o5-20020adfca05000000b00336ee9edbb3sm1605985wrh.94.2024.01.05.07.48.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:48:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 47/71] memory: Simplify memory_region_init_rom_nomigrate() calls
Date: Fri,  5 Jan 2024 16:42:40 +0100
Message-ID: <20240105154307.21385-48-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Mechanical change using the following coccinelle script:

@@
expression mr, owner, arg3, arg4, errp;
@@
-   memory_region_init_rom_nomigrate(mr, owner, arg3, arg4, &errp);
    if (
-       errp
+       !memory_region_init_rom_nomigrate(mr, owner, arg3, arg4, &errp)
    ) {
        ...
        return;
    }

and removing the local Error variable.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-Id: <20231120213301.24349-5-philmd@linaro.org>
---
 system/memory.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 72c6441e20..3997ac5928 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3601,11 +3601,8 @@ void memory_region_init_rom(MemoryRegion *mr,
                             Error **errp)
 {
     DeviceState *owner_dev;
-    Error *err = NULL;
 
-    memory_region_init_rom_nomigrate(mr, owner, name, size, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!memory_region_init_rom_nomigrate(mr, owner, name, size, errp)) {
         return;
     }
     /* This will assert if owner is neither NULL nor a DeviceState.
-- 
2.41.0


