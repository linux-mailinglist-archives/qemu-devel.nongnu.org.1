Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F427DD0B9
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:41:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxqrV-0002aY-DJ; Tue, 31 Oct 2023 11:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qxqr3-0002Tv-Az
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:40:33 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qxqqy-0003kg-0A
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:40:33 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c515527310so80933971fa.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698766819; x=1699371619;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KcXuK+xbqaqkrK6n/T3qmlROjWXVHk5ofR1FJH6tFRg=;
 b=iNx3Ktxqrjm9zEBaAdN3d870TA08+hu7hgOBtq8c2GuVfE0v5rg/EUw0KEuVZoGla1
 tSdgW8TGt6c0RVyf0BDoBeygzDAocSmomCxFtkP3Aeg+6L8DbKrvSRDS9ZnZ92daEJVc
 WcvJPdWf3D9YU9D3B9ZFwakB8BcSQmG511VRCodEGYOHmb7JCtXOuTcjnzN8aFkAcTkg
 DypsUWHun/hMEhEFoRl0tKwhpAglYddx3qmvFYPv0UwZDDTZYjsrFfD5Rp/QLttIMvUE
 pWjb2Q8WV17N/6iDXMSb0ikgEd1Ht5lwWrsbSLNFrd//L0AwdRkMqsPPXBx9u9anxs0L
 2eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698766819; x=1699371619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KcXuK+xbqaqkrK6n/T3qmlROjWXVHk5ofR1FJH6tFRg=;
 b=IutpZTaIvmi1v6rDmqOWCH0LWsJWVZ5rsq67uBoJQ3/ZtXlQbMgRxady8MRqvEzWsg
 f09QAKcQwvDrXATKtymoUyPp/w9ROMgSzyFEO5c+knjdAAP9fVdytcsQ4xQAfgeDlfa0
 DiPvLZaE4q1YQhDaqXHOfDYxwqLpR/bh6nHAwk8IE66A1dXUP+7DNpPOftMM3nDmDdjy
 xUI01EZjwCgaxCy6fiRt+SlReLQYhhEpFxx22zBRljKguYyAireaeYPdUgGIXwPqVnzy
 AcCW2zMFd3xHc0Z2xC3g2Rcifoj3/ONFqmQdxdX/HynR+fjno0u/+gDflb6G6lfvYSnu
 wJPg==
X-Gm-Message-State: AOJu0Yzb9gUuDhDs/MNEdnKIHxeV4hnxki+3aa58sjbQt4b2BGFj7XDE
 mGadMiwrQfDkEIUciiNrTRcggB1vSN8B8SQL2czjow==
X-Google-Smtp-Source: AGHT+IFpkVdVL3nPs4chOd3trlZ8EBbQDQ6z1+3laBuHbYwPtNv8shl6jendNgy1YuRuT0kkVh5E7w==
X-Received: by 2002:a2e:be0c:0:b0:2c5:1bd9:f95c with SMTP id
 z12-20020a2ebe0c000000b002c51bd9f95cmr12373849ljq.53.1698766819463; 
 Tue, 31 Oct 2023 08:40:19 -0700 (PDT)
Received: from rockhopper.. (214.11.169.217.in-addr.arpa. [217.169.11.214])
 by smtp.gmail.com with ESMTPSA id
 r12-20020a05600c458c00b003fbe4cecc3bsm2094613wmo.16.2023.10.31.08.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 08:40:19 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>,
 libvir-list@redhat.com (reviewer:Incompatible changes)
Subject: [PATCH v5 5/5] docs/about/deprecated: Document RISC-V "pmu-num"
 deprecation
Date: Tue, 31 Oct 2023 15:37:17 +0000
Message-ID: <20231031154000.18134-6-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031154000.18134-1-rbradford@rivosinc.com>
References: <20231031154000.18134-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=rbradford@rivosinc.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

This has been replaced by a "pmu-mask" property that provides much more
flexibility.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Acked-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 docs/about/deprecated.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 4e0eb2fe02..60c26bc410 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -413,6 +413,18 @@ Specifying the iSCSI password in plain text on the command line using the
 used instead, to refer to a ``--object secret...`` instance that provides
 a password via a file, or encrypted.
 
+CPU device properties
+'''''''''''''''''''''
+
+``pmu-num=n`` on RISC-V CPUs (since 8.2)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In order to support more flexible counter configurations this has been replaced
+by a ``pmu-mask`` property. If set of counters is continuous then the mask can
+be calculated with ``((2 ^ n) - 1) << 3``. The least significant three bits
+must be left clear.
+
+
 Backwards compatibility
 -----------------------
 
-- 
2.41.0


