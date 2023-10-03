Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6A97B6FDF
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:35:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjFF-00007m-Do; Tue, 03 Oct 2023 13:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjF9-0008VN-B4
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:35 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjF7-0007YD-Gv
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:35 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-692c70bc440so909263b3a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354292; x=1696959092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0DUsW3Z1l6kI6dnJslOCZY121JffUsDAYF90PScLnzY=;
 b=SwMY+qmiaRTzpt0RG7mDVi4F2iFMEng93XyR6BJI3cXubfBRuoOHETbFGp6dAAKXDr
 0dGJhO3OvhYtVEWHtpRd7V59pg6RQ8vHGadkdMrjkiUmSjFxOhGm5dw4VhnZk8nFrNSk
 xsO3oCGtSmlwA/5JBGaqKQ4gA0Bp6fkTfq7H3qIpo8oov3O1CzQpWA3nZmpSElFOXB2j
 L5B6dMh7fEtGBLl/Lgiwk3nKZlYXS/qrusqZ09kf1k3Rn3yT4GjPGPg+sWBsLGcL3mRg
 uxdEiKiIsR9dc6SKKrIO6mc0CBs79SZThkQycpbnoNzFeY+1X+/4OLkybhKumjdCaYCD
 04Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354292; x=1696959092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0DUsW3Z1l6kI6dnJslOCZY121JffUsDAYF90PScLnzY=;
 b=q839ajUu5pC4ClYFL+IzYVS3PFqPs2trQBJS7++iWaMWGrMzzcOsyxeKMpK4DEg4HX
 stylRnrq2Pp+WlJ/ruBTDaTfdHd372WSoVkL0e32uwHN8sTaNiBenJJfyGqArHj26gGj
 l+E2cgkJyjeAWznVWFtplm2gtP2j4TwZrFESUEtFY0wdNIuxxdRhO+4JAT76vD+ZaD4/
 tk9QGZEnFRVRcT6noCnE56VG1jyUa1t3p4575ajjyAjT5wnam8KaMMZDWUx/DXYbovCS
 6bV3YeUvsO0nNpvyCr07g16RcnaD3bqZsf/S8w0tRyP4jVoSjVVi7ks1G0eb9SPLWZad
 cBLA==
X-Gm-Message-State: AOJu0YxMke24p6/H3qecmZ4yM2iDYi2B91tw3Py9VrbvqbTqB0AJGUF4
 46qANhAyFBBM8H5nCJNG95T0DBpGT+EGPbyLSDk=
X-Google-Smtp-Source: AGHT+IHjB7k7+P9bxE1mw1xqk3RRbW0maUCCfXS0JP7xZcOvV0FjzUJOM3Rtdqo0mdUl0WkYDFiZDA==
X-Received: by 2002:a05:6a20:7485:b0:161:536d:a13b with SMTP id
 p5-20020a056a20748500b00161536da13bmr112772pzd.18.1696354292254; 
 Tue, 03 Oct 2023 10:31:32 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 35/47] accel: Rename accel-common.c -> accel-target.c
Date: Tue,  3 Oct 2023 10:30:40 -0700
Message-Id: <20231003173052.1601813-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We use the '-common.c' suffix for target agnostic units.
This file is target specific, rename it using the '-target'
suffix.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230914185718.76241-6-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/{accel-common.c => accel-target.c} | 0
 accel/meson.build                        | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename accel/{accel-common.c => accel-target.c} (100%)

diff --git a/accel/accel-common.c b/accel/accel-target.c
similarity index 100%
rename from accel/accel-common.c
rename to accel/accel-target.c
diff --git a/accel/meson.build b/accel/meson.build
index 76f3cbc530..fda3157a6e 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -1,4 +1,4 @@
-specific_ss.add(files('accel-common.c'))
+specific_ss.add(files('accel-target.c'))
 system_ss.add(files('accel-softmmu.c', 'accel-blocker.c'))
 user_ss.add(files('accel-user.c'))
 
-- 
2.34.1


