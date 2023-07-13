Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 383F3752C15
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:25:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3nQ-00047F-Qv; Thu, 13 Jul 2023 17:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1qK3nO-000473-5I
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:24:18 -0400
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1qK3nK-0004kD-7W
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:24:17 -0400
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
 by mx0a-00190b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DInkIo011124; Thu, 13 Jul 2023 22:24:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=1PllVKjimm/XDcciovjzMXiGpou/wB7hs9lVIlSihnM=;
 b=YaymbtHh7woUEMjNA2vfYUpfEGPq3ugbkMvdXk7NXrc82yMFSVRyEb7uXMHJVwtaCRZL
 cJ4mzVw9RZS6Jj7KFLeNsVJvrNWERAY/O4AcdF5AUbspo8EPmKF8lt0PxtWBXZCq5/8o
 ArX5bwTUiTupVTkvDcSlUnxABAT6Daimdl5TwxFGtlndIM6TprYdNPuwdydTJ60r5k34
 UAenQ2aH7COtXEXvigto/2NhGS2IRGmt01/XuROoAbdNB+Vm2Sj47eJEVtOEHR4okZOA
 F05lbPR/GoOHWCq29xzXM+ggMR//YefZlKAOHugKnw8neUozChATCTTGe3fl9lrOvfgi hA== 
Received: from prod-mail-ppoint3
 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be
 forged))
 by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 3rtpvujxah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 22:24:09 +0100
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
 by prod-mail-ppoint3.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DIlmpH031450; Thu, 13 Jul 2023 17:24:08 -0400
Received: from prod-mail-relay18.dfw02.corp.akamai.com ([172.27.165.172])
 by prod-mail-ppoint3.akamai.com (PPS) with ESMTP id 3rtpv1gn3e-1;
 Thu, 13 Jul 2023 17:24:08 -0400
Received: from [172.19.65.70] (unknown [172.19.65.70])
 by prod-mail-relay18.dfw02.corp.akamai.com (Postfix) with ESMTP id CEB8E284;
 Thu, 13 Jul 2023 21:24:07 +0000 (GMT)
Message-ID: <66f81daa-1b2a-9491-a259-e60b497250b5@akamai.com>
Date: Thu, 13 Jul 2023 16:24:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V4] migration: simplify blockers
Content-Language: en-US
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>
References: <1688761248-32741-1-git-send-email-steven.sistare@oracle.com>
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <1688761248-32741-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_09,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307130189
X-Proofpoint-GUID: 0qqnNoV1i5-tmBICg6MKIcq-6RFL3ItD
X-Proofpoint-ORIG-GUID: 0qqnNoV1i5-tmBICg6MKIcq-6RFL3ItD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_09,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 impostorscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307130189
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=mgalaxy@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 7/7/23 15:20, Steve Sistare wrote:
> Modify migrate_add_blocker and migrate_del_blocker to take an Error **
> reason.  This allows migration to own the Error object, so that if
> an error occurs, migration code can free the Error and clear the client
> handle, simplifying client code.
>
> This is also a pre-requisite for future patches that will add a mode
> argument to migration requests to support live update, and will maintain
> a list of blockers for each mode.  A blocker may apply to a single mode
> or to multiple modes, and passing Error** will allow one Error object to
> be registered for multiple modes.
>
> No functional change.

Tested-by: Michael Galaxy <mgalaxy@akamai.com>
Reviewed-by: Michael Galaxy <mgalaxy@akamai.com>


> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   backends/tpm/tpm_emulator.c  | 10 ++--------
>   block/parallels.c            |  6 ++----
>   block/qcow.c                 |  6 ++----
>   block/vdi.c                  |  6 ++----
>   block/vhdx.c                 |  6 ++----
>   block/vmdk.c                 |  6 ++----
>   block/vpc.c                  |  6 ++----
>   block/vvfat.c                |  6 ++----
>   dump/dump.c                  |  4 ++--
>   hw/9pfs/9p.c                 | 10 ++--------
>   hw/display/virtio-gpu-base.c |  8 ++------
>   hw/intc/arm_gic_kvm.c        |  3 +--
>   hw/intc/arm_gicv3_its_kvm.c  |  3 +--
>   hw/intc/arm_gicv3_kvm.c      |  3 +--
>   hw/misc/ivshmem.c            |  8 ++------
>   hw/ppc/pef.c                 |  2 +-
>   hw/ppc/spapr.c               |  2 +-
>   hw/ppc/spapr_events.c        |  2 +-
>   hw/ppc/spapr_rtas.c          |  2 +-
>   hw/remote/proxy.c            |  7 ++-----
>   hw/s390x/s390-virtio-ccw.c   |  9 +++------
>   hw/scsi/vhost-scsi.c         |  8 +++-----
>   hw/vfio/common.c             | 26 ++++----------------------
>   hw/vfio/migration.c          | 16 ++--------------
>   hw/virtio/vhost.c            |  8 ++------
>   include/migration/blocker.h  | 24 +++++++++++++++++-------
>   migration/migration.c        | 22 ++++++++++++++--------
>   stubs/migr-blocker.c         |  4 ++--
>   target/i386/kvm/kvm.c        |  8 ++++----
>   target/i386/nvmm/nvmm-all.c  |  3 +--
>   target/i386/sev.c            |  2 +-
>   target/i386/whpx/whpx-all.c  |  3 +--
>   ui/vdagent.c                 |  5 ++---
>   33 files changed, 89 insertions(+), 155 deletions(-)
>
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 402a2d6..bf1a90f 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -534,11 +534,8 @@ static int tpm_emulator_block_migration(TPMEmulator *tpm_emu)
>           error_setg(&tpm_emu->migration_blocker,
>                      "Migration disabled: TPM emulator does not support "
>                      "migration");
> -        if (migrate_add_blocker(tpm_emu->migration_blocker, &err) < 0) {
> +        if (migrate_add_blocker(&tpm_emu->migration_blocker, &err) < 0) {
>               error_report_err(err);
> -            error_free(tpm_emu->migration_blocker);
> -            tpm_emu->migration_blocker = NULL;
> -
>               return -1;
>           }
>       }
> @@ -1016,10 +1013,7 @@ static void tpm_emulator_inst_finalize(Object *obj)
>   
>       qapi_free_TPMEmulatorOptions(tpm_emu->options);
>   
> -    if (tpm_emu->migration_blocker) {
> -        migrate_del_blocker(tpm_emu->migration_blocker);
> -        error_free(tpm_emu->migration_blocker);
> -    }
> +    migrate_del_blocker(&tpm_emu->migration_blocker);
>   
>       tpm_sized_buffer_reset(&state_blobs->volatil);
>       tpm_sized_buffer_reset(&state_blobs->permanent);
> diff --git a/block/parallels.c b/block/parallels.c
> index 18e34ae..c2d92c4 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -960,9 +960,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>       error_setg(&s->migration_blocker, "The Parallels format used by node '%s' "
>                  "does not support live migration",
>                  bdrv_get_device_or_node_name(bs));
> -    ret = migrate_add_blocker(s->migration_blocker, errp);
> +    ret = migrate_add_blocker(&s->migration_blocker, errp);
>       if (ret < 0) {
> -        error_free(s->migration_blocker);
>           goto fail;
>       }
>       qemu_co_mutex_init(&s->lock);
> @@ -994,8 +993,7 @@ static void parallels_close(BlockDriverState *bs)
>       g_free(s->bat_dirty_bmap);
>       qemu_vfree(s->header);
>   
> -    migrate_del_blocker(s->migration_blocker);
> -    error_free(s->migration_blocker);
> +    migrate_del_blocker(&s->migration_blocker);
>   }
>   
>   static BlockDriver bdrv_parallels = {
> diff --git a/block/qcow.c b/block/qcow.c
> index 577bd70..feedad5 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -304,9 +304,8 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
>       error_setg(&s->migration_blocker, "The qcow format used by node '%s' "
>                  "does not support live migration",
>                  bdrv_get_device_or_node_name(bs));
> -    ret = migrate_add_blocker(s->migration_blocker, errp);
> +    ret = migrate_add_blocker(&s->migration_blocker, errp);
>       if (ret < 0) {
> -        error_free(s->migration_blocker);
>           goto fail;
>       }
>   
> @@ -796,8 +795,7 @@ static void qcow_close(BlockDriverState *bs)
>       g_free(s->cluster_cache);
>       g_free(s->cluster_data);
>   
> -    migrate_del_blocker(s->migration_blocker);
> -    error_free(s->migration_blocker);
> +    migrate_del_blocker(&s->migration_blocker);
>   }
>   
>   static int coroutine_fn GRAPH_UNLOCKED
> diff --git a/block/vdi.c b/block/vdi.c
> index 6c35309..1b7f423 100644
> --- a/block/vdi.c
> +++ b/block/vdi.c
> @@ -495,9 +495,8 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
>       error_setg(&s->migration_blocker, "The vdi format used by node '%s' "
>                  "does not support live migration",
>                  bdrv_get_device_or_node_name(bs));
> -    ret = migrate_add_blocker(s->migration_blocker, errp);
> +    ret = migrate_add_blocker(&s->migration_blocker, errp);
>       if (ret < 0) {
> -        error_free(s->migration_blocker);
>           goto fail_free_bmap;
>       }
>   
> @@ -986,8 +985,7 @@ static void vdi_close(BlockDriverState *bs)
>   
>       qemu_vfree(s->bmap);
>   
> -    migrate_del_blocker(s->migration_blocker);
> -    error_free(s->migration_blocker);
> +    migrate_del_blocker(&s->migration_blocker);
>   }
>   
>   static int vdi_has_zero_init(BlockDriverState *bs)
> diff --git a/block/vhdx.c b/block/vhdx.c
> index f2c3a80..0fffa7e 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -985,8 +985,7 @@ static void vhdx_close(BlockDriverState *bs)
>       s->bat = NULL;
>       qemu_vfree(s->parent_entries);
>       s->parent_entries = NULL;
> -    migrate_del_blocker(s->migration_blocker);
> -    error_free(s->migration_blocker);
> +    migrate_del_blocker(&s->migration_blocker);
>       qemu_vfree(s->log.hdr);
>       s->log.hdr = NULL;
>       vhdx_region_unregister_all(s);
> @@ -1093,9 +1092,8 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
>       error_setg(&s->migration_blocker, "The vhdx format used by node '%s' "
>                  "does not support live migration",
>                  bdrv_get_device_or_node_name(bs));
> -    ret = migrate_add_blocker(s->migration_blocker, errp);
> +    ret = migrate_add_blocker(&s->migration_blocker, errp);
>       if (ret < 0) {
> -        error_free(s->migration_blocker);
>           goto fail;
>       }
>   
> diff --git a/block/vmdk.c b/block/vmdk.c
> index 70066c2..a150a11 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -1360,9 +1360,8 @@ static int vmdk_open(BlockDriverState *bs, QDict *options, int flags,
>       error_setg(&s->migration_blocker, "The vmdk format used by node '%s' "
>                  "does not support live migration",
>                  bdrv_get_device_or_node_name(bs));
> -    ret = migrate_add_blocker(s->migration_blocker, errp);
> +    ret = migrate_add_blocker(&s->migration_blocker, errp);
>       if (ret < 0) {
> -        error_free(s->migration_blocker);
>           goto fail;
>       }
>   
> @@ -2839,8 +2838,7 @@ static void vmdk_close(BlockDriverState *bs)
>       vmdk_free_extents(bs);
>       g_free(s->create_type);
>   
> -    migrate_del_blocker(s->migration_blocker);
> -    error_free(s->migration_blocker);
> +    migrate_del_blocker(&s->migration_blocker);
>   }
>   
>   static int64_t coroutine_fn GRAPH_RDLOCK
> diff --git a/block/vpc.c b/block/vpc.c
> index 3810a60..15f04fc 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -449,9 +449,8 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
>       error_setg(&s->migration_blocker, "The vpc format used by node '%s' "
>                  "does not support live migration",
>                  bdrv_get_device_or_node_name(bs));
> -    ret = migrate_add_blocker(s->migration_blocker, errp);
> +    ret = migrate_add_blocker(&s->migration_blocker, errp);
>       if (ret < 0) {
> -        error_free(s->migration_blocker);
>           goto fail;
>       }
>   
> @@ -1187,8 +1186,7 @@ static void vpc_close(BlockDriverState *bs)
>       g_free(s->pageentry_u8);
>   #endif
>   
> -    migrate_del_blocker(s->migration_blocker);
> -    error_free(s->migration_blocker);
> +    migrate_del_blocker(&s->migration_blocker);
>   }
>   
>   static QemuOptsList vpc_create_opts = {
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 0ddc91f..0436d28 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1267,9 +1267,8 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>                      "The vvfat (rw) format used by node '%s' "
>                      "does not support live migration",
>                      bdrv_get_device_or_node_name(bs));
> -        ret = migrate_add_blocker(s->migration_blocker, errp);
> +        ret = migrate_add_blocker(&s->migration_blocker, errp);
>           if (ret < 0) {
> -            error_free(s->migration_blocker);
>               goto fail;
>           }
>       }
> @@ -3236,8 +3235,7 @@ static void vvfat_close(BlockDriverState *bs)
>       g_free(s->cluster_buffer);
>   
>       if (s->qcow) {
> -        migrate_del_blocker(s->migration_blocker);
> -        error_free(s->migration_blocker);
> +        migrate_del_blocker(&s->migration_blocker);
>       }
>   }
>   
> diff --git a/dump/dump.c b/dump/dump.c
> index 1f1a6ed..99016c6 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -111,7 +111,7 @@ static int dump_cleanup(DumpState *s)
>               qemu_mutex_unlock_iothread();
>           }
>       }
> -    migrate_del_blocker(dump_migration_blocker);
> +    migrate_del_blocker(&dump_migration_blocker);
>   
>       return 0;
>   }
> @@ -2158,7 +2158,7 @@ void qmp_dump_guest_memory(bool paging, const char *file,
>        * Allows even for -only-migratable, but forbid migration during the
>        * process of dump guest memory.
>        */
> -    if (migrate_add_blocker_internal(dump_migration_blocker, errp)) {
> +    if (migrate_add_blocker_internal(&dump_migration_blocker, errp)) {
>           /* Remember to release the fd before passing it over to dump state */
>           close(fd);
>           return;
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 991645a..64b03f8 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -406,11 +406,7 @@ static int coroutine_fn put_fid(V9fsPDU *pdu, V9fsFidState *fidp)
>                * delete the migration blocker. Ideally, this
>                * should be hooked to transport close notification
>                */
> -            if (pdu->s->migration_blocker) {
> -                migrate_del_blocker(pdu->s->migration_blocker);
> -                error_free(pdu->s->migration_blocker);
> -                pdu->s->migration_blocker = NULL;
> -            }
> +            migrate_del_blocker(&pdu->s->migration_blocker);
>           }
>           return free_fid(pdu, fidp);
>       }
> @@ -1505,10 +1501,8 @@ static void coroutine_fn v9fs_attach(void *opaque)
>           error_setg(&s->migration_blocker,
>                      "Migration is disabled when VirtFS export path '%s' is mounted in the guest using mount_tag '%s'",
>                      s->ctx.fs_root ? s->ctx.fs_root : "NULL", s->tag);
> -        err = migrate_add_blocker(s->migration_blocker, NULL);
> +        err = migrate_add_blocker(&s->migration_blocker, NULL);
>           if (err < 0) {
> -            error_free(s->migration_blocker);
> -            s->migration_blocker = NULL;
>               clunk_fid(s, fid);
>               goto out;
>           }
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index a29f191..995c9a9 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -167,8 +167,7 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>   
>       if (virtio_gpu_virgl_enabled(g->conf)) {
>           error_setg(&g->migration_blocker, "virgl is not yet migratable");
> -        if (migrate_add_blocker(g->migration_blocker, errp) < 0) {
> -            error_free(g->migration_blocker);
> +        if (migrate_add_blocker(&g->migration_blocker, errp) < 0) {
>               return false;
>           }
>       }
> @@ -232,10 +231,7 @@ virtio_gpu_base_device_unrealize(DeviceState *qdev)
>   {
>       VirtIOGPUBase *g = VIRTIO_GPU_BASE(qdev);
>   
> -    if (g->migration_blocker) {
> -        migrate_del_blocker(g->migration_blocker);
> -        error_free(g->migration_blocker);
> -    }
> +    migrate_del_blocker(&g->migration_blocker);
>   }
>   
>   static void
> diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
> index 1d58894..e0d9e51 100644
> --- a/hw/intc/arm_gic_kvm.c
> +++ b/hw/intc/arm_gic_kvm.c
> @@ -516,8 +516,7 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
>       if (!kvm_arm_gic_can_save_restore(s)) {
>           error_setg(&s->migration_blocker, "This operating system kernel does "
>                                             "not support vGICv2 migration");
> -        if (migrate_add_blocker(s->migration_blocker, errp) < 0) {
> -            error_free(s->migration_blocker);
> +        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
>               return;
>           }
>       }
> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
> index 7eda9fb..61c1cc7 100644
> --- a/hw/intc/arm_gicv3_its_kvm.c
> +++ b/hw/intc/arm_gicv3_its_kvm.c
> @@ -114,8 +114,7 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
>           GITS_CTLR)) {
>           error_setg(&s->migration_blocker, "This operating system kernel "
>                      "does not support vITS migration");
> -        if (migrate_add_blocker(s->migration_blocker, errp) < 0) {
> -            error_free(s->migration_blocker);
> +        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
>               return;
>           }
>       } else {
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 72ad916..77eb37e 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -878,8 +878,7 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>                                  GICD_CTLR)) {
>           error_setg(&s->migration_blocker, "This operating system kernel does "
>                                             "not support vGICv3 migration");
> -        if (migrate_add_blocker(s->migration_blocker, errp) < 0) {
> -            error_free(s->migration_blocker);
> +        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
>               return;
>           }
>       }
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index d66d912..0447888 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -903,8 +903,7 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
>       if (!ivshmem_is_master(s)) {
>           error_setg(&s->migration_blocker,
>                      "Migration is disabled when using feature 'peer mode' in device 'ivshmem'");
> -        if (migrate_add_blocker(s->migration_blocker, errp) < 0) {
> -            error_free(s->migration_blocker);
> +        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
>               return;
>           }
>       }
> @@ -922,10 +921,7 @@ static void ivshmem_exit(PCIDevice *dev)
>       IVShmemState *s = IVSHMEM_COMMON(dev);
>       int i;
>   
> -    if (s->migration_blocker) {
> -        migrate_del_blocker(s->migration_blocker);
> -        error_free(s->migration_blocker);
> -    }
> +    migrate_del_blocker(&s->migration_blocker);
>   
>       if (memory_region_is_mapped(s->ivshmem_bar2)) {
>           if (!s->hostmem) {
> diff --git a/hw/ppc/pef.c b/hw/ppc/pef.c
> index cc44d5e..d28ed3b 100644
> --- a/hw/ppc/pef.c
> +++ b/hw/ppc/pef.c
> @@ -63,7 +63,7 @@ static int kvmppc_svm_init(ConfidentialGuestSupport *cgs, Error **errp)
>       /* add migration blocker */
>       error_setg(&pef_mig_blocker, "PEF: Migration is not implemented");
>       /* NB: This can fail if --only-migratable is used */
> -    migrate_add_blocker(pef_mig_blocker, &error_fatal);
> +    migrate_add_blocker(&pef_mig_blocker, &error_fatal);
>   
>       cgs->ready = true;
>   
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 54dbfd7..161c6d3 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1728,7 +1728,7 @@ static void spapr_machine_reset(MachineState *machine, ShutdownCause reason)
>       /* Signal all vCPUs waiting on this condition */
>       qemu_cond_broadcast(&spapr->fwnmi_machine_check_interlock_cond);
>   
> -    migrate_del_blocker(spapr->fwnmi_migration_blocker);
> +    migrate_del_blocker(&spapr->fwnmi_migration_blocker);
>   }
>   
>   static void spapr_create_nvram(SpaprMachineState *spapr)
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 4508e40..c1b7bb9 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -920,7 +920,7 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>        * fails when running with -only-migrate.  A proper interface to
>        * delay migration completion for a bit could avoid that.
>        */
> -    ret = migrate_add_blocker(spapr->fwnmi_migration_blocker, NULL);
> +    ret = migrate_add_blocker(&spapr->fwnmi_migration_blocker, NULL);
>       if (ret == -EBUSY) {
>           warn_report("Received a fwnmi while migration was in progress");
>       }
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 7df2158..26c384b 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -496,7 +496,7 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>       spapr->fwnmi_machine_check_interlock = -1;
>       qemu_cond_signal(&spapr->fwnmi_machine_check_interlock_cond);
>       rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> -    migrate_del_blocker(spapr->fwnmi_migration_blocker);
> +    migrate_del_blocker(&spapr->fwnmi_migration_blocker);
>   }
>   
>   static struct rtas_call {
> diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
> index 2052d72..fbc85a8 100644
> --- a/hw/remote/proxy.c
> +++ b/hw/remote/proxy.c
> @@ -107,8 +107,7 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
>   
>       error_setg(&dev->migration_blocker, "%s does not support migration",
>                  TYPE_PCI_PROXY_DEV);
> -    if (migrate_add_blocker(dev->migration_blocker, errp) < 0) {
> -        error_free(dev->migration_blocker);
> +    if (migrate_add_blocker(&dev->migration_blocker, errp) < 0) {
>           object_unref(dev->ioc);
>           return;
>       }
> @@ -134,9 +133,7 @@ static void pci_proxy_dev_exit(PCIDevice *pdev)
>           qio_channel_close(dev->ioc, NULL);
>       }
>   
> -    migrate_del_blocker(dev->migration_blocker);
> -
> -    error_free(dev->migration_blocker);
> +    migrate_del_blocker(&dev->migration_blocker);
>   
>       proxy_memory_listener_deconfigure(&dev->proxy_listener);
>   
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 2dece8e..7e89fb3 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -335,8 +335,7 @@ static void s390_machine_unprotect(S390CcwMachineState *ms)
>           s390_pv_vm_disable();
>       }
>       ms->pv = false;
> -    migrate_del_blocker(pv_mig_blocker);
> -    error_free_or_abort(&pv_mig_blocker);
> +    migrate_del_blocker(&pv_mig_blocker);
>       ram_block_discard_disable(false);
>   }
>   
> @@ -359,11 +358,10 @@ static int s390_machine_protect(S390CcwMachineState *ms)
>   
>       error_setg(&pv_mig_blocker,
>                  "protected VMs are currently not migratable.");
> -    rc = migrate_add_blocker(pv_mig_blocker, &local_err);
> +    rc = migrate_add_blocker(&pv_mig_blocker, &local_err);
>       if (rc) {
>           ram_block_discard_disable(false);
>           error_report_err(local_err);
> -        error_free_or_abort(&pv_mig_blocker);
>           return rc;
>       }
>   
> @@ -371,8 +369,7 @@ static int s390_machine_protect(S390CcwMachineState *ms)
>       rc = s390_pv_vm_enable();
>       if (rc) {
>           ram_block_discard_disable(false);
> -        migrate_del_blocker(pv_mig_blocker);
> -        error_free_or_abort(&pv_mig_blocker);
> +        migrate_del_blocker(&pv_mig_blocker);
>           return rc;
>       }
>   
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index 443f67d..14e23cc 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -208,7 +208,7 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
>                   "When external environment supports it (Orchestrator migrates "
>                   "target SCSI device state or use shared storage over network), "
>                   "set 'migratable' property to true to enable migration.");
> -        if (migrate_add_blocker(vsc->migration_blocker, errp) < 0) {
> +        if (migrate_add_blocker(&vsc->migration_blocker, errp) < 0) {
>               goto free_virtio;
>           }
>       }
> @@ -241,10 +241,9 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
>    free_vqs:
>       g_free(vqs);
>       if (!vsc->migratable) {
> -        migrate_del_blocker(vsc->migration_blocker);
> +        migrate_del_blocker(&vsc->migration_blocker);
>       }
>    free_virtio:
> -    error_free(vsc->migration_blocker);
>       virtio_scsi_common_unrealize(dev);
>    close_fd:
>       if (vhostfd >= 0) {
> @@ -260,8 +259,7 @@ static void vhost_scsi_unrealize(DeviceState *dev)
>       struct vhost_virtqueue *vqs = vsc->dev.vqs;
>   
>       if (!vsc->migratable) {
> -        migrate_del_blocker(vsc->migration_blocker);
> -        error_free(vsc->migration_blocker);
> +        migrate_del_blocker(&vsc->migration_blocker);
>       }
>   
>       /* This will stop vhost backend. */
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 77e2ee0..5493282 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -383,8 +383,6 @@ static unsigned int vfio_migratable_device_num(void)
>   
>   int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>   {
> -    int ret;
> -
>       if (multiple_devices_migration_blocker ||
>           vfio_migratable_device_num() <= 1) {
>           return 0;
> @@ -399,13 +397,8 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>       error_setg(&multiple_devices_migration_blocker,
>                  "Migration is currently not supported with multiple "
>                  "VFIO devices");
> -    ret = migrate_add_blocker(multiple_devices_migration_blocker, errp);
> -    if (ret < 0) {
> -        error_free(multiple_devices_migration_blocker);
> -        multiple_devices_migration_blocker = NULL;
> -    }
>   
> -    return ret;
> +    return migrate_add_blocker(&multiple_devices_migration_blocker, errp);
>   }
>   
>   void vfio_unblock_multiple_devices_migration(void)
> @@ -415,9 +408,7 @@ void vfio_unblock_multiple_devices_migration(void)
>           return;
>       }
>   
> -    migrate_del_blocker(multiple_devices_migration_blocker);
> -    error_free(multiple_devices_migration_blocker);
> -    multiple_devices_migration_blocker = NULL;
> +    migrate_del_blocker(&multiple_devices_migration_blocker);
>   }
>   
>   static bool vfio_viommu_preset(void)
> @@ -435,8 +426,6 @@ static bool vfio_viommu_preset(void)
>   
>   int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp)
>   {
> -    int ret;
> -
>       if (giommu_migration_blocker ||
>           !vfio_viommu_preset()) {
>           return 0;
> @@ -450,13 +439,8 @@ int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp)
>   
>       error_setg(&giommu_migration_blocker,
>                  "Migration is currently not supported with vIOMMU enabled");
> -    ret = migrate_add_blocker(giommu_migration_blocker, errp);
> -    if (ret < 0) {
> -        error_free(giommu_migration_blocker);
> -        giommu_migration_blocker = NULL;
> -    }
>   
> -    return ret;
> +    return migrate_add_blocker(&giommu_migration_blocker, errp);
>   }
>   
>   void vfio_migration_finalize(void)
> @@ -466,9 +450,7 @@ void vfio_migration_finalize(void)
>           return;
>       }
>   
> -    migrate_del_blocker(giommu_migration_blocker);
> -    error_free(giommu_migration_blocker);
> -    giommu_migration_blocker = NULL;
> +    migrate_del_blocker(&giommu_migration_blocker);
>   }
>   
>   static void vfio_set_migration_error(int err)
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 1db7d52..04f0aa3 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -804,8 +804,6 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>   
>   static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>   {
> -    int ret;
> -
>       if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
>           error_propagate(errp, err);
>           return -EINVAL;
> @@ -814,13 +812,7 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>       vbasedev->migration_blocker = error_copy(err);
>       error_free(err);
>   
> -    ret = migrate_add_blocker(vbasedev->migration_blocker, errp);
> -    if (ret < 0) {
> -        error_free(vbasedev->migration_blocker);
> -        vbasedev->migration_blocker = NULL;
> -    }
> -
> -    return ret;
> +    return migrate_add_blocker(&vbasedev->migration_blocker, errp);
>   }
>   
>   /* ---------------------------------------------------------------------- */
> @@ -899,9 +891,5 @@ void vfio_migration_exit(VFIODevice *vbasedev)
>           vfio_unblock_multiple_devices_migration();
>       }
>   
> -    if (vbasedev->migration_blocker) {
> -        migrate_del_blocker(vbasedev->migration_blocker);
> -        error_free(vbasedev->migration_blocker);
> -        vbasedev->migration_blocker = NULL;
> -    }
> +    migrate_del_blocker(&vbasedev->migration_blocker);
>   }
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 8239433..6397bd2 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1464,9 +1464,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>       }
>   
>       if (hdev->migration_blocker != NULL) {
> -        r = migrate_add_blocker(hdev->migration_blocker, errp);
> +        r = migrate_add_blocker(&hdev->migration_blocker, errp);
>           if (r < 0) {
> -            error_free(hdev->migration_blocker);
>               goto fail_busyloop;
>           }
>       }
> @@ -1516,10 +1515,7 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
>           memory_listener_unregister(&hdev->memory_listener);
>           QLIST_REMOVE(hdev, entry);
>       }
> -    if (hdev->migration_blocker) {
> -        migrate_del_blocker(hdev->migration_blocker);
> -        error_free(hdev->migration_blocker);
> -    }
> +    migrate_del_blocker(&hdev->migration_blocker);
>       g_free(hdev->mem);
>       g_free(hdev->mem_sections);
>       if (hdev->vhost_ops) {
> diff --git a/include/migration/blocker.h b/include/migration/blocker.h
> index 9cebe2b..b048f30 100644
> --- a/include/migration/blocker.h
> +++ b/include/migration/blocker.h
> @@ -17,19 +17,23 @@
>   /**
>    * @migrate_add_blocker - prevent migration from proceeding
>    *
> - * @reason - an error to be returned whenever migration is attempted
> + * @reasonp - address of an error to be returned whenever migration is attempted
>    *
>    * @errp - [out] The reason (if any) we cannot block migration right now.
>    *
>    * @returns - 0 on success, -EBUSY/-EACCES on failure, with errp set.
> + *
> + * *@reasonp is freed and set to NULL if failure is returned.
> + * On success, the caller must not free @reasonp, except by
> + *   calling migrate_del_blocker.
>    */
> -int migrate_add_blocker(Error *reason, Error **errp);
> +int migrate_add_blocker(Error **reasonp, Error **errp);
>   
>   /**
>    * @migrate_add_blocker_internal - prevent migration from proceeding without
>    *                                 only-migrate implications
>    *
> - * @reason - an error to be returned whenever migration is attempted
> + * @reasonp - address of an error to be returned whenever migration is attempted
>    *
>    * @errp - [out] The reason (if any) we cannot block migration right now.
>    *
> @@ -38,14 +42,20 @@ int migrate_add_blocker(Error *reason, Error **errp);
>    * Some of the migration blockers can be temporary (e.g., for a few seconds),
>    * so it shouldn't need to conflict with "-only-migratable".  For those cases,
>    * we can call this function rather than @migrate_add_blocker().
> + *
> + * *@reasonp is freed and set to NULL if failure is returned.
> + * On success, the caller must not free @reasonp, except by
> + *   calling migrate_del_blocker.
>    */
> -int migrate_add_blocker_internal(Error *reason, Error **errp);
> +int migrate_add_blocker_internal(Error **reasonp, Error **errp);
>   
>   /**
> - * @migrate_del_blocker - remove a blocking error from migration
> + * @migrate_del_blocker - remove a blocking error from migration and free it.
>    *
> - * @reason - the error blocking migration
> + * @reasonp - address of the error blocking migration
> + *
> + * This function frees *@reasonp and sets it to NULL.
>    */
> -void migrate_del_blocker(Error *reason);
> +void migrate_del_blocker(Error **reasonp);
>   
>   #endif
> diff --git a/migration/migration.c b/migration/migration.c
> index c612ec1..ec80966 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1417,35 +1417,41 @@ void migrate_init(MigrationState *s)
>       s->switchover_acked = false;
>   }
>   
> -int migrate_add_blocker_internal(Error *reason, Error **errp)
> +int migrate_add_blocker_internal(Error **reasonp, Error **errp)
>   {
>       /* Snapshots are similar to migrations, so check RUN_STATE_SAVE_VM too. */
>       if (runstate_check(RUN_STATE_SAVE_VM) || !migration_is_idle()) {
> -        error_propagate_prepend(errp, error_copy(reason),
> +        error_propagate_prepend(errp, *reasonp,
>                                   "disallowing migration blocker "
>                                   "(migration/snapshot in progress) for: ");
> +        *reasonp = NULL;
>           return -EBUSY;
>       }
>   
> -    migration_blockers = g_slist_prepend(migration_blockers, reason);
> +    migration_blockers = g_slist_prepend(migration_blockers, *reasonp);
>       return 0;
>   }
>   
> -int migrate_add_blocker(Error *reason, Error **errp)
> +int migrate_add_blocker(Error **reasonp, Error **errp)
>   {
>       if (only_migratable) {
> -        error_propagate_prepend(errp, error_copy(reason),
> +        error_propagate_prepend(errp, *reasonp,
>                                   "disallowing migration blocker "
>                                   "(--only-migratable) for: ");
> +        *reasonp = NULL;
>           return -EACCES;
>       }
>   
> -    return migrate_add_blocker_internal(reason, errp);
> +    return migrate_add_blocker_internal(reasonp, errp);
>   }
>   
> -void migrate_del_blocker(Error *reason)
> +void migrate_del_blocker(Error **reasonp)
>   {
> -    migration_blockers = g_slist_remove(migration_blockers, reason);
> +    if (*reasonp) {
> +        migration_blockers = g_slist_remove(migration_blockers, *reasonp);
> +        error_free(*reasonp);
> +        *reasonp = NULL;
> +    }
>   }
>   
>   void qmp_migrate_incoming(const char *uri, Error **errp)
> diff --git a/stubs/migr-blocker.c b/stubs/migr-blocker.c
> index 5676a2f..17a5dbf 100644
> --- a/stubs/migr-blocker.c
> +++ b/stubs/migr-blocker.c
> @@ -1,11 +1,11 @@
>   #include "qemu/osdep.h"
>   #include "migration/blocker.h"
>   
> -int migrate_add_blocker(Error *reason, Error **errp)
> +int migrate_add_blocker(Error **reasonp, Error **errp)
>   {
>       return 0;
>   }
>   
> -void migrate_del_blocker(Error *reason)
> +void migrate_del_blocker(Error **reasonp)
>   {
>   }
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index de53184..352ec68 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1597,7 +1597,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
>           error_setg(&hv_passthrough_mig_blocker,
>                      "'hv-passthrough' CPU flag prevents migration, use explicit"
>                      " set of hv-* flags instead");
> -        ret = migrate_add_blocker(hv_passthrough_mig_blocker, &local_err);
> +        ret = migrate_add_blocker(&hv_passthrough_mig_blocker, &local_err);
>           if (ret < 0) {
>               error_report_err(local_err);
>               return ret;
> @@ -1611,7 +1611,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
>                      " use explicit 'hv-no-nonarch-coresharing=on' instead (but"
>                      " make sure SMT is disabled and/or that vCPUs are properly"
>                      " pinned)");
> -        ret = migrate_add_blocker(hv_no_nonarch_cs_mig_blocker, &local_err);
> +        ret = migrate_add_blocker(&hv_no_nonarch_cs_mig_blocker, &local_err);
>           if (ret < 0) {
>               error_report_err(local_err);
>               return ret;
> @@ -2207,7 +2207,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>               error_setg(&invtsc_mig_blocker,
>                          "State blocked by non-migratable CPU device"
>                          " (invtsc flag)");
> -            r = migrate_add_blocker(invtsc_mig_blocker, &local_err);
> +            r = migrate_add_blocker(&invtsc_mig_blocker, &local_err);
>               if (r < 0) {
>                   error_report_err(local_err);
>                   return r;
> @@ -2265,7 +2265,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>       return 0;
>   
>    fail:
> -    migrate_del_blocker(invtsc_mig_blocker);
> +    migrate_del_blocker(&invtsc_mig_blocker);
>   
>       return r;
>   }
> diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
> index 066a173..6943257 100644
> --- a/target/i386/nvmm/nvmm-all.c
> +++ b/target/i386/nvmm/nvmm-all.c
> @@ -929,9 +929,8 @@ nvmm_init_vcpu(CPUState *cpu)
>           error_setg(&nvmm_migration_blocker,
>               "NVMM: Migration not supported");
>   
> -        if (migrate_add_blocker(nvmm_migration_blocker, &local_error) < 0) {
> +        if (migrate_add_blocker(&nvmm_migration_blocker, &local_error) < 0) {
>               error_report_err(local_error);
> -            error_free(nvmm_migration_blocker);
>               return -EINVAL;
>           }
>       }
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index fe2144c..9a71246 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -891,7 +891,7 @@ sev_launch_finish(SevGuestState *sev)
>       /* add migration blocker */
>       error_setg(&sev_mig_blocker,
>                  "SEV: Migration is not implemented");
> -    migrate_add_blocker(sev_mig_blocker, &error_fatal);
> +    migrate_add_blocker(&sev_mig_blocker, &error_fatal);
>   }
>   
>   static void
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index 3de0dc1..2527396 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -2160,9 +2160,8 @@ int whpx_init_vcpu(CPUState *cpu)
>                  "State blocked due to non-migratable CPUID feature support,"
>                  "dirty memory tracking support, and XSAVE/XRSTOR support");
>   
> -        if (migrate_add_blocker(whpx_migration_blocker, &local_error) < 0) {
> +        if (migrate_add_blocker(&whpx_migration_blocker, &local_error) < 0) {
>               error_report_err(local_error);
> -            error_free(whpx_migration_blocker);
>               ret = -EINVAL;
>               goto error;
>           }
> diff --git a/ui/vdagent.c b/ui/vdagent.c
> index 8a65149..07c8060 100644
> --- a/ui/vdagent.c
> +++ b/ui/vdagent.c
> @@ -671,7 +671,7 @@ static void vdagent_chr_open(Chardev *chr,
>       return;
>   #endif
>   
> -    if (migrate_add_blocker(vd->migration_blocker, errp) != 0) {
> +    if (migrate_add_blocker(&vd->migration_blocker, errp) != 0) {
>           return;
>       }
>   
> @@ -921,10 +921,9 @@ static void vdagent_chr_fini(Object *obj)
>   {
>       VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(obj);
>   
> -    migrate_del_blocker(vd->migration_blocker);
> +    migrate_del_blocker(&vd->migration_blocker);
>       vdagent_disconnect(vd);
>       buffer_free(&vd->outbuf);
> -    error_free(vd->migration_blocker);
>   }
>   
>   static const TypeInfo vdagent_chr_type_info = {

