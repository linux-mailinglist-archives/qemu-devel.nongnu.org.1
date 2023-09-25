Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A3F7ADA9C
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:51:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmtl-0001O7-Nk; Mon, 25 Sep 2023 10:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qkmtc-00014j-TB
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:49:13 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qkmtQ-0008Fj-Po
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:49:12 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3226b8de467so5266765f8f.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695653338; x=1696258138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iR1iGRTKQhM4i1nnnC3x69E8sH/nb//WSFW8YZTcQR4=;
 b=gTfmiDciHGcnHOh675FpFqs/r5NIxBNOqK82gDzZ5UuhEENXMMqJniNZwLO8fCI3yh
 8597T5mxVWpeQRWw7uLleJNXCBPh2/gDC14B/BOexxxMnzbbj+7eOTiU072hFpRDw8F+
 RVhPdE5wfZT/zamQZW+FIqukOgny3i5B5MN3Fae3q4YG4rVngkqsdleH0dKzVyli83/W
 YEAwU8latFZa+R/FuMirndy+xK8EDN8qM/20n0qS2DrE+go/ocdVpcQbaquL9CI1MQzn
 a3BTux1Y7afAPq+dw/P3F2Rh/kYHzwFhdHA9pgHcgwDYE0jlz7y9x3XB7r2EOCykf7q+
 suYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653338; x=1696258138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iR1iGRTKQhM4i1nnnC3x69E8sH/nb//WSFW8YZTcQR4=;
 b=Vq3n1xTXlk0qx9wglJI1XODI2zKHX0SvQAuaYXYG5WYC44QYIEAoe0fAqxywWbH/Di
 EgFW+mnso7j9O+4UsPfn/dfJsDShEcL0ZsieduKNGN5On0qx4+2jInTI2L//vI4XppFy
 1Tt/hkyfYnxwFHMHSX4ShhkQfDpOVzQXYUCSByroquXRMm16oSCpF1oP2Q94oroJZwLl
 cfYEs/3Q4lnhfXBQaT+Rfo4rzkbNrR1wr8RsUWfB6NEJIA+Kilh3YkEI6u7czeJG4jgZ
 Fjfoa6PrFM30Ua5EVWeJtHtma5S1f4HgDHbb/0fdJdRsUDJVxDWb5W5f1/zzEFpjoT1u
 aKrQ==
X-Gm-Message-State: AOJu0Yx72HLg2SUOMmb2ejClM8XlXYsHTMyZypMVyuw3bYfS7AHx3BwQ
 9CN9k7spSvZi4lBk16u76Go3cQ==
X-Google-Smtp-Source: AGHT+IHugUQ5tOq6CRzPkYCzsBd9E4Yy/hi2wf4KRfr4/Tz70/a43yWShtUDMYE1btwRst1FJhQGdw==
X-Received: by 2002:adf:eb84:0:b0:31f:bab8:a31a with SMTP id
 t4-20020adfeb84000000b0031fbab8a31amr5254791wrn.39.1695653337710; 
 Mon, 25 Sep 2023 07:48:57 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 bw10-20020a0560001f8a00b0032326908972sm3557423wrb.17.2023.09.25.07.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:48:57 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F3B991FFC2;
 Mon, 25 Sep 2023 15:48:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 John Snow <jsnow@redhat.com>, libvir-list@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Nicholas Piggin <npiggin@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bin.meng@windriver.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 08/31] configure: ensure dependency for cross-compile setup
Date: Mon, 25 Sep 2023 15:48:31 +0100
Message-Id: <20230925144854.1872513-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925144854.1872513-1-alex.bennee@linaro.org>
References: <20230925144854.1872513-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

If we update configure we should make sure we regenerate all the
compiler details. We should also ensure those details are upto date
before building the TCG tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure b/configure
index e83872571d..a95e0f5767 100755
--- a/configure
+++ b/configure
@@ -1788,6 +1788,8 @@ for target in $target_list; do
           echo "HOST_GDB_SUPPORTS_ARCH=y" >> "$config_target_mak"
       fi
 
+      echo "$config_target_mak: configure" >> Makefile.prereqs
+      echo "build-tcg-tests-$target: $config_target_mak" >> Makefile.prereqs
       echo "run-tcg-tests-$target: $qemu\$(EXESUF)" >> Makefile.prereqs
       tcg_tests_targets="$tcg_tests_targets $target"
   fi
-- 
2.39.2


