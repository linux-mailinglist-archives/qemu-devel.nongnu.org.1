Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B78797283
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:02:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEdJ-00039o-Jc; Thu, 07 Sep 2023 09:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEd8-0002tO-A4
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEd3-0007KR-JG
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dArbTK+KzhT/gOPgG3uYUWvS6zno8A51atqiaGekGRM=;
 b=OehsFquAz7bnHDTudj97wn8olxUNqLvyskijMcsBKlVOrxah31qo9j6CE4/vCL9xmwCcDR
 WO6ZWUGHZTxZrNWPcP3dLoyFVmZP1ZsmLa/7XprbpgRz39Sfk+8A8kumRRL49L2YN0+2k/
 VzO8htix5oLymX5VT1m8cePlOF/65Is=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-TZvHyHd4NYG0g3XwHTTcvw-1; Thu, 07 Sep 2023 09:00:54 -0400
X-MC-Unique: TZvHyHd4NYG0g3XwHTTcvw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31c470305cfso553572f8f.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091651; x=1694696451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dArbTK+KzhT/gOPgG3uYUWvS6zno8A51atqiaGekGRM=;
 b=bFEi5NhV5Frpv+UgavmaNziAoz9mbWk1LnX+S4br0rCaEQNBEuO4HCtONd7fqfattv
 U89AJl/yRvfl6orCQRUt1+3b8cnMCZsX0LvADFtZBYmypt1zjezhrdXQgnllc6t7yTLn
 I+V83FihNtjMrPDDB+DJPM8DqZmZqICoKB/H/4UJl10n3dk49uylofQsFNj3j2A7Bzka
 EirUinkstMHVq6b5TgxLwimU45FUIyD76XsZaWyAshhl4DN1DSyZ4dO+E25oF6OV1pCP
 dBzkENSxqX0Qu7rR5wq7lgI2hdagAtPMe0syYvVYL/nfOAPDAfGttVltR2gp8UtegaOi
 tWAQ==
X-Gm-Message-State: AOJu0YyhAUHD5uXDfBIunIygm7fimMHcT3qK4KMXfzdidTWMXe4sYSP/
 6Vdnf3k8lZZQDAcCBPSCYSavGoce/Gf6YMcjdid+a9P2zahtKrUSA5+KaTSUuJoOEySGkYwvyyQ
 6Mgf9pl6UgszmhJczzGEyD/Lt4KigRMBQAdoBq3RMpgNg9mDGC/N7zSlHEJr/QLPX+C3GiWqBVk
 A=
X-Received: by 2002:a5d:4243:0:b0:317:49a2:1f89 with SMTP id
 s3-20020a5d4243000000b0031749a21f89mr4769442wrr.1.1694091651627; 
 Thu, 07 Sep 2023 06:00:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0kIaqZoL9BebiIrPjIpKQKQfzaisxvzqQonxEoD4mAsFcCHX0vQ/1y1DtqTQAdBBqmz/t9g==
X-Received: by 2002:a5d:4243:0:b0:317:49a2:1f89 with SMTP id
 s3-20020a5d4243000000b0031749a21f89mr4769389wrr.1.1694091650532; 
 Thu, 07 Sep 2023 06:00:50 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 k11-20020a5d6d4b000000b0031ad2663ed0sm23259304wri.66.2023.09.07.06.00.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/51] contrib/plugins: add Darwin support
Date: Thu,  7 Sep 2023 14:59:28 +0200
Message-ID: <20230907130004.500601-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
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

Under Darwin, using -shared makes it impossible to have undefined symbols
and -bundle has to be used instead; so detect the OS and use
different options.

Based-on: <20230907101811.469236-1-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/plugins/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index db1bd04dfa6..c26fa08441e 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -37,7 +37,11 @@ all: $(SONAMES)
 	$(CC) $(CFLAGS) -c -o $@ $<
 
 lib%.so: %.o
+ifeq ($(CONFIG_DARWIN),y)
+	$(CC) -bundle -Wl,-undefined,dynamic_lookup -o $@ $^ $(LDLIBS)
+else
 	$(CC) -shared -o $@ $^ $(LDLIBS)
+endif
 
 clean:
 	rm -f *.o *.so *.d
-- 
2.41.0


