Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF8278AC87
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 12:41:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaZeo-0003RZ-Jn; Mon, 28 Aug 2023 06:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeb-0003Of-2p
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeX-00058R-2I
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693219164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5xDtDpdOBwZhBAew8Hu/OwGzF2f6d9EDmRfFAUzZmA=;
 b=DtZuOxAZ5k5DmxvHfI3/bIZrqBnMTP6zxCgXve5XA3lGBaFXaisHRnfYt1BHqD8tZxl1zq
 Jf06lSzYeXiEbGKNv2VowAkitnxNEZvRFDMyoU9wXhTyQYIiBR2GR1BsZcgV9Z/XZm3UAI
 RPBXvznOlw+heBbMIwJfYblsBPDpjHo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-0wh2XqtXOlWlZstkg4rkZQ-1; Mon, 28 Aug 2023 06:39:23 -0400
X-MC-Unique: 0wh2XqtXOlWlZstkg4rkZQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4005f0a53c5so24860745e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 03:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693219161; x=1693823961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t5xDtDpdOBwZhBAew8Hu/OwGzF2f6d9EDmRfFAUzZmA=;
 b=JA1I30/a0RWQ+Mz4qvoRDdYBiiXVAaF8ufF9HBER6fA9aGshrELaQydlAbD1CDbeY6
 FSmbLQ6PFkDgWxaH5WP9tU3FGpRZHoQkiPx+9tUGMtjSk+VLEsZXZOWuK+VSKh0iKrGO
 v28mlQw49PiZ9ZpDGMeqnzydTLrAcLVu35/mXIPiRUT81fsjsQir9u+1GBFfOiO5CkDB
 VKUPlRci1tjsBcN7JzABnGd7Q2e0tVQG0h3sJuqON91b9XJKPTZMvfWJXSxSDTuUPPt/
 TrcgmJuimGfwdQQMdVZMub1gftP0x2p4vSc0G5Ufu1A3I0uBCD3gaIBQeC1jNGaofzOq
 uLXg==
X-Gm-Message-State: AOJu0Yy6Ed+opLNhOhYZdshGzYEXnlLSZ68vPRbJwXs6LNF5gaCheyxW
 5qoBGEOcaI+4/cZrXmAnENGnbXUh3oR++mCeXvJ03R5ECAdPxfAYpspd24/We2I2Y46Bk15swTv
 Gy1Pe+Gk70HZ1hx9jmQ708xjJVpdkzbsWDbi9OHkp8x1aTbZh4HLUw/20r8uCfc3za0D5Liyf6z
 Q=
X-Received: by 2002:a7b:c34d:0:b0:3fe:2e0d:b715 with SMTP id
 l13-20020a7bc34d000000b003fe2e0db715mr19944004wmj.18.1693219161487; 
 Mon, 28 Aug 2023 03:39:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNXQVmp0cuvY4AA2YTA6peOmRbXulEf2axsmoQOGTmGFTyS80Bkzj1BfR3rF5zCRH1Ti5zog==
X-Received: by 2002:a7b:c34d:0:b0:3fe:2e0d:b715 with SMTP id
 l13-20020a7bc34d000000b003fe2e0db715mr19943993wmj.18.1693219161167; 
 Mon, 28 Aug 2023 03:39:21 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 c12-20020a05600c0acc00b003fee6f027c7sm13444915wmr.19.2023.08.28.03.39.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 03:39:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/14] configure: remove unnecessary mkdir -p
Date: Mon, 28 Aug 2023 12:38:53 +0200
Message-ID: <20230828103856.46031-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828103856.46031-1-pbonzini@redhat.com>
References: <20230828103856.46031-1-pbonzini@redhat.com>
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

It is already included in the symlink shell function.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure b/configure
index 08bf24b689c..b9bd008592a 100755
--- a/configure
+++ b/configure
@@ -1775,7 +1775,6 @@ fi
 for target in $target_list; do
     target_dir="$target"
     target_name=$(echo $target | cut -d '-' -f 1)$EXESUF
-    mkdir -p "$target_dir"
     case $target in
         *-user) symlink "../qemu-$target_name" "$target_dir/qemu-$target_name" ;;
         *) symlink "../qemu-system-$target_name" "$target_dir/qemu-system-$target_name" ;;
-- 
2.41.0


