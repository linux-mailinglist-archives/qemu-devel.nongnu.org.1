Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B803F7BB632
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:17:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoimq-00080z-RZ; Fri, 06 Oct 2023 07:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoimo-00080F-QP
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoimh-0000Dx-1M
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ih1ItFgUjyLDwAKRKghxifXgQduOcEOb4rpNW8gc4o=;
 b=HoWAs8l/qyqC7Kt9Epk9fY2s4Bc9//xBS9eYLi+6uoqvVLo/V3tNOT9nS46Gvy1nbPHtVP
 2O6uVckoHKNn3DilMOB7LblUSWd4d7nuxzN83iXAJfXcpIspt31Gqv5v1kr34uF7/aftgX
 ehbPARLd1F8QS8s7912e1B0re98Y6fw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-tDXiFfykN86r_aCk5vHqzA-1; Fri, 06 Oct 2023 07:14:17 -0400
X-MC-Unique: tDXiFfykN86r_aCk5vHqzA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9ba0616b761so7893566b.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590856; x=1697195656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ih1ItFgUjyLDwAKRKghxifXgQduOcEOb4rpNW8gc4o=;
 b=ZtmgYo+eGWhRe88qL2DisZZshluYEjxu60gexJ1f/vS1PKd3xUNWKx3E9pqIyk/L3H
 Mu7xwVcpUnDMDHg6lT8No9sBL4ppIxy9sF5ciAqSPRKa/y3vTESAN94JHk+NK74zSfCP
 Lrr9VCqjOh50VVmD9ql7EgcsThGHYXl6XfnK2+tNFu8FwC/QenPVMHQJDpg6v+6GdZHF
 Rg99o2fh9u0M9tUZBkcAKoBRF6792zbO20b/a3fA/9pIL3eviAjrj70utLgprraGFaxA
 F5blGVXssqADzI5tTDLZIv+li0P8U+NtLC2k9kiNqNqAEDa0peFqFMiqIl0NU/bJlqRz
 OpkQ==
X-Gm-Message-State: AOJu0YwRNNp8qySpWjedqIOUs+xH3zFvKAP/Ej5yUAY9E6QZuv2fYyxg
 YN9rjB2Q4E/Hd6ELzyv68TajyrPXhd9M4mrSSOV1CI8ScrT2D8Xj1GIbZH+ND2CU6wODyV7wWnX
 RJZbKHp4Ztqj9GY0Mexqpm1d7S3EAloYOKQppiQfPpZp2uFZTN+2g7mx9PgQqsRDvkVtsIUqR7r
 0=
X-Received: by 2002:a17:907:b1a:b0:9b6:5a86:2926 with SMTP id
 h26-20020a1709070b1a00b009b65a862926mr6518760ejl.62.1696590855903; 
 Fri, 06 Oct 2023 04:14:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC6GEUNCreEx+Csfk/k5apbPZMomqsz1gYn0/i9yucho/AXu3XITfqYWHY+jOGSTr/F+aNPg==
X-Received: by 2002:a17:907:b1a:b0:9b6:5a86:2926 with SMTP id
 h26-20020a1709070b1a00b009b65a862926mr6518737ejl.62.1696590855461; 
 Fri, 06 Oct 2023 04:14:15 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a1709064ad000b009ae54585aebsm2650629ejt.89.2023.10.06.04.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Roman Bolshakov <roman@roolebo.dev>
Subject: [PULL 01/26] target/i386/hvf: Remove unused includes in 'hvf-i386.h'
Date: Fri,  6 Oct 2023 13:13:47 +0200
Message-ID: <20231006111412.13130-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The only non standard type -- CPUArchState -- is forward
declared in "qemu/typedefs.h", so no particular header is
required here.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Roman Bolshakov <roman@roolebo.dev>
Tested-by: Roman Bolshakov <roman@roolebo.dev>
Message-ID: <20231004092510.39498-2-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf-i386.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
index 95b47c1c2e7..243bc111ccc 100644
--- a/target/i386/hvf/hvf-i386.h
+++ b/target/i386/hvf/hvf-i386.h
@@ -16,12 +16,6 @@
 #ifndef HVF_I386_H
 #define HVF_I386_H
 
-#include "qemu/accel.h"
-#include "sysemu/hvf.h"
-#include "sysemu/hvf_int.h"
-#include "cpu.h"
-#include "x86.h"
-
 void hvf_handle_io(CPUArchState *, uint16_t, void *, int, int, int);
 
 /* Host specific functions */
-- 
2.41.0


