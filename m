Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A467BB61A
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:15:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoinS-0008SZ-3T; Fri, 06 Oct 2023 07:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinO-0008Pc-3M
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:15:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinM-0000NP-8r
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mCVCUOq7aVspI9V9Yn5TanbFRt42+uPiRwJWugQqYU4=;
 b=LbUq93gSpIjDT8oIKIj7QqovCO9heHKrHkfx2g9K88i91dD3oA5RkdXE6wI2apllg9mbTD
 UCMXhvne9ryDLEJRMlvNzR45Rclw0aE+otp+CLAdb0FCUjgMBS5So4a8xGuP6T29P8zcc6
 TSsk+YcUv00PrM6a+u248KO0ULr7/2Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-WoaR15IgMMSlSMQck1vimA-1; Fri, 06 Oct 2023 07:14:43 -0400
X-MC-Unique: WoaR15IgMMSlSMQck1vimA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-99c8bbc902eso169931066b.1
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590881; x=1697195681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mCVCUOq7aVspI9V9Yn5TanbFRt42+uPiRwJWugQqYU4=;
 b=JEdwZxa5ssVWoQnwniK3K3gxTSFIFAGoUNBZFAy0NuIFAYxUUE69xa7K1YTVG1WQE3
 ieKepamokPLN64qctYWJu6lg010iCoBm3NOIyWPZSm+2EdiIdOg1CcFgzqEq4HK4i1c5
 Qj3iA93betEYVk/NqMa4t6sWk79tt8F08LY45VeK7BaJtTw8tQF+DhFR2VkAtFHxd8nm
 YjB5EUb2qCtIr6MvVcBl/1wdlhmJxLZ5+8TSH0jVfD6ZE1ITC4HZfz51+3SHqM9uGSt2
 wx4yQMqddi+yuihkG9FljTpUkqq/AeYDxfeU5ktpd1QhRKx/v2SO+3Qi7gDIWPz6lKFJ
 j8NA==
X-Gm-Message-State: AOJu0YwMhozCH66jkbeqqvan3jQigEJ3qIeleoK0Dz8re/6tNJucLjiE
 oJK9eWj6PiqWdO0SsYiP7xR/hRzUn4bMtMGD9dU9sWbwhzwwf5YfsjFHqfcp7nEVvLwF03SQte/
 zAEWjXwkc1aWnEEU1HDZlEihZkEPON9CAS72I9lX08WS4bFwpgUiGmRBunidBwO8yQlE8Nmkaze
 c=
X-Received: by 2002:a17:907:2722:b0:9b2:7f8c:ac09 with SMTP id
 d2-20020a170907272200b009b27f8cac09mr6995109ejl.6.1696590881680; 
 Fri, 06 Oct 2023 04:14:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpOVyhkTOWqQez/VSu34+iTjT2i9mDiBNp2WvXyPjAAmFiQLXs868LfuivVJon/rmqJuwzSQ==
X-Received: by 2002:a17:907:2722:b0:9b2:7f8c:ac09 with SMTP id
 d2-20020a170907272200b009b27f8cac09mr6995098ejl.6.1696590881359; 
 Fri, 06 Oct 2023 04:14:41 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 kb4-20020a1709070f8400b009adc81bb544sm2691932ejc.106.2023.10.06.04.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/26] meson: Rename softmmu_mods -> system_mods
Date: Fri,  6 Oct 2023 13:14:01 +0200
Message-ID: <20231006111412.13130-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
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

See commit de6cd7599b ("meson: Replace softmmu_ss -> system_ss")
for rationale.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004090629.37473-12-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 21a1bc03f87..8890dc57480 100644
--- a/meson.build
+++ b/meson.build
@@ -3496,7 +3496,7 @@ modinfo_generate = find_program('scripts/modinfo-generate.py')
 modinfo_files = []
 
 block_mods = []
-softmmu_mods = []
+system_mods = []
 foreach d, list : modules
   if not (d == 'block' ? have_block : have_system)
     continue
@@ -3510,7 +3510,7 @@ foreach d, list : modules
       if d == 'block'
         block_mods += sl
       else
-        softmmu_mods += sl
+        system_mods += sl
       endif
       if module_ss.sources() != []
         # FIXME: Should use sl.extract_all_objects(recursive: true) as
@@ -3554,7 +3554,7 @@ foreach d, list : target_modules
                                 include_directories: target_inc,
                                 c_args: c_args,
                                 pic: true)
-            softmmu_mods += sl
+            system_mods += sl
             # FIXME: Should use sl.extract_all_objects(recursive: true) too.
             modinfo_files += custom_target(module_name + '.modinfo',
                                            output: module_name + '.modinfo',
@@ -3597,7 +3597,7 @@ block_syms = custom_target('block.syms', output: 'block.syms',
                              capture: true,
                              command: [undefsym, nm, '@INPUT@'])
 qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
-                             input: [libqemuutil, softmmu_mods],
+                             input: [libqemuutil, system_mods],
                              capture: true,
                              command: [undefsym, nm, '@INPUT@'])
 
@@ -3682,7 +3682,7 @@ common_ss.add(hwcore)
 ###########
 
 emulator_modules = []
-foreach m : block_mods + softmmu_mods
+foreach m : block_mods + system_mods
   emulator_modules += shared_module(m.name(),
                 build_by_default: true,
                 name_prefix: '',
-- 
2.41.0


