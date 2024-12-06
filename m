Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C38199E6D3D
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Dec 2024 12:23:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJWPv-0000oS-0t; Fri, 06 Dec 2024 06:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tJWPs-0000oE-OW
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 06:22:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tJWPq-0001wU-Lr
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 06:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733484151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hR/36+jL1HEYne7ZJbaetgKkJOfY5RpKpU8sxbUibaY=;
 b=YYn18/GxrIkhEgQIdbaB5tb+H8mJv+T6VOWyoCP7nhteyqp5RZrichEGXL9dHX2TBUKoVF
 X4DmH/aF0K0vian8DN6RA8qxLHFZEN9W7iNv5Fqi7cXNhnsSsLW2CXq5MOg5WUbChUJGet
 2l/pE/85P/g2SP1Bko2jlIGniQNy7Do=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-WcQ5LRSEMKSeIQy1KaSVIQ-1; Fri,
 06 Dec 2024 06:22:27 -0500
X-MC-Unique: WcQ5LRSEMKSeIQy1KaSVIQ-1
X-Mimecast-MFC-AGG-ID: WcQ5LRSEMKSeIQy1KaSVIQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7EED19560A3; Fri,  6 Dec 2024 11:22:25 +0000 (UTC)
Received: from gondolin.str.redhat.com (dhcp-192-244.str.redhat.com
 [10.33.192.244])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E235D19560A2; Fri,  6 Dec 2024 11:22:18 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH RFCv2 00/20] kvm/arm: Introduce a customizable aarch64 KVM
 host model
Date: Fri,  6 Dec 2024 12:21:53 +0100
Message-ID: <20241206112213.88394-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

A respin/update on the aarch64 KVM cpu models. Also available at
gitlab.com/cohuck/qemu arm-cpu-model-rfcv2

Find Eric's original cover letter below, so that I do not need to
repeat myself on the aspects that have not changed since RFCv1 :)

Changes from RFCv1:

Rebased on more recent QEMU (some adaptions in the register conversions
of the first few patches.)

Based on feedback, I have removed the "custom" cpu model; instead, I
have added the new SYSREG_<REG>_<FIELD> properties to the "host" model.
This works well if you want to tweak anything that does not correspond
to the existing properties for the host model; however, if you e.g.
wanted to tweak sve, you have two ways to do so -- we'd probably either
want to check for conflicts, or just declare precedence. The kvm-specific
props remain unchanged, as they are orthogonal to this configuration.

The cpu model expansion for the "host" model now dumps the new SYSREG_
properties in addition to the existing host model properties; this is a
bit ugly, but I don't see a good way on how to split this up.

Some more adaptions due to the removal of the "custom" model.

Things *not* changed from RFCv1:

SYSREG_ property naming (can be tweaked easily, once we are clear on what
the interface should look like.)

Sysreg generation scripts, and the generated files (I have not updated
anything there.) I think generating the various definitions makes sense,
as long as we double-check the generated files on each update (which would
be something to trigger manually anyway.)

What I would like us to reach some kind of consensus on:

How to continue with the patches moving the ID registers from the isar
struct into the idregs array. These are a bit of churn to drag along;
if they make sense, maybe they can be picked independently of this series?

Whether it make sense to continue with the approach of tweaking values in
the ID registers in general. If we want to be able to migrate between cpus
that do not differ wildly, we'll encounter differences that cannot be
expressed via FEAT_xxx -- e.g. when comparing various AmpereAltra Max systems,
they only differ in parts of CTR_EL0 -- which is not a feature register, but
a writable register.

Please take a look, and looking forward to your feedback :)

***********************************************************************

Title: Introduce a customizable aarch64 KVM host model 

This RFC series introduces a KVM host "custom" model.

Since v6.7 kernel, KVM/arm allows the userspace to overwrite the values
of a subset of ID regs. The list of writable fields continues to grow.
The feature ID range is defined as the AArch64 System register space
with op0==3, op1=={0, 1, 3}, CRn==0, CRm=={0-7}, op2=={0-7}.

The custom model uses this capability and allows to tune the host
passthrough model by overriding some of the host passthrough ID regs. 

