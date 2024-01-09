Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72810828AB9
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 18:09:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNFb2-0005lv-Hs; Tue, 09 Jan 2024 12:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNFaz-0005l9-Sh
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:08:58 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNFau-0008Sg-Lh
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:08:57 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e5451c13aso833895e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 09:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704820116; x=1705424916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=69LXYrrfhX4USfUNx0NS+uPG+jTOb5kfwCxIZthBqDw=;
 b=yg548Hlb/8/h1mwmDHQs5tZTWy4re/q2DZkDVgahQY4P+Pn96Juij3/5AE0UVhGDv9
 ZIXjUAB9lqGar2rp81B64vosOmm+fTLXITlcdRcnrWcBIZ57oscQvCN5yjPZQm/QoFwQ
 teutAo1KxVzONutvAOgCSoPZr4AuaRkhMSIfFod7JrhoXEBL89XnDCFFM8NCcbijmsBT
 e+r4hlH3VPCVXKWktjU1E5BJCaSV2dhMDAUJjhsWAsEOyfItk8D2FaPOEeGwpmQ6QAFO
 p54XC/F3QAagHExxKqnXXc5e5P1TQS07mb85r+jFbpSiIFlgleRIq8g91iZBS2JJijbe
 Nl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704820116; x=1705424916;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=69LXYrrfhX4USfUNx0NS+uPG+jTOb5kfwCxIZthBqDw=;
 b=ZzHwcIGfGHOvfMYwOR7n4pqezPZAy7Bssoab0DLYo2WBTX0QVpUFMNELy/8l6NcuhF
 hdtHQ59g2DktGdpYIrnKxNtpoDpvTn8GTVYa+ohQswqeF0nEHihoC0yPhr3rP/hc+Rzx
 ApjjcpbXQ3hvUzkYhd/oTiik482uLmt/wsw2tl53ev6gQt4T4pCknOFgFrmMbdBMXXQU
 X/PrK3Eyd9+q+r+b+8C1uyY2rL1cL3Q+ySIeZHrYWPzH55dTijI1rwfUIQHWdP/jCHZy
 AqRBNsMKbtgO6EBfaAZJs/U+jpv1/s8PPJqM33IpBjHh15U1+eibDjra8Qwhk0Ghi+c3
 DcNA==
X-Gm-Message-State: AOJu0YyaHJhld3EuMCPyXjjD/KtPQ01iJ6VMJje3sPKDYxZjS4yUWamK
 s7neAjarXDjlmXR5kgDpB0T7/bl//lP2AzbCgFZh4Yh+dGc=
X-Google-Smtp-Source: AGHT+IENZhqLThBfNBIEyNhUOEJRGDF6RNiKOJKE3ifrqNvjZ/LL5kWu3j64WjP5PCAN9LbE/S5nHA==
X-Received: by 2002:a05:600c:2053:b0:40e:4838:f374 with SMTP id
 p19-20020a05600c205300b0040e4838f374mr1073933wmg.78.1704820116129; 
 Tue, 09 Jan 2024 09:08:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a05600c138700b0040d62f97e3csm15328228wmf.10.2024.01.09.09.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 09:08:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] docs/system/arm/virt.rst: Improve 'highmem' option docs
Date: Tue,  9 Jan 2024 17:08:34 +0000
Message-Id: <20240109170834.1387457-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Improve the 'highmem' option docs to note that by default we assume
that a 32-bit kernel on an LPAE-capable CPU has LPAE enabled, and
what the consequences are.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 docs/system/arm/virt.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 7c4c80180c6..c245c52b7ac 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -96,7 +96,13 @@ mte
 highmem
   Set ``on``/``off`` to enable/disable placing devices and RAM in physical
   address space above 32 bits. The default is ``on`` for machine types
-  later than ``virt-2.12``.
+  later than ``virt-2.12`` when the CPU supports an address space
+  bigger than 32 bits (i.e. 64-bit CPUs, and 32-bit CPUs with the
+  Large Physical Address Extension (LPAE) feature). If you want to
+  boot a 32-bit kernel which does not have ``CONFIG_LPAE`` enabled on
+  a CPU type which implements LPAE, you will need to manually set
+  this to ``off``; otherwise some devices, such as the PCI controller,
+  will not be accessible.
 
 compact-highmem
   Set ``on``/``off`` to enable/disable the compact layout for high memory regions.
-- 
2.34.1


