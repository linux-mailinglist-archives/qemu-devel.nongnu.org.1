Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C8F85FCAE
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Feb 2024 16:41:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdBAm-0004Tt-9C; Thu, 22 Feb 2024 10:39:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rdBAj-0004Sl-Qn
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 10:39:41 -0500
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rdBAf-0002T7-4M
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 10:39:41 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9328:0:640:5832:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id EF57A60D43;
 Thu, 22 Feb 2024 18:39:30 +0300 (MSK)
Received: from davydov-max-nux.yandex.net (unknown
 [2a02:6b8:8f:4:b109:a1eb:adad:8bd8])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id CdVQ8Q0i7a60-0QNjMFmn; Thu, 22 Feb 2024 18:39:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1708616370;
 bh=KAQ7bIK/33QGf3xImcTyGRwGSGrbYVHgYfFl9Kfrcqg=;
 h=Cc:Message-Id:References:Date:In-Reply-To:Subject:To:From;
 b=c2EiVvZWkdBaQ7drtHeGGdPF40w2La7w99yuJjYU9CVAzUbs7YUzaBpzGIexivmkz
 M+v91D3pMG/5Ss7U/UB/hNWnQ8O3yy+juncCFbPEfXRRTdf/RLnEuwlWQCmk9e+zlm
 ZK22ebxIyItGALb/HKh1eGEz6/mo2SJ9J+CBFvCA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: davydov-max@yandex-team.ru, vsementsov@yandex-team.ru, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 jsnow@redhat.com, eblake@redhat.com, armbru@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, alxndr@bu.edu, den@virtuozzo.com
Subject: [PATCH v9 1/4] qom: add default value
Date: Thu, 22 Feb 2024 18:39:09 +0300
Message-Id: <20240222153912.646053-2-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222153912.646053-1-davydov-max@yandex-team.ru>
References: <20240222153912.646053-1-davydov-max@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

qmp_qom_list_properties can print default values if they are available
as qmp_device_list_properties does, because both of them use the
ObjectPropertyInfo structure with default_value field. This can be useful
when working with "not device" types (e.g. memory-backend).

Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qom/qom-qmp-cmds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 7c087299de..e91a235347 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -212,6 +212,7 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
         info->name = g_strdup(prop->name);
         info->type = g_strdup(prop->type);
         info->description = g_strdup(prop->description);
+        info->default_value = qobject_ref(prop->defval);
 
         QAPI_LIST_PREPEND(prop_list, info);
     }
-- 
2.34.1


