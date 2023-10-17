Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B267CC776
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:29:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qslzg-0005Uh-Bi; Tue, 17 Oct 2023 11:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qslzc-0005U5-Gd
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:28:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qslza-0006sv-TW
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697556501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C+wMnezdSmjs10pDeNJeo7+9S3n3Z8j46jkaSy9yiGY=;
 b=Z9+ORFIKsV++1iaoeuLiuIu5JqWgvzfH4gPc+IIkYfGq3jhoSNvUJY7Df6D5Ltiz0U0aPx
 JwAKUN4AEFPfqzhd82Smmv4GrDEQcNnQpVMqpp5hL7qsIIaD+DdS439AZlNhVsDmHLRRah
 A8ovb8/aPyTW8cGbVN1rPLKTmue/8oA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-ZpPK_h1lNnK7KmZix5YMOA-1; Tue, 17 Oct 2023 11:28:08 -0400
X-MC-Unique: ZpPK_h1lNnK7KmZix5YMOA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 591A58E4148;
 Tue, 17 Oct 2023 15:28:08 +0000 (UTC)
Received: from localhost (unknown [10.39.193.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D540150;
 Tue, 17 Oct 2023 15:28:08 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm/kvm: convert to read_sys_reg64
In-Reply-To: <CAFEAcA88O-VDq2rRfVhZ_6OShFq1ANEMmHWHVtNS5hCPQNYtdg@mail.gmail.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20231010142453.224369-1-cohuck@redhat.com>
 <20231010142453.224369-4-cohuck@redhat.com>
 <CAFEAcA88O-VDq2rRfVhZ_6OShFq1ANEMmHWHVtNS5hCPQNYtdg@mail.gmail.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 17 Oct 2023 17:28:06 +0200
Message-ID: <87y1g1clq1.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 17 2023, Peter Maydell <peter.maydell@linaro.org> wrote:

> On Tue, 10 Oct 2023 at 15:25, Cornelia Huck <cohuck@redhat.com> wrote:
>>
>> We can use read_sys_reg64 to get the SVE_VLS register instead of
>> calling GET_ONE_REG directly.
>>
>> Suggested-by: Gavin Shan <gshan@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  target/arm/kvm64.c | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
>> index 558c0b88dd69..d40c89a84752 100644
>> --- a/target/arm/kvm64.c
>> +++ b/target/arm/kvm64.c
>> @@ -500,10 +500,6 @@ uint32_t kvm_arm_sve_get_vls(CPUState *cs)
>>              .target = -1,
>>              .features[0] = (1 << KVM_ARM_VCPU_SVE),
>>          };
>> -        struct kvm_one_reg reg = {
>> -            .id = KVM_REG_ARM64_SVE_VLS,
>> -            .addr = (uint64_t)&vls[0],
>> -        };
>>          int fdarray[3], ret;
>>
>>          probed = true;
>> @@ -512,7 +508,7 @@ uint32_t kvm_arm_sve_get_vls(CPUState *cs)
>>              error_report("failed to create scratch VCPU with SVE enabled");
>>              abort();
>>          }
>> -        ret = ioctl(fdarray[2], KVM_GET_ONE_REG, &reg);
>> +        ret = read_sys_reg64(fdarray[2], &vls[0], KVM_REG_ARM64_SVE_VLS);
>>          kvm_arm_destroy_scratch_host_vcpu(fdarray);
>>          if (ret) {
>>              error_report("failed to get KVM_REG_ARM64_SVE_VLS: %s",
>
> read_sys_reg64() asserts that the register you're trying to
> read is 64 bits, but KVM_REG_ARM64_SVE_VLS is not, it's 512 bits:
>
> #define KVM_REG_ARM64_SVE_VLS           (KVM_REG_ARM64 | KVM_REG_ARM64_SVE | \
>                                          KVM_REG_SIZE_U512 | 0xffff)
>
> So this change would trip the assert on a host where SVE
> is supported and enabled.

Whoops, it seems that I misread this. (And my test environment didn't
have that enabled...)


