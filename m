Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E39CACC9F1
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Jun 2025 17:16:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMTLw-0004MN-SV; Tue, 03 Jun 2025 11:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uMTLp-0004Li-N4
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uMTLk-00065Q-Jc
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748963685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j8B3gHHP/8JurKyH285IBxQpYEQhsELog9paMOChLMM=;
 b=fL4HpEXM2E96NBn8ENLPlQ/GlmYmbZAQrgy7jKg4MWZuxvKwxHtTvEnKp3hzXOp+zDFb93
 nTQl6eteeul8P+G0/sNn+wmXeseeLZEjuqIgb6rOMvP4dOhlZSnI2Xslnx1Z2XlDeTp2mZ
 V82XDL5OCBaKGmJx8JBoIE8Bco+d5nE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-r3WC_cJ0NJuD2YuMgUFrJA-1; Tue,
 03 Jun 2025 11:14:39 -0400
X-MC-Unique: r3WC_cJ0NJuD2YuMgUFrJA-1
X-Mimecast-MFC-AGG-ID: r3WC_cJ0NJuD2YuMgUFrJA_1748963676
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B896A1801A33; Tue,  3 Jun 2025 15:14:35 +0000 (UTC)
Received: from localhost (dhcp-192-216.str.redhat.com [10.33.192.216])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91F44180047F; Tue,  3 Jun 2025 15:14:33 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "maz@kernel.org"
 <maz@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "sebott@redhat.com" <sebott@redhat.com>, "armbru@redhat.com"
 <armbru@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>, "jdenemar@redhat.com"
 <jdenemar@redhat.com>
Cc: "agraf@csgraf.de" <agraf@csgraf.de>, "shahuang@redhat.com"
 <shahuang@redhat.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Subject: RE: [PATCH v3 00/10] kvm/arm: Introduce a customizable aarch64 KVM
 host model
In-Reply-To: <878qmibc5a.fsf@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20250414163849.321857-1-cohuck@redhat.com>
 <de7db6bc22ad4f0a8ac1fac718c810a1@huawei.com> <87bjrfbkyz.fsf@redhat.com>
 <878qmibc5a.fsf@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Tue, 03 Jun 2025 17:14:30 +0200
Message-ID: <87tt4wamcp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, May 27 2025, Cornelia Huck <cohuck@redhat.com> wrote:

