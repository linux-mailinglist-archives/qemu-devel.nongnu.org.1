Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C23752C3F
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:36:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3xu-0006rG-9q; Thu, 13 Jul 2023 17:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1qK3xs-0006r5-Cv
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:35:08 -0400
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1qK3xq-0000rM-46
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:35:08 -0400
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
 by mx0a-00190b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DInR3K006098; Thu, 13 Jul 2023 22:35:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=L7bWGKNnoO9kVrspMNT/Kp2EgilZ7TpFXnQGHVkPeJA=;
 b=lu5qRzOnksWb8D2ywVLZ6SNYvj/p+LxKSJyXsN8ownwosGs6ltqOfeZYlsPIhFZJpY2t
 ruiIEX1wPQJsmzisl1hu0NekUVMV/KKIycXzLF3yBlPQl+YSWYPNAsQZK1LXdmFW40a/
 yEd2JN8A6ZUg0EarrjJX8gO8eFugQc88pYQkrBY5zRZJiZX3h0nL0xxBgWgp8uFxIBd+
 1j9+5pZ5T9XPsYmYdfmBCkrUpUJMIQiDMox+D+zSq1vEw9Alc6zWjmAKNzMUBau/LQtT
 htaFStmN7QtJDKHONK+UBqpVPebAVt+o5pzCQRD7Ag3OKgY2ylNHU1wOJvuM7QWcif7h hw== 
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61]
 (may be forged))
 by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 3rtpvuun2h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 22:35:02 +0100
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
 by prod-mail-ppoint6.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DImaow001371; Thu, 13 Jul 2023 17:35:00 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
 by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 3rtpv60hwn-1;
 Thu, 13 Jul 2023 17:35:00 -0400
Received: from [172.19.65.70] (dfw-lpsukzs4.dfw02.corp.akamai.com
 [172.19.65.70])
 by prod-mail-relay10.akamai.com (Postfix) with ESMTP id A8A3E606A8;
 Thu, 13 Jul 2023 21:34:59 +0000 (GMT)
Message-ID: <cedaeab1-8497-41d6-3411-e0bb1ad54cee@akamai.com>
Date: Thu, 13 Jul 2023 16:34:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V3] migration: simplify notifiers
Content-Language: en-US
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <1686148954-250144-1-git-send-email-steven.sistare@oracle.com>
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <1686148954-250144-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_09,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307130189
X-Proofpoint-GUID: -QgMYx45wzaHlZ478MWTCDlB_O6qFmTe
X-Proofpoint-ORIG-GUID: -QgMYx45wzaHlZ478MWTCDlB_O6qFmTe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_10,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 priorityscore=1501
 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0 clxscore=1011
 mlxscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307130191
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


