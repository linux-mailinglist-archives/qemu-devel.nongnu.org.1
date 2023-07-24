Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F13775EE4C
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 10:49:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNrFG-0007EB-67; Mon, 24 Jul 2023 04:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qNrFE-0007Di-Gl
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:48:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qNrFC-0007na-GB
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690188521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CJ6ZG+0vLUsia/tm0ndIdy96+hJ8O488N7k/b0KMW2M=;
 b=GY2hxR0qO8tR8xxPKSUm66MYZ2s6DYrUFhe3EZyQK4glf3tW4JoaiTzAD52Q4NTVwRcg2m
 rnrFfHeIl86BysSxj62GLyRha05RQy7au2AvkLgTKCmgO8PqIpdeFApe2+QaL/JPhzx+vx
 I9rINKxG0KiOMO3NBoFVWA1/YGmpEQg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-l62iWj7YPFuKhdCBjfwx4A-1; Mon, 24 Jul 2023 04:48:37 -0400
X-MC-Unique: l62iWj7YPFuKhdCBjfwx4A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06DE7104D514;
 Mon, 24 Jul 2023 08:48:37 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C46FAF7833;
 Mon, 24 Jul 2023 08:48:36 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Gavin Shan <gshan@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH for-8.2 2/2] arm/kvm: convert to kvm_get_one_reg
In-Reply-To: <db578c20-22d9-3b76-63e7-d99b891f6d36@redhat.com>
Organization: Red Hat GmbH
References: <20230718111404.23479-1-cohuck@redhat.com>
 <20230718111404.23479-3-cohuck@redhat.com>
 <db578c20-22d9-3b76-63e7-d99b891f6d36@redhat.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 24 Jul 2023 10:48:35 +0200
Message-ID: <878rb5g0f0.fsf@redhat.com>
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

On Mon, Jul 24 2023, Gavin Shan <gshan@redhat.com> wrote:

> Hi Connie,
>
> On 7/18/23 21:14, Cornelia Huck wrote:
>> We can neaten the code by switching the callers that work on a
>> CPUstate to the kvm_get_one_reg function.
>> 
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>   target/arm/kvm.c   | 15 +++---------
>>   target/arm/kvm64.c | 57 ++++++++++++----------------------------------
>>   2 files changed, 18 insertions(+), 54 deletions(-)
>> 
>
> The replacements look good to me. However, I guess it's worty to apply
> the same replacements for target/arm/kvm64.c since we're here?
>
> [gshan@gshan arm]$ pwd
> /home/gshan/sandbox/q/target/arm
> [gshan@gshan arm]$ git grep KVM_GET_ONE_REG
> kvm64.c:    err = ioctl(fd, KVM_GET_ONE_REG, &idreg);
> kvm64.c:    return ioctl(fd, KVM_GET_ONE_REG, &idreg);
> kvm64.c:        ret = ioctl(fdarray[2], KVM_GET_ONE_REG, &reg);

These are the callers that don't work on a CPUState (all in initial
feature discovery IIRC), so they need to stay that way.


