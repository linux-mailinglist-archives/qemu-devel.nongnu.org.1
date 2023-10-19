Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FDD7CFD39
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:49:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtUKg-0008TA-OK; Thu, 19 Oct 2023 10:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtUKb-0008Pr-ON
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:49:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtUKZ-0004hB-S6
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697726938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=P7zvEP/G7/UoWkMdn9O7KhmDjkETN3/VUcjMUECJi/s=;
 b=Z7HhJ6+VCoeGJybWOockMZP2vpxebWlLBnar9LzNfqJJU3cIW43D6RAIZmDQDnqa2FadAm
 oMZL7XVnJ94bXBm+JWZCWMxwe3DRcZpQwXvXXhd9x9xgEb05Iz39hgT40i6CbjGWQ5yJOw
 yaltGfrU9Fc8nvnBRn9W4UW7DCwXlL0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-WBATLYvhMsGmLBr8vKDNDw-1; Thu, 19 Oct 2023 10:48:57 -0400
X-MC-Unique: WBATLYvhMsGmLBr8vKDNDw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A395C10201F7
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:48:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8353225C8
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:48:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7B49821E6A1F; Thu, 19 Oct 2023 16:48:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 0/3] QAPI patches patches for 2023-10-19
Date: Thu, 19 Oct 2023 16:48:52 +0200
Message-ID: <20231019144855.833802-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit deaca3fd30d3a8829160f8d3705d65ad83176800:

  Merge tag 'pull-vfio-20231018' of https://github.com/legoater/qemu into staging (2023-10-18 06:21:15 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2023-10-19

for you to fetch changes up to e307a8174bb876ba0ac91cf1c2ced01ec4374af9:

  qapi: provide a friendly string representation of QAPI classes (2023-10-19 07:21:37 +0200)

----------------------------------------------------------------
QAPI patches patches for 2023-10-19

----------------------------------------------------------------
Daniel P. Berrangé (1):
      qapi: provide a friendly string representation of QAPI classes

John Snow (1):
      qapi: re-establish linting baseline

Markus Armbruster (1):
      qapi: Belatedly update CompatPolicy documentation for unstable

 qapi/compat.json       | 4 ++--
 scripts/qapi/gen.py    | 2 +-
 scripts/qapi/parser.py | 5 +++--
 scripts/qapi/schema.py | 5 +++++
 4 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.41.0


