Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBEC7CA466
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:40:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsK5Y-0007vV-2K; Mon, 16 Oct 2023 05:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsK5V-0007uB-Ie
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:40:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsK5U-0002jy-5w
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697449235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eVrQ3Ode1goRqOjVfbwKTkSqtROVFEsSIobhzqCWnaE=;
 b=BB3zkSPKpHfPQz/PJnfKsrsUQzitRCKbV4m24TeAwD8gSb9hEeu0/I6+rKxlK9UD/0BF0W
 dNRaftwDVb/GcPtLicNHGhPeYF8TJUKAvR7/hhoRgvldnM2pVw7w8e1QpZawlawuLMgYN4
 EliLbalGUFOSAUM9SoC5xpSNSplNIX0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-HBGexkDQNAGGhPyM0g_THg-1; Mon, 16 Oct 2023 05:40:24 -0400
X-MC-Unique: HBGexkDQNAGGhPyM0g_THg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9bd91ce3033so274850166b.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697449222; x=1698054022;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eVrQ3Ode1goRqOjVfbwKTkSqtROVFEsSIobhzqCWnaE=;
 b=jzK111nFYUEs2kudEN3iPMJ9BOtphDKmu2/4gF5OEWaaFQDuRX12E15kHnZH7CXZax
 i8CMypWBLJ/q3qFLzuPWaMmO+pECvcVyhrN66+6AxteELrBSXW+th5lXfcsQhFH7o+tJ
 sgKja9lx5gjuC29bIT5KTUgQvWK+VXSG8k98J9B8rIjxrQQvtjhno83Tsm17SnLmeI4M
 YXZiYlXdqzxLA1ut6L+42ua4B/avAfwlD/cO0Z0vR+z6CMYwruLFGl9tvh0psbFwKevW
 dHjyloi+Bz9zrRvqyda+CJE0xxtxH/WQMn0Ch0bvsRaMUieioMK7+ZX3eK0t7fC4gP0X
 8i2g==
X-Gm-Message-State: AOJu0Yyurt3ysfVpkp8ami8v58Y1bse0k1ptCq1vF1ctT2vtUIPAW0S6
 ndBSUmyNtJPJyxwATlICwaVPxPNypvxE2AbtAFe89ssrRoGa46IvgNr3gBd1QYYg2YXoLDwz2Wz
 j4e563V9r258B4Hzjonruvy+nNiraq4076QNlm3Uix8TzeC99aLdTHFL2AwENhaJ1qw2uBG8Au0
 Y=
X-Received: by 2002:a17:906:8b:b0:9b2:b149:b81a with SMTP id
 11-20020a170906008b00b009b2b149b81amr32556545ejc.64.1697449222525; 
 Mon, 16 Oct 2023 02:40:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBHDR1gbCqSsDjKKJJuUoXO6XPXEIzpx7ZAGWKF4EtODft/r5sEI8uXa+hxlL++ze/0LkxlA==
X-Received: by 2002:a17:906:8b:b0:9b2:b149:b81a with SMTP id
 11-20020a170906008b00b009b2b149b81amr32556539ejc.64.1697449222252; 
 Mon, 16 Oct 2023 02:40:22 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 17-20020a170906029100b00989828a42e8sm3690889ejf.154.2023.10.16.02.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 02:40:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] tests/avocado: avoid invalid escape in Python string
Date: Mon, 16 Oct 2023 11:40:14 +0200
Message-ID: <20231016094016.173598-3-pbonzini@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is an error in Python 3.12; fix it by using a raw string literal.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/avocado/virtio_check_params.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/avocado/virtio_check_params.py b/tests/avocado/virtio_check_params.py
index 4093da8a674..0b1e99fc24b 100644
--- a/tests/avocado/virtio_check_params.py
+++ b/tests/avocado/virtio_check_params.py
@@ -43,7 +43,7 @@
 class VirtioMaxSegSettingsCheck(QemuSystemTest):
     @staticmethod
     def make_pattern(props):
-        pattern_items = ['{0} = \w+'.format(prop) for prop in props]
+        pattern_items = [r'{0} = \w+'.format(prop) for prop in props]
         return '|'.join(pattern_items)
 
     def query_virtqueue(self, vm, dev_type_name):
-- 
2.41.0


