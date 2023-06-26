Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC3873DF69
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:39:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlP1-0007xZ-PK; Mon, 26 Jun 2023 08:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLe-0002vb-GM
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLY-00037A-Ab
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wcs6ygCPOeUuRIG5HHabBU2pdqpkqeqfBKN/9VnEw90=;
 b=REOsCzioQTgNpZCV3Le5rjQgS3vG4pQqlCePwJbwd9DjAcpArNwiQgjSEAniI41DRG6TB7
 5mhGKz8sfeFq++pEiR8vLbG2Zex+tN3t3DtGQ1Y3MH8AiaINQVzMHcbWPN2AVuWCBcFmzL
 VeEjNY9r3XZn6HVmXv/r5uyUPy6823M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-FWnZTsZpN-2GWetLblXiug-1; Mon, 26 Jun 2023 08:29:30 -0400
X-MC-Unique: FWnZTsZpN-2GWetLblXiug-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f7e4dc0fe5so19028365e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782568; x=1690374568;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wcs6ygCPOeUuRIG5HHabBU2pdqpkqeqfBKN/9VnEw90=;
 b=DwyYnTCepJcmdWdhsmKfYNopWYqFR8K6iQ0KE07PBLRtTKU5xl9ugRQvzpRyv8V/1P
 cPeP76JWJHvCYaNfKZJ7Oh1nLlrqYoZj1b4dwlCcJXDB5U2rN7u/IDrKCkJ7zBdHR8+U
 NyrCzp9jn0iz3va/5WkbZrNdDqyPtGNC0yTFfSSD5+/J4EDAvN1fIZFWP+dmeuwKxJb2
 k9gvuYoBvyIkReEeJ4tnjsfHsEg5QeOdGjaUbgq0CciywT6DC0lYxZifeviBHHYxYsyd
 QgQscbJa6Sn1FVfBNDBXu2+4RHybAL+oQKmV36aM35y3oeW9cZKsPLQu3+a3SBoZihXc
 OHhQ==
X-Gm-Message-State: AC+VfDzYM0xVaaRu+ZMKWXMJRlrPCKs8iMw8mA6ePa2cnD1GHQFO+Oos
 FjsU2pPc1MAUURUnhj8u+U1ucLOl4nVdoruwSFJI2oWU/FbzA3GfT0ugktRRSjGsNdADiMUgANF
 jCvn9/JSuFWF5E4smw2pfP54bOOB8du+R05vd8TOJyjNi3jGJw9b8CZ3kAOfoL+MGxeoy
X-Received: by 2002:a7b:c34d:0:b0:3f7:b1df:26d with SMTP id
 l13-20020a7bc34d000000b003f7b1df026dmr26691595wmj.38.1687782568519; 
 Mon, 26 Jun 2023 05:29:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ65jmB+M9WbQS53Oz4GaUU3qYn8kVUNCc2Nty0rR5ShsuLBoFBrGZfhWzcmiRwB/nt/9oWD2w==
X-Received: by 2002:a7b:c34d:0:b0:3f7:b1df:26d with SMTP id
 l13-20020a7bc34d000000b003f7b1df026dmr26691584wmj.38.1687782568310; 
 Mon, 26 Jun 2023 05:29:28 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 p12-20020a5d638c000000b00313f61889e9sm1201418wru.36.2023.06.26.05.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:29:27 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:29:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 32/53] tests/data/acpi: update after SMBIOS 2.0 change
Message-ID: <d3a1ccd95853abae0e840a80797fb0b7e8626871.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Switching to SMBIOS3.0 by default shifts some addresses, so we get this
change in tests/data/acpi/q35/SSDT.dimmpxm :

@@ -389,6 +389,6 @@
         }
     }

-    Name (MEMA, 0x07FFE000)
+    Name (MEMA, 0x07FFF000)
 }

update the expected file to match.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/q35/SSDT.dimmpxm            | Bin 1815 -> 1815 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 81148a604f..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/SSDT.dimmpxm",
diff --git a/tests/data/acpi/q35/SSDT.dimmpxm b/tests/data/acpi/q35/SSDT.dimmpxm
index 9ea4e0d0ceaa8a5cbd706afb6d49de853fafe654..70f133412f5e0aa128ab210245a8de7304eeb843 100644
GIT binary patch
delta 23
ecmbQvH=U0wIM^jboSlJzanD9BE_UVz|JeaVy9Ofw

delta 23
ecmbQvH=U0wIM^jboSlJzam_|9E_UV*|JeaVTLvQl

-- 
MST


