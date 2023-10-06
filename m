Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 056377BB6BE
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:42:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj9L-00059Q-4I; Fri, 06 Oct 2023 07:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8t-00050j-Iz
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8m-00007A-Fb
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fX6Z/GVlWWFVTgEr4OP0izgwtLk4sbJJBFiTtU8kar4=;
 b=FCv4/OxsMyZ/KlaOPbwLnwPAG57KT27w770rSXQ14N/eLLu8dMKhQYtwMZVFyf4fvu16du
 gs7koKucotV5o7Q5jqMz2KlIO2YLFNCAiwTPQTHsZbVi2omHuN0GPokUNVlFhJ+NlRcITi
 Oc7N2+vC0Xz9tj+av0hiAnUWbw+bg+M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-ql0YyHVqPT6QCByByGSPWA-1; Fri, 06 Oct 2023 07:37:01 -0400
X-MC-Unique: ql0YyHVqPT6QCByByGSPWA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18E8281D782;
 Fri,  6 Oct 2023 11:37:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C47024A9B0A;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ABA1221E6893; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Laurent Vivier <laurent@vivier.eu>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 30/32] linux-user/syscall.c: clean up local variable shadowing
 in do_ioctl_dm()
Date: Fri,  6 Oct 2023 13:36:55 +0200
Message-ID: <20231006113657.3803180-31-armbru@redhat.com>
In-Reply-To: <20231006113657.3803180-1-armbru@redhat.com>
References: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

From: Laurent Vivier <laurent@vivier.eu>

Fix following warnings:

.../linux-user/syscall.c: In function 'do_ioctl_dm':
.../linux-user/syscall.c:5053:23: warning: declaration of 'arg_type' shadows a previous local [-Wshadow=local]
 5053 |         const argtype arg_type[] = { MK_STRUCT(STRUCT_dm_target_spec) };
      |                       ^~~~~~~~
.../linux-user/syscall.c:4991:20: note: shadowed declaration is here
 4991 |     const argtype *arg_type = ie->arg_type;
      |                    ^~~~~~~~
...//linux-user/syscall.c:5102:27: warning: declaration of 'arg_type' shadows a previous local [-Wshadow=local]
 5102 |             const argtype arg_type[] = { MK_STRUCT(STRUCT_dm_name_list) };
      |                           ^~~~~~~~
.../linux-user/syscall.c:4991:20: note: shadowed declaration is here
 4991 |     const argtype *arg_type = ie->arg_type;
      |                    ^~~~~~~~
.../linux-user/syscall.c:5130:27: warning: declaration of 'arg_type' shadows a previous local [-Wshadow=local]
 5130 |             const argtype arg_type[] = { MK_STRUCT(STRUCT_dm_target_spec) };
      |                           ^~~~~~~~
.../linux-user/syscall.c:4991:20: note: shadowed declaration is here
 4991 |     const argtype *arg_type = ie->arg_type;
      |                    ^~~~~~~~
.../linux-user/syscall.c:5170:27: warning: declaration of 'arg_type' shadows a previous local [-Wshadow=local]
 5170 |             const argtype arg_type[] = { MK_STRUCT(STRUCT_dm_target_versions) };
      |                           ^~~~~~~~
.../linux-user/syscall.c:4991:20: note: shadowed declaration is here
 4991 |     const argtype *arg_type = ie->arg_type;
      |                    ^~~~~~~~

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20230925151029.461358-4-laurent@vivier.eu>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 linux-user/syscall.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c6ffadd082..0f1ecc1e0b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5050,8 +5050,8 @@ static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
     {
         void *gspec = argptr;
         void *cur_data = host_data;
-        const argtype arg_type[] = { MK_STRUCT(STRUCT_dm_target_spec) };
-        int spec_size = thunk_type_size(arg_type, 0);
+        const argtype dm_arg_type[] = { MK_STRUCT(STRUCT_dm_target_spec) };
+        int spec_size = thunk_type_size(dm_arg_type, 0);
         int i;
 
         for (i = 0; i < host_dm->target_count; i++) {
@@ -5059,7 +5059,7 @@ static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
             uint32_t next;
             int slen;
 
-            thunk_convert(spec, gspec, arg_type, THUNK_HOST);
+            thunk_convert(spec, gspec, dm_arg_type, THUNK_HOST);
             slen = strlen((char*)gspec + spec_size) + 1;
             next = spec->next;
             spec->next = sizeof(*spec) + slen;
@@ -5099,7 +5099,7 @@ static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
             struct dm_name_list *nl = (void*)host_dm + host_dm->data_start;
             uint32_t remaining_data = guest_data_size;
             void *cur_data = argptr;
-            const argtype arg_type[] = { MK_STRUCT(STRUCT_dm_name_list) };
+            const argtype dm_arg_type[] = { MK_STRUCT(STRUCT_dm_name_list) };
             int nl_size = 12; /* can't use thunk_size due to alignment */
 
             while (1) {
@@ -5111,7 +5111,7 @@ static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
                     host_dm->flags |= DM_BUFFER_FULL_FLAG;
                     break;
                 }
-                thunk_convert(cur_data, nl, arg_type, THUNK_TARGET);
+                thunk_convert(cur_data, nl, dm_arg_type, THUNK_TARGET);
                 strcpy(cur_data + nl_size, nl->name);
                 cur_data += nl->next;
                 remaining_data -= nl->next;
@@ -5127,8 +5127,8 @@ static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
         {
             struct dm_target_spec *spec = (void*)host_dm + host_dm->data_start;
             void *cur_data = argptr;
-            const argtype arg_type[] = { MK_STRUCT(STRUCT_dm_target_spec) };
-            int spec_size = thunk_type_size(arg_type, 0);
+            const argtype dm_arg_type[] = { MK_STRUCT(STRUCT_dm_target_spec) };
+            int spec_size = thunk_type_size(dm_arg_type, 0);
             int i;
 
             for (i = 0; i < host_dm->target_count; i++) {
@@ -5139,7 +5139,7 @@ static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
                     host_dm->flags |= DM_BUFFER_FULL_FLAG;
                     break;
                 }
-                thunk_convert(cur_data, spec, arg_type, THUNK_TARGET);
+                thunk_convert(cur_data, spec, dm_arg_type, THUNK_TARGET);
                 strcpy(cur_data + spec_size, (char*)&spec[1]);
                 cur_data = argptr + spec->next;
                 spec = (void*)host_dm + host_dm->data_start + next;
@@ -5167,8 +5167,8 @@ static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
             struct dm_target_versions *vers = (void*)host_dm + host_dm->data_start;
             uint32_t remaining_data = guest_data_size;
             void *cur_data = argptr;
-            const argtype arg_type[] = { MK_STRUCT(STRUCT_dm_target_versions) };
-            int vers_size = thunk_type_size(arg_type, 0);
+            const argtype dm_arg_type[] = { MK_STRUCT(STRUCT_dm_target_versions) };
+            int vers_size = thunk_type_size(dm_arg_type, 0);
 
             while (1) {
                 uint32_t next = vers->next;
@@ -5179,7 +5179,7 @@ static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
                     host_dm->flags |= DM_BUFFER_FULL_FLAG;
                     break;
                 }
-                thunk_convert(cur_data, vers, arg_type, THUNK_TARGET);
+                thunk_convert(cur_data, vers, dm_arg_type, THUNK_TARGET);
                 strcpy(cur_data + vers_size, vers->name);
                 cur_data += vers->next;
                 remaining_data -= vers->next;
-- 
2.41.0


