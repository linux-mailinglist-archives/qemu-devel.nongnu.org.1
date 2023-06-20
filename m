Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F415736F53
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 16:56:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBclH-0002G2-7I; Tue, 20 Jun 2023 10:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBclF-0002Fm-E3
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:55:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBclE-000248-07
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687272899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N0vcTkq3hhD8raDcSoY9kEwoGWptQCEnJkfNRj5GiDw=;
 b=NL5+nuRJ36V2Id8ENYv7fSNrTwiWnyLaUuBBHtRFn9z6lMeEgq73HD2ZIGcdL5h+WUwgn/
 5gTzPB+d1P2q75zZ65r4L/r0/I7DTF62II6ByaXwydYpAe7/WMAliVb+HxNQKhRmC1h1x2
 RR8QIacK7VmGG8re2QDLo2qZ++/t33s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-zEVfgQ51PCaS4ILtnTSobA-1; Tue, 20 Jun 2023 10:54:52 -0400
X-MC-Unique: zEVfgQ51PCaS4ILtnTSobA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-76077669a5aso123840285a.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 07:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687272892; x=1689864892;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0vcTkq3hhD8raDcSoY9kEwoGWptQCEnJkfNRj5GiDw=;
 b=LXoXGgOvEW0dmZmOCHTyHxNBBKaps7UsnMuf1p2fInd9SK+ofu5j+l0sJ/2Gk8sMOM
 VefoKyPG3uEORylY+QXN1ty1jz+BUdPk5cJCOrD+lrSmuGuDmwKSFkQ72H3MW7yH4ueh
 tHfM69o80Yfa1sqrS+G+a/FX/2G+DhciPnZ3AwGRWvxf6IfqsgZelBy2nPss6agubWyv
 jpnCChUsy18keXFKnFie+kBpn+eK0+pA5yc+bt9uR1+kXZrEM0MD2SYmuk5HyK8TPguz
 fwLCwsFRW37QjtomzxBJr7NB66qeQBTNuJGQ1Qj+JgRDD/RnITrJkFZfeCRJdCzBvGpE
 xTpQ==
X-Gm-Message-State: AC+VfDxMpyvLGbPBWufDiRsvJX34uJoXggUPa35G8qJwpCYIktExhlFY
 IWzz/Ds6kUKHyBHSnC7e2UwRV8zjptjKqG9Gbe19eHYSHs9nvBwN9dXo41eLtvd+mH0xCfbJ9dW
 1mtEo7A0z9aZEmDQ=
X-Received: by 2002:a05:620a:2784:b0:763:a511:48b9 with SMTP id
 g4-20020a05620a278400b00763a51148b9mr4107534qkp.1.1687272892029; 
 Tue, 20 Jun 2023 07:54:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4uhNE8hlGv+UoW88v85cald0c+ltwQ+FRmOoxS83uOlDgfSCc3q7B7U2LVsxNU2urX0+xagg==
X-Received: by 2002:a05:620a:2784:b0:763:a511:48b9 with SMTP id
 g4-20020a05620a278400b00763a51148b9mr4107516qkp.1.1687272891722; 
 Tue, 20 Jun 2023 07:54:51 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 t26-20020a05620a005a00b0075ecdc937ffsm1204840qkt.41.2023.06.20.07.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 07:54:51 -0700 (PDT)
Date: Tue, 20 Jun 2023 10:54:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 01/42] migration-test: Be consistent for ppc
Message-ID: <ZJG9utW5qi04ZM7s@x1n>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608224943.3877-2-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, Jun 09, 2023 at 12:49:02AM +0200, Juan Quintela wrote:
> It makes no sense that we don't have the same configuration on both sides.

I hope Laurent can see this one out of 40s.

Makes sense to me, but does it mean that the devices are not matching
before on ppc?  Confused how did it work then..

> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/qtest/migration-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index b0c355bbd9..c5e0c69c6b 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -646,7 +646,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                        "'nvramrc=hex .\" _\" begin %x %x "
>                                        "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
>                                        "until'", end_address, start_address);
> -        arch_target = g_strdup("");
> +        arch_target = g_strdup("-nodefaults");
>      } else if (strcmp(arch, "aarch64") == 0) {
>          init_bootfile(bootpath, aarch64_kernel, sizeof(aarch64_kernel));
>          machine_opts = "virt,gic-version=max";
> -- 
> 2.40.1
> 

-- 
Peter Xu


