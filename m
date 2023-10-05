Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B357BA836
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 19:40:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoSJQ-0002sl-QH; Thu, 05 Oct 2023 13:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qoSJK-0002lC-Aw
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 13:38:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qoSJI-00039D-Sg
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 13:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696527503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w+XqRmQLkx5WL2QG/hMOCfW3bt6RkXb/YCFt0zsQ694=;
 b=JfKFRMxkJWtvPUKxCTStSxBS4c82TKcgNuTNFRvfRr1N3vrUNztS2CBYLXCGXKl8yF/OTt
 KmwQRrfhvu+kD3xxLrKlsD0DXO0YXEcSbvMi3Fbh1KWdiEyzJPBXS1gC1LvFQk39QUYIQj
 b1udwMcXRmoZR7QQpdn87D4XAaq1k8I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-bpOZZ_FnMtWE-kvhyv5fDg-1; Thu, 05 Oct 2023 13:38:19 -0400
X-MC-Unique: bpOZZ_FnMtWE-kvhyv5fDg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92FA2810BD8;
 Thu,  5 Oct 2023 17:38:19 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5C82215670B;
 Thu,  5 Oct 2023 17:38:18 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] topic: meson: add more compiler hardening flags
Date: Thu,  5 Oct 2023 18:38:10 +0100
Message-ID: <20231005173812.966264-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

I also tested enabling -ftrapv, to change signed integer
overflow from wrapping, to trapping instead. This exposed a
bug in the string-input-visitor which overflows when parsing
ranges, and exposed the test-int128 code as (harmlessly)
overflowing during its testing. Both can be fixed, but I'm
not entirely sure whether -ftrapv is viable or not. I was
wondering about TCG and whether it has a need to intentionally
allow integer overflow for any of its instruction emulation
requirements ?  "make check" passes qtest but that's not
sufficiently broad to make me comfortable. Thus I've not
included an -ftrapv patch here.

Daniel P. Berrangé (2):
  meson: mitigate against ROP exploits with -fzero-call-used-regs
  meson: mitigate against use of uninitialize stack for exploits

 meson.build | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.41.0


