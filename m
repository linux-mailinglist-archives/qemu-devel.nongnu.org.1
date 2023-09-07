Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B63B7797299
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:09:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEdH-00034S-6R; Thu, 07 Sep 2023 09:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEd6-0002si-GO
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEd2-0007JJ-Ak
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SNGxCcskM5CtdJOrttdHLKr3u4GjeZuEossSiUwH/70=;
 b=UD9sJgcQk76pyMobEK3v2fhtacUQR0hkQLW9XJct0ApC5x43BDaxq9dK8BccMKlfjKJiWV
 wU7iM+Ew+iRAUqnWEeR/BSKCIMJXhJjtf0ZuDqdP4+o+/eX9a+tr2cqxW1zEl8oUWd7qBv
 /6Q085ZVnRTDnRbrsC9HRCsnGsB375k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-VdnSzAf-NLi9K5siCC7TZg-1; Thu, 07 Sep 2023 09:00:51 -0400
X-MC-Unique: VdnSzAf-NLi9K5siCC7TZg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-401be705672so6871295e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091642; x=1694696442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SNGxCcskM5CtdJOrttdHLKr3u4GjeZuEossSiUwH/70=;
 b=dsUgj9W6tmwneVLPJnpPCrcz2qYlCzteyTjGgN/1VGjV7QV8prMz/Qu7f9xJG4spFz
 0EGdDHFT5h+NMXvbehyy/YXHeg22FbhnHcOceiZMpjvXcv4EhEN8CLCxc6WzfPG1Ra+Z
 7ZatritKnQvyKtPtk2X+vnuYioC2IDvg/faOUQsQ5X+gFNTq2QHUVYmTMeVODMQHYfC7
 O/gZ53NmDKai8rOMTDJlVmsP4sAsOeSGOqVk3DbyUyCDQcQ0nQMuT/liMRVBD+XmoQet
 ZlxSttVsWBqnCzo/3ASNC4Bg+n+MfxyeA4J+fKrj8Xa3zQo5dbqZ2jV+r9SIMMVGNMfu
 Lw6g==
X-Gm-Message-State: AOJu0Yz2WYlhIh9uXb8EmTfDJ+tW24cIJEzuA1nvVsMMxF22h8Vu7OBY
 rXeUCLPV8OXb81QUbJpzQX/R78fTBmx5z/BGe0H+X60gG7ZLRndVgvkm7X7cAd8vteGAYnWqG7g
 VqdfMkcfxLCkTE7Fmab58DxuTxymMhCyQ8g6MDqDz/VD+BaTWGkuP+hawKVleugcE/pr0CAGxTv
 g=
X-Received: by 2002:a1c:7718:0:b0:3fe:1679:ba7b with SMTP id
 t24-20020a1c7718000000b003fe1679ba7bmr5177783wmi.24.1694091642511; 
 Thu, 07 Sep 2023 06:00:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgVhlWBz6V9whbR5+0BbKiFNSsbaih55hkIy2p82bSOO9zPpXkqNOkn7EWXDK5tMEDibGyqQ==
X-Received: by 2002:a1c:7718:0:b0:3fe:1679:ba7b with SMTP id
 t24-20020a1c7718000000b003fe1679ba7bmr5177742wmi.24.1694091641771; 
 Thu, 07 Sep 2023 06:00:41 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 x16-20020a05600c21d000b003fbca942499sm2480623wmj.14.2023.09.07.06.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/51] contrib/plugins/drcov: Fix string format
Date: Thu,  7 Sep 2023 14:59:25 +0200
Message-ID: <20230907130004.500601-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

This fixes on Darwin:

  plugins/drcov.c:52:13: warning: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
              start_code, end_code, entry, path);
              ^~~~~~~~~~
  plugins/drcov.c:52:25: warning: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
              start_code, end_code, entry, path);
                          ^~~~~~~~
  plugins/drcov.c:52:35: warning: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
              start_code, end_code, entry, path);
                                    ^~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230907105004.88600-3-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/plugins/drcov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/plugins/drcov.c b/contrib/plugins/drcov.c
index 686ae0a537d..5edc94dcaf6 100644
--- a/contrib/plugins/drcov.c
+++ b/contrib/plugins/drcov.c
@@ -48,7 +48,7 @@ static void printf_header(unsigned long count)
     uint64_t start_code = qemu_plugin_start_code();
     uint64_t end_code = qemu_plugin_end_code();
     uint64_t entry = qemu_plugin_entry_code();
-    fprintf(fp, "0, 0x%lx, 0x%lx, 0x%lx, %s\n",
+    fprintf(fp, "0, 0x%" PRIx64 ", 0x%" PRIx64 ", 0x%" PRIx64 ", %s\n",
             start_code, end_code, entry, path);
     fprintf(fp, "BB Table: %ld bbs\n", count);
 }
-- 
2.41.0


