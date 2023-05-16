Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F403F7052F6
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 17:59:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyx3o-0001gL-5Y; Tue, 16 May 2023 11:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <3887702e5f8995638c98f9d9326b4913fb107be7@lizzy.crudebyte.com>)
 id 1pyx3l-0001fd-Hz
 for qemu-devel@nongnu.org; Tue, 16 May 2023 11:57:57 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <3887702e5f8995638c98f9d9326b4913fb107be7@lizzy.crudebyte.com>)
 id 1pyx3j-0004Wa-Mx
 for qemu-devel@nongnu.org; Tue, 16 May 2023 11:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=HwoUHAOMcBRr0HwXNBkEMeaarhSfXj86KJOvYkVWFnU=; b=NQne6
 XDAYLSfweWSEpFDWKc+eKfs2qBsY5yp9itnpw9VAGi5s44F66RsZepu3GEopnsR+vGcpPWPsLeFVr
 Khw2v+NEsjzH31XiPW0DmKORe1DpJ2YfSKrA2vmfzF9S12f2YSOCU4ju1oltb1luQxfBQDOkC+Rk7
 zhPkHAqrl7NqXPzhuKPRl8hDzZTIBPyIiqD/YmhGa84Pn0yF+/U/fg3YR5hZSRqUksdrAa41PHiKb
 WLEsQr8i37o9ObLAgN0IBnblai0WmHtF7r1SQLUQH2OXoQFCHCpPRmqBpa+50al+iMufsiNB8I/hq
 W6rBFxPGrQzZUmGsPk9iiLp7ZMlXw==;
Message-Id: <3887702e5f8995638c98f9d9326b4913fb107be7.1684250463.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1684250463.git.qemu_oss@crudebyte.com>
References: <cover.1684250463.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 16 May 2023 17:21:04 +0200
Subject: [PULL 4/4] configure: make clear that VirtFS is 9p
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>,
    Thomas Huth <thuth@redhat.com>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=3887702e5f8995638c98f9d9326b4913fb107be7@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add '9P' to the summary output section of 'VirtFS' to avoid being
confused with virtiofs.

Based-on: <20230503130757.863824-1-pefoley@google.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <E1px7Id-0000NE-OQ@lizzy.crudebyte.com>
---
 meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index c6b05149e9..5e2807ea7c 100644
--- a/meson.build
+++ b/meson.build
@@ -3930,8 +3930,8 @@ if have_block
   summary_info += {'Block whitelist (rw)': get_option('block_drv_rw_whitelist')}
   summary_info += {'Block whitelist (ro)': get_option('block_drv_ro_whitelist')}
   summary_info += {'Use block whitelist in tools': get_option('block_drv_whitelist_in_tools')}
-  summary_info += {'VirtFS support':    have_virtfs}
-  summary_info += {'VirtFS Proxy Helper support': have_virtfs_proxy_helper}
+  summary_info += {'VirtFS (9P) support':    have_virtfs}
+  summary_info += {'VirtFS (9P) Proxy Helper support': have_virtfs_proxy_helper}
   summary_info += {'Live block migration': config_host_data.get('CONFIG_LIVE_BLOCK_MIGRATION')}
   summary_info += {'replication support': config_host_data.get('CONFIG_REPLICATION')}
   summary_info += {'bochs support':     get_option('bochs').allowed()}
-- 
2.30.2


