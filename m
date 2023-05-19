Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D2F709A77
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:52:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01Qw-00076M-7E; Fri, 19 May 2023 10:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Qt-00074C-3a
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:50:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Qr-0003Ui-Io
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NojQDkxaiUz9/Fpnr3UOkUr9Gdhrk66biKkct4h/Eno=;
 b=frv73BYi2OtjunFaQAt3lu7+R6NJ2NIbnwvrC71n6gxI1cl4c+SYQbLs2NHGACPI1oHAVQ
 PpXJ1TeE1h6pz+hhSiItkV2vRJIcTXFD1Ar5SrtkDyfkSekGcnIpQz4vJ4rege4Q978Apf
 K4v9FJ+NydWIGD+4P7yUhSwu/bHs/tw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-LN4YAPusO3KEXsP7qVx6kw-1; Fri, 19 May 2023 10:50:10 -0400
X-MC-Unique: LN4YAPusO3KEXsP7qVx6kw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ab3e925512so5586531fa.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507808; x=1687099808;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NojQDkxaiUz9/Fpnr3UOkUr9Gdhrk66biKkct4h/Eno=;
 b=XbzGx1YQaEgoz/8Zdj4vf/RKifW0cuenXAEfGgV/nmLbWghugAp8LbK6UPVuCGrnso
 k1RdfoeUFa4lXMbkMhRVMOxgUJOQOvKQZ6inVlhHy95ZUpQjmh/sattirMsg2KlxBbxb
 u3WOlJuxsJzKdneyD6r87MA5FMLDroOYDVhh9sraXEO/V3cvmnOk+fty722BxUB2Ie0v
 pquLgCkv7b4iywP5llpLJlXpxw95S9gthHI7fd3u/PG2OqkZev5zl00IfJV0s+UxFVYP
 KWfE6qveHUQjng+96N4okXZUGEh70EYZeCQjtn2jNOQ+DEToLeX5uIPS84t403CnM6o6
 Blwg==
X-Gm-Message-State: AC+VfDymZhar5uchTBAfiPX2AtiravqhfV6yjtRCPP5Wuy9d/SaVvInx
 pwLOqQKa8LGSwzLvMuPzDFhSozoyE2cH1cL4Z0do+zzVtNRdDelBPaFsxv4f5VkDA1CTCNkvWt8
 4JvrEQY6Gatf27bUB5tCBgeScoFulszp3NNhMaUzxWnChNGhnQu7p+ZIrpof6sAbF0bxj
X-Received: by 2002:a05:6512:3189:b0:4f1:21a2:9006 with SMTP id
 i9-20020a056512318900b004f121a29006mr994626lfe.18.1684507808202; 
 Fri, 19 May 2023 07:50:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6zrgjjJhEtho2MaQ3xAkpOw4LaErI9e/NHoEw0YYkJzD5Ni1nzIwbNAiSEMHkKcuVXUwC+Bw==
X-Received: by 2002:a05:6512:3189:b0:4f1:21a2:9006 with SMTP id
 i9-20020a056512318900b004f121a29006mr994612lfe.18.1684507807955; 
 Fri, 19 May 2023 07:50:07 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 m11-20020ac24acb000000b004edb2cb3500sm615608lfp.279.2023.05.19.07.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:50:07 -0700 (PDT)
Date: Fri, 19 May 2023 10:50:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Raghu H <raghuhack78@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stefan Weil <sw@weilnetz.de>, Davidlohr Bueso <dave@stgolabs.net>
Subject: [PULL 06/40] docs/cxl: Replace unsupported AARCH64 with x86_64
Message-ID: <0795b98f096b876a36e2c45adb42c2004655011e.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Raghu H <raghuhack78@gmail.com>

Currently Qemu CXL emulation support is not availabe on AARCH64 but its
available with qemu x86_64 architecture, updating the document to reflect
the supported platform.

Signed-off-by: Raghu H <raghuhack78@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20230421134507.26842-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/system/devices/cxl.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index dd1a62bd57..8f2885aba1 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -302,7 +302,7 @@ Example command lines
 ---------------------
 A very simple setup with just one directly attached CXL Type 3 device::
 
-  qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
+  qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
   ...
   -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest.raw,size=256M \
   -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=256M \
@@ -315,7 +315,7 @@ A setup suitable for 4 way interleave. Only one fixed window provided, to enable
 interleave across 2 CXL host bridges.  Each host bridge has 2 CXL Root Ports, with
 the CXL Type3 device directly attached (no switches).::
 
-  qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
+  qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
   ...
   -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest.raw,size=256M \
   -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxltest2.raw,size=256M \
@@ -339,7 +339,7 @@ the CXL Type3 device directly attached (no switches).::
 
 An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
 
-  qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
+  qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
   ...
   -object memory-backend-file,id=cxl-mem0,share=on,mem-path=/tmp/cxltest.raw,size=256M \
   -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest1.raw,size=256M \
-- 
MST