> On Mon, May 26 2025, Cornelia Huck <cohuck@redhat.com> wrote:
>
>> On Fri, May 23 2025, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:
>>
>>> Hi,
>>>
>>>> -----Original Message-----
>>>> From: Cornelia Huck <cohuck@redhat.com>
>>>> Sent: Monday, April 14, 2025 5:39 PM
>>>> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
>>>> devel@nongnu.org; qemu-arm@nongnu.org; kvmarm@lists.linux.dev;
>>>> peter.maydell@linaro.org; richard.henderson@linaro.org;
>>>> alex.bennee@linaro.org; maz@kernel.org; oliver.upton@linux.dev;
>>>> sebott@redhat.com; Shameerali Kolothum Thodi
>>>> <shameerali.kolothum.thodi@huawei.com>; armbru@redhat.com;
>>>> berrange@redhat.com; abologna@redhat.com; jdenemar@redhat.com
>>>> Cc: agraf@csgraf.de; shahuang@redhat.com; mark.rutland@arm.com;
>>>> philmd@linaro.org; pbonzini@redhat.com; Cornelia Huck
>>>> <cohuck@redhat.com>
>>>> Subject: [PATCH v3 00/10] kvm/arm: Introduce a customizable aarch64 KVM
>>>> host model
>>>
>>> [..]
>>>
>>> )
>>>> 
>>>> Code also available at
>>>> https://gitlab.com/cohuck/qemu/-/tree/arm-cpu-model-
>>>> rfcv3?ref_type=heads
>>>
>>> I had a spin with the above branch, but Qemu boot fails,
>>>
>>> ERROR:../target/arm/cpu64.c:57:get_sysreg_idx: code should not be reached
>>> Bail out! ERROR:../target/arm/cpu64.c:57:get_sysreg_idx: code should not be reached
>>>
>>> From a quick debug, it looks like the below path results in an invalid ID idx.
>>>
>>> kvm_arm_expose_idreg_properties()
>>>  kvm_idx_to_idregs_idx(0)
>>>   get_sysreg_idx(0xc000)  --> id_register seems to start at 0xc008
>>>
>>> Haven't debugged further.
>>>
>>> I am running against a 6.15-rc1 kernel after updating the Qemu branch by,
>>> ./update-aarch64-sysreg-code.sh  path_to_6.15-rc1
>>>
>>> Not sure I am  missing anything. Please check and let me know.
>>
>> Thanks for trying this out; I'll try to re-create this here.
>> (I think I've messed up those conversion functions often enough...)
>
> The conversion functions are not at fault here, but we're missing
> registers. If we have MIDR and friends writable, they show up in the
> masks returned by the kernel, but they are not present in the kernel's
> sysreg file where we generate our definitions from, and
> kvm_idx_to_idregs_idx() asserts instead of returning an error, which is
> kind of suboptimal...
>
> So I see two possible ways to fix this:
> - add MIDR and friends to the kernel's sysreg file
> - add MIDR and friends in QEMU's cpu-sysregs.h.inc file, and only append
>   generated definitions there
>
> First option means one more round trip, second options has more
> potential for messing things up if we keep stuff local to QEMU.

With the patch below, things work for me with a 6.15+ kernel. It's a bit
messy, though, and raises questions (how do we want to handle those regs
across accelerators, for example, or how we can make sure that the code
is more robust when registers are added.)

My biggest question, however, is how this interacts with the framework
to provide lists of MIDR/REVIDR/AIDR for errata management. The hack
below adds properties to configure those regs, I guess we'd want to
suppress adding the props in order to avoid conflicts.

WDYT?

diff --git a/scripts/gen-cpu-sysreg-properties.awk b/scripts/gen-cpu-sysreg-properties.awk
index 6740e814f733..7afd9afd2650 100755
--- a/scripts/gen-cpu-sysreg-properties.awk
+++ b/scripts/gen-cpu-sysreg-properties.awk
@@ -109,6 +109,27 @@ END {
 	if (__current_block_depth != 0)
 		fatal("Missing terminator for " block_current() " block")
 
+	# Manually add MIDR/REVIDR/AIDR
+	print ""
+	print "    /* MIDR_EL1 */"
+	print "    ARM64SysReg *MIDR_EL1 = arm64_sysreg_get(MIDR_EL1_IDX);"
+	print "    MIDR_EL1->name = \"MIDR_EL1\";"
+	print "    arm64_sysreg_add_field(MIDR_EL1, \"Implementer\", 24, 31);"
+	print "    arm64_sysreg_add_field(MIDR_EL1, \"Variant\", 20, 23);"
+	print "    arm64_sysreg_add_field(MIDR_EL1, \"Architecture\", 16, 19);"
+	print "    arm64_sysreg_add_field(MIDR_EL1, \"PartNum\", 4, 15);"
+	print "    arm64_sysreg_add_field(MIDR_EL1, \"Revision\", 0, 3);"
+	print ""
+	print "    /* REVIDR_EL1 */"
+	print "    ARM64SysReg *REVIDR_EL1 = arm64_sysreg_get(REVIDR_EL1_IDX);"
+	print "    REVIDR_EL1->name = \"REVIDR_EL1\";"
+	print "    arm64_sysreg_add_field(REVIDR_EL1, \"IMPDEF\", 0, 63);"
+	print ""
+	print "    /* AIDR_EL1 */"
+	print "    ARM64SysReg *AIDR_EL1 = arm64_sysreg_get(AIDR_EL1_IDX);"
+	print "    AIDR_EL1->name = \"AIDR_EL1\";"
+	print "    arm64_sysreg_add_field(AIDR_EL1, \"IMPDEF\", 0, 63);"
+	print ""
 	print "}"
 }
 
diff --git a/scripts/gen-cpu-sysregs-header.awk b/scripts/gen-cpu-sysregs-header.awk
index 452e51035d52..2eb561b693dc 100755
--- a/scripts/gen-cpu-sysregs-header.awk
+++ b/scripts/gen-cpu-sysregs-header.awk
@@ -7,7 +7,10 @@
 BEGIN {
     print ""
 } END {
-    print ""
+    /* add MIDR, REVIDR, and AIDR */
+    print "DEF(MIDR_EL1, 3, 0, 0, 0, 0)"
+    print "DEF(REVIDR_EL1, 3, 0, 0, 0, 6)"
+    print "DEF(AIDR_EL1, 3, 1, 0, 0, 7)"
 }
 
 # skip blank lines and comment lines
diff --git a/target/arm/cpu-sysreg-properties.c b/target/arm/cpu-sysreg-properties.c
index 29c4c8ada115..bc1ae5e1a224 100644
--- a/target/arm/cpu-sysreg-properties.c
+++ b/target/arm/cpu-sysreg-properties.c
@@ -715,4 +715,24 @@ void initialize_cpu_sysreg_properties(void)
 
 /* For S2PIR_EL2 fields see PIRx_ELx */
 
+
+    /* MIDR_EL1 */
+    ARM64SysReg *MIDR_EL1 = arm64_sysreg_get(MIDR_EL1_IDX);
+    MIDR_EL1->name = "MIDR_EL1";
+    arm64_sysreg_add_field(MIDR_EL1, "Implementer", 24, 31);
+    arm64_sysreg_add_field(MIDR_EL1, "Variant", 20, 23);
+    arm64_sysreg_add_field(MIDR_EL1, "Architecture", 16, 19);
+    arm64_sysreg_add_field(MIDR_EL1, "PartNum", 4, 15);
+    arm64_sysreg_add_field(MIDR_EL1, "Revision", 0, 3);
+
+    /* REVIDR_EL1 */
+    ARM64SysReg *REVIDR_EL1 = arm64_sysreg_get(REVIDR_EL1_IDX);
+    REVIDR_EL1->name = "REVIDR_EL1";
+    arm64_sysreg_add_field(REVIDR_EL1, "IMPDEF", 0, 63);
+
+    /* AIDR_EL1 */
+    ARM64SysReg *AIDR_EL1 = arm64_sysreg_get(AIDR_EL1_IDX);
+    AIDR_EL1->name = "AIDR_EL1";
+    arm64_sysreg_add_field(AIDR_EL1, "IMPDEF", 0, 63);
+
 }
diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index 02aae133eb67..8f0927ce0422 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -49,4 +49,6 @@ DEF(SMIDR_EL1, 3, 1, 0, 0, 6)
 DEF(CSSELR_EL1, 3, 2, 0, 0, 0)
 DEF(CTR_EL0, 3, 3, 0, 0, 1)
 DEF(DCZID_EL0, 3, 3, 0, 0, 7)
-
+DEF(MIDR_EL1, 3, 0, 0, 0, 0)
+DEF(REVIDR_EL1, 3, 0, 0, 0, 6)
+DEF(AIDR_EL1, 3, 1, 0, 0, 7)
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 95bb728a77f1..7454f329157c 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -54,7 +54,7 @@ int get_sysreg_idx(ARMSysRegs sysreg)
     switch (sysreg) {
 #include "cpu-sysregs.h.inc"
     }
-    g_assert_not_reached();
+    return -1;
 }
 
 #undef DEF


