Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A63B1BFD8
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Aug 2025 07:18:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujWWq-0008Bp-Q1; Wed, 06 Aug 2025 01:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ujWWg-00089L-Su; Wed, 06 Aug 2025 01:17:23 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ujWWe-0004Vn-Ad; Wed, 06 Aug 2025 01:17:22 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5765H2ch024568
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 6 Aug 2025 14:17:02 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=nr7F4bDqTPjj4MsKPfw7eCxMK1HdFpR23wzwZj9/2Mw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754457422; v=1;
 b=CwwQwayXGyx167DwBkfFlpOmmd3lcujho4lT8BfzLb8lPKlj0MdV1f1NfmV5jHeB
 E31tCL136EuXHUfrUTCB3R+IM2c5O6DaTD1CN9h1qeURcuQeSChLb/O/41SobGrl
 VZgqrFb8eQ5Njv2M+6tB3+7/+Mt9p7HN1XE94ZLXluL10owknwKdslXsaC6mgVfp
 B8A07NAzc0nzizIPicHcCXNahS1lKCp6iFxG+AVL86Zx3bUtBpMGXBoOrikI/hzm
 a1k1GVMdkTdL7cqd7TXQhvBJ9Shn7CRDZ9SOi2qANZ8U9qi6dvsRDu2mKXoDdcwj
 WYpyhRfc+pJt9aBX+uBgXg==
Message-ID: <07eebc10-a6e0-4fb8-a364-09f026a4a342@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 6 Aug 2025 14:17:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/27] migration: push Error **errp into
 qemu_loadvm_state()
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-7-123450810db7@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250805-propagate_tpm_error-v9-7-123450810db7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/08/06 3:25, Arun Menon wrote:
> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that qemu_loadvm_state() must report an error
> in errp, in case of failure.
> 
> When postcopy live migration runs, the device states are loaded by
> both the qemu coroutine process_incoming_migration_co() and the
> postcopy_ram_listen_thread(). Therefore, it is important that the
> coroutine also reports the error in case of failure, with
> error_report_err(). Otherwise, the source qemu will not display
> any errors before going into the postcopy pause state.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   migration/migration.c |  7 ++++---
>   migration/savevm.c    | 31 +++++++++++++++++++------------
>   migration/savevm.h    |  2 +-
>   3 files changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 10c216d25dec01f206eacad2edd24d21f00e614c..bb7d5e1dee52692cbea1d2c8fdca541e6a75bedb 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -881,7 +881,7 @@ process_incoming_migration_co(void *opaque)
>                         MIGRATION_STATUS_ACTIVE);
>   
>       mis->loadvm_co = qemu_coroutine_self();
> -    ret = qemu_loadvm_state(mis->from_src_file);
> +    ret = qemu_loadvm_state(mis->from_src_file, &local_err);
>       mis->loadvm_co = NULL;
>   
>       trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
> @@ -908,7 +908,8 @@ process_incoming_migration_co(void *opaque)
>       }
>   
>       if (ret < 0) {
> -        error_setg(&local_err, "load of migration failed: %s", strerror(-ret));
> +        error_prepend(&local_err, "load of migration failed: %s: ",
> +                      strerror(-ret));
>           goto fail;
>       }
>   
> @@ -924,7 +925,7 @@ fail:
>       migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                         MIGRATION_STATUS_FAILED);
>       migrate_set_error(s, local_err);
> -    error_free(local_err);
> +    error_report_err(local_err);

There is "error_report_err(s->error)" after this so this can result in 
duplicate error printing.

