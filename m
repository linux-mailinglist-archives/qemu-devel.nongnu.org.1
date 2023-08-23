Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3507853FD
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 11:29:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYkBD-0005JC-LN; Wed, 23 Aug 2023 05:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qYkBB-0005GG-Ap
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:29:33 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qYkB9-0006Ym-J6
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:29:33 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3a85c5854deso2060679b6e.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 02:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1692782969; x=1693387769; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=shPARw+tLNnIUFEFBFESRJz0RNmWaqWCpot+BQW0Pwg=;
 b=POlUhmrWg1upRg9uJcARhw66wMLMp/xQmuVxv8oTXzLJkEg6B4SjtattVobFxTlFow
 gmp0TESHHcy03wPtcJusCowQkIaLOhNP5aCk7pMe0sh6+/lwf9uR/9E+PryE8zIPaTlk
 0nFgLN3p/fw7+EvhkZmAwsJS8fHT3jte7VOpuu9ayvrXHbfqYMMqC80Q7klc2d9ImQ78
 oG7sE4boyAzgg/f7EEKwEumKgWaeMbATeqbBUo2Vte17FG3ifLAGGO5e0nMm77IcXemc
 zvGl/LKWLz44jlimLzafzmUArKsOT+1bdFWA3NXcIwsyU/kWo3SA50mf/PTcPoOvhp3i
 BVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692782969; x=1693387769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=shPARw+tLNnIUFEFBFESRJz0RNmWaqWCpot+BQW0Pwg=;
 b=i5QCHdVHpvJQUX4D5zjcP+Np4tPK1RBOP7Vakx2Lz2BhJRkdjW/jTY8Mkhb3XIWXyQ
 RXXmGfxqfLxLnHl8113mKK82D10hYkbY8P9ykyFsmQ0LhOADr0nGJxkc3qLn7B3DkzVa
 RQgHL4Nq8OZgNjFUuCBs3a6wvn+NyemmoGXXtiOzYVCZ7SNlzkhg8Hy8QPHDxPB1vp46
 HmItepeTmoDlC9i++3j2mXz9P8Tj668tFiZvVW+gydKNRhy8YbKX+vg9LXHw5uAlazWe
 /zKsqGlAlW+zvFGzGzEGSM7wZCrjWcQ0YBNP4CtNqN+BaFomWK08LLMSfC8KArzlkNLw
 iWBw==
X-Gm-Message-State: AOJu0YxubGqvfey9kb/uF/JdDb4G/tBWDQCv2ZUQRQYW4n1WlEPvfM9F
 Stg9uWuIfTHz10nriOYfdrAJ8cuaGx9GAfxENwpJqQ==
X-Google-Smtp-Source: AGHT+IEIIktRaJjOEgpZVEsFAvzZG+CANLeW9zgdhIp/MDGf5qbOD5X5pknwZHsuL689Xo16Bntv8Q==
X-Received: by 2002:aca:d1a:0:b0:3a7:2d4c:5d4e with SMTP id
 26-20020aca0d1a000000b003a72d4c5d4emr12601809oin.7.1692782969727; 
 Wed, 23 Aug 2023 02:29:29 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 c10-20020aa78c0a000000b006875df4773fsm1169462pfd.163.2023.08.23.02.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 02:29:29 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: john.levon@nutanix.com, stefanha@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v2 4/4] vfio-user: Fix config space access byte order
Date: Wed, 23 Aug 2023 02:29:05 -0700
Message-Id: <20230823092905.2259418-5-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823092905.2259418-1-mnissler@rivosinc.com>
References: <20230823092905.2259418-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=mnissler@rivosinc.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


