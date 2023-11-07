Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C94B97E3D51
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 13:27:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0LAw-0000Yf-NH; Tue, 07 Nov 2023 07:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0LA6-0007Eu-0y
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 07:26:30 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0L9v-0005KG-KF
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 07:26:29 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9d2d8343dc4so838417866b.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 04:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699359978; x=1699964778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G5jwu7f17a+yqtzy4C256uds7gVdP2jJyZeTSPjjH48=;
 b=mzdkjLFAtNlSHmxJWhBWOxnfd+bp2pQOClHzjs0mj/rdTVg4Ea7/LfIobDvBYYJCo9
 C9E4JaDH974mCL4duZb8BXCRyfnbUrQuNo8Z/+cVy5PfyT3zpIRCFuuZl2sVjLSEg+rF
 4/qzHmZe89N20Is8dyfZpgT4AH8b93WohCCkxXB4quzCzdWVbGPZBLPQiVMydEy2Gbn+
 t2ATShzJh8L4D6te8R0mrzkwUWLtTvuLOcrzRf1u7h7DpRPWcxnNL5Q7yAbsUSytGZ89
 v7xSmg8H4aYlip5PleiGnthU1lE24rbtl1mO9hJBuFdElnMp7h3xKzFEwa8B+EsOxZTB
 gF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699359978; x=1699964778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G5jwu7f17a+yqtzy4C256uds7gVdP2jJyZeTSPjjH48=;
 b=j4nC3zAuGhC+YGbpNpau4HfwFMUtr/XbSTtxBSOk/4gCau7EiTh2+ViHyJWS0Tk+sO
 ZCuS/tNclJAUYqGHcMDklHywY7Uuh7BQ3ZImrR7ku3NmStH8pqzTkIkxkMdC3ZIlaN3v
 VpEo9SdT5KvCwk+nFD0uJt7pqEyIyiq8H6ObnQhVdFQMErQU3us8/RSbNt5pUrabxIjc
 MgovWCPoKzeQdD3M9KQu1VlH3AHFEyXk0PlKyhk0hHgI+lmF4eDu+ierucebP0dcQc5j
 82LPr7jZno7WiMLlbBEehwyz2y6xFEaZ6V9cQfLxTfZvJTdEJiydHrZXx2c1FepCFcl3
 +bPA==
X-Gm-Message-State: AOJu0Ywbtil6k68gnjpAE7WVMl0I4whAICoUxfW/UNfMic4lkL5oHgHQ
 b1bFYckJjNIqZMb6AZeoxDL1nj+VRjB4DvQpdDk=
X-Google-Smtp-Source: AGHT+IF1bAmhsZy7a81GGB/OM2OIgpR0Z5xrK8Sglh0M+mSuV2WJ+N7GENwlcn1z45jcWBghWUvEBw==
X-Received: by 2002:a17:907:724e:b0:9be:5ab2:73c0 with SMTP id
 ds14-20020a170907724e00b009be5ab273c0mr16879801ejc.8.1699359977901; 
 Tue, 07 Nov 2023 04:26:17 -0800 (PST)
Received: from m1x-phil.lan ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 md5-20020a170906ae8500b009ad7fc17b2asm989795ejb.224.2023.11.07.04.26.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Nov 2023 04:26:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 73/75] MAINTAINERS: Add more guest-agent related files to the
 corresponding section
Date: Tue,  7 Nov 2023 13:24:40 +0100
Message-ID: <20231107122442.58674-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107122442.58674-1-philmd@linaro.org>
References: <20231107122442.58674-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

From: Thomas Huth <thuth@redhat.com>

contrib/systemd/qemu-guest-agent.service, tests/data/test-qga-config
and tests/data/test-qga-os-release belong to the guest agent, so make
sure that these files are covered here, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Message-ID: <20231107101811.14189-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a9354e695..bc69253a25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3145,10 +3145,11 @@ M: Michael Roth <michael.roth@amd.com>
 M: Konstantin Kostiuk <kkostiuk@redhat.com>
 S: Maintained
 F: qga/
+F: contrib/systemd/qemu-guest-agent.service
 F: docs/interop/qemu-ga.rst
 F: docs/interop/qemu-ga-ref.rst
 F: scripts/qemu-guest-agent/
-F: tests/unit/test-qga.c
+F: tests/*/test-qga*
 T: git https://github.com/mdroth/qemu.git qga
 
 QEMU Guest Agent Win32
-- 
2.41.0


