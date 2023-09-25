Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA257ADA9E
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:52:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmtl-0001Nb-Gy; Mon, 25 Sep 2023 10:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qkmth-0001DG-1D
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:49:17 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qkmtS-0008Ho-Qi
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:49:16 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4054f790190so49800785e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695653340; x=1696258140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cd4HdnbICWyITK5Y/4XhPzcPYvpQm5TBhsynKcdayLw=;
 b=eok3J2nNQVGkHlbMvu8/rmmNvL03GNnzO0/wLfpxZhzhVh/eHjV/0KgjNKWIQ4ysDl
 2LUHbrPAtl1zOK5YJ/pdl0n1oC2Jp/eye8mL++JVn5vCE2lciqMoeSxym1cR5rHnTpqo
 uzkqyLzEpXljHDavZ21Lrn/oW6Tr38aqzd5+epiOK0TSaYVWpLmoyTnaPbgGq+REc+eg
 zHan06QQYcdj5LZiA9hdtW09BWylX1FbT+gD4scTA1uQtEP7jW09iusDsMzr0jLGGA1g
 PjwEWSflTc4MYEAIPc0RSG5iSTnxilxgvv9VJETqLLJLPqiilmbNpbV7ehryoC0UctMS
 CNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653340; x=1696258140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cd4HdnbICWyITK5Y/4XhPzcPYvpQm5TBhsynKcdayLw=;
 b=IjO4k0rJBFbkigc5G7Uto12AXOXI0IJIG4abQYfolO5EMsh/SxbjoVtaAeCvwlSwlv
 rDxMiBUytauKd0IhCyGRreW5cbWQqHEJtDkr6a2dytKF97nq54qxvFWZ71akew8Hiksl
 5+J0MLu8904KOkO7MnJ0gKE++Zh+hhpDTRCDj35PkwwvV/ZWyEpLee/L/Ylbb90hb85S
 96cPfQWhA+/rvPIhsbbmTwdtPReTnFqASZefR6BSsmIgz7fz3iDGWEGyXU+2wC1EVsRz
 yZBmY6IwJ2npjnbehVodt56FX8/uVLKPxdnP7d74nlnvb+RBGBaBjU/z9u+/2CSqI3vd
 3H2w==
X-Gm-Message-State: AOJu0YxmHPu2PtbP81eITvrjZcUqZOvIkEeC+JOoMMYrKmhcIEhy2WQ5
 2GjETyt6Mx+aLDG0zbpy92Iwkw==
X-Google-Smtp-Source: AGHT+IGIMYocIaDoZ9eRM/8O33TiaHsL2YWIHMFN7tmlUnw5/PDkfYQxbIiSwyzvw88ck/ZVkroehQ==
X-Received: by 2002:a05:600c:230d:b0:404:6ed9:98d1 with SMTP id
 13-20020a05600c230d00b004046ed998d1mr6165003wmo.41.1695653340427; 
 Mon, 25 Sep 2023 07:49:00 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v19-20020adf8b53000000b0032318649b21sm6818394wra.31.2023.09.25.07.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:48:57 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8A5F61FFBF;
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
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>,
 Rabin Vincent <rabinv@axis.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Subject: [PATCH 04/31] docs: mark CRIS support as deprecated
Date: Mon, 25 Sep 2023 15:48:27 +0100
Message-Id: <20230925144854.1872513-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925144854.1872513-1-alex.bennee@linaro.org>
References: <20230925144854.1872513-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

This might be premature but while streamling the avocado tests I
realised the only tests we have are "check-tcg" ones. The aging
fedora-criss-cross image works well enough for developers but can't be
used in CI as we need supported build platforms to build QEMU.

Does this mean the writing is on the wall for this architecture?

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Rabin Vincent <rabinv@axis.com>
Cc: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 docs/about/deprecated.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index dc4da95329..7cfe313aa6 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -399,6 +399,17 @@ Specifying the iSCSI password in plain text on the command line using the
 used instead, to refer to a ``--object secret...`` instance that provides
 a password via a file, or encrypted.
 
+TCG CPUs
+--------
+
+CRIS CPU architecture (since 8.1)
+'''''''''''''''''''''''''''''''''
+
+The CRIS architecture was pulled from Linux in 4.17 and the compiler
+is no longer packaged in any distro making it harder to run the
+``check-tcg`` tests. Unless we can improve the testing situation there
+is a chance the code will bitrot without anyone noticing.
+
 Backwards compatibility
 -----------------------
 
-- 
2.39.2


