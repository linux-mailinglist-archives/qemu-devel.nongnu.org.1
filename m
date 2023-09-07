Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C59679729D
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:09:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEdQ-0003FM-1R; Thu, 07 Sep 2023 09:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEd4-0002sR-Gc
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEd1-0007JY-4E
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=deDGl1ZSdh4eDpSF5HH/DX8AUIwg+yuy4UZLXOALgvk=;
 b=AUdoE8w2OCdxWpE24ZbSDTzBJDcstuqMbyNknNI3KsDB9Q1R1vuOTAfA5/jU2CtZUUuklC
 HA5JFDJ3ukJoIfEKNWJGvFuw4XvkZA5GfSNPTVjCh17ZmJzHzQpteZF2Id0bknTkxeUIUA
 TKQMXErrNRule6tNVaEGwlUfEItrEn0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-tjAS4tBRP1SWgRwVVfhlLg-1; Thu, 07 Sep 2023 09:00:52 -0400
X-MC-Unique: tjAS4tBRP1SWgRwVVfhlLg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-401dba99384so6530935e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091644; x=1694696444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=deDGl1ZSdh4eDpSF5HH/DX8AUIwg+yuy4UZLXOALgvk=;
 b=SiAxBXh40CFy8toATTuO6kw7p/nnPJV1BtHbfeDQeXUu8d767lOI/bnW7jAwBj/oqW
 FjAKdw4FHBZvLuC/vQWm/dMOCpMSPGP4W85cWVFyn8e/7IeqY895qnC59AFutSUgf59m
 Rg8CpqVZgZBKzL1xhx4Y2/y96WBbgf8bKuYdUTc+eEslooQvWV97rqlTTqS6GSbtlT9x
 WwKw+uBdzt1jS6MQm7kZqiF9EacmvfkiQmjIO2bMZH3dKaQTLY75kxOdHUj8OdqYChK9
 LLurlbXAMDuVyihyMCC0vDQU/6eLAUhVlCuDY3xbsSXqYakG3BCw6p+s/BqPtZmmigBR
 G3Lw==
X-Gm-Message-State: AOJu0YwLCvoWBuWK1MSA1cU4Jpvayart1ogunXEtQvLXGys8S0dbvVYR
 ACvwMNyya4SAbTGgVfIjn+sMLsPhY9PQ54YDD4R0rA8WozVn2Xm5LTt1JCfXAbNKcXe+pqxcWsK
 Lm+H9hN1VoAf3kP7OwukO4exGqvrEdKpNiUJPiaCOC69wXX8JhcZaGixl2LxU3ZkF1GvfkaCHq2
 Q=
X-Received: by 2002:a05:600c:21d0:b0:3fe:1548:264f with SMTP id
 x16-20020a05600c21d000b003fe1548264fmr4727852wmj.22.1694091644455; 
 Thu, 07 Sep 2023 06:00:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR2gYroLEBo+gJJAkyzuEObtS/aSjAejDpMJaJuZmLHL/VCKHXe/xfaYumt+hKxx8XwfFB6w==
X-Received: by 2002:a05:600c:21d0:b0:3fe:1548:264f with SMTP id
 x16-20020a05600c21d000b003fe1548264fmr4727828wmj.22.1694091644066; 
 Thu, 07 Sep 2023 06:00:44 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 w7-20020a05600c474700b003fed9b1a1f4sm1662943wmo.1.2023.09.07.06.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/51] contrib/plugins/howvec: Fix string format
Date: Thu,  7 Sep 2023 14:59:26 +0200
Message-ID: <20230907130004.500601-18-pbonzini@redhat.com>
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

  plugins/howvec.c:186:40: warning: format specifies type 'long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
                                         class->count);
                                         ^~~~~~~~~~~~
  plugins/howvec.c:213:36: warning: format specifies type 'long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
                                     rec->count,
                                     ^~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230907105004.88600-4-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/plugins/howvec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 0ed01ea931e..644a7856bb2 100644
--- a/contrib/plugins/howvec.c
+++ b/contrib/plugins/howvec.c
@@ -181,7 +181,8 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
         switch (class->what) {
         case COUNT_CLASS:
             if (class->count || verbose) {
-                g_string_append_printf(report, "Class: %-24s\t(%ld hits)\n",
+                g_string_append_printf(report,
+                                       "Class: %-24s\t(%" PRId64 " hits)\n",
                                        class->class,
                                        class->count);
             }
@@ -208,7 +209,8 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
              i++, counts = g_list_next(counts)) {
             InsnExecCount *rec = (InsnExecCount *) counts->data;
             g_string_append_printf(report,
-                                   "Instr: %-24s\t(%ld hits)\t(op=0x%08x/%s)\n",
+                                   "Instr: %-24s\t(%" PRId64 " hits)"
+                                   "\t(op=0x%08x/%s)\n",
                                    rec->insn,
                                    rec->count,
                                    rec->opcode,
-- 
2.41.0


