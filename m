Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C93A732BED
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 11:37:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA5s4-0007NT-Ia; Fri, 16 Jun 2023 05:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1qA5s2-0007NI-M7
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 05:35:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1qA5s0-0002aV-FH
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 05:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686908151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q8l9L24y2xVRrnIdArlLU3tmjEcJDi2B2DRB6z45nFQ=;
 b=KyEjcBeq1eRDmsGK6Z8ReBH77gxckBG2zQb1xQANcpNPp6KcLU8ug/a9UQzAdohNPflPO+
 dQ+kBf39q8PIT/hsr5HASA3E5fid+mN9X5o81ykZm7yXQ/g+JrWsLnZS8tsGNGmQW/zhaO
 wxsMNrrxywrOqv2bWmTIIehkMg0wi/0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-wcalj8lYNlOkc7v7VxzfOw-1; Fri, 16 Jun 2023 05:35:48 -0400
X-MC-Unique: wcalj8lYNlOkc7v7VxzfOw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4ec790b902bso405516e87.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jun 2023 02:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686908147; x=1689500147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q8l9L24y2xVRrnIdArlLU3tmjEcJDi2B2DRB6z45nFQ=;
 b=hX/4jQGkHJd2PMOpnOge53/gXhOJmLYr3o4WCY0wYhWA8+qBxEPfFoBRHLTMWmbHDA
 xtXR2Ns6k09VNEnB29r0Ygua4gAb4YDJN0vPxoLbC52c3J2+tROs4Pv4wccjlCLeMNdO
 17nlgYEsKXwfCTTdOoLYYVJ0PaEDfBzW+6GV+LiMTcIVZDhnUy9bdnKU1ZZxnMKi6f6L
 QavDLY07US/PIxFVcBLUMmgNFPv0+9iqQcB8KmafuB10yJQ+YEZtSAE9q2ypof6czAny
 g4tz/riTFs453CIt35HRcmhNC1G+J/B404vKG9GXqY9F2qwF6XP2j5QCJL1dmOhNs/DZ
 Zwhw==
X-Gm-Message-State: AC+VfDxS4aKPR1o9kht+owAGdVtOlPDjigZM2hs4U/o7B/fVsW5CrvcH
 VlZ5PiRdK/Ssk7odnhs3A5n4BVLzyjZn9keg3qspNKfe8ZDbgoRe+yFpJegjxvxhh3qE8hSp13s
 QXo0VcGRwQqBs82TT3peVG35B/Bmgy3s=
X-Received: by 2002:a19:6506:0:b0:4f7:6453:f3f1 with SMTP id
 z6-20020a196506000000b004f76453f3f1mr918190lfb.15.1686908147031; 
 Fri, 16 Jun 2023 02:35:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7vgd0qlpzGb7D32nEgCsWUn+1fYIcwa0oprbNe6wZQf+lcwY3veFDaMZ4MiNJPG6ZYzRnhRSSJIuBLYFyamBg=
X-Received: by 2002:a19:6506:0:b0:4f7:6453:f3f1 with SMTP id
 z6-20020a196506000000b004f76453f3f1mr918164lfb.15.1686908146629; Fri, 16 Jun
 2023 02:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230530144821.1557-1-avihaih@nvidia.com>
In-Reply-To: <20230530144821.1557-1-avihaih@nvidia.com>
From: YangHang Liu <yanghliu@redhat.com>
Date: Fri, 16 Jun 2023 17:35:35 +0800
Message-ID: <CAGYh1E-NjThfYg9M+z6o4ghM5J4C9EO_KA82bd2Ewhm2Vgf52w@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] migration: Add switchover ack capability and VFIO
 precopy support
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, 
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>, 
 Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yanghliu@redhat.com;
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

Tested-by: YangHang Liu <yanghliu@redhat.com>

