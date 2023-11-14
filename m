Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC41D7EAF6F
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 12:44:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2rpG-0004H1-Rp; Tue, 14 Nov 2023 06:43:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2rpE-0004GH-M2
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 06:43:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2rpD-0005hP-0d
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 06:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699962201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=14mCa62RJa2B957wfG+W4h4GYJ0Y9xh9HalnTV09DEs=;
 b=LcZfImdvqj8Ro5NpouXyRZ9yLCsnuqMBIFVIWAeSQQr/nhwmgXL6Znq6vGkSPG36sxFjyP
 mnq+W36zYYgggTdn/lZHMUObKlxaxCbpHJ8fTEpfA0LFlsXKNDn0YroD8HLsTL563DDZ+4
 YnpZ5q/6CnEAV4PCUnSrWdC4nB4BUq4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-pCbDmaGuNW2ukmpa-VyseA-1; Tue, 14 Nov 2023 06:43:20 -0500
X-MC-Unique: pCbDmaGuNW2ukmpa-VyseA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29929811E7D
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 11:43:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6060B2026D4C;
 Tue, 14 Nov 2023 11:43:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/3] Fix s390x PV dumps in case of errors
Date: Tue, 14 Nov 2023 12:43:15 +0100
Message-ID: <20231114114318.158226-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit f78ea7ddb0e18766ece9fdfe02061744a7afc41b:

  Merge tag 'pull-request-2023-11-13' of https://gitlab.com/thuth/qemu into staging (2023-11-13 07:15:43 -0500)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-11-14

for you to fetch changes up to d12a91e0baafce7b1cbacff7cf9339eeb0011732:

  target/s390x/arch_dump: Add arch cleanup function for PV dumps (2023-11-14 10:42:32 +0100)

----------------------------------------------------------------
* Fix s390x PV dumps in case of errors

----------------------------------------------------------------
Janosch Frank (3):
      target/s390x/dump: Remove unneeded dump info function pointer init
      dump: Add arch cleanup function
      target/s390x/arch_dump: Add arch cleanup function for PV dumps

 include/sysemu/dump-arch.h |  1 +
 dump/dump.c                |  4 ++++
 target/s390x/arch_dump.c   | 21 +++++++++++++++++----
 3 files changed, 22 insertions(+), 4 deletions(-)


