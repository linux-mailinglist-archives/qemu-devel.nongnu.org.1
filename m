Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7D9734E79
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 10:49:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBAYN-0000gE-QT; Mon, 19 Jun 2023 04:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <belmouss@redhat.com>)
 id 1qBAY8-0000Z0-3x
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 04:47:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <belmouss@redhat.com>)
 id 1qBAY6-0001vQ-68
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 04:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687164464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4w3YpH5qXapneVx3HaqAk+3r8QPENMI65AdTYVcRres=;
 b=Cj4ZXNbXD4YWBiZD6ywvXCV5Auec53HubCaRuDunPIt78AUiGapyNl3FHoRzEbeGR6/N4i
 35fp9szKTE+qQEWfmqmZCqu6J+S1t8z2dooiKsmluCJnrqFwe5QD+BnbUNHyQRHkFB3AxA
 4kH60Q4hyctsGBN5H119jigdfhDQc+8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-vlECUEMnPvCgE-mdrYxVgw-1; Mon, 19 Jun 2023 04:47:42 -0400
X-MC-Unique: vlECUEMnPvCgE-mdrYxVgw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A22403C0ED4A
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:47:42 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.45.225.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22B1740C20F5
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:47:41 +0000 (UTC)
From: Bilal Elmoussaoui <belmouss@redhat.com>
To: qemu-devel@nongnu.org
Subject: 
Date: Mon, 19 Jun 2023 10:43:12 +0200
Message-ID: <20230619084720.452296-2-belmouss@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=belmouss@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Expose the recently added multi touch support on the UI DBus backend

Bilal Elmoussaoui (2):
  ui/touch: Move event handling to a common helper
  ui/dbus: Expose a touch device interface

 include/ui/console.h | 15 ++++++++++
 ui/console.c         | 65 ++++++++++++++++++++++++++++++++++++++++++++
 ui/dbus-console.c    | 59 +++++++++++++++++++++++++++++++++++++++-
 ui/dbus-display1.xml | 45 ++++++++++++++++++++++++++++--
 ui/gtk.c             | 61 ++++-------------------------------------
 ui/trace-events      |  1 +
 6 files changed, 187 insertions(+), 59 deletions(-)



