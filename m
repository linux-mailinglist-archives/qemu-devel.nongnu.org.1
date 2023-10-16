Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F93F7CADEB
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 17:44:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsPkv-0005Uw-Kj; Mon, 16 Oct 2023 11:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1qsPkt-0005UV-3a
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:43:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1qsPkr-00079X-9W
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697471020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=+YMFFZLHAZNohMJziJW/If5eTn+3J0Gx77R4mSLf7VY=;
 b=VCOP3xVXrwPJRengHp38MuryrdXt4iuSjnO0ArwLo7On3PEQPjEuJfM24G8I8FhtGWVrhe
 cOhT2TlVF2K3mN9HtFMeqnWMkrFmEf+r6iiuOT6hx7d6mXExp7t0sJOZ1T3ZromZBMgnmE
 Oue89D8NZzOOjphO4s+rrxS3X+XTPKE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-ZLAYXjJJMl-24p-yxSDD-w-1; Mon, 16 Oct 2023 11:43:37 -0400
X-MC-Unique: ZLAYXjJJMl-24p-yxSDD-w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1C8581D9E5
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 15:43:36 +0000 (UTC)
Received: from localhost (unknown [10.42.28.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CCC0492BEE;
 Mon, 16 Oct 2023 15:43:36 +0000 (UTC)
Date: Mon, 16 Oct 2023 16:43:36 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: tcg_flush_jmp_cache replacing qatomic_set loop with memset
Message-ID: <20231016154336.GA27462@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hey Paolo,

Quick question.  I'm sure the transformation below is *not* correct,
because it doesn't preserve the invariant of the lockless structure.
Is there a way to do this while maintaining correctness?  For example
putting barrier() after memset?  (Note I'm also zeroing .pc which may
be a problem.)

The background to this is that I've been playing around with the very
hot tb_lookup function.  Increasing the size of the jump cache (which
hasn't changed since, erm, 2005!), looks like it could improve
performance, plus a few other changes which I'm playing with.  However
increasing the size causes profiles to be dominated by the loop in
tcg_flush_jmp_cache, presumably because of all those serialized atomic ops.

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 8cb6ad3511..6a21b3dba8 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -796,9 +796,7 @@ void tcg_flush_jmp_cache(CPUState *cpu)
         return;
     }
 
-    for (int i = 0; i < TB_JMP_CACHE_SIZE; i++) {
-        qatomic_set(&jc->array[i].tb, NULL);
-    }
+    memset(jc->array, 0, TB_JMP_CACHE_SIZE * sizeof jc->array[0]);
 }
 
 /* This is a wrapper for common code that can not use CONFIG_SOFTMMU */

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
nbdkit - Flexible, fast NBD server with plugins
https://gitlab.com/nbdkit/nbdkit


