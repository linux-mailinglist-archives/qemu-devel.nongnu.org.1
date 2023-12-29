Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEBF8201B1
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:28:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLV-0007FC-Qw; Fri, 29 Dec 2023 16:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLU-0007Dz-3s
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:44 -0500
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLS-0006od-NC
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:43 -0500
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-35fb0dcec7aso32580055ab.3
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885081; x=1704489881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OWhbEXkC1GW/Vbr9cJeB8yQeDQQ2N/bSYDuiieojzSA=;
 b=gJzjfvA1zfd9yIyRawgE8LKFCdXIcoilf/eF8aDnO+ii3UrQqh4rWmIF6ZO2ZE7myF
 m3sScsI6WS7+fo8IgcCioJLcxnxD9Y34nuB+aCXsA2WW9/lf9E4DCxHZr4rkrKBSQC0l
 /aTbZCgzaeASbl4HdgIv2NM2p2h8agJSSr9YUtiaA6nIBKCDek7l8OarmYJ+vwX5GU55
 MV6bd7kuVIBeKJg3XEkUp6AxsjIVNAKFVovdsjuZCWPz/oW/lQocys1dAW6sYvMQQrjI
 hPbeJDTAwSMrNuEunSxigwTplYzkRn3xmO34eYXZSRdtPmv4Xvoy/iCQMJNXlnu10Qti
 gmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885081; x=1704489881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OWhbEXkC1GW/Vbr9cJeB8yQeDQQ2N/bSYDuiieojzSA=;
 b=oC4BItvuE3xAxN+oyYlT5BzPL0jBOF1lpdamQDDzxUKvlsV+CuLOpd0W4K85ov/4GC
 eUfCR+gsCL0u4M93p4EhVEmbP8THZi8vFguJaP6K6/Zxam8rHqJX5FXv2t/iu8RJjEgL
 zTG310YvHOvq5NkBRt7RuPWJ+FrExoV45V7lEcFq8FdbHL4eX5NMCYLAKomi1TDGEmPq
 X38hRHaAysenPz2TAOJ1WP7o1TgZz0zF6ciQWjJTcOFk2rflkyj33pmfe5wRtzWDqe2r
 RKa6ZnZ71xfDpPAmFUHl0CbUZo/Fp2ZkkOJE9fSpP0iiQMlixZpeyw4Y5qW/RfVNAcT9
 eJeg==
X-Gm-Message-State: AOJu0YzDvQ2egLqDMmgqXFofrQG//bBH5ZGu8S98IgOCd1q6icoOW7oR
 Zo6t0DMhMNqdOsdkeOqSf1EIUfT1s32QNQbzXleuIMnM2C0UdA==
X-Google-Smtp-Source: AGHT+IEPLJT/17cB3OYD3QEfm+o3cwJlRWviOdBVAistJqv3zKNiMyD9wZ29TnEgxYqPRysoBzWe7w==
X-Received: by 2002:a05:6e02:144d:b0:35f:e83e:88ae with SMTP id
 p13-20020a056e02144d00b0035fe83e88aemr17087448ilo.21.1703885081554; 
 Fri, 29 Dec 2023 13:24:41 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: [PULL 20/71] hw/9pfs: Constify VMState
Date: Sat, 30 Dec 2023 08:22:55 +1100
Message-Id: <20231229212346.147149-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x131.google.com
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

Acked-by: Greg Kurz <groug@kaod.org>
Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231221031652.119827-21-richard.henderson@linaro.org>
---
 hw/9pfs/virtio-9p-device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 5f522e68e9..efa41cfd73 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -237,7 +237,7 @@ static const VMStateDescription vmstate_virtio_9p = {
     .name = "virtio-9p",
     .minimum_version_id = 1,
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
-- 
2.34.1


