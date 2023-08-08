Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9303877410A
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:13:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDV-0001uK-9Y; Tue, 08 Aug 2023 13:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDI-0001IA-Uz
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:48 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDH-0003DB-3J
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:44 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-317715ec496so5099855f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514581; x=1692119381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UoDVrI+V/WeST7HHYmpphoZh47MLRk/ECXknUSo6bhk=;
 b=T/fYG6Y4W2Ft9oPC/PpjIiFRK3kZL89ISpu8NPdgjbK441poq9kzBZzwe1kkMoEARc
 V98hA+bup8UFoW+XbVmcGHCnjjZkVU2p/A78LEl2IIfWZnIuypgIt77qy3QkPzVxzBZE
 3KkuCHuqNRiuefQcfuwvUOMsFQFBFtAzsmiP/siSCXSdWNxq72u8f96bAX4oEarg56/+
 eWSTEh7B0kt/nGWSvgTSS2lhKbpKhuj4CcJmFqIOMbpJosoA8Lknpk2gsoi2GU3SQird
 FR8BujokQojut8ambPnnYeEFcQzZeJZEaKExByTxeVZR6Kvf9UkKVOPtIW2aQOsIJ3/6
 7K5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514581; x=1692119381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UoDVrI+V/WeST7HHYmpphoZh47MLRk/ECXknUSo6bhk=;
 b=XCuAnoMXirtuhHHL2nUweVigKpiJXlo39oU2TB1blKSIyanE0XTAV3td3JJXIK2L1G
 Vegi38n7uyGWCKBiSR7goqwjeaLHxJb15s0KAfGrwNOQaArjIXwcM1CCuw+4oa4b5+dZ
 BgOvMNBI8nVuXMfCNqnsnmrqDcRbZV1osOTylGTDIUozOBUXDqc08Gk1oRf1y3l8US6l
 y7lsu5JYu+KMBT77w4esWAjwL0RZ+gyjtZdi+RYMFSW3sKJM7sDz2aSiB2yziCguouvV
 zHFa36Iu4vTdGpDRcdfragFcIShACiXe2A/Fbb+tszAUTqbWsi/UusAEDxxTVDuW896C
 p66Q==
X-Gm-Message-State: AOJu0Yxfsl4yRLY9LjwBzXmgpiB9kc56hrgcxWFkkY8kN5+S7FYWNzRv
 spzKaeGUD0JqyO4DUe3R402czi1rTLRmww==
X-Google-Smtp-Source: AGHT+IFvn+ODGoDdIjyMoyTZjS26F/yaH4Ia2Bdkfw8IlWbRh3jszZxFCyd16SBlSkSPVvEOui/IbA==
X-Received: by 2002:adf:fe04:0:b0:314:3bd7:6a0c with SMTP id
 n4-20020adffe04000000b003143bd76a0cmr53804wrr.33.1691514580889; 
 Tue, 08 Aug 2023 10:09:40 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:09:40 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Kyle Evans <kevans@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 02/33] Disable clang warnings arising from bsd-user/qemu.h
Date: Tue,  8 Aug 2023 08:07:44 +0200
Message-Id: <20230808060815.9001-3-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x435.google.com
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

From: Kyle Evans <kevans@FreeBSD.org>

Implement PRAGMA_DISABLE_PACKED_WARNING and PRAGMA_REENABLE_PACKED_WARNING macros in bsd-user/qemu.h.

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/qemu.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index edf9602f9b..dfdfa8dd67 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -276,6 +276,37 @@ static inline bool access_ok(int type, abi_ulong addr, abi_ulong size)
  * These are usually used to access struct data members once the struct has been
  * locked - usually with lock_user_struct().
  */
+
+/*
+ * Tricky points:
+ * - Use __builtin_choose_expr to avoid type promotion from ?:,
+ * - Invalid sizes result in a compile time error stemming from
+ *   the fact that abort has no parameters.
+ * - It's easier to use the endian-specific unaligned load/store
+ *   functions than host-endian unaligned load/store plus tswapN.
+ * - The pragmas are necessary only to silence a clang false-positive
+ *   warning: see https://bugs.llvm.org/show_bug.cgi?id=39113 .
+ * - We have to disable -Wpragmas warnings to avoid a complaint about
+ *   an unknown warning type from older compilers that don't know about
+ *   -Waddress-of-packed-member.
+ * - gcc has bugs in its _Pragma() support in some versions, eg
+ *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83256 -- so we only
+ *   include the warning-suppression pragmas for clang
+ */
+#ifdef __clang__
+#define PRAGMA_DISABLE_PACKED_WARNING                                   \
+    _Pragma("GCC diagnostic push");                                     \
+    _Pragma("GCC diagnostic ignored \"-Wpragmas\"");                    \
+    _Pragma("GCC diagnostic ignored \"-Waddress-of-packed-member\"")
+
+#define PRAGMA_REENABLE_PACKED_WARNING          \
+    _Pragma("GCC diagnostic pop")
+
+#else
+#define PRAGMA_DISABLE_PACKED_WARNING
+#define PRAGMA_REENABLE_PACKED_WARNING
+#endif
+
 #define __put_user(x, hptr)\
 ({\
     int size = sizeof(*hptr);\
-- 
2.40.0


