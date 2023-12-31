Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 819E1820A9F
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:53:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrUs-00082v-VP; Sun, 31 Dec 2023 03:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSv-00057o-4f
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSm-0000qU-0D
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5St6V/X9aWWovQ3ck81QWi8L/g+CG2amW8js8n1+mn0=;
 b=VahYHfeuCjKThouq5PHWEkLE5a3r1PRr0yyPMztADlr9/xmHJt4airf9s9IsY2dFzaevB2
 L9XKLXQ7AV2I1FMfqWTlvZUGiRcWSOAowmhUnlp00Mc4APj3pqs9etl51H/W5r4n92FLRr
 +pLcHBkSBT8RUXlDW8dqEbWbGYkX+Lw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-N0ZyMQKdMKuK-cayjBKhCQ-1; Sun, 31 Dec 2023 03:46:18 -0500
X-MC-Unique: N0ZyMQKdMKuK-cayjBKhCQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33688aa4316so5019305f8f.2
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012377; x=1704617177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5St6V/X9aWWovQ3ck81QWi8L/g+CG2amW8js8n1+mn0=;
 b=bAOnnnVVT8emfeLazk1+orYjAQu8ph0vIdicoLgecpwcsAwMiATFbJStXQIg1awiDx
 aOwSZH8Bnf6shfNv1RezVMt53T/QJ+52wIMWzQOYrVPnwPjtbFD489aC6lkl+zrL2l22
 mmbJIg2qhOjdCpSYpwLCwfMSwbQqAy5psN4AszqnBsmzH7pBkxSwjv7qUht4baNYHiEX
 8Nzr2ho0iYq5xp8d4FWd1HWhAYWHczBE279W3Ivle4YPdBUhHtA4wWeRX0NDem4CfNtq
 mGoYK9LsqUAlCkhMEX0BZ6AkGKs6RBYWhDpR9SbAM1EORizDVRZoT/Ro+HWojyRJuXlX
 B3Dw==
X-Gm-Message-State: AOJu0YyFfKUBzn5pXhSbkFAX4ziBLcfNXzB9oLag7i4hfN1LqYeqs/D3
 BdZYKKCYMcIbNql44F5+THGF15MvnFb4wkJVauQlfsutNdkYUrDiTQvdsItWYJcV97KgstmQLSC
 8Qg0FmOlpPFe4hicKr1H3t2WbHIDHB794vwCZqc/yCDB8RpNDhiQ109qrnfeFn4kS+XTlH96Z+T
 jG0EMmOa0=
X-Received: by 2002:a05:600c:4686:b0:40d:4dce:4a2e with SMTP id
 p6-20020a05600c468600b0040d4dce4a2emr8662049wmo.26.1704012377267; 
 Sun, 31 Dec 2023 00:46:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHhhQjAoVz7glahG+JKjRJxqmIlcdgM15DqYFw+3oScgnJkgFszWVla2hZu30dO0mn5HQd7w==
X-Received: by 2002:a05:600c:4686:b0:40d:4dce:4a2e with SMTP id
 p6-20020a05600c468600b0040d4dce4a2emr8662043wmo.26.1704012377033; 
 Sun, 31 Dec 2023 00:46:17 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 fb8-20020a05600c520800b0040d87b9eec7sm888060wmb.32.2023.12.31.00.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/46] meson: remove unused variable
Date: Sun, 31 Dec 2023 09:44:42 +0100
Message-ID: <20231231084502.235366-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/bench/meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/bench/meson.build b/tests/bench/meson.build
index 3c799dbd983..7e76338a52d 100644
--- a/tests/bench/meson.build
+++ b/tests/bench/meson.build
@@ -3,9 +3,9 @@ qht_bench = executable('qht-bench',
                        sources: 'qht-bench.c',
                        dependencies: [qemuutil])
 
-qtree_bench = executable('qtree-bench',
-                         sources: 'qtree-bench.c',
-                         dependencies: [qemuutil])
+executable('qtree-bench',
+           sources: 'qtree-bench.c',
+           dependencies: [qemuutil])
 
 executable('atomic_add-bench',
            sources: files('atomic_add-bench.c'),
-- 
2.43.0