On Wed, May 31, 2023 at 1:01=E2=80=AFAM Avihai Horon <avihaih@nvidia.com> w=
rote:
>
> Hello everyone,
>
> This is v5 of the switchover ack series.
>
> Changes from v4 [6]:
> * Removed superfluous '"' in vfio_save_iterate() trace. (Cedric)
> * Removed VFIOMigration->switchover_ack_needed and computed it locally
>   when needed. (Cedric)
> * Added R-bs.
>
> Changes from v3 [5]:
> * Rebased on latest master branch.
> * Simplified switchover ack logic (call switchover_ack_needed only in
>   destination). (Peter)
> * Moved caching of VFIO migration flags to a separate patch. (Cedric)
> * Moved adding of x-allow-pre-copy property to a separate patch. (Cedric)
> * Reset VFIOMigration->precopy_{init,dirty}_size in vfio_query_precopy_si=
ze()
>   and in vfio_save_cleanup(). (Cedric)
> * Added a reference to VFIO uAPI in vfio_save_block() ENOMSG comment. (Ce=
dric)
> * Added VFIOMigration->precopy_{init,dirty}_size to trace_vfio_save_itera=
te(). (Cedric)
> * Adapted VFIO migration to switchover ack logic simplification:
>   - Checked migrate_switchover_ack() in vfio_{save,load}_setup() and set
>     VFIOMigration->switchover_ack_needed accordingly.
>   - vfio_switchover_ack_needed() doesn't set VFIOMigration->switchover_ac=
k_needed
>     and only returns its value.
> * Move VFIOMigration->switchover_ack_needed =3D false to vfio_migration_c=
leanup()
>   so it will be set to false both in src and dest.
> * Fixed a few typos/coding style. (Peter/Cedric)
> * Added R-b/A-b (didn't add Cedric's R-b on patch #7 as switchover ack
>   changes in patch #2 introduced some changes to patch #7 as well).
>
> Changes from v2 [4]:
> * Rebased on latest master branch.
> * Changed the capability name to "switchover-ack" and the related
>   code/docs accordingly. (Peter)
> * Added a counter for the number of switchover ack users in the source
>   and used it to skip switchover ack if there are no users (instead of
>   setting the switchover acked flag to true). (Peter)
> * Added R-bs.
>
> Changes from v1 [3]:
> * Rebased on latest master branch.
> * Updated to latest QAPI doc comment conventions and refined
>   QAPI docs and capability error message. (Markus)
> * Followed Peter/Juan suggestion and removed the handshake between
>   source and destination.
>   Now the capability must be set on both source and destination.
>   Compatibility of this feature between different QEMU versions or
>   different host capabilities (i.e., kernel) is achieved in the regular
>   way of device properties and hw_comapt_x_y.
> * Replaced is_initial_data_active() and initial_data_loaded()
>   SaveVMHandlers handlers with a notification mechanism. (Peter)
> * Set the capability also in destination in the migration test.
> * Added VFIO device property x-allow-pre-copy to be able to preserve
>   compatibility between different QEMU versions or different host
>   capabilities (i.e., kernel).
> * Changed VFIO precopy initial data implementation according to the
>   above changes.
> * Documented VFIO precopy initial data support in VFIO migration
>   documentation.
> * Added R-bs.
>
> =3D=3D=3D
>
> This series adds a new migration capability called "switchover ack". The
> purpose of this capability is to reduce migration downtime in cases
> where loading of migration data in the destination can take a lot of
> time, such as with VFIO migration data.
>
> The series then moves to add precopy support and switchover ack support
> for VFIO migration.
>
> Switchover ack is used by VFIO migration, but other migrated devices can
> add support for it and use it as well.
>
> =3D=3D=3D Background =3D=3D=3D
>
> Migration downtime estimation is calculated based on bandwidth and
> remaining migration data. This assumes that loading of migration data in
> the destination takes a negligible amount of time and that downtime
> depends only on network speed.
>
> While this may be true for RAM, it's not necessarily true for other
> migrated devices. For example, loading the data of a VFIO device in the
> destination might require from the device to allocate resources and
> prepare internal data structures which can take a significant amount of
> time to do.
>
> This poses a problem, as the source may think that the remaining
> migration data is small enough to meet the downtime limit, so it will
> stop the VM and complete the migration, but in fact sending and loading
> the data in the destination may take longer than the downtime limit.
>
> To solve this, VFIO migration uAPI defines "initial bytes" as part of
> its precopy stream [1]. Initial bytes can be used in various ways to
> improve VFIO migration performance. For example, it can be used to
> transfer device metadata to pre-allocate resources in the destination.
> However, for this to work we need to make sure that all initial bytes
> are sent and loaded in the destination before the source VM is stopped.
>
> The new switchover ack migration capability helps us achieve this.
> It prevents the source from stopping the VM and completing the migration
> until an ACK is received from the destination that it's OK to do so.
> Thus, a VFIO device can make sure that its initial bytes were sent
> and loaded in the destination before the source VM is stopped.
>
> Note that this relies on the return path capability to communicate from
> the destination back to the source.
>
> =3D=3D=3D Flow of operation =3D=3D=3D
>
> To use switchover ack, the capability must be enabled in both the source
> and the destination.
>
> During migration setup, migration code in the destination calls the
> switchover_ack_needed() SaveVMHandlers handler of the migrated devices
> to check if switchover ack is used by them.
> A "switchover_ack_pending_num" counter is increased for each migrated
> device that supports this feature. It will be used later to mark when an
> ACK should be sent to the source.
>
> Migration is active and the source starts to send precopy data as usual.
> In the destination, when a migrated device thinks it's OK to do
> switchover, it notifies the migration code about it and the
> "switchover_ack_pending_num" counter is decreased. For example, for a
> VFIO device it's when the device receives and loads its initial bytes.
>
> When the "switchover_ack_pending_num" counter reaches zero, it means
> that all devices agree to do switchover and an ACK is sent to the
> source, which will now be able to complete the migration when
> appropriate.
>
> =3D=3D=3D Test results =3D=3D=3D
>
> The below table shows the downtime of two identical migrations. In the
> first migration swithcover ack is disabled and in the second it is
> enabled. The migrated VM is assigned with a mlx5 VFIO device which has
> 300MB of device data to be migrated.
>
> +----------------------+-----------------------+----------+
> |    Switchover ack    | VFIO device data size | Downtime |
> +----------------------+-----------------------+----------+
> |       Disabled       |         300MB         |  1900ms  |
> |       Enabled        |         300MB         |  420ms   |
> +----------------------+-----------------------+----------+
>
> Switchover ack gives a roughly 4.5 times improvement in downtime.
> The 1480ms difference is time that is used for resource allocation for
> the VFIO device in the destination. Without switchover ack, this time is
> spent when the source VM is stopped and thus the downtime is much
> higher. With switchover ack, the time is spent when the source VM is
> still running.
>
> =3D=3D=3D Patch breakdown =3D=3D=3D
>
> - Patches 1-4 add the switchover ack capability.
> - Patches 5-8 add VFIO migration precopy support. Similar version of
>   them was previously sent here [2].
> - Patch 9 adds switchover ack support for VFIO migration.
>
> Thanks for reviewing!
>
> [1]
> https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/vfio.h#=
L1048
>
> [2]
> https://lore.kernel.org/qemu-devel/20230222174915.5647-3-avihaih@nvidia.c=
om/
>
> [3]
> https://lore.kernel.org/qemu-devel/20230501140141.11743-1-avihaih@nvidia.=
com/
>
> [4]
> https://lore.kernel.org/qemu-devel/20230517155219.10691-1-avihaih@nvidia.=
com/
>
> [5]
> https://lore.kernel.org/qemu-devel/20230521151808.24804-1-avihaih@nvidia.=
com/
>
> [6]
> https://lore.kernel.org/qemu-devel/20230528140652.8693-1-avihaih@nvidia.c=
om/
>
> Avihai Horon (9):
>   migration: Add switchover ack capability
>   migration: Implement switchover ack logic
>   migration: Enable switchover ack capability
>   tests: Add migration switchover ack capability test
>   vfio/migration: Refactor vfio_save_block() to return saved data size
>   vfio/migration: Store VFIO migration flags in VFIOMigration
>   vfio/migration: Add VFIO migration pre-copy support
>   vfio/migration: Add x-allow-pre-copy VFIO device property
>   vfio/migration: Add support for switchover ack capability
>
>  docs/devel/vfio-migration.rst |  45 +++++--
>  qapi/migration.json           |  12 +-
>  include/hw/vfio/vfio-common.h |   5 +
>  include/migration/register.h  |   2 +
>  migration/migration.h         |  14 +++
>  migration/options.h           |   1 +
>  migration/savevm.h            |   1 +
>  hw/core/machine.c             |   1 +
>  hw/vfio/common.c              |   6 +-
>  hw/vfio/migration.c           | 221 +++++++++++++++++++++++++++++++---
>  hw/vfio/pci.c                 |   2 +
>  migration/migration.c         |  32 ++++-
>  migration/options.c           |  17 +++
>  migration/savevm.c            |  54 +++++++++
>  tests/qtest/migration-test.c  |  26 ++++
>  hw/vfio/trace-events          |   4 +-
>  migration/trace-events        |   3 +
>  17 files changed, 413 insertions(+), 33 deletions(-)
>
> --
> 2.26.3
>
>


