Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C91947A1D70
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 13:29:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh6zO-0002IH-Lo; Fri, 15 Sep 2023 07:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qh6zM-0002Em-Rb; Fri, 15 Sep 2023 07:27:56 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qh6zL-0008Dq-Cv; Fri, 15 Sep 2023 07:27:56 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c3d6d88231so17177565ad.0; 
 Fri, 15 Sep 2023 04:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694777259; x=1695382059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IcdT9tgTzwyZG5PnKDZ4UxZv7lGrxB6DWITLWfeqGiM=;
 b=cG/1whifklAoNZAcYAUHC5dusQUmX82RQ2C2V/ZL7S5PcQa9dww6TRAw/SDaIwnJOM
 GJO33ljzCGcRvkW7Gpw8NHNKx13d2aIn4OyPjgauuBOsiXPqASH4VwR4U7WiMlWNkGAQ
 xiVIIJRBujx9+YzMpgUYpQ7RrmsoZJtbU7YA9sV+QFMFCTMykWg80SWqK6H7jTYyc3hy
 wH1uD6j+939Ixfy2PVOy4GzRPlFyIUevCKLRU7bHrL8t7NaqbU9aiSD0bF3V1K0QmDCv
 oVbiJfCrogAg2aD2k3nnMtWCzly69+Zcwqeq18gkWpFI3j998daJ6zesdflPTPPAdlAq
 m6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694777259; x=1695382059;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IcdT9tgTzwyZG5PnKDZ4UxZv7lGrxB6DWITLWfeqGiM=;
 b=N/rzC7FqlAxtJoYlLPs1dnogwA5x9ovPAFuHRvxh5NdJlNLVMTDGkRqB8/Do7XQAEM
 TdDCYE7HlI/3Kj3/lkFB+y7D1LWT2QOpRj05XjlvvgOawV5Q5LZTEthGEoqsyo1ufO6G
 jbdo8KTb02PUP6HG5VjuWOtD14mwQ9HOLgJKXyM9lG/v+aKZj3oy9qglmO59FK2KecWS
 Yo6c2JMO5fWSjhEilCbQSxxQMlf0CwFERwb7Ll4+VXE10CFnbtrg97IIljWpkQcqYIvT
 T6KPg687yfNqamO9CaMMY2Npkab3gEg2nxjNKo+Klomsc+tO1jOvraj8PXx07YGVJw1/
 5kHw==
X-Gm-Message-State: AOJu0YzcWz3dJ/5oAICxsaobIeWGmPpcqFp+Mbe/VZPP/217IyJtvLpv
 JT8Az6ZeotjgwxWEXrkonKQ=
X-Google-Smtp-Source: AGHT+IH76EGh4Vle5cM6a41QZg96Mx92ipzSi/wletjpTklZwDR6jeuw6EtK1crd0GWoznQ7/y/QNA==
X-Received: by 2002:a17:903:258f:b0:1c3:f4fa:b1a2 with SMTP id
 jb15-20020a170903258f00b001c3f4fab1a2mr1230985plb.8.1694777258646; 
 Fri, 15 Sep 2023 04:27:38 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a170902e5c100b001b1a2c14a4asm3277691plf.38.2023.09.15.04.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 04:27:37 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: lukas@wunner.de, wilfred.mallawa@wdc.com, Jonathan.Cameron@Huawei.com,
 jiewen.yao@intel.com, qemu-devel@nongnu.org, kbusch@kernel.org,
 its@irrelevant.dk, mst@redhat.com, marcel.apfelbaum@gmail.com,
 hchkuo@avery-design.com.tw, cbrowy@avery-design.com
Cc: alistair23@gmail.com, qemu-block@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 1/3] hw/pci: Add all Data Object Types
Date: Fri, 15 Sep 2023 21:27:21 +1000
Message-ID: <20230915112723.2033330-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add all of the defined protocols/features from the PCIe-SIG
"Table 6-32 PCI-SIG defined Data Object Types (Vendor ID = 0001h)"
table.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/pci/pcie_doe.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/pci/pcie_doe.h b/include/hw/pci/pcie_doe.h
index 87dc17dcef..15d94661f9 100644
--- a/include/hw/pci/pcie_doe.h
+++ b/include/hw/pci/pcie_doe.h
@@ -46,6 +46,8 @@ REG32(PCI_DOE_CAP_STATUS, 0)
 
 /* PCI-SIG defined Data Object Types - r6.0 Table 6-32 */
 #define PCI_SIG_DOE_DISCOVERY       0x00
+#define PCI_SIG_DOE_CMA             0x01
+#define PCI_SIG_DOE_SECURED_CMA     0x02
 
 #define PCI_DOE_DW_SIZE_MAX         (1 << 18)
 #define PCI_DOE_PROTOCOL_NUM_MAX    256
-- 
2.41.0


