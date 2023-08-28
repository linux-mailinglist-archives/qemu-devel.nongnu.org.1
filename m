Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C65DE78BBA3
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:43:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalrt-0003lG-UY; Mon, 28 Aug 2023 19:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrq-0003j9-PF
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:58 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalro-0006k6-HP
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:58 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-34deab8010dso761795ab.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266115; x=1693870915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WFs67P4F2+8DZwkOjNHRiidMV7RJJmR/6f17KsE7NYA=;
 b=M5r+DFuzYZqZw0r8/WF5CMRXccpHYygwQYlvL4hzG8+pb6S+mWXAYKxvhmUbomvH/A
 rsaWEVh0QYiE8jdndPATI77GS6ILc+yGvLiMX0T3IyvWN7/olHziXKVoPmcB/HwXvQ+2
 iLbu026MbyjiXxgGqrsNT8fURdXDZ+zvrCqfgD+Hb7C/9a/LTn7dCqTpZ/A95Xe1l7Oc
 OOlCW3Kf8dDMt5I7swRjX9F0p+Pb+/sLD7gNZqPA2uw5Rdi++CJvLzV8Kx5ILqpGijpK
 vSeaa1Uub4Metb1a4fiXtXpcyM5G7Ofnz0vnDXFrugGAEtgIZimxUYGFBiTnIWUSLCwy
 RdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266115; x=1693870915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WFs67P4F2+8DZwkOjNHRiidMV7RJJmR/6f17KsE7NYA=;
 b=EjjjItgfJLBX2N8naGXUftoCLTja4TBtvQ+yHzfxklHQXNjXF29Lfuxnu9NCXRP2Px
 /On46cUCEzbOoW16QC5dRndJYqnOHG9lUEhHERh4Qx3uyh4KQ360K8BimF49sXR6pz8x
 OX7To1EvNB1m75xcBQclqrBHbq7/JkGvMH7id/ztACs100H3PWirWBjNk10rd7RpbDGU
 dxN6Qvb/XapqFnrfrYVIeTyI32xZX+ILjeGGBMIJHAK9VT0T1ThGKLOrG80C8Q8D2DU2
 wqXvuv4XYUu607JfWAxejgXyqm78ojXAIr12Q+ibw7xYUOGf7gHIwz2sRoesSi6/BFN1
 faAw==
X-Gm-Message-State: AOJu0YyEStZDAKnteiZnnZLe7mH6jsDmtx3986MSSMCoaDXIpiBsBSrK
 nLEvqx4GrLGVFproPmbH4uMs+MMLuZKTSSXwbtA=
X-Google-Smtp-Source: AGHT+IHH8g609/B719CGmTKCHMgPKgnRQPkHzw7keKKtDapYRSDs8eaOUTYLIPCjdPnrStOLCtfvXQ==
X-Received: by 2002:a05:6e02:1b0d:b0:348:ba80:5a37 with SMTP id
 i13-20020a056e021b0d00b00348ba805a37mr21865958ilv.0.1693266114794; 
 Mon, 28 Aug 2023 16:41:54 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:54 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 18/36] bsd-user: Implement target_to_host_fcntl_cmd
Date: Mon, 28 Aug 2023 17:38:03 -0600
Message-ID: <20230828233821.43074-19-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12a;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x12a.google.com
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

Implement the stat conversion functions:
target_to_host_fcntl_cmd

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-stat.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.c b/bsd-user/freebsd/os-stat.c
index 9eb01bf6645..2ce235d5dae 100644
--- a/bsd-user/freebsd/os-stat.c
+++ b/bsd-user/freebsd/os-stat.c
@@ -170,3 +170,11 @@ abi_long h2t_freebsd11_statfs(abi_ulong target_addr,
     return 0;
 }
 
+/*
+ * fcntl cmd conversion
+ */
+abi_long target_to_host_fcntl_cmd(int cmd)
+{
+    return cmd;
+}
+
-- 
2.41.0


