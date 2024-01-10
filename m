Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FDA82942D
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 08:19:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNSrk-0003c0-Er; Wed, 10 Jan 2024 02:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNSri-0003b8-Bu
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 02:19:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNSrg-00017o-E4
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 02:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704871143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ib69lHgX9BqBm4h0qNJxi+DoaaYUfrXUTb36l/1Nkp0=;
 b=Bsw4T9e8kX7Okr6+DAWc5PPPCr5y7MR1C5Wi7ROKPsqJlzCPwe1QNQcyC5KwApc84pq/0N
 YZwdGJ1e665yZ8T8RbLMKKBv/gVKnXRermgq1nsRI4YuAZ/X7Q/tcpgQDQ1ycY/xyX6Aek
 L9lvhi2G4hSLhYMT/Glwz4UUSOm/OZE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-FaaJUSV2MUO9rc0k2bNu7A-1; Wed, 10 Jan 2024 02:19:01 -0500
X-MC-Unique: FaaJUSV2MUO9rc0k2bNu7A-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6d99a379dacso487505b3a.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 23:19:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704871140; x=1705475940;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ib69lHgX9BqBm4h0qNJxi+DoaaYUfrXUTb36l/1Nkp0=;
 b=wK2RG+WFKhXyaOo+puBNfwqnyzBQFH3Vn+X+Et7rPu61uXDEF6x6P2IIylGw6122qN
 Sm3c1sV8/bET/cp4/tN5Verh1fr/V546XhNyl50DSCTJjeUysEDgdJZg9hLzft/OMZLQ
 +gSdeYFKCI9UgktxJaZPUfqSdFzyaeMcTvdq4lASVahzjj4ir7+HOxNFAzckqnJSEt7n
 Rvt4Z34CoYK6QP6rJE0BiiOuLkNbI3vPX2XVbBdDJhqVekBDkvtKewIVCF2BDOF0X/8g
 acEig+T8R7g+YIEbcQQOo21k1ETuo294YvUTx5uzV1lpDtWNzQs6W6ztqZt/Gnp2LJ/w
 RBGA==
X-Gm-Message-State: AOJu0Yyatu89rBRKQ1fDCg3ssVWdV6UgcJsykL8g6CHzfYY42pdI52B9
 5vWCv6weMKKwkNTB3RQCIQS/60F0z+NmqxV7DONsh3jP85k2PwRyFo+GVRjt+poIdqRchW+ZTqT
 o0KEsWdYkUlz/N7tCWKdv6pk=
X-Received: by 2002:a05:6a00:390a:b0:6d9:edd1:4ede with SMTP id
 fh10-20020a056a00390a00b006d9edd14edemr1455924pfb.2.1704871139995; 
 Tue, 09 Jan 2024 23:18:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4JubxShX9MXvWiLz9RFdM4qyRPIhBSst0OwwwuV/ShzaJ0QlLfO3FzZ2jsD3II3mqQ9cvVQ==
X-Received: by 2002:a05:6a00:390a:b0:6d9:edd1:4ede with SMTP id
 fh10-20020a056a00390a00b006d9edd14edemr1455911pfb.2.1704871139648; 
 Tue, 09 Jan 2024 23:18:59 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 l8-20020a056a00140800b006d9ce7d3258sm2786829pfu.204.2024.01.09.23.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 23:18:59 -0800 (PST)
Date: Wed, 10 Jan 2024 15:18:50 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH V1 2/3] migration: notifier error reporting
Message-ID: <ZZ5E2ubl9XRdXDmh@x1n>
References: <1702491093-383782-1-git-send-email-steven.sistare@oracle.com>
 <1702491093-383782-3-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1702491093-383782-3-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Dec 13, 2023 at 10:11:32AM -0800, Steve Sistare wrote:
> After calling notifiers, check if an error has been reported via
> migrate_set_error, and halt the migration.
> 
> None of the notifiers call migrate_set_error at this time, so no
> functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/migration/misc.h |  2 +-
>  migration/migration.c    | 26 ++++++++++++++++++++++----
>  2 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 901d117..231d7e4 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -65,7 +65,7 @@ MigMode migrate_mode_of(MigrationState *);
>  void migration_add_notifier(Notifier *notify,
>                              void (*func)(Notifier *notifier, void *data));
>  void migration_remove_notifier(Notifier *notify);
> -void migration_call_notifiers(MigrationState *s);
> +int migration_call_notifiers(MigrationState *s);
>  bool migration_in_setup(MigrationState *);
>  bool migration_has_finished(MigrationState *);
>  bool migration_has_failed(MigrationState *);
> diff --git a/migration/migration.c b/migration/migration.c
> index d5bfe70..29a9a92 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1280,6 +1280,8 @@ void migrate_set_state(int *state, int old_state, int new_state)
>  
>  static void migrate_fd_cleanup(MigrationState *s)
>  {
> +    bool already_failed;
> +
>      qemu_bh_delete(s->cleanup_bh);
>      s->cleanup_bh = NULL;
>  
> @@ -1327,11 +1329,20 @@ static void migrate_fd_cleanup(MigrationState *s)
>                            MIGRATION_STATUS_CANCELLED);
>      }
>  
> +    already_failed = migration_has_failed(s);
> +    if (migration_call_notifiers(s)) {
> +        if (!already_failed) {
> +            migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> +            /* Notify again to recover from this late failure. */
> +            migration_call_notifiers(s);
> +        }
> +    }
> +
>      if (s->error) {
>          /* It is used on info migrate.  We can't free it */
>          error_report_err(error_copy(s->error));
>      }
> -    migration_call_notifiers(s);
> +
>      block_cleanup_parameters();
>      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>  }
> @@ -1450,9 +1461,10 @@ void migration_remove_notifier(Notifier *notify)
>      }
>  }
>  
> -void migration_call_notifiers(MigrationState *s)
> +int migration_call_notifiers(MigrationState *s)
>  {
>      notifier_list_notify(&migration_state_notifiers, s);
> +    return (s->error != NULL);

Exporting more migration_*() functions is pretty ugly to me..

Would it be better to pass in "Error** errp" into each notifiers?  That may
need an open coded notifier_list_notify(), breaking the loop if "*errp".

And the notifier API currently only support one arg..  maybe we should
implement the notifiers ourselves, ideally passing in "(int state, Error
**errp)" instead of "(MigrationState *s)".

Ideally with that MigrationState* shouldn't be visible outside migration/.

Thanks,

>  }
>  
>  bool migration_in_setup(MigrationState *s)
> @@ -2520,7 +2532,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>       * spice needs to trigger a transition now
>       */
>      ms->postcopy_after_devices = true;
> -    migration_call_notifiers(ms);
> +    if (migration_call_notifiers(ms)) {
> +        goto fail;
> +    }
>  
>      migration_downtime_end(ms);
>  
> @@ -3589,7 +3603,11 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>          rate_limit = migrate_max_bandwidth();
>  
>          /* Notify before starting migration thread */
> -        migration_call_notifiers(s);
> +        if (migration_call_notifiers(s)) {
> +            migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> +            migrate_fd_cleanup(s);
> +            return;
> +        }
>      }
>  
>      migration_rate_set(rate_limit);
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


