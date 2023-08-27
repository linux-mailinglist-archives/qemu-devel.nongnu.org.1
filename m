Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B3078B91C
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:11:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiYT-00083p-Nk; Mon, 28 Aug 2023 16:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYS-00083d-4J
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:09:44 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYP-0007KP-W4
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:09:43 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4ff09632194so5829453e87.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253380; x=1693858180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dbhAj08KImMbc5WgMU+hBPHTP5Ms6a+YvM+aYhMORU8=;
 b=La/9oz/c4RqUcF6ejn8c4GnWqJMVTQHvbQZxibT1WCREo9H0ubzq7wVw9AZg5XkaZ7
 CRNDZgRjiIoXSCbUuVq+dI59IWAi21foQhHXs6r1aRPUqow8hlsZbonkrVm8uxMJOPMX
 FDSBYyOVsBq8vLWL0jmHKcWJDxmy5GL7MCN1oT+JLH1vNVBwFwdyx3/ktUFZQJT1S/Nz
 DCWrZISgQm7NeA1XA1FMsdwBE813leHK26UfrHq+ksEL55gGp7mXYlTWWjXoZ003/c5z
 NJgqQ8SeGlLf3Q51a5GFPQqv1tOY/+8WqZCE/bVmJfpSHnagnvaVWm1ygkft8zcyrMx6
 nHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253380; x=1693858180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dbhAj08KImMbc5WgMU+hBPHTP5Ms6a+YvM+aYhMORU8=;
 b=UO90tP2UrZ6obw81TOj4kSWzyA1aW+/ScNvMHK9OFKxPD1dzw9VUGpIzCvaLvfmWOk
 dP4kkQBv9D7gwhqG8jnihsSr13gOM7PS2ecJytH/sEkBeVuiwCEujvM0yyxqZkeSjUUR
 9vP3nRsI/wE/z9jrns/P/lsQGsm/Qv8eQGkvRE5hA+nIV9z7rBIIcnXiNAz1PJDGzvzx
 cBK2LSaOJunGYRBF5jQsXOaM2L3iYQaOIDESQopQQvbqAQOBqURSM8l0grMlTUHLA+rP
 r6NHJw2Zh/j912fnktGxXb4tFniTLpj16t4AjlgGbMKPsLZyQ/6pYr6vqYSN5WA8w9XQ
 aDHQ==
X-Gm-Message-State: AOJu0YxlEqjvTwCGnrP4EbkDs5ycep0H1mHTbIT+XDUULesv6V0dSwOK
 KnHscMRWxM+SnIWiF9l5JV96asTMYEnGaw==
X-Google-Smtp-Source: AGHT+IEGsjyuXD+mOUef1EmG3IL1w8WwYC6SiGoWRcJTtRMMnLVyoY+u93xQnU6RX30XUfglTnt4sg==
X-Received: by 2002:ac2:4c07:0:b0:500:12c6:c915 with SMTP id
 t7-20020ac24c07000000b0050012c6c915mr16308664lfq.67.1693253379523; 
 Mon, 28 Aug 2023 13:09:39 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:09:39 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Kyle Evans <kevans@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 01/32] bsd-user: define TARGET_RFSPAWN for rfork to use
 vfork(2) semantics.
Date: Sun, 27 Aug 2023 17:57:15 +0200
Message-Id: <20230827155746.84781-2-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-lf1-x130.google.com
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

From: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/syscall_defs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index e4825f2662..daf7f5637e 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -179,6 +179,10 @@ struct target_freebsd__wrusage {
     struct target_freebsd_rusage wru_children;
 };
 
+/* sys/unistd.h */
+/* user: vfork(2) semantics, clear signals */
+#define TARGET_RFSPAWN (1U << 31)
+
 #define safe_syscall0(type, name) \
 type safe_##name(void) \
 { \
-- 
2.40.0


