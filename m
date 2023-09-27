Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA097B0728
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 16:42:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlVib-0005Pg-FG; Wed, 27 Sep 2023 10:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlViY-0005P8-Vj
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 10:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlViX-0000au-NU
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 10:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695825645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ldu6liHropiN5kGE07WPyrowsoo5wduxOv92c9JNaak=;
 b=CE17XM4cSyG67fi5lDSe4gwL03tEG05AisgajNdYBDTJBTatZ90sI5f8t69XUvJrDdYqHA
 5+x+8AbjLDXAAOXpHjfMXi5/WZCdMxDm39Fn0pqe02l5vjcHPNRyya4tMTpsAiz8PqPone
 4XHPrztxQuZQ4NwTh+n5oipEbwZ4GY4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-uNd3YKLUOMy6a2oG-H5lig-1; Wed, 27 Sep 2023 10:40:41 -0400
X-MC-Unique: uNd3YKLUOMy6a2oG-H5lig-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C5F0280165B;
 Wed, 27 Sep 2023 14:40:41 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8FD1E492B05;
 Wed, 27 Sep 2023 14:40:40 +0000 (UTC)
From: "Eric Blake" <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, andrey.drobyshev@virtuozzo.com,
 peter.maydell@linaro.org, Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 1/3] mailmap: Fix Andrey Drobyshev author email
Date: Wed, 27 Sep 2023 09:38:17 -0500
Message-ID: <20230927143815.3397386-6-eblake@redhat.com>
In-Reply-To: <20230927143815.3397386-5-eblake@redhat.com>
References: <20230927143815.3397386-5-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

This fixes authorship of commits 2848289168, 52b10c9c0c as the mailing
list rewrote the "From:" field in the corresponding patches.  See commit
3bd2608db7 ("maint: Add .mailmap entries for patches claiming list
authorship") for explanation.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20230926102801.512107-1-andrey.drobyshev@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 64ef9f4de6f..04a7feb005b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -46,6 +46,7 @@ Ian McKellar <ianloic@google.com> Ian McKellar via Qemu-devel <qemu-devel@nongnu
 Julia Suvorova <jusual@mail.ru> Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>
 Justin Terry (VM) <juterry@microsoft.com> Justin Terry (VM) via Qemu-devel <qemu-devel@nongnu.org>
 Stefan Weil <sw@weilnetz.de> Stefan Weil via <qemu-devel@nongnu.org>
+Andrey Drobyshev <andrey.drobyshev@virtuozzo.com> Andrey Drobyshev via <qemu-block@nongnu.org>

 # Next, replace old addresses by a more recent one.
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markovic@mips.com>
-- 
2.41.0


