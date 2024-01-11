Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E01E82A5DD
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 03:18:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNkcz-0005H2-DJ; Wed, 10 Jan 2024 21:17:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNkco-0005Ga-Qh
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 21:16:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNkcf-0003rF-1Y
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 21:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704939403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a2Va6TJ1Gh8biPnQ2T2yBxWTD+Sbtr1jLFqNkwb1oCI=;
 b=Y6Il/f8HJ6sR6fS6sbsFiay3mpS/9DWD32gKrLrFoHp3uO+qArt2U7bKjdVrazbydm2Ayq
 hN1MjLvfpm9zbiYJq3Ad5JoytlRibKtzqHr+9PnQdXCW5s7t0eYQX7SDUcFe7ZG9XFpTq+
 gYMeWpWuGQbWlOWDHEg5FDCFLNgSprE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-qXRNjD6lO-C4YCJFbrBa_w-1; Wed, 10 Jan 2024 21:16:41 -0500
X-MC-Unique: qXRNjD6lO-C4YCJFbrBa_w-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-28bea0ff98cso994266a91.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 18:16:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704939400; x=1705544200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a2Va6TJ1Gh8biPnQ2T2yBxWTD+Sbtr1jLFqNkwb1oCI=;
 b=b88EpnpJJciME9pjaxG9HOvasNYbq2FsoeH4og5eJ+4VNf7fJ7tbLki6VndQmWCmQs
 SAfotTKrxLJR1RX4rYVXGINTIA2LzYCXJGYptQdR/AiYGblMOGrHbuMkuQzJ6afhW5nF
 aEtLXNvP4RmJ87e/90iIgTEX5dhufrEnL46DvDMN/6a8HYiKCaAxV2bvKQ/Ur3uAr6Ig
 t57ERT3u7g7BpcYlzpm/qDBzotlsDZ3d67cmnlhIK63M82LKDK1tfTQ7Nm2j6io45aWq
 lxTWDwJhvXSVkwYVInM2Q6mvWfrbXJNDHYJRlnBDw7Ej822fe6VeY+sMvrH2xftD0W0r
 UsGw==
X-Gm-Message-State: AOJu0YxnrsHQGP+Suq5KYFLd+7wgi6o1NslS+09xLDotxlKXUW4rUY5M
 M8DdHWQP5jL+hZLq1EAsBzdXgJ7StU5n1x03q4xOGouuVj0T7puQEBGzs2mA2V4AUvnmG/WCCuF
 vpuBwklUyy/m5RcZfgDDuHIk=
X-Received: by 2002:a17:90b:38cf:b0:28c:ee93:7575 with SMTP id
 nn15-20020a17090b38cf00b0028cee937575mr877538pjb.1.1704939400337; 
 Wed, 10 Jan 2024 18:16:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH71LmopU6qEkYIksfEcwOnthCrbhTzNzxktpdEHrJi9+LMkzoqwXVPjkPfYivT3PAq/gg0LQ==
X-Received: by 2002:a17:90b:38cf:b0:28c:ee93:7575 with SMTP id
 nn15-20020a17090b38cf00b0028cee937575mr877519pjb.1.1704939399945; 
 Wed, 10 Jan 2024 18:16:39 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 sg9-20020a17090b520900b0028d9fc97c29sm55261pjb.14.2024.01.10.18.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 18:16:39 -0800 (PST)
Date: Thu, 11 Jan 2024 10:16:35 +0800
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH V1 2/3] migration: notifier error reporting
Message-ID: <ZZ9PgyDQ8QRG4Rqw@x1n>
References: <1702491093-383782-1-git-send-email-steven.sistare@oracle.com>
 <1702491093-383782-3-git-send-email-steven.sistare@oracle.com>
 <ZZ5E2ubl9XRdXDmh@x1n>
 <94e1241e-e355-4e96-b86a-e0218a7589c6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94e1241e-e355-4e96-b86a-e0218a7589c6@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
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

