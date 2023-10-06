Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A942B7BB6D9
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:44:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj9K-000597-2C; Fri, 06 Oct 2023 07:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8u-00050t-98
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8p-00006y-T7
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7vgbyhnUXIGB+1tDeH0onAn2odq5gPJwvCH/ib+n0Jw=;
 b=KSJwtC4VaG1wc0mrUwmF6eEYqURRlqf5Z/Y/1gM8XNr2HWuFrakX0aqHm0Sf3/SXoJUeb4
 pGroXnrD4WseQBqMH3Byb+6xYs2phMbaMNVGkOVFuy9wSQFFXZRvsjzTolNOGQvpdJfwBM
 AZpCtI3RhmDzB/josSP03QJIA1XFmVU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-6D27LPJcMWm7iaSWMWWkAA-1; Fri, 06 Oct 2023 07:37:01 -0400
X-MC-Unique: 6D27LPJcMWm7iaSWMWWkAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1A7D3C100AC;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA71040C6EA8;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AE5CE21E6894; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Laurent Vivier <laurent@vivier.eu>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 31/32] linux-user/syscall.c: clean up local variable shadowing
 in TARGET_NR_getcpu
Date: Fri,  6 Oct 2023 13:36:56 +0200
Message-ID: <20231006113657.3803180-32-armbru@redhat.com>
In-Reply-To: <20231006113657.3803180-1-armbru@redhat.com>
References: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

From: Laurent Vivier <laurent@vivier.eu>

Fix following warnings:

.../linux-user/syscall.c: In function 'do_syscall1':
.../linux-user/syscall.c:11180:22: warning: declaration of 'cpu' shadows a previous local [-Wshadow=local]
11180 |             unsigned cpu, node;
      |                      ^~~
.../linux-user/syscall.c:8963:15: note: shadowed declaration is here
 8963 |     CPUState *cpu = env_cpu(cpu_env);
      |               ^~~

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20230925151029.461358-5-laurent@vivier.eu>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 linux-user/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0f1ecc1e0b..97a5e9ddf2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11177,14 +11177,14 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         }
     case TARGET_NR_getcpu:
         {
-            unsigned cpu, node;
-            ret = get_errno(sys_getcpu(arg1 ? &cpu : NULL,
+            unsigned cpuid, node;
+            ret = get_errno(sys_getcpu(arg1 ? &cpuid : NULL,
                                        arg2 ? &node : NULL,
                                        NULL));
             if (is_error(ret)) {
                 return ret;
             }
-            if (arg1 && put_user_u32(cpu, arg1)) {
+            if (arg1 && put_user_u32(cpuid, arg1)) {
                 return -TARGET_EFAULT;
             }
             if (arg2 && put_user_u32(node, arg2)) {
-- 
2.41.0


