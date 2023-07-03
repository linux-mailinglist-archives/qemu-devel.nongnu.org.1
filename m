Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 943557454BA
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 07:17:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGBuU-00070d-F1; Mon, 03 Jul 2023 01:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGBuR-0006zt-Cq
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 01:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGBuN-00067g-Tt
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 01:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688361329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J+1SiybUOJyci9HeiGlz50lCOzgGxCB0YY2OW5NgJqI=;
 b=G3tSwyfyKquDUl2AZSkFRCZosuatRSOev2FPYfD8Qk4vW6mS7Ra9uO5Guz8BYVI7Xu12I7
 JVib6Q1NaNUDnaVf5VGVsxYgSjRuEfgPhcGDHRJFf1koEHkbfQJuMKaJE2ZeJKGhEjKny1
 JiMhFQwYYdo6FGaHwpVmMAQyKCTJARA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-kfv2LTxgO3iJ5ocdFsxEpQ-1; Mon, 03 Jul 2023 01:15:27 -0400
X-MC-Unique: kfv2LTxgO3iJ5ocdFsxEpQ-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-55b473e5268so4069959a12.2
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 22:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688361326; x=1690953326;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J+1SiybUOJyci9HeiGlz50lCOzgGxCB0YY2OW5NgJqI=;
 b=evWoAnF0kaYrZe/Cv7jcu92hXoBgjiJQouNa3AGLyB0v/n94oS3UkN/Vk46drNu+wS
 w/FC81nADIDmA2VNuPMwKUoVJT7n8zGqg1ARwO8/nLD9YMkdf/3EvTzqQ9cYpUo+XpYf
 +fk3bdO+wyQfQhcf+aI1smavXAHVt2wKlVmL7r1G2ObFD6V6nNRN62muCi/nE6efq6VK
 dKjLGkQmc7vsEG6QvEXLGxLwVIxIUV8esAYT/2imtOzfZiO8BMB7XMsH7GLs+UcP8jkP
 OHk29Mf741JIdomhwQpeiQZ+5O1oSvygbkUJ4Prxc6qeL0D0J/BMswDcFsi7cKroyi3N
 gqeQ==
X-Gm-Message-State: AC+VfDy8Vvn3u+zXqEmasXfkM0ThSpibNOvVNhDNAD3qWLz4zb+x80Bb
 seuwguopQVEC1VEytUAHw+Hk5ReOubgFHf4s9ifrL3o69xi/Kgj60vMqoMTFi3xX4uYK8j1RJvy
 HwI0GUl1dW833dJ4=
X-Received: by 2002:a05:6a20:7d8b:b0:11f:84d4:2fa8 with SMTP id
 v11-20020a056a207d8b00b0011f84d42fa8mr10314302pzj.40.1688361326547; 
 Sun, 02 Jul 2023 22:15:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4RI1QsVde+OGfS5zKMGKOnIOxMa+7gWejZ4LqxHErB32lW8XKQg9V7spa+ZzlbkzW4DVIWFQ==
X-Received: by 2002:a05:6a20:7d8b:b0:11f:84d4:2fa8 with SMTP id
 v11-20020a056a207d8b00b0011f84d42fa8mr10314291pzj.40.1688361326245; 
 Sun, 02 Jul 2023 22:15:26 -0700 (PDT)
Received: from smtpclient.apple ([203.212.242.239])
 by smtp.gmail.com with ESMTPSA id
 e26-20020aa7825a000000b006687b41c4dasm13276301pfn.110.2023.07.02.22.15.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 02 Jul 2023 22:15:25 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH 0/3] pci: Fix ARI next function numbers
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230702083357.13517-1-akihiko.odaki@daynix.com>
Date: Mon, 3 Jul 2023 10:45:20 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8E30E588-3D80-49DD-8551-6422EB35EFEB@redhat.com>
References: <20230702083357.13517-1-akihiko.odaki@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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



> On 02-Jul-2023, at 2:03 PM, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>=20
> The ARI next function number field is undefined for VF. The PF should
> end the linked list formed with the field by specifying 0.
>=20
> Supersedes: <20230701070133.24877-1-akihiko.odaki@daynix.com>
> ("[PATCH 0/4] pci: Compare function number and ARI next function =
number")

Normally we do this using patch version numbers because otherwise over =
email, its hard to track the various iterations of the patches trying to =
solve the same thing.

>=20
> Akihiko Odaki (3):
>  docs: Fix next function numbers in SR/IOV documentation
>  hw/nvme: Fix ARI next function numbers
>  igb: Fix ARI next function numbers
>=20
> docs/pcie_sriov.txt | 4 ++--
> hw/net/igb.c        | 2 +-
> hw/nvme/ctrl.c      | 2 +-
> 3 files changed, 4 insertions(+), 4 deletions(-)
>=20
> --=20
> 2.41.0
>=20


