Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4D37B690F
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:32:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qneYD-0008RT-Pp; Tue, 03 Oct 2023 08:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qneXw-0008PF-Qt
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:30:42 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qneXp-0007gQ-Qe
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:30:36 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3232be274a0so2564612f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 05:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696336229; x=1696941029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g7j+ZKjZU7k+0CzG1aKzjQAk8hMMCzbHPgv7YGTA/m4=;
 b=aBkxC18IAx/RJIMBRZvkXfHDcLgICGvz9/0cz24KZeyMv6LhrN24hm88xUtM85ltZ1
 gwP9nYIYhv16i4+/RV1yDO/scyneQmObvZLNXZuptN4XsYxek7ZeO4s+s4dmPrg5a2wU
 gKYHAqLYDaf/bwIjvVqmUEmS0xsqEb9pMg5we9UjX5gwibFNHC5R7qM0UjCGLZArZHWH
 Ly/vFT28Wo7v4BReEuCUxQa5JmzmUFnp3ph5W44QC2Z7AUBqZDrU/zSXU1p2V0Iyp5XU
 HkTEZa3F2BYKBaHkdt6WsYxqEVlJzUCii7vmWR1YSapgpRZDO7tDS+zftquLbmrJnCXk
 94LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696336229; x=1696941029;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g7j+ZKjZU7k+0CzG1aKzjQAk8hMMCzbHPgv7YGTA/m4=;
 b=vwpIU2ZRoHzMZqeZBkafh1QqWR5MKAM7FBZI/GKRIX/QymIK5dTQm5cifD6Wd5Z6zo
 hThbGyBkV2Cs9vP0onuvw2crz5VFWTCMqH5iaI3yidFeL7fakZfwmtbEKTzG0jfpnxZI
 fBsef2XuBeVFU5Ct6WWjEyned6629BFd1m8dG/V4YL4XmwmPwWVi7ThCIA/uO5JVo/5p
 8/RtgK8/uXbod1TEhtQ9j96oT/SvpOLvAVFLmCGFM7c1iQd1txS65KXFvH4QsCkr6PEJ
 HbGCx+9JnRyCoqO0DH6tGEl/2c272WFy98nrWT3Lg+lBbLq0QGXWzu+MBjiTQgx8tVDJ
 abRA==
X-Gm-Message-State: AOJu0YxS+UdreI/eb+E/F6kAXHN5Wjvy0YltzriW0nYxlINpaG8nrKK2
 jTC7dwYbgA/xZpiLFT9I6qI7/CACxebuFPlxxcw8HA==
X-Google-Smtp-Source: AGHT+IFBxMV4/1nchJeQ/YxQdQE65HU0cTcfcAYgMnGyWOki7FRja2chgmqsuZvdG1rMjy8dNfke8g==
X-Received: by 2002:adf:f3cd:0:b0:31f:fc9a:a03 with SMTP id
 g13-20020adff3cd000000b0031ffc9a0a03mr2082106wrp.20.1696336229468; 
 Tue, 03 Oct 2023 05:30:29 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-246.abo.bbox.fr. [176.131.222.246])
 by smtp.gmail.com with ESMTPSA id
 n26-20020a1c721a000000b004063c9f68f2sm1186897wmc.26.2023.10.03.05.30.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Oct 2023 05:30:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 0/7] accel: Restrict tcg_exec_[un]realizefn() to TCG
Date: Tue,  3 Oct 2023 14:30:18 +0200
Message-ID: <20231003123026.99229-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Since v1:
- Use 'target'/'common' in function names (Claudio)
- Added Claudio R-b tags

From v1:
- Add missing accel_cpu_common_unrealize()
- Add AccelClass::cpu_common_[un]realize handlers
- Use tcg_exec_[un]realizefn as AccelClass handlers

Philippe Mathieu-Daudé (7):
  accel: Rename accel_cpu_realizefn() ->  accel_cpu_realize()
  accel: Rename AccelCPUClass::cpu_realizefn() -> cpu_target_realize()
  accel: Rename accel_cpu_realize() -> accel_cpu_common_realize()
  accel: Introduce accel_cpu_common_unrealize() stub
  accel: Declare AccelClass::cpu_common_[un]realize() handlers
  accel/tcg: Have tcg_exec_realizefn() return a boolean
  accel/tcg: Restrict tcg_exec_[un]realizefn() to TCG

 accel/tcg/internal.h        |  3 +++
 include/exec/cpu-all.h      |  2 --
 include/hw/core/accel-cpu.h |  2 +-
 include/qemu/accel.h        | 12 ++++++++++--
 accel/accel-common.c        | 27 ++++++++++++++++++++++++---
 accel/tcg/cpu-exec.c        |  4 +++-
 accel/tcg/tcg-all.c         |  2 ++
 cpu.c                       | 13 +++----------
 target/i386/hvf/hvf-cpu.c   |  2 +-
 target/i386/kvm/kvm-cpu.c   |  4 ++--
 target/i386/tcg/tcg-cpu.c   |  2 +-
 11 files changed, 50 insertions(+), 23 deletions(-)

-- 
2.41.0


