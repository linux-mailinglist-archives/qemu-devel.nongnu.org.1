Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0B37A5116
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 19:37:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiIBF-0008PL-BM; Mon, 18 Sep 2023 13:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qiIBD-0008Ow-Jw
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:37:03 -0400
Received: from mail-yw1-x1144.google.com ([2607:f8b0:4864:20::1144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qiIBB-00062A-31
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:37:02 -0400
Received: by mail-yw1-x1144.google.com with SMTP id
 00721157ae682-59bbdb435bfso47660737b3.3
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 10:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695058619; x=1695663419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ElFAYYNkJRNCt2dt0TpsJRoShLKSj6k2tGqTV+c4V5M=;
 b=fC0VebRI9lzQMrPxSa5z3UbOAqQ8iHfQz/Gdbyj+lNM7jiy36KDPUiEKiCmFGvelVe
 K7r62t7GMn0ZQdoEmhfnGchZbiyyieklCyBA3vuM8STryvGWTePnOZe1RTv/w/fylqYM
 GhCgnhkzrKZPtmRCEN6lki9vVbjBUBuydUqL5wXGjDQ3mbj57lUeg5sxAqf+jwjGXYPs
 1DVoiT65P5F0rxQuYfA5zGAK3WtlE1TpY3GdRZ0+TOqiPtlcL9hRLA2cOdBQWl/F6U3b
 QHh9Ei5qwOL0q6sOdCZq/bS+XB9OHsOpCghUTYOg36iK1tcX56EN42KhOtwltl8sk5+3
 av+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695058619; x=1695663419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ElFAYYNkJRNCt2dt0TpsJRoShLKSj6k2tGqTV+c4V5M=;
 b=w/7eSdAJMx7Z2IWR0DAo6dna7o8gWLw0Bw6mpzE+dgnlti88L38qIc0jwT8Tvhb1rS
 If5lj2FW3pPHfHtn9kGGbIo+7bC8yUTaPuzMKk05sDnMGTsS8Zd2GebjAiYjlADGigdy
 omFzfXeKNw+TaBluBUVMeNsDR7RM/tKz4HRo3K9mfcSat8v9Q4lqCDxbVru1kfc4bKrL
 XglbChKiAdNzEXdwKCRbcCKYeYQ3/4fb2FJqPS66/wN6W2v+TSQv3GieqrRWsHSOhJ97
 17nqW0GIypIuo8Nmmy8K8E5ZkNkfswsJfAsRYRwkvg6EEyt/iSdJnFAaRM4hrZiTk6uA
 8qLQ==
X-Gm-Message-State: AOJu0Yw2lb7W8FMk8go74QJEhHhSPTEVdUpmnC0HknBy7OWsjyyYynBa
 5bI1DmBmx9x/EWKE6rr/dLsLnDu4AwZH
X-Google-Smtp-Source: AGHT+IHA+i8+y/c+Uh4TfqYlAHY/UorGy2DGFcez195H+rnhowSOTPtmxgj047onc5oz4SUheg8SRQ==
X-Received: by 2002:a0d:eac7:0:b0:59c:bab:eb4f with SMTP id
 t190-20020a0deac7000000b0059c0babeb4fmr9721891ywe.16.1695058619492; 
 Mon, 18 Sep 2023 10:36:59 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net.
 [173.79.56.208]) by smtp.gmail.com with ESMTPSA id
 v66-20020a818545000000b005704c4d3579sm2720306ywf.40.2023.09.18.10.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 10:36:59 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org, junhee.ryu@sk.com,
 kwangjin.ko@sk.com, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v4 0/1] Niagara MHSLD
Date: Mon, 18 Sep 2023 13:36:55 -0400
Message-Id: <20230918173656.504628-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1144;
 envelope-from=gourry.memverge@gmail.com; helo=mail-yw1-x1144.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

v4 update: Kconfig and meson fixes

Since Niagara uses <shm.h>, it presently can only be built
for linux.  Also addings missing Kconfig files and options
to turn it off, and turns it off by default if VENDOR or
CXL_MEM_DEVICE are turned off.

Gregory Price (1):
  cxl/vendor: SK hynix Niagara Multi-Headed SLD Device

 hw/cxl/Kconfig                          |   6 +
 hw/cxl/meson.build                      |   2 +
 hw/cxl/vendor/Kconfig                   |   1 +
 hw/cxl/vendor/meson.build               |   1 +
 hw/cxl/vendor/skhynix/.gitignore        |   1 +
 hw/cxl/vendor/skhynix/Kconfig           |   4 +
 hw/cxl/vendor/skhynix/init_niagara.c    |  99 +++++
 hw/cxl/vendor/skhynix/meson.build       |   3 +
 hw/cxl/vendor/skhynix/skhynix_niagara.c | 516 ++++++++++++++++++++++++
 hw/cxl/vendor/skhynix/skhynix_niagara.h | 162 ++++++++
 10 files changed, 795 insertions(+)
 create mode 100644 hw/cxl/vendor/Kconfig
 create mode 100644 hw/cxl/vendor/meson.build
 create mode 100644 hw/cxl/vendor/skhynix/.gitignore
 create mode 100644 hw/cxl/vendor/skhynix/Kconfig
 create mode 100644 hw/cxl/vendor/skhynix/init_niagara.c
 create mode 100644 hw/cxl/vendor/skhynix/meson.build
 create mode 100644 hw/cxl/vendor/skhynix/skhynix_niagara.c
 create mode 100644 hw/cxl/vendor/skhynix/skhynix_niagara.h

-- 
2.39.1


