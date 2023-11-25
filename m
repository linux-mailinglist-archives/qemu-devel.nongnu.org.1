Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8802E7F8CC9
	for <lists+qemu-devel@lfdr.de>; Sat, 25 Nov 2023 18:31:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6wU3-00008l-V8; Sat, 25 Nov 2023 12:30:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1r6wU1-00007E-4S
 for qemu-devel@nongnu.org; Sat, 25 Nov 2023 12:30:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1r6wTz-0004NY-39
 for qemu-devel@nongnu.org; Sat, 25 Nov 2023 12:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700933417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tMVTAD8HC+lHxrjtWqvBKJMvTPF3KmWJxF64AOP54ic=;
 b=X7xBg95ctrEcxM8r4HuNANBtqYJL7lbL/9r/sKK8tR1X7dyzICbQ9s1f1E4UUr4oJofRxY
 A58gjKJNurMs7X6teYq+9cfhCEUksaAdE4Lvb4rOx6oZNWRe6A8mSmbo001pwbbgiF4qtO
 aTay5dDJwmur3HIC24o3IhZxEpQRjfg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-PnlMMCPKN3-12ySAOcP7qw-1; Sat,
 25 Nov 2023 12:30:14 -0500
X-MC-Unique: PnlMMCPKN3-12ySAOcP7qw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DEFDB381078C;
 Sat, 25 Nov 2023 17:30:13 +0000 (UTC)
Received: from kostyanf14nb.redhat.com (unknown [10.45.224.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31505492BE7;
 Sat, 25 Nov 2023 17:30:12 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/1] QGA build bug fixes for QEMU 8.2.0-rc2
Date: Sat, 25 Nov 2023 19:30:10 +0200
Message-ID: <20231125173011.374840-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
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

The following changes since commit 4705fc0c8511d073bee4751c3c974aab2b10a970:

  Merge tag 'pull-for-8.2-fixes-231123-1' of https://gitlab.com/stsquad/qemu into staging (2023-11-24 08:00:18 -0500)

are available in the Git repository at:

  https://github.com/kostyanf14/qemu.git tags/qga-pull-2023-11-25

for you to fetch changes up to 7e5b19793d0519ec761f2bcf6591a4c995de3894:

  build-sys: fix meson project version usage (2023-11-25 19:23:38 +0200)

----------------------------------------------------------------
qga-pull-2023-11-25

----------------------------------------------------------------
Marc-André Lureau (1):
      build-sys: fix meson project version usage

 qga/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
2.42.0


