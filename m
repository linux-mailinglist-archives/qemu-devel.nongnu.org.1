Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 329E87C9289
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 05:37:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrVRs-0007ZN-Kf; Fri, 13 Oct 2023 23:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrVRp-0007Yz-M5
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 23:36:17 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrVRo-00044H-0N
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 23:36:17 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6c62cb79b02so1734083a34.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 20:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697254573; x=1697859373;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LZCq9uzeYwtBUAXrydnBqoyPl0qovdL8Bo19xUHLIxI=;
 b=cgAXlpQ9yDqgfnbLmrx+BmCMREC5DSh5rf1N1ZQmjOyZduPz3cUjL9NdcC16LH9cd5
 ehUeETBiTkR2C03/mbjT1SLkgbWH4F8Qwb+EvMaeLmIuMsyVVCMrs3CAmPK3RVw11l6J
 CgPf3Wsdg0kthny+QC7cBZP/fxIWCEgMQDnOPfLvdB8VI6l2FrOSueiRtiyVupmyU87C
 /HZmybL3vVv0V3WL9sUdOk0DarL8oDeI5WZNlabpU3xn9+qAiQsdbdnKaNe2ZJGfH2ce
 F6ImCTx+3LWQhnAFasmJWsIPPmjQsMUk/5drW72UUZuuaJVdt40Y7qm5SMUGt1WHUoAD
 7SVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697254573; x=1697859373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LZCq9uzeYwtBUAXrydnBqoyPl0qovdL8Bo19xUHLIxI=;
 b=DpRrFLHNfaKdYijDcdYMfVEDMUsBcjWNwasfN2mKBXAauy/8ZebsUl04VRtxKbO/MB
 80qfMooM9GbblZX/VYY5uoLM8MzF0NApzuBSP63FimMgtrQCE9QfvtZQU8ql/ekRM0h9
 U7VYR13BF/pSnGund3nfUvwZzXDWLzy8ygilFzJ5FNIXt9uA1AqfGEIq3KiIrRBnmx0n
 GVA3JANtXhUogau2rS9yUuQuGTiGKv3LyY1zyM4e/9zwd83VyG7EBX5D2nTjpYktaWeZ
 maRBXNvgiem8zisXIjXC2kqVsvl7ODGmbkveTr2Dhdurfd47vCAgC2dpZzDxPo03RO+A
 OPxg==
X-Gm-Message-State: AOJu0YwjmJdfUQkLUfj5o+Zvh820RNlAzotmmRCHpwifQU/smNOt5vNj
 2TbWZfdm5PqltlP4hGCek2fTNw==
X-Google-Smtp-Source: AGHT+IHctyh8mj7/I1Z6+67TEGp0YCRkx32mCynnUmNQAFCZVRJeMi77ZzTi+PLtqwmWRUWTdhEuaA==
X-Received: by 2002:a05:6808:2897:b0:3af:d1d6:8a59 with SMTP id
 eu23-20020a056808289700b003afd1d68a59mr21000036oib.38.1697254573666; 
 Fri, 13 Oct 2023 20:36:13 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 v12-20020a17090a088c00b002774d7e2fefsm751059pjc.36.2023.10.13.20.36.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 20:36:13 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/3] gdbstub and TCG plugin improvements
Date: Sat, 14 Oct 2023 12:35:38 +0900
Message-ID: <20231014033545.15220-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This series extracts fixes and refactorings that can be applied
independently from "[PATCH v9 00/23] plugins: Allow to read registers".

The patch "target/riscv: Move MISA limits to class" was replaced with
patch "target/riscv: Move misa_mxl_max to class" since I found instances
may have different misa_ext_mask.

V1 -> V2:
  Added patch "target/riscv: Do not allow MXL_RV32 for TARGET_RISCV64".
  Added patch "target/riscv: Initialize gdb_core_xml_file only once".
  Dropped patch "target/riscv: Remove misa_mxl validation".
  Dropped patch "target/riscv: Move misa_mxl_max to class".
  Dropped patch "target/riscv: Validate misa_mxl_max only once".

Akihiko Odaki (3):
  target/riscv: Do not allow MXL_RV32 for TARGET_RISCV64
  target/riscv: Initialize gdb_core_xml_file only once
  plugins: Remove an extra parameter

 accel/tcg/plugin-gen.c     | 9 +++------
 target/riscv/cpu.c         | 5 +++++
 target/riscv/tcg/tcg-cpu.c | 7 ++-----
 3 files changed, 10 insertions(+), 11 deletions(-)

-- 
2.42.0