On Wed, Jan 10, 2024 at 01:08:41PM -0500, Steven Sistare wrote:
> On 1/10/2024 2:18 AM, Peter Xu wrote:
> > On Wed, Dec 13, 2023 at 10:11:32AM -0800, Steve Sistare wrote:
> >> After calling notifiers, check if an error has been reported via
> >> migrate_set_error, and halt the migration.
> >>
> >> None of the notifiers call migrate_set_error at this time, so no
> >> functional change.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> ---
> >>  include/migration/misc.h |  2 +-
> >>  migration/migration.c    | 26 ++++++++++++++++++++++----
> >>  2 files changed, 23 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/include/migration/misc.h b/include/migration/misc.h
> >> index 901d117..231d7e4 100644
> >> --- a/include/migration/misc.h
> >> +++ b/include/migration/misc.h
> >> @@ -65,7 +65,7 @@ MigMode migrate_mode_of(MigrationState *);
> >>  void migration_add_notifier(Notifier *notify,
> >>                              void (*func)(Notifier *notifier, void *data));
> >>  void migration_remove_notifier(Notifier *notify);
> >> -void migration_call_notifiers(MigrationState *s);
> >> +int migration_call_notifiers(MigrationState *s);
> >>  bool migration_in_setup(MigrationState *);
> >>  bool migration_has_finished(MigrationState *);
> >>  bool migration_has_failed(MigrationState *);
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index d5bfe70..29a9a92 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -1280,6 +1280,8 @@ void migrate_set_state(int *state, int old_state, int new_state)
> >>  
> >>  static void migrate_fd_cleanup(MigrationState *s)
> >>  {
> >> +    bool already_failed;
> >> +
> >>      qemu_bh_delete(s->cleanup_bh);
> >>      s->cleanup_bh = NULL;
> >>  
> >> @@ -1327,11 +1329,20 @@ static void migrate_fd_cleanup(MigrationState *s)
> >>                            MIGRATION_STATUS_CANCELLED);
> >>      }
> >>  
> >> +    already_failed = migration_has_failed(s);
> >> +    if (migration_call_notifiers(s)) {
> >> +        if (!already_failed) {
> >> +            migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> >> +            /* Notify again to recover from this late failure. */
> >> +            migration_call_notifiers(s);
> >> +        }
> >> +    }
> >> +
> >>      if (s->error) {
> >>          /* It is used on info migrate.  We can't free it */
> >>          error_report_err(error_copy(s->error));
> >>      }
> >> -    migration_call_notifiers(s);
> >> +
> >>      block_cleanup_parameters();
> >>      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> >>  }
> >> @@ -1450,9 +1461,10 @@ void migration_remove_notifier(Notifier *notify)
> >>      }
> >>  }
> >>  
> >> -void migration_call_notifiers(MigrationState *s)
> >> +int migration_call_notifiers(MigrationState *s)
> >>  {
> >>      notifier_list_notify(&migration_state_notifiers, s);
> >> +    return (s->error != NULL);
> > 
> > Exporting more migration_*() functions is pretty ugly to me..
> 
> I assume you mean migrate_set_error(), which is currently only called from
> migration/*.c code.
> 
> Instead, we could define a new function migrate_set_notifier_error(), defined
> in the new file migration/notifier.h, so we clearly limit the migration 
> functions which can be called from notifiers.  (Its implementation just calls
> migrate_set_error)

Fundementally this allows another .c to change one more field of
MigrationState (which is ->error) and I still want to avoid it.

I just replied in the other thread, but now with all these in mind I think
I still prefer not passing in MigrationState* at all.  It's already kind of
abused due to migrate_get_current(), and IMHO it's healthier to limit its
usage to minimum to cover the core of migration states for migration/ use
only.

Shrinking or even stop exporting migrate_get_current() is another more
challenging task, but now what we can do is stop enlarging the direct use
of MigrationState*.

> 
> > Would it be better to pass in "Error** errp" into each notifiers?  That may
> > need an open coded notifier_list_notify(), breaking the loop if "*errp".
> > 
> > And the notifier API currently only support one arg..  maybe we should
> > implement the notifiers ourselves, ideally passing in "(int state, Error
> > **errp)" instead of "(MigrationState *s)".
> > 
> > Ideally with that MigrationState* shouldn't be visible outside migration/.
> 
> I will regret saying this because of the amount of (mechanical) code change involved,
> but the cleanest solution is:

:)

>
> * Pass errp to: 
>   notifier_with_return_list_notify(NotifierWithReturnList *list, void *data, Error *errp)
> * Pass errp to the NotifierWithReturn notifier:
>   int (*notify)(NotifierWithReturn *notifier, void *data, Error **errp);
> * Delete the errp member from struct PostcopyNotifyData and pass errp to the notifier function
>   Ditto for PrecopyNotifyData.
> * Convert all migration notifiers to NotifierWithReturn

Would you mind changing MigrationState* into an event just like postcopy?
We don't need to use migration_has_failed() etc., afaict three events
should be enough for the existing four users, exactly like what postcopy
does:

  - MIG_EVENT_PRECOPY_SETUP
  - MIG_EVENT_PRECOPY_DONE
  - MIG_EVENT_PRECOPY_FAILED

Merging postcopy will be indeed the cleanest.  I'm okay if you want to
leave that for later, but if you'd do that together I'd appreciate that.

Thanks,

-- 
Peter Xu


