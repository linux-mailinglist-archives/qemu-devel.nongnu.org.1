Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A80C37870F6
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 15:58:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZAps-0007lS-CL; Thu, 24 Aug 2023 09:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qZApq-0007l7-IR
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 09:57:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qZApo-0001oc-F4
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 09:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692885433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mxO0E7n8I/kNnXtsay2NQ8vqeIx2fnHx8d3x/szsKsc=;
 b=G2Av4PgOvxtruNce2QehQK3Krixhyz1VQxDPWPb6UbXkPu3/dWqUAKEqHxVtSIGCRjoh67
 QeMCZtL2J+3QeTF8qmFhqXPbMHBWip8u8Biqu0NKE6kvCrarwnZbaA5WeQCZ/HiMhH/D5K
 GN+9eaTnalA965Ersaz5hOHt9oDe3n0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-SD25umEbN9aClSbtNdVveA-1; Thu, 24 Aug 2023 09:57:12 -0400
X-MC-Unique: SD25umEbN9aClSbtNdVveA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C407D280AA28
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 13:57:11 +0000 (UTC)
Received: from work.redhat.com (unknown [10.39.193.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39C646B2B3;
 Thu, 24 Aug 2023 13:57:11 +0000 (UTC)
From: Tim Wiederhake <twiederh@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tim Wiederhake <twiederh@redhat.com>
Subject: [PATCH 0/3] Fix some feature names for i386
Date: Thu, 24 Aug 2023 15:57:07 +0200
Message-Id: <20230824135710.343175-1-twiederh@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=twiederh@redhat.com;
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

Some feature names were missing, wrong, or duplicated in the
feature_word_info table. See individual commits for details.

This introduces some merge conflicts for
https://lists.nongnu.org/archive/html/qemu-devel/2023-08/msg02005.html
but that series might need to be reworked anyway.

Regards,
Tim

Tim Wiederhake (3):
  target/i386: Add missing feature names in FEAT_VMX_EPT_VPID_CAPS
  target/i386: Fix feature names in FEAT_VMX_EPT_VPID_CAPS
  target/i386: Fix duplicated feature name in FEAT_KVM

 target/i386/cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.39.2


