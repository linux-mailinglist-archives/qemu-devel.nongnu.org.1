Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E91937A3171
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 18:34:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhYE2-0003RZ-US; Sat, 16 Sep 2023 12:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1qhYE1-0003Qk-8U
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 12:32:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1qhYDz-0008MW-Mb
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 12:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694881970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xIHfhbG9vrWXCteyDogmUAAdtPlvGL+scSsfu6RPhII=;
 b=cGAmLNlEpAMzIGn2WlGED4Jb0JhuZDxzNlD3f3tjmYz3ePNlNyybrNgGP/7Ii5oXhCeQeB
 4K0kqGB87rOBbSqfmv2PKlbJrYzo6Sy+jVfaFzxJ47UWDxOTNdpCIATPw5itKiVpfOsF07
 rTcK5+AYHrGccVeLOaQYIqxqkOWl5aM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-Ch7xPuwEOPqseIIX3YoWyw-1; Sat, 16 Sep 2023 12:32:45 -0400
X-MC-Unique: Ch7xPuwEOPqseIIX3YoWyw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84D468039C8;
 Sat, 16 Sep 2023 16:32:45 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown
 [10.11.5.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6386C40C6EA8;
 Sat, 16 Sep 2023 16:32:45 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix,
 from userid 12668)
 id 44A6130C1C0A; Sat, 16 Sep 2023 16:32:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id
 412633FB77; Sat, 16 Sep 2023 18:32:45 +0200 (CEST)
Date: Sat, 16 Sep 2023 18:32:45 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Helge Deller <deller@gmx.de>
cc: Richard Henderson <richard.henderson@linaro.org>, 
 John David Anglin <dave.anglin@bell.net>, qemu-devel@nongnu.org, 
 linux-parisc@vger.kernel.org
Subject: [PATCH v2] qemu-hppa: lock both words of function descriptor
In-Reply-To: <953ee56d-173a-aaf2-c7fc-34386f285340@gmx.de>
Message-ID: <e09db414-c3ca-9725-1d28-42811767e60@redhat.com>
References: <87bd9251-5d6a-11f5-9a28-78224a776742@redhat.com>
 <953ee56d-173a-aaf2-c7fc-34386f285340@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mpatocka@redhat.com;
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



On Sat, 16 Sep 2023, Helge Deller wrote:

> On 9/16/23 15:52, Mikulas Patocka wrote:
> > The code in setup_rt_frame reads two words at haddr, but locks only one.
> > This patch fixes it to lock both.
> >
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> >
> > ---
> >   linux-user/hppa/signal.c |    5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > Index: qemu/linux-user/hppa/signal.c
> > ===================================================================
> > --- qemu.orig/linux-user/hppa/signal.c
> > +++ qemu/linux-user/hppa/signal.c
> > @@ -149,12 +149,11 @@ void setup_rt_frame(int sig, struct targ
> >           target_ulong *fdesc, dest;
> >
> >           haddr &= -4;
> > -        if (!lock_user_struct(VERIFY_READ, fdesc, haddr, 1)) {
> > +        if (!(fdesc = lock_user(VERIFY_READ, haddr, 2 *
> > sizeof(target_ulong), 1)))
> >               goto give_sigsegv;
> > -        }
> 
> Patch is Ok, but I think the qemu coding style is to keep the { } braces, even
> if they are unnecessary (as in this case).
> 
> Acked-by: Helge Deller <deller@gmx.de>

OK, here I resend it:


From: Mikulas Patocka <mpatocka@redhat.com>

The code in setup_rt_frame reads two words at haddr, but locks only one.
This patch fixes it to lock both.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Acked-by: Helge Deller <deller@gmx.de>

---
 linux-user/hppa/signal.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: qemu/linux-user/hppa/signal.c
===================================================================
--- qemu.orig/linux-user/hppa/signal.c
+++ qemu/linux-user/hppa/signal.c
@@ -149,12 +149,12 @@ void setup_rt_frame(int sig, struct targ
         target_ulong *fdesc, dest;
 
         haddr &= -4;
-        if (!lock_user_struct(VERIFY_READ, fdesc, haddr, 1)) {
+        if (!(fdesc = lock_user(VERIFY_READ, haddr, 2 * sizeof(target_ulong), 1))) {
             goto give_sigsegv;
         }
         __get_user(dest, fdesc);
         __get_user(env->gr[19], fdesc + 1);
-        unlock_user_struct(fdesc, haddr, 1);
+        unlock_user(fdesc, haddr, 0);
         haddr = dest;
     }
     env->iaoq_f = haddr;


