Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E084771D8B
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 11:52:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSwqm-0001kZ-04; Mon, 07 Aug 2023 05:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qSwqb-0001Nu-1V
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:48:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qSwqW-0003N8-Mv
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691401696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9D2kwUXcWHuqKCZpSeVBwl7AeE4LL/xDIP2bwX4TNM4=;
 b=Q0c4NqqnuoqFF7xWqp5k0g3lVcx0DGQ2/5yMQnAusVChSA20g/kk56uxknNbQAPO08Zs61
 iMbgbNaKQPXzZEFz3vFY/Q84hLP9mKOSfXLPckh5Ly3CXYtbMaBotH/WZTSS86sKiom6Ht
 1tC8FnrjUUc4N/SBn76OM9Or2WYTIRk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-zeW0-wrjOyK0XVUOrXu6sA-1; Mon, 07 Aug 2023 05:48:14 -0400
X-MC-Unique: zeW0-wrjOyK0XVUOrXu6sA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe13f529f5so26377565e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 02:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691401692; x=1692006492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9D2kwUXcWHuqKCZpSeVBwl7AeE4LL/xDIP2bwX4TNM4=;
 b=chgfmfip4PjwgG13nw521a3R0BFVXmaZh8VCR660NWZru1uSU4WDTKemwf7HL5vP0u
 DyzeBtRjePKjd3bR8VBFSUxiXahIx5/Ibok3FNflwCXe9IaSP4IFH9jI5Gv1znF1851G
 fE6nHD/DIv/5tw51pA4nwRt253bDIDEOh/unEaYGCmZL1N4zkCmUtY0xnKVano1uvnnG
 dnLEyn0KROJEBnipZs5uWvVfwP9NIfojOUkR6LNicbZaajZXtho7WCH3CoLCcaHve7cF
 1nyejZEg15tSYEP7oy4wM+MITOr4aOc4yDG43lkQn0428uHBt6cUFpBNWOkRSfbnyYw0
 dbWA==
X-Gm-Message-State: AOJu0YyDgXBZxoJ5EPlU/1ODAZFHdfwdo6iuhhDr9pKE8y2Iu3QGxrBD
 BoZ0Ecd/RnjwBXZqDFEjo745ZEIMsCXf/WoiVHnuK3/grW0qOI37SZhT8ElDbS9fMfgYaBc1Rw/
 SF2bkQoYJGBBg6dWX+2SF6hp9gF4mgPEUMmIz+wVlYLHXzz8an63xuE5TbulQQXlln/mkJj5vF7
 w=
X-Received: by 2002:a1c:7706:0:b0:3f8:fc96:6bfd with SMTP id
 t6-20020a1c7706000000b003f8fc966bfdmr7206483wmi.17.1691401692719; 
 Mon, 07 Aug 2023 02:48:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjfpGAwAJnghiEky8peXAymVJTQsO2qN/GcF8RPLMdpySp1/GyTm4yX8wQvf0siVB84ugX/w==
X-Received: by 2002:a1c:7706:0:b0:3f8:fc96:6bfd with SMTP id
 t6-20020a1c7706000000b003f8fc966bfdmr7206470wmi.17.1691401692421; 
 Mon, 07 Aug 2023 02:48:12 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 n20-20020a7bcbd4000000b003fe557829ccsm5658528wmi.28.2023.08.07.02.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 02:48:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [PATCH 1/3] configure: fix detection for x32 linux-user
Date: Mon,  7 Aug 2023 11:48:05 +0200
Message-ID: <20230807094807.471646-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807094807.471646-1-pbonzini@redhat.com>
References: <20230807094807.471646-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

x32 uses the same signal handling fragments as x86_64, since host_arch
is set to x86_64 when Meson runs.  Remove the unnecessary forwarder and
set the host_arch variable properly in configure.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                                 | 2 ++
 linux-user/include/host/x32/host-signal.h | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)
 delete mode 100644 linux-user/include/host/x32/host-signal.h

diff --git a/configure b/configure
index 98dc78280e6..484d38d81f4 100755
--- a/configure
+++ b/configure
@@ -472,6 +472,8 @@ fi
 case "$cpu" in
   riscv*)
     host_arch=riscv ;;
+  x32)
+    host_arch=x86_64 ;;
   *)
     host_arch="$cpu" ;;
 esac
diff --git a/linux-user/include/host/x32/host-signal.h b/linux-user/include/host/x32/host-signal.h
deleted file mode 100644
index 26800591d3b..00000000000
--- a/linux-user/include/host/x32/host-signal.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "../x86_64/host-signal.h"
-- 
2.41.0


