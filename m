Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F2B712836
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 16:29:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2YQk-0003qp-MT; Fri, 26 May 2023 10:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q2YQf-0003ot-Gl
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q2YQd-0008VH-Ld
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685111306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1coDur2GYu627vDC4xo9p6xFnmof47TFKAKmHbWpgnk=;
 b=WrBA4uLNzuwm2HP9W1IKbUy6R+Y57zUeVxerUiM2khUEOnYnZ6iL/KHXvEutAZayiRkun0
 ObsonnM84TBxDTg/5A3JFL3TSw7OIyMCha3HyN64WwBCrg9Z3umXl32PNozDlm7tPiotqD
 L2SxWR9fk2r8J4HWlLO4VVuEjskYABc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-5cxmEqUpPQW_FUI7AwDL2w-1; Fri, 26 May 2023 10:28:25 -0400
X-MC-Unique: 5cxmEqUpPQW_FUI7AwDL2w-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-97005627685so91617566b.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 07:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685111303; x=1687703303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1coDur2GYu627vDC4xo9p6xFnmof47TFKAKmHbWpgnk=;
 b=VeBpXnxbcHdDzJz8mjWVhZnmIYC6XSwp7LngmdbN4gRGyWI8YQfU2JrNSBN/y2AUKh
 VeO3stijASFR8RZdXIkZyFT8xMw5FJ0VKhNLDVbx7wo2HrFf73jHlBVrz9uJXp4CE6hq
 rra3xM5j4q5ur2BzgB4j67B8swfDVGhiRV9WFDswNyNFOIoxwd09E8MEN/xMZE28dEgm
 XmivrbylgMVmH4glo5w1bnZrIUFE+2zSZYVruvH8rZd76EZPNCR/22iMNKORuN/RdXE2
 mFPAdkX0V7hfBDxTmeS7A2pzzETWEoaFxaAZKzTwV+7srEjsVwKSo2ILb9axXqLsYiPc
 vCpQ==
X-Gm-Message-State: AC+VfDx5zZlIKU9q877jyv1qwtDt1eROw0WXSaND2cNenPrthBARlGlk
 x/G/y9mzDgN/O8/dzGDihDP0wjv4ekclx1wrawyaRVxEFkUEspAgSDR50kCi8kBIqDqlO2Mmg1Z
 ZgyCo52n+IDM1LCZMBN1icSU=
X-Received: by 2002:a17:907:72cc:b0:973:8198:bbf6 with SMTP id
 du12-20020a17090772cc00b009738198bbf6mr2153105ejc.3.1685111303267; 
 Fri, 26 May 2023 07:28:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7k+TukbhgFxpFbwnTJCFvL8g7/noqy1hduUURif+lNo4T0twf4/pCtN6/2Yp8BxBN9rDqENA==
X-Received: by 2002:a17:907:72cc:b0:973:8198:bbf6 with SMTP id
 du12-20020a17090772cc00b009738198bbf6mr2153092ejc.3.1685111302954; 
 Fri, 26 May 2023 07:28:22 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 lx6-20020a170906af0600b0096efa536229sm2269279ejb.149.2023.05.26.07.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 07:28:22 -0700 (PDT)
Date: Fri, 26 May 2023 16:28:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Dinah Baum <dinahbaum123@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [RESEND PATCH v2 0/3] Enable -cpu <cpu>,help
Message-ID: <20230526162821.455a5c4c@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230404011956.90375-1-dinahbaum123@gmail.com>
References: <20230404011956.90375-1-dinahbaum123@gmail.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon,  3 Apr 2023 21:19:53 -0400
Dinah Baum <dinahbaum123@gmail.com> wrote:

> Part 1 is a refactor/code motion patch for
> qapi/machine target required for setup of
> 
> Part 2 which enables query-cpu-model-expansion
> on all architectures
> 
> Part 3 implements the '<cpu>,help' feature
> 
> Limitations:
> Currently only 'FULL' expansion queries are implemented since
> that's the only type enabled on the architectures that
> allow feature probing
> 
> Unlike the 'device,help' command, default values aren't
> printed

what's wrong with 'device,help' if it's used for cpu devices?

> 
> Changes since v2: Rebase
> 
> Dinah Baum (3):
>   qapi/machine-target: refactor machine-target
>   cpu, qapi, target/arm, i386, s390x: Generalize
>     query-cpu-model-expansion
>   cpu, qdict, vl: Enable printing options for CPU type
> 
>  MAINTAINERS                      |   1 +
>  cpu.c                            |  61 +++++++++++++++
>  include/exec/cpu-common.h        |  10 +++
>  include/qapi/qmp/qdict.h         |   2 +
>  qapi/machine-target-common.json  | 130 +++++++++++++++++++++++++++++++
>  qapi/machine-target.json         | 129 +-----------------------------
>  qapi/meson.build                 |   1 +
>  qemu-options.hx                  |   7 +-
>  qobject/qdict.c                  |   5 ++
>  softmmu/vl.c                     |  36 ++++++++-
>  target/arm/arm-qmp-cmds.c        |   7 +-
>  target/arm/cpu.h                 |   7 +-
>  target/i386/cpu-sysemu.c         |   7 +-
>  target/i386/cpu.h                |   6 ++
>  target/s390x/cpu.h               |   7 ++
>  target/s390x/cpu_models_sysemu.c |   6 +-
>  16 files changed, 278 insertions(+), 144 deletions(-)
>  create mode 100644 qapi/machine-target-common.json
> 


