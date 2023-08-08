Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C7B774129
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:15:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDy-0004jp-2W; Tue, 08 Aug 2023 13:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDu-0004TB-JB
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:22 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDs-0003sM-LG
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:22 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31768ce2e81so5105686f8f.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514619; x=1692119419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KspvY8FV5F74efJIOVU4WuAXYNKJQkrN6FRFbUmd84c=;
 b=JYSpgUYuZJSDAK+kT5AKzwsDcOWLGOv6axRDwyi9CJLrHyZe1sfQr5xxqxwYBuYrPS
 qMVI5O5V/IiLDMOX6HLQPm3KjzvTiIMgGKShZW1V8ZOivK6ir3YkApRBaU4V+UYDVJz4
 xi9Z/OXQAyqhF+L/D/+Yj9LTgCS8ZdTthZwAl/N7wP7/Tz5gDDHqzM301h2U2IE3Ri7V
 8Lrk3Lf9Fuc2aq56MW6+c8oM8M/XaT/zpoq1K1ms6Y6RZFDEmBJz0wz24WEjd12RAX2k
 klVw8hriqJno4ZlMwg41LWUtSbjHLuu4tfZBvxN+zNJXKa5fztIkISHna36S+riW3SbO
 Z8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514619; x=1692119419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KspvY8FV5F74efJIOVU4WuAXYNKJQkrN6FRFbUmd84c=;
 b=dzTydaeLF0pAzlj/tCkqrLggYJTixKYT/5nid1wSp8imKoeqp2gYHldLE5jRFVLbb5
 2ZKFctA26fdIYeoEfTwd0sJRndCXKBKnrK9FTUaToBCgLdJszymXXafpslfjpywyROxK
 fx4ZV1OHnwhVG5F1U1ehL22GzQXoSkcBTwvPSjJSiRMKHjRpH1UOHVLSp+4Rb5AR9xGb
 7Xqi0Z5cvxRujOsi6DnANMQekLPFqk0gxxMCNj3R5VnzFyKaYGHiJLmZbsR6QWJ3Slf3
 QmElEaw95UIrU1mPkQaO8iOvRXgxq9j9pi8uRNr5KoDTv4HBOb55uBke/2Pnlx8+tama
 IAyg==
X-Gm-Message-State: AOJu0YwSminKuBfFvXCBAG1uhb+fGZS7JHPY3FwXKeTkPdihytgk+urW
 aVNrM3S0jrAqYg5O/BETI2GqVocFDhbDTQ==
X-Google-Smtp-Source: AGHT+IExIg7Rjnf69/S9vB/yixph0s3j3PFjfBLdcS0f/Xb9lZqB7DAQ62wanb1k9Z0BP0V+8I1pdA==
X-Received: by 2002:a5d:4e07:0:b0:317:62c3:13a7 with SMTP id
 p7-20020a5d4e07000000b0031762c313a7mr70499wrt.19.1691514618896; 
 Tue, 08 Aug 2023 10:10:18 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:10:18 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 31/33] Add glue to call the following syscalls to the
 freebsd_syscall function:
Date: Tue,  8 Aug 2023 08:08:13 +0200
Message-Id: <20230808060815.9001-32-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
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

From: Warner Losh <imp@bsdimp.com>

getfh
lgetfh
fhopen
freebsd11_fhstat
freebsd11_fhstatfs
fhstat
fhstatfs

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-syscall.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index ade47a0d2f..73616a5be0 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -524,6 +524,34 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd11_nlstat(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_getfh: /* getfh(2) */
+        ret = do_freebsd_getfh(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_lgetfh: /* lgetfh(2) */
+        ret = do_freebsd_lgetfh(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fhopen: /* fhopen(2) */
+        ret = do_freebsd_fhopen(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fhstat: /* fhstat(2) */
+        ret = do_freebsd11_fhstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fhstat: /* fhstat(2) */
+        ret = do_freebsd_fhstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fhstatfs: /* fhstatfs(2) */
+        ret = do_freebsd11_fhstatfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fhstatfs: /* fhstatfs(2) */
+        ret = do_freebsd_fhstatfs(arg1, arg2);
+        break;
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.40.0


