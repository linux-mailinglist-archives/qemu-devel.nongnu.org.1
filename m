Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C23082D4A9
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 08:38:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPHXq-0001ep-8B; Mon, 15 Jan 2024 02:38:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPHXm-0001eI-Cs
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 02:38:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPHXj-0001rO-S5
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 02:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705304279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hqciTJ2WbH8toeiKsdYUlr/rGMQ8JOqZJTar50sLVq8=;
 b=HgjG5ie4hL1p02u1IAkyKfYEYstnibnDlRoX7vIpMEvKpUVk9EnrNBxHiXotEhibI7Ry8P
 1K4ZrjtsDCkCeS6exzAHlcjw9HmbClO88P8GIcNWIuWJ2DaRsJ3o2n/91xFwLHE1wHbAfw
 nFLQ47hCXrozjXwTtcUnv8QZggVQgb8=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-dlylwOd1NLOUWq1XVbRtaA-1; Mon, 15 Jan 2024 02:37:57 -0500
X-MC-Unique: dlylwOd1NLOUWq1XVbRtaA-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3bd54b3593aso920217b6e.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 23:37:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705304277; x=1705909077;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hqciTJ2WbH8toeiKsdYUlr/rGMQ8JOqZJTar50sLVq8=;
 b=TU0pc0VdS7sANd+UppjJFs0/M4v+Vo5kaoeYlwvbyR2YoBf8u4q5Pzh2fv9MyjorWk
 BrPhy6TUBecFvGwVKxfC9Idzq2ffkD4CHAm4BCt9tnDy5Z81HqD6N2QsM1/XRTzG2qPg
 NETG9jaC5ucS1OaseF6sgBra12KB9y1SZ25fvQc7zGmzmJk/C54deP+IcYtf0HQsUwk6
 8a+oQVv7RjC1VdmWLl3lu7zJQcMV8zFpoG0IEz7YJ19UfJuCLt+klEVEWUN7tRW2VEPE
 ajBkPUi3N7GuGxckqsbe8Lr41EDMJG/bSkT8cgaA7c/k7aZXAHD8OgsFUBTXugYZ5Ojh
 aang==
X-Gm-Message-State: AOJu0YwpdxrIRAmcCjoGwDZ4nEhDRFNhBKYWAQfonlAlgHDNcldS63tw
 Ap2kng58bD3h/d46jWQvOi7AEGGztqTSBTU3siVwE2/1vB+AnTmNd4MbSy7CXBfAX0BzzJjk1WG
 de8lp5TWHebeWVnzrF7PJamE=
X-Received: by 2002:a05:6808:2129:b0:3bd:54a3:1e51 with SMTP id
 r41-20020a056808212900b003bd54a31e51mr10427855oiw.4.1705304276816; 
 Sun, 14 Jan 2024 23:37:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvU7AZdxL+yD3ysC8BHcJ48cqN5ri/HRYaXyf9w9ry0555sCYLSxE45oYmeXyk3a4XVkDCVg==
X-Received: by 2002:a05:6808:2129:b0:3bd:54a3:1e51 with SMTP id
 r41-20020a056808212900b003bd54a31e51mr10427834oiw.4.1705304276471; 
 Sun, 14 Jan 2024 23:37:56 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 ka23-20020a056a00939700b006db0c82959asm7037267pfb.43.2024.01.14.23.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 23:37:56 -0800 (PST)
Date: Mon, 15 Jan 2024 15:37:45 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V2 08/11] migration: refactor migrate_fd_connect failures
Message-ID: <ZaTgyfYvyH-BW4Ev@x1n>
References: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
 <1705071910-174321-9-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1705071910-174321-9-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Jan 12, 2024 at 07:05:07AM -0800, Steve Sistare wrote:
> Move common code for the error path in migrate_fd_connect to a shared
> fail label.  No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

One nitpick below:

> ---
>  migration/migration.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index e9914aa..c828ba7 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3549,6 +3549,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>      Error *local_err = NULL;
>      uint64_t rate_limit;
>      bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
> +    int expect_state = s->state;

IMHO we can drop this.

>  
>      /*
>       * If there's a previous error, free it and prepare for another one.
> @@ -3603,11 +3604,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>      if (migrate_postcopy_ram() || migrate_return_path()) {
>          if (open_return_path_on_source(s)) {
>              error_setg(&local_err, "Unable to open return-path for postcopy");
> -            migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> -            migrate_set_error(s, local_err);
> -            error_report_err(local_err);
> -            migrate_fd_cleanup(s);
> -            return;
> +            goto fail;
>          }
>      }
>  
> @@ -3629,12 +3626,8 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>      }
>  
>      if (multifd_save_setup(&local_err) != 0) {
> -        migrate_set_error(s, local_err);
> -        error_report_err(local_err);
> -        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> -                          MIGRATION_STATUS_FAILED);
> -        migrate_fd_cleanup(s);
> -        return;
> +        expect_state = MIGRATION_STATUS_SETUP;

Then drop this.

> +        goto fail;
>      }
>  
>      if (migrate_background_snapshot()) {
> @@ -3645,6 +3638,13 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>                  migration_thread, s, QEMU_THREAD_JOINABLE);
>      }
>      s->migration_thread_running = true;
> +    return;
> +
> +fail:
> +    migrate_set_error(s, local_err);
> +    migrate_set_state(&s->state, expect_state, MIGRATION_STATUS_FAILED);

Then constantly use s->state.

> +    error_report_err(local_err);
> +    migrate_fd_cleanup(s);
>  }
>  
>  static void migration_class_init(ObjectClass *klass, void *data)
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


