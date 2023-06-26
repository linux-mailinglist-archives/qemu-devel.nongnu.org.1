Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EFD73E20B
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 16:24:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlL7-00027d-2R; Mon, 26 Jun 2023 08:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKe-0001x2-WB
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKd-0002pH-9f
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2SGHL2LHvwzaWBgCYGtwaYW5rqEUKCoWms25kqlSWFs=;
 b=LQvuRa3ao3LiTTya/ajf/dpCuXNlfK/GgXVxO6k5mZjDpBhwUbs/fdR5CMhtcimGS18Zes
 JCIGBFMemue+oIxVGJ9lTauGfqVvDhuxOAxbe95OIR3mGLVkJvgUYqbvLyQjncXp9A+BV/
 jwJUm1bBG+84tRQ8hIhc56Rd3ZFgbn4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-ghBRY_QQOjupxYMR4jFSAw-1; Mon, 26 Jun 2023 08:28:33 -0400
X-MC-Unique: ghBRY_QQOjupxYMR4jFSAw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b6a0772b97so7638371fa.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782511; x=1690374511;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2SGHL2LHvwzaWBgCYGtwaYW5rqEUKCoWms25kqlSWFs=;
 b=G27Fbh2dAkNlzVYtpmVUIJjXd/dWBgEcylN2Ge8gcApo+IG6EhfaReOdUyHgVuB9eH
 mx2kfZtw5GOjmp5q2lwtxLJvU/iOzod0ZG7QyODYjpa9OHc1q01KTHiUjGoulrwHqs+Y
 AubyWTtOZ72arKxbUlQrcPg92ESxnsZTPqi1KEX9pYWSwmw5bZYsFCQAb0crGz6ujAy8
 obcDalKJPc5aen0CTEojuZ3QX2c7wT7FkKB4eFcqPDkbvTPWEWtZJj2hu7T3Nn6/Zifs
 69I6ooFgi8Gr7jxd4tI3s2mEHMEyrLlFTWheFltJDL1ksnztZ8xCJRnvL4k2Dk+sVpd+
 +5Nw==
X-Gm-Message-State: AC+VfDzuRdTG0xeeLyyuzhUpEgW1ED2nZ1sieQ/uYHtAL2SiEl0Pj5oV
 +MR+66IZB9wehAHOzXmdnyCc5mEKh/EVzGWXcsI3f0e8Q2clRIFm2YhJhPRAqG81hXeKVmoCye4
 FxAoWSfaFavrFAIP2HC5npm+eZlZPvQAyzag9kTXla2iXhglwc3Y2jBvzDsmO0sRf+6vA
X-Received: by 2002:a19:6418:0:b0:4f9:571d:c50e with SMTP id
 y24-20020a196418000000b004f9571dc50emr9597064lfb.36.1687782511487; 
 Mon, 26 Jun 2023 05:28:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7oYc8eeekdb9sTHbTMX6gS9I7dLEk2lQptTCTrWd/ayxP6THs93h8HQqI5ATWQsfxeUjiSrA==
X-Received: by 2002:a19:6418:0:b0:4f9:571d:c50e with SMTP id
 y24-20020a196418000000b004f9571dc50emr9597045lfb.36.1687782511183; 
 Mon, 26 Jun 2023 05:28:31 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 u18-20020a5d6ad2000000b00313e90d1d0dsm5325493wrw.112.2023.06.26.05.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:28:30 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:28:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 13/53] softmmu: Introduce qemu_target_page_mask() helper
Message-ID: <b3b408ffb9291e887029051a522a2c968a816d22.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since TARGET_PAGE_MASK is poisoned in target-agnostic code,
introduce the qemu_target_page_mask() helper to get this
value from target-agnostic code at runtime.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230524093744.88442-2-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/target_page.h | 1 +
 softmmu/physmem.c          | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/exec/target_page.h b/include/exec/target_page.h
index bbf37aea17..98ffbb5c23 100644
--- a/include/exec/target_page.h
+++ b/include/exec/target_page.h
@@ -15,6 +15,7 @@
 #define EXEC_TARGET_PAGE_H
 
 size_t qemu_target_page_size(void);
+int qemu_target_page_mask(void);
 int qemu_target_page_bits(void);
 int qemu_target_page_bits_min(void);
 
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 6bdd944fe8..bda475a719 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -3359,6 +3359,11 @@ size_t qemu_target_page_size(void)
     return TARGET_PAGE_SIZE;
 }
 
+int qemu_target_page_mask(void)
+{
+    return TARGET_PAGE_MASK;
+}
+
 int qemu_target_page_bits(void)
 {
     return TARGET_PAGE_BITS;
-- 
MST


