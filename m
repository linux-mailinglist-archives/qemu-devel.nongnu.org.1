Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CBB800E34
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 16:14:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r95Cr-000583-Ax; Fri, 01 Dec 2023 10:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r95CX-00052l-HA
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 10:13:09 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r95CS-00053c-3m
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 10:13:09 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40b538d5c4eso17076035e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 07:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701443580; x=1702048380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=57x23omuVrExXgPDfxrIdHt1R1VqyRD4qvLTNT8D6tI=;
 b=eIKZVJhUzGBzmdGVEfWRhAZe+jQQWaxG5pHOSFyZBZsRCqmD2hmxF/P96rprv+H+T2
 FBrlNtKQAfnMg6Il9UlW4V+kUHjdK63RrpYrPpjColwcyKqSJ16ie0H1OQYCyIYSy+IX
 JE3UbMYxhkxawEd14J/nSfWlxKjalrdyRe2g0wvVGqWQX9kVldW1pEUX2cWu/OS5fLsY
 ut0C7VEbpbNfKXTmqsdcZi0Sby65PD0RdtLs97ie2DwoilL/1FJYZZbZI6JSgg+r5bwX
 ZJjkS2H9RiC87Lm09mOu6B1/QU54guumXrEeUH+MSVJtAiEdyqxEgwpfnO2TsfLcePNs
 iv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701443580; x=1702048380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=57x23omuVrExXgPDfxrIdHt1R1VqyRD4qvLTNT8D6tI=;
 b=Xg2wNJbcV/1x1N8Pfg1m8VWXOfuue7XCKPAFA7/kg9LQOtZZwvL4JMz7R+m/u0DiOe
 YajROpmfEUUISacZ3Yk6zTAmWsvx99tBAtEBGznzjKJHNXBCelCvEtG6adWfqp3Q0neB
 SczBuGG3xePzlbflY0IeiZcRBYVUXKOuXuDm9FUJPi6ZbJTupddRlrWNDKYoXInAfc1Z
 E2shA3OeRcruDa7gi+I0WFKvrGPBCwovFTCHwvkzc9O59nuaQN2toOeRXCTmdy4uYjaZ
 by/k/nHUx31L4hxVk16ch94N8FecyLT7eecwG6SBkRICVC3n8uVUnJneHHVzenQlP/pA
 BRIA==
X-Gm-Message-State: AOJu0YxliCxYdmEQ4N9ldC1YESuYNdIy5FV956kqncmUKtIvvlfxPQxI
 FSCYA+carQJRETZEgbVJ+2HCfg==
X-Google-Smtp-Source: AGHT+IGG6uiBxj1FeOOcjK4MvU5HBQ+rVuiZEPQlv41LIbyZGclfq0hWmbiVzBK5Hrkssi5OBAEJ6Q==
X-Received: by 2002:adf:f48d:0:b0:333:2fd2:4add with SMTP id
 l13-20020adff48d000000b003332fd24addmr896006wro.89.1701443579792; 
 Fri, 01 Dec 2023 07:12:59 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v10-20020adfe4ca000000b00332f95ab451sm4390896wrm.58.2023.12.01.07.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 07:12:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 00BB45FB61;
 Fri,  1 Dec 2023 15:12:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Luis Machado <luis.machado@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/6] gdbstub: use a better signal when we halt for IO reasons
Date: Fri,  1 Dec 2023 15:12:23 +0000
Message-Id: <20231201151228.2610209-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231201151228.2610209-1-alex.bennee@linaro.org>
References: <20231201151228.2610209-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The gdb description GDB_SIGNAL_IO is "I/O possible" and by default gdb
will try and restart the guest, getting us nowhere. Report
GDB_SIGNAL_STOP instead which should at least halt the session at the
failure point.

Reviewed-by: Luis Machado <luis.machado@arm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231201093633.2551497-2-alex.bennee@linaro.org>

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 465c24b36e..5c0c725e54 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -24,6 +24,7 @@ enum {
     GDB_SIGNAL_TRAP = 5,
     GDB_SIGNAL_ABRT = 6,
     GDB_SIGNAL_ALRM = 14,
+    GDB_SIGNAL_STOP = 17,
     GDB_SIGNAL_IO = 23,
     GDB_SIGNAL_XCPU = 24,
     GDB_SIGNAL_UNKNOWN = 143
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 783ac140b9..83fd452800 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -183,7 +183,7 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
         break;
     case RUN_STATE_IO_ERROR:
         trace_gdbstub_hit_io_error();
-        ret = GDB_SIGNAL_IO;
+        ret = GDB_SIGNAL_STOP;
         break;
     case RUN_STATE_WATCHDOG:
         trace_gdbstub_hit_watchdog();
-- 
2.39.2


