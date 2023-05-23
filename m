Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC34F70D1A3
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:48:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I2w-0004CV-Tu; Mon, 22 May 2023 22:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I2n-0003iP-TZ
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:46:39 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I2m-0004ln-8H
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:46:37 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-53404873a19so4755600a12.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809995; x=1687401995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xitm0A45Amz5Z6itZEu4YEyvH9NMSzi5s2+CaOW3KMA=;
 b=Ua4vnlqZFmYQiahOIM1qMuPkV5EZytB4d58/C/9/QDahphUrKzi5hbS/2MCTXDO6lb
 zRqlk2Yc9zCkww7wBZQYhf9sXRVM9DbvQaQmXMg69f7dxFSM+pg2d8VeuIAo74d3PKXG
 VvImxoCAf96XxEifHRMveIo4N77ny5IxLl1qeQ8b6v6nOIBH9HBA4lKlUMP3DGakjSIy
 09mGkgFQuEzUGY0EWUroxWgaF3MKsbuRp39DCohh5wadt+uxjkSIGBlo4Usm1bMJhyW/
 vpZFWi8A87xjg+jxmyDYr8bW/mhGC626dtoKB+E+bTIRl6aTtR9/FudT21AYe60X+xeo
 Nqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809995; x=1687401995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xitm0A45Amz5Z6itZEu4YEyvH9NMSzi5s2+CaOW3KMA=;
 b=kuFAirD69hUaZ8g2iJcVtKP1+LGGkJAQRijQL+pTIW+fay2wtLF6NpMjVQ3u8cQoc9
 k/nt8wKk8YsRNP50MVSazn6VyyCnDn56rHmQTCfavOu1bCkXLfLpCJvzaPfEYx0MlUpx
 Xrj4agRSxAmRzCqReCu417EY/O2RCX6UopOKW51R2YimoUCmoiYeH8agT7x5eQGc99i/
 uFLiPTysH0QtnwIdxsPkjU6AU2BChZladlSYNuQJucCnVJtHLH1Vg0BieJl0V3pdJDY3
 Led6zdLQMESIfF+QT62BuZNiyq284Oxqp9+0sKGl81xQBq3ag9shtRJsF84hAo+CIEy4
 /uWg==
X-Gm-Message-State: AC+VfDyDQEYs97PvJhLsnx0QPYqEoaVRkfBUFlFsABmUeEPK1629ha28
 9fCLaOJWghEfG4YZ/V9KPkvCwg==
X-Google-Smtp-Source: ACHHUZ5KSKUdRWYkwbtjYnozA3evJfTE/00XHkmZH6wePRAsAHvxx2Ctmsbz8Xb/lKE1Z2+2ufIp1g==
X-Received: by 2002:a17:90a:bf0e:b0:252:a2e5:4c3f with SMTP id
 c14-20020a17090abf0e00b00252a2e54c3fmr12684785pjs.25.1684809994913; 
 Mon, 22 May 2023 19:46:34 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:46:34 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Tomasz Dzieciol <t.dzieciol@partner.samsung.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 48/48] docs/system/devices/igb: Note igb is tested for DPDK
Date: Tue, 23 May 2023 11:43:39 +0900
Message-Id: <20230523024339.50875-49-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/system/devices/igb.rst | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/docs/system/devices/igb.rst b/docs/system/devices/igb.rst
index afe036dad2..60c10bf7c7 100644
--- a/docs/system/devices/igb.rst
+++ b/docs/system/devices/igb.rst
@@ -14,7 +14,8 @@ Limitations
 ===========
 
 This igb implementation was tested with Linux Test Project [2]_ and Windows HLK
-[3]_ during the initial development. The command used when testing with LTP is:
+[3]_ during the initial development. Later it was also tested with DPDK Test
+Suite [4]_. The command used when testing with LTP is:
 
 .. code-block:: shell
 
@@ -22,8 +23,8 @@ This igb implementation was tested with Linux Test Project [2]_ and Windows HLK
 
 Be aware that this implementation lacks many functionalities available with the
 actual hardware, and you may experience various failures if you try to use it
-with a different operating system other than Linux and Windows or if you try
-functionalities not covered by the tests.
+with a different operating system other than DPDK, Linux, and Windows or if you
+try functionalities not covered by the tests.
 
 Using igb
 =========
@@ -32,7 +33,7 @@ Using igb should be nothing different from using another network device. See
 :ref:`pcsys_005fnetwork` in general.
 
 However, you may also need to perform additional steps to activate SR-IOV
-feature on your guest. For Linux, refer to [4]_.
+feature on your guest. For Linux, refer to [5]_.
 
 Developing igb
 ==============
@@ -68,4 +69,5 @@ References
 .. [1] https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/82576eb-gigabit-ethernet-controller-datasheet.pdf
 .. [2] https://github.com/linux-test-project/ltp
 .. [3] https://learn.microsoft.com/en-us/windows-hardware/test/hlk/
-.. [4] https://docs.kernel.org/PCI/pci-iov-howto.html
+.. [4] https://doc.dpdk.org/dts/gsg/
+.. [5] https://docs.kernel.org/PCI/pci-iov-howto.html
-- 
2.40.1


