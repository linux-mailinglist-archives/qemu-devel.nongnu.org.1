Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CDF74E1A7
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:03:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzuQ-0003hl-5K; Mon, 10 Jul 2023 19:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuM-0003gN-PH
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuL-0004Av-DH
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SM6HtXV56hI3gJZn0vAaGg3ztZLfzZhW3nxUKN5CA6E=;
 b=NahldwUvRd+BrBI44oSAWkekvhBKDw7VzfscllZdD4GyfGbyFOKWrpQ/X/4iMuFkkcU9Qu
 sCwDg50N6jneO15HV64Bl8QyrksZEVR7UT7sgGuxx0RMv/u6vVc4s8c7WsTM2rwsnE3B07
 hp8RJnGe58Nvb2+QH86V0bm9No4uBQQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-5SCDiTFZOPevRmUsihpSAA-1; Mon, 10 Jul 2023 19:03:03 -0400
X-MC-Unique: 5SCDiTFZOPevRmUsihpSAA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-315998d6e7fso1080196f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030182; x=1691622182;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SM6HtXV56hI3gJZn0vAaGg3ztZLfzZhW3nxUKN5CA6E=;
 b=M6QEEv7+kO/S57tcSb3YS57jvQP4XhuMPCrrbPPojPFNdqCFyC5819ixHtRdka2+FK
 ZQmWXICyxg4BwNfw11jZnkC7K32Fe0EHLMYcCw+2XPJ0a3MJCu5KUftgSYsIPpnSkbl7
 7ClKhJ20oK5BBZmxSuFdKoo+RqVZaDQik5L6JHPh5ABhsrz6zgQx49PwIjSvBDZvTfJ9
 KXmFivw/lLmmqCU9xHkbYpwMFGtzMAarsOb+61qfK9Elj5RzNyP19dv9q7fTIBH/UhGq
 XvZ6ZiIJTXhNx0lku5N6pcs1W4+zibdTIpCmnL+vL8U+jZvKGaNU7d0GfP0o1TiINiOQ
 4dmw==
X-Gm-Message-State: ABy/qLaP1AiQ3cr4OyxeVjNbGPghNR3VX/y6oSSYevdn1aoBG+ScN8OS
 78pCuS4xMeHTMrBD3VBJCEJFsdGbgXe59PqFyCekMcpitIOu6w2wZAprhNqV5ilMvfEgjR8Lb2H
 5GeSp0ymHzlCYplpxN8uV2/G/vxB6wFNV38s5g9WuajMJeFJLjsYpLQF9XErJy6X2zPAs
X-Received: by 2002:a5d:5444:0:b0:314:8d:7eb1 with SMTP id
 w4-20020a5d5444000000b00314008d7eb1mr11284795wrv.55.1689030182045; 
 Mon, 10 Jul 2023 16:03:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEvualZyW5BnHDmgPlPuIhijkNWtMlnL85ocKyJFBMVf8svlhNSVyRYm+Wwkyi/95s1pCPm1A==
X-Received: by 2002:a5d:5444:0:b0:314:8d:7eb1 with SMTP id
 w4-20020a5d5444000000b00314008d7eb1mr11284779wrv.55.1689030181795; 
 Mon, 10 Jul 2023 16:03:01 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 q4-20020adfcd84000000b0031134bcdacdsm594256wrj.42.2023.07.10.16.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:03:01 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:02:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 12/66] hw/smbios: Fix smbios_smp_sockets caculation
Message-ID: <d79a284a44bb7d88b233fb6bb12ea3723f43469d.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

smp.sockets is the number of sockets which is configured by "-smp" (
otherwise, the default is 1). Trying to recalculate it here with another
rules leads to errors, such as:

1. 003f230e37d7 ("machine: Tweak the order of topology members in struct
   CpuTopology") changes the meaning of smp.cores but doesn't fix
   original smp.cores uses.

   With the introduction of cluster, now smp.cores means the number of
   cores in one cluster. So smp.cores * smp.threads just means the
   threads in a cluster not in a socket.

2. On the other hand, we shouldn't use smp.cpus here because it
   indicates the initial number of online CPUs at the boot time, and is
   not mathematically related to smp.sockets.

So stop reinventing the another wheel and use the topo values that
has been calculated.

Fixes: 003f230e37d7 ("machine: Tweak the order of topology members in struct CpuTopology")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20230628135437.1145805-3-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/smbios/smbios.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index d2007e70fb..d67415d44d 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -1088,8 +1088,7 @@ void smbios_get_tables(MachineState *ms,
         smbios_build_type_2_table();
         smbios_build_type_3_table();
 
-        smbios_smp_sockets = DIV_ROUND_UP(ms->smp.cpus,
-                                          ms->smp.cores * ms->smp.threads);
+        smbios_smp_sockets = ms->smp.sockets;
         assert(smbios_smp_sockets >= 1);
 
         for (i = 0; i < smbios_smp_sockets; i++) {
-- 
MST


