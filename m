Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D76F37C64B2
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 07:43:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqoTB-00037K-7p; Thu, 12 Oct 2023 01:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqoT8-000376-Lb
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 01:42:47 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqoT6-0005SJ-MS
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 01:42:46 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-27d0a173e61so440693a91.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 22:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697089363; x=1697694163;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YkXaH78PMb/y1UApbzY60+8C/VVaLSCmXjiHRLeSeQI=;
 b=b0l6wbb3/sBgmtj3z1pCaoep0wIQ/CMmmSJcBA/9nuuGiEB0t7OXBW63abpscPCpcQ
 lU+/VuM7KIEcjSUp0LB0+t0QVPezakFXqKrUolcOuykDFDr50RtHk+LIfyM+zYR9bpGF
 rr93wLWgm1E3svK79ZkQyqflW7jW/frSE2IlrddYyHTHIhhc1ikzIM1KkjOpo8HVco8z
 BH2RmFYIhD0w5ip09Ba9j700KWwn0WCM90V3bQAMq0IXFLwGTeOgTaDZJ9S7F2iYWMAn
 R/dUoSkI0Di1jJsil4reW8Huu7itHduFdaqTk4OCPgislzApv372jFB/dZkoj/28Zq20
 b6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697089363; x=1697694163;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YkXaH78PMb/y1UApbzY60+8C/VVaLSCmXjiHRLeSeQI=;
 b=gC0RYCPmjEbm3bspE13ppZuAXxhcGoy4l/eiTu0UMEqhK4lhr73IVt+UUIwFN9wOKy
 1FVDJV2mOil6WrXaA14dV72Y/C6UD1mJj69RPcbV8TLfqyaolgNEW4hBQA0j3654TQcc
 2JS7en/9qTjtyYVQG2Cdiz84AD0psqUOP57MEMK3SPoxF3IRK0wEXQKJFiCouUlh9Ji2
 jBjfQxrlNwoqJVzasolCz1EOdSkPLl71M+5xsSt+rdIIzGIRvyhC7Nr9SS7FXVHZkSMZ
 YCNAgT/KZCAKuvrPIQs6jMMYbqRpxH+QcyzHnTh3UODAQ4DAZWLVcwr/iIbSsGQO3wi+
 W7hg==
X-Gm-Message-State: AOJu0YyvHfl9/H66dJnZeqL/wLgTGgyc0JvDahq8palwPIanEJ5l13U3
 yPBaHIhNok+qIP37N6nCimbDgg==
X-Google-Smtp-Source: AGHT+IHNRiomPLBaoI2WQghUs0zAunOUFVOGyIc015Tf1BEZ+89ozTj2FJ2uDY+XByNpQfdgUWZInw==
X-Received: by 2002:a17:90a:ce04:b0:27d:dc9:be7a with SMTP id
 f4-20020a17090ace0400b0027d0dc9be7amr2763874pju.7.1697089363163; 
 Wed, 11 Oct 2023 22:42:43 -0700 (PDT)
Received: from localhost ([157.82.206.10]) by smtp.gmail.com with UTF8SMTPSA id
 6-20020a17090a1a0600b0027cfb5f010dsm1037779pjk.4.2023.10.11.22.42.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 22:42:42 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/4] gdbstub and TCG plugin improvements
Date: Thu, 12 Oct 2023 14:42:15 +0900
Message-ID: <20231012054223.37870-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102a.google.com
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

Akihiko Odaki (4):
  target/riscv: Remove misa_mxl validation
  target/riscv: Move misa_mxl_max to class
  target/riscv: Validate misa_mxl_max only once
  plugins: Remove an extra parameter

 target/riscv/cpu-qom.h   |   1 +
 target/riscv/cpu.h       |   1 -
 accel/tcg/plugin-gen.c   |   9 +--
 hw/riscv/boot.c          |   2 +-
 target/riscv/cpu.c       | 142 +++++++++++++++++----------------------
 target/riscv/gdbstub.c   |  12 ++--
 target/riscv/machine.c   |   7 +-
 target/riscv/translate.c |   3 +-
 8 files changed, 81 insertions(+), 96 deletions(-)

-- 
2.42.0


