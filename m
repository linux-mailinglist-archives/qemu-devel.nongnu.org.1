Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D94740055
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:08:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBE8-0000NA-Dg; Tue, 27 Jun 2023 12:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBDl-0000C5-0m
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:07:13 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBDe-00058m-TV
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:07:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbaa534dd4so4937165e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882025; x=1690474025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GnP8f96S0GKF3CO1A0jcmqKih6bOlzq38Er4YTCNWjo=;
 b=TL0E+q55wYUsZuGYCLCfc7mgnfjV0tH5Td/+n1VS6HjtjBln+9N8A1Cc6dqjihwWQ1
 gb4U5AjmrV0k7JdyvVF80Zi7wSetPmx1fbu8wbd5oFXSX7TXD+m81hb/q7SIi1xZNLzR
 6CPDxTg8cv/ITH1bbUqUAB/ph4nMHzkH/3YCKhvEW9J2tee4q/xs+p859V7s/EKgkGz9
 0zIm/f12gkP4auBjFiX22krKLBUF2G8s7vdoprP77WFqzwcjD4Iyanjt5IoheatKGilN
 ZZI/vAgogCL2/VVHjtexWL+7Kwm6AsAfdd5asELEoW6XvzNqa5Cab2WHDYeNANh7wTGr
 KpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882025; x=1690474025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GnP8f96S0GKF3CO1A0jcmqKih6bOlzq38Er4YTCNWjo=;
 b=ZJdQbM1kvYgnGAKgtMzq+Rtr34NWtIQ5z0oolZ2srwHR0VdN4q5SPTH7kE6rlbaKFm
 Em6qbIhJ6tON0cDJR8ve8yBxiA32PPNoP5/M1UyNhf1IK2/wg5+1oZeVczcaEVwBNe0p
 j1kDi6z/2gegv3OPqtxF6f40IATrFVVViqyQTvFsxiXE1R0L1xUCfq5Opymf9Bna/bld
 lxxD6T3j3nugnzFgrCCBKSRz9aQPXBuiYhVbe6USgmFui9ON1sJF+DK0BTAKBHvEqn2H
 noT4OLU7SaQW+npgqHOmyvIE+tJZu7yqV14y7ENb37iogEM2NYar2U5ACIRp2RyqDJk2
 0LfA==
X-Gm-Message-State: AC+VfDzXAYF4eBH8SullDjZ/sG0X+NocxgqhGCatfNn70J5GCMpu/Oqn
 Ue0wucDKpoeH9MiSOEAcF4XKjw==
X-Google-Smtp-Source: ACHHUZ6QbCnOO5NoHn4kCqg8Uk3MovSw4vhICQHVzADMT5Ngvi3x99k+sFp47VfP8eFP6oAa2dH1nA==
X-Received: by 2002:a05:600c:22c6:b0:3f9:b244:c294 with SMTP id
 6-20020a05600c22c600b003f9b244c294mr29213300wmg.35.1687882025130; 
 Tue, 27 Jun 2023 09:07:05 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v1-20020adfe281000000b00311299df211sm10835337wri.77.2023.06.27.09.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:07:03 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 89C7D1FFC2;
 Tue, 27 Jun 2023 17:07:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Leonardo Bras <leobras@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Bandan Das <bsd@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Juan Quintela <quintela@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v3 07/36] scripts/oss-fuzz: add a suppression for keymap
Date: Tue, 27 Jun 2023 17:06:31 +0100
Message-Id: <20230627160700.2955547-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160700.2955547-1-alex.bennee@linaro.org>
References: <20230627160700.2955547-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

When updating to the latest fedora the santizer found more leaks
inside xkbmap:

  FAILED: pc-bios/keymaps/ar
  /builds/stsquad/qemu/build-oss-fuzz/qemu-keymap -f pc-bios/keymaps/ar -l ara
  =================================================================
  ==3604==ERROR: LeakSanitizer: detected memory leaks
  Direct leak of 1424 byte(s) in 1 object(s) allocated from:
      #0 0x56316418ebec in __interceptor_calloc (/builds/stsquad/qemu/build-oss-fuzz/qemu-keymap+0x127bec) (BuildId: a2ad9da3190962acaa010fa8f44a9269f9081e1c)
      #1 0x7f60d4dc067e  (/lib64/libxkbcommon.so.0+0x1c67e) (BuildId: b243a34e4e58e6a30b93771c256268b114d34b80)
      #2 0x7f60d4dc2137 in xkb_keymap_new_from_names (/lib64/libxkbcommon.so.0+0x1e137) (BuildId: b243a34e4e58e6a30b93771c256268b114d34b80)
      #3 0x5631641ca50f in main /builds/stsquad/qemu/build-oss-fuzz/../qemu-keymap.c:215:11

and many more. As we can't do anything about the library add a
suppression to keep the CI going with what its meant to be doing.

Message-Id: <20230623122100.1640995-9-alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/oss-fuzz/lsan_suppressions.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/oss-fuzz/lsan_suppressions.txt b/scripts/oss-fuzz/lsan_suppressions.txt
index 02ec0a6ed5..7d90c280d0 100644
--- a/scripts/oss-fuzz/lsan_suppressions.txt
+++ b/scripts/oss-fuzz/lsan_suppressions.txt
@@ -1,2 +1,5 @@
 # The tcmalloc on Fedora37 confuses things
 leak:/lib64/libtcmalloc_minimal.so.4
+
+# libxkbcommon also leaks in qemu-keymap
+leak:/lib64/libxkbcommon.so.0
-- 
2.39.2


