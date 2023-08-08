Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5198C7740D0
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:11:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDT-0001g4-36; Tue, 08 Aug 2023 13:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDN-0001JP-4b
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:52 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDK-0003EA-Q2
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:48 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3110ab7110aso5151331f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514584; x=1692119384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dUXdjqhzsI3nw2PqVOgdvYv9H8Cx5wm1FMu37In2c7U=;
 b=UWNgC0qbGK6gLrmprRL+bndkm/Pd129MAmO70Mw3gpg/MXHstZDoS/5qAPaFltr//Z
 /TKLmcuekInpk5c0+ZKQ5CVirfPW042vU8mAI0XVfiUGkPnMQ8jBmqM/iXfSnA37yfVT
 9F+IftmAt2MCjl0rxJ+RRa+yeZkdjrXOc1iTO2KwDfLrHG71vkf9jiBYdIjurNaHqbwI
 ZN+uEIs+49pINKOzQUSPa43idPGJcIsRq1ul7IIx4AF5X3j/Mc5Q1brapEK7dlAUEHjy
 MZCNWCurg9DYn+tnFocQiaw4dDt/wMXEbt6cTioJQjqiWzjGO6xgBeAVcF/DgzDfG7pR
 lZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514584; x=1692119384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dUXdjqhzsI3nw2PqVOgdvYv9H8Cx5wm1FMu37In2c7U=;
 b=QBbCmmwEP5su/XGre3qxXFW9pDgMtMLUftM/rPUWK9t9ANRzZwdXKrquX+SEfF/FjQ
 0+WgiYcbLrp6PerbWyA+6YAelN4+rps/Fk/YsbP/je2J8OqnxuPOFI0SO3fQCCQQtsDp
 12EBrtxFaRe0rda3oo0V+2tq/MaHX5Zrpk88OkJ6d7I6N7QbLUpQygQbTgr9cAmBvsRD
 FHoCvi2PlKXtcxV+hxm1pWxv+gcP+Z2EQGRbPXnPt1BldaRbUA6/7PpDqgMPdX0UocOm
 EkYBL+B43QwHB96r/zbwJkzozaINi7eNehT/rPVkYg68zr0SHz7FW4OFaNBuWsXhyw96
 tcfQ==
X-Gm-Message-State: AOJu0YyW1wMW0UiAxyjeTrmappa+RGQfEboN+nCfg6tfCi+Cv0Z4EXou
 Y01EX4Ud8D4Wpl3215C/yWq0YYjCSv0lMQ==
X-Google-Smtp-Source: AGHT+IFqGpLGMHRia1wdTUcu0cf9oxtpbOv2hA9mKRXppptpPQKOjsctNfp1FhQ7nxpIDXKA7v3EIA==
X-Received: by 2002:a5d:668d:0:b0:314:1aed:8f5f with SMTP id
 l13-20020a5d668d000000b003141aed8f5fmr51491wru.34.1691514584150; 
 Tue, 08 Aug 2023 10:09:44 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:09:43 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 05/33] Forward declare functions defined in os-stat.c
Date: Tue,  8 Aug 2023 08:07:47 +0200
Message-Id: <20230808060815.9001-6-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x431.google.com
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

From: Michal Meloun <mmel@FreeBSD.org>

Add to bsd-user/freebsd/qemu-os.h the forward declarations
of conversion functions related to stat syscalls.

Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/qemu-os.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/bsd-user/freebsd/qemu-os.h b/bsd-user/freebsd/qemu-os.h
index 7ef4c55350..12adc50928 100644
--- a/bsd-user/freebsd/qemu-os.h
+++ b/bsd-user/freebsd/qemu-os.h
@@ -32,4 +32,19 @@
 
 struct freebsd11_stat;
 
+/* os-stat.c */
+abi_long h2t_freebsd11_stat(abi_ulong target_addr,
+        struct freebsd11_stat *host_st);
+abi_long h2t_freebsd11_nstat(abi_ulong target_addr,
+        struct freebsd11_stat *host_st);
+abi_long t2h_freebsd_fhandle(fhandle_t *host_fh, abi_ulong target_addr);
+abi_long h2t_freebsd_fhandle(abi_ulong target_addr, fhandle_t *host_fh);
+abi_long h2t_freebsd11_statfs(abi_ulong target_addr,
+    struct freebsd11_statfs *host_statfs);
+abi_long target_to_host_fcntl_cmd(int cmd);
+abi_long h2t_freebsd_stat(abi_ulong target_addr,
+        struct stat *host_st);
+abi_long h2t_freebsd_statfs(abi_ulong target_addr,
+    struct statfs *host_statfs);
+
 #endif /* QEMU_OS_H */
-- 
2.40.0


