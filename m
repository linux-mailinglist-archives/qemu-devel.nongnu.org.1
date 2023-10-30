Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E983B7DC1C8
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:21:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZeY-0001nW-Np; Mon, 30 Oct 2023 17:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdy-00011f-DF
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:54 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdt-0006WQ-8B
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:54 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc3bc5df96so13191425ad.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 14:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698700666; x=1699305466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8pyDCZsxNfETKywVTX+e7wkZvY5QpmtSHCpOlxwyOrU=;
 b=p+VxXUF4Zf48YmGCH4w9p5Gp3jkrteP0WW112jRI0rx7pue9vdEE8NL7fWO9lAAVwO
 mRhgj34mZrusSN4ZHNsF5PwlDPehHK6B7SK9yFm1Fpp6gpjCNBWgLYU9wroz1nQNG7Ey
 W7lgAkPk5sr7kR+9Fw0FkbpkgD8axJha2mbor1fCPbFiYWcLStypiLrCRI9T5C8IjGHy
 phqIH91+bZqIWT2L0X3kx727+Y3EHTKQvDJHhfyQPas3f/GDm+MmFReg86JfMNszRRwI
 11SKkecahKYJuKNaqrI4b4FxGqEroJ/oHItNd+tMJt4fPovJzRY47N1I9XtMh4B3zbSn
 q9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698700666; x=1699305466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8pyDCZsxNfETKywVTX+e7wkZvY5QpmtSHCpOlxwyOrU=;
 b=OSGnQ3ZB341LdEYA6YZUFysSbKkagr/wRy5oQ68Y/tEgC+/clXbcmlHCpmJ1G0R7lh
 mdfsBrFfmATeQkeVFKspJjaA0kj0Erg9CkU6NKMznLuLza4uaZx+fVbq4fc7Mk0/en0B
 zhc0jtu0lF6IY0l1DuqPU/dfOwU+uzDLGJlVud5yn3BkNI01hM5Dyxj9obtsdPOBs7pz
 hWtcTH/HUqL1h4lL7lU0wkS+uBkfpULcMx8/Zw+wXNzO7BfqEoqzWH0QA4PITQeVHjUh
 CqZ5wLyriZrPpPTlMzVtgw8DeS74JSfw1lSt/ff+E9Xf8yxAugzIyPgk28kE9od2+Kae
 QZew==
X-Gm-Message-State: AOJu0YyvEPwSqJOANYc21ZwxLWGOCHmDX5h0+vkA5YMWNgb7kI+wuXvI
 4+1E816kj4lM6VQzYBTjUvWB2RPovP+OwBaDV3s=
X-Google-Smtp-Source: AGHT+IHe0Zy5sDzydwv75V6+UQVlO0Zn4WpzOeVuicLjJ46jJUSljg99hS2+CtqFF+n7yKCdSpZPFQ==
X-Received: by 2002:a17:902:d30c:b0:1ca:b820:74ed with SMTP id
 b12-20020a170902d30c00b001cab82074edmr5633668plc.14.1698700666380; 
 Mon, 30 Oct 2023 14:17:46 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf2-20020a170903268200b001cc32261bdfsm4670350plb.38.2023.10.30.14.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:17:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 20/21] linux-user: Show vdso address in /proc/pid/maps
Date: Mon, 30 Oct 2023 14:17:26 -0700
Message-Id: <20231030211727.165090-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030211727.165090-1-richard.henderson@linaro.org>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h    | 1 +
 linux-user/elfload.c | 1 +
 linux-user/syscall.c | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 12f638336a..4de9ec783f 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -32,6 +32,7 @@ struct image_info {
         abi_ulong       brk;
         abi_ulong       start_stack;
         abi_ulong       stack_limit;
+        abi_ulong       vdso;
         abi_ulong       entry;
         abi_ulong       code_offset;
         abi_ulong       data_offset;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a1583883fa..46832358b0 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3919,6 +3919,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
     const VdsoImageInfo *vdso = vdso_image_info();
     if (vdso) {
         load_elf_vdso(&vdso_info, vdso);
+        info->vdso = vdso_info.load_bias;
     } else if (TARGET_ARCH_HAS_SIGTRAMP_PAGE) {
         abi_long tramp_page = target_mmap(0, TARGET_PAGE_SIZE,
                                           PROT_READ | PROT_WRITE,
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d49cd314a2..65ac3ac796 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7992,6 +7992,8 @@ static void open_self_maps_4(const struct open_self_maps_data *d,
         path = "[stack]";
     } else if (start == info->brk) {
         path = "[heap]";
+    } else if (start == info->vdso) {
+        path = "[vdso]";
     }
 
     /* Except null device (MAP_ANON), adjust offset for this fragment. */
-- 
2.34.1


