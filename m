Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6894F9F7784
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Dec 2024 09:37:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOByo-0006tW-3J; Thu, 19 Dec 2024 03:33:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByk-0006iB-AD
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByi-0005GS-Pa
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8AAp/S2v8W3fPum66lzAfsVl337fXfIWb2U5k64KdL0=;
 b=HehjXZxonx2cjglWoU7nlnNc6dMFRq23s8qa24EQoZD/UN2qkScziYzHogz2N/t3AlR2pW
 XGw2BzEQdK0chcUjSall3Ufv7xkkbLzKJHEXub72uQ7UgSZYFP6qM6hBq9vbPMoWnBsa3q
 +xrXKyuVMa5UrToP4ZUmHkM2KB4jTpA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-9oDyKbxXNey8Cjv-i94plA-1; Thu, 19 Dec 2024 03:33:48 -0500
X-MC-Unique: 9oDyKbxXNey8Cjv-i94plA-1
X-Mimecast-MFC-AGG-ID: 9oDyKbxXNey8Cjv-i94plA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-436219070b4so2729865e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597226; x=1735202026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8AAp/S2v8W3fPum66lzAfsVl337fXfIWb2U5k64KdL0=;
 b=k4pcsAorNqnguAZd7q+eoJkHrYdzlRMTod2aIfXaEq47C/n3nFDUUEhAuQ7vFJcAe0
 BQ/jIXhfeX0leblvbINPmHHfZk9OeYLXLPjTkOT1ydNdm3zgK1DUErt0qCRlsSC86DHA
 gX+T/FEL+vZrDkXXy3t8YauoxpfC+7hzXlcGxV9JrjquDQjYC62SqLyPZ4J0PaVzD2dV
 8KKhUoR1sS1m2nJktr1bHiNXsvY/IIBvybPQTcke6RzSL+lgFZmTIyrFrFK1ruc6KMrX
 MxXj/c+VlnIpj3aCvn1bXVEngEa8ziudPlb8ciVV7vij8qo35KuHkNLfN2ebZc2rXEwE
 kUfA==
X-Gm-Message-State: AOJu0YxX30VmSlrzzQrc3xpv/KwRLPkTEUnrO49trCQUNhFyrLMKseQ1
 iU3TiNH+pXFgDg+UQy3i1j3CmVonQiRS+dTsaITCa7qVvIiwSHW6I0leQckrQUC0n26zsU032Zz
 ZE8yIaHNz7pn69Wf6xRVOaZAcPyPbJEAK96n04A4uhBTT4jso2RFqr7CJsmnFheY5Y4wBm3mQxp
 CjKIqvViPQWsJglYiE2rrMj0cvC2bnD6KnSO9G
X-Gm-Gg: ASbGncsWFOHAqHVN3R98qus5XzCVNi1VETGADKXAKmSSeo6xmABMuvlx2Kwl371iMxZ
 PBaB8aP/ZYThjFhSIy8ppLLRwnniLBjPxg8U36XSBDomz+w/ipYd/MDE44QcgQ+iNBVR7vB6U3w
 CFTP6nG5XmaHh1wD5rWJKSsly2OWQudhQC/Zb7nIIq3NcbV6S5yaW3m8jMAF97fLZIcBSKTvf9J
 2eOrh8Tipv+q6/Wq1LXdMCtAawB0Rrw8alXwBGPvOEVXCfhDa6YAGLOBFXO
X-Received: by 2002:a05:600c:4f84:b0:434:f0df:a14 with SMTP id
 5b1f17b1804b1-436553487famr54228145e9.2.1734597226542; 
 Thu, 19 Dec 2024 00:33:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4H4vRHZk2XSkCrzocY6aLyz8yOIxWULqVjb1iPoLK6Z+chHqCfIJSfdI5UiTgDNqac6ftwQ==
X-Received: by 2002:a05:600c:4f84:b0:434:f0df:a14 with SMTP id
 5b1f17b1804b1-436553487famr54227885e9.2.1734597226195; 
 Thu, 19 Dec 2024 00:33:46 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea423sm11356045e9.2.2024.12.19.00.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 36/41] rust: pl011: match break logic of C version
Date: Thu, 19 Dec 2024 09:32:23 +0100
Message-ID: <20241219083228.363430-37-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Check loopback_enabled(), not fifo_enabled(), like the C code.

Also, set_break_error() must not happen until the break is read from
the FIFO.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index e85d13c5a2b..960ee38ed69 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -460,9 +460,8 @@ pub fn can_receive(&self) -> bool {
     }
 
     pub fn event(&mut self, event: QEMUChrEvent) {
-        if event == bindings::QEMUChrEvent::CHR_EVENT_BREAK && !self.fifo_enabled() {
+        if event == bindings::QEMUChrEvent::CHR_EVENT_BREAK && !self.loopback_enabled() {
             self.put_fifo(DATA_BREAK);
-            self.receive_status_error_clear.set_break_error(true);
         }
     }
 
-- 
2.47.1


