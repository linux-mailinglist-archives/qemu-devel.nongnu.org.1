Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFF870D181
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:44:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I0g-0003D5-SS; Mon, 22 May 2023 22:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0f-0003Cj-7U
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:25 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0c-00047G-AS
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:25 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-25394160fd3so2444830a91.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809861; x=1687401861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GWLvavGLU06o92baLIElqMgyuvFGkHiNTbKmxofkG2E=;
 b=StDctYEPCw7+2HNo8eXgHqAxSj0aYS5i4XtP0EvS0KmYeRxpTFhzFeB8aiUcDcwfT0
 ZJGe5foAADD7xYQeoGp4YBT13qdK2jYU5P4oCwEX8yc7ZFmxZCt34Dp8uQZOIPBlokcY
 aZnuGMuIMpyGju/f27DbS+bRvDC2g7U1zk8Js6SWqA0KhGexj6xg3qtRAaN9LLUa+6mW
 WV0Uxzuo4P6+vlBIb1H4JhqBSxsMsKBOGmcKX1S/jKsoy9VENoIcvMBPyA5AO17+wI5y
 JGKxDuT75z9nYqMlat079UwswPzb6pi5+IsSouMAGgOcewkNT58HKFnKPrTBeWudD/ni
 iwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809861; x=1687401861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GWLvavGLU06o92baLIElqMgyuvFGkHiNTbKmxofkG2E=;
 b=RbrLAN1SmiE9RZIm853+reST/DPThiEolaKf5KHj5bWiEqXY0Q3Xq5s4ojFyKqcOEM
 u2tJPqwBYilgOAiw5SSoEmfqGyMudtuzx/+kFIXIX+of4Ix/INUAQv4EuINpKj9uJ2ss
 n98op0xdRGaIQaKvWTLSPfcH8+MDc5AwPnXc5gH9zaoAOXRh/HwNds3vcUcRoXJ+ZByD
 dU3ajGFvYVNuIHioRcf3xS92+0z8IB3YNt26sJndJJTxiYpBKdUlmsk+Sa3sonr/SPP3
 nPLxMfS4ATG/QwmGxpaS9k9GQISKYIx9iUG8i65MseH9zqMTa12msg/Wvu5ga/7lSxp/
 exow==
X-Gm-Message-State: AC+VfDz2B08AbFj3VMHF+z4YKd2cmOQZ88WB4fnLN16Mv69jRZgSwtFs
 Kfv6A5k3qr+yn3gT4dCVxpzS/g==
X-Google-Smtp-Source: ACHHUZ6Dyx9d/Z9Zb4aXRbFh+zQZOjBJjSqetcwf5k05DK1VATYr20guCLtuXfaDTYthHx4PsXX4Lw==
X-Received: by 2002:a17:90a:ce01:b0:255:7b0d:9f5d with SMTP id
 f1-20020a17090ace0100b002557b0d9f5dmr4000461pju.7.1684809860938; 
 Mon, 22 May 2023 19:44:20 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:44:20 -0700 (PDT)
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
Subject: [PATCH v5 08/48] e1000e: Always copy ethernet header
Date: Tue, 23 May 2023 11:42:59 +0900
Message-Id: <20230523024339.50875-9-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102b.google.com
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

e1000e_receive_internal() used to check the iov length to determine
copy the iovs to a contiguous buffer, but the check is flawed in two
ways:
- It does not ensure that iovcnt > 0.
- It does not take virtio-net header into consideration.

The size of this copy is just 18 octets, which can be even less than
the code size required for checks. This (wrong) optimization is probably
not worth so just remove it.

Fixes: 6f3fbe4ed0 ("net: Introduce e1000e device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/e1000e_core.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index c2d864a504..14b94db59c 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1686,12 +1686,9 @@ static ssize_t
 e1000e_receive_internal(E1000ECore *core, const struct iovec *iov, int iovcnt,
                         bool has_vnet)
 {
-    static const int maximum_ethernet_hdr_len = (ETH_HLEN + 4);
-
     uint32_t n = 0;
-    uint8_t min_buf[ETH_ZLEN];
+    uint8_t buf[ETH_ZLEN];
     struct iovec min_iov;
-    uint8_t *filter_buf;
     size_t size, orig_size;
     size_t iov_ofs = 0;
     E1000E_RxRing rxr;
@@ -1714,24 +1711,21 @@ e1000e_receive_internal(E1000ECore *core, const struct iovec *iov, int iovcnt,
         net_rx_pkt_unset_vhdr(core->rx_pkt);
     }
 
-    filter_buf = iov->iov_base + iov_ofs;
     orig_size = iov_size(iov, iovcnt);
     size = orig_size - iov_ofs;
 
     /* Pad to minimum Ethernet frame length */
-    if (size < sizeof(min_buf)) {
-        iov_to_buf(iov, iovcnt, iov_ofs, min_buf, size);
-        memset(&min_buf[size], 0, sizeof(min_buf) - size);
+    if (size < sizeof(buf)) {
+        iov_to_buf(iov, iovcnt, iov_ofs, buf, size);
+        memset(&buf[size], 0, sizeof(buf) - size);
         e1000x_inc_reg_if_not_full(core->mac, RUC);
-        min_iov.iov_base = filter_buf = min_buf;
-        min_iov.iov_len = size = sizeof(min_buf);
+        min_iov.iov_base = buf;
+        min_iov.iov_len = size = sizeof(buf);
         iovcnt = 1;
         iov = &min_iov;
         iov_ofs = 0;
-    } else if (iov->iov_len < maximum_ethernet_hdr_len) {
-        /* This is very unlikely, but may happen. */
-        iov_to_buf(iov, iovcnt, iov_ofs, min_buf, maximum_ethernet_hdr_len);
-        filter_buf = min_buf;
+    } else {
+        iov_to_buf(iov, iovcnt, iov_ofs, buf, ETH_HLEN + 4);
     }
 
     /* Discard oversized packets if !LPE and !SBP. */
@@ -1740,9 +1734,9 @@ e1000e_receive_internal(E1000ECore *core, const struct iovec *iov, int iovcnt,
     }
 
     net_rx_pkt_set_packet_type(core->rx_pkt,
-        get_eth_packet_type(PKT_GET_ETH_HDR(filter_buf)));
+        get_eth_packet_type(PKT_GET_ETH_HDR(buf)));
 
-    if (!e1000e_receive_filter(core, filter_buf, size)) {
+    if (!e1000e_receive_filter(core, buf, size)) {
         trace_e1000e_rx_flt_dropped();
         return orig_size;
     }
-- 
2.40.1


