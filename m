Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E9F7CD668
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:28:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1uU-0000II-66; Wed, 18 Oct 2023 04:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uO-0000GW-CS
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uM-0003YX-AV
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bybKTa9G9RMY0v1lzFDYASsOxiC+RbIei3NGvfqoAE=;
 b=iuoIu96zD21/3NezNtzCllEgENPXxyLkjdThpzzjLLMvrSEDf0o/zIpzmzyXqQcsXTumb8
 J0t1FDmSZz59IwD/5bIxCcwuFBQDF4RVj3hTssfXvLfL7bv/+6Cl1QiFwDKrGSdIk+70nH
 4d/4mXrK6OpBT+sVPMIoP2JJCYFHGvY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-puXPIRRePKmRTZ5evFFv0A-1; Wed, 18 Oct 2023 04:27:57 -0400
X-MC-Unique: puXPIRRePKmRTZ5evFFv0A-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9bd86510329so474150166b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617676; x=1698222476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4bybKTa9G9RMY0v1lzFDYASsOxiC+RbIei3NGvfqoAE=;
 b=cSNjfJF19/r5yoF2k8jbF+ZkJvd6qbhg02dX6EwCGdCEOLZsCU4TIK2a2iOARjh7En
 U0VtV2DJ/Hu3svkuECvS8aU6m8+42I6OUZlSG6/AvuW94oOfSNfuwivgV49wUVzuaQFt
 3pXtrDdaoDuZZbZbw+yF52twwfgWZEoQTS6wlE13eNxG6ALZoUIXPLscPeULJoUAbBFX
 ePOACDgpl9N+MPh0Vfv2umDZTUFHht91oRzArNsIUoyNTXh7cXbFoM5vhhlexf+v/NtG
 VvO6gQvBpz/EGHg+7nGAroM5rThKyZjqabaIgb6lj8rY+hqQxsEKfz9CJJle54/Lx+6q
 TXqA==
X-Gm-Message-State: AOJu0YyqBYlRSgkLcq66yAul/lDaK73bNTpEAC93tG33Z5PBtZGsR8w+
 84B0uTbn+Y5oAuUwLLLq9YvKTIlsZzOIb9OIUmBSmCgyKZmZaV6Uv1awK3WWhtvA6g5PuUWNp4w
 dz9nMHmIMQzPqotNpp/j+WzF5aLQ2CgmdPgphPw41LbzWxNZPfz1t8Gsk+zxM1U2elin8HMD7cl
 Y=
X-Received: by 2002:a17:907:97d4:b0:9ae:37d9:803e with SMTP id
 js20-20020a17090797d400b009ae37d9803emr3530828ejc.8.1697617676159; 
 Wed, 18 Oct 2023 01:27:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWr36RWkNc6hNrfzE5pku0+EgJji2lC+jTGeKqUnaa+vhfaN64mqUrW5Tbga6xcmzuniJZZw==
X-Received: by 2002:a17:907:97d4:b0:9ae:37d9:803e with SMTP id
 js20-20020a17090797d400b009ae37d9803emr3530820ejc.8.1697617675835; 
 Wed, 18 Oct 2023 01:27:55 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 lh22-20020a170906f8d600b009b94c545678sm1166560ejb.153.2023.10.18.01.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:27:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PULL 01/32] iotests: get rid of '..' in path environment output
Date: Wed, 18 Oct 2023 10:27:21 +0200
Message-ID: <20231018082752.322306-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
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

From: John Snow <jsnow@redhat.com>

Resolve the build_root before we append more items onto it so that the
environment output is more concise with less parent directory confetti
in it.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20230621002121.1609612-4-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qemu-iotests/testenv.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py
index 9a37ad91529..e67ebd254b1 100644
--- a/tests/qemu-iotests/testenv.py
+++ b/tests/qemu-iotests/testenv.py
@@ -216,7 +216,7 @@ def __init__(self, source_dir: str, build_dir: str,
         self.source_iotests = source_dir
         self.build_iotests = build_dir
 
-        self.build_root = os.path.join(self.build_iotests, '..', '..')
+        self.build_root = Path(self.build_iotests).parent.parent
 
         self.init_directories()
 
-- 
2.41.0


