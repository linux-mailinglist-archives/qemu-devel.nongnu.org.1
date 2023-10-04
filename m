Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC7C7B7A68
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:44:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxTg-0002EF-NQ; Wed, 04 Oct 2023 04:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxTd-000297-CH
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:43:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxTb-0000tj-Pb
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g3XainUJVMKa+Hs4fQFDx+vYokCoMuU5n+RMYZYnWdU=;
 b=ULDnp/nMFRk6/GV6rKWGkUa2Oj1bJ9fgObvejX03mK7qnecIT1UXzLD+c0Pr4vodQL7yqD
 kU3YmNyHqvIPuofuab3jv2rzqMMbUH+qbuf53MDK5fdpRVWUQh1x9b58q7LRwKazJtoexu
 RlezH9wXA6R9yIpmOBo9uyr5wOOOLCA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-5GByD0ClNg-yF6gpiFvsQw-1; Wed, 04 Oct 2023 04:43:25 -0400
X-MC-Unique: 5GByD0ClNg-yF6gpiFvsQw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3231f43fc5eso1406070f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409004; x=1697013804;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g3XainUJVMKa+Hs4fQFDx+vYokCoMuU5n+RMYZYnWdU=;
 b=u1pRs4eIE/6/En4TvSyt1QDNTPQIchtdsILgMX1siIaCGXs9LIRrHypjj0yuxBWYrl
 4tytiSHeeY46eCJ2blUKwJqbgPjbJuxX0PzOgBjMbQRY+tuH8UQ79Cp3OmGKDyIhxuUH
 BvcSyTt/btMtU1ME3hANHzoSKlcMW1bxDOX/PpG9ufLCsJLLojGFJeE4xd3NQ8dZqEZh
 ESzxYxXW9BczPHRmdaT7TG+ssRk9fdN8EivoUPuL1fU/x++lenefj56m//n3Qxqd0NUD
 WjANpbaDfbBvesehEJ7bh4+JTS/9GI30Gx1v+BYDitTl8/S7EA9NEqfdgS0of5CfCbfJ
 My3A==
X-Gm-Message-State: AOJu0YyPyi+Vc2wJMKYvFs8X+fe22C/JeElbWEZ4FoKotLZwkHnze4OS
 WN817LoiXIFE3zyBfwrafbdWl+ZqyN4whjOV0a90VlWXTyYlPbX9WjBVJYjcTspFdG7WT7QCyjH
 dnZGWmuSwRDeT3+vjnFzofDQWlT13Yh8j8j3cIBFExAerfjlbVCORwA2w2wCUPDAWNvn/
X-Received: by 2002:a5d:654d:0:b0:322:5251:d798 with SMTP id
 z13-20020a5d654d000000b003225251d798mr1287098wrv.70.1696409004184; 
 Wed, 04 Oct 2023 01:43:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMx7uZIJUKsjozHyD7xpXezcSD4e6GIbSNdhP0jcVS4GLNRd+msRoPiYt3ZBDQ7WMqK13vYQ==
X-Received: by 2002:a5d:654d:0:b0:322:5251:d798 with SMTP id
 z13-20020a5d654d000000b003225251d798mr1287084wrv.70.1696409003794; 
 Wed, 04 Oct 2023 01:43:23 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 f16-20020adff590000000b0032326908972sm3440984wro.17.2023.10.04.01.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:43:23 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:43:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/63] hw/virtio/vhost-vdpa: Inline TARGET_PAGE_ALIGN() macro
Message-ID: <a72a3ba2488d56fc8ef4dc23f99b3c06345644c8.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

Use TARGET_PAGE_SIZE to calculate TARGET_PAGE_ALIGN
(see the rationale in previous commits).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230710094931.84402-4-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 3ab0dc0b5b..0e0ed6d7ac 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -331,7 +331,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
         return;
     }
 
-    iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
+    iova = ROUND_UP(section->offset_within_address_space, TARGET_PAGE_SIZE);
     llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
     if (int128_ge(int128_make64(iova), llend)) {
         return;
@@ -415,7 +415,7 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
         return;
     }
 
-    iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
+    iova = ROUND_UP(section->offset_within_address_space, TARGET_PAGE_SIZE);
     llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
 
     trace_vhost_vdpa_listener_region_del(v, iova,
-- 
MST


