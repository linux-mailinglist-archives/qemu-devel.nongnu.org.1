Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9DC80BD84
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 23:09:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCRxX-0004z0-Ce; Sun, 10 Dec 2023 17:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rCRxU-0004yO-QM
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 17:07:32 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rCRxT-0004Zr-9D
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 17:07:32 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6d9f9fbfd11so1110660a34.2
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 14:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702246049; x=1702850849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Au4Krg4kZ7j5Ko4bh1XLXuCKSsJKJR37wN7Q6jKPnWE=;
 b=KDUKVVnd6RihfUX7JH+omPFvkmTqzpvaczrxf67HR8ecakX0zTd3sVwCdoieS76xNT
 DKskUIRnH5tb15JozMLmTcu8J/rojuvIdyBTfiWpFdTEj1C7ZCe8fAox7TJ7vALp9ZPY
 FKb3ECdqg+j9wsmOG6eDsv1bRaH0OfD9elLNnAThZDJl5lEfXdn+CWk4HVsfOvHpyhou
 /ruGy+/KpPeAt59xjvkypzZZwTEOpKORYxLS75vvM67K7z696CIUlKFnn6qh3xsQ9cPw
 yltuWV3xIzG3Qahy/KktLEFBvmCwNaMPre/CCSdmKj6wRg1rkyiuqj5GoW2IhMPIgbCW
 Dd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702246049; x=1702850849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Au4Krg4kZ7j5Ko4bh1XLXuCKSsJKJR37wN7Q6jKPnWE=;
 b=bPpS9XX5JLJ8bX0XVr+9wmyQFG63UpFpvwE1X0MUzEJGODUEfd880yiMhA3p62enAO
 paN3rpFAGfcJLvifqiJucivNEkjq+fKmj9emFEw/Wl/AfjPdpycGY00GezKf+Fapbfll
 NateHimpw77E2mpre4TmArp7jFGuYEA6PAa5H44rzmciOBcYPAvYcnop9kWjy3iYS2x+
 ssI0hF7feJgiW5JovtA2bnt0sP2NZHFzUBi5H0fO5U+PdGiwt+2Vrf8zlmtH3c4EbMHc
 OOlM0xbN1rME5fNlgcC0u57wuDw+/3jFo9pgRyzQIuyf22/T4ftqKz5GWp2bKbH9kv+s
 /liA==
X-Gm-Message-State: AOJu0Yy+LyHN1ING8k3TotzEHvMvSI83K/bFlqc010n8XGsrKouLeH3O
 d3pW/AoneW39b64xNq07LOuEAuHyhWi28A==
X-Google-Smtp-Source: AGHT+IEVlror291rUhEqZcLD6/FVYjg77fQq6b5PT0AEluEssnNvXLHhDeX6DZk8BfSjjsje8TUW3A==
X-Received: by 2002:a05:6830:1051:b0:6d9:db78:fe99 with SMTP id
 b17-20020a056830105100b006d9db78fe99mr2536319otp.35.1702246049411; 
 Sun, 10 Dec 2023 14:07:29 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 q23-20020a4a6c17000000b0058e200a9065sm1588173ooc.29.2023.12.10.14.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Dec 2023 14:07:28 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 9/9] Hexagon (target/hexagon) Remove dead functions from
 hex_common.py
Date: Sun, 10 Dec 2023 15:07:12 -0700
Message-Id: <20231210220712.491494-10-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231210220712.491494-1-ltaylorsimpson@gmail.com>
References: <20231210220712.491494-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

These functions are no longer used after making the generators
object oriented.

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/hex_common.py | 51 ------------------------------------
 1 file changed, 51 deletions(-)

diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index ca5e9630c1..195620c7ec 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -33,9 +33,6 @@
 overrides = {}  # tags with helper overrides
 idef_parser_enabled = {}  # tags enabled for idef-parser
 
-def bad_register(regtype, regid):
-    raise Exception(f"Bad register parse: regtype '{regtype}' regid '{regid}'")
-
 # We should do this as a hash for performance,
 # but to keep order let's keep it as a list.
 def uniquify(seq):
@@ -200,46 +197,6 @@ def get_tagimms():
     return dict(zip(tags, list(map(compute_tag_immediates, tags))))
 
 
-def is_pair(regid):
-    return len(regid) == 2
-
-
-def is_single(regid):
-    return len(regid) == 1
-
-
-def is_written(regid):
-    return regid[0] in "dexy"
-
-
-def is_writeonly(regid):
-    return regid[0] in "de"
-
-
-def is_read(regid):
-    return regid[0] in "stuvwxy"
-
-
-def is_readwrite(regid):
-    return regid[0] in "xy"
-
-
-def is_scalar_reg(regtype):
-    return regtype in "RPC"
-
-
-def is_hvx_reg(regtype):
-    return regtype in "VQ"
-
-
-def is_old_val(regtype, regid, tag):
-    return regtype + regid + "V" in semdict[tag]
-
-
-def is_new_val(regtype, regid, tag):
-    return regtype + regid + "N" in semdict[tag]
-
-
 def need_slot(tag):
     if (
         "A_CVI_SCATTER" not in attribdict[tag]
@@ -280,14 +237,6 @@ def skip_qemu_helper(tag):
     return tag in overrides.keys()
 
 
-def is_tmp_result(tag):
-    return "A_CVI_TMP" in attribdict[tag] or "A_CVI_TMP_DST" in attribdict[tag]
-
-
-def is_new_result(tag):
-    return "A_CVI_NEW" in attribdict[tag]
-
-
 def is_idef_parser_enabled(tag):
     return tag in idef_parser_enabled
 
-- 
2.34.1


