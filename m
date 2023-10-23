Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1777D36FB
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 14:38:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quuB7-0002NB-BW; Mon, 23 Oct 2023 08:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1quuB2-0002MW-T8
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:37:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1quuAv-0000vJ-Qr
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698064612;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=F+CRA24nGBkNeQwzOFr7JCYRcSMlBMq147SAtrDaPNA=;
 b=aP5OMqa1oVe96H3Oj8Kdv3r+VW1SeNjxD/meg6jADjga8nk3fYmY888YRLl2qQx7p9wKp5
 lnSHe00ApfkGUPUlSyNkdqJ81szB2IzVoHpAs7U/zFHLjYtbcS6WTUereTlmwq4lTmGlyX
 iIGQeS5EBdK9g47QjeoWphpnffrRzZM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-ceA5Lsc-NeSqVXoy-TPJRg-1; Mon, 23 Oct 2023 08:36:51 -0400
X-MC-Unique: ceA5Lsc-NeSqVXoy-TPJRg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A23B80F8FD;
 Mon, 23 Oct 2023 12:36:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D66BC8C0A;
 Mon, 23 Oct 2023 12:36:48 +0000 (UTC)
Date: Mon, 23 Oct 2023 13:36:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V1 3/4] cpr: relax some blockers
Message-ID: <ZTZo3gXG1Jyzw0jq@redhat.com>
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <1697748466-373230-4-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1697748466-373230-4-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Oct 19, 2023 at 01:47:45PM -0700, Steve Sistare wrote:
> Some devices block migration because they rely on local state that
> is not migrated to the target host, such as for local filesystems.
> These need not block cpr, which will restart qemu on the same host.
> Narrow the scope of these blockers so they only apply to normal mode.
> They will not block cpr modes when they are added in subsequent patches.

Looking at these changes, it is not entirely clear to me
why many of these features were blocked for migration
in the first place, and thus it is even less clear why
we should be OK to relax this for cpr.

I'd prefer to see some justification for each file,
explaining why the current blocker exists and why
it is OK to relax it for cpr.

> 
> No functional change until a new mode is added.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  backends/tpm/tpm_emulator.c | 2 +-
>  block/parallels.c           | 2 +-
>  block/qcow.c                | 2 +-
>  block/vdi.c                 | 2 +-
>  block/vhdx.c                | 2 +-
>  block/vmdk.c                | 2 +-
>  block/vpc.c                 | 2 +-
>  block/vvfat.c               | 2 +-
>  hw/9pfs/9p.c                | 2 +-
>  hw/scsi/vhost-scsi.c        | 2 +-
>  hw/virtio/vhost.c           | 2 +-
>  target/i386/nvmm/nvmm-all.c | 3 ++-
>  12 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index bf1a90f..ac66aee 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -534,7 +534,7 @@ static int tpm_emulator_block_migration(TPMEmulator *tpm_emu)
>          error_setg(&tpm_emu->migration_blocker,
>                     "Migration disabled: TPM emulator does not support "
>                     "migration");
> -        if (migrate_add_blocker(&tpm_emu->migration_blocker, &err) < 0) {
> +        if (migrate_add_blocker_normal(&tpm_emu->migration_blocker, &err) < 0) {
>              error_report_err(err);
>              return -1;
>          }
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
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index af636cf..369dfc8 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1501,7 +1501,7 @@ static void coroutine_fn v9fs_attach(void *opaque)
>          error_setg(&s->migration_blocker,
>                     "Migration is disabled when VirtFS export path '%s' is mounted in the guest using mount_tag '%s'",
>                     s->ctx.fs_root ? s->ctx.fs_root : "NULL", s->tag);
> -        err = migrate_add_blocker(&s->migration_blocker, NULL);
> +        err = migrate_add_blocker_normal(&s->migration_blocker, NULL);
>          if (err < 0) {
>              clunk_fid(s, fid);
>              goto out;
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index 14e23cc..bf528d5 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -208,7 +208,7 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
>                  "When external environment supports it (Orchestrator migrates "
>                  "target SCSI device state or use shared storage over network), "
>                  "set 'migratable' property to true to enable migration.");
> -        if (migrate_add_blocker(&vsc->migration_blocker, errp) < 0) {
> +        if (migrate_add_blocker_normal(&vsc->migration_blocker, errp) < 0) {
>              goto free_virtio;
>          }
>      }
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index d737671..f5e9625 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1527,7 +1527,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>      }
>  
>      if (hdev->migration_blocker != NULL) {
> -        r = migrate_add_blocker(&hdev->migration_blocker, errp);
> +        r = migrate_add_blocker_normal(&hdev->migration_blocker, errp);
>          if (r < 0) {
>              goto fail_busyloop;
>          }
> diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
> index 7d752bc..0cfcdac 100644
> --- a/target/i386/nvmm/nvmm-all.c
> +++ b/target/i386/nvmm/nvmm-all.c
> @@ -929,7 +929,8 @@ nvmm_init_vcpu(CPUState *cpu)
>          error_setg(&nvmm_migration_blocker,
>              "NVMM: Migration not supported");
>  
> -        if (migrate_add_blocker(&nvmm_migration_blocker, &local_error) < 0) {
> +        ret = migrate_add_blocker_normal(&nvmm_migration_blocker, &local_error);
> +        if (ret < 0) {
>              error_report_err(local_error);
>              return -EINVAL;
>          }
> -- 
> 1.8.3.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


