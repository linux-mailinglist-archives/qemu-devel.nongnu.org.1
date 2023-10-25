Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 791427D7891
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:30:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnI1-0001fD-CF; Wed, 25 Oct 2023 19:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHz-0001bq-0g
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHr-0004z9-0U
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Vb4Qe1NyyPujf0KFShQsH1h7YoB6iPMVKpNCBVwOYI=;
 b=ibHe1iNdzj/UnBix+gmg39YWLnEhv5nYJcxlLORXyxckV9XJle9sb1thkqnB58+pCaEzlI
 73qWMtOUa+TF/wZ0lypfxGjChXMbyXumZ5Rdi2m3qutEE1WRW8drB8bEMXTQzZ1e2lb2Ie
 OQjptYrLg7Uo3c8ZOUOed6LFIfQJo7k=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-kqSd8dGEPoKX3cDQA1kYnA-1; Wed, 25 Oct 2023 19:27:38 -0400
X-MC-Unique: kqSd8dGEPoKX3cDQA1kYnA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-778a32da939so41922885a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276457; x=1698881257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Vb4Qe1NyyPujf0KFShQsH1h7YoB6iPMVKpNCBVwOYI=;
 b=Tei5KGQWBKJ6CBevsa+lRJhzafgjzmKiFYKkc0L4Hu98ZbUg6JUqh5sSupVQwABfKQ
 YlenxKpJWCYPuRi78bmTSFBzpikzfKO3Sbz6NiCvR7P2jTi4rZt5/iRCYKiXmoEVcHMn
 HWagpNb2euKz5W5qewo92pOJBLV8U+7sFrJgStGNTDgRtTscmBbxN7F9zI0cjBjotQ6v
 HYpxGnPZHcV2s6oXdhShVTM8FFw1kuDrZlufpbrZj022nMuitqbNRF5o6ihcWCfiRI+i
 gaTm6BubAqpYEa7z62bmsRZIvbwyEzIq7XBx6UzlnhjPjm/4eoLMXV1XVBgHOEezyiI7
 ceZg==
X-Gm-Message-State: AOJu0YwJ7rAV8/GVgRfiuJGAYePUVYaai8BqQIV7SgfJ2u12Xk4HQ7l2
 RtaJIN7647/A8chJpyEOvmeWwY8bmMj8gdD9D7Tboq8x2w9kq5eQ33fSZPzf0D04bs+TnWHu/DJ
 tzb3pfGSOCDMGFE8cBtAlyeI0zlpiBGMTZEZJ3VwVr7+0XC3jHOoOzTS2e+PgTG/1rXCfqBn7x1
 4=
X-Received: by 2002:a05:620a:258e:b0:775:92bb:eb25 with SMTP id
 x14-20020a05620a258e00b0077592bbeb25mr17714525qko.55.1698276457431; 
 Wed, 25 Oct 2023 16:27:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH//V3DVUW2T1gepgWcXd8RNdgEvSkvZ77nuvxmogHgLgOXlAGrLyxgfDz7I23yFWdCnOrOOg==
X-Received: by 2002:a05:620a:258e:b0:775:92bb:eb25 with SMTP id
 x14-20020a05620a258e00b0077592bbeb25mr17714509qko.55.1698276457044; 
 Wed, 25 Oct 2023 16:27:37 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 vv16-20020a05620a563000b007677347e20asm4537496qkn.129.2023.10.25.16.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:27:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 09/24] kvm: require KVM_CAP_INTERNAL_ERROR_DATA
Date: Thu, 26 Oct 2023 01:27:02 +0200
Message-ID: <20231025232718.89428-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025232718.89428-1-pbonzini@redhat.com>
References: <20231025232718.89428-1-pbonzini@redhat.com>
MIME-Version: 1.0
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This was introduced in KVM in Linux 2.6.33, we can require it unconditionally.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 3f7eafe08cb..8eee5042252 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -111,6 +111,7 @@ static const KVMCapabilityInfo kvm_required_capabilites[] = {
     KVM_CAP_INFO(USER_MEMORY),
     KVM_CAP_INFO(DESTROY_MEMORY_REGION_WORKS),
     KVM_CAP_INFO(JOIN_MEMORY_REGIONS_WORKS),
+    KVM_CAP_INFO(INTERNAL_ERROR_DATA),
     KVM_CAP_LAST_INFO
 };
 
@@ -2794,16 +2795,14 @@ static void kvm_handle_io(uint16_t port, MemTxAttrs attrs, void *data, int direc
 
 static int kvm_handle_internal_error(CPUState *cpu, struct kvm_run *run)
 {
+    int i;
+
     fprintf(stderr, "KVM internal error. Suberror: %d\n",
             run->internal.suberror);
 
-    if (kvm_check_extension(kvm_state, KVM_CAP_INTERNAL_ERROR_DATA)) {
-        int i;
-
-        for (i = 0; i < run->internal.ndata; ++i) {
-            fprintf(stderr, "extra data[%d]: 0x%016"PRIx64"\n",
-                    i, (uint64_t)run->internal.data[i]);
-        }
+    for (i = 0; i < run->internal.ndata; ++i) {
+        fprintf(stderr, "extra data[%d]: 0x%016"PRIx64"\n",
+                i, (uint64_t)run->internal.data[i]);
     }
     if (run->internal.suberror == KVM_INTERNAL_ERROR_EMULATION) {
         fprintf(stderr, "emulation failure\n");
-- 
2.41.0