On 6/7/23 09:42, Steve Sistare wrote:
> Pass the callback function to add_migration_state_change_notifier so
> that migration can initialize the notifier on add and clear it on
> delete, which simplifies the call sites.  Shorten the function names
> so the extra arg can be added more legibly.  Hide the global notifier
> list in a new function migration_call_notifiers, and make it externally
> visible so future live update code can call it.
Tested-by: Michael Galaxy <mgalaxy@akamai.com>
Reviewed-by: Michael Galaxy <mgalaxy@akamai.com>
> No functional change.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/net/virtio-net.c      |  6 +++---
>   hw/vfio/migration.c      |  8 ++++----
>   include/migration/misc.h |  6 ++++--
>   migration/migration.c    | 22 ++++++++++++++++------
>   net/vhost-vdpa.c         |  7 ++++---
>   ui/spice-core.c          |  3 +--
>   6 files changed, 32 insertions(+), 20 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 6df6b73..c4dc795 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3605,8 +3605,8 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>           n->primary_listener.hide_device = failover_hide_primary_device;
>           qatomic_set(&n->failover_primary_hidden, true);
>           device_listener_register(&n->primary_listener);
> -        n->migration_state.notify = virtio_net_migration_state_notifier;
> -        add_migration_state_change_notifier(&n->migration_state);
> +        migration_add_notifier(&n->migration_state,
> +                               virtio_net_migration_state_notifier);
>           n->host_features |= (1ULL << VIRTIO_NET_F_STANDBY);
>       }
>   
> @@ -3769,7 +3769,7 @@ static void virtio_net_device_unrealize(DeviceState *dev)
>       if (n->failover) {
>           qobject_unref(n->primary_opts);
>           device_listener_unregister(&n->primary_listener);
> -        remove_migration_state_change_notifier(&n->migration_state);
> +        migration_remove_notifier(&n->migration_state);
>       } else {
>           assert(n->primary_opts == NULL);
>       }
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index c4656bb..8af0294 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -619,9 +619,9 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>       migration->vm_state = qdev_add_vm_change_state_handler(vbasedev->dev,
>                                                              vfio_vmstate_change,
>                                                              vbasedev);
> -    migration->migration_state.notify = vfio_migration_state_notifier;
> -    add_migration_state_change_notifier(&migration->migration_state);
> -
> +    migration_add_notifier(&migration->migration_state,
> +                           vfio_migration_state_notifier);
> +
>       return 0;
>   }
>   
> @@ -670,7 +670,7 @@ void vfio_migration_exit(VFIODevice *vbasedev)
>       if (vbasedev->migration) {
>           VFIOMigration *migration = vbasedev->migration;
>   
> -        remove_migration_state_change_notifier(&migration->migration_state);
> +        migration_remove_notifier(&migration->migration_state);
>           qemu_del_vm_change_state_handler(migration->vm_state);
>           unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
>           vfio_migration_free(vbasedev);
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 5ebe13b..0987eb1 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -59,8 +59,10 @@ void migration_object_init(void);
>   void migration_shutdown(void);
>   bool migration_is_idle(void);
>   bool migration_is_active(MigrationState *);
> -void add_migration_state_change_notifier(Notifier *notify);
> -void remove_migration_state_change_notifier(Notifier *notify);
> +void migration_add_notifier(Notifier *notify,
> +                            void (*func)(Notifier *notifier, void *data));
> +void migration_remove_notifier(Notifier *notify);
> +void migration_call_notifiers(MigrationState *s);
>   bool migration_in_setup(MigrationState *);
>   bool migration_has_finished(MigrationState *);
>   bool migration_has_failed(MigrationState *);
> diff --git a/migration/migration.c b/migration/migration.c
> index 5103e2f..17b4b47 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1178,7 +1178,7 @@ static void migrate_fd_cleanup(MigrationState *s)
>           /* It is used on info migrate.  We can't free it */
>           error_report_err(error_copy(s->error));
>       }
> -    notifier_list_notify(&migration_state_notifiers, s);
> +    migration_call_notifiers(s);
>       block_cleanup_parameters();
>       yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>   }
> @@ -1273,14 +1273,24 @@ static void migrate_fd_cancel(MigrationState *s)
>       }
>   }
>   
> -void add_migration_state_change_notifier(Notifier *notify)
> +void migration_add_notifier(Notifier *notify,
> +                            void (*func)(Notifier *notifier, void *data))
>   {
> +    notify->notify = func;
>       notifier_list_add(&migration_state_notifiers, notify);
>   }
>   
> -void remove_migration_state_change_notifier(Notifier *notify)
> +void migration_remove_notifier(Notifier *notify)
>   {
> -    notifier_remove(notify);
> +    if (notify->notify) {
> +        notifier_remove(notify);
> +        notify->notify = NULL;
> +    }
> +}
> +
> +void migration_call_notifiers(MigrationState *s)
> +{
> +    notifier_list_notify(&migration_state_notifiers, s);
>   }
>   
>   bool migration_in_setup(MigrationState *s)
> @@ -2191,7 +2201,7 @@ static int postcopy_start(MigrationState *ms)
>        * spice needs to trigger a transition now
>        */
>       ms->postcopy_after_devices = true;
> -    notifier_list_notify(&migration_state_notifiers, ms);
> +    migration_call_notifiers(ms);
>   
>       ms->downtime =  qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - time_at_stop;
>   
> @@ -3219,7 +3229,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>           rate_limit = migrate_max_bandwidth();
>   
>           /* Notify before starting migration thread */
> -        notifier_list_notify(&migration_state_notifiers, s);
> +        migration_call_notifiers(s);
>       }
>   
>       migration_rate_set(rate_limit);
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 37cdc84..1a4608b 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -297,7 +297,8 @@ static void vhost_vdpa_net_data_start_first(VhostVDPAState *s)
>   {
>       struct vhost_vdpa *v = &s->vhost_vdpa;
>   
> -    add_migration_state_change_notifier(&s->migration_state);
> +    migration_add_notifier(&s->migration_state,
> +                           vdpa_net_migration_state_notifier);
>       if (v->shadow_vqs_enabled) {
>           v->iova_tree = vhost_iova_tree_new(v->iova_range.first,
>                                              v->iova_range.last);
> @@ -341,7 +342,7 @@ static void vhost_vdpa_net_client_stop(NetClientState *nc)
>       assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
>   
>       if (s->vhost_vdpa.index == 0) {
> -        remove_migration_state_change_notifier(&s->migration_state);
> +        migration_remove_notifier(&s->migration_state);
>       }
>   
>       dev = s->vhost_vdpa.dev;
> @@ -818,7 +819,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
>       s->vhost_vdpa.device_fd = vdpa_device_fd;
>       s->vhost_vdpa.index = queue_pair_index;
>       s->always_svq = svq;
> -    s->migration_state.notify = vdpa_net_migration_state_notifier;
> +    s->migration_state.notify = NULL;
>       s->vhost_vdpa.shadow_vqs_enabled = svq;
>       s->vhost_vdpa.iova_range = iova_range;
>       s->vhost_vdpa.shadow_data = svq;
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index 52a5938..db21db2 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -821,8 +821,7 @@ static void qemu_spice_init(void)
>       };
>       using_spice = 1;
>   
> -    migration_state.notify = migration_state_notifier;
> -    add_migration_state_change_notifier(&migration_state);
> +    migration_add_notifier(&migration_state, migration_state_notifier);
>       spice_migrate.base.sif = &migrate_interface.base;
>       qemu_spice.add_interface(&spice_migrate.base);
>   

