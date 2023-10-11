Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 519E47C4AA0
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 08:32:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqSkc-0001r2-8d; Wed, 11 Oct 2023 02:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qqSkU-0001q3-Cg
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 02:31:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qqSkS-0006rG-PI
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 02:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697005871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UVm9nEWfBVHV0TWOUNy9M417MZyEmmdt261AL01UI4o=;
 b=Zq1i9j24hsKyi9YLuJforcTgarEIP1e6f9Xlj/prkvTdz2O8mNBeDhftDG5XqTeP6z1r+P
 m4fCEmgwp/6yVu+vHX2UZI2wKGd2J8ORt2nbB21i1jhq/dmK4bTCm8PMYhJzWwIXZ05Sby
 28R2zRmXDBJNBZYDssY8Fa379vRNJcg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-BpK8owk9MtGY1lKOOCXBDQ-1; Wed, 11 Oct 2023 02:31:10 -0400
X-MC-Unique: BpK8owk9MtGY1lKOOCXBDQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD7043857B72;
 Wed, 11 Oct 2023 06:31:09 +0000 (UTC)
Received: from localhost (unknown [10.39.208.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 094A41C060DF;
 Wed, 11 Oct 2023 06:31:08 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	stefanha@redhat.com,
	vr_qemu@t-online.de
Subject: [PULL 1/8] hw/audio/es1370: reset current sample counter
Date: Wed, 11 Oct 2023 10:30:54 +0400
Message-ID: <20231011063101.258955-2-marcandre.lureau@redhat.com>
In-Reply-To: <20231011063101.258955-1-marcandre.lureau@redhat.com>
References: <20231011063101.258955-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Volker Rümelin <vr_qemu@t-online.de>

Reset the current sample counter when writing the Channel Sample
Count Register. The Linux ens1370 driver and the AROS sb128
driver expect the current sample counter counts down from sample
count to 0 after a write to the Channel Sample Count Register.
Currently the current sample counter starts from 0 after a reset
or the last count when the counter was stopped.

The current sample counter is used to raise an interrupt whenever
a complete buffer was transferred. When the counter starts with a
value lower than the reload value, the interrupt triggeres before
the buffer was completly transferred. This may lead to corrupted
audio streams.

Tested-by: Rene Engel <ReneEngel80@emailn.de>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20230917065813.6692-1-vr_qemu@t-online.de>
---
 hw/audio/es1370.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 90f73d4c23..0567721eb7 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -502,7 +502,7 @@ static void es1370_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
     case ES1370_REG_DAC2_SCOUNT:
     case ES1370_REG_ADC_SCOUNT:
         d += (addr - ES1370_REG_DAC1_SCOUNT) >> 2;
-        d->scount = (val & 0xffff) | (d->scount & ~0xffff);
+        d->scount = (val & 0xffff) << 16 | (val & 0xffff);
         ldebug ("chan %td CURR_SAMP_CT %d, SAMP_CT %d\n",
                 d - &s->chan[0], val >> 16, (val & 0xffff));
         break;
-- 
2.41.0


