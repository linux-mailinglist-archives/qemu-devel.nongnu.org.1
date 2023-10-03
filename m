Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1345D7B7548
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:40:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovU-0004DU-Ft; Tue, 03 Oct 2023 19:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovS-0004DF-26
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:38 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovQ-0007PN-H8
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:37 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-79fa5d9f3a2so57655539f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376135; x=1696980935;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xbdd7u9NeVPCkT9yPQuY1ndY3BOt1BhLoy0Idqk3wZ0=;
 b=XFpoU95FBMaxl5vVpYbRYXCjGj+oiluW3ouUBElxZgNoIjv/42OoMtB4H/1ilc9C2B
 mGEAF6IypEUdmz57dSzsQtNavT9L7LlKC5iwcCwZCcA8dKivYcz/hzk2a8FZhnUPp/+o
 XfDGKmoyWisHxxfZN/fy3GupDAgCVNYHIrhRSjYENiJAhf5AlzU9pIB1kwogKiksmK5f
 H18TAf7li5V0EsnFGuwScE1bml47jLtXckNPs6eTdbhLd5J+lQctoKFDt6E95+nSxX5W
 VgPUezbODL15nFShLapgH2zklptzNoRyKRp8SkSNmzMXFQIZ7X2oK1U+yE+H79fsg/m/
 inBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376135; x=1696980935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xbdd7u9NeVPCkT9yPQuY1ndY3BOt1BhLoy0Idqk3wZ0=;
 b=YwQhzb3D0j/3Om34WefJP0ox85Fdi3jM4ToWRHXFi+OX0JNZED9GVNlj85covO25Po
 C/qs5TNcvSrmnb6353GhWiDXIIHsK7s935n5NxI7UpneU/s7mWN8x7hV0D9M0M5Bs/XY
 EIqGGf+MhAfCbGOXE4c6mHjQWOCEEV7L7+AN8ynu3gIsO3tjQXROKMd7h3zmwlH9vFyF
 UDTOSon1wODPgfqWbMUexo7CIWixlkX5T1/FTGh424o6XZDlgIXPm9+Y3+M1WSo2fcMJ
 9TYIXkzc8k5F0cOzPvKM/mT1V8HMijuVU2oqT7nLZgnMOGHPSS1RgfSeCO3MADh2Ivid
 K6Pw==
X-Gm-Message-State: AOJu0YxnRwqd/j7HCqMueGQOdf+HM9s/rMlp8KwhvhaXflBuMxpijQ4F
 BCXhEpouLJrwQ0f/GSa/HuyyttRsRCu1Twh9QA368w==
X-Google-Smtp-Source: AGHT+IFmSOg8VqZyhZRuh2gBPHeO8RkxjzjDX47q1Jnw4RUwOmgkh5K+xip80MGigalbqPujIAu7tA==
X-Received: by 2002:a05:6602:228a:b0:79f:a25b:51c with SMTP id
 d10-20020a056602228a00b0079fa25b051cmr969481iod.11.1696376135171; 
 Tue, 03 Oct 2023 16:35:35 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:34 -0700 (PDT)
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
Subject: [PULL 31/51] bsd-user: Declarations for ipc_perm and shmid_ds
 conversion functions
Date: Tue,  3 Oct 2023 17:31:55 -0600
Message-ID: <20231003233215.95557-32-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d36;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd36.google.com
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182709.4834-4-kariem.taha2.7@gmail.com>
---
 bsd-user/qemu-bsd.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
index b93a0b7fd5b..ffc64bb244a 100644
--- a/bsd-user/qemu-bsd.h
+++ b/bsd-user/qemu-bsd.h
@@ -22,6 +22,16 @@
 
 #include <sys/types.h>
 #include <sys/resource.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#include <sys/resource.h>
+#include <sys/sem.h>
+#include <sys/shm.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <sys/uuid.h>
+#include <sys/wait.h>
+#include <netinet/in.h>
 
 /* bsd-proc.c */
 int target_to_host_resource(int code);
@@ -35,4 +45,14 @@ int host_to_target_waitstatus(int status);
 void h2g_rusage(const struct rusage *rusage,
         struct target_freebsd_rusage *target_rusage);
 
+/* bsd-mem.c */
+void target_to_host_ipc_perm__locked(struct ipc_perm *host_ip,
+        struct target_ipc_perm *target_ip);
+void host_to_target_ipc_perm__locked(struct target_ipc_perm *target_ip,
+        struct ipc_perm *host_ip);
+abi_long target_to_host_shmid_ds(struct shmid_ds *host_sd,
+        abi_ulong target_addr);
+abi_long host_to_target_shmid_ds(abi_ulong target_addr,
+        struct shmid_ds *host_sd);
+
 #endif /* QEMU_BSD_H */
-- 
2.41.0


