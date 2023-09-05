Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 343AB7921A4
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 11:47:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdSdy-0005mM-1P; Tue, 05 Sep 2023 05:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1qdSdr-0005lp-Cv
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:46:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1qdSdn-0002d0-4n
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:46:39 -0400
Received: from lhrpeml100002.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rg0wj1fY4z6D8rK;
 Tue,  5 Sep 2023 17:45:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml100002.china.huawei.com (7.191.160.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 5 Sep 2023 10:46:28 +0100
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.031; 
 Tue, 5 Sep 2023 10:46:28 +0100
To: Dov Murik <dovmurik@linux.ibm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra
 <ashish.kalra@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Steve Rutherford <srutherford@google.com>, "James
 Bottomley" <jejb@linux.ibm.com>, Juan Quintela <quintela@redhat.com>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>, Hubertus Franke
 <frankeh@us.ibm.com>, Tobin Feldman-Fitzthum <tobin@linux.ibm.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>
Subject: RE: [RFC PATCH v2 00/12] Confidential guest-assisted live migration
Thread-Topic: [RFC PATCH v2 00/12] Confidential guest-assisted live migration
Thread-Index: AQHXmCrdmtYNxw+JD0qvlDM8Ae9oHLAQhwYg
Date: Tue, 5 Sep 2023 09:46:28 +0000
Message-ID: <5d02265589dd4b0a9072fc29b53a096a@huawei.com>
References: <20210823141636.65975-1-dovmurik@linux.ibm.com>
In-Reply-To: <20210823141636.65975-1-dovmurik@linux.ibm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


> -----Original Message-----
> From: Qemu-devel
> [mailto:qemu-devel-bounces+shameerali.kolothum.thodi=3Dhuawei.com@nong
> nu.org] On Behalf Of Dov Murik
> Sent: 23 August 2021 15:16
> To: qemu-devel@nongnu.org
> Cc: Tom Lendacky <thomas.lendacky@amd.com>; Ashish Kalra
> <ashish.kalra@amd.com>; Brijesh Singh <brijesh.singh@amd.com>; Michael
> S. Tsirkin <mst@redhat.com>; Steve Rutherford <srutherford@google.com>;
> James Bottomley <jejb@linux.ibm.com>; Juan Quintela
> <quintela@redhat.com>; Dr. David Alan Gilbert <dgilbert@redhat.com>; Dov
> Murik <dovmurik@linux.ibm.com>; Hubertus Franke <frankeh@us.ibm.com>;
> Tobin Feldman-Fitzthum <tobin@linux.ibm.com>; Paolo Bonzini
> <pbonzini@redhat.com>
> Subject: [RFC PATCH v2 00/12] Confidential guest-assisted live migration
>=20
> This is an RFC series for fast migration of confidential guests using an
> in-guest migration helper that lives in OVMF.  QEMU VM live migration
> needs to read source VM's RAM and write it in the target VM; this
> mechanism doesn't work when the guest memory is encrypted or QEMU is
> prevented from reading it in another way.  In order to support live
> migration in such scenarios, we introduce an in-guest migration helper
> which can securely extract RAM content from the guest in order to send
> it to the target.  The migration helper is implemented as part of the
> VM's firmware in OVMF.
>=20
> We've implemented and tested this on AMD SEV, but expect most of the
> processes can be used with other technologies that prevent direct access
> of hypervisor to the guest's memory.  Specifically, we don't use SEV's
> PSP migration commands (SEV_SEND_START, SEV_RECEIVE_START, etc) at all;
> but note that the mirror VM relies on
> KVM_CAP_VM_COPY_ENC_CONTEXT_FROM
> to shared the SEV ASID with the main VM.

Hi Dov,

Sorry if I missed out, but just to check if there are any updates to or rev=
ised
one to this series? This guest-assisted method seems to be a good generic
approach for live migration and just wondering whether it is worth taking a
look for ARM CCA as well(I am not sure ARM RMM spec will have any=20
specific proposal for live migration or not, but couldn't find anything
public yet).

Please let me know if you plan to re-spin or there are any concerns with
this approach. Appreciate if you can point me to any relevant discussion
threads.

Thanks,
Shameer

>=20
> Corresponding RFC patches for OVMF have been posted by Tobin
> Feldman-Fitzthum on edk2-devel [1].  Those include the crux of the
> migration helper: a mailbox protocol over a shared memory page which
> allows communication between QEMU and the migration helper.  In the
> source VM this is used to read a page and encrypt it for transport; in
> the target it is used to decrypt the incoming page and storing the
> content in the correct address in the guest memory.  All encryption and
> decryption operations occur inside the trusted context in the VM, and
> therefore the VM's memory plaintext content is never accessible to the
> hosts participating in the migration.
>=20
> In order to allow OVMF to run the migration helper in parallel to the
> guest OS, we use a mirror VM [3], which shares the same memory mapping
> and SEV ASID as the main VM but has its own run loop.  To start the
> mirror vcpu and the migration handler, we added a temporary
> start-migration-handler QMP command; this will be removed in a future
> version to run as part of the migrate QMP command.
>=20
> In the target VM we need the migration handler running to receive
> incoming RAM pages; to achieve that, we boot the VM into OVMF with a
> special fw_cfg value that causes OVMF to not boot the guest OS; we then
> allow QEMU to receive an incoming migration by issuing a new
> start-migrate-incoming QMP command.
>=20
> The confidential RAM migration requires checking whether a given guest
> RAM page is encrypted or not.  This is achieved using SEV shared regions
> list tracking, which is implemented as part the SEV live migration patch
> series [2].  This feature tracks hypercalls from OVMF and guest Linux to
> report changes of page encryption status so that QEMU has an up-to-date
> view of which memory regions are shared and which are encrypted.
>=20
> We left a few unfinished edges in this RFC but decided to publish it to
> start the commmunity discussion.  TODOs:
>=20
> 1. QMP commands start-migration-handler and start-migrate-incoming are
>    developer tools and should be performed automatically.
> 2. The entry point address of the in-guest migration handler and its GDT
>    are currently hard-coded in QEMU (patch 8); instead they should be
>    discovered using pc_system_ovmf_table_find.  Same applies for the
>    mailbox address (patch 1).
> 3. For simplicity, this patch series forces the use of the
>    guest-assisted migration instead of the SEV PSP-based migration.
>    Ideally we might want the user to choose the desired mode using
>    migrate-set-parameters or a similar mechanism.
> 4. There is currently no discovery protocol between QEMU and OVMF to
>    verify that OVMF indeed supports in-guest migration handler.
>=20
>=20
> List of patches in this series:
>=20
> 1-3: introduce new confidtial RAM migration functions which communicate
>      with the migration helper.
> 4-6: use the new MH communication functions when migrating encrypted
> RAM
>      pages
> 7-9: allow starting migration handler on mirror vcpu with QMP command
>      start-migration-handler
> 10:  introduce the start-migrate-incoming QMP command to switch the
>      target into accepting the incoming migration.
> 11:  fix devices issues when loading state into a live VM
> 12:  add documentation
>=20
>=20
> This patch series is based on top of:
>=20
> 1. Add SEV guest live migration support, from Ashish Kalra [2]
> 2. Support for mirror VM, from Ashish Kalra [3]
>=20
> [1] https://edk2.groups.io/g/devel/message/79517
> [2]
> https://lore.kernel.org/qemu-devel/cover.1628076205.git.ashish.kalra@amd
> .com/
> [3]
> https://lore.kernel.org/qemu-devel/cover.1629118207.git.ashish.kalra@amd
> .com/
>=20
>=20
> Changes from RFC v1:
>  - Use the an SEV mirror VM for the migation handler (instead of
>    auxilliary vcpus)
>=20
> RFC v1:
> https://lore.kernel.org/qemu-devel/20210302204822.81901-1-dovmurik@li
> nux.vnet.ibm.com/
>=20
>=20
> Dov Murik (12):
>   migration: Add helpers to save confidential RAM
>   migration: Add helpers to load confidential RAM
>   migration: Introduce gpa_inside_migration_helper_shared_area
>   migration: Save confidential guest RAM using migration helper
>   migration: Load confidential guest RAM using migration helper
>   migration: Skip ROM, non-RAM, and vga.vram memory region during RAM
>     migration
>   i386/kvm: Exclude mirror vcpu in kvm_synchronize_all_tsc
>   migration: Allow resetting the mirror vcpu to the MH entry point
>   migration: Add QMP command start-migration-handler
>   migration: Add start-migrate-incoming QMP command
>   hw/isa/lpc_ich9: Allow updating an already-running VM
>   docs: Add confidential guest live migration documentation
>=20
>  docs/confidential-guest-live-migration.rst | 145 +++++++++
>  docs/confidential-guest-support.txt        |   5 +
>  docs/index.rst                             |   1 +
>  qapi/migration.json                        |  38 +++
>  include/sysemu/sev.h                       |   1 +
>  migration/confidential-ram.h               |  23 ++
>  hw/isa/lpc_ich9.c                          |   3 +-
>  migration/confidential-ram.c               | 339
> +++++++++++++++++++++
>  migration/migration.c                      |  29 ++
>  migration/ram.c                            | 133 +++++++-
>  target/i386/kvm/kvm.c                      |   4 +-
>  migration/meson.build                      |   2 +-
>  migration/trace-events                     |   4 +
>  13 files changed, 714 insertions(+), 13 deletions(-)
>  create mode 100644 docs/confidential-guest-live-migration.rst
>  create mode 100644 migration/confidential-ram.h
>  create mode 100644 migration/confidential-ram.c
>=20
> --
> 2.20.1
>=20


