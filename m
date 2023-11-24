Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C7C7F77B7
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 16:25:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Y2m-0004iS-Hb; Fri, 24 Nov 2023 10:24:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r6Y2k-0004ht-C6
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:24:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r6Y2j-0004BZ-0U
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700839472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YmHH4Lq7wXhVn5H+D0xjFuHkteZqE8fy6RhYHDV9pGE=;
 b=HdWafBQFZCj7/0pvN+VXxylIsVf8mpf+ZvkzvvE9D6EP1xvXhYIycUQuW9zcnFkAORXSW5
 98ybxhtUsxXUyDdFb8aXkFmHYs2PYA0CygeIcCArX+dAE/Ez/KOrOxT16mv880UZw7Cmcv
 FKx+9KkZpTC5qafI/ngjxjnnd05ltWY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-tCqq2nQpOOibu2h8-ChDOQ-1; Fri, 24 Nov 2023 10:24:31 -0500
X-MC-Unique: tCqq2nQpOOibu2h8-ChDOQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-77d6854a3f9so217927385a.3
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 07:24:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700839470; x=1701444270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YmHH4Lq7wXhVn5H+D0xjFuHkteZqE8fy6RhYHDV9pGE=;
 b=fm8udLjHXE6g/360ba7OXmyo0G3K/6mrrvuSG9yI7v1WvKu2U4FKTdjIEoB6lrgJgu
 U/HkWLnXenJmV7nnQ+TqlRw+Or8vtXGZ6QMBpNvEHYBs3gNFqjDBMvu79NgGcIAbQydp
 VoKLnJcLuV8izU0nmGy3olFtEzICNUCZKcFNQZI+FAPLO5VTz7VUXfhmUoNL5N/Wvrh5
 Z/EWOulHj5MzmTzjrF2nLTm8pxkR0qvZ/TpTbaCHHwDO5fRB7kfXo/HcJ3ZId661y1bS
 GnaQSD8Sl8GrD0+Zno32PWqsV5HIj4fIfyUXXYZI0DmD/JAD+lKEYJ/iI9WliS0bf5ex
 1bEg==
X-Gm-Message-State: AOJu0YyDHXpkPQYNPNVMirknGVdEkoOMZqNCwJ6KXMyEs9eVpTxRNAcF
 Vz0zGJ8W6Nu/O+7EubUDt6gG2iTkZ5EgDxk2lePr6UXzcOeTsZ4hhQltow3+0Lj37c5qYqIWF/0
 67IINXsjW0UBzud4pdFHy8E18dD/sFCCj8l//zX6lixlHd70xIj03dCaxdDIiJZoL4PaDUMFnst
 w=
X-Received: by 2002:a05:620a:839b:b0:77d:7610:7962 with SMTP id
 pb27-20020a05620a839b00b0077d76107962mr3735099qkn.41.1700839470163; 
 Fri, 24 Nov 2023 07:24:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdIOLE2u6j0QKFuPAc45J0FZQ0HHii+ZnOJeI1KbyiRpjFWVaTiVazIyDO+nEkefr6mJ6KcQ==
X-Received: by 2002:a05:620a:839b:b0:77d:7610:7962 with SMTP id
 pb27-20020a05620a839b00b0077d76107962mr3735063qkn.41.1700839469828; 
 Fri, 24 Nov 2023 07:24:29 -0800 (PST)
Received: from [10.201.49.108] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a05620a261100b0077d85b1d45dsm159875qko.72.2023.11.24.07.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 07:24:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL 08/10] system: Use &error_abort in
 memory_region_init_ram_[device_]ptr()
Date: Fri, 24 Nov 2023 16:24:06 +0100
Message-ID: <20231124152408.140936-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124152408.140936-1-pbonzini@redhat.com>
References: <20231124152408.140936-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

If an unexpected error condition happens, we have to abort
(&fatal_error is meant for expected errors).

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20231120133112.82447-1-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 system/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 304fa843ea1..4d9cb0a7fff 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1692,7 +1692,7 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
 
     /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
     assert(ptr != NULL);
-    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_fatal);
+    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
 }
 
 void memory_region_init_ram_device_ptr(MemoryRegion *mr,
@@ -1711,7 +1711,7 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
 
     /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
     assert(ptr != NULL);
-    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_fatal);
+    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
 }
 
 void memory_region_init_alias(MemoryRegion *mr,
-- 
2.43.0


