Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C335A08B5B
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Jan 2025 10:21:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBC9-0008Mw-HL; Fri, 10 Jan 2025 04:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWBBd-0007Yz-V3
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:20:14 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWBBZ-0007aI-Ev
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:20:12 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-216728b1836so29702405ad.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 01:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736500807; x=1737105607;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rab9AM6XE46IpCNkIWxpuZTQFO5WIkXW71J3f3qzs3Q=;
 b=PH01vXPt09J67q+eexH5dfJB3Ly2ASd+L+zvSnbYOlI0A/wPgYJ6YEwxrvI7Iaw8NR
 jUAtJVMATbxfHXx43HRS+S/f88KDxTbi7IsVty+Xg/m383vzFaaCOdvRlvlZw5X3++oz
 Oj6bTuc1NZ3t83JRtaPlzQNPx62wm39owyDBqyiIJde/69YQwVgiqlPK+BqBNqpYPKye
 tV7HthpD+ruc+vsG9/aepBjXWFQLo5t0C0n7l+UWZl9rtcrND7b7lU7BWtUQAak3NGlE
 oCChy0P82DoAiZxGZ0J3SveV6cApCJS3Nl2pxQ0Hn3b4DMtKQEyRwwqPIGUpYJj56g7q
 nnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736500807; x=1737105607;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rab9AM6XE46IpCNkIWxpuZTQFO5WIkXW71J3f3qzs3Q=;
 b=ptz6itbVDt+T8gu9oPhj45atbk1hv7SM2wMj+VNwMs4SSMthWX0M3nfyrWID0J8z2n
 EOvpHLeCpsTaxQkfwJ9/9Oq4K5TMdklzzdIckwdzjFCuN/nTY1EPnjD1AoOh4+JJxk2/
 7Z55iG+MVxEdPLFjg0CIk7F7vp+zRA+MXJc6rxFDJH4fAzy6xN0Qw7ECywVrnatb4wOk
 UG4PjbXI0qT39ZHaDgZ0cpf2+M1cr+5UlQAirsLjFQY7txy0MB5JV+3un4KqXKrgGVrm
 aWbzBAZC49gpZ1sVRtB2whVD+ZXgil+1Gk3E5Uj548dOnb0bEkBhFm1P+yAO4yaCsslu
 Jjew==
X-Gm-Message-State: AOJu0YxrNHpmTeEXvpjehUU9rjm6zFwgh656itfz1ljDU48sKw97mUJX
 riDMI2x/nQ6OLl9d/sCTdfC4LTnwyV5GaF1vuYa1ZcFwlBBrD8yXwK7vyWwTuOs=
X-Gm-Gg: ASbGncsfB9V+NYbGlbVZgy/5SsfRoXtv03GXXVrifdsdhNTWqivnGDig3rECtkhQSJS
 NbyzcXqRWXrGJwK4LTTkU2QSM8HBL4C6tolknlg3LBS3UJnQVFB0qo8witLHBRpIbBvYfMmQH9v
 RMTLyz5qU/n8WS4tmTT9rZ89YLxa+54BNU1XydFEsnzbSqsfLE9M3rte4JhZjSEPtXWxg3jvyZO
 TxisTKBKcKz8Dr3L5ZXUy6IcG2D4Q5sPx+vCeAfvd4MtCsjH5F51rv0cSw=
X-Google-Smtp-Source: AGHT+IF7U9cLA0Vt6s08wzfiYTUJTv/5hvjEYLEUJlGUL2zH5dUT59pU+mFX+O3moJad/28l4Ok0vQ==
X-Received: by 2002:a05:6a00:35c7:b0:725:f153:22d5 with SMTP id
 d2e1a72fcca58-72d21fd2f25mr14712760b3a.18.1736500806714; 
 Fri, 10 Jan 2025 01:20:06 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72d406a77d5sm1164448b3a.171.2025.01.10.01.20.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 01:20:06 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 10 Jan 2025 18:19:35 +0900
Subject: [PATCH v8 2/2] memory: Do not create circular reference with subregion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-san-v8-2-57a5a1be1bcf@daynix.com>
References: <20250110-san-v8-0-57a5a1be1bcf@daynix.com>
In-Reply-To: <20250110-san-v8-0-57a5a1be1bcf@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

memory_region_update_container_subregions() used to call
memory_region_ref(), which creates a reference to the owner of the
subregion, on behalf of the owner of the container. This results in a
circular reference if the subregion and container have the same owner.

memory_region_ref() creates a reference to the owner instead of the
memory region to match the lifetime of the owner and memory region. We
do not need such a hack if the subregion and container have the same
owner because the owner will be alive as long as the container is.
Therefore, create a reference to the subregion itself instead ot its
owner in such a case; the reference to the subregion is still necessary
to ensure that the subregion gets finalized after the container.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 system/memory.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 78e17e0efa83..972617b0192d 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1855,6 +1855,24 @@ void memory_region_unref(MemoryRegion *mr)
     }
 }
 
+static void memory_region_ref_subregion(MemoryRegion *subregion)
+{
+    if (subregion->container->owner == subregion->owner) {
+        object_ref(OBJECT(subregion));
+    } else {
+        memory_region_ref(subregion);
+    }
+}
+
+static void memory_region_unref_subregion(MemoryRegion *subregion)
+{
+    if (subregion->container->owner == subregion->owner) {
+        object_unref(OBJECT(subregion));
+     } else {
+        memory_region_unref(subregion);
+     }
+}
+
 uint64_t memory_region_size(MemoryRegion *mr)
 {
     if (int128_eq(mr->size, int128_2_64())) {
@@ -2644,7 +2662,8 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
 
     memory_region_transaction_begin();
 
-    memory_region_ref(subregion);
+    memory_region_ref_subregion(subregion);
+
     QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
         if (subregion->priority >= other->priority) {
             QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
@@ -2702,7 +2721,8 @@ void memory_region_del_subregion(MemoryRegion *mr,
         assert(alias->mapped_via_alias >= 0);
     }
     QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
-    memory_region_unref(subregion);
+    memory_region_unref_subregion(subregion);
+
     memory_region_update_pending |= mr->enabled && subregion->enabled;
     memory_region_transaction_commit();
 }

-- 
2.47.1


