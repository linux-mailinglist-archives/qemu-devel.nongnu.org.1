Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7A7742F5F
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 23:17:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEz0V-0004MB-27; Thu, 29 Jun 2023 17:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEz0P-0004Ld-89
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 17:16:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEz0N-0003JE-F6
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 17:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688073401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vy8YsfUaSXe1DdBiW280uutUiBW4TCPu0rr+d5SEoOw=;
 b=RoGXRAHx6KKRSOkUUdCru+yhTtFkhdteGj00vfnjV+qdAvXhJJ74rgs5fsWSw/PW0HEb0R
 DPGTKdWBmRCHiOPCsbVZ67zFEyNhDbpeKs9icNoM42X9QJRjUWgqwqqoiybvcum2cyyXwd
 EDA3rmbzH0ofFZxOEWqFC5B8P6GZVy8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-uaka7kNQM8WgX_XrHdB0pw-1; Thu, 29 Jun 2023 17:16:40 -0400
X-MC-Unique: uaka7kNQM8WgX_XrHdB0pw-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-402fa256023so1855641cf.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 14:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688073399; x=1690665399;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vy8YsfUaSXe1DdBiW280uutUiBW4TCPu0rr+d5SEoOw=;
 b=Zo/YYCucneJTqeMug0oKD/3JS1Lz46qNMx7TjAnD6e24S34SSCaFnahQELtGef3T2p
 ngrs+kOdGZFe6j9NDRVQrQoj51AQFXz4RK2XPv8F3Nn4J15PskFfQj1loSz/ikD3ywEM
 q7huZivd1O84nb66+A+mDqIocAwZSXZWyiq+9zB1yvxjvyEqgU83vgGclnvMCOONBwvA
 t/dHqi6SoJDsBuntdw9AtTzKO6d5dS7g9OXbpmRoU+6jupzDs+nW36q9I4KeCTLasm83
 gsI8+ZrBOhbrIA/EqpBSXyrkHZ9bE3S4hfyF+rvRaftbw09V24RrizO6KqxrvWQ9Qzp3
 Jocg==
X-Gm-Message-State: AC+VfDwV8BRc14YZpR17QoM8oJ+o9HWgoxeIsnbdHDtzGZPRdG5zGcso
 jaFPn+UAZqEVy+cVfgvbNJTofHzyNhn1OKfm3JSTtL9PkztQxM1JZ41ztgpTlNBUJStQL8TrSAL
 vG93Vhzc5bi3wzsE=
X-Received: by 2002:a05:622a:1a8c:b0:403:2818:7041 with SMTP id
 s12-20020a05622a1a8c00b0040328187041mr768855qtc.1.1688073399608; 
 Thu, 29 Jun 2023 14:16:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6msh1FrJaVCIgNlBXXxkA4yD0P0F+leVNZrnZ4eTvJtSeVXGbzAjWyJptdVpZZBHGakW0Mag==
X-Received: by 2002:a05:622a:1a8c:b0:403:2818:7041 with SMTP id
 s12-20020a05622a1a8c00b0040328187041mr768829qtc.1.1688073399313; 
 Thu, 29 Jun 2023 14:16:39 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 r15-20020ac85e8f000000b00403214e8862sm2574090qtx.33.2023.06.29.14.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 14:16:38 -0700 (PDT)
Date: Thu, 29 Jun 2023 17:16:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/6] tests/qtest: migration: Add migrate_incoming_qmp
 helper
Message-ID: <ZJ30tJ+3umGH2Xto@x1n>
References: <20230628165542.17214-1-farosas@suse.de>
 <20230628165542.17214-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230628165542.17214-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Jun 28, 2023 at 01:55:39PM -0300, Fabiano Rosas wrote:
> file-based migration requires the target to initiate its migration after
> the source has finished writing out the data in the file. Currently
> there's no easy way to initiate 'migrate-incoming', allow this by
> introducing migrate_incoming_qmp helper, similarly to migrate_qmp.
> 
> Also make sure migration events are enabled and wait for the incoming
> migration to start before returning. This avoid a race when querying
> the migration status too soon after issuing the command.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-helpers.c | 28 ++++++++++++++++++++++++++++
>  tests/qtest/migration-helpers.h |  4 ++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index 2df198c99e..bc54b29184 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -81,6 +81,34 @@ void migrate_set_capability(QTestState *who, const char *capability,
>                               capability, value);
>  }
>  
> +void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
> +{
> +    va_list ap;
> +    QDict *args, *rsp, *data;
> +
> +    va_start(ap, fmt);
> +    args = qdict_from_vjsonf_nofail(fmt, ap);
> +    va_end(ap);
> +
> +    g_assert(!qdict_haskey(args, "uri"));
> +    qdict_put_str(args, "uri", uri);
> +
> +    migrate_set_capability(to, "events", true);
> +
> +    rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
> +                    args);
> +    g_assert(qdict_haskey(rsp, "return"));

rsp leaked?

> +
> +    rsp = qtest_qmp_eventwait_ref(to, "MIGRATION");
> +    g_assert(qdict_haskey(rsp, "data"));
> +
> +    data = qdict_get_qdict(rsp, "data");
> +    g_assert(qdict_haskey(data, "status"));
> +    g_assert_cmpstr(qdict_get_str(data, "status"), ==, "setup");
> +
> +    qobject_unref(rsp);
> +}
> +
>  /*
>   * Note: caller is responsible to free the returned object via
>   * qobject_unref() after use
> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
> index 484d7c960f..57d295a4fe 100644
> --- a/tests/qtest/migration-helpers.h
> +++ b/tests/qtest/migration-helpers.h
> @@ -23,6 +23,10 @@ bool migrate_watch_for_resume(QTestState *who, const char *name,
>  G_GNUC_PRINTF(3, 4)
>  void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...);
>  
> +G_GNUC_PRINTF(3, 4)
> +void migrate_incoming_qmp(QTestState *who, const char *uri,
> +                          const char *fmt, ...);
> +
>  void migrate_set_capability(QTestState *who, const char *capability,
>                              bool value);
>  
> -- 
> 2.35.3
> 

-- 
Peter Xu


