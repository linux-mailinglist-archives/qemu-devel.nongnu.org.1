Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 600987B7EA8
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:06:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0b7-00036E-Le; Wed, 04 Oct 2023 08:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0ZK-0000Pb-6G
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:01:37 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0ZI-00017M-21
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:01:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-406650da82bso19153275e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696420890; x=1697025690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9QTZPnGa7dzlAxYI3K0r+uL7KCteU3g2TmxdKpGNVN0=;
 b=AFm0zfRDJoWdXeEUqHwgxSFITCWXs1/nS40U2pGSA1YbQoX5FKNnYF/gJH4J+463hC
 W1nFq05MjC1BebyLaMGtEVb+JSvpspdr+ZRy/D0dtZWgSBNHJfoNrEdGjeHV70/Rozi0
 rFeHWPbUZe91ubilp6d9Dy05yL6I3UToJc/EUJZtbiVA0U3KNIba6nWK3Y0hGIUoSO5d
 TEiSqodx2koWjfLNuIpMA1fdZsKmKmacMPY2nPegfYJ9YU/rg+FdJmi919LKZk/tJKj+
 o6p2kuht2u/W0+UsHdeZbhoxDMePN5Jc/m4RmPCqSFUaNdIS9/dce8+CXbRWeTn8DOSw
 pA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696420890; x=1697025690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9QTZPnGa7dzlAxYI3K0r+uL7KCteU3g2TmxdKpGNVN0=;
 b=qRsCYd8I1Qjy8lM7NVEIeoWG85fsdh70OrqKUIZBeWrcALKiywuaptJTb55aZE2XoF
 Q/gaPXw7WaMMIWeqmjj34PaWbM4NVHFBJ8LYJ42OWKL5Q0yUnYhwB/DxA1bBmsKYmNqf
 0ncnqTXTdZdFOuDvRH33EPkBlMz2VRKvxRlR9PonsmSY/Ly3DTDKCKv+jl/g/sSIta28
 Q4VszlbRm6F5HezoVV+5FTqCYO/DOgzw1cXkRYixS7I8hSCsmcXqrWYjv2RKvnhwSpmM
 MdeW8WvDQHwtCbrV0BQ/uhrPkVlGctrer+2PIqOSbMM0vUKGOmHbZUJAUWHto4uYUgKN
 Y2dg==
X-Gm-Message-State: AOJu0YxKJ2ikRFRjOcAu2D78yaMwbiGQF8tFNBoncMOgv82FALFdEySY
 MnjAtdCJqRyfm9D2mMId4EjYUNz0CRCFZPrUGDg=
X-Google-Smtp-Source: AGHT+IFgZJVdmWW1rDVNPvd43g/WPuP39kPXM7D50nGRVd8lRFQ08yURJeYc0kn2TT47yqcmSnKBmA==
X-Received: by 2002:a1c:7209:0:b0:405:a30:151e with SMTP id
 n9-20020a1c7209000000b004050a30151emr2290577wmc.12.1696420889413; 
 Wed, 04 Oct 2023 05:01:29 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 e16-20020a056000121000b00324853fc8adsm3838124wrx.104.2023.10.04.05.01.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 05:01:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 11/16] util/cutils: Clean up global variable shadowing in
 get_relocated_path()
Date: Wed,  4 Oct 2023 14:00:14 +0200
Message-ID: <20231004120019.93101-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004120019.93101-1-philmd@linaro.org>
References: <20231004120019.93101-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Fix:

  util/cutils.c:1147:17: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
      const char *exec_dir = qemu_get_exec_dir();
                  ^
  util/cutils.c:1035:20: note: previous declaration is here
  static const char *exec_dir;
                     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 util/cutils.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/util/cutils.c b/util/cutils.c
index 25373198ad..b44718a6a2 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -1144,7 +1144,6 @@ char *get_relocated_path(const char *dir)
 {
     size_t prefix_len = strlen(CONFIG_PREFIX);
     const char *bindir = CONFIG_BINDIR;
-    const char *exec_dir = qemu_get_exec_dir();
     GString *result;
     int len_dir, len_bindir;
 
-- 
2.41.0


