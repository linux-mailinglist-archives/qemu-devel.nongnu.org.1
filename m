Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F6A7B86C1
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:41:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5jz-0003YG-Te; Wed, 04 Oct 2023 13:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5jy-0003WK-3R
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:32:54 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5jw-00012P-2F
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:32:53 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4056ce55e7eso375795e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696440769; x=1697045569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MGJIXDRJu9nRlkvT0HuUW6wiDMZ2EXW42Fkcow2Wmmc=;
 b=dAtVN/H72dd5veYTUlbJ78N8jmDPHy/V65XrqcC9foxksc1IWZHI+MuW3vZonXwRJ9
 U6zkUMdHm9ZH6/sLzvhVjs4rSLhnMf4LXNE1WPL+Hq/iaqySJ4J12o2Rsi1bwTXrVF9E
 R+oOk+vrhhVUvboaymYaOFYpuF4AaukL5lE+G9Mj7BUrBQYxZ8In7cflTmhuzfbZBWGp
 3FlimrnvVmMcAV7OI9AnJ6/oc24lGHTOxphfM3lPl1D3CK8A2i0MqW1lPXS0ySIZ3vU+
 6+6sFqYSrHxZkS5KRSFNvSTp6SXobHqXIO+xzg8RAgj/+y6zPS0LkakIepVQjY20/CdD
 /86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696440769; x=1697045569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MGJIXDRJu9nRlkvT0HuUW6wiDMZ2EXW42Fkcow2Wmmc=;
 b=Jh4bNjJD0daXZ4yFAaN5jv7/IaM1Nf5OsSwbKLk9DhNVju3aod73l8Senu1cl+bov4
 vYX4gihlUw7fPElzsxU+YwYMASKWHkoGaGhoUz0sPKLE0n9aARm3WdTmtXy987sTmJU0
 ruGuY9E4PA+Ze7tbSaWr32K4zHZymfWasQduUjW0/nVwdah+j6Snk/X0YOv0wX6f+TYR
 oVarfAz5dfm0d+VKLWKX7+p8j9HR+0MmXKt9A7bPcWjpX9tAyzE+Gx6ceZUAI7DRdYfN
 Os/bu/H+voR/Z//PZWZ97ixyD50soLQOgJ1uM5zVabYsAk0nYUgUE9yF1ejn+/LMd8/W
 GYIA==
X-Gm-Message-State: AOJu0YyUA7Bfvig4uMiTXhn+7YLR5km45NUskEDCdNZ0vrQyhVz+SZP4
 4vb8OJyJ4JTwSMrZdtYpHkSxyd7pXCvpkpzWklc=
X-Google-Smtp-Source: AGHT+IEbkOhMaEJy/rCsBI/FeDf+daJgpixyA4ZYMBpatjF919qpdEZDy8miCs2E+T3QGJpDEQrG9g==
X-Received: by 2002:a1c:4c13:0:b0:406:7d74:a29b with SMTP id
 z19-20020a1c4c13000000b004067d74a29bmr2907167wmf.13.1696440769157; 
 Wed, 04 Oct 2023 10:32:49 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 w21-20020a05600c015500b0040652e8ca13sm2011782wmm.43.2023.10.04.10.32.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 10:32:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 07/21] qapi: Inline QERR_INVALID_PARAMETER_TYPE definition
 (constant param)
Date: Wed,  4 Oct 2023 19:31:42 +0200
Message-ID: <20231004173158.42591-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004173158.42591-1-philmd@linaro.org>
References: <20231004173158.42591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Address the comment added in commit 4629ed1e98
("qerror: Finally unused, clean up"), from 2015:

  /*
   * These macros will go away, please don't use
   * in new code, and do not add new ones!
   */

Mechanical transformation using the following
coccinelle semantic patch:

    @match@
    expression errp;
    constant param;
    constant value;
    @@
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE, param, value);

    @script:python strformat depends on match@
    param << match.param;
    value << match.value;
    fixedfmt; // new var
    @@
    fixedfmt = f'"Invalid parameter type for \'{param[1:-1]}\', expected: {value[1:-1]}"'
    coccinelle.fixedfmt = cocci.make_ident(fixedfmt)

    @replace@
    expression match.errp;
    constant match.param;
    constant match.value;
    identifier strformat.fixedfmt;
    @@
    -    error_setg(errp, QERR_INVALID_PARAMETER_TYPE, param, value);
    +    error_setg(errp, fixedfmt);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/arm-qmp-cmds.c        | 3 ++-
 target/s390x/cpu_models_sysemu.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index b53d5efe13..3c99fd8222 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -154,7 +154,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     if (model->props) {
         qdict_in = qobject_to(QDict, model->props);
         if (!qdict_in) {
-            error_setg(errp, QERR_INVALID_PARAMETER_TYPE, "props", "dict");
+            error_setg(errp,
+                       "Invalid parameter type for 'props', expected: dict");
             return NULL;
         }
     }
diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
index 63981bf36b..4507714493 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_sysemu.c
@@ -111,7 +111,8 @@ static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
     if (info->props) {
         qdict = qobject_to(QDict, info->props);
         if (!qdict) {
-            error_setg(errp, QERR_INVALID_PARAMETER_TYPE, "props", "dict");
+            error_setg(errp,
+                       "Invalid parameter type for 'props', expected: dict");
             return;
         }
     }
-- 
2.41.0


