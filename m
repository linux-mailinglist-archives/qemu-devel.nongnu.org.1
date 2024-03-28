Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D21A87932B
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Mar 2024 12:39:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0SM-00088M-3X; Tue, 12 Mar 2024 07:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rk0RP-0007Gt-1W
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rk0RJ-0003BW-9o
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710243418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhrgPSWh3/CZjT1Prh2aYVoBUzi3uS9GB7YTqPQ4pQ4=;
 b=fZ3f1ad5qDXYkMKmfFnIKN9ZZbuZnaQS/r12Flf9fL6RMGnZTbJ+TZzE19k4BPH1KWDRKo
 gK/OcuAF+Ham4KHVZvRE0+qEY+XgX+1+LEj2F9L+S+mCnHwZnToeA1VVju2/ask1Wn/TMp
 2O9E4yAwgSq0nF/edvOZ+WwivTmw6mk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-V5MlNyTbNKSJCxUqHj28Aw-1; Tue, 12 Mar 2024 07:36:55 -0400
X-MC-Unique: V5MlNyTbNKSJCxUqHj28Aw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B61D1811E81;
 Tue, 12 Mar 2024 11:36:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D7FC2492BC6;
 Tue, 12 Mar 2024 11:36:52 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Nick Briggs <nicholas.h.briggs@gmail.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 3/8] Avoid unaligned fetch in ladr_match()
Date: Tue, 12 Mar 2024 19:36:37 +0800
Message-ID: <20240312113642.36862-4-jasowang@redhat.com>
In-Reply-To: <20240312113642.36862-1-jasowang@redhat.com>
References: <20240312113642.36862-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Nick Briggs <nicholas.h.briggs@gmail.com>

There is no guarantee that the PCNetState is allocated such that
csr[8] is allocated on an 8-byte boundary.  Since not all hosts are
capable of unaligned fetches the 16-bit elements need to be fetched
individually to avoid a potential fault.  Closes issue #2143

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2143
Signed-off-by: Nick Briggs <nicholas.h.briggs@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/pcnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index 494eab8479..ad675ab29d 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -632,7 +632,7 @@ static inline int ladr_match(PCNetState *s, const uint8_t *buf, int size)
 {
     struct qemu_ether_header *hdr = (void *)buf;
     if ((*(hdr->ether_dhost)&0x01) &&
-        ((uint64_t *)&s->csr[8])[0] != 0LL) {
+        (s->csr[8] | s->csr[9] | s->csr[10] | s->csr[11]) != 0) {
         uint8_t ladr[8] = {
             s->csr[8] & 0xff, s->csr[8] >> 8,
             s->csr[9] & 0xff, s->csr[9] >> 8,
-- 
2.42.0


