Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB608788E11
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 19:52:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZay9-0005Ks-L1; Fri, 25 Aug 2023 13:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qZay7-0005KV-UL
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 13:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qZay5-0000js-Rp
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 13:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692985892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=c+f7DUJ15sCPnoliEmWi1kVJBZhT5yqxfglwKF9avVI=;
 b=AK7r0fXjewdE8EHN1e9aZSrWBEX6X4vmYDazQfDtF8tCSVFQbsBoEA79PPREcyk6Mj/7xa
 SgbnDvzYoQvAzNh9Ap1yyaqEfi/rU16gVAZL/dZMfhJAdX8qoym/gbBizElRPg8mM4aa+1
 C/CR0ebAw+rWz9lM5rRLbd8kwWzBskY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-6-HW9bzMOsuMXlK721sqwg-1; Fri, 25 Aug 2023 13:51:28 -0400
X-MC-Unique: 6-HW9bzMOsuMXlK721sqwg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 740A51C07848;
 Fri, 25 Aug 2023 17:51:28 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF46463A63;
 Fri, 25 Aug 2023 17:51:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-trivial@nongnu.org
Subject: [PATCH 0/3] hw/mips/jazz: Rework the NIC init code
Date: Fri, 25 Aug 2023 19:51:20 +0200
Message-Id: <20230825175123.624114-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The NIC init code of the jazz machines is rather cumbersome, with
a for-loop around it that is always left after the first iteration.
This patch series reworks this a little bit to make the code more
readable and shorter.

Thomas Huth (3):
  hw/mips/jazz: Remove the big_endian variable
  hw/mips/jazz: Move the NIC init code into a separate function
  hw/mips/jazz: Simplify the NIC setup code

 hw/mips/jazz.c | 89 +++++++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 49 deletions(-)

-- 
2.39.3


