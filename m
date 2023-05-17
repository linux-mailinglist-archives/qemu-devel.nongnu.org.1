Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC172707060
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 20:03:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLEa-0000PA-Iu; Wed, 17 May 2023 13:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEW-00009O-VK
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEV-0004Mo-C9
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PP9Xn2n4ChTkZoiiBSEFm8Q1rGJycAE9rbs4ej+xjbs=;
 b=SK1qlQCbB9h71btmdb8x1fxE4k3S24UPYBGL5aKXWAALnQPVm2vQfeRha+FJ7Y4Q1c2i9w
 fRF7Z18yHmL5vWiUTRhqj8QWCFCKR4F/yDwSJOY9dGj/vTNFAG8TKQ/oQgdQmK2eceZDtz
 G8VEhIhaO7DZ8w481InQHp0U0Otw2bc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-80YKyLFAO2uSE2QvQFyjSg-1; Wed, 17 May 2023 13:46:35 -0400
X-MC-Unique: 80YKyLFAO2uSE2QvQFyjSg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f4221cd284so4439395e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345594; x=1686937594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PP9Xn2n4ChTkZoiiBSEFm8Q1rGJycAE9rbs4ej+xjbs=;
 b=CGYSCTKV8vVkkdCGVaMndH/tTECrhxgcaeosb0dM64hYseHCv+3LOdAIjPaG/cr97C
 hnHnsa7qDVouhW+vZjUMxYiJHZnh2kX9fdxbHKEHZ/qzuaYZKGECNdHNajfH34brK2Eo
 sb9AzbMJTB4lw5CLayCcnJO7YtJoyxVcMnN8izyAt2beSMCNT4IhWUM26FIa0Lx4ubBf
 R8x8DPzfC3okoFyKov3VWnM9krKkdDNe4uaHPJWIzIj4Zokw54486pdQ4HupH/9EOPnV
 XblDIJ1FzhqbOD/PFl7KDfadGK9m9fs9QTZBIFfqxYan3cV8Mv2BMLq2ajdmELKovacU
 0BSA==
X-Gm-Message-State: AC+VfDym7rgn9zZwxfJD3IciFbni9g0lVL/1/bBCGfFLa5G/giaaSJOC
 mJgoA7fwRyRzlc+77MEIZ6hYrE+gDeRLlelM1gRKFn+nZgimdfaVYG1JJ5tuGG8y5T6cI+N+K+J
 rGop5zp4TH0o9j7qg1Rmi4a3rt2jFFSLCQo1rh0BwxwzhdS+gY59Za3FmMqSKNBaZqnL1TwKdd2
 8=
X-Received: by 2002:a7b:cd04:0:b0:3f5:d0ba:3c1a with SMTP id
 f4-20020a7bcd04000000b003f5d0ba3c1amr1817495wmj.4.1684345593986; 
 Wed, 17 May 2023 10:46:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6fJcUAbKBIvSP5I/Gw0xVF8wuxHuhJyBkokoMOm+JImIsgL0DLZiBIeikRUUrAu4q36GCb7w==
X-Received: by 2002:a7b:cd04:0:b0:3f5:d0ba:3c1a with SMTP id
 f4-20020a7bcd04000000b003f5d0ba3c1amr1817489wmj.4.1684345593755; 
 Wed, 17 May 2023 10:46:33 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a7bca49000000b003f3157988f8sm2903585wml.26.2023.05.17.10.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PULL 43/68] mkvenv: mark command as required
Date: Wed, 17 May 2023 19:44:55 +0200
Message-Id: <20230517174520.887405-44-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This is only available in Python 3.7+.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-26-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index 558619910efd..8c036c019aaf 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -854,6 +854,7 @@ def main() -> int:
     subparsers = parser.add_subparsers(
         title="Commands",
         dest="command",
+        required=True,
         metavar="command",
         help="Description",
     )
-- 
2.40.1


