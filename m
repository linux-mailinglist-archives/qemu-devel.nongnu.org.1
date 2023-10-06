Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 043C07BB618
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:14:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoimw-00081o-C3; Fri, 06 Oct 2023 07:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoimu-00081O-UL
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoimt-0000HT-Gg
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iSaoZDLtMbdcEKV3jUJN3mk/qKz/NtrRlOhHUjSJjMw=;
 b=JHtf/In1j3eie4F6QdYzI96TGALMdrE+ZRC+wXcemdArmcxu23c4rGbxc9nGVrDDGpunTX
 vn/yYgYQlL1PLlTlFEHdzyp4gzaVs7PYQ0rvksOJVpsKJtMq38v/EeuBCeIWHrdo2o4JYD
 sqenTTmA+ng3k8sEurA4yop5dWqWEuQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-CXA96p1iOwuvW8DF3CmAQg-1; Fri, 06 Oct 2023 07:14:24 -0400
X-MC-Unique: CXA96p1iOwuvW8DF3CmAQg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9adc78b386cso172066866b.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590863; x=1697195663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iSaoZDLtMbdcEKV3jUJN3mk/qKz/NtrRlOhHUjSJjMw=;
 b=H/AqfUkgOg3VkQRViMugAcfBy+DSoKx7YhsQW+wsaa3fe0nt4Ih131b6QGVi3hL7z4
 usUlf32MvKY73Bqoma0OSwXyz+9fLUARqR1WCelFsWmqug0k3R9yxNEPnvcokEsW2aaC
 khvrBJiIxTIpU0wew99Z2jooPlCQ5P1K6dZUhpGgSepnDVeTkTZSmv+5lckmQzVJW8D8
 zF01CUSNOxBYPsso8JpLB6gki/yhP72T9Fm56oFV73o7KE7QV7sKBic5JosnqiZzAifY
 JFj6vp1WUK4GJ/UMV0yq9QMHuzdXInt+k3RtblSP4hyaE8JxSolisVK8We+OqMlkdT+o
 Wlkg==
X-Gm-Message-State: AOJu0YxSGrELzfE6isZwkOohU7S53HKbmPE8ENmLztEu2PCv8crBcWpZ
 GXPtlb7LFKzlOXrZqL3UX9GOTiRGnyEOiM7llDhXxx8sy43jIK6F1x3GEOZwjte2fZzL+FEubG2
 dxQqkZImX9Y5rr2XuSbzPQlKv2Udn2/2Td/F+j87SPYktUDxrnWQywBb4epk5dIwecLc0S1C3jz
 Y=
X-Received: by 2002:a17:906:535e:b0:9ae:42da:803c with SMTP id
 j30-20020a170906535e00b009ae42da803cmr6347058ejo.48.1696590862948; 
 Fri, 06 Oct 2023 04:14:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8Pieni9yRnUOHlCOcoxL/vGmLh3FxzMJRoClt1hJG1LuLdPQebLuKAaTfQk5wLX183ePFvQ==
X-Received: by 2002:a17:906:535e:b0:9ae:42da:803c with SMTP id
 j30-20020a170906535e00b009ae42da803cmr6347042ejo.48.1696590862655; 
 Fri, 06 Oct 2023 04:14:22 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 qx18-20020a170906fcd200b0099bc8bd9066sm2718825ejb.150.2023.10.06.04.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/26] softmmu/trace-events: Fix a typo
Date: Fri,  6 Oct 2023 13:13:51 +0200
Message-ID: <20231006111412.13130-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Commit 8af3f5c6d6 ("softmmu: add trace point when bdrv_flush_all
fails") added calls to trace_vm_stop_flush_all() in 'cpus.c'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004090629.37473-2-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/softmmu/trace-events b/softmmu/trace-events
index 22606dc27b3..69c9044151b 100644
--- a/softmmu/trace-events
+++ b/softmmu/trace-events
@@ -21,7 +21,7 @@ flatview_destroy(void *view, void *root) "%p (root %p)"
 flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
 global_dirty_changed(unsigned int bitmask) "bitmask 0x%"PRIx32
 
-# softmmu.c
+# cpus.c
 vm_stop_flush_all(int ret) "ret %d"
 
 # vl.c
-- 
2.41.0


