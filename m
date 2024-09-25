Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6079857DD
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Sep 2024 13:16:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stPwc-0005Rj-IU; Wed, 25 Sep 2024 07:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPw5-0003r0-KF
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:11:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPw3-0003lp-3x
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727262714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7DEh6045OUJp99Ba8zmy2nR/KEr7ul1oZPdI/Kx0ia4=;
 b=bWVZZ5gKcmAfZezb7qrskzizYC5zdobcEJh+CXXPmoLxW3h9VVZN+9axLxQFTGS2kKcnzN
 r4rbD9vfwF8XHFq0UreTBVCFR54rth+njKddEnQNJnnM8A20DfuJk0CyC3ogMu9j6VxZA7
 LIFAOqTza/4MPYx58PWmQgTekQ5cPbQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-Mcut2KtkNPqbmUO8A6Lngg-1; Wed,
 25 Sep 2024 07:11:51 -0400
X-MC-Unique: Mcut2KtkNPqbmUO8A6Lngg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 396B81935868; Wed, 25 Sep 2024 11:11:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.206])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5BB021956094; Wed, 25 Sep 2024 11:11:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 28/44] hw/tpm: remove break after g_assert_not_reached()
Date: Wed, 25 Sep 2024 13:10:09 +0200
Message-ID: <20240925111029.24082-29-thuth@redhat.com>
In-Reply-To: <20240925111029.24082-1-thuth@redhat.com>
References: <20240925111029.24082-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This patch is part of a series that moves towards a consistent use of
g_assert_not_reached() rather than an ad hoc mix of different
assertion mechanisms.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20240919044641.386068-21-pierrick.bouvier@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/tpm/tpm_spapr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index e084e987e6..5f7a0dfc61 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -206,7 +206,6 @@ static int tpm_spapr_do_crq(struct SpaprVioDevice *dev, uint8_t *crq_data)
                 break;
             default:
                 g_assert_not_reached();
-                break;
             }
             trace_tpm_spapr_do_crq_get_version(be32_to_cpu(local_crq.data));
             spapr_tpm_send_crq(dev, &local_crq);
-- 
2.46.0


