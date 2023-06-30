Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0997435E6
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:38:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8hG-00022v-TP; Fri, 30 Jun 2023 03:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hB-00021x-Vt
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:34 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hA-0005P5-5Y
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:33 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-992dcae74e0so57788466b.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 00:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688110650; x=1690702650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYD68kEPFclICXbOLUMz7Z2cY+C5HyXMhNA+XfCtq1g=;
 b=cMLi8dLimg0ZC1JZPXyyxwpRR+1WfYEOXkOC2Ogr6LgW8r6wvYHigAYQIGwH31+0I3
 fJC/Q7r0f5aIN4kKHc/n1Ot6G7tkMfkn++6vhTTf6RmJ241ug2ehqQ8uAcZ3/RVoaljv
 U0X79FJE0L8K0Yd8N7pgwuJ5pxD8FSh3O8DU/EFTt5Aiqa1RLVU5Jo5yazQ88OFddyVX
 p0ETk+Gf63JsEmfU14SlqgzFZCg2M0oz3cZTXGEL39T5Vavpj5La38WphLAroXxkA9lJ
 DVL2a2etpFYSkX6iyrOH2WdPuD9Gay/q8u6ACoBFGXyORCE+ZXGtg+PVobMjm6YyhEfr
 5zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688110650; x=1690702650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qYD68kEPFclICXbOLUMz7Z2cY+C5HyXMhNA+XfCtq1g=;
 b=XuytUKp9c6KPwVzSGu2MhPSE9bN1CfZA8e4hvsdcGgZyy6Z6dEj8bc9EsEw78mf8UE
 rsDkP+ezxQNSFMJzJ857lOAXI5wCn8aHGfz/QDmz6LBx7yKmiCiXBKak2xIENTrg7jPu
 4xMc3a+9INDp/TO/Y726d37HyzKzEBNps2jwC+mmjvsuWcS1LxUX8ng7GMMrBdJn2GVV
 XD/aZClLSkJQw839PZbFnkoav6vMM/GRd/wpEaFsoFBHC9m4egGUCEx+tw2+SHQsqvX+
 wH+ft9FcwQw5Ys93R89t0Yi0SzSf450pRxx1kWTttglvXiXQqf5UsyhGOkDgrpbJ2Yw+
 XqJQ==
X-Gm-Message-State: ABy/qLYaJHiMdxqhnUEyu3wLSGCmB3Bvzshty4GsQqe0FKOyNciRBS4T
 Py9PUYncC0w8/KyjrrsMBTrLuEOGWuQ=
X-Google-Smtp-Source: APBJJlHFEFXaQXb6sItsxlMy7MR79qaAyUdE10f3o/SGZ9lmNr1Cf75u1UAt8dDWZa1EHMMmRo/FCA==
X-Received: by 2002:a17:906:34d5:b0:961:a67:28d with SMTP id
 h21-20020a17090634d500b009610a67028dmr1203132ejb.22.1688110650461; 
 Fri, 30 Jun 2023 00:37:30 -0700 (PDT)
Received: from archlinux.. (dynamic-089-012-131-254.89.12.pool.telefonica.de.
 [89.12.131.254]) by smtp.gmail.com with ESMTPSA id
 k19-20020a1709061c1300b00988b32160dfsm7625578ejg.222.2023.06.30.00.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 00:37:29 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 02/17] hw/pci-host/q35: Fix double,
 contradicting .endianness assignment
Date: Fri, 30 Jun 2023 09:37:05 +0200
Message-ID: <20230630073720.21297-3-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630073720.21297-1-shentey@gmail.com>
References: <20230630073720.21297-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Fixes the following clangd warning (-Winitializer-overrides):

  q35.c:297:19: Initializer overrides prior initialization of this subobject
  q35.c:292:19: previous initialization is here

Settle on little endian which is consistent with using pci_host_conf_le_ops.

Fixes: bafc90bdc594 ("q35: implement TSEG")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/q35.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index fd18920e7f..84137b9ad9 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -285,7 +285,6 @@ static void blackhole_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps blackhole_ops = {
     .read = blackhole_read,
     .write = blackhole_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .impl.min_access_size = 4,
-- 
2.41.0


