Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5BC73F870
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:12:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE4js-0001ym-4Z; Tue, 27 Jun 2023 05:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qE4jl-0001yG-4f
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qE4jj-0003AG-LV
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687857106;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BFIbwOz+gFYHiL5orI+EOSiQ6kQZFhbwdajuQi+7LYk=;
 b=RMpJ4NeeVXWrQdlYDUzVAQUIy0nQFMSmmVv4Yjv4JcOjRVAN0UeClrmzq75+iPNxFlYhG9
 RPOKiIuLDZOs8BnTJToLzrAnzpGJ+SFV/DcGp1nH712MTB7xBo55OlNZiDutRwfaDCjG20
 aqKVZhvjvhX9JQ1Bcmmfjd6mprq1ZNQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-zjfh6jrIM9ixoW2UA_-hGg-1; Tue, 27 Jun 2023 05:11:44 -0400
X-MC-Unique: zjfh6jrIM9ixoW2UA_-hGg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-313fe11f5e2so324535f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 02:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687857102; x=1690449102;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BFIbwOz+gFYHiL5orI+EOSiQ6kQZFhbwdajuQi+7LYk=;
 b=SGM924SIajbPGKupdiOzl7b958LGHwGblhegMFx5ih3PmlG8Tp9yk+ZBVB06DsGGi/
 ePgP47CwhrDjywOWJrd6vdXcD4qEymAtwMYct4FCYmxBZ9DW6ccQjJR3MTLyjjHiKbPg
 tnE6TTbtLrZKDqPS36nMDBv0XL9l4/eEb4BjB0tg3695LniJuZgEcgPX5HCk2QNGeW5Y
 +Pp6Wn5WA6Lu/eeqcVYGdjuc+b/F6yuG8j3GEnfCksg6UJV+fE0QOX1qg4RdzaJ5FkZc
 c6elZYPqRdK0JkpQMkitXV8nf3+QJVLeArk4O5FplpTMrtuAVT7wt0K9F/5db6HtzxIc
 eZTA==
X-Gm-Message-State: AC+VfDycxCf+6N4jlU3qFClZR2jZTCazc/CQmlBPPYJoIPPQWP5qQSoB
 Wqyq3qfi0Lq/rj3Kg5Ei1Jk7r8ogkUKgsIHTOUr3EaOSA0DPbPnUFe6ju9QlqQx7rCsQGv8K/ik
 x+ryynwX3B+aOW24=
X-Received: by 2002:a5d:6106:0:b0:313:ef24:6feb with SMTP id
 v6-20020a5d6106000000b00313ef246febmr5524174wrt.3.1687857102446; 
 Tue, 27 Jun 2023 02:11:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7SLO6Rs20Q/f2wQVdzdNhvTNDMLi+cU1KVnYHTXibz1JT4atKTv+adubtggCV3w4zuPx83uQ==
X-Received: by 2002:a5d:6106:0:b0:313:ef24:6feb with SMTP id
 v6-20020a5d6106000000b00313ef246febmr5524161wrt.3.1687857102092; 
 Tue, 27 Jun 2023 02:11:42 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 e10-20020a056000194a00b0031134bcdacdsm9807471wry.42.2023.06.27.02.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 02:11:41 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Steve Sistare
 <steven.sistare@oracle.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 1/6] migration: Set migration status early in incoming side
In-Reply-To: <20230626182210.8792-2-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 26 Jun 2023 15:22:05 -0300")
References: <20230626182210.8792-1-farosas@suse.de>
 <20230626182210.8792-2-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 27 Jun 2023 11:11:40 +0200
Message-ID: <877crpclrn.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> We are sending a migration event of MIGRATION_STATUS_SETUP at
> qemu_start_incoming_migration but never actually setting the state.
>
> This creates a window between qmp_migrate_incoming and
> process_incoming_migration_co where the migration status is still
> MIGRATION_STATUS_NONE. Calling query-migrate during this time will
> return an empty response even though the incoming migration command
> has already been issued.
>
> Commit 7cf1fe6d68 ("migration: Add migration events on target side")
> has added support to the 'events' capability to the incoming part of
> migration, but chose to send the SETUP event without setting the
> state. I'm assuming this was a mistake.
>
> To avoid introducing a change in behavior, we need to keep sending the
> SETUP event, even if the 'events' capability is not set.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 7c8292d4d4..562b78261d 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -424,13 +424,26 @@ void migrate_add_address(SocketAddress *address)
>  static void qemu_start_incoming_migration(const char *uri, Error **errp)
>  {
>      const char *p = NULL;
> +    MigrationIncomingState *mis = migration_incoming_get_current();
>  
>      /* URI is not suitable for migration? */
>      if (!migration_channels_and_uri_compatible(uri, errp)) {
>          return;
>      }
>  
> -    qapi_event_send_migration(MIGRATION_STATUS_SETUP);
> +    migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
> +                      MIGRATION_STATUS_SETUP);
> +    /*
> +     * QMP clients should have set the 'events' migration capability
> +     * if they want to receive this event, in which case the
> +     * migrate_set_state() call above will have already sent the
> +     * event. We still need to send the event for compatibility even
> +     * if migration events are disabled.
> +     */
> +    if (!migrate_events()) {
> +        qapi_event_send_migration(MIGRATION_STATUS_SETUP);
> +    }

Can we add and test for a property here, so we can drop this at some
point in the future?

> +
>      if (strstart(uri, "tcp:", &p) ||
>          strstart(uri, "unix:", NULL) ||
>          strstart(uri, "vsock:", NULL)) {
> @@ -524,7 +537,7 @@ process_incoming_migration_co(void *opaque)
>  
>      mis->largest_page_size = qemu_ram_pagesize_largest();
>      postcopy_state_set(POSTCOPY_INCOMING_NONE);
> -    migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
> +    migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
>                        MIGRATION_STATUS_ACTIVE);
>  
>      mis->loadvm_co = qemu_coroutine_self();


