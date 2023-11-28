Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 145777FBE48
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 16:40:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r80B5-0000A1-6S; Tue, 28 Nov 2023 10:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1r80B2-00009S-Bp
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 10:39:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1r80B0-0005IY-Lb
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 10:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701185946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FhliJe40ILRbl4h+52+3yHEmFQKJQ8NDVsRJxhwEMPA=;
 b=cUgpV9YxMXV/hBwbsEQM9CgtOMRhEdp8LRaq5DghwrGr41omAwuZt9obdm4m7sy45v5FFp
 rVj7ISWzaxRLtfpR5j90LeDBmD9vfEli0zoHbhYj20VU8fHAQP+AB8xVu9TcYWMqu4ejrr
 xSZbleOqS+oPr3BmD7UppLtZBHwUD+8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-u01nM_pON7GmwTEx2sIurg-1; Tue,
 28 Nov 2023 10:39:02 -0500
X-MC-Unique: u01nM_pON7GmwTEx2sIurg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44EB13C1E9D2;
 Tue, 28 Nov 2023 15:39:02 +0000 (UTC)
Received: from localhost (unknown [10.22.8.243])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D9E11C060BB;
 Tue, 28 Nov 2023 15:39:01 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org
Subject: Re: [PATCH for-8.2] target/arm: Disable SME if SVE is disabled
In-Reply-To: <20231127173318.674758-1-peter.maydell@linaro.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20231127173318.674758-1-peter.maydell@linaro.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 28 Nov 2023 16:39:00 +0100
Message-ID: <877cm1yjjf.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Nov 27 2023, Peter Maydell <peter.maydell@linaro.org> wrote:

> There is no architectural requirement that SME implies SVE, but
> our implementation currently assumes it. (FEAT_SME_FA64 does
> imply SVE.) So if you try to run a CPU with eg "-cpu max,sve=off"
> you quickly run into an assert when the guest tries to write to
> SMCR_EL1:
>
> #6  0x00007ffff4b38e96 in __GI___assert_fail
>     (assertion=0x5555566e69cb "sm", file=0x5555566e5b24 "../../target/arm/helper.c", line=6865, function=0x5555566e82f0 <__PRETTY_FUNCTION__.31> "sve_vqm1_for_el_sm") at ./assert/assert.c:101
> #7  0x0000555555ee33aa in sve_vqm1_for_el_sm (env=0x555557d291f0, el=2, sm=false) at ../../target/arm/helper.c:6865
> #8  0x0000555555ee3407 in sve_vqm1_for_el (env=0x555557d291f0, el=2) at ../../target/arm/helper.c:6871
> #9  0x0000555555ee3724 in smcr_write (env=0x555557d291f0, ri=0x555557da23b0, value=2147483663) at ../../target/arm/helper.c:6995
> #10 0x0000555555fd1dba in helper_set_cp_reg64 (env=0x555557d291f0, rip=0x555557da23b0, value=2147483663) at ../../target/arm/tcg/op_helper.c:839
> #11 0x00007fff60056781 in code_gen_buffer ()
>
> Avoid this unsupported and slightly odd combination by
> disabling SME when SVE is not present.
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2005
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> '-cpu sve=off,sme=on,sme_fa64=off' crashes in the same way, so just
> turning off FA64 isn't sufficient.  Maybe we should support
> SME-no-SVE, but for 8.2 at least turning off SME is better than
> letting users hit an assertion.
> ---
>  target/arm/cpu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 25e9d2ae7b8..0fe268ac785 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1743,6 +1743,15 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
>              return;
>          }
>  
> +        /*
> +         * FEAT_SME is not architecturally dependent on FEAT_SVE (unless
> +         * FEAT_SME_FA64 is present). However our implementation currently
> +         * assumes it, so if the user asked for sve=off then turn off SME also.
> +         */

Might be worth adding a note here that KVM currently does not support
SME anyway? It took me a moment to remember that.

> +        if (cpu_isar_feature(aa64_sme, cpu) && !cpu_isar_feature(aa64_sve, cpu)) {
> +            object_property_set_bool(OBJECT(cpu), "sme", false, &error_abort);
> +        }
> +
>          arm_cpu_sme_finalize(cpu, &local_err);
>          if (local_err != NULL) {
>              error_propagate(errp, local_err);


