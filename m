Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 014998201A5
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:27:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKMW-0001ar-Do; Fri, 29 Dec 2023 16:25:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKM2-00019r-1o
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:25:18 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKM0-0007pD-FF
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:25:17 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6da16ec9be4so1554680b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885115; x=1704489915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l/g/xbbVARm94nOrfgxhdYMz88vGBMTmt5c/f0fX3lI=;
 b=hTyjRbMTHtOC0nD9vIItkb9Mf2NUnV+VsfDkU+YxX8m2LQBZlzMVuCdFljI7xxgs0p
 RrsmBec/OGuVkG99E4FscoPjAquODmVYvSs00bfubelSTKK6bYk9ADisMDRXOtEA0/uJ
 Cx5Xwfywf6MNgeT+Up2Ua+yCksh2CHeMrYF1SkU/QcVPcXl4B8MM2Sl65EFR1Xou3pQW
 52TzNPlKWNbEJ0YuECqm4cGqMCQAQb3HHNuhC84KG3hMINwNwpquPe+sBaqRA9Sdi34s
 8NbbFMRSTLsR8TlYW5LggbWyMubP3hGyJDaOK5sV4Kb4uFKP3BpPTrXhKQfwIk0ChdbW
 qofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885115; x=1704489915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l/g/xbbVARm94nOrfgxhdYMz88vGBMTmt5c/f0fX3lI=;
 b=eijyahXEP1QpNdrLLXXgxDTV85p6gy2dnpXdNkoyNWAZsxvm6EwPeI0Tm/VkgTr/IJ
 mLubsAzNT7oM7XYMTXmL9QvTS+e/M91O73BUdDIw9vDBjyyGmEdbfOFfilTkxVuO/USe
 w6YtFi1+UwM18AcNLgR6Pft9t7DXHjyd+2KBQq9SraYxbRcU91t+C2C6/AdSFDC+yP6d
 aDq4v1vo9GMVd1cACcKpv+12mns5QF3Y+ZmkGLwf4Rah+pCn+A0gNuVOVcZjMmPVyfL7
 Sf0Ru/zpMsrmrzB4mVYFGszHhdOvgOStRqeVIsdJBkT72obGTx2/EUo8OVraMZsaZAjP
 +OMQ==
X-Gm-Message-State: AOJu0YyUAsxhZKZ2W9YmAtACcJNlYC8vr1wa+VP/mRJkR4jzaqK0Phw/
 IVjcx2zQ4QMFjzvRJyaeqUqBn0v2c/1t60fixAaM+rBVPfbUxw==
X-Google-Smtp-Source: AGHT+IFZ0CyZgg17Ky2jAlRA1MPg0hwniGqLIwprjQ37X9goWaJHJzJl7uVGmi65/eRHDWImgpTtOQ==
X-Received: by 2002:aa7:8c42:0:b0:6d9:ac6f:20b4 with SMTP id
 e2-20020aa78c42000000b006d9ac6f20b4mr8950106pfd.42.1703885115090; 
 Fri, 29 Dec 2023 13:25:15 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.25.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:25:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/71] hw/ipack: Constify VMState
Date: Sat, 30 Dec 2023 08:23:10 +1100
Message-Id: <20231229212346.147149-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231221031652.119827-36-richard.henderson@linaro.org>
---
 hw/ipack/ipack.c   | 2 +-
 hw/ipack/tpci200.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ipack/ipack.c b/hw/ipack/ipack.c
index ae20f36da6..c39dbb481f 100644
--- a/hw/ipack/ipack.c
+++ b/hw/ipack/ipack.c
@@ -93,7 +93,7 @@ const VMStateDescription vmstate_ipack_device = {
     .name = "ipack_device",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(slot, IPackDevice),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/ipack/tpci200.c b/hw/ipack/tpci200.c
index 6b3edbf017..88eef4b830 100644
--- a/hw/ipack/tpci200.c
+++ b/hw/ipack/tpci200.c
@@ -619,7 +619,7 @@ static const VMStateDescription vmstate_tpci200 = {
     .name = "tpci200",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, TPCI200State),
         VMSTATE_BOOL_ARRAY(big_endian, TPCI200State, 3),
         VMSTATE_UINT8_ARRAY(ctrl, TPCI200State, N_MODULES),
-- 
2.34.1


