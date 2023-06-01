Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6A0719505
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:06:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4dJ9-00087s-6I; Thu, 01 Jun 2023 04:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eskultet@redhat.com>)
 id 1q4dJ3-00087R-1v
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:05:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eskultet@redhat.com>)
 id 1q4dJ0-0006Kj-Ue
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685606710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2iXuCiXA3FLSnhc8kcrILH/kfeTz9V97FbiZPu1wLk=;
 b=B1wjNnLtiKcRRBEKrbgVHPYQqFdxfMhZLwSqV5Luv9+RXFsHT7ZgoFGE3AiCR3/wRfePX1
 PmdygoOhXRKVMq1hUx1fGRaqV3sq9otBCtI3f9SSArp/Zk4eCP2VIyDd4opbIm7svdzSTt
 oj2GSK38vvWUgDhSHJb0hFyN3cJqZi8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-zWO8-eO8PCO5vwETvG1OMQ-1; Thu, 01 Jun 2023 04:05:09 -0400
X-MC-Unique: zWO8-eO8PCO5vwETvG1OMQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-94a356c74e0so33143766b.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 01:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685606708; x=1688198708;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O2iXuCiXA3FLSnhc8kcrILH/kfeTz9V97FbiZPu1wLk=;
 b=gnU1kOSaStOJVAEueDxQvPislHclMkMAf84TSmJ33aJugNNId0SphDjL6DU4H6Mmwc
 3A9f6SBmhyuSRSaDZzhuj3J/0xI5c/oYjcQWZmkPLImP/roJfQ9lfHpcHvrgAZb4h1Cd
 p/ZoZJo5BDP0ytM+SHCgCTjeLK+PtQMaMW6C3YkI+rXEI/tGpJ2oOMHQ3lVmpFIlateq
 2CY5Ru9pTBfyyGMVfo7MchgEUSCy9V8MWLaafHw5yCDTL1o3Vv5gMXB4DEoB6/S+PIcJ
 zu/UtnxYPlMDZ7lf/9oTQnU/6y/osYExiVEuLi4ifb3bOUcverkbjfQFhL3GUdMAKCpS
 6Iyg==
X-Gm-Message-State: AC+VfDyGuGTkQokLQyF1pOlh5GyPdLC/9FxPPzOjExb0yYa8dkh5QZhr
 zK9dzkRx7oUGu1AipojkneixWDFdSr0TjOLDP/U/hEVW+Qe4HPNgzFpOrN/OdCQM4MUUekCzBjz
 FRrXsOdiUQaA+YZk=
X-Received: by 2002:a17:907:3ea0:b0:94f:694e:b953 with SMTP id
 hs32-20020a1709073ea000b0094f694eb953mr7639607ejc.59.1685606708083; 
 Thu, 01 Jun 2023 01:05:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ48d/5T7703zjZueEZi/nwPI5x9kVCJcRrt0haFbu+SV1wILT58vHYkH5Zp6Nr8GLOwc6RyJw==
X-Received: by 2002:a17:907:3ea0:b0:94f:694e:b953 with SMTP id
 hs32-20020a1709073ea000b0094f694eb953mr7639595ejc.59.1685606707783; 
 Thu, 01 Jun 2023 01:05:07 -0700 (PDT)
Received: from ridgehead.home.lan (cst2-15-35.cust.vodafone.cz. [31.30.15.35])
 by smtp.gmail.com with ESMTPSA id
 q26-20020a17090622da00b0096f7cf96525sm10269089eja.146.2023.06.01.01.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 01:05:07 -0700 (PDT)
Date: Thu, 1 Jun 2023 10:05:06 +0200
From: Erik Skultety <eskultet@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/3] tests/vm/freebsd: Get up-to-date package list from
 lcitool
Message-ID: <ZHhRMnXmUf4dEyLd@ridgehead.home.lan>
References: <20230531200906.17790-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230531200906.17790-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eskultet@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

On Wed, May 31, 2023 at 10:09:03PM +0200, Philippe Mathieu-Daudé wrote:
> Inspired by this patch from Thomas:
> https://lore.kernel.org/qemu-devel/20230531090415.40421-1-thuth@redhat.com/
> 
> Instead of updating the package list manually, use lcitool vars file.
> 
> Philippe Mathieu-Daudé (3):
>   tests/vm: Pass project source path to build_image()
>   tests/vm: Introduce get_qemu_packages_from_lcitool_vars() helper
>   tests/vm/freebsd: Get up-to-date package list from lcitool vars file
> 
>  tests/vm/Makefile.include |  1 +
>  tests/vm/basevm.py        | 10 +++++++--
>  tests/vm/centos           |  2 +-
>  tests/vm/centos.aarch64   |  2 +-
>  tests/vm/freebsd          | 46 +++++----------------------------------
>  tests/vm/haiku.x86_64     |  2 +-
>  tests/vm/netbsd           |  2 +-
>  tests/vm/openbsd          |  2 +-
>  tests/vm/ubuntuvm.py      |  2 +-
>  9 files changed, 20 insertions(+), 49 deletions(-)
> 
> -- 
> 2.38.1
> 

From my POV the changes are pretty straight-forward, but I'll let others who
use this code on pretty much daily basis to comment. What I'll say though is
that I only just now looked at the Python VM spawner helpers you have and it
left me wondering whether there'd be interest in dropping much of the code in
favour of lcitool invocations - not all, not even trying to say it would be
100% smooth, but it would
1) give lcitool even bigger exposure
2) find bugs
3) generalize the functionality even more
4) open doors for more features needed by the community

Specifically looking at the vm/centos source file, we recently added support
for downloading guests from vendor-provided cloud images (asking libosinfo for
the URL to download from )which are cached essentially the same way as your
code does and then provisions it using a storage overlay. Package installation
and other configuration is done via Ansible, so root SSH is taken care of,
serial console is force enabled, etc.

If the community were interested in migrating the aforementioned functionality
to lcitool wrt/ provisioning local VMs (no FreeBSD at the moment though :(  [1])
I'd be happy to help with that.

Regards,
Erik

[1] recently I saw a statement somewhere that FreeBSD is finally considering
providing official cloud-init template images and that it should happen some
time this year, so knowing this I'd rather wait some more than to add yet
another code to special-case the cloud-init provisions with lcitool for FreeBSD


