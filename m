Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A695474D246
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:52:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInZ4-0005RX-3f; Mon, 10 Jul 2023 05:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qInYV-0005An-Nh
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qInYU-0004Zv-3o
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688982701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oO1yP2V7gEz0ygXxQ+mvNNEq89MgTm0X3M26XqdcGo0=;
 b=PuRoAtHhi0U+eiLTJ0oe+uhWmvGr3GTsbKcjZsi7SZFFpNNym9G/tK5wd0NmA0q0Y28Z30
 3+iN8CPUyhr/PjuZ6bxxDaxjq9C7X0bencmHhBHxfgMsUsi9w2Fx5P5rXlrbi8MuQZPQgE
 MR8pB99yDa2xKKTZ8yh16/8XtlvZP+E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-S8j-SdLwOaepuxLXmtyeSg-1; Mon, 10 Jul 2023 05:51:39 -0400
X-MC-Unique: S8j-SdLwOaepuxLXmtyeSg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 716943844FA0;
 Mon, 10 Jul 2023 09:51:39 +0000 (UTC)
Received: from kostyanf14nb.redhat.com (unknown [10.45.225.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AE9A40C206F;
 Mon, 10 Jul 2023 09:51:38 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 0/3] qga: Add new option --allow-rpcs
Date: Mon, 10 Jul 2023 12:51:33 +0300
Message-Id: <20230710095136.1022704-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The allow-rpcs option accepts a comma-separated list of RPCs to
enable. This option is opposite to --block-rpcs. Using --block-rpcs
and --allow-rpcs at the same time is not allowed.

resolves: https://gitlab.com/qemu-project/qemu/-/issues/1505

v2 -> v1:
  Fix warning when wrong config file specified

v1: https://patchew.org/QEMU/20230706083035.623802-1-kkostiuk@redhat.com/

Konstantin Kostiuk (3):
  qga: Rename ga_disable_not_allowed -> ga_disable_not_allowed_freeze
  qga: Add new option --allow-rpcs
  qga: Add tests for --allow-rpcs option

 docs/interop/qemu-ga.rst |  5 +++
 qga/main.c               | 91 ++++++++++++++++++++++++++++++++++++----
 tests/unit/test-qga.c    | 31 ++++++++++++++
 3 files changed, 118 insertions(+), 9 deletions(-)

--
2.34.1