The end goal is to get more flexibility when migrating guests
between different machines. We would like the upper software layer
to be able detect how tunable the vpcu is on both source and destination
and accordingly define a customized KVM host model that can fit
both ends. With the legacy host passthrough model, this migration
use case would fail.

QEMU queries the host kernel to get the list of writable ID reg
fields and expose all the writable fields as uint64 properties. Those
are named "SYSREG_<REG>_<FIELD>". REG and FIELD names are those
described in ARM ARM Reference manual and linux arch/arm64/tools/sysreg.
Some awk scriptsintroduced in the series help parsing the sysreg file and
generate some code. those scripts are used in a similar way as
scripts/update-linux-headers.sh.  In case the ABI gets broken, it is
still possible to manually edit the generated code. However it is
globally expected the REG and FIELD names are stable.

The list of SYSREG_ID properties can be retrieved through the qmp
monitor using query-cpu-model-expansion [2].

The first part of the series mostly consists in migrating id reg
storage from named fields in ARMISARegisters to anonymous index
ordered storage in an IdRegMap struct array. The goal is to have
a generic way to store all id registers, also compatible with the
way we retrieve their writable capability at kernel level through
the KVM_ARM_GET_REG_WRITABLE_MASKS ioctl. Having named fields
prevented us from getting this scalability/genericity. Although the
change is invasive  it is quite straightforward and should be easy
to be reviewed.

Then the bulk of the job is to retrieve the writable ID fields and
match them against a "human readable" description of those fields.
We use awk scripts, derived from kernel arch/arm64/tools/gen-sysreg.awk
(so all the credit to Mark Rutland) that populates a data structure
which describes all the ID regs in sysreg and their fields. We match
writable ID reg fields with those latter and dynamically create a
uint64 property. 

Then we need to extend the list of id regs read from the host
so that we get a chance to let their value overriden and write them
back into KVM .

This expectation is that this custom KVM host model can prepare for
the advent of named models. Introducing named models with reduced
and explicitly defined features is the next step.

Obviously this series is not able to cope with non writable ID regs.
For instance the problematic of MIDR/REVIDR setting is not handled
at the moment.


TESTS:
- with few IDREG fields that can be easily examined from guest
  userspace:
  -cpu custom,SYSREG_ID_AA64ISAR0_EL1_DP=0x0,SYSREG_ID_AA64ISAR1_EL1_DPB=0x0
- migration between custom models
- TCG A57 non regressions. Light testing for TCG though. Deep
  review may detect some mistakes when migrating between named fields
  and IDRegMap storage
- light testing of introspection. Testing a given writable ID field
  value with query-cpu-model-expansion is not supported yet.

TODO/QUESTIONS:
- Some idreg named fields are not yet migrated to an array storage.
  some of them are not in isar struct either. Maybe we could have
  handled TCG and KVM separately and it may turn out that this
  conversion is unneeded. So as it is quite cumbersome I prefered
  to keep it for a later stage.
- the custom model does not come with legacy host properties
  such as SVE, MTE, expecially those that induce some KVM
  settings. This needs to be fixed.
- The custom model and its exposed properties depend on the host
  capabilities. More and more IDREG become writable meaning that
  the custom model gains more properties over the time and it is
  host linux dependent. At the moment there is no versioning in
  place. By default the custom model is a host passthrough model
  (besides the legacy functions). So if the end-user tries to set
  a field that is not writable from a kernel pov, it will fail.
  Nevertheless a versionned custom model could constrain the props
  exposed, independently on the host linux capabilities.
- the QEMU layer does not take care of IDREG field value consistency.
  The kernel neither. I imagine this could be the role of the upper
  layer to implement a vcpu profile that makes sure settings are
  consistent. Here we come to "named" models. What should they look
  like on ARM?
- Implementation details:
  -  it seems there are a lot of duplications in
  the code. ID regs are described in different manners, with different
  data structs, for TCG, now for KVM.
  - The IdRegMap->regs is sparsely populated. Maybe a better data
  struct could be used, although this is the one chosen for the kernel
  uapi.

