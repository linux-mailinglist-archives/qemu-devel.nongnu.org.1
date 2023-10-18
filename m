Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B681E7CD677
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:30:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1uW-0000Tz-MB; Wed, 18 Oct 2023 04:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uU-0000PQ-U5
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uS-0003ZB-Rk
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZvnDkgkojYakbouPNQnSNioH7Xg+71/AImlTm5h72Ow=;
 b=H1Pdc6hWTvovxSjLl8o7kpa3RhL4ozzEj56AAKz0WLz1LfYBT+ObaF6CiinMdVDJQ6z1S1
 6QomSEPteXYtT72scQFZBCBRc1qjcEjL8d8tA6dSlAAsVax63DYWkcYktXu+vjEO68tShd
 xY1kBNSUZtM/as+2WoSXYVJ/Hj+bVCg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-B7t_9HZfMduqfynNgdd7uA-1; Wed, 18 Oct 2023 04:28:06 -0400
X-MC-Unique: B7t_9HZfMduqfynNgdd7uA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5362b33e8ffso5105291a12.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617684; x=1698222484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZvnDkgkojYakbouPNQnSNioH7Xg+71/AImlTm5h72Ow=;
 b=c1s4RzK1YP8O64gNGL2VpZeQuuko1+C4oaGcGxSDnc4WCyns8aTwiBsr5W9yviSNWM
 6jNfiTHhD5P4QutBpGtTRUFwLdScvuLvujsznGn92MTpSkUg93QPww0xNntYwbb9AZ5Z
 q2kEIwODxwz2EcULqULKzxs0iQtFtfA6QT4AQ9OtO/gSQfkQn/QRNhaJ1oqCAiBQj8M5
 x6bfH1XKp9+m0qClTeUz6hSjOUNaegb4Ug8MQiUUWrkhv/wlZxiaeMhI/haj3OvJz5Cx
 p2WW/Ck/7Hk6nsn2LF+u7u+zEOj3iG0OLJXZnRYvyNmuYPYhuhiZk5MjTCXx3kcnX3CI
 i2PQ==
X-Gm-Message-State: AOJu0Yw7Wn1Vt+IijmMR7bQBW3gRAeGESFaof/o+Rnf/LvrsQ7nM3UPX
 hPxLisYiaIMGKVa6grnVzDr1QAY/n10HRKmSvTl/uxohw9hP1AlplImSAXsIObGQNWji9AmbvhM
 U2KPG5vWwBSZxfptmy3UfVL8qFi6Mpey8nZA/M5DNWfse947MlRXDewbtjmu3lIxsPrl6Yke2Ch
 w=
X-Received: by 2002:a50:f616:0:b0:53e:6f96:dcf with SMTP id
 c22-20020a50f616000000b0053e6f960dcfmr3187527edn.34.1697617684553; 
 Wed, 18 Oct 2023 01:28:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/FlKvS+wayjuaWYqMSY2DBn+TOCwqdqJrnF/l+E8wTZ3+cp9zEw8VZ28e7dktTaq6jmRWtQ==
X-Received: by 2002:a50:f616:0:b0:53e:6f96:dcf with SMTP id
 c22-20020a50f616000000b0053e6f960dcfmr3187518edn.34.1697617684179; 
 Wed, 18 Oct 2023 01:28:04 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 cx11-20020a05640222ab00b0053da777f7d1sm2386753edb.10.2023.10.18.01.28.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/32] target/i386: check intercept for XSETBV
Date: Wed, 18 Oct 2023 10:27:25 +0200
Message-ID: <20231018082752.322306-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
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

Note that this intercept is special; it is checked before the #GP
exception.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/svm.h           | 1 +
 target/i386/tcg/translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/i386/svm.h b/target/i386/svm.h
index f9a785489d8..1bd78447306 100644
--- a/target/i386/svm.h
+++ b/target/i386/svm.h
@@ -132,6 +132,7 @@
 /* only included in documentation, maybe wrong */
 #define SVM_EXIT_MONITOR	0x08a
 #define SVM_EXIT_MWAIT		0x08b
+#define SVM_EXIT_XSETBV		0x08d
 #define SVM_EXIT_NPF  		0x400
 
 #define SVM_EXIT_ERR		-1
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d2061ec44a0..4f6f9fa7e52 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -5916,6 +5916,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
                                  | PREFIX_REPZ | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
+            gen_svm_check_intercept(s, SVM_EXIT_XSETBV);
             if (!check_cpl0(s)) {
                 break;
             }
-- 
2.41.0


