Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 982837EB6E2
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 20:28:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2z3x-0003tl-9p; Tue, 14 Nov 2023 14:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2z3v-0003st-5N
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 14:27:03 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2z3t-00070Z-4b
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 14:27:02 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-565334377d0so4707674a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 11:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699990019; x=1700594819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JLKWYDsjkvpifTsfNAx+wzg8HUX4emgmt/2POiSK9Os=;
 b=IrUj1vtl3lydx3pquErtIpRxF5qV9ufMkAsoWDpwfY9y4Z/aKDvNN3QHIGDNeQ2iIn
 gHr5zCzkVB1uRY8meJDJvWZMfu0THZk4PivtvC5kD2XvLW28oBoqJ1Fm+44PSdr3sR3T
 aUHZzh0ENKEcj1r4ze0beBH/ciK7uUBtqDJTW/ugn7UmJvh/SdQgS8kQGvvbeM5hZTCY
 eIFx9aGApo0poHDo/qMhc9lQ8cJBXoGEfsywh+sjA+/wsAGl39IQRFqip0ix7sBGxejX
 Ielt4iQJsnESeIKouWmE6OYm672zs5cmYtL5Ol+0yg63gGPcBl+Vr8sd1+LYdUN6CUhz
 8Ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699990019; x=1700594819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JLKWYDsjkvpifTsfNAx+wzg8HUX4emgmt/2POiSK9Os=;
 b=jmH+laqxZGUTFfx5CX8BHGdeylZzQ5nv+xkW7LCA4jyrwF7q7trTjdKbrOkSbtxYRK
 Okz1O73Pe63prhhB0+CXmFIdYXUVW1X/RayhCB+q8ppwuNvUi4z2+Z/usM99CwnJXCoU
 GhBsD8VG+HxmjkdsTUvxEw+t+jlAs6sdf5bPN590o9MLXgpYYPRid1jrw+jOlE5zc4IF
 MBuLc7G5lfc+iX3T1DpqQJa6T9C4LGt/LFzWzxzEYEbB89CnycIdgBqO2JLbe+zpQWCB
 g86v/JkNpU6g6/4h/2yWzO/gIbkZsjJ7Zvkbe7pyCEK8eSRVLynumFoEK5/aaJHtsRjB
 wu5Q==
X-Gm-Message-State: AOJu0YwtLdcUh5nypOnK+n8EZ8u9rAJNsaxV+RfHplgs9k7L4ETaMawy
 e21K1rmJDrzpit+kzX4Zr4V7OLJlwqKdp8qw5SE=
X-Google-Smtp-Source: AGHT+IFcVkJkDAbpWNkyJdSaHiohgPVk/R7Z0L2HQbaREh5LYfeUA7IzEp4KTTUod4i/dpXraWC2Tw==
X-Received: by 2002:a17:902:6b88:b0:1cc:2eda:bde8 with SMTP id
 p8-20020a1709026b8800b001cc2edabde8mr3228989plk.24.1699990019599; 
 Tue, 14 Nov 2023 11:26:59 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j18-20020a170902c3d200b001c728609574sm6052643plj.6.2023.11.14.11.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 11:26:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PULL 2/3] accel/tcg: Forward probe size on to notdirty_write
Date: Tue, 14 Nov 2023 11:26:55 -0800
Message-Id: <20231114192656.176451-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114192656.176451-1-richard.henderson@linaro.org>
References: <20231114192656.176451-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

From: Jessica Clarke <jrtc27@jrtc27.com>

Without this, we just dirty a single byte, and so if the caller writes
more than one byte to the host memory then we won't have invalidated any
translation blocks that start after the first byte and overlap those
writes. In particular, AArch64's DC ZVA implementation uses probe_access
(via probe_write), and so we don't invalidate the entire block, only the
TB overlapping the first byte (and, in the unusual case an unaligned VA
is given to the instruction, we also probe that specific address in
order to get the right VA reported on an exception, so will invalidate a
TB overlapping that address too). Since our IC IVAU implementation is a
no-op for system emulation that relies on the softmmu already having
detected self-modifying code via this mechanism, this means we have
observably wrong behaviour when jumping to code that has been DC ZVA'ed.
In practice this is an unusual thing for software to do, as in reality
the OS will DC ZVA the page and the application will go and write actual
instructions to it that aren't UDF #0, but you can write a test that
clearly shows the faulty behaviour.

For functions other than probe_access it's not clear what size to use
when 0 is passed in. Arguably a size of 0 shouldn't dirty at all, since
if you want to actually write then you should pass in a real size, but I
have conservatively kept the implementation as dirtying the first byte
in that case so as to avoid breaking any assumptions about that
behaviour.

Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
Message-Id: <20231104031232.3246614-1-jrtc27@jrtc27.com>
[rth: Move the dirtysize computation next to notdirty_write.]
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 765805e70b..db3f93fda9 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1479,7 +1479,8 @@ int probe_access_full(CPUArchState *env, vaddr addr, int size,
 
     /* Handle clean RAM pages.  */
     if (unlikely(flags & TLB_NOTDIRTY)) {
-        notdirty_write(env_cpu(env), addr, 1, *pfull, retaddr);
+        int dirtysize = size == 0 ? 1 : size;
+        notdirty_write(env_cpu(env), addr, dirtysize, *pfull, retaddr);
         flags &= ~TLB_NOTDIRTY;
     }
 
@@ -1502,7 +1503,8 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
 
     /* Handle clean RAM pages.  */
     if (unlikely(flags & TLB_NOTDIRTY)) {
-        notdirty_write(env_cpu(env), addr, 1, *pfull, 0);
+        int dirtysize = size == 0 ? 1 : size;
+        notdirty_write(env_cpu(env), addr, dirtysize, *pfull, 0);
         flags &= ~TLB_NOTDIRTY;
     }
 
@@ -1524,7 +1526,8 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
 
     /* Handle clean RAM pages. */
     if (unlikely(flags & TLB_NOTDIRTY)) {
-        notdirty_write(env_cpu(env), addr, 1, full, retaddr);
+        int dirtysize = size == 0 ? 1 : size;
+        notdirty_write(env_cpu(env), addr, dirtysize, full, retaddr);
         flags &= ~TLB_NOTDIRTY;
     }
 
@@ -1560,7 +1563,7 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
 
         /* Handle clean RAM pages.  */
         if (flags & TLB_NOTDIRTY) {
-            notdirty_write(env_cpu(env), addr, 1, full, retaddr);
+            notdirty_write(env_cpu(env), addr, size, full, retaddr);
         }
     }
 
-- 
2.34.1