References:

[1] [PATCH v12 00/11] Support writable CPU ID registers from userspace
https://lore.kernel.org/all/20230609190054.1542113-1-oliver.upton@linux.dev/

[2]
qemu-system-aarch64 -qmp unix:/home/augere/TEST/QEMU/qmp-sock,server,nowait -M virt --enable-kvm -cpu custom
scripts/qmp/qmp-shell /home/augere/TEST/QEMU/qmp-sock
Welcome to the QMP low-level shell!
Connected to QEMU 9.0.50
(QEMU) query-cpu-model-expansion type=full model={"name":"custom"}

[3]
KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES
KVM_ARM_GET_REG_WRITABLE_MASKS
Documentation/virt/kvm/api.rst

[4] linux "sysreg" file
linux/arch/arm64/tools/sysreg and gen-sysreg.awk
./tools/include/generated/asm/sysreg-defs.h


Cornelia Huck (3):
  kvm: kvm_get_writable_id_regs
  arm-qmp-cmds: introspection for ID register props
  arm/cpu-features: document ID reg properties

Eric Auger (17):
  arm/cpu: Add sysreg definitions in cpu-sysregs.h
  arm/cpu: Store aa64isar0 into the idregs arrays
  arm/cpu: Store aa64isar1/2 into the idregs array
  arm/cpu: Store aa64drf0/1 into the idregs array
  arm/cpu: Store aa64mmfr0-3 into the idregs array
  arm/cpu: Store aa64drf0/1 into the idregs array
  arm/cpu: Store aa64smfr0 into the idregs array
  arm/cpu: Store id_isar0-7 into the idregs array
  arm/cpu: Store id_mfr0/1 into the idregs array
  arm/cpu: Store id_dfr0/1 into the idregs array
  arm/cpu: Store id_mmfr0-5 into the idregs array
  arm/cpu: Add infra to handle generated ID register definitions
  arm/cpu: Add sysreg generation scripts
  arm/cpu: Add generated files
  arm/kvm: Allow reading all the writable ID registers
  arm/kvm: write back modified ID regs to KVM
  arm/cpu: more customization for the kvm host cpu model

 docs/system/arm/cpu-features.rst      |  47 +-
 hw/intc/armv7m_nvic.c                 |  27 +-
 scripts/gen-cpu-sysreg-properties.awk | 325 ++++++++++++
 scripts/gen-cpu-sysregs-header.awk    |  47 ++
 scripts/update-aarch64-sysreg-code.sh |  27 +
 target/arm/arm-qmp-cmds.c             |  19 +
 target/arm/cpu-custom.h               |  58 +++
 target/arm/cpu-features.h             | 311 ++++++------
 target/arm/cpu-sysreg-properties.c    | 682 ++++++++++++++++++++++++++
 target/arm/cpu-sysregs.h              | 152 ++++++
 target/arm/cpu.c                      | 123 ++---
 target/arm/cpu.h                      | 120 +++--
 target/arm/cpu64.c                    | 260 +++++++---
 target/arm/helper.c                   |  68 +--
 target/arm/internals.h                |   6 +-
 target/arm/kvm.c                      | 253 +++++++---
 target/arm/kvm_arm.h                  |  16 +-
 target/arm/meson.build                |   1 +
 target/arm/ptw.c                      |   6 +-
 target/arm/tcg/cpu-v7m.c              | 174 +++----
 target/arm/tcg/cpu32.c                | 320 ++++++------
 target/arm/tcg/cpu64.c                | 460 ++++++++---------
 target/arm/trace-events               |   8 +
 23 files changed, 2594 insertions(+), 916 deletions(-)
 create mode 100755 scripts/gen-cpu-sysreg-properties.awk
 create mode 100755 scripts/gen-cpu-sysregs-header.awk
 create mode 100755 scripts/update-aarch64-sysreg-code.sh
 create mode 100644 target/arm/cpu-custom.h
 create mode 100644 target/arm/cpu-sysreg-properties.c
 create mode 100644 target/arm/cpu-sysregs.h

-- 
2.47.0


