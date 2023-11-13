Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9CB7E991D
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 10:37:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2TN0-0007y0-BT; Mon, 13 Nov 2023 04:36:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r2TMs-0007we-NU
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 04:36:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r2TMp-0001xH-V8
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 04:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699868185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wNqioex2+VB5no0qXPn54WCogZjaauY/Y5i9gqFytyQ=;
 b=ZrQu9OeLIzP4eo1prQkpsuCB41qJkBZIcdLLo5wWC4jEd07IXLAr4GRozLXVBeLdOJ8VZ3
 bNxwzFCkpdUBjgMEFlms+ggy4EhJEv/aYNWxuhO1eGo3kUJZUYa3HZZ4AwUglRdPm2PJE0
 cBD6dAtSMD5VlLSF95sfu4lfPihCmPs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-c1jg8skcOqKCRzX0dqGUew-1; Mon,
 13 Nov 2023 04:36:23 -0500
X-MC-Unique: c1jg8skcOqKCRzX0dqGUew-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 180803816B48
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:36:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EAEE21C060AE
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:36:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DEF0621E6A1F; Mon, 13 Nov 2023 10:36:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 0/2] -Wshadow=local patches for 2023-11-13
Date: Mon, 13 Nov 2023 10:36:19 +0100
Message-ID: <20231113093621.750115-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The following changes since commit 69680740eafa1838527c90155a7432d51b8ff203:

  Merge tag 'qdev-array-prop' of https://repo.or.cz/qemu/kevin into staging (2023-11-11 11:23:25 +0800)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-shadow-2023-11-13

for you to fetch changes up to 569205e4e92f802cf409fe03dd2ac41dd0b54aae:

  meson: Enable -Wshadow=local (2023-11-13 10:32:57 +0100)

----------------------------------------------------------------
-Wshadow=local patches for 2023-11-13

----------------------------------------------------------------
Markus Armbruster (1):
      meson: Enable -Wshadow=local

Thomas Huth (1):
      block/snapshot: Fix compiler warning with -Wshadow=local

 meson.build      | 1 +
 block/snapshot.c | 6 ++----
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.41.0


