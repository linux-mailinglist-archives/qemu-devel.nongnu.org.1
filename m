Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D32AD0267
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Jun 2025 14:42:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWML-0006g3-Ct; Fri, 06 Jun 2025 08:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWJP-0003qV-0Z
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWJL-00061d-Qg
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rqC/toGRqED1KkT0crHa1j83NZQruIG+EZBTua+GSwo=;
 b=M8JMUQKHqrJ71c/9wUfOeY60peAFd3v+7kk3OPd93WHbsuuTDkUpI+ZYDVeN5tnN1yEckb
 vtgtcwl1Co6siBlFG48tL6LioLReqZad5JvwEydh02q9TJa1/A6+9jRcfG+/vFipO/Ru68
 wBk8lX4BoXRMcpNVm8+myzKO/c4puEo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-4XWQn4KfNSGW0ho14ioqHQ-1; Fri, 06 Jun 2025 08:36:37 -0400
X-MC-Unique: 4XWQn4KfNSGW0ho14ioqHQ-1
X-Mimecast-MFC-AGG-ID: 4XWQn4KfNSGW0ho14ioqHQ_1749213396
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so10413105e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213395; x=1749818195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rqC/toGRqED1KkT0crHa1j83NZQruIG+EZBTua+GSwo=;
 b=T0XYoCItzUfRrmpzKNea7WCSmuqsQJ4n33JxRDdbgzIJpuRiW7YV8PvQ5LBNlqSeZ7
 e+LGmfps6nQvFUccYW8ambl9pufPIpvEIPrzsAOjZTbce6ef5yzxJBAHeeDSxImHDn03
 5sMaRSqqsvgx+ICVzJaQtopebwx9MK80RggY4es8LgRWS0v3mckzdKxG+GQsDK2DtYAz
 TvMvnF/wArZIhwnDyz0asyYbixk0fj2YPHdDG48d4FpbZgRrR8Z6lPpODvc47YFuMAGE
 UPh/Ovi7JLPr0lzv1ae7ozGxGVQgZJPESyJrFXMX8SUsvkHsCGzvxJRHB3V0EQ1OPK4a
 AB0Q==
X-Gm-Message-State: AOJu0YyOMuyHPYgPPLvb4OjpIo9oT7I8e1c2c7b2pHLEE6nW69yiXGw8
 6cnZkfLznaVFcDpZZxC79iutTyV5aL8ZzynzFudZIgWgTflOcejSDxVnfj9UZ9CWcN8Y2fM036t
 xu/eCMDeIDYJlLdWowrgdYfXHYfYiIdPUYuzdpiHUiOqYiz6H9uSLKJlbFznWT3Fwt5Od9WRr7S
 sfuLQWVmKYjj25bHnUooS3KuoANaixxKhlh7GWN8N7
X-Gm-Gg: ASbGncvacimostrIJaCaStHpumBJFL7Nkb6XE+qyhrGRdES+MvVpuDidf6LJm/k3RWG
 hZhmpVdAN/4gf6AGDDhg3eaUxwSyvd7L+/dD8tK87VR0Tx4M202ymlfhMDzxvZY0WhEUMpZ+YVs
 tpIzpaLdy0a8pP1hhm/uj/b3j4LyTnf8GWXYP7cdFNykoyIz3vvwSSpX6+d9+gRKk7tL/hsi6aQ
 TflZvwG75gQ72kGNI+1OoqZNfLcvP38fTncGM8B9VOTpYhqK24rlqkR0d3Fp14Rig9JvSoYK6r9
 bZN00lahrrH0PUFvsOBhA6Pq
X-Received: by 2002:a05:600c:1c8b:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-4520128d3e8mr38077575e9.0.1749213395567; 
 Fri, 06 Jun 2025 05:36:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVz+DVfO7F1JTWWM5o8gq1ChnKLkb1JoWZUHfbppgg/iVU1vbYCXlNyW21kbxC+P6HpNdBpg==
X-Received: by 2002:a05:600c:1c8b:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-4520128d3e8mr38077235e9.0.1749213395047; 
 Fri, 06 Jun 2025 05:36:35 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4526e163447sm19828035e9.17.2025.06.06.05.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:36:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 31/31] tests/tcg/x86_64/fma: add test for exact-denormal output
Date: Fri,  6 Jun 2025 14:34:45 +0200
Message-ID: <20250606123447.538131-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

Add some fma test cases that check for correct handling of FTZ and
for the flag that indicates that the input denormal was consumed.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250519145114.2786534-5-peter.maydell@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/tcg/x86_64/fma.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/tcg/x86_64/fma.c b/tests/tcg/x86_64/fma.c
index 46f863005ed..34219614c0a 100644
--- a/tests/tcg/x86_64/fma.c
+++ b/tests/tcg/x86_64/fma.c
@@ -82,6 +82,18 @@ static testdata tests[] = {
      */
     { 0x3fdfffffffffffff, 0x001fffffffffffff, 0x801fffffffffffff, true,
       0x8010000000000000, 0x20 }, /* Enabling FTZ shouldn't change flags */
+    /*
+     * normal * 0 + a denormal. With FTZ disabled this gives an exact
+     * result (equal to the input denormal) that has consumed the denormal.
+     */
+    { 0x3cc8000000000000, 0x0000000000000000, 0x8008000000000000, false,
+      0x8008000000000000, 0x2 }, /* Denormal */
+    /*
+     * With FTZ enabled, this consumes the denormal, returns zero (because
+     * flushed) and indicates also Underflow and Precision.
+     */
+    { 0x3cc8000000000000, 0x0000000000000000, 0x8008000000000000, true,
+      0x8000000000000000, 0x32 }, /* Precision, Underflow, Denormal */
 };
 
 int main(void)
-- 
2.49.0


