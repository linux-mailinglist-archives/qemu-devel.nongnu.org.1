Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED797B643B
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:32:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnaob-000349-US; Tue, 03 Oct 2023 04:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoV-0002lA-N7
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoU-0000Lo-7H
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696321889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5QcmQw2PVuW7Kd2iuNxUNyWZSEU9TNIASS3C9a1HLJI=;
 b=fVabOoRt2rpkUU7ANpzpRBfhoav7h7aSyh4N/7VqKKQHEXCxxMYufioJirpxjxoKz4F+C1
 32Q4C9aCkMY7Bnl247xEfGIQEtbvm/AsNkINBIv3ZLvB4JP0mB1b8ExSaTFLunoR0E5Jco
 CRgAtyJUQtjJXvCx1EGKRY9SteG2FI8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-HzC8gvuuOaa4CZ8-fjLVlw-1; Tue, 03 Oct 2023 04:31:28 -0400
X-MC-Unique: HzC8gvuuOaa4CZ8-fjLVlw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-533f8bc82a8so513673a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321887; x=1696926687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5QcmQw2PVuW7Kd2iuNxUNyWZSEU9TNIASS3C9a1HLJI=;
 b=S+ZGLUJ/meSQ4YRFinyLoV0iD3jVbyHcFk9/K6ZWvRk4N5r7Euq5JgmRJUYPICE4g5
 l1u4CSnLLpCtZcdYk/2d7gIxiMcGBKb4G3NRS1zvE8aBjcQLuef8BN9dZ+26fNUHXO5W
 PUuxFha4fehRxoZvRCUKUqzlA05/ZDwhY/z7z3Gus8vjznT7HoPaObUwZUQLwd7rof/a
 VWasnCXAtvRl2VJQ1/6Z18P+VgskevhS5/2VDOwcrkI9eFgnibJf8iryZpLchiBmryv9
 370TDFsgRXefu39ElrLaejYm1MuQWNyR/6WSJ5ctvBBHAMPmZnoRdldS3vDglArvvHDQ
 ZF3g==
X-Gm-Message-State: AOJu0Yyv9Doupr7k3/UyqPWurXwAmIm5KaS+Yf0qbNuaRb/7DylNUye0
 glYIxLU23S6ErqA8zfR0qIDb97Uf1t5v79xHDw6EZpjXwcpg1vd7N8tad0GjW/17dAxauv1nEVL
 PQg8GqtAxO7wbNhx/LP1TUxoH2OgHtz+reHIeP1f6QmYkruMw7cYzWnjKiDw7ACx6j8bYTnevv6
 8=
X-Received: by 2002:aa7:df07:0:b0:530:8897:f0e9 with SMTP id
 c7-20020aa7df07000000b005308897f0e9mr12064502edy.21.1696321886821; 
 Tue, 03 Oct 2023 01:31:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnm7J/8v1HPrvbaO1MZHgS0def4es6X79LnW230e1dSnVOBS8dhR+kHPIRNWz89MosYOox2g==
X-Received: by 2002:aa7:df07:0:b0:530:8897:f0e9 with SMTP id
 c7-20020aa7df07000000b005308897f0e9mr12064482edy.21.1696321886481; 
 Tue, 03 Oct 2023 01:31:26 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 k25-20020aa7c399000000b005342fa19070sm489389edq.89.2023.10.03.01.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 01:31:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Martin Kletzander <mkletzan@redhat.com>
Subject: [PULL 21/24] hw/ppc: Support machine-default audiodev with fallback
Date: Tue,  3 Oct 2023 10:30:38 +0200
Message-ID: <20231003083042.110065-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003083042.110065-1-pbonzini@redhat.com>
References: <20231003083042.110065-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Martin Kletzander <mkletzan@redhat.com>

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ppc/prep.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index f6fd35fcb9e..137276bcb92 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -45,6 +45,7 @@
 #include "trace.h"
 #include "elf.h"
 #include "qemu/units.h"
+#include "audio/audio.h"
 
 /* SMP is not enabled, for now */
 #define MAX_CPUS 1
@@ -310,6 +311,10 @@ static void ibm_40p_init(MachineState *machine)
         dev = DEVICE(isa_dev);
         qdev_prop_set_uint32(dev, "iobase", 0x830);
         qdev_prop_set_uint32(dev, "irq", 10);
+
+        if (machine->audiodev) {
+            qdev_prop_set_string(dev, "audiodev", machine->audiodev);
+        }
         isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
 
         isa_dev = isa_new("pc87312");
@@ -426,6 +431,8 @@ static void ibm_40p_machine_init(MachineClass *mc)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("604");
     mc->default_display = "std";
     mc->default_nic = "pcnet";
+
+    machine_add_audiodev_property(mc);
 }
 
 DEFINE_MACHINE("40p", ibm_40p_machine_init)
-- 
2.41.0


