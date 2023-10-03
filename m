Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED007B7168
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 21:00:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkaC-0006jT-P6; Tue, 03 Oct 2023 14:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnka4-0006W1-3C
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnka2-0007F5-8v
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696359433;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1IBj+8Ef4wj4DpNxFdSIfh1N5a8Gm+LMR2EzZ8Qn87I=;
 b=F8HPQec/3UIaSy2ixz7zfH/iXitsBlVtq4bklcWXJoHO2Kagu9XN2GU/jt57QLCUSABXOT
 f3aqxXyNtmRCWieey4VpApa8t7mNleQCeYJ16U9N8BTnViDqx8qrMtT76B3goxnpjp2PC2
 boFI3iSn3QW1khZL/AXj2HUv97/I7xk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-hIDCq2lCPuCm27QCPPrLkA-1; Tue, 03 Oct 2023 14:57:12 -0400
X-MC-Unique: hIDCq2lCPuCm27QCPPrLkA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4030ae94fedso9546065e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 11:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696359429; x=1696964229;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1IBj+8Ef4wj4DpNxFdSIfh1N5a8Gm+LMR2EzZ8Qn87I=;
 b=bX/KjBRzYrGPk+ALOxxkcab+Nvhs8lwHCf8GXporfXdXmjw3sus+uBwHjzcNiKkmBu
 p1QcG8Md/xJS53mqeyJB64CljxLKOWCIUvU2hbQs+1k4eQaVafJqdgUrTa0EjRct6CeR
 Tcgeo29HwZeb92iWoqmmtOm38WomaWTGlc8dB3wVpuBFyfRIdSXqylzWwikKw2NX7iFT
 a/TarIuIzmJuoB+0J8YKNoW7sjBbP1f53a/F4yJaSompdd1hReYY996t2bPz9SDjRF0W
 xjZTHEqh99huibf8ypxpV53scJuWur7jXs5vykkvKlPYNkc7tFwqbVRc31HNt7tmzkgW
 ORHQ==
X-Gm-Message-State: AOJu0YwvswCETusmniD5Pu5UYVsdcKOsWRKWuGkTz3v54li/G2D4hg72
 Wa1BUuUqTFdtaNGFNBkXK1aTmldDG7LsoxjzvpDhWFXMow2N5xSiUFqYHr+rur3MXERZHc5p/IQ
 izNx80qEZeTtki0Ks6RbjsMzmYA==
X-Received: by 2002:a1c:7712:0:b0:401:c52c:5ed9 with SMTP id
 t18-20020a1c7712000000b00401c52c5ed9mr288773wmi.32.1696359429602; 
 Tue, 03 Oct 2023 11:57:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFxD40aeJmTZQGUGH2+SrbRZFymvT/KYGfKvAUh0Z3r/Kt2q7WNfDwm52DbDTng3PSFJ9FrQ==
X-Received: by 2002:a1c:7712:0:b0:401:c52c:5ed9 with SMTP id
 t18-20020a1c7712000000b00401c52c5ed9mr288759wmi.32.1696359429281; 
 Tue, 03 Oct 2023 11:57:09 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 11-20020a05600c020b00b003fe2b081661sm10036210wmi.30.2023.10.03.11.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 11:57:08 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: peterx@redhat.com,  leobras@redhat.com,  qemu-devel@nongnu.org,  Fabiano
 Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 1/2] migration: Fix rdma migration failed
In-Reply-To: <20230926100103.201564-1-lizhijian@fujitsu.com> (Li Zhijian's
 message of "Tue, 26 Sep 2023 18:01:02 +0800")
