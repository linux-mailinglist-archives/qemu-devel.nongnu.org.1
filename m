Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE3A7DD0C2
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:42:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxqsd-0006BD-KR; Tue, 31 Oct 2023 11:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxqsb-00066N-C3
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxqsZ-000437-3h
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698766924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tprj/Havtt/UFOMVmR+tMFeB4UD2p0f4XF4YXGRTTSY=;
 b=faw8hDDV5Or6A2s7oqpa+FNYRXfogWBNhYV4HmRXmNAGP2+N9Jxe7e+8kv+uYxppYnrQLE
 iwuDViPlEaMMF0bB0TLZfM4BTnwlcp5Q4neHqSqh8vlKewusCVeY8ZQziLO6C/kXjGBBMR
 xP63HWrZTV7sGkhZY0ZzAsUWbZ3Vjug=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-M4GOWq2RNSSf2TJivzappg-1; Tue, 31 Oct 2023 11:42:03 -0400
X-MC-Unique: M4GOWq2RNSSf2TJivzappg-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3b40deadcb7so1921701b6e.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698766922; x=1699371722;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tprj/Havtt/UFOMVmR+tMFeB4UD2p0f4XF4YXGRTTSY=;
 b=eMeaUf1dANYe3XsxzWCmZE2iKTjuneOslo6ClyIswdiZMBCEa9zS94tKj7FjR+ICaK
 0DvozFpK2pROF7WEZPMldWU3ZQEwyIH6qUVF6uZ8DI02l8psrOg1JAR/fJkJL1YqMxrd
 JrJZNtgiQwsiy/ZZUredkC44qPFid8YokEMmpHoGtA5A3nisvvlUXJxhooySVS9EFfJf
 2fJaqAskT3nNHqyK+VyzvrVkELzbH9N+iA+4yPw6V1coEPV4XOC2Fz7bPf2OfFABuuGg
 Udy8jKGL/KbysULUM0XvcibZ+E1SkbFlihSlSLEmEhipcpDjCq+8s5qwwYuxZg2VCG+s
 7CXg==
X-Gm-Message-State: AOJu0Yxcr8Ps+4un+LRJFc8X/0cZsWMMh/yrOAeouxeOM22eOcICXg5g
 6sce8YpOSc4FEawRoY9JIbd5kW8NtDGOwIObQ1n2j03+vmC0D48AiimuCZ6LOBZTZ7uGFVNN5fq
 R+XVqgUFbkV2UD3Y=
X-Received: by 2002:a05:6808:158c:b0:3b2:db33:e301 with SMTP id
 t12-20020a056808158c00b003b2db33e301mr15571348oiw.0.1698766922318; 
 Tue, 31 Oct 2023 08:42:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/liCaq3lhPOZfAtGA4PWyBoc84VEId932P6pUsizGxCCCYMWi9vL+Ilh3YpiWew0iAiMm7A==
X-Received: by 2002:a05:6808:158c:b0:3b2:db33:e301 with SMTP id
 t12-20020a056808158c00b003b2db33e301mr15571327oiw.0.1698766922002; 
 Tue, 31 Oct 2023 08:42:02 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 de43-20020a05620a372b00b007788d2f3d4asm602176qkb.39.2023.10.31.08.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 08:42:01 -0700 (PDT)
Date: Tue, 31 Oct 2023 11:41:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [PATCH V2 3/6] cpr: relax blockdev migration blockers
Message-ID: <ZUEgRy0l8XRVuQNo@x1n>
References: <1698263069-406971-1-git-send-email-steven.sistare@oracle.com>
 <1698263069-406971-4-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1698263069-406971-4-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Copy qemu-block and maintainers.

On Wed, Oct 25, 2023 at 12:44:26PM -0700, Steve Sistare wrote:
> Some blockdevs block migration because they do not support sharing across
> hosts and/or do not support dirty bitmaps.  These prohibitions do not apply
> if the old and new qemu processes do not run concurrently, and if new qemu
> starts on the same host as old, which is the case for cpr.  Narrow the scope
> of these blockers so they only apply to normal mode.  They will not block
> cpr modes when they are added in subsequent patches.
> 
> No functional change until a new mode is added.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> ---
>  block/parallels.c | 2 +-
>  block/qcow.c      | 2 +-
>  block/vdi.c       | 2 +-
>  block/vhdx.c      | 2 +-
>  block/vmdk.c      | 2 +-
>  block/vpc.c       | 2 +-
>  block/vvfat.c     | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/block/parallels.c b/block/parallels.c
> index 1697a2e..8a520db 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1369,7 +1369,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>                 bdrv_get_device_or_node_name(bs));
>      bdrv_graph_rdunlock_main_loop();
>  
> -    ret = migrate_add_blocker(&s->migration_blocker, errp);
> +    ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
>      if (ret < 0) {
>          error_setg(errp, "Migration blocker error");
>          goto fail;
> diff --git a/block/qcow.c b/block/qcow.c
> index fdd4c83..eab68e3 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -307,7 +307,7 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
>                 bdrv_get_device_or_node_name(bs));
>      bdrv_graph_rdunlock_main_loop();
>  
> -    ret = migrate_add_blocker(&s->migration_blocker, errp);
> +    ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
>      if (ret < 0) {
>          goto fail;
>      }
> diff --git a/block/vdi.c b/block/vdi.c
> index fd7e365..c647d72 100644
> --- a/block/vdi.c
> +++ b/block/vdi.c
> @@ -498,7 +498,7 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
>                 bdrv_get_device_or_node_name(bs));
>      bdrv_graph_rdunlock_main_loop();
>  
> -    ret = migrate_add_blocker(&s->migration_blocker, errp);
> +    ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
>      if (ret < 0) {
>          goto fail_free_bmap;
>      }
> diff --git a/block/vhdx.c b/block/vhdx.c
> index e37f8c0..a9d0874 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -1096,7 +1096,7 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
>      error_setg(&s->migration_blocker, "The vhdx format used by node '%s' "
>                 "does not support live migration",
>                 bdrv_get_device_or_node_name(bs));
> -    ret = migrate_add_blocker(&s->migration_blocker, errp);
> +    ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
>      if (ret < 0) {
>          goto fail;
>      }
> diff --git a/block/vmdk.c b/block/vmdk.c
> index 1335d39..85864b8 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -1386,7 +1386,7 @@ static int vmdk_open(BlockDriverState *bs, QDict *options, int flags,
>      error_setg(&s->migration_blocker, "The vmdk format used by node '%s' "
>                 "does not support live migration",
>                 bdrv_get_device_or_node_name(bs));
> -    ret = migrate_add_blocker(&s->migration_blocker, errp);
> +    ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
>      if (ret < 0) {
>          goto fail;
>      }
> diff --git a/block/vpc.c b/block/vpc.c
> index c30cf86..aa1a48a 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -452,7 +452,7 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
>                 bdrv_get_device_or_node_name(bs));
>      bdrv_graph_rdunlock_main_loop();
>  
> -    ret = migrate_add_blocker(&s->migration_blocker, errp);
> +    ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
>      if (ret < 0) {
>          goto fail;
>      }
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 266e036..9d050ba 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1268,7 +1268,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>                     "The vvfat (rw) format used by node '%s' "
>                     "does not support live migration",
>                     bdrv_get_device_or_node_name(bs));
> -        ret = migrate_add_blocker(&s->migration_blocker, errp);
> +        ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
>          if (ret < 0) {
>              goto fail;
>          }
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


