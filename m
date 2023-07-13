Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3AB752189
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 14:46:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJviJ-0007WF-53; Thu, 13 Jul 2023 08:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qJviD-0007RF-1D
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 08:46:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qJviB-0001ZD-Ia
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 08:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689252382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Na+kCnNj/UTr9FDqRKxyFnSiNymAfK65QMKbN71Qyak=;
 b=CcFlhzxbMRMBmYMH5/i1zWtqDgoO+mYl+u2gIAY+MrKus4ZCNZgTnGdfzE5P8qH26D4Xyq
 RXaV97c03b/gyP/XnFpefNSUFDZjTcw+UlYmM+4IM+9E1q+FAlUQgJ3sh2/DyFTd18f4s0
 1GH2Y+BCLL4sBAbQUDB8otUCDo8Ikks=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-RTE30MPEMxClsO-c1fetIg-1; Thu, 13 Jul 2023 08:46:20 -0400
X-MC-Unique: RTE30MPEMxClsO-c1fetIg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A439429A9D42;
 Thu, 13 Jul 2023 12:46:19 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 39953C1ED96;
 Thu, 13 Jul 2023 12:46:19 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, eduardo@habkost.net,
 peter.maydell@linaro.org, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, shan.gavin@gmail.com
Subject: Re: [PATCH 3/3] hw/arm/virt: Support host CPU type only when KVM or
 HVF is configured
In-Reply-To: <20230713054502.410911-4-gshan@redhat.com>
Organization: Red Hat GmbH
References: <20230713054502.410911-1-gshan@redhat.com>
 <20230713054502.410911-4-gshan@redhat.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Thu, 13 Jul 2023 14:46:17 +0200
Message-ID: <87o7kgq8rq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 13 2023, Gavin Shan <gshan@redhat.com> wrote:

> The CPU type 'host-arm-cpu' class won't be registered until KVM or
> HVF is configured in target/arm/cpu64.c. Support the corresponding
> CPU type only when KVM or HVF is configured.
>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  hw/arm/virt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 43d7772ffd..ad28634445 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -217,7 +217,9 @@ static const char *valid_cpu_types[] = {
>  #endif
>      ARM_CPU_TYPE_NAME("cortex-a53"),
>      ARM_CPU_TYPE_NAME("cortex-a57"),
> +#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
>      ARM_CPU_TYPE_NAME("host"),
> +#endif
>      ARM_CPU_TYPE_NAME("max"),
>      NULL
>  };

Doesn't the check in parse_cpu_option() already catch the case where
the "host" cpu model isn't registered? I might be getting lost in the
code flow, though.


