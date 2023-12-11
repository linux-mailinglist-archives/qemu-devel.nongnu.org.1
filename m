Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B2380C45B
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 10:21:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCcTJ-0000CW-1F; Mon, 11 Dec 2023 04:21:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcTG-0000C8-PP
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:21:03 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcTE-0005vH-DF
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:21:02 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40c38e292c8so11093435e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 01:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702286457; x=1702891257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSr3GvPnKq8aUa4IaKiJbjvKp2+Gjt/QBooUG8s8u+M=;
 b=xS2jIeZ0ahmKMgrtLAcBPxhDieYM6PBFQ3EeeJ4c4xWyYorUd9SEH/9X3Tw2Cr1cY6
 0chJuhXDj5v2jX1k8zXYIl0BM8qScaxoRSk9f1RgaHobrBfkCtF0guVHk+U62hwElqAU
 CYfApFhYBV3iAgaxUNpqaKyM8wQf9aQkwAPu6dkXScWJgLG3OvbHuU3eWoQU/RkaAUKa
 2uitxPfWehJn9l/G2OxhTdUSB8KbdUWXF2bd4UTzWCfrCrkKoQozIlcx8fMar5N6h/y9
 C2AkZWdUZDpPl9vecjRB5sQDcDYLBxSSMbJwkKBd7M9N1YYV0tToSFRKe174NrhXyMxX
 pmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702286457; x=1702891257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mSr3GvPnKq8aUa4IaKiJbjvKp2+Gjt/QBooUG8s8u+M=;
 b=Y8rrIYAAIjqrhCNQYWuVaeqgUp4QfVuWd0srqY3UZ63LlSXET0fxNswrpSsINfeKX5
 jXNtDTahO81TlMdOXrxCiUpgF9WGKazZlAzdf8VY1cNs4utpU0HMBIAqAWZrSREfvmLh
 3u2LVEvRwibO2yhw6iSmwfKqFQ9OhQAuXa98f7t36fQLa5OT5ha/qJSkutwUXR0PR5Xz
 X79bKQOMDWTwMEOiL9STz14wX9VpT9y9ds04Fz9zp+QB4Al9xHYlawJdW4R6NhSDh/17
 MzERybRIkKgpMt1q095eezwuXZR//1UYqc3HnoNj4JYMxg+dNQijUOSBkUMLE58gHOMN
 QTPA==
X-Gm-Message-State: AOJu0YwVAcNchEdH7di7URh+sMyNtkqcAbKWaAwfeanqAjOl4S5ur8jo
 4/4FOQOWHc3UcMDUx3HP2KNpHg==
X-Google-Smtp-Source: AGHT+IHF6eOIncoPqKfa9MwNZx43hnXJbBj2tSLUkeiOlagE6IX8N15DSWb0UkLX9zshcjX7vDXeQQ==
X-Received: by 2002:a05:600c:1819:b0:40b:5e4a:2367 with SMTP id
 n25-20020a05600c181900b0040b5e4a2367mr368882wmp.105.1702286457098; 
 Mon, 11 Dec 2023 01:20:57 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p1-20020a05600c1d8100b0040b47c69d08sm14638319wms.18.2023.12.11.01.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:20:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 55D7A5FBF6;
 Mon, 11 Dec 2023 09:13:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 14/16] accel/tcg: define tlb_fill as a trace point
Date: Mon, 11 Dec 2023 09:13:43 +0000
Message-Id: <20231211091346.14616-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211091346.14616-1-alex.bennee@linaro.org>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

While we do have a bunch of debugging we can turn on in cputlb there
is an argument for making tlb_fill a generally available trace point.
Any fault (via probe or access) will have to be preceded by a tlb_fill
for the address in question.

We don't bother logging the return address as that will be a host
address associated with translation and therefor can move around with
ASLR.

In my particular case I'm trying to track down a difference in memory
fault exception patterns between record and replay phases.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/cputlb.c     | 2 ++
 accel/tcg/trace-events | 1 +
 2 files changed, 3 insertions(+)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index db3f93fda9..c35df27caf 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1308,6 +1308,8 @@ static void tlb_fill(CPUState *cpu, vaddr addr, int size,
 {
     bool ok;
 
+    trace_tlb_fill(addr, size, access_type, mmu_idx);
+
     /*
      * This is not a probe, so only valid return is success; failure
      * should result in exception + longjmp to the cpu loop.
diff --git a/accel/tcg/trace-events b/accel/tcg/trace-events
index 4e9b450520..31dda01c12 100644
--- a/accel/tcg/trace-events
+++ b/accel/tcg/trace-events
@@ -9,6 +9,7 @@ exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=0x%x"
 # cputlb.c
 memory_notdirty_write_access(uint64_t vaddr, uint64_t ram_addr, unsigned size) "0x%" PRIx64 " ram_addr 0x%" PRIx64 " size %u"
 memory_notdirty_set_dirty(uint64_t vaddr) "0x%" PRIx64
+tlb_fill(uint64_t vaddr, int size, int access_type, int mmu_idx) "0x%" PRIx64 "/%d %d %d"
 
 # translate-all.c
 translate_block(void *tb, uintptr_t pc, const void *tb_code) "tb:%p, pc:0x%"PRIxPTR", tb_code:%p"
-- 
2.39.2


