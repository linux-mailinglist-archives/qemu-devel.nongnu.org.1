Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A48DC7DCD94
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:16:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxoaL-0008LB-JC; Tue, 31 Oct 2023 09:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxoaG-0008Jr-UT
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:15:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxoaA-0000Al-Ku
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698758096;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=fwt+qAZnE3+4Ca3lcMRZuxYOMX4ohYc5pMOgwYcSV1o=;
 b=cCqOJIWPlLXPJREseDFilE7tW9ecBxOZGlRWe5L4PDvruQSM454K/2tLC3/31xQmJDVI9F
 EdxAad0dgByGHHd6AcmtCwZDDz0+RXurcDqa8JoZxM9qLekvhpg+71aGsOGGcu++eosDzs
 GqH7GW7lEDv30DqqfUpSPj07wLTT9uY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-7bmNPfaoNSu4ErYUrfAP-A-1; Tue, 31 Oct 2023 09:14:55 -0400
X-MC-Unique: 7bmNPfaoNSu4ErYUrfAP-A-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-5a7cc433782so54283617b3.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 06:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698758095; x=1699362895;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fwt+qAZnE3+4Ca3lcMRZuxYOMX4ohYc5pMOgwYcSV1o=;
 b=p0qOMHWZh/ilREGLRFALJ6rqAZaZNihlgwnbccyuB14sotDJLz5+hMexME6V3fYdAO
 IYRGHB/2MjsUAZVLU0lPbgoNwcgzRvEWoqIsh8vaE61iTPJJrXKpBFOqsXJXHSiugYOh
 ArAkMOwojVnvhujMyd0ifLhzcS2R4J8aS9K9JyakhvTa5SDOlz/AlWTgPu6lxBQD1S57
 6xqMqYsKFbjXyAaKwbVpXTvuByTz9uppPk/eJAOTKTpI/w44B7xfQgS6fzsIBjhykOCS
 QTC8wqmaYybtFBUNB1VlqnhhS+w/xKqLqKvobNsrQoxAKP7vK2cnlMMv9fbjdaMz0DbB
 JbFA==
X-Gm-Message-State: AOJu0YxIbZE42DknqvRIRnYM5mhikdh8f95oSwypW5MLiQO0GdC7O/fc
 GSs65nHeP0BsDpZJpqNaRJov4e+jKBo7hR5hkNpmTkiNSFIJQTB29kBdoOZBeEyRMPYDdD4xCGe
 GhIhngwYnbEUbnTw=
X-Received: by 2002:a81:c606:0:b0:5a7:d938:c5e2 with SMTP id
 l6-20020a81c606000000b005a7d938c5e2mr10070449ywi.14.1698758094916; 
 Tue, 31 Oct 2023 06:14:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEeOEMJ16D9OhRc43mK9aL3QyVik9v1bxzq5Z5ATizwTOdil9KwYbukd7GF9OmiTeYH9TS7w==
X-Received: by 2002:a81:c606:0:b0:5a7:d938:c5e2 with SMTP id
 l6-20020a81c606000000b005a7d938c5e2mr10070413ywi.14.1698758094630; 
 Tue, 31 Oct 2023 06:14:54 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 w188-20020a0dd4c5000000b0059f8120ee4dsm781485ywd.30.2023.10.31.06.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 06:14:53 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Eric Blake <eblake@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  Avihai Horon <avihaih@nvidia.com>,  Yishai Hadas
 <yishaih@nvidia.com>,  "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: Re: [PATCH 5/5] migration: Print expected-downtime on completion
In-Reply-To: <20230926161841.98464-6-joao.m.martins@oracle.com> (Joao
 Martins's message of "Tue, 26 Sep 2023 17:18:41 +0100")
References: <20230926161841.98464-1-joao.m.martins@oracle.com>
 <20230926161841.98464-6-joao.m.martins@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 14:14:51 +0100
Message-ID: <877cn37x2s.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Joao Martins <joao.m.martins@oracle.com> wrote:
> Right now, migration statistics either print downtime or expected
> downtime depending on migration completing of in progress. Also in the
> beginning of migration by printing the downtime limit as expected
> downtime, when estimation is not available.
>
> The pending_size is private in migration iteration and not necessarily
> accessible outside. Given the non-determinism of the switchover cost, it
> can be useful to understand if the downtime was far off from the one
> detected by the migration algoritm, thus print the resultant downtime
> alongside its estimation.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>

I see that "part" of this series is on the downtime series by Peter.
I have merged them (they are tracepoints, we can change them when
needed).

But this one is not on that series.

Should we continue and send a patch for it?

Later, Juan.


> ---
>  migration/migration.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index dec6c88fbff9..f08f65b4b1c3 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -943,6 +943,10 @@ static void populate_time_info(MigrationInfo *info, MigrationState *s)
>      if (s->state == MIGRATION_STATUS_COMPLETED) {
>          info->has_total_time = true;
>          info->total_time = s->total_time;
> +        if (s->expected_downtime) {
> +            info->has_expected_downtime = true;
> +            info->expected_downtime = s->expected_downtime;
> +        }
>      } else {
>          info->has_total_time = true;
>          info->total_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) -
> @@ -2844,6 +2848,10 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>  
>      if ((!pending_size || pending_size < s->threshold_size) && can_switchover) {
>          trace_migration_thread_low_pending(pending_size);
> +        if (s->threshold_size) {
> +            s->expected_downtime = (pending_size * s->parameters.downtime_limit) /
> +                                   s->threshold_size;
> +        }
>          migration_completion(s);
>          return MIG_ITERATE_BREAK;
>      }


