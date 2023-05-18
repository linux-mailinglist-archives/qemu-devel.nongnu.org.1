Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A58708062
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 13:51:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzc99-0004TL-Cx; Thu, 18 May 2023 07:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzc97-0004TC-KU
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:50:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzc96-00050Q-27
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684410610;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ILQmDWaTq3SsdHJUCCexIgisMSE7TKwgIx2nO4eTXxg=;
 b=IApV8GoRhMyl9az1EVxYRI3L6f0cI0/3xJ1TOJ1pSFNpOhL0SfQfZQFnR39fQw8C9f/OQE
 PM/QMNB+u4lGEfPD7vzQKIrZXAomYirH0zLcPzM75aO6xc8YQzJXs5JABMII8pYq/dOwDe
 ltbiT0EAi+0e7zPU6DwezvRzJH6ror8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-hvOw6hpxM8O75xMunubHsw-1; Thu, 18 May 2023 07:50:07 -0400
X-MC-Unique: hvOw6hpxM8O75xMunubHsw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3063287f1c9so855181f8f.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684410606; x=1687002606;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ILQmDWaTq3SsdHJUCCexIgisMSE7TKwgIx2nO4eTXxg=;
 b=hFToLoHFR7uGasMj9GI3LFb3koef+eSmb3RtYHw+dVRrjTYImWnS1MBEqKrq6WjSS/
 kmxodJFjd6SyzFNLKsdLMr2GI7RfIW1N9dx29ezRoYNNj8KEOhZSyuHWLQr99S0i/Xlz
 VPzD4s9pPcfps55PpJdJ8dCRkb9Crj1MlW3htKpATaoGV/xrnSOoXpySUtChlH4zNbBt
 BRswMjM2lnH9Q0MrK3UgY2EbZ+K6Q1lJcpGXnvmwc+xc9PB9caSzlH1ozpya5rbFtkdc
 u0vGRXgVm/cRN54S6SATF5ZuAx73UK4UtXfPxUUqNf7FlM56JlWfGZpbCXM9HSUL6Kwe
 0eyg==
X-Gm-Message-State: AC+VfDynefIX+RYwIFbxO3H0Rvg0cUC77XEEqRb3qFR+MGlRpDrN9Yr6
 KtEDe0A2wqSh3szKkRlk+UdLIpUizxLmgxaEUUaWGRVP+0VEr42QUXM+olSaZ/WrBEQf2J9Xbh6
 r9ZUDOub4JXXIA1E=
X-Received: by 2002:adf:ec47:0:b0:306:2d3d:a108 with SMTP id
 w7-20020adfec47000000b003062d3da108mr1247757wrn.11.1684410606585; 
 Thu, 18 May 2023 04:50:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6dHuY7D7d62S1EgLMhl0swp0BVkKi701c+VGmR4v80z2eWozFTNZK8mhDHm3mrtm1BIbX14g==
X-Received: by 2002:adf:ec47:0:b0:306:2d3d:a108 with SMTP id
 w7-20020adfec47000000b003062d3da108mr1247746wrn.11.1684410606175; 
 Thu, 18 May 2023 04:50:06 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 e6-20020a056000120600b003012030a0c6sm1989525wrx.18.2023.05.18.04.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 04:50:04 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Tejus GK <tejus.gk@nutanix.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 berrange@redhat.com,  shivam.kumar1@nutanix.com
Subject: Re: [RFC v3 1/2] migration: Update error description whenever
 migration fails
In-Reply-To: <20230518062308.90631-2-tejus.gk@nutanix.com> (Tejus GK's message
 of "Thu, 18 May 2023 06:23:07 +0000")
References: <20230518062308.90631-1-tejus.gk@nutanix.com>
 <20230518062308.90631-2-tejus.gk@nutanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 13:50:04 +0200
Message-ID: <87o7mhdfkj.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Tejus GK <tejus.gk@nutanix.com> wrote:
> There are places in migration.c where the migration is marked failed with
> MIGRATION_STATUS_FAILED, but the failure reason is never updated. Hence
> libvirt doesn't know why the migration failed when it queries for it.
>
> Signed-off-by: Tejus GK <tejus.gk@nutanix.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


> ---
>  migration/migration.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 00d8ba8da0..864150d01d 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1683,15 +1683,11 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>      } else if (strstart(uri, "fd:", &p)) {
>          fd_start_outgoing_migration(s, p, &local_err);
>      } else {
> -        if (!(has_resume && resume)) {
> -            yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> -        }
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "uri",
> +        error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
>                     "a valid migration protocol");
>          migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>                            MIGRATION_STATUS_FAILED);
>          block_cleanup_parameters();
> -        return;

If you have to respin, please split the removal of the yan_unregister()
and return in one patch, and let of this patch the error bits.

>      }
>  
>      if (local_err) {
> @@ -2073,7 +2069,7 @@ migration_wait_main_channel(MigrationState *ms)
>   * Switch from normal iteration to postcopy
>   * Returns non-0 on error
>   */
> -static int postcopy_start(MigrationState *ms)
> +static int postcopy_start(MigrationState *ms, Error **errp)
>  {
>      int ret;
>      QIOChannelBuffer *bioc;
> @@ -2183,7 +2179,7 @@ static int postcopy_start(MigrationState *ms)
>       */
>      ret = qemu_file_get_error(ms->to_dst_file);
>      if (ret) {
> -        error_report("postcopy_start: Migration stream errored (pre package)");
> +        error_setg(errp, "postcopy_start: Migration stream errored (pre package)");
>          goto fail_closefb;
>      }
>  
> @@ -2220,7 +2216,7 @@ static int postcopy_start(MigrationState *ms)
>  
>      ret = qemu_file_get_error(ms->to_dst_file);
>      if (ret) {
> -        error_report("postcopy_start: Migration stream errored");
> +        error_setg(errp, "postcopy_start: Migration stream errored");
>          migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
>                                MIGRATION_STATUS_FAILED);
>      }
> @@ -2741,6 +2737,7 @@ typedef enum {
>  static MigIterateState migration_iteration_run(MigrationState *s)
>  {
>      uint64_t must_precopy, can_postcopy;
> +    Error *local_err = NULL;
>      bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
>  
>      qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
> @@ -2763,8 +2760,9 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>      /* Still a significant amount to transfer */
>      if (!in_postcopy && must_precopy <= s->threshold_size &&
>          qatomic_read(&s->start_postcopy)) {
> -        if (postcopy_start(s)) {
> -            error_report("%s: postcopy failed to start", __func__);
> +        if (postcopy_start(s, &local_err)) {
> +            migrate_set_error(s, local_err);
> +            error_report_err(local_err);

Not your fault.
But the interface of migrate_set_error() is a mess.  It is followed
sometimes from error_report_err() another from error_free() and another
by ...


