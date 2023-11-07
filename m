Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAA57E3D83
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 13:29:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0LB0-0001FM-TL; Tue, 07 Nov 2023 07:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0L9z-0006sG-9M
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 07:26:23 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0L9s-0005Iw-6H
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 07:26:22 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9c53e8b7cf4so840227466b.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 04:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699359972; x=1699964772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qmG50O/2f50/2WgP2HPpZwiYXOel5yrYkpXTGRW5eAc=;
 b=YqDKViovIWaWNrSqs0vCDmYg1PEvUvvDip/VCoId1cERTIbMa4XR0RWxhVzZdjR3Ty
 +gFu49p3WcAIouwhKo7T9sDVjdpimbAvMkgnHzZFyOXuZLT8BqZzeQ3pz6IJUHqF0t54
 YzrfjgjoSpTQPPUu7TkrJhyTld4z/XEdiDWbHiOzys+ohKK+yLSuf56eDrFZP/22iTXh
 9u+aqpad2VMWFPcpqF/C3KRi59ftlgPoEbr9VIYP1Qeqf0sMdXMaveOqO716cgXj3Up+
 /jUDrz6B/vlGieQI1M8Ukf02J2SkTAOL1pFuiDz/WJi+6viybbwcmHHmb04lplI9h4AA
 1rQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699359972; x=1699964772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qmG50O/2f50/2WgP2HPpZwiYXOel5yrYkpXTGRW5eAc=;
 b=nUx8J7s9guC05RMaAIJhe1FhhKOGgKTQANjZm5XGj8ZjUj0Z/81jdloI2vaJZq5FLO
 ug6ghb57DxV7s7J/rZ0ihLVtB0I4HbYhpMSnbMrlHOmhU3DUNiR27fKUjJANDo1mXPfc
 UacwXW6blng4ZM8DrvJDDKQmQgUhDLDwNDlDzPaB4ip8/XW7ApgClHXINvEktjLZzpZ6
 Gr5OOWzRe6weI4GpcHwlHY8LOd4IRhGY0ceyWdUvsNfIF03Z6aSwozsUUwaI9866uRpM
 x7HsNmx2v6e1RjBw3NviLFm5rEzRK9FaFClDtTlfeQEH6JKyvvZ4F5gCSCo9Omf/PBNP
 U8pw==
X-Gm-Message-State: AOJu0YwVfUrq2jIReJqD2GNxE7ISUv1brp58rZVtYSx2YUogCu9QE/GH
 vbCNMyCFJMOenScteSK9Zzp2wusSnHYzr2H5L4w=
X-Google-Smtp-Source: AGHT+IFxWQrfEBcl5NXrCBGPBwPhcJoKBU53mNboU0c8IUkQBQXplWulnu+kXpy+b3L94b87BBhvNQ==
X-Received: by 2002:a17:907:934c:b0:9bf:b6f5:3a08 with SMTP id
 bv12-20020a170907934c00b009bfb6f53a08mr15984029ejc.52.1699359972231; 
 Tue, 07 Nov 2023 04:26:12 -0800 (PST)
Received: from m1x-phil.lan ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a170906168c00b0099cd1c0cb21sm972160ejd.129.2023.11.07.04.26.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Nov 2023 04:26:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 72/75] MAINTAINERS: Add include/hw/xtensa/mx_pic.h to the
 XTFPGA machine section
Date: Tue,  7 Nov 2023 13:24:39 +0100
Message-ID: <20231107122442.58674-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107122442.58674-1-philmd@linaro.org>
References: <20231107122442.58674-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

These machines are the only user of the mx_pic code, so the
header (which is currently "unmaintained" according to the
MAINTAINERS file) should be added to this section.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231107102104.14342-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a17decd31..2a9354e695 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1861,6 +1861,7 @@ M: Max Filippov <jcmvbkbc@gmail.com>
 S: Maintained
 F: hw/xtensa/xtfpga.c
 F: hw/net/opencores_eth.c
+F: include/hw/xtensa/mx_pic.h
 
 Devices
 -------
-- 
2.41.0


