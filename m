Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB977CFDA9
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 17:19:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtUo3-0007Xx-1Z; Thu, 19 Oct 2023 11:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtUnx-0007Vp-Ge
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:19:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtUnv-00016y-Lg
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697728759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QGJkC0zSR33abZ28uTtvbvt15CwM3C4VDDrMnC2AZRc=;
 b=PlbGlKx77S46Ca3juUejiL8dg/bQwLvOwPCCPZDvuK2V/HZ8Bl/FF9iAgGdemrJMkRz2U2
 BT9/Z5DvyuMZ4A0QoYuwo1rc1HoIqiEDgKZcW6Ign46H7KYz21XeT5QQ9Oyk5BbNkjb1Y1
 H2HUpeFHFPQQLAQTGXM3SlbXBEIFFEg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-H9LQeW0HOL6LY4cTH38IUw-1; Thu, 19 Oct 2023 11:19:11 -0400
X-MC-Unique: H9LQeW0HOL6LY4cTH38IUw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66011f0d521so14318696d6.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 08:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697728750; x=1698333550;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGJkC0zSR33abZ28uTtvbvt15CwM3C4VDDrMnC2AZRc=;
 b=nB6egjgjbHVaHsWVj2aAe6dtTcsG7gXMrPx51iSBkL0S2fiqR2nZkmE42jjJwniG86
 7wodYDdlC3LCC48F8vFJfTUszYJHYzNVMByYcTHG+1mXtOqEz31LI1SAyx5d1GXX3FO2
 TtkfMyG6iSMOZjGp9C830MPTC11rtWa86mvno+xBmH0SKWPiViEOKzrfkvr/lnaul+iL
 Z8zBeGepvJzT7ihJkqfTrFi6HyxXT9bq70DsHZ9TJFJB7Vzfn/jyLOZfhttOJ+AMaewE
 tnWafbddsKX+m45HRZENoifqCSXZbpjLxjZH5d6R+2hodCg2RY6ng19qwaYIVzjSJwSo
 B1pA==
X-Gm-Message-State: AOJu0YzTA9ckleRa6GXHPJ7/oeADKoazAounjeB/DS9sl3WPnraVsB12
 oqQ83o3kGwikDCmNb4EJoUdFDa83GjSXHe4Vu/j3VcY79ZUYkXQeFlogNERrsOO5ntAM0Rh+5tI
 h+Utcd2yqp6koGL0=
X-Received: by 2002:a05:622a:6a4a:b0:41c:c83d:a94d with SMTP id
 ig10-20020a05622a6a4a00b0041cc83da94dmr1646765qtb.5.1697728749883; 
 Thu, 19 Oct 2023 08:19:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcpJiPhU3LfU4fQgx2emuQLdw40kRvLcpevkS/m8ZEeKmdWLHK/0xeTTSsQ7tQB0K6K7tfJQ==
X-Received: by 2002:a05:622a:6a4a:b0:41c:c83d:a94d with SMTP id
 ig10-20020a05622a6a4a00b0041cc83da94dmr1646739qtb.5.1697728749445; 
 Thu, 19 Oct 2023 08:19:09 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 l30-20020ac84cde000000b0041818df8a0dsm804146qtv.36.2023.10.19.08.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:19:09 -0700 (PDT)
Date: Thu, 19 Oct 2023 11:19:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: quintela@redhat.com, qemu-devel@nongnu.org,
 Leonardo Bras <leobras@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 2/6] migration/multifd: Stop checking p->quit in
 multifd_send_thread
Message-ID: <ZTFI7A49U+3JsMe+@x1n>
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-3-farosas@suse.de>
 <87o7gv6kt6.fsf@secure.mitica> <87o7guy7zu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o7guy7zu.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Oct 19, 2023 at 11:58:13AM -0300, Fabiano Rosas wrote:
> Juan Quintela <quintela@redhat.com> writes:
> 
> > Fabiano Rosas <farosas@suse.de> wrote:
> >> We don't need to check p->quit in the multifd_send_thread() because it
> >> is shadowed by the 'exiting' flag. Ever since that flag was added
> >> p->quit became obsolete as a way to stop the thread.
> >>
> >> Since p->quit is set at multifd_send_terminate_threads() under the
> >> p->mutex lock, the thread will only see it once it loops, so 'exiting'
> >> will always be seen first.
> >>
> >> Note that setting p->quit at multifd_send_terminate_threads() still
> >> makes sense because we need a way to inform multifd_send_pages() that
> >> the channel has stopped.
> >>
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >
> > Reviewed-by: Juan Quintela <quintela@redhat.com>
> >
> > But then should we remove the quit altogether?
> >
> 
> It still serves a purpose to allow multifd_send_pages() to see that the
> channel has exited. While that function does also check
> multifd_send_state->exiting, it could already be waiting at the mutex
> when the channel aborts. So we need to either check 'exiting' again or
> keep p->quit.

Sounds better to just move multifd_send_state->exiting check into the loop,
then drop the per-channel ->quit?

diff --git a/migration/multifd.c b/migration/multifd.c
index 1fe53d3b98..381a9a14e4 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -399,10 +399,6 @@ static int multifd_send_pages(QEMUFile *f)
     MultiFDSendParams *p = NULL; /* make happy gcc */
     MultiFDPages_t *pages = multifd_send_state->pages;
 
-    if (qatomic_read(&multifd_send_state->exiting)) {
-        return -1;
-    }
-
     qemu_sem_wait(&multifd_send_state->channels_ready);
     /*
      * next_channel can remain from a previous migration that was
@@ -413,12 +409,11 @@ static int multifd_send_pages(QEMUFile *f)
     for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
         p = &multifd_send_state->params[i];
 
-        qemu_mutex_lock(&p->mutex);
-        if (p->quit) {
-            error_report("%s: channel %d has already quit!", __func__, i);
-            qemu_mutex_unlock(&p->mutex);
+        if (qatomic_read(&multifd_send_state->exiting)) {
             return -1;
         }
+
+        qemu_mutex_lock(&p->mutex);
         if (!p->pending_job) {
             p->pending_job++;
             next_channel = (i + 1) % migrate_multifd_channels();

Thanks,

-- 
Peter Xu


