Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA8075EE46
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 10:48:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNrDq-0006X9-6W; Mon, 24 Jul 2023 04:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qNrDo-0006Wt-Eq
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:47:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qNrDm-0007Vl-RB
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690188433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mhey2rfScVI0ERO3qifA2o1FZHJDtGw8MJL1bWmGkcM=;
 b=QMOc+/7w9Sz/cDY09P11cFOSD7Zj7/DDfc02hzw/KuWlIhw+XAWA6NQxef8bSF2tEjzXRK
 PjZwe9SDQ6a7eWL7QpTJy5idAXhfJ7oiPAWAFIiC8gSUuqWiqsRSSGb0GQyXCT49LUykNK
 gG0QaF8De/4I7wHuJRpBsGwkoRs7EOw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-355-oT7Jp7WnNZWZ-rw25rGdYw-1; Mon, 24 Jul 2023 04:47:09 -0400
X-MC-Unique: oT7Jp7WnNZWZ-rw25rGdYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05582101A54E;
 Mon, 24 Jul 2023 08:47:09 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4782F782E;
 Mon, 24 Jul 2023 08:47:08 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Gavin Shan <gshan@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH for-8.2 1/2] arm/kvm: convert to kvm_set_one_reg
In-Reply-To: <a5b93992-5576-04cf-3af0-2c237831f5c6@redhat.com>
Organization: Red Hat GmbH
References: <20230718111404.23479-1-cohuck@redhat.com>
 <20230718111404.23479-2-cohuck@redhat.com>
 <a5b93992-5576-04cf-3af0-2c237831f5c6@redhat.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 24 Jul 2023 10:47:07 +0200
Message-ID: <87bkg1g0hg.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jul 24 2023, Gavin Shan <gshan@redhat.com> wrote:

> Hi Connie,
>
> On 7/18/23 21:14, Cornelia Huck wrote:
>> We can neaten the code by switching to the kvm_set_one_reg function.
>> 
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>   target/arm/kvm.c   | 13 +++------
>>   target/arm/kvm64.c | 66 +++++++++++++---------------------------------
>>   2 files changed, 21 insertions(+), 58 deletions(-)
>> 
>
> Some wrong replacements to be fixed in kvm_arch_put_fpsimd() as below.
> Apart from that, LGTM:
>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> @@ -725,19 +721,17 @@ static void kvm_inject_arm_sea(CPUState *c)
>>   static int kvm_arch_put_fpsimd(CPUState *cs)
>>   {
>>       CPUARMState *env = &ARM_CPU(cs)->env;
>> -    struct kvm_one_reg reg;
>>       int i, ret;
>>   
>>       for (i = 0; i < 32; i++) {
>>           uint64_t *q = aa64_vfp_qreg(env, i);
>>   #if HOST_BIG_ENDIAN
>>           uint64_t fp_val[2] = { q[1], q[0] };
>> -        reg.addr = (uintptr_t)fp_val;
>> +        ret = kvm_set_one_reg(cs, AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]),
>> +                                                        &fp_val);
>                                                             ^^^^^^^
>                                                             s/&fp_val/fp_val
>>   #else
>> -        reg.addr = (uintptr_t)q;
>> +        ret = kvm_set_one_reg(cs, AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]), &q);
>                                                                                ^^^
>                                                                               s/&q/q
>                                                                                
>>   #endif

Whoops, I thought I had double-checked these...


