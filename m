Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C91A17EF4A6
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 15:36:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3zwE-0004sj-Ai; Fri, 17 Nov 2023 09:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r3zwB-0004sa-2N
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 09:35:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r3zw9-0002hX-H9
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 09:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700231712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1RhIdUI3EcLvEOlz+I7ld9yGjon6bBtJC2tBRc/POpY=;
 b=V1G6bugpeopVqapNM3WBFxYtdJft0uIzY/lhDi11wFhE8knxUqaSDGQgAufXkoa+YZLZ1j
 CqvGFe4lriNaPUFNIdh5VyBnOOAF+NJFWcNe5PlOZKxTONew1zOXPJHsfkmH0BI1LkFLbM
 dO1LaN6Z576jmLi6Fm+89wIQEjsPhWg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-EUiPi0RMNw2n-zXRcIrzOg-1; Fri,
 17 Nov 2023 09:35:09 -0500
X-MC-Unique: EUiPi0RMNw2n-zXRcIrzOg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 988041C07559;
 Fri, 17 Nov 2023 14:35:09 +0000 (UTC)
Received: from localhost (unknown [10.39.208.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A625E2026D4C;
 Fri, 17 Nov 2023 14:35:08 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, dwmw@amazon.co.uk
Subject: [PATCH for-8.2 0/3] UI: fix default VC regressions
Date: Fri, 17 Nov 2023 18:35:02 +0400
Message-ID: <20231117143506.1521718-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Hi,

There are a few annoying regressions with the default VCs introduced with the
pixman series. The "vl: revert behaviour for -display none" change solves most
of the issues. Another one is hit when using remote displays, and VCs are not
created as they used to, see: "ui/console: fix default VC when there are no
display". Finally, "ui: use "vc" chardev for dbus, gtk & spice-app" was meant to
be included in the pixman series and also brings back default VCs creation.

Marc-André Lureau (3):
  vl: revert behaviour for -display none
  ui: use "vc" chardev for dbus, gtk & spice-app
  ui/console: fix default VC when there are no display

 system/vl.c    |  2 +-
 ui/console.c   | 18 ++++++++----------
 ui/dbus.c      |  1 +
 ui/gtk.c       |  1 +
 ui/spice-app.c |  1 +
 5 files changed, 12 insertions(+), 11 deletions(-)

-- 
2.41.0


