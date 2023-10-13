Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F38627C88B3
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 17:32:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrK7a-0002RS-Gz; Fri, 13 Oct 2023 11:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrK7Y-0002QK-2n
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrK7W-0002aO-GX
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697211033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=D6hjwGZmNcx+A7BWDawXZwO4gTxAMCMOfXHlsCPuFro=;
 b=Eaho9oflmwywKLVNb+qI8/QH+pWIcgeZzk3osbLF2N7dpSy334k7sXCLxoFLX/oGpVUCSM
 hw+mO+b22eINYFpyVo1YK4fX+9iiHgvBslmV7YT87G2XLvh7SxuA+BXi46J1XyoNxzcR4D
 Q88wgn0+D+VhlORKIrJGB3IOoY/RKBk=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-QE6gKBONP16E3_IbNDqCig-1; Fri, 13 Oct 2023 11:30:31 -0400
X-MC-Unique: QE6gKBONP16E3_IbNDqCig-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3af85efc4a3so3406309b6e.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 08:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697211030; x=1697815830;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D6hjwGZmNcx+A7BWDawXZwO4gTxAMCMOfXHlsCPuFro=;
 b=FlIkMiP8wlQ6H3iol3GQjPrd0ouVt1TSixLaoRy6ovjpUXv/E1ybJfDmX2y7QlXEi6
 8f3z6es5ioozx6o9C7jPv5+lr/XGF6vWHQ9ZBLlUX9Koj3eFqxbYHNWx/2DMjVjF28KI
 87N1la9QR81G1t7+8qnw2SU/3joyQgjBDiX8SvipnLzbjkR77NFQR5aIcod2MLqiWw+k
 SHHjxtMh6m+DfQhzSrC+HZKmVFVhvUkfQnvE38L2x0WznTO3wqwIXY5OPSjKIxt9MdTp
 h0wLiGgpWKucg6NBnk5CA6Nbq0Y8bympRFkTKLZ9bloucdGzNQg3o1ZhAhEZj665HSIF
 6a/w==
X-Gm-Message-State: AOJu0YxDGPszD2iUb+1ktafw/d9BwZmiEE3AkmqP11V3pCsk2KBl39ih
 H/wuJ8UbOoSChcRwCIRk3B3tL6PhnZj2rMeIIoNGRN5bfPzT+L0/ZkrX/4Q+X4J3BEjF/vDIXpf
 7L0GBBiOVQYVPusfeydZjcCJKHG+ohbaKN/EiBUKCLM1ye1vxDmpYUuwnsRbnUbtuHn/A6vyvyN
 c=
X-Received: by 2002:a05:6808:f8c:b0:3af:66e5:5d3c with SMTP id
 o12-20020a0568080f8c00b003af66e55d3cmr36797602oiw.26.1697211030638; 
 Fri, 13 Oct 2023 08:30:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKsoBAyt6wm3gKSBN9tQxS3OFD7TYEOBhKFkXGFcGhV4c2Vnkae8oM032+VAGifNjRHt9Kxw==
X-Received: by 2002:a05:6808:f8c:b0:3af:66e5:5d3c with SMTP id
 o12-20020a0568080f8c00b003af66e55d3cmr36797586oiw.26.1697211030259; 
 Fri, 13 Oct 2023 08:30:30 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 z10-20020ad4414a000000b0066d1348bdddsm746133qvp.44.2023.10.13.08.30.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 08:30:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/vm: netbsd: install dtc
Date: Fri, 13 Oct 2023 17:30:27 +0200
Message-ID: <20231013153027.800327-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Install dtc as it is now a mandatory external dependency in order to build QEMU.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vm/netbsd | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 939dc1b22a1..3ef1ec2d9cc 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -40,6 +40,9 @@ class NetBSDVM(basevm.BaseVM):
         "gsed",
         "gettext-tools",
 
+        # libs: basic
+        "dtc",
+
         # libs: crypto
         "gnutls",
 
-- 
2.41.0


