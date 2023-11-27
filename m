Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BF27F98A4
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 06:23:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7U4a-0004UK-GB; Mon, 27 Nov 2023 00:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1r7U4V-0004TV-Qp
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 00:22:16 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1r7U4T-0008Bk-QM
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 00:22:15 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3b861a3be3eso827775b6e.0
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 21:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701062532; x=1701667332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRRD/Ekj0h83Op/FvtNapJt01xEZPwiTxtAfYesAOBw=;
 b=hX4y2CqS4ZShaGLUK3HOoE8HWu7vZ781OdDo331QES3bq2j3ekTQAioqi22wf8Lqvu
 Fv8nLIeMe8iRb+p2wN7/wfwxsVZ+1P6usCORLsF91zR5cq286E6dUrtTzm7DK/htc14N
 55ejupTkD2lwQKe+T3Ehv+/JrSCOMJr2nRo25F0iins0ykSQs7dQoICdGPnhdcn/sKZf
 7B3eqYgKxhVCMdbDBMMANxh4rjxHXHAmkzyCf26whYactrk3iwzz7faovlOnzXQGZo0p
 jOO0PoiW672qgGhWznzvx0XFDK3p2QrvpEn4vkjXrmHtDcXOj2v+KPQzFvTR0Yk2pbfj
 NNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701062532; x=1701667332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IRRD/Ekj0h83Op/FvtNapJt01xEZPwiTxtAfYesAOBw=;
 b=Ov8W5XQRgIevQm0TZBbJyQNBNSYxyE10RDBLhIne5lo6b0AIPjNv/vaTLociYjzNvD
 W9cJc9RqZZo5FLP2L0fj5hm+MSRErrHM7OySHquwAd8f93MXhTvIYANJk0uithPt/tty
 u/7RWh648ci4SCQJywkuxoiNgHysj07AFqvPE5VOLZBBlWpnbuqdebAtghCIKfcki3/M
 COxTENpukF4s4MeIsTDzK62TlvLmAVbXu9Ugodm+AIQuWmlIZ/O3bfHg+pyKuXYPz+Fh
 qPcta0xON8NTcyUP6pb2bpfnNL1faO9NbwxwSPsOhM0MAe2MWzmtYefo8+XN5KA6uwL1
 CVMg==
X-Gm-Message-State: AOJu0Yxin/TcqzpxDmkuTOOSM35u6k0YHRkqi5KbYBgJlE9gIp5bCL2q
 OTHF1aFp8cJT4b4pIB4Tc0NQ9MgSP1F+UFeRYL5AnsLd
X-Google-Smtp-Source: AGHT+IGoHhUmlmRE4sSolDjV0Xe1Kz7BdtC+Cnd0gjEuyIlrTDrEt8fOSdHpwDRD1pWAm1EJd1Vqeg==
X-Received: by 2002:a05:6808:2115:b0:3b2:dd87:fc with SMTP id
 r21-20020a056808211500b003b2dd8700fcmr14613191oiw.2.1701062532036; 
 Sun, 26 Nov 2023 21:22:12 -0800 (PST)
Received: from amd.. ([2804:7f0:b402:7782:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 v13-20020aa7808d000000b006cb9f436232sm6392316pff.114.2023.11.26.21.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Nov 2023 21:22:11 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: thuth@redhat.com,
	gustavo.romero@linaro.org
Subject: [PATCH 4/4] hw/misc/ivshmem: Rename ivshmem to ivshmem-pci
Date: Mon, 27 Nov 2023 05:20:24 +0000
Message-Id: <20231127052024.435743-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127052024.435743-1-gustavo.romero@linaro.org>
References: <20231127052024.435743-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oi1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Because now there is also an MMIO ivshmem device (ivshmem-flat.c), and
ivshmem.c is a PCI specific implementation, rename it to ivshmem-pci.c.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/misc/{ivshmem.c => ivshmem-pci.c} | 0
 hw/misc/meson.build                  | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/misc/{ivshmem.c => ivshmem-pci.c} (100%)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem-pci.c
similarity index 100%
rename from hw/misc/ivshmem.c
rename to hw/misc/ivshmem-pci.c
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 7b03fc1345..6f0a7c31cd 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -37,7 +37,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
 subdir('macio')
 
 # ivshmem devices
-system_ss.add(when: 'CONFIG_IVSHMEM_DEVICE', if_true: files('ivshmem.c'))
+system_ss.add(when: 'CONFIG_IVSHMEM_DEVICE', if_true: files('ivshmem-pci.c'))
 system_ss.add(when: 'CONFIG_IVSHMEM_FLAT_DEVICE', if_true: files('ivshmem-flat.c'))
 
 system_ss.add(when: 'CONFIG_ALLWINNER_SRAMC', if_true: files('allwinner-sramc.c'))
-- 
2.34.1


