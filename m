Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF08804451
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 02:54:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAKcu-0002tz-NJ; Mon, 04 Dec 2023 20:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rAKck-0002rt-Pg
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 20:53:23 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rAKci-000694-RK
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 20:53:22 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3b86f3cdca0so2821202b6e.3
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 17:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701741198; x=1702345998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZCrrnq1dgepTONr6iON1BdaxnQiffQjlgr8QvjnPmrc=;
 b=LHBjQPP45IfQgPsfh8U5pXyqIIIKhNNWxe+sppvDWtwudo0CT7u3DBRaahwHG4M28f
 CmGHqdQvzd1o4RM3t9JamXtocXPTY8o1UiRQqOwCsMkoIeBjQ1mP/989lsk1mGKkOGkt
 VW4J3P/ZMeWraJpKorC+cTgEoBv2f294zaCml9YuTKKC615gtgdfv8CYQOOe0uTooXke
 FMVWgzYao1cyWOtz+CYez203YT9rHqPDIo8W92GHXzo1wzT/TLW5L6LvNE4z40TZCQUX
 B5KkgBRlAbsFxv6QZE+bMsFMiwP2sfGFcdGoxEg5uIdTRAxHaBgORBhm14wvjTHrgDyI
 lBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701741198; x=1702345998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZCrrnq1dgepTONr6iON1BdaxnQiffQjlgr8QvjnPmrc=;
 b=cFihv5Irhw2sCe6DmCnuAV5Y8u2nIz8jjaCGUan1daHnBapaVL9cmU/iQGAwaYNgHt
 iqdAhw+MfXCqI36Wm0mG/JKoL7hQNcMShmpXaNRhWA4epCUZc9VhcXt8UYDXycu7vOq+
 GFYX6WRMKTKrIoSubmx/e1m05KV+74Cl8A2K/p07NgiYszBT9wx6S4RDfuF3eUGVdCK9
 pE532a3y3ElluUWJo5JJckyMYNRSt88e5oSFkGQxdy5a392/e62aOJoLnw0TH4Az4ECI
 smHWgz6WzIJB13cl95RmyQ8+74sDwRhB/8ABGI7hI5cOVQ20YS3LPkcQaaJ+RglzDiJE
 +sAw==
X-Gm-Message-State: AOJu0YwYCqkbyGiL3bJNJKtOElVwfIGGxrGlMGdpEF1RStcyeob2sq2t
 RgHsOF/0kj00l5nA3lzL+5dnxp9Guws+7A==
X-Google-Smtp-Source: AGHT+IF9u8jJmSo3tBmUzFyeRdsVHqAXi80Wu0iXekuYRIYlrTu+JtwjEV0wZtT6OEHvYEyqIEwC4g==
X-Received: by 2002:a05:6808:124c:b0:3b8:b063:8261 with SMTP id
 o12-20020a056808124c00b003b8b0638261mr6138550oiv.99.1701741198404; 
 Mon, 04 Dec 2023 17:53:18 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 c4-20020aca1c04000000b003b8b7063a44sm1064624oic.44.2023.12.04.17.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 17:53:18 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH 9/9] Hexagon (target/hexagon) Remove dead functions from
 hex_common.py
Date: Mon,  4 Dec 2023 18:53:03 -0700
Message-Id: <20231205015303.575807-10-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205015303.575807-1-ltaylorsimpson@gmail.com>
References: <20231205015303.575807-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x22d.google.com
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
index 59fed78ab0..90d61a1b16 100755
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