>   
>       migration_incoming_state_destroy();
>   
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 1bd27efe437d4d911728d776e995490d0a45dcf5..ca166ebd397ad80836ed2f9cb20a92f704fd4ed5 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3149,28 +3149,24 @@ out:
>       return ret;
>   }
>   
> -int qemu_loadvm_state(QEMUFile *f)
> +int qemu_loadvm_state(QEMUFile *f, Error **errp)
>   {
>       MigrationState *s = migrate_get_current();
>       MigrationIncomingState *mis = migration_incoming_get_current();
> -    Error *local_err = NULL;
>       int ret;
>   
> -    if (qemu_savevm_state_blocked(&local_err)) {
> -        error_report_err(local_err);
> +    if (qemu_savevm_state_blocked(errp)) {
>           return -EINVAL;
>       }
>   
>       qemu_loadvm_thread_pool_create(mis);
>   
> -    ret = qemu_loadvm_state_header(f, &local_err);
> +    ret = qemu_loadvm_state_header(f, errp);
>       if (ret) {
> -        error_report_err(local_err);
>           return ret;
>       }
>   
> -    if (qemu_loadvm_state_setup(f, &local_err) != 0) {
> -        error_report_err(local_err);
> +    if (qemu_loadvm_state_setup(f, errp) != 0) {
>           return -EINVAL;
>       }
>   
> @@ -3181,6 +3177,9 @@ int qemu_loadvm_state(QEMUFile *f)
>       cpu_synchronize_all_pre_loadvm();
>   
>       ret = qemu_loadvm_state_main(f, mis);
> +    if (ret < 0) {
> +        error_setg(errp, "Load VM state failed: %d", ret);
> +    }
>       qemu_event_set(&mis->main_thread_load_event);
>   
>       trace_qemu_loadvm_state_post_main(ret);
> @@ -3198,8 +3197,14 @@ int qemu_loadvm_state(QEMUFile *f)
>           if (migrate_has_error(migrate_get_current()) ||
>               !qemu_loadvm_thread_pool_wait(s, mis)) {
>               ret = -EINVAL;
> +            error_setg(errp,
> +                       "Error while loading VM state: "
> +                       "Migration stream has error");
>           } else {
>               ret = qemu_file_get_error(f);
> +            if (ret < 0) {
> +                error_setg(errp, "Error while loading vmstate : %d", ret);
> +            }
>           }
>       }
>       /*
> @@ -3464,6 +3469,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
>   
>   void qmp_xen_load_devices_state(const char *filename, Error **errp)
>   {
> +    ERRP_GUARD();
>       QEMUFile *f;
>       QIOChannelFile *ioc;
>       int ret;
> @@ -3485,10 +3491,10 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
>       f = qemu_file_new_input(QIO_CHANNEL(ioc));
>       object_unref(OBJECT(ioc));
>   
> -    ret = qemu_loadvm_state(f);
> +    ret = qemu_loadvm_state(f, errp);
>       qemu_fclose(f);
>       if (ret < 0) {
> -        error_setg(errp, "loading Xen device state failed");
> +        error_prepend(errp, "loading Xen device state failed: ");
>       }
>       migration_incoming_state_destroy();
>   }
> @@ -3496,6 +3502,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
>   bool load_snapshot(const char *name, const char *vmstate,
>                      bool has_devices, strList *devices, Error **errp)
>   {
> +    ERRP_GUARD();
>       BlockDriverState *bs_vm_state;
>       QEMUSnapshotInfo sn;
>       QEMUFile *f;
> @@ -3559,13 +3566,13 @@ bool load_snapshot(const char *name, const char *vmstate,
>           ret = -EINVAL;
>           goto err_drain;
>       }
> -    ret = qemu_loadvm_state(f);
> +    ret = qemu_loadvm_state(f, errp);
>       migration_incoming_state_destroy();
>   
>       bdrv_drain_all_end();
>   
>       if (ret < 0) {
> -        error_setg(errp, "Error %d while loading VM state", ret);
> +        error_prepend(errp, "Error %d while loading VM state: ", ret);
>           return false;
>       }
>   
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 2d5e9c716686f06720325e82fe90c75335ced1de..b80770b7461a60e2ad6ba5e24a7baeae73d90955 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -64,7 +64,7 @@ void qemu_savevm_send_colo_enable(QEMUFile *f);
>   void qemu_savevm_live_state(QEMUFile *f);
>   int qemu_save_device_state(QEMUFile *f);
>   
> -int qemu_loadvm_state(QEMUFile *f);
> +int qemu_loadvm_state(QEMUFile *f, Error **errp);
>   void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
>   int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
>   int qemu_load_device_state(QEMUFile *f);
> 


