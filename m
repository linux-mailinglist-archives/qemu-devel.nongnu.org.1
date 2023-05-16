Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D2C704B45
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 13:00:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysP9-0001QL-Gl; Tue, 16 May 2023 06:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysP6-0001JV-AQ
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysOi-00084j-Iz
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684234755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FayYwThs25Dl8i8SOz3tLnsDO2kYo9i3jD8JBO/RWl4=;
 b=V1RTgM4sSTGGGJxwOsoGL5wxdtE0yCd6eJJ5UwVWeLqJJ3lnsbKh7AHVi+98ZNVxVy/62v
 WiVRLaRgngUezOC2kZwdvErITszjq2cRKYA0jtGwpGneuDBdD4AHvi37RvkjKTPb70EMH6
 s0MD6MaZjKXtIUdJkV+Z5t9yHLGSReU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-vXOEe_AwM2y7Q_CfwoD8kQ-1; Tue, 16 May 2023 06:59:12 -0400
X-MC-Unique: vXOEe_AwM2y7Q_CfwoD8kQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26C8085C06D;
 Tue, 16 May 2023 10:59:12 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CA92492B00;
 Tue, 16 May 2023 10:59:11 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	philmd@linaro.org,
	berrange@redhat.com
Subject: [PATCH v2 02/27] python: update pylint configuration
Date: Tue, 16 May 2023 12:58:43 +0200
Message-Id: <20230516105908.527838-2-pbonzini@redhat.com>
In-Reply-To: <20230516105908.527838-1-pbonzini@redhat.com>
References: <20230516105908.527838-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

Pylint 2.17.x decided that SocketAddrT was a bad name for a Type Alias for some
reason. Sure, fine, whatever.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230511035435.734312-3-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/setup.cfg | 1 +
 1 file changed, 1 insertion(+)

diff --git a/python/setup.cfg b/python/setup.cfg
index 9e923d97628f..3f36502954e4 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -132,6 +132,7 @@ good-names=i,
            fd,  # fd = os.open(...)
            c,   # for c in string: ...
            T,   # for TypeVars. See pylint#3401
+           SocketAddrT,  # Not sure why this is invalid.
 
 [pylint.similarities]
 # Ignore imports when computing similarities.
-- 
2.40.1



