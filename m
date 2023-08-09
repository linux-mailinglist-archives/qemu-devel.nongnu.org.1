Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDE5776377
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 17:12:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTkqh-0007J3-8C; Wed, 09 Aug 2023 11:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qTkqf-0007HN-Az
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:11:45 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qTkqd-00084g-OJ
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691593901; x=1692198701; i=deller@gmx.de;
 bh=L/N056++ZkY1Ij5RAK92jq8wtV1M/2ebEIE2RWPJ1oU=;
 h=X-UI-Sender-Class:Date:From:To:Subject:References:In-Reply-To;
 b=NRv8hEF7pNIvWTEhCV2OI/5XZkf+eXrPP/oeB08mbVRI5MIGELWIXSWy7KsY41e/sL9twaM
 StAts3pZLjT8T4BqX5tV8kVfU/TH/MxfgEI6nrt9FhYLgwwaSQa9OX29Vmo8bmoPLe2ggZsT7
 qiwEMpwkvnIMqCRmffmYXdnJO6W0Vq/AMS2fqp+5E1VhflYDqMjDxRoZHiDkUdF2hO9MuHSf9
 AjmfQhmmLf96KFoffscw78YiGKTzcc1xxYW4cS/e1JtIPleQc+kM6o6okHtOCbaUdzc5de3if
 AVgvJ6DSo5K9y6nyVZEjEMg5Zpn7tnoIt8s71mqf7NiDyt2XrOGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.156.76]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnakR-1q40Ou0q3R-00jXJn; Wed, 09
 Aug 2023 17:11:41 +0200
Date: Wed, 9 Aug 2023 17:11:39 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Fix interval_tree_iter_first() to check root node value
Message-ID: <ZNOsq6Z7t/eyIG/9@p100>
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-11-richard.henderson@linaro.org>
 <d2842004-ce3e-325f-69a7-3eec6e4cd1d5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2842004-ce3e-325f-69a7-3eec6e4cd1d5@linaro.org>
X-Provags-ID: V03:K1:AMcfR9QR4WEHjal2eaMUuDVPJxJ5JEfe28iS36iq7mIpS+k87EF
 xWpYJOa1dHq1Up0KQdbWe80s5W1Z0IlHiXxhnsfiNT0YQxiI52EPHNrlgSRhS5mVxrkb5nq
 a+RfOo5FHgHWARHb0bGILJHXoKwq5+H+MkGcXB7lPQ1nCnWpyW4XI6vrFcGqURLMK7MCUQO
 OoEpmptUnHFv12J89xL6g==
UI-OutboundReport: notjunk:1;M01:P0:Cy9XPU+1p5Q=;BmtX/A3lyfocN7twe2Nj/46JDkw
 5NHTnV7KBHEuySP3+vylfF4MuupK7B9SDH8+OA4G1NP3mva5i7OgnmhRviWqGWAvcWmq2vlR5
 +hb4/CVvp+m5/Vw/lZfB8vi+rhCAux6r788o30XWLre2Nuv2UnzwngypNP6/BQSuNm5avTn3D
 6Pi40+6EEmPCkzPIxWzwcwr8drKHBJnjOnFn2XbR/T15iIyq1YImJyoGL7cN1H6c+swteKB/f
 bXNeNm/8wBYlrY3mi166KYZl81IjNYd+0vPJCQfKmgpHHfDf3C/T2fMnvBbKkZJVKnUWmU9gu
 Xd2BOtNgr7LoIjsiPDPzOkPssUpOLaTuKHenCtkRRjCmV2361roOWYYFhRFOLFSTvqsMb1f9I
 K0inU21Enh7plpb45LmNIL4wRGNrOUl3/SYdtNpFQ56Hq3vwtPMhZeoxJfAQUa25qOvbwa2O0
 Doj0mZWZELm6mlyTSLNBi/j2qSiKELpw2Wp9XuThSEpWop3RbTkGICpiNs8YKyB+PJGqdDyxO
 CNpncoFIBVU1Uwfzu1DAd0IneMNaE8Kllzgefpw2EupzAlX5c9mR2Vz2aachQKrP8Bmr3Ztjd
 +VuUNO19wojz5Ml4SB+UF8DQAakmYMwLo7c5VmKRL2mJIbf3nrx8G7IyU7D9N/YV5klfjfTyi
 is95L1PgCnt2s8oRLGHGraznLnz9+k9twwvFxeS+gEWv8cxcKgcYsgT+Xeu90+w3BSHUqrXGj
 6guuwL4oDcHZwPfSPlUwax+aAq1Uxra35ecpbGpcSs9zKJvYk/Lre8DTGN/Q27rMdJPqJBzqf
 lQP2Ve+ENrltxK5p3a98XA44x4MjSu0tRMauDWmLeTE2h5Iip5BlWsv/y2+YPfAb2mLbwHNCS
 btl3K8WEWHgTvxwXyd6L7twjejBUYZV6TJtgerhf56Nf3iZy4c7LfoaaE+S+6WFcJcBnL3UzN
 JEDSvYpNfiAI6FBU95+bTRRxpcE=
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fix a crash in qemu-user when running

    cat /proc/self/maps

in a chroot, where /proc isn't mounted.

The problem was introduced by commit 3ce3dd8ca965 ("util/selfmap:
Rewrite using qemu/interval-tree.h") where in open_self_maps_1() the
function read_self_maps() is called and which returns NULL if it can't
read the hosts /proc/self/maps file. Afterwards that NULL is fed into
interval_tree_iter_first() which doesn't check if the root node is NULL.

Fix it by adding a check if root is NULL and return NULL in that case.

Signed-off-by: Helge Deller <deller@gmx.de>
Fixes: 3ce3dd8ca965 ("util/selfmap: Rewrite using qemu/interval-tree.h")

diff --git a/util/interval-tree.c b/util/interval-tree.c
index f2866aa7d3..53465182e6 100644
=2D-- a/util/interval-tree.c
+++ b/util/interval-tree.c
@@ -797,7 +797,7 @@ IntervalTreeNode *interval_tree_iter_first(IntervalTre=
eRoot *root,
 {
     IntervalTreeNode *node, *leftmost;

-    if (!root->rb_root.rb_node) {
+    if (!root || !root->rb_root.rb_node) {
         return NULL;
     }


