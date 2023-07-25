Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B95760AD0
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 08:48:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOBpL-00050x-3o; Tue, 25 Jul 2023 02:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qOBos-0004xa-8p
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 02:46:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qOBoq-0006zW-Rc
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 02:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690267612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=89TD0GkjXHYtreaQbauxAJjOlVd2myWjOp9c68ed0sA=;
 b=iYzXFtL6dO4AQ4NgmXtkCz3qdgh3gk5IsRsQ8NdbWxfpLBjZJCQfkiXEf00BIqSH63YRNn
 Vs4Fo5mxLOd/ri+hqnEotl+GgkAGlJYuvwV2Rhr1ryDaiCDF09y5e7/53XS7yH2ilR+UEy
 lNDg7iLzn14GjCoh5c5wRmsVGxGVCUw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-D2RuQt5AOjmvPnHWvuRBog-1; Tue, 25 Jul 2023 02:46:50 -0400
X-MC-Unique: D2RuQt5AOjmvPnHWvuRBog-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-51e278a3a2dso4093934a12.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 23:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690267609; x=1690872409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=89TD0GkjXHYtreaQbauxAJjOlVd2myWjOp9c68ed0sA=;
 b=KC2HZxRPTi8tUa8hIyj/yYXWtQKouH3gdvrRjCxsy8uXm1307G1Kqk/kh4oFQG5rEZ
 myZUcs7vBnU/V+ziOF9rGXxemGdif/s9FAc++4wX5+iWAmClepIV5Y4P7Swc/6UPoGhH
 hxkgup+zlgHUbXOZepn9JKaclt2ZFNuz7B5yxzWfCHvLgSq6PUmBKr222npeZQm4I4Y5
 ySGb+glHbENf92xmDejBAXJHnxNi+ryO0KUFn6sbJALiqBma/KfuBjJEycw4FHbgjt+t
 inCC9YQBBoYSBC/+GizR+jVmO6vLuGhMiUUf0ZbHAkNCRNWwBu7uDlGOZYKkMtoHBN4g
 Z09w==
X-Gm-Message-State: ABy/qLZXE81Bby/XXruf/MFD/mzfEYIZEejCfag9EwCxdIoAinPusaSu
 dddrXcUEFXMhphWdbdFdU864gOzLBeLp6wyWeMovSRdIDUpYi4ebjYyydSy71Tk1PXyWKBed0zd
 ri24Pf1wOAjiT7HA=
X-Received: by 2002:aa7:df14:0:b0:522:561f:83c2 with SMTP id
 c20-20020aa7df14000000b00522561f83c2mr183085edy.1.1690267609515; 
 Mon, 24 Jul 2023 23:46:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFvr3aXCoxkUi7+1rwr/tpKbi4cy+phtwptXlsPLQfXNDFjUeLOdYTykckIRU4yyrvoBonOdw==
X-Received: by 2002:aa7:df14:0:b0:522:561f:83c2 with SMTP id
 c20-20020aa7df14000000b00522561f83c2mr183060edy.1.1690267609146; 
 Mon, 24 Jul 2023 23:46:49 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 f15-20020aa7d84f000000b0051de2455041sm7121026eds.24.2023.07.24.23.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 23:46:48 -0700 (PDT)
Date: Tue, 25 Jul 2023 08:46:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gavin Shan <gshan@redhat.com>, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, pbonzini@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 shan.gavin@gmail.com, berrange@redhat.com
Subject: Re: [PATCH 0/3] hw/arm/virt: Use generic CPU invalidation
Message-ID: <20230725084647.082428f3@imammedo.users.ipa.redhat.com>
In-Reply-To: <CAFEAcA-Tp7_vpGUea4W6cf3rTDqqGKy6VtsguDjiSAbRX=dL=Q@mail.gmail.com>
References: <20230713054502.410911-1-gshan@redhat.com>
 <CAFEAcA8197FCwfNZrnxfO-87RveOko0Ju-KcTJOEi0vfjVtDKg@mail.gmail.com>
 <2d21e89f-c965-e8f1-3705-dfea8367fc7e@linaro.org>
 <CAFEAcA-XK0U0bPuAf4K7avdJqnmcibFX_swY1Weo_Tn3wHJ1fw@mail.gmail.com>
 <20230714135004.230c05b2@imammedo.users.ipa.redhat.com>
 <CAFEAcA92QFxN0at+5rk7yrfk1sj3tX-GcfZYYY5_=210np_j4g@mail.gmail.com>
 <20230717144455.6f02fde9@imammedo.users.ipa.redhat.com>
 <527ed3dc-b723-5c37-37e2-58d4266b1f32@redhat.com>
 <20230724170604.74b4ca0a@imammedo.users.ipa.redhat.com>
 <CAFEAcA-Tp7_vpGUea4W6cf3rTDqqGKy6VtsguDjiSAbRX=dL=Q@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Mon, 24 Jul 2023 16:14:22 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 24 Jul 2023 at 16:06, Igor Mammedov <imammedo@redhat.com> wrote:
> > I've seen others asking why you print type name instead of shorter cpu-model
> > used on CLI. To do that would make you write a patch to implement reverse mapping.
> > In some cases it's simple, in others plain impossible unless you can get
> > access to -cpu foo stored somewhere.
> >
> > What I don't particularity like about adding reverse type->cpu_model mapping,
> > is that it would complicate code to carter to QEMU's interface inconsistencies.
> > And if you do it easy way (instead of fixing every target) touching only ARM,
> > it will be spotty at best and just add to technical debt elsewhere ->
> > more inconsistencies.
> >
> > What I'm proposing is for you to keep printing type names.
> > So if others won't object to type names I'm more or less fine with your
> > current approach.  
> 
> I do object to type names, because the UI for choosing
> a CPU ("-cpu whatever") does not take type names, it
> takes CPU names. The QOM type names that those end up
> being under the hood are a detail of QEMU's implementation
> that we shouldn't expose to users in the help messages.

those are exposed to users as a part of -device interface
which uses typenames for any device and based on that interface
in some monitor/qmp commands 

> > Instead of adding type->cpu_model mapping (it's not the first time
> > this particular question had arisen - there were similar patches before
> > on qemu-devel), get rid of shortened cpu_model in user interface (-cpu)
> > altogether and use CPU type name there.  
> 
> I also think we should not do this, because it will break
> a ton of existing command lines, and it's not clear it
> has any benefit to users.

Yes it will break existing scripts but that for users to fix up once
(not to mention that could be worked around with a wrapper,
QEMU can even supply that for existing cpu types).
(so along with deprecation, we can provide a warning +
a wrapper to use, and after deprecation make it a hard error
but keep wrapper around for those that do not wish to use typenames)

Consistent naming across UI and consistent name -> type handling 
would be beneficial to users in the long run (especially ones
that have to deal with both interfaces so that they won't
have to bother which use where).

> thanks
> -- PMM
> 


