Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A9581BCF4
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:21:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGMiY-0007WU-B3; Thu, 21 Dec 2023 12:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMiT-0007W3-3e
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMiQ-0004Sh-CZ
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703179209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7KHsaL4UQVL7EB67oxOli3jIm09+5F03qAdq+7G5z8A=;
 b=gpLLUEzN0/QBqmeyC5URdXay15y6m26kFt4PLmPyR5q+6fMx0QKa19QYsI+RlIoKpDsyse
 iOhqdiCkXRWitZ2LNnN7/U28Lc4bOGo83P/zt/JW6BboD6dnxWz2LApX0DYGU0xL0UOSVK
 azVDg1qWBqr5ZcNqeQMRNcYrPqHDqeY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-qHULxM2mPBu4aY2SN65ZFA-1; Thu, 21 Dec 2023 12:20:08 -0500
X-MC-Unique: qHULxM2mPBu4aY2SN65ZFA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40d39a425bbso7559455e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:20:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703179206; x=1703784006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7KHsaL4UQVL7EB67oxOli3jIm09+5F03qAdq+7G5z8A=;
 b=uQQyNy8KswTaFshf5Y84+NkLRzRwhbKw6zv5gnWadt56hsxPtbZHPnOsxNVHQ6u/1V
 btTNjrvuj/qQZ5/P+O6PolIf4Dv9KxtAdJD3GNYETl9qp99c3koZlXoS8IJ+muG7ZJ3P
 BHzPUdT21YJxLudd+Ad8nawy+Vfl9rxdsYdZtmkJZPwWu1cGhWAP0om87yzadkGy64Vy
 QE2WfepWyXsi9zuu5Hp6Fz6gVhDx9dw+Zm0WJ/m7OSC3QKQEiAJ6w7fSVg/tcI1vzk60
 t7JohfI4P4EvBF2VIb+1FwuDb9h3JWCrD2v5uAYFm8eUyEXJPt6PQZI29XerRa8gM6ur
 I9QA==
X-Gm-Message-State: AOJu0YxzDUkNozhaiHywtKjWWPIZLuEnY3afXMfupMlD2CvWF1VO+Q7l
 XKnGKywSg8SpgknenMzBEeZqUOjSwZU39Bo5I35xnK3Q/ulQ0tATKyfsThtBrha9SBPuN2IQHHs
 INUBYVLgVKuzyJ8xMUtG6e+U+LSekCGOnXxYo2n6YlyVcaW6S7DaRWOl8+x8RvXoWQeyRupjQB9
 s0hWPSVoY=
X-Received: by 2002:a7b:c3c6:0:b0:40d:3c5d:b2e3 with SMTP id
 t6-20020a7bc3c6000000b0040d3c5db2e3mr42271wmj.81.1703179206212; 
 Thu, 21 Dec 2023 09:20:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgRCM8MSsEZYKAuSpXQ5DEHlq5cOxLBFTe/7kgCyBhh1v8yzD64apT6H/xmCeCJCrH5BS/Ew==
X-Received: by 2002:a7b:c3c6:0:b0:40d:3c5d:b2e3 with SMTP id
 t6-20020a7bc3c6000000b0040d3c5db2e3mr42268wmj.81.1703179205801; 
 Thu, 21 Dec 2023 09:20:05 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 b6-20020adfee86000000b00336344c3c3fsm2448885wro.90.2023.12.21.09.20.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:20:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/21] meson: use version_compare() to compare version
Date: Thu, 21 Dec 2023 18:19:40 +0100
Message-ID: <20231221171958.59350-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221171958.59350-1-pbonzini@redhat.com>
References: <20231221171958.59350-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

While a simple lexicographic comparison usually works, it is less
robust than a more specific algorithm designed to compare versions.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qga/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/meson.build b/qga/meson.build
index ff7a8496e48..a6af614891a 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -140,7 +140,7 @@ if targetos == 'windows'
       qemu_ga_msi_vss = ['-D', 'InstallVss']
       deps += qga_vss
     endif
-    if glib.version() < '2.73.2'
+    if glib.version().version_compare('<2.73.2')
       libpcre = 'libpcre1'
     else
       libpcre = 'libpcre2'
-- 
2.43.0


