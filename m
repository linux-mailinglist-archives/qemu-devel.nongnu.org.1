Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8E095C546
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Aug 2024 08:16:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shNYf-0002nI-IB; Fri, 23 Aug 2024 02:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shNYc-0002eV-0w
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:13:58 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shNYV-00038n-LZ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:13:57 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2d3d58d6e08so1217728a91.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 23:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1724393628; x=1724998428;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YdHplAffMcXcyi9egxfeqIrbdnUVPw/pDkvqxXIV6Fk=;
 b=LaS6mr/2/L0gqc4ZRA57xV55f1UmRP6c6jbfJrKzTDCN2dM3B335HRL7OVN0aX0Qtw
 02Gggpk/mHEU3+7rHeSHSeXW6qDX6084O/Ekce7kr9eBvOVhoC2chGaNIDKtZbveC8/m
 gMgzrCAzqzwX1bqqowkcdDg0mYs20zka/lxo4C+1yFNbRWRJ5yEMWBpKvz7rooDmTTVY
 yC//gPqh1olto06HGuaKyjtdLPOdQmwi97FI4VYwYbyqp4rxM3cTfz5R2ZL4csNYoh1b
 B7m2ow13hCCT2UyZ3zNCTbPe3JprtbeR9lNS4KHuOrChehOgN6MEZxxUxwmNdEkmLQ2W
 HHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724393628; x=1724998428;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YdHplAffMcXcyi9egxfeqIrbdnUVPw/pDkvqxXIV6Fk=;
 b=P2Vw6/GKwYVkMQTSfDl5twEWlrm1kF30Ns9QlyRGw148dqmJm1K/2N7uvVS9YNbfnN
 hkgVFDL4lPabjnzFIe/978ASKjXfo5v8fZqdwXFNRlWjdna2yqRt9uPFvx2wCig2ZQWb
 xCic/8ykIQL5Ji9/3qXj/7W0mMPf44Asgxyi25smIgkWFl9IukS0ZodoMBGXs2p8yF5q
 dnUqJT3xXl0pPll3Ci2ti/2LH9PY/VnRy1Da5R0ay46mtJielY8USMU1rKdJiDpaoHqf
 zSfe1OwrIjndra79XD6bHSuojPOe+lgyRC3qHnGL4sn+7ccfkWfVI8a9p0mAA1/eb25K
 wtXg==
X-Gm-Message-State: AOJu0Yxme3Q7MTvy6rHQlqNMCU4oZVhx/Xt6zhogJbE9DqkkUgJkcaua
 wkSXAlDCiaZFBqFOoqDpwHbB+G9lxj0ru2yh85+7O7JAz7kIbMXV+ydSnKgpifA=
X-Google-Smtp-Source: AGHT+IFzJ10oTRUyLJrWB5ipu7tvGZB9L6IX1t4YpN1zznxvJDoxVqCckhwL5Q+Xwak+DQuAoYo6Pg==
X-Received: by 2002:a17:90a:c002:b0:2cb:e429:f525 with SMTP id
 98e67ed59e1d1-2d646d2bbdfmr1123154a91.33.1724393628209; 
 Thu, 22 Aug 2024 23:13:48 -0700 (PDT)
Received: from localhost ([157.82.207.23]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2d61393fbcbsm3057579a91.22.2024.08.22.23.13.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 23:13:48 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 23 Aug 2024 15:13:09 +0900
Subject: [PATCH v4 4/7] memory: Clarify that owner may be missing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-san-v4-4-a24c6dfa4ceb@daynix.com>
References: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
In-Reply-To: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

A memory region may not have an owner, and memory_region_ref() and
memory_region_unref() do nothing for such.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/exec/memory.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 461e42d03491..d79415a3b159 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1219,7 +1219,7 @@ void memory_region_init(MemoryRegion *mr,
 /**
  * memory_region_ref: Add a reference to a memory region
  *
- * This function adds a reference to the owner.
+ * This function adds a reference to the owner if present.
  * See docs/devel/memory.rst to know about owner.
  *
  * @mr: the #MemoryRegion
@@ -1229,8 +1229,8 @@ void memory_region_ref(MemoryRegion *mr);
 /**
  * memory_region_unref: Remove a reference to a memory region
  *
- * This function removes a reference to the owner and possibly destroys it.
- * See docs/devel/memory.rst to know about owner.
+ * This function removes a reference to the owner and possibly destroys it if
+ * present. See docs/devel/memory.rst to know about owner.
  *
  * @mr: the #MemoryRegion
  */

-- 
2.46.0


