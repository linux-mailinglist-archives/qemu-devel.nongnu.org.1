Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ADBAABDCD
	for <lists+qemu-devel@lfdr.de>; Tue,  6 May 2025 10:53:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCE2r-0002eQ-1z; Tue, 06 May 2025 04:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uCE2p-0002dP-Pn
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:52:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uCE2n-0007DM-I5
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746521572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aMnNQjB04WG0Qqvm2ABXs0Bc8TJ2dI2m6KYQ6aIicSc=;
 b=KE1BWRaKM9/BA79rUCg4Kqz46c0UDC72GcTBmrJZdNfqf3CKt7L7mQiGC3RS+PjeDY2xrj
 GY/t41vNZTR+gtckwcNBPSrG21JKHil30VUPRuKqf3yQXI2Qh7YMPMqThD6QdsafER1nm/
 S18hYY/4FzjOlTB5CaUArpyV13vA1yo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-WPyLGutYPD6BO0B2GvrW6g-1; Tue,
 06 May 2025 04:52:49 -0400
X-MC-Unique: WPyLGutYPD6BO0B2GvrW6g-1
X-Mimecast-MFC-AGG-ID: WPyLGutYPD6BO0B2GvrW6g_1746521567
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 592FF1955E74; Tue,  6 May 2025 08:52:46 +0000 (UTC)
Received: from gondolin.str.redhat.com (dhcp-192-216.str.redhat.com
 [10.33.192.216])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E04D21956094; Tue,  6 May 2025 08:52:38 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 agraf@csgraf.de
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v6 00/14] arm: rework id register storage
Date: Tue,  6 May 2025 10:52:20 +0200
Message-ID: <20250506085234.855779-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Just some small changes:
- fixed up some botched conversions noted by Eric (thanks!)
- rebased to current master
- new patch with a small cleanup suggested by Eric

Also available at
https://gitlab.com/cohuck/qemu/-/commits/arm-rework-idreg-storage-v6

<v5 cover letter>
Just a quick respin to fix a missed conversion in hvf.c.

<v4 cover letter>
Next iteration of the id register patches; only small changes.

Changed from v3:
- added R-bs (thanks!)
- added missing SPDX header
- merged patch introducing accessors for kvm to the first user
- skip over sysregs outside of the id register range when generating
  register definitions again

Also available at
https://gitlab.com/cohuck/qemu/-/commits/arm-rework-idreg-storage-v4

<v3 cover letter>
Yet another update of the id register series, less changes this time
around.

Changed from v2:
- changed generation of the various register defines via the "DEF"
  magic suggested by Richard
- some kvm-only code moved to kvm.c; some code potentially useful to
  non-kvm code stayed out of there (the cpu model code will make use
  of it, and that one should be extendable outside of kvm -- a
  revised version of those patches is still in the works, but I'll be
  off for a few days and rather wanted to get this one out first)

Also available at
https://gitlab.com/cohuck/qemu/-/commits/arm-rework-idreg-storage-v3

<v2 cover letter>

Changed from v1:
- Noticed that we missed the hvf code. Converted, compiled, but not tested
  as I'm lacking an environment for testing.
- Hopefully incorporated most of the suggested changes -- if I missed
  something, it was unintentional unless mentioned below.
  - fixed repeated inclusion of definitions
  - hopefully made macros more robust
  - removed distinction between reading 32/64 values, which was mostly
    adding churn for little value
  - postponed generating property definitions to the cpu model patches,
    where they are actually used
  - juggled hunks and moved them to the right patches
  - fixed some typos
- rebased to a more recent code base

NOT changed from v1:
- definitions are still generated from the Linux sysregs file
  - I still think updating the generated files on demand (so that we can
    double check the result) is the right thing to do
  - I'm open to changing the source of the definitions from the sysregs
    file to the JSON definitions published by Arm; however, I first wanted
    to get the code using it right -- we can switch out the code generating
    the file to use a different source easily later on, and I'd also like
    to steal parts of the script from Linux once integrated (which I think
    hasn't happened yet?)

<v1 cover letter>

[Note: I've kept the cc list from the last round of cpu model patches;
so if you're confused as to why you're cc:ed here, take it as a
heads-up that a new cpu model series will come along soon]

This patch series contains patches extracted from the larger cpu model
series (RFC v2 last posted at
https://lore.kernel.org/qemu-devel/20241206112213.88394-1-cohuck@redhat.com/)
and aims at providing a base upon which we can continue with building
support for cpu models, but which is hopefully already an improvement
on its own.

Main changes from the patches in that series include:
- post-pone the changes to handle KVM writable ID registers for cpu models
  (I have a series including that on top of this one)
- change how we store the list of ID registers, and access them
  basically, use an enum for indexing, and an enum doing encodings in a
  pattern similar to cpregs
- move some hunks to different patches
- update the scripts to generate the register descriptions, and run
  them against a recent Linux sysregs file

What I've kept:
- generating the register descriptions from the Linux sysregs file
  I think that file is still our best bet to generate the descriptions
  easily, and updating the definitions is a manual step that can be checked
  for unintended changes
- most of the hard work that Eric had been doing; all new bugs in there
  are my own :)

</v1 cover letter>
</v2 cover letter>
</v3 cover letter>
</v4 cover letter>
</v5 cover letter>

Cornelia Huck (2):
  arm/cpu: switch to a generated cpu-sysregs.h.inc
  arm/kvm: use fd instead of fdarray[2]

Eric Auger (12):
  arm/cpu: Add sysreg definitions in cpu-sysregs.h
  arm/cpu: Store aa64isar0/aa64zfr0 into the idregs arrays
  arm/cpu: Store aa64isar1/2 into the idregs array
  arm/cpu: Store aa64pfr0/1 into the idregs array
  arm/cpu: Store aa64mmfr0-3 into the idregs array
  arm/cpu: Store aa64dfr0/1 into the idregs array
  arm/cpu: Store aa64smfr0 into the idregs array
  arm/cpu: Store id_isar0-7 into the idregs array
  arm/cpu: Store id_pfr0/1/2 into the idregs array
  arm/cpu: Store id_dfr0/1 into the idregs array
  arm/cpu: Store id_mmfr0-5 into the idregs array
  arm/cpu: Add sysreg generation scripts

 hw/intc/armv7m_nvic.c                 |  27 +-
 scripts/gen-cpu-sysregs-header.awk    |  35 ++
 scripts/update-aarch64-sysreg-code.sh |  25 ++
 target/arm/cpu-features.h             | 317 +++++++++---------
 target/arm/cpu-sysregs.h              |  42 +++
 target/arm/cpu-sysregs.h.inc          |  52 +++
 target/arm/cpu.c                      | 111 +++----
 target/arm/cpu.h                      |  80 +++--
 target/arm/cpu64.c                    | 128 +++----
 target/arm/helper.c                   |  68 ++--
 target/arm/hvf/hvf.c                  |  39 ++-
 target/arm/internals.h                |   6 +-
 target/arm/kvm.c                      | 139 ++++----
 target/arm/ptw.c                      |   6 +-
 target/arm/tcg/cpu-v7m.c              | 174 +++++-----
 target/arm/tcg/cpu32.c                | 320 +++++++++---------
 target/arm/tcg/cpu64.c                | 459 +++++++++++++-------------
 17 files changed, 1103 insertions(+), 925 deletions(-)
 create mode 100755 scripts/gen-cpu-sysregs-header.awk
 create mode 100755 scripts/update-aarch64-sysreg-code.sh
 create mode 100644 target/arm/cpu-sysregs.h
 create mode 100644 target/arm/cpu-sysregs.h.inc

-- 
2.49.0


