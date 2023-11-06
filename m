Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 069F47E205E
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:51:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzy2p-00026S-9c; Mon, 06 Nov 2023 06:45:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy2U-00025Q-Os
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:45:06 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy2T-00053k-9M
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:45:06 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4083ac51d8aso33496365e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699271103; x=1699875903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HAp2vJsfIjryO6ERGLNtaKXCTt6QsFuHAbc0TgTsKDY=;
 b=fd9387ShaL67S3Ue/jpUGyr2Ng3Md64LQkHToJ3+9YwFCYL5HyV9sJN3cbwzwY4Ye7
 X91Iwwf4tDROU7E6bB600ChseiHQLOMhGXI9xtRohi+nmEPMT+yLlbV6HRkZ9zNMXSoQ
 LN8xh8j+vxG93P0LuFYiOXxnJRgeyM9Hdeyzf0gmaI4VdUyrulrd5mvvxxR+ye/UFipp
 CO0WBpm1CnmDgC4hTGbBEB7UNOU0VLweezjZSWYsqk/11rntzBKdWfbnvh/GufMBxXXu
 pyrXXNZw3zQyLqMRbRlKZjLH+8KAn1qBPt6feOl0LIdnH7OTDQ6HPBONFCRrIYJevPrm
 7J6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699271103; x=1699875903;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HAp2vJsfIjryO6ERGLNtaKXCTt6QsFuHAbc0TgTsKDY=;
 b=cDB0+TQXAlfKIF5nZQlIzi21ezW6z5dL6+DkXPGKe+D/xgKbABGKejOqNx1tCThWe2
 ZDY5GnhLUkT9mxmxij1JBzGPGozvNqdEZXWB3m8nL/Td07hmuLvrctx2jryctzr1jhJQ
 VVAMjj3JaMv9AUsp8j3FcHtX1GZZ7v8WYozhPwPIDouPlL1aYYvLqt5tS+zQcqRKbFO2
 GqtEn1B96g1Q3a7qWa1XaxWvGujE0v3S8QNXS4Ui/7uWQbjjqZfZfvpu1sjE5yI+MlNr
 GeSpcGQOJ4upCx5BgTSR5PGE4RR8Mk55sq+4lAbFcoLsA2+BhveesvNUD0mTEHmlc8c3
 NxFg==
X-Gm-Message-State: AOJu0YzCJIOhvmXu6iuu7c2uyzkRfuHC1xToe1nFAwr5fCCGdTL611y3
 yZOQZ+mooQs3ShwfDqq+9DZBKU14nM0loz5YAs4=
X-Google-Smtp-Source: AGHT+IH8uhVqmwlFAlrNzHT463yaf9s+mG4L6XlPwBjsoMZFRvmiH2nbz6DpXiQPy+pIxCyp67WKwQ==
X-Received: by 2002:a05:600c:a0a:b0:409:5580:bc9f with SMTP id
 z10-20020a05600c0a0a00b004095580bc9fmr13581608wmp.34.1699271103429; 
 Mon, 06 Nov 2023 03:45:03 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 j19-20020a05600c191300b004090ca6d785sm12055182wmq.2.2023.11.06.03.45.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:45:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] target/s390x/cpu: Restrict CPUS390XState declaration to
 'cpu.h'
Date: Mon,  6 Nov 2023 12:44:55 +0100
Message-ID: <20231106114500.5269-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

In order to restrict CPUS390XState declaration to "cpu.h" (both
target-specific):
- have the following prototypes take a S390CPU* instead:
  . css_do_sic()
  . sclp_service_call()
  . sclp_service_call_protected()
- restrict cpu_get_tb_cpu_state() definition to TCG

Philippe Mathieu-Daudé (4):
  hw/s390x/css: Have css_do_sic() take S390CPU instead of CPUS390XState
  hw/s390x/sclp: Have sclp_service_call[_protected]() take S390CPU*
  target/s390x/cpu: Restrict cpu_get_tb_cpu_state() definition to TCG
  target/s390x/cpu: Restrict CPUS390XState declaration to 'cpu.h'

 include/hw/s390x/css.h         |  2 +-
 include/hw/s390x/sclp.h        |  5 ++---
 target/s390x/cpu-qom.h         |  2 --
 target/s390x/cpu.h             | 11 ++++++++---
 hw/s390x/css.c                 |  3 ++-
 hw/s390x/sclp.c                |  7 ++++---
 target/s390x/kvm/kvm.c         |  4 ++--
 target/s390x/tcg/misc_helper.c |  5 +++--
 8 files changed, 22 insertions(+), 17 deletions(-)

-- 
2.41.0


