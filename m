Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B12D7ADA4B
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:49:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmsv-0000fu-Sr; Mon, 25 Sep 2023 10:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmsX-0000bP-IK
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:48:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmsT-00083R-4W
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695653280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ITGZB8gY7QUvz9h/7p0uHnZ6OI+XGEDpO0hgcQS4x48=;
 b=FOBXgqGFWF83O+L5AKBpNcaGbxim46yU3si8TjLGADXmjGtZp7NGQnZfZJm6jYmHnkAaSl
 cWIkMLwUf/2G8CeZs3e+PzoovI9LHWveg0NEHxE7AVJxVYjBvoW7XimkQH0qBzXlAarJM0
 C8d/zelyl84Rg2IF5PA6/limbNXYY0M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-kyvckNLTMz-NvYVR4yZK9Q-1; Mon, 25 Sep 2023 10:47:57 -0400
X-MC-Unique: kyvckNLTMz-NvYVR4yZK9Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40474e7323dso60721585e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653276; x=1696258076;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ITGZB8gY7QUvz9h/7p0uHnZ6OI+XGEDpO0hgcQS4x48=;
 b=YMFpsLhpHY4mNGxNL1HvsxGnwgB82dxeBldjnm1xKP5+Ug6V/MkUla6X5g7Ua8GdqP
 CzQTIczvvnOcRCCKK6gknlEDBcHF6p/SZEUvKsoVl16oiVetOWJE6YfIx26nOpvcxUlG
 XFeXsAH4xwKoFj8dItf4nq8zgTrQkRfY09lHdN8MO8tZhthkN1byRGXkLTj4ZCh5T5wo
 MONx/AlghpsEi2W7rkmJ1Kvf08bwX+3I5/6MpSD4sjiZwx4PYl+TEvdBOvPzpBoBRjEx
 UgKr6LwssUyUtwdAz1hcb8QHVXkp2ncoJmfl2UeUtlGDEFWgA3Wrr9NLPUnvuI2TKvB1
 GhxQ==
X-Gm-Message-State: AOJu0YyAXG6RrAp0Hua0O0y7FBK9EEiZDDkY4dQia6eB8ZbJRQOLKyvg
 2Bmdr7BsA26E9VUF7kmp7TcnOBQFU5ai1OithzjU9QtAF0wPwzi9SNm9755xJhZbMw/GN0N0IKR
 bjlm8WMNPnA2QbCbQLaYtAoVhaKhco4bWcozlQgDuEEDHZvhvdtqoaCEH1h2/5xgf9APYixJ/Im
 4=
X-Received: by 2002:a05:600c:895:b0:405:95ae:4aa7 with SMTP id
 l21-20020a05600c089500b0040595ae4aa7mr1313791wmp.10.1695653276214; 
 Mon, 25 Sep 2023 07:47:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3ugwm0hhpT2c4vdL5x4Ca7jaKDZgm7rgD3SG+98Klz+TUK7jJhwjQbYv94UZ69QaAexYcXw==
X-Received: by 2002:a05:600c:895:b0:405:95ae:4aa7 with SMTP id
 l21-20020a05600c089500b0040595ae4aa7mr1313783wmp.10.1695653275892; 
 Mon, 25 Sep 2023 07:47:55 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 x26-20020a1c7c1a000000b003fe29f6b61bsm12418584wmc.46.2023.09.25.07.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:47:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH] target/i386/cpu: avoid shadowed local variables
Date: Mon, 25 Sep 2023 16:47:43 +0200
Message-ID: <20230925144744.527958-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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

Reuse the pointer variable used for the unversioned model.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f9e51a9d87e..9dcb1efc896 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5976,9 +5976,10 @@ static void x86_register_cpudef_types(const X86CPUDefinition *def)
     /* Versioned models: */
 
     for (vdef = x86_cpu_def_get_versions(def); vdef->version; vdef++) {
-        X86CPUModel *m = g_new0(X86CPUModel, 1);
         g_autofree char *name =
             x86_cpu_versioned_model_name(def, vdef->version);
+
+        m = g_new0(X86CPUModel, 1);
         m->cpudef = def;
         m->version = vdef->version;
         m->note = vdef->note;
-- 
2.41.0


