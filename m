Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F0D70D1B4
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:49:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I1m-0005ge-K5; Mon, 22 May 2023 22:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1a-0005aG-JN
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:22 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1K-0004Oe-Be
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:22 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2533d8f4a1eso4750322a91.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809904; x=1687401904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AsthgQJrNHF2V5nen/vLbtV66eO8AMLQ9pq9fDeN3xU=;
 b=wJ+tMLFJm0d7rcfXB2SbV/zV2OFr9nrTSTJS3t3Hh6bUkdE1DNPHg4xPaKWcTJOhFz
 wN3zD/tyQwtxd92u0xAqVMt/pxCV0v1W7oGgs7TZ28Kg8sNBFnUCHfO93Orl5b/QM5q3
 8i/Mg7vSV82wK48+4gSd1rRJYtOU3dblVZAe2IGbRpYa6gUCr1nLOgURMoeJIeNmt61/
 YLGlUxsYoLEZDw/d04/QjHY/q6ScmGEv8YVr8FKghTYJgD1D4L6O1fT64BPMCzF3fsRE
 VeR6T3OZsSj5KkZZthbp5Fm/9/MNrpzL9nff1sd8GmLjpjAld6KHPRlYZBDjWGRvW18X
 dsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809904; x=1687401904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AsthgQJrNHF2V5nen/vLbtV66eO8AMLQ9pq9fDeN3xU=;
 b=PSCCG1QDFPMO6YpiKbaz+TsYE44Rb/IQ+mXC50JxgnFutm0Tt70Yv2vdo7zxq6CLRA
 VmCTTRKfgFbPvDrQty/lQU735GcKzKNvFXQz88weR9kbAg9Ji+KhjoZQhTTUxF9EwzXk
 Mjy8eRzZBhokYR6uo+iFggNl74WHK7j3OX06WqJI94BP91h7/SIqkQyV5m9NhdkdDoG9
 INzf+T5yGxT7nQ4OM1d4xvBh+b9kc+RTnR0IBTRv1nC2UegfaGmimcYC/GfRWoUdVUre
 YiUjCAbPSsy5qV2XV911rA/mUyZga+rRomHe/TRSqT/pPSjVpQOgJOKEFZ1sGIcUt2EO
 VtuQ==
X-Gm-Message-State: AC+VfDyZlaeDYxd7twfcBqj1VPbibV9+mVATkmKcoHlnLPm7Wnt8lJ4p
 Ri515sRKg/t6GK9cXEKRbfSBiA==
X-Google-Smtp-Source: ACHHUZ4Nij2HKvyombTCtRyX3ascl1mH9ShRL5BAI13J4EaCRRWfJBQ7N2M+t0EBvTXewelLE1QoXw==
X-Received: by 2002:a17:90a:f310:b0:255:8fd0:fc0e with SMTP id
 ca16-20020a17090af31000b002558fd0fc0emr2328474pjb.1.1684809904722; 
 Mon, 22 May 2023 19:45:04 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:45:04 -0700 (PDT)
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
Subject: [PATCH v5 21/48] igb: Read DCMD.VLE of the first Tx descriptor
Date: Tue, 23 May 2023 11:43:12 +0900
Message-Id: <20230523024339.50875-22-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1033.google.com
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

Section 7.2.2.3 Advanced Transmit Data Descriptor says:
> For frames that spans multiple descriptors, all fields apart from
> DCMD.EOP, DCMD.RS, DCMD.DEXT, DTALEN, Address and DTYP are valid only
> in the first descriptors and are ignored in the subsequent ones.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 hw/net/igb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index bae51cbb63..162ef26789 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -613,7 +613,7 @@ igb_process_tx_desc(IGBCore *core,
             idx = (tx->first_olinfo_status >> 4) & 1;
             igb_tx_insert_vlan(core, queue_index, tx,
                 tx->ctx[idx].vlan_macip_lens >> 16,
-                !!(cmd_type_len & E1000_TXD_CMD_VLE));
+                !!(tx->first_cmd_type_len & E1000_TXD_CMD_VLE));
 
             if (igb_tx_pkt_send(core, tx, queue_index)) {
                 igb_on_tx_done_update_stats(core, tx->tx_pkt, queue_index);
-- 
2.40.1


