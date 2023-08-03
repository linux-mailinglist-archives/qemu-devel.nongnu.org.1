Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1DD76E756
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 13:50:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRWp2-0008BV-P8; Thu, 03 Aug 2023 07:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qRWp1-0008BG-2o; Thu, 03 Aug 2023 07:48:51 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qRWoy-00017v-02; Thu, 03 Aug 2023 07:48:50 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-686f090310dso786758b3a.0; 
 Thu, 03 Aug 2023 04:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691063325; x=1691668125;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2hqc91/BRkB3XOcvjZWG7zm2+xiIXVouQ+NeKZYZhKc=;
 b=O+cau5LtGifN2wVBtvu/PN7SnGCIaEMOJIZ5eK7CBgN5ob3XQEdX2xY4Q0hxYFBq7E
 XERdhnTpIGvupfhKyw1KeJQ+bARkW2C7QuSHf3jmOTqMwjCupPJcQrMxYXF8ycpwmgDz
 LXSvLQrzijpIgVPBiGcXcJifswK/OZRc3QtD4QMmpDq5ApaBVdnW5qtEylphKMdgsH0A
 sEm74j0aoAevgB6PR9U/+TPAY1L1wyk3pN5WACw8TYK3n4TGosG8xHNZEOk57suMQCqQ
 DmS/Yvm5k7JU/0MAAVrPntFTv5HLpW4Xk7fEZoiuMpein54hrCr3T9lZmBo9OXuAYOVF
 lejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691063325; x=1691668125;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2hqc91/BRkB3XOcvjZWG7zm2+xiIXVouQ+NeKZYZhKc=;
 b=JRfV5UgHRHnRr9QoAxHsPSZisgcU0SwCHTiJ9FPX8yiOssVJkfVW/E9d6oMesboddI
 tsCDBAoaNWpX+8aYM4uGYyWSbtZGOkEEZNB8F4hsM05kJT3XFf/j36iWnEy9MKRBGRJL
 z8/1kP7qhxELbxa+iPopkeUCjDRiaPIUZt8Ih2jY9VCr5Wcryn+IfgPYH3Fuh68Jx7vd
 J426fG9N7ntNAVHpmN/fTCaM0N9ENBBnnELlQYTrwlWhNIofmmq961NLUF4ofEC6auJn
 vS/nGE5pPOeEQ7Kb6bH1XM+3E5/WGpxBsoWC+j8L1Zml9/t4osTfsNLeFTjdwiWv+DO8
 4raQ==
X-Gm-Message-State: ABy/qLbqgYXrRa/TwTvMBbx51dbczeLTZJPFztm827dv3PgeRq8E3NUp
 5rhQYoq95OJ/9XZYRg9bJv7iRP1re9Np6g==
X-Google-Smtp-Source: APBJJlFWf/kJ8ZY15pQBCappw05vOlFw57qArp4tAUIVREubbQy9ypQrLc4DiyGAVC4kORJn16RuMg==
X-Received: by 2002:a05:6a20:1451:b0:127:72c3:6427 with SMTP id
 a17-20020a056a20145100b0012772c36427mr23379864pzi.2.1691063324897; 
 Thu, 03 Aug 2023 04:48:44 -0700 (PDT)
Received: from localhost.localdomain ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 p24-20020aa78618000000b0068702b66ab1sm12184958pfn.174.2023.08.03.04.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 04:48:44 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, hreitz@redhat.com, k.jensen@samsung.com, kwolf@redhat.com,
 pbonzini@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com,
 berrange@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, philmd@linaro.org,
 thuth@redhat.com, lvivier@redhat.com, jeuk20.kim@samsung.com
Subject: [PATCH v9 0/4] hw/ufs: Add Universal Flash Storage (UFS) support
Date: Thu,  3 Aug 2023 20:48:22 +0900
Message-Id: <cover.1691062912.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Dear Stefan,
I'm really sorry, but could you please put this patch series
instead of v8, which was previously merged into block-next?
The fixes from v8 are below.
Please let me know if you have any comments or issues.

Thank you very much,
Jeuk

Since v8:
- Fix compilation warnings (Mike Maslenkin reported. Thanks so much Mike!)
- Skip ufs-test for qemu-system-ppc64
I have confirmed that the dma in ufs-test does not work well
for qemu-system-ppc64.
This seems to be because qemu-system-ppc64 is the only big-endian system test.
Since there are currently no ufs devices supported on big-endian systems,
I just skip the test for now, and leave it as a TODO.

Jeuk Kim (4):
  hw/ufs: Initial commit for emulated Universal-Flash-Storage
  hw/ufs: Support for Query Transfer Requests
  hw/ufs: Support for UFS logical unit
  tests/qtest: Introduce tests for UFS

 MAINTAINERS              |    7 +
 docs/specs/pci-ids.rst   |    2 +
 hw/Kconfig               |    1 +
 hw/meson.build           |    1 +
 hw/ufs/Kconfig           |    4 +
 hw/ufs/lu.c              | 1445 ++++++++++++++++++++++++++++++++++++
 hw/ufs/meson.build       |    1 +
 hw/ufs/trace-events      |   58 ++
 hw/ufs/trace.h           |    1 +
 hw/ufs/ufs.c             | 1494 ++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs.h             |  131 ++++
 include/block/ufs.h      | 1090 +++++++++++++++++++++++++++
 include/hw/pci/pci.h     |    1 +
 include/hw/pci/pci_ids.h |    1 +
 include/scsi/constants.h |    1 +
 meson.build              |    1 +
 tests/qtest/meson.build  |    1 +
 tests/qtest/ufs-test.c   |  584 +++++++++++++++
 18 files changed, 4824 insertions(+)
 create mode 100644 hw/ufs/Kconfig
 create mode 100644 hw/ufs/lu.c
 create mode 100644 hw/ufs/meson.build
 create mode 100644 hw/ufs/trace-events
 create mode 100644 hw/ufs/trace.h
 create mode 100644 hw/ufs/ufs.c
 create mode 100644 hw/ufs/ufs.h
 create mode 100644 include/block/ufs.h
 create mode 100644 tests/qtest/ufs-test.c

-- 
2.34.1


