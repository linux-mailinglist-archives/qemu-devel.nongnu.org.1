Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB91082AC5C
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 11:45:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNsXd-00047H-Lu; Thu, 11 Jan 2024 05:44:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNsXZ-000471-GO
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 05:44:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNsXX-00029d-CP
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 05:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704969838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WeQGFyNcwRy2fnDQDR9/okS2evxHpEG092ZRaZmwZNw=;
 b=eSCQ2mq2jftbAmY6Ei/JLHozifkEMpo9Gb2FkUiWgZn0wl853BV2JP2ue978hl2jBvV9FS
 XPmiLq+UCI/jc/s+4oeN2BwUNcoSewS0XELu2+SJH+PGrWctCAYDAzdSqZodT7swL2koXg
 zpnd/Q6+nP7x1grgTPF+0B8DYfpipeQ=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-X61Retc-O9ucO3mxfAH86Q-1; Thu, 11 Jan 2024 05:43:56 -0500
X-MC-Unique: X61Retc-O9ucO3mxfAH86Q-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6d9bf77a474so1547593b3a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 02:43:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704969835; x=1705574635;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WeQGFyNcwRy2fnDQDR9/okS2evxHpEG092ZRaZmwZNw=;
 b=rOLkHmzarg94mqKi0oq+dtLiX3cPcyoMtbcCVgneeyvxNxxdcGWGEmwQg+jJo2yejX
 G9qR1Eyv9MZXgF4rYntB7nZ5MqhQoQrMyG/GjJUCAbNeaenUCpa2yWgGshWsrtJIywb4
 yssCw5YFl2+FncgxU9uFw5+AL0PnGD3orH+th82cfieGsm45vcbW1ZIi+1QFaK9Lubio
 4jItW1UdNBSTeNT/MZSF3rvMokfn17atTRywgd4KSjqIJgFew1Ou6JseBZhb2EhRXCeY
 ayEPB0L4AaE+54GrDfsg9G8CLS12Bmphm5yIf0zjrKBIhjGoYOkF2IIuvo3j6S1v/qhY
 TGUQ==
X-Gm-Message-State: AOJu0YwXqHoQBD8y3UX1xsicUsUp+6JSyStpMmacGL7mqiDzqsvcNs1Z
 mIVywUA/vaFiQsS7rjOqba6HHEVgzSDrmscrnXrhh5G0aeqH3FT3J2Q+kEVM7yqjmsKU5xPd4PK
 Qnw0/iCsGQu3VXRa7LJY5jrk=
X-Received: by 2002:a05:6a20:9385:b0:199:501f:a08b with SMTP id
 x5-20020a056a20938500b00199501fa08bmr1826580pzh.3.1704969835445; 
 Thu, 11 Jan 2024 02:43:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHELjabGTxjFrmPttQ28kfsZWNiFrsQGmZfqOVpfpQQNMZS3Yx8O88dV6zta7wSSPkvhEWorw==
X-Received: by 2002:a05:6a20:9385:b0:199:501f:a08b with SMTP id
 x5-20020a056a20938500b00199501fa08bmr1826558pzh.3.1704969835111; 
 Thu, 11 Jan 2024 02:43:55 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 x9-20020aa793a9000000b006d974fe1b0esm857152pff.7.2024.01.11.02.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 02:43:54 -0800 (PST)
Date: Thu, 11 Jan 2024 18:43:46 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eric Blake <eblake@redhat.com>
Subject: Re: [RFC PATCH v3 06/30] migration/ram: Introduce 'fixed-ram'
 migration capability
Message-ID: <ZZ_GYkxofOc-6TnU@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127202612.23012-7-farosas@suse.de>
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

On Mon, Nov 27, 2023 at 05:25:48PM -0300, Fabiano Rosas wrote:
> Add a new migration capability 'fixed-ram'.
> 
> The core of the feature is to ensure that each RAM page has a specific
> offset in the resulting migration stream. The reasons why we'd want
> such behavior are:
> 
>  - The resulting file will have a bounded size, since pages which are
>    dirtied multiple times will always go to a fixed location in the
>    file, rather than constantly being added to a sequential
>    stream. This eliminates cases where a VM with, say, 1G of RAM can
>    result in a migration file that's 10s of GBs, provided that the
>    workload constantly redirties memory.
> 
>  - It paves the way to implement O_DIRECT-enabled save/restore of the
>    migration stream as the pages are ensured to be written at aligned
>    offsets.
> 
>  - It allows the usage of multifd so we can write RAM pages to the
>    migration file in parallel.
> 
> For now, enabling the capability has no effect. The next couple of
> patches implement the core functionality.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> - mentioned seeking on docs
> ---
>  docs/devel/migration.rst | 21 +++++++++++++++++++++
>  migration/options.c      | 34 ++++++++++++++++++++++++++++++++++
>  migration/options.h      |  1 +
>  migration/savevm.c       |  1 +
>  qapi/migration.json      |  6 +++++-
>  5 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> index ec55089b25..eeb4fec31f 100644
> --- a/docs/devel/migration.rst
> +++ b/docs/devel/migration.rst
> @@ -572,6 +572,27 @@ Others (especially either older devices or system devices which for
>  some reason don't have a bus concept) make use of the ``instance id``
>  for otherwise identically named devices.
>  
> +Fixed-ram format
> +----------------
> +
> +When the ``fixed-ram`` capability is enabled, a slightly different
> +stream format is used for the RAM section. Instead of having a
> +sequential stream of pages that follow the RAMBlock headers, the dirty
> +pages for a RAMBlock follow its header. This ensures that each RAM
> +page has a fixed offset in the resulting migration file.
> +
> +The ``fixed-ram`` capability must be enabled in both source and
> +destination with:
> +
> +    ``migrate_set_capability fixed-ram on``
> +
> +Since pages are written to their relative offsets and out of order
> +(due to the memory dirtying patterns), streaming channels such as
> +sockets are not supported. A seekable channel such as a file is
> +required. This can be verified in the QIOChannel by the presence of
> +the QIO_CHANNEL_FEATURE_SEEKABLE. In more practical terms, this
> +migration format requires the ``file:`` URI when migrating.

After the doc cleanup that I just posted, fixed-ram can have its own file
now.

Could you move the nice ascii art from patch 8 commit message to here?
More doc is always good.  The commit message can get lost very soon, doc
will be more persistent.

Also, can we provide more information on this feature in the doc then users
can know when they should be used, and how?

For example, IIUC it only applies to the case where the user wants to stop
the VM right after snapshot-ing it into a file, right?  We'd better be
clear on this, as this is quite a special use of migration anyway. When at
this, we should also mention the fact that it's always suggested to stop
the VM first before doing such a migration?

> +
>  Return path
>  -----------
>  
> diff --git a/migration/options.c b/migration/options.c
> index 8d8ec73ad9..775428a8a5 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -204,6 +204,7 @@ Property migration_properties[] = {
>      DEFINE_PROP_MIG_CAP("x-switchover-ack",
>                          MIGRATION_CAPABILITY_SWITCHOVER_ACK),
>      DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
> +    DEFINE_PROP_MIG_CAP("x-fixed-ram", MIGRATION_CAPABILITY_FIXED_RAM),

Let's drop "x-"?  I am thinking we should drop all x-, it can break some
scripts but iiuc shouldn't be more than that.  Definitely another story..

>      DEFINE_PROP_END_OF_LIST(),
>  };

-- 
Peter Xu


