Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF96767073
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 17:24:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPOtn-0000r2-Q2; Fri, 28 Jul 2023 10:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qPOtl-0000py-Ib
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qPOtk-0005H9-2G
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690556214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XwL5jqjrWy3VUmwDVvA4JhWXfBmO1G48xB/s/F+fxyk=;
 b=L3CiY63ulp7A3kTvPQ375IE+57V+wbjbEG069vwuUL9ZTlTP34gUIdKMHOvYpMx5A9E+lQ
 6f1orI+H2SD//NDP89dMnozGevjWAdVNVn0EPY8Wm9eozS2TBGONXbSj1g9nYYvuSjM8++
 ZhcVR4hUWoHs9SaA/VXijDuS4RT3+88=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-PAs5JexLMSqIZ2tkgTkqcw-1; Fri, 28 Jul 2023 10:56:52 -0400
X-MC-Unique: PAs5JexLMSqIZ2tkgTkqcw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 547CD38008C6
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 14:56:52 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A547C492B02
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 14:56:50 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-8.1 0/1] NBD patches for 2023-07-28
Date: Fri, 28 Jul 2023 09:55:49 -0500
Message-ID: <20230728145548.1058053-3-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

The following changes since commit ccdd31267678db9d80578b5f80bbe94141609ef4:

  Merge tag 'pull-qapi-2023-07-26-v2' of https://repo.or.cz/qemu/armbru into staging (2023-07-26 07:16:19 -0700)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2023-07-28

for you to fetch changes up to e5b815b0defcc3617f473ba70c3e675ef0ee69c2:

  qemu-nbd: regression with arguments passing into nbd_client_thread() (2023-07-27 08:33:44 -0500)

----------------------------------------------------------------
NBD patches for 2023-07-28

- Denis V. Lunev: Fix regression in 'qemu-nbd -c /dev/nbdN'

----------------------------------------------------------------
Denis V. Lunev (1):
      qemu-nbd: regression with arguments passing into nbd_client_thread()

 qemu-nbd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

base-commit: ccdd31267678db9d80578b5f80bbe94141609ef4
-- 
2.41.0


