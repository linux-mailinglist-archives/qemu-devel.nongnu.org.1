Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5870A7B756B
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:44:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnov8-0003wj-Hw; Tue, 03 Oct 2023 19:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnov5-0003vL-JN
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:15 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnov2-0006gd-4F
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:15 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-79fa416b7ffso60867739f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376109; x=1696980909;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u5huf7WpcMpMUeKt9etdLQ59Hm45g8cQi4QWAhrlxD0=;
 b=OzQdUBF4LXCL4QGdL4u2XDgWOQXOtMGJm7UOqTOJpVnUno1yFMXMYXIm5/2a3E4zYS
 7xy4yr7WFMBsm7VDybiJenBPGeUjXqyJdci1vGqzMH902/e1zEyNTFYJ+WI74h+UTah9
 8iNnve42P73nUllKDekReeR4IN5r448S6Kx523l43mEUoyocW/4Tg8oNAdM1WBe0qBqc
 ezpZS5a3ovjxUHypflSnDQH+empEgo0sz9yJvm5Oojs5rguThdRqmhJYLJxENmfbBBnc
 SsgN6kjNDkdWPfBauvvcgKCdH8pe7D/gvT31p+7/MjjpQDNbZ7KZEF5ZmNFXqY0YoWYB
 wqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376109; x=1696980909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u5huf7WpcMpMUeKt9etdLQ59Hm45g8cQi4QWAhrlxD0=;
 b=uUe0sS2uIdEWQQ1QdltsNjro20//pFO2GROBCFJ+83BzfqPYr7titjf73t10UdLAh6
 Dbm7xlLdrNd0aFMepozVHSLdV6tg+KO1C1yuxJaVh6+9hJwN7TQ/+3xLnkhGFVP8sJ0g
 atR17RRuY2pCgzEWgc4mW9nSN6YTChWlxsTr0RBkWuwKBEIAvPyEU8Ez9vrswBA2O78z
 F2MOmxBzgvdem0KxO+VmaXVqiWzzua96UOiKUmCdgkh5EhTsK3NIO/6KcWNKNtza1L9n
 q7hxSwy9eGkzH9fUCYeIJPN5BPIB3rfea+Nm+1mtYdagOTR5nFiB+31isprvrmfS0UEi
 twVg==
X-Gm-Message-State: AOJu0Yy/zrpfL9u2/WnItgbf6jU8ypqpx9uL/H7reevCLIW6dEGbCzBt
 yQmJ2K/1RTOqi0TBvdyH6tO67p37MT96pPiRS65umA==
X-Google-Smtp-Source: AGHT+IFUJ122Ie9NCheR/OEg3UPU2Ta3L2B6lAXRj7/VLZ6ONiYOkhGZdjY0WNruVgsDFLyYfsI94w==
X-Received: by 2002:a5e:8c0c:0:b0:795:16b8:85fc with SMTP id
 n12-20020a5e8c0c000000b0079516b885fcmr1004957ioj.0.1696376108730; 
 Tue, 03 Oct 2023 16:35:08 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:08 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/51] bsd-user: Define procctl(2) related structs
Date: Tue,  3 Oct 2023 17:31:26 -0600
Message-ID: <20231003233215.95557-3-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Implement procctl flags and related structs:
struct target_procctl_reaper_status
struct target_procctl_reaper_pidinfo
struct target_procctl_reaper_pids
struct target_procctl_reaper_kill

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182425.3163-3-kariem.taha2.7@gmail.com>
---
 bsd-user/syscall_defs.h | 42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index ddd38c13e08..a3bc738ff89 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -390,6 +390,48 @@ struct target_freebsd_flock {
 /* user: vfork(2) semantics, clear signals */
 #define TARGET_RFSPAWN (1U << 31)
 
+/*
+ * from sys/procctl.h
+ */
+#define TARGET_PROC_SPROTECT            1
+#define TARGET_PROC_REAP_ACQUIRE        2
+#define TARGET_PROC_REAP_RELEASE        3
+#define TARGET_PROC_REAP_STATUS         4
+#define TARGET_PROC_REAP_GETPIDS        5
+#define TARGET_PROC_REAP_KILL           6
+
+struct target_procctl_reaper_status {
+    uint32_t rs_flags;
+    uint32_t rs_children;
+    uint32_t rs_descendants;
+    uint32_t rs_reaper;
+    uint32_t rs_pid;
+    uint32_t rs_pad0[15];
+};
+
+struct target_procctl_reaper_pidinfo {
+    uint32_t pi_pid;
+    uint32_t pi_subtree;
+    uint32_t pi_flags;
+    uint32_t pi_pad0[15];
+};
+
+struct target_procctl_reaper_pids {
+    uint32_t rp_count;
+    uint32_t rp_pad0[15];
+    abi_ulong rp_pids;
+};
+
+struct target_procctl_reaper_kill {
+    int32_t  rk_sig;
+    uint32_t rk_flags;
+    uint32_t rk_subtree;
+    uint32_t rk_killed;
+    uint32_t rk_fpid;
+    uint32_t rk_pad0[15];
+};
+
+
 #define safe_syscall0(type, name) \
 type safe_##name(void) \
 { \
-- 
2.41.0


