Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A12ED7B0726
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 16:42:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlVid-0005QJ-Q7; Wed, 27 Sep 2023 10:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlVic-0005Q2-7V
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 10:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlVia-0000hE-Sh
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 10:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695825646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XzhH1gkGCCNKtn3/xwPer7PAelkiKk5SB1tlE9OGoGA=;
 b=EpPKiWjFahuP2WK+cXXTqsfSFtdk3QhUrpWAgzBmYRRbev5YOcYms3P8ql7G/w0ECnGwiY
 KC7iLrHacH9GxPaqGS4OUQoNA+Kdee5NxDsbkfPqzz2EnFXIpTNwpB2KDrLrBlJ87oJi8n
 Ez+DUHMZDuZ9jTnIu/pQTJ43wvWxwyY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-rYiDLuJbMa2Krj4MdTqgig-1; Wed, 27 Sep 2023 10:40:42 -0400
X-MC-Unique: rYiDLuJbMa2Krj4MdTqgig-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D5ED3C23FE5;
 Wed, 27 Sep 2023 14:40:42 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1B96492C37;
 Wed, 27 Sep 2023 14:40:41 +0000 (UTC)
From: "Eric Blake" <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, andrey.drobyshev@virtuozzo.com,
 peter.maydell@linaro.org, Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 3/3] mailmap: Fix BALATON Zoltan author email
Date: Wed, 27 Sep 2023 09:38:19 -0500
Message-ID: <20230927143815.3397386-8-eblake@redhat.com>
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

From: Eric Blake <eblake@redhat.com>

This fixes authorship of commits 5cbd51a5 and friends, where the
qemu-ppc mailing list rewrote the "From:" field in the corresponding
patches.  See commit 3bd2608db7 ("maint: Add .mailmap entries for
patches claiming list authorship") for explanation.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index fadf6e74506..d2149592887 100644
--- a/.mailmap
+++ b/.mailmap
@@ -59,6 +59,7 @@ Julia Suvorova <jusual@mail.ru> Julia Suvorova via Qemu-devel <qemu-devel@nongnu
 Justin Terry (VM) <juterry@microsoft.com> Justin Terry (VM) via Qemu-devel <qemu-devel@nongnu.org>
 Stefan Weil <sw@weilnetz.de> Stefan Weil via <qemu-devel@nongnu.org>
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com> Andrey Drobyshev via <qemu-block@nongnu.org>
+BALATON Zoltan <balaton@eik.bme.hu> BALATON Zoltan via <qemu-ppc@nongnu.org>

 # Next, replace old addresses by a more recent one.
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markovic@mips.com>
-- 
2.41.0


