Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB83070D1A1
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:48:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I1A-0003eH-E6; Mon, 22 May 2023 22:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I14-0003TH-Fr
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:51 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I12-0004Am-Uu
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:50 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-25343f0c693so4664333a91.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809888; x=1687401888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ocsD2ZaUCUvnX115Ui0hmhaA4Y0GfsbtERqEgOjd/I=;
 b=Sw9bFQod6JLJgLL+Xm1dmPBhPosXTjwsFYCH9ATV1iLVc4/Gt6T5WjNMpiWdnse4E9
 xu6Y2DeSP0VFZ4hEphd+qbjnunOAQkxMNvI6VHVXRzQsi2gtPFdSNa8hYKXEkhjs5sgQ
 UXu+rV4s6x44TQHjf5/hFm5WlBmHFILd7euAORaWLfTtfyQk8wGI29OL+/2K2iUNMOoY
 dlSxGGiwh6E6YYjDf9ahKzbHGOu3Fg4NzK59tC9SfMbTQxSPF+H6BwViZH8AJw7OFOiZ
 75AQ0OXIn4E+fCczhEqu44PvXm8ObF4XO9FYQ6nkgS0ggWAFR4NqBUEfoFChbpVE1vKj
 kp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809888; x=1687401888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ocsD2ZaUCUvnX115Ui0hmhaA4Y0GfsbtERqEgOjd/I=;
 b=C03mCpDGn0FlUFn0ks0WYYI8dSGNkN5kQdR1AF1NgIRH7SwEAhfztw+pXdIF94uijl
 wD9NCz0A6QeyDY98W6FOdNgRPb32PhlaIB0lOhqQ4P1kKL+Xft5FNgPMkWQkU3i5Lx4r
 kYwQCZS3wfi3BOTmuJJQXle17jd7MK7XyBPGfG1YhTGgGN+YK71QnSYJcNGcEn+zAfS+
 Q/AjY+OB0nCErNWO9uUbEisCteUaHrqdcYi82YIJ9KfgeUp5jmi3ndkzVz9b8D+Ekrda
 93+JyvlQFAXfeD/LxZJohdw3W6EQFxIEx+gXSYF2oOV0bWX/P4GKp+zOkjwS8CAmJw4z
 3+bQ==
X-Gm-Message-State: AC+VfDzDxg9jLstdhEC3JUcPOOjgYe4Fk3iHL8eF33P8HONkZxoUwtr7
 Ql/86qXShMMKT0Wj0eCXk9QBvQ==
X-Google-Smtp-Source: ACHHUZ6a/nW9W2qiQhPP2Q6C8mxltRzfiR4WqI7JUJqk6hYEeHhSd1DwmATfQXzvZCHOP6vfUQC7ag==
X-Received: by 2002:a17:90a:5b04:b0:23d:15d8:1bc3 with SMTP id
 o4-20020a17090a5b0400b0023d15d81bc3mr11571577pji.39.1684809887868; 
 Mon, 22 May 2023 19:44:47 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:44:47 -0700 (PDT)
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
Subject: [PATCH v5 16/48] e1000x: Take CRC into consideration for size check
Date: Tue, 23 May 2023 11:43:07 +0900
Message-Id: <20230523024339.50875-17-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1029;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1029.google.com
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

Section 13.7.15 Receive Length Error Count says:
>  Packets over 1522 bytes are oversized if LongPacketEnable is 0b
> (RCTL.LPE). If LongPacketEnable (LPE) is 1b, then an incoming packet
> is considered oversized if it exceeds 16384 bytes.

> These lengths are based on bytes in the received packet from
> <Destination Address> through <CRC>, inclusively.

As QEMU processes packets without CRC, the number of bytes for CRC
need to be subtracted. This change adds some size definitions to be used
to derive the new size thresholds to eth.h.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/net/eth.h      |  2 ++
 hw/net/e1000x_common.c | 10 +++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index e8af5742be..05f56931e7 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -32,6 +32,8 @@
 #define ETH_ALEN 6
 #define ETH_HLEN 14
 #define ETH_ZLEN 60     /* Min. octets in frame without FCS */
+#define ETH_FCS_LEN 4
+#define ETH_MTU 1500
 
 struct eth_header {
     uint8_t  h_dest[ETH_ALEN];   /* destination eth addr */
diff --git a/hw/net/e1000x_common.c b/hw/net/e1000x_common.c
index 6cc23138a8..212873fd77 100644
--- a/hw/net/e1000x_common.c
+++ b/hw/net/e1000x_common.c
@@ -140,16 +140,16 @@ bool e1000x_hw_rx_enabled(uint32_t *mac)
 
 bool e1000x_is_oversized(uint32_t *mac, size_t size)
 {
+    size_t header_size = sizeof(struct eth_header) + sizeof(struct vlan_header);
     /* this is the size past which hardware will
        drop packets when setting LPE=0 */
-    static const int maximum_ethernet_vlan_size = 1522;
+    size_t maximum_short_size = header_size + ETH_MTU;
     /* this is the size past which hardware will
        drop packets when setting LPE=1 */
-    static const int maximum_ethernet_lpe_size = 16 * KiB;
+    size_t maximum_large_size = 16 * KiB - ETH_FCS_LEN;
 
-    if ((size > maximum_ethernet_lpe_size ||
-        (size > maximum_ethernet_vlan_size
-            && !(mac[RCTL] & E1000_RCTL_LPE)))
+    if ((size > maximum_large_size ||
+        (size > maximum_short_size && !(mac[RCTL] & E1000_RCTL_LPE)))
         && !(mac[RCTL] & E1000_RCTL_SBP)) {
         e1000x_inc_reg_if_not_full(mac, ROC);
         trace_e1000x_rx_oversized(size);
-- 
2.40.1


