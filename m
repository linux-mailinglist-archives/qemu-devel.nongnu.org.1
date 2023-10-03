Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7792B7B753C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:39:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovD-00041d-JS; Tue, 03 Oct 2023 19:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnov8-0003xN-Sm
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:18 -0400
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnov6-0006no-Nf
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:18 -0400
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7a26fd82847so59598839f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376115; x=1696980915;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hSOU5X81V46msYlqeKtgkBYQcLTO4MUKpgJ2TqbhBJ4=;
 b=Sd17vx6mPJnVDbhQGFe8veuqwKwUQlrnqBb9yTz5wHi7yBjZU7B+PkeBAQuvErZIon
 eLEG9j+DgotawFbgUCRXMXuL7D9P/gIB3xGf+2D4Q/EzMoR28zBnx0TrUmdmTYkM5/pw
 F6+VN2uRCwYDkCTjU6LUDMUcUWa7AIKGa2T42EmIwjNlcVvW+/hxrgdetaznkrY6VOjR
 6tEdh0V791yVZtNRHXkBjgmxHaOJdbg34XP8Z7veoNmTT+Cf2KaC6vI8VzV6IUF62F9d
 /MNoxp2NzR79Dz3pWupcrfvE2wmAGWMaffWbXfp3EIpBScgVR96DZFcbDhSeOUAdLSyV
 h1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376115; x=1696980915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hSOU5X81V46msYlqeKtgkBYQcLTO4MUKpgJ2TqbhBJ4=;
 b=MS4NCpIb9w5tTpmHrT9mokE3oFEE8wkq+mj8mOhBfcXJodtsD9vFrqeF6gB/rzcT85
 tX5y4KFqTfcYf2JDAFEUxqdaKLZEhNBNAweB9O5ayBZKrvYwSLuAl4hzUClizDkiAT4Y
 FxmctiDY7Dz4cylw7cXvaXm0E8xFDwxsY+Kgpva3i4Gm26/39tQTxmJ/1Gn4GjQGfC6E
 v0qW/s5KulqzJErT+leVSHxv2WhTraHfOo6R2py8s88YGNa9msNKzaKiyGalSswgXxsU
 cvNBwVykSNE4BXAsQjaZwzpFp3tb+cXJqNp7XszjFjg2hjmvDrLi/W+6FD1+DYvvdjL0
 heaQ==
X-Gm-Message-State: AOJu0YzU2SWqTMJPKaTgf+3UkdiHOpC7UMmsKF40pBKq7Xo6VZQK++BW
 cQEou5UGwaDWCEtnf7KBwKHdNGvSIopiyGCW2J8VfA==
X-Google-Smtp-Source: AGHT+IG5PNLmQyRmAMa1NbA085CROIItjB8d06zzgrt/o4J5y34IYtYFQAX1TH3vlmpjusYlwNLoiw==
X-Received: by 2002:a5d:9cd5:0:b0:79f:d4e6:5175 with SMTP id
 w21-20020a5d9cd5000000b0079fd4e65175mr981597iow.16.1696376115226; 
 Tue, 03 Oct 2023 16:35:15 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:14 -0700 (PDT)
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
Subject: [PULL 09/51] bsd-user: Implement host_to_target_waitstatus conversion.
Date: Tue,  3 Oct 2023 17:31:33 -0600
Message-ID: <20231003233215.95557-10-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2c;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2c.google.com
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
Message-Id: <20230925182425.3163-10-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-proc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
index aa386ff4820..19f6efe1f78 100644
--- a/bsd-user/bsd-proc.c
+++ b/bsd-user/bsd-proc.c
@@ -102,3 +102,20 @@ abi_long host_to_target_wrusage(abi_ulong target_addr,
     return 0;
 }
 
+/*
+ * wait status conversion.
+ *
+ * Map host to target signal numbers for the wait family of syscalls.
+ * Assume all other status bits are the same.
+ */
+int host_to_target_waitstatus(int status)
+{
+    if (WIFSIGNALED(status)) {
+        return host_to_target_signal(WTERMSIG(status)) | (status & ~0x7f);
+    }
+    if (WIFSTOPPED(status)) {
+        return (host_to_target_signal(WSTOPSIG(status)) << 8) | (status & 0xff);
+    }
+    return status;
+}
+
-- 
2.41.0


