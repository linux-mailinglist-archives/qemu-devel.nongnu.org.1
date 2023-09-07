Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9E87972B1
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:12:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEgs-0003Dn-B3; Thu, 07 Sep 2023 09:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qeEgc-0003As-UI
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:04:44 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qeEgO-00083i-U8
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:04:41 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c1ff5b741cso8200055ad.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694091867; x=1694696667;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=shPARw+tLNnIUFEFBFESRJz0RNmWaqWCpot+BQW0Pwg=;
 b=VpiC5toVm6Wn4tPKrqBL1Fk+26N+JNKUa00hmqidn6C2+YSFUQQ9oTFA5Oz+C4cOc0
 HSg6JFBdQw0m8ndXxZZcrSaTk6kZOY+tVTIQtcbgtBYEwvm9+o+EdG79YOrl9kpHaR6B
 SfJ5bULifNBQPBqEaqI1uKeW67zxShjErnjgIuVuzfT9S4lKIc55y1aHPM2W/kJ5ae5o
 zTrg22uldPwB2UNC+emwUbfjdmO67nvkH46ALgeGGKDFIKLwcMMUElvgG8FJiYHqwYMt
 J1Yt6EvRhvJkdsU5N2L3TddHS0/t3IJZyToY2VpnMwARAeWt7UoVrbS6gbrSQPm+fndt
 lgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091867; x=1694696667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=shPARw+tLNnIUFEFBFESRJz0RNmWaqWCpot+BQW0Pwg=;
 b=kZhZeT1Ify/da5ub3LhpY8rTzXH6Kw0V/J+rdl9sEkimU01quRTRi23SwmRCm1grSr
 ntI3d2EvPc67sTfp5p59IoyJruIb08KjI32yoFKztYy3ECew3Sm5lE6LlcALYDRZ/sC7
 WdcvcgzuhWUIlj011BBCxgsqRv1w+rgx80iHkWX/Q4/J+vHsDgKh1H6XtWVzma498ca3
 WGUSdHjMj07rmLMv4pP6BXlNU2mpQM9WvhgRliMYNg9KI5nyLenqfi9l3mky118vXPje
 YQRoLnEOKEFNvwGl7XFpBuwDaZwa8qFdROn8CcNQy8kV6fI8NPD8z534qbNqXTQlwnVV
 xLSg==
X-Gm-Message-State: AOJu0Yw5RE6H6iQVEUttBO/g/0Ou42FuJUOoLz+/Ku+XfmriDTjdsf/W
 5/WVESIfQiiewZTb5Sk7x9KudnlF6+86M7ucq81Ozw==
X-Google-Smtp-Source: AGHT+IGpAgrY5UZo35/0Eq6WgqoT85hokhjospBGmrfXGUYOauR8RKdMECMlSCV/uSNsnXtPSBcLxQ==
X-Received: by 2002:a17:902:ec89:b0:1c3:4444:3c9e with SMTP id
 x9-20020a170902ec8900b001c344443c9emr12012123plg.58.1694091867221; 
 Thu, 07 Sep 2023 06:04:27 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 g24-20020a170902fe1800b001b0358848b0sm12821913plj.161.2023.09.07.06.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:04:26 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: john.levon@nutanix.com, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, stefanha@redhat.com,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v3 5/5] vfio-user: Fix config space access byte order
Date: Thu,  7 Sep 2023 06:04:10 -0700
Message-Id: <20230907130410.498935-6-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907130410.498935-1-mnissler@rivosinc.com>
References: <20230907130410.498935-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=mnissler@rivosinc.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

PCI config space is little-endian, so on a big-endian host we need to
perform byte swaps for values as they are passed to and received from
the generic PCI config space access machinery.

Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 hw/remote/vfio-user-obj.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index cee5e615a9..d38b4700f3 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -281,7 +281,7 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_ctx, char * const buf,
     while (bytes > 0) {
         len = (bytes > pci_access_width) ? pci_access_width : bytes;
         if (is_write) {
-            memcpy(&val, ptr, len);
+            val = ldn_le_p(ptr, len);
             pci_host_config_write_common(o->pci_dev, offset,
                                          pci_config_size(o->pci_dev),
                                          val, len);
@@ -289,7 +289,7 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_ctx, char * const buf,
         } else {
             val = pci_host_config_read_common(o->pci_dev, offset,
                                               pci_config_size(o->pci_dev), len);
-            memcpy(ptr, &val, len);
+            stn_le_p(ptr, len, val);
             trace_vfu_cfg_read(offset, val);
         }
         offset += len;
-- 
2.34.1


