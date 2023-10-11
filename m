Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 547DE7C5044
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:35:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWXG-0001WC-7h; Wed, 11 Oct 2023 06:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX7-0001L9-CD
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:41 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX4-0005CX-Bt
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:41 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50435a9f800so8699173e87.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697020415; x=1697625215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=djhZEY3GVFJ70rgdAPOhClTGynl2JirWDslytlqGvz0=;
 b=IPl3LF5imUJsZNRn2Ma50Jg4pGQ7CeDHIeBpik8ZOapCJsz/dVtpnRx4h26s0tdQ/n
 aUr8xI1981WTFEL41uYGWxABpRw4E8qyMzmpvuoNtAVI0i3Opk+aue451OEynA33kLnJ
 reFPQ9VGgqKHJysszapfcPEhjqS1tywDzRvN6G9NHp6R4KfCm+W0Oo9OMXSuLvzSLPV2
 X6yPqPpp88FxzpQmUiC3k/JkiIuKz0yOnWY9udGSwKOfs6R+lvFEe+ecEz/sRtFp9YBB
 ZB/J+2y8E/sA2eUGXGEnoqsxL50Nml4Hbk3UUk6O9/Sz7FKeIcmTOepMW/mm7ekF26L/
 /bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697020415; x=1697625215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=djhZEY3GVFJ70rgdAPOhClTGynl2JirWDslytlqGvz0=;
 b=oy/fA39E5IltSRTC8xqqoMUMztRMBq209V85hNQ0NqExQBIrc1ORUYMfT6gcsWUuCr
 oB5e3Ddz86xAal3FKubPKJKglzJQkosGc5SDr7m+yzwYMdGnodtKI/Tqr3+97oa+1LVk
 0EgB3swbO7c++sysTqb2VHEDYQG9TBhPjE6B8LdVBv9HxK2GtKywts2fmpALFuAgjyxO
 +8p5TWpdclRvFJGoFqk1ZMyBk4bUq29U87tVgTmiJuy1qn4bO9lFdjFZKSGeAnE/XdsT
 aHiBBVuF89QUUgIe/UES19R8ZWnXH7IuMOEUpIJuiEo/W2mxVHiEpZi6eQfVy7GLsxBC
 1B3A==
X-Gm-Message-State: AOJu0YxdXq35o6IxNUtkU1IQxmNKjfD8eMYSvUb+HTU5Uda0B9X6A4z8
 l3tXwG6mWkVo8DXEULlGVlHNjA==
X-Google-Smtp-Source: AGHT+IFNINSliDfuL1aE/pKafoZObvwTu7gqLcow+jp2mzWdMlvnB263JC63SR7R11jl9yOrVfYLuA==
X-Received: by 2002:a05:6512:2811:b0:503:257a:7f5d with SMTP id
 cf17-20020a056512281100b00503257a7f5dmr23356290lfb.31.1697020415348; 
 Wed, 11 Oct 2023 03:33:35 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a1c7909000000b00401b242e2e6sm18678477wme.47.2023.10.11.03.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:33:32 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 09FA31FFBC;
 Wed, 11 Oct 2023 11:33:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 08/25] gdbstub: Fix target_xml initialization
Date: Wed, 11 Oct 2023 11:33:12 +0100
Message-Id: <20231011103329.670525-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12e.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

target_xml is no longer a fixed-length array but a pointer to a
variable-length memory.

Fixes: 56e534bd11 ("gdbstub: refactor get_feature_xml")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230912224107.29669-2-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231009164104.369749-9-alex.bennee@linaro.org>

diff --git a/gdbstub/system.c b/gdbstub/system.c
index 189975b1d6..48976873d2 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -292,7 +292,7 @@ static int find_cpu_clusters(Object *child, void *opaque)
         assert(cluster->cluster_id != UINT32_MAX);
         process->pid = cluster->cluster_id + 1;
         process->attached = false;
-        process->target_xml[0] = '\0';
+        process->target_xml = NULL;
 
         return 0;
     }
-- 
2.39.2


