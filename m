Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7B6709A7A
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:52:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01Qv-00075k-Lv; Fri, 19 May 2023 10:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Qi-00071e-6f
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Qf-0003I6-BL
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8m/TvR9N88B9CWAayRXkVdTCBxjRBqiu8lXv0OP6qsE=;
 b=cl8vTge/ozE0+vQ3w3fta5bWF0DZM5h2NuiOWWTq45OZIy6lliu1HRwvIynvn7NxUSAsi9
 vkNH9pmEt9IpY3dE0lRNvkLfW0zMuOYuGI/xSqkhOl+n4UoJTXjAHDXMN5cGkRztO0jTbA
 eF4mVHwS5+dYbNyQBBCJDiHnGnsx7s8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-263HggwiOduxVYAOysRBLg-1; Fri, 19 May 2023 10:49:59 -0400
X-MC-Unique: 263HggwiOduxVYAOysRBLg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2add1fdcef0so20893641fa.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507797; x=1687099797;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8m/TvR9N88B9CWAayRXkVdTCBxjRBqiu8lXv0OP6qsE=;
 b=CCIk/HoljAm2Vk8aXjaGlE6NBDZF+Wx0sI4WeolGCfCViEllePtkJhR0knJawEWclW
 WsD3pKs0xgJ37h32pn3wypA0upgIs5Cxvx+EufkBtgq9pQ0b6cB7LOnyK2h0cLuC555n
 0QYtlRUWJMf81Rc0b+rDSuvBT+A2KaDTgk7uMnebIOCEERTspyPWtkc6GjCYgTUMnJkH
 dGVLob3IksZgzQPoGt0QmAoKwk1uBTVO58S4VXSjmbzXKt9Q99UeIiFevR1C0OlRL1n3
 3o21oaqcwZQOksRgfnFlvGoQuYtiKW1BjTgz8WltqAx0Dn5RNgfxJVr2Ai7v5CiX7suq
 dd2g==
X-Gm-Message-State: AC+VfDyOCfq9zf/+jiWVOlMbOlxaHAAX25Izx00f/CilBAsM9zG2xcSL
 ATnrjRnNmpGpg1bJkVMwuOiPG+KQFYzUChpMzqJIzgJsNocOszeqmFad8TEulltI5IhdRWEoB9r
 5GT6yO6H4mhqTuqREEDDqcKefsT7JwHKeqWSn6In/RRLGLE3KzgCx/4TqZC7CVBfR5/Mq
X-Received: by 2002:ac2:5ed1:0:b0:4f3:a9d4:45ef with SMTP id
 d17-20020ac25ed1000000b004f3a9d445efmr890680lfq.22.1684507797799; 
 Fri, 19 May 2023 07:49:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5IhH1xt85TGvGyHU2Or6RSiyUunRizj3vm8t3V/sX4PwGaHW28MHt87URzYf6S7t0BIfJDdA==
X-Received: by 2002:ac2:5ed1:0:b0:4f3:a9d4:45ef with SMTP id
 d17-20020ac25ed1000000b004f3a9d445efmr890669lfq.22.1684507797495; 
 Fri, 19 May 2023 07:49:57 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 o18-20020ac24352000000b004ec7c0f2178sm627588lfl.63.2023.05.19.07.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:49:56 -0700 (PDT)
Date: Fri, 19 May 2023 10:49:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Brice Goglin <Brice.Goglin@inria.fr>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 04/40] docs/cxl: fix some typos
Message-ID: <ca4750583a597e97cbf8cec008d228f95d22c426.1684507742.git.mst@redhat.com>
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

From: Brice Goglin <Brice.Goglin@inria.fr>

Signed-off-by: Brice Goglin <Brice.Goglin@inria.fr>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20230421134507.26842-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/system/devices/cxl.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 4c38223069..9618becdab 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -162,7 +162,7 @@ Example system Topology. x marks the match in each decoder level::
   |<------------------SYSTEM PHYSICAL ADDRESS MAP (1)----------------->|
   |    __________   __________________________________   __________    |
   |   |          | |                                  | |          |   |
-  |   | CFMW 0   | |  CXL Fixed Memory Window 1       | | CFMW 1   |   |
+  |   | CFMW 0   | |  CXL Fixed Memory Window 1       | | CFMW 2   |   |
   |   | HB0 only | |  Configured to interleave memory | | HB1 only |   |
   |   |          | |  memory accesses across HB0/HB1  | |          |   |
   |   |__________| |_____x____________________________| |__________|   |
@@ -208,8 +208,8 @@ Notes:
 (1) **3 CXL Fixed Memory Windows (CFMW)** corresponding to different
     ranges of the system physical address map.  Each CFMW has
     particular interleave setup across the CXL Host Bridges (HB)
-    CFMW0 provides uninterleaved access to HB0, CFW2 provides
-    uninterleaved access to HB1. CFW1 provides interleaved memory access
+    CFMW0 provides uninterleaved access to HB0, CFMW2 provides
+    uninterleaved access to HB1. CFMW1 provides interleaved memory access
     across HB0 and HB1.
 
 (2) **Two CXL Host Bridges**. Each of these has 2 CXL Root Ports and
@@ -247,7 +247,7 @@ Example topology involving a switch::
   |<------------------SYSTEM PHYSICAL ADDRESS MAP (1)----------------->|
   |    __________   __________________________________   __________    |
   |   |          | |                                  | |          |   |
-  |   | CFMW 0   | |  CXL Fixed Memory Window 1       | | CFMW 1   |   |
+  |   | CFMW 0   | |  CXL Fixed Memory Window 1       | | CFMW 2   |   |
   |   | HB0 only | |  Configured to interleave memory | | HB1 only |   |
   |   |          | |  memory accesses across HB0/HB1  | |          |   |
   |   |____x_____| |__________________________________| |__________|   |
-- 
MST


