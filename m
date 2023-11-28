Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5357FB3F4
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 09:22:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7tLZ-0002pb-Ls; Tue, 28 Nov 2023 03:21:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r7tLT-0002pH-FV
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 03:21:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r7tLR-0006Sj-TB
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 03:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701159685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n9WKzX5AYJoHCUT9HRWsn9jNZh8ojqD7w9pNsHNOxmg=;
 b=Dpa5fo7Hlg/FZfQVs+lhfCokq50h36YMsqQBqIcbe864HFtPYvwmoru0owCCdSAaoLHc9u
 fJLMM6uZSUDYvExpTe1FFZyu34WQZN1gQwVSZ5G7luw6sXJljcbLdWgbBBYN3ITDwho46s
 VTJ8cON4oniB5XK+EI/2x2JZF8kOq1Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-26iZ5Cu3O8Ke0Dwy_TsiZA-1; Tue, 28 Nov 2023 03:21:20 -0500
X-MC-Unique: 26iZ5Cu3O8Ke0Dwy_TsiZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F90D88D046;
 Tue, 28 Nov 2023 08:21:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D1462502A;
 Tue, 28 Nov 2023 08:21:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8F89821E6A1F; Tue, 28 Nov 2023 09:21:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Shiyuan Gao via <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>,  Juan Quintela
 <quintela@redhat.com>,  Konstantin Kostiuk <kkostiuk@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>,  Shiyuan Gao <gaoshiyuan@baidu.com>
Subject: Re: [PATCH] util/qemu-config: Remove unnecessary traversal
References: <20231113141936.30567-1-gaoshiyuan@baidu.com>
Date: Tue, 28 Nov 2023 09:21:18 +0100
In-Reply-To: <20231113141936.30567-1-gaoshiyuan@baidu.com> (Shiyuan Gao via's
 message of "Mon, 13 Nov 2023 22:19:36 +0800")
Message-ID: <875y1m2sqp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Shiyuan Gao via <qemu-devel@nongnu.org> writes:

> From: Gao Shiyuan <gaoshiyuan@baidu.com>
>
> No remove QemuOptsList from *_config_groups, so no need to
> traverse from the beginning every time.
>
> No functional changes.
>
> Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> ---
>  include/qemu/config-file.h |  3 +++
>  util/qemu-config.c         | 18 ++++++++----------
>  2 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/include/qemu/config-file.h b/include/qemu/config-file.h
> index b82a778123..223ef7bc8f 100644
> --- a/include/qemu/config-file.h
> +++ b/include/qemu/config-file.h
> @@ -1,6 +1,9 @@
>  #ifndef QEMU_CONFIG_FILE_H
>  #define QEMU_CONFIG_FILE_H
>  
> +#define MAX_VM_CONFIG_GROUPS    48
> +#define MAX_DRIVE_CONFIG_GROUPS 5

These are not used outside qemu-config.c, so it's better to define them
there.

> +
>  typedef void QEMUConfigCB(const char *group, QDict *qdict, void *opaque, Error **errp);
>  
>  void qemu_load_module_for_opts(const char *group);
> diff --git a/util/qemu-config.c b/util/qemu-config.c
> index 42076efe1e..d7bab2047f 100644
> --- a/util/qemu-config.c
> +++ b/util/qemu-config.c
> @@ -9,8 +9,8 @@
>  #include "qemu/config-file.h"
>  #include "hw/boards.h"
>  
> -static QemuOptsList *vm_config_groups[48];
> -static QemuOptsList *drive_config_groups[5];
> +static QemuOptsList *vm_config_groups[MAX_VM_CONFIG_GROUPS];
> +static QemuOptsList *drive_config_groups[MAX_DRIVE_CONFIG_GROUPS];
>  
>  static QemuOptsList *find_list(QemuOptsList **lists, const char *group,
>                                 Error **errp)
> @@ -260,11 +260,10 @@ QemuOptsList *qemu_find_opts_err(const char *group, Error **errp)
>  
>  void qemu_add_drive_opts(QemuOptsList *list)
>  {
> -    int entries, i;
> +    static int i;
> +    static int entries = MAX_DRIVE_CONFIG_GROUPS - 1; /* keep list NULL terminated */
>  
> -    entries = ARRAY_SIZE(drive_config_groups);
> -    entries--; /* keep list NULL terminated */
> -    for (i = 0; i < entries; i++) {
> +    for (; i < entries; i++) {
>          if (drive_config_groups[i] == NULL) {
>              drive_config_groups[i] = list;
>              return;
> @@ -276,11 +275,10 @@ void qemu_add_drive_opts(QemuOptsList *list)
>  
>  void qemu_add_opts(QemuOptsList *list)
>  {
> -    int entries, i;
> +    static int i;
> +    static int entries = MAX_VM_CONFIG_GROUPS - 1; /* keep list NULL terminated */
>  
> -    entries = ARRAY_SIZE(vm_config_groups);
> -    entries--; /* keep list NULL terminated */
> -    for (i = 0; i < entries; i++) {
> +    for (; i < entries; i++) {
>          if (vm_config_groups[i] == NULL) {
>              vm_config_groups[i] = list;
>              return;

These two functions run at most 4 and 47 times, respectively.  I don't
think speeding them up matters.  Keeping them simple does.

Your patch conflates two separate changes.

1. Replace use of ARRAY_SIZE() by new macros.  Doesn't feel like an
improvement to me.

2. Optimize appending to arrays drive_config_groups[] and
vm_config_groups[].

Let's have a look at 2. without 1.:

diff --git a/util/qemu-config.c b/util/qemu-config.c
index 42076efe1e..7875359eb3 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -260,11 +260,13 @@ QemuOptsList *qemu_find_opts_err(const char *group, Error **errp)
 
 void qemu_add_drive_opts(QemuOptsList *list)
 {
-    int entries, i;
+    static int i;
+    int entries;
 
     entries = ARRAY_SIZE(drive_config_groups);
     entries--; /* keep list NULL terminated */
-    for (i = 0; i < entries; i++) {
+
+    for (; i < entries; i++) {
         if (drive_config_groups[i] == NULL) {
             drive_config_groups[i] = list;
             return;
@@ -276,11 +278,13 @@ void qemu_add_drive_opts(QemuOptsList *list)
 
 void qemu_add_opts(QemuOptsList *list)
 {
-    int entries, i;
+    static int i;
+    int entries;
 
     entries = ARRAY_SIZE(vm_config_groups);
     entries--; /* keep list NULL terminated */
-    for (i = 0; i < entries; i++) {
+
+    for (; i < entries; i++) {
         if (vm_config_groups[i] == NULL) {
             vm_config_groups[i] = list;
             return;

This is a more focused patch.

It makes the functions faster, which doesn't matter.  Does it make the
functions easier to understand?  That would matter.


