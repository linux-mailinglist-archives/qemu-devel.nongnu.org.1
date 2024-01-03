Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E3F822D25
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 13:35:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL0S1-0000rH-3i; Wed, 03 Jan 2024 07:34:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rL0Rx-0000o4-TW
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 07:34:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rL0Rw-0003uA-1u
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 07:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704285259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C2FydINtaM0L+l4F4wTXqiAuybmiMdIpVnxxl8qKyzM=;
 b=hJLcJ7/xNRFgzmKFPXmlIk7BN0fUSmWYri9e5irRoZJ7OcP3BP63vHp6PaYzp5/xYyG2N7
 DFwSwDFjFGgJaSrYb6lDE+m0vkOZ4Ou38FI42em2SKCipBypF+3WQSygvrt/L7nfJV1prd
 BE2iqgH6YsEZ5KvU+F0pYlnYKVe6cg0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-DQbD6Ck3Oz6oapk0TiqjXw-1; Wed, 03 Jan 2024 07:34:16 -0500
X-MC-Unique: DQbD6Ck3Oz6oapk0TiqjXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDC728047C0;
 Wed,  3 Jan 2024 12:34:15 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC56A40C6EB9;
 Wed,  3 Jan 2024 12:34:14 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 0/2] topic: meson: add more compiler hardening flags
Date: Wed,  3 Jan 2024 12:34:12 +0000
Message-ID: <20240103123414.2401208-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
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

This brings more compiler hardening flags to the default QEMU
build process. The proposed flags have already been adopted by
default in the kernel build process. At some point it is hoped
that distros might enable them globally, as they've done in
the past with things like _FORTIFY_SOURCE. Meanwhile they are
easy things to enable in QEMU which have negligible cost and
clear benefits to hardening. Considering QEMU shows no signs
of stoppping the flow of guest triggerable CVEs, investing in
hardening is worthwhile. See the respective commit messages
for details

Changed in v2:

 * Fix spelling of -ftrivial-auto-var-init option

Daniel P. Berrangé (2):
  meson: mitigate against ROP exploits with -fzero-call-used-regs
  meson: mitigate against use of uninitialize stack for exploits

 meson.build | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.43.0


