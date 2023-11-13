Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B6B7E9D84
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 14:45:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2XEL-0005Ng-2P; Mon, 13 Nov 2023 08:43:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r2XEG-0005Kl-9C
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 08:43:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r2XED-0006ed-Io
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 08:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699883029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uv3oL7Y2G0XLMiOnzVJ7oNmg5jL57540u26sSWVlPC8=;
 b=cxUl9xsnLef4c4HWzPQAmrQz8stkDVBQUdlUmgu5w+Hz/CHxGQYCXJg9egwJByGKjN+CTY
 fKp4mx5VN/uz8IxUkOYGXQRba84HPFd8z5PwB47mw94DenrBeNaueBWqIdFRn6eyIjMGdD
 eMLz9KK0iWMau2Su0P+bh2fV8FTZF5s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-mqVAkllUOfy7qB806qLh9w-1; Mon,
 13 Nov 2023 08:43:45 -0500
X-MC-Unique: mqVAkllUOfy7qB806qLh9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E19D3C14904;
 Mon, 13 Nov 2023 13:43:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 28FE6C15983;
 Mon, 13 Nov 2023 13:43:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2D05A21E6A1F; Mon, 13 Nov 2023 14:43:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair@alistair23.me, edgar.iglesias@gmail.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com, qemu-arm@nongnu.org
Subject: [PATCH 0/2] Replace anti-social QOM type names (again)
Date: Mon, 13 Nov 2023 14:43:42 +0100
Message-ID: <20231113134344.1195478-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We got rid of QOM type names containing ',' in 6.0, but some have
crept back in.  Replace them just like we did in 6.0.

Cover letter of 6.0's replacement:
https://lore.kernel.org/qemu-devel/20210304140229.575481-1-armbru@redhat.com/

Markus Armbruster (2):
  docs/system/arm: Fix for rename of type "xlnx.bbram-ctrl"
  hw: Replace anti-social QOM type names (again)

 docs/system/arm/xlnx-versal-virt.rst     | 4 ++--
 include/hw/misc/xlnx-versal-cframe-reg.h | 2 +-
 include/hw/misc/xlnx-versal-cfu.h        | 6 +++---
 include/hw/misc/xlnx-versal-crl.h        | 2 +-
 include/hw/nvram/xlnx-efuse.h            | 2 +-
 include/hw/nvram/xlnx-versal-efuse.h     | 4 ++--
 include/hw/nvram/xlnx-zynqmp-efuse.h     | 2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.41.0