References: <20230926100103.201564-1-lizhijian@fujitsu.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 03 Oct 2023 20:57:07 +0200
Message-ID: <87edib5ybg.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Li Zhijian <lizhijian@fujitsu.com> wrote:
> Migration over RDMA failed since
> commit: 294e5a4034 ("multifd: Only flush once each full round of memory")
> with erors:
> qemu-system-x86_64: rdma: Too many requests in this message (3638950032).Bailing.
>
> migration with RDMA is different from tcp. RDMA has its own control
> message, and all traffic between RDMA_CONTROL_REGISTER_REQUEST and
> RDMA_CONTROL_REGISTER_FINISHED should not be disturbed.
>
> find_dirty_block() will be called during RDMA_CONTROL_REGISTER_REQUEST
> and RDMA_CONTROL_REGISTER_FINISHED, it will send a extra traffic(
> RAM_SAVE_FLAG_MULTIFD_FLUSH) to destination and cause migration to fail
> even though multifd is disabled.
>
> This change make migrate_multifd_flush_after_each_section() return true
> when multifd is disabled, that also means RAM_SAVE_FLAG_MULTIFD_FLUSH
> will not be sent to destination any more when multifd is disabled.
>
> Fixes: 294e5a4034 ("multifd: Only flush once each full round of memory")
> CC: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Ouch.

> index 1d1e1321b0..327bcf2fbe 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -368,7 +368,7 @@ bool migrate_multifd_flush_after_each_section(void)
>  {
>      MigrationState *s = migrate_get_current();
>  
> -    return s->multifd_flush_after_each_section;
> +    return !migrate_multifd() || s->multifd_flush_after_each_section;
>  }
>  
>  bool migrate_postcopy(void)

But I think this is ugly.

migrate_multifd_flush_after_each_section()

returnls true

with multifd not enabled?

And we are creating a "function" that just reads a property now does
something else.

What about this?

I know that the change is bigger, but it makes clear what is happening
here.

commit c638f66121ce30063fbf68c3eab4d7429cf2b209
Author: Juan Quintela <quintela@redhat.com>
Date:   Tue Oct 3 20:53:38 2023 +0200

    migration: Non multifd migration don't care about multifd flushes
    
    RDMA was having trouble because
    migrate_multifd_flush_after_each_section() can only be true or false,
    but we don't want to send any flush when we are not in multifd
    migration.
    
    CC: Fabiano Rosas <farosas@suse.de
    Reported-by: Li Zhijian <lizhijian@fujitsu.com>
    Signed-off-by: Juan Quintela <quintela@redhat.com>

diff --git a/migration/ram.c b/migration/ram.c
index e4bfd39f08..716cef6425 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1387,7 +1387,8 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
         pss->page = 0;
         pss->block = QLIST_NEXT_RCU(pss->block, next);
         if (!pss->block) {
-            if (!migrate_multifd_flush_after_each_section()) {
+            if (migrate_multifd() &&
+                !migrate_multifd_flush_after_each_section()) {
                 QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
                 int ret = multifd_send_sync_main(f);
                 if (ret < 0) {
@@ -3064,7 +3065,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
         return ret;
     }
 
-    if (!migrate_multifd_flush_after_each_section()) {
+    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
         qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
     }
 
@@ -3176,7 +3177,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 out:
     if (ret >= 0
         && migration_is_setup_or_active(migrate_get_current()->state)) {
-        if (migrate_multifd_flush_after_each_section()) {
+        if (migrate_multifd() && migrate_multifd_flush_after_each_section()) {
             ret = multifd_send_sync_main(rs->pss[RAM_CHANNEL_PRECOPY].pss_channel);
             if (ret < 0) {
                 return ret;
@@ -3253,7 +3254,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         return ret;
     }
 
-    if (!migrate_multifd_flush_after_each_section()) {
+    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
         qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
     }
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
@@ -3760,7 +3761,7 @@ int ram_load_postcopy(QEMUFile *f, int channel)
             break;
         case RAM_SAVE_FLAG_EOS:
             /* normal exit */
-            if (migrate_multifd_flush_after_each_section()) {
+            if (migrate_multifd() && migrate_multifd_flush_after_each_section()) {
                 multifd_recv_sync_main();
             }
             break;
@@ -4038,7 +4039,8 @@ static int ram_load_precopy(QEMUFile *f)
             break;
         case RAM_SAVE_FLAG_EOS:
             /* normal exit */
-            if (migrate_multifd_flush_after_each_section()) {
+            if (migrate_multifd() &&
+                migrate_multifd_flush_after_each_section()) {
                 multifd_recv_sync_main();
             }
             break;


