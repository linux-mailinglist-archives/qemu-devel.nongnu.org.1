Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F38397449C1
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 16:32:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFbd7-0001iQ-EB; Sat, 01 Jul 2023 10:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qFbd5-0001ho-EB
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 10:31:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qFbd2-0001KB-Rk
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 10:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688221871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E71uuT+fQuh/mSlJdR32R8r5VvS6JMp7AKRTtok/H7o=;
 b=OlJNbvgXfkiMU6IlalA/dpv9NFc/OoQ//KJKRN0CQNezSzEDx00LFQijBiDSiX4/U0t5y7
 2FMkQD9MUFMangjZ0adJdY21UUzSfAWE97rR7S28/t7/wUpmX5biH39JDVCE3XYpzv8L1m
 RUIkCivjcBXFEovyRQ3VBj/pJ30cG2E=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-hcJDxnG3PYCPG5zgbr8S0Q-1; Sat, 01 Jul 2023 10:31:09 -0400
X-MC-Unique: hcJDxnG3PYCPG5zgbr8S0Q-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-666e7b83930so2704881b3a.3
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 07:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688221867; x=1690813867;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E71uuT+fQuh/mSlJdR32R8r5VvS6JMp7AKRTtok/H7o=;
 b=aEjjWS3p4TFNPkaSf3YKFAkr7VyIWvYxi7lWCU1vwCbzAlf5WYZkJMr8rxWwNjxu2X
 OTTmE0GtrCbMmoHkk3eUZ6e35KFhR/tNBmcxqR3LFtSZ93BOocBShiZ23dVztsdvyttb
 pVf/pRxeAgY0VCl5k4XSVpbEln/UgHnxglkc1nVC6u3aeo2+nLRRvIsA82ty6xTO600+
 BX/gj9umO3339ydrS+4ynBAFfEbLSOHcNIyvWs0OGYV3hE7MZH6NCjLcEihr/sdyh3/w
 R9W0k/yvLxbbhljFovdHXeQLwy3ylsToPKjizk/BirzOskwO8A4zk8HjcQICQClF9m7T
 +5Mw==
X-Gm-Message-State: AC+VfDwRi2CtyudD+1Bgfnaq+UnWJGJ0smH3PrEOG9phpbLtoGqCfOR5
 DfwbwZ0duuA21pyQVYFrK5JfjKgCazDw3+RLAALDhweD6s3xVP+Z4BiIz+wr2zJbXTmxA1YlCG7
 3hPxJBHqFLrytsh8=
X-Received: by 2002:a05:6a20:7f8d:b0:11d:162d:bb7 with SMTP id
 d13-20020a056a207f8d00b0011d162d0bb7mr4674937pzj.41.1688221867772; 
 Sat, 01 Jul 2023 07:31:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7g6U7qIFqdtTK+ziVUA+UyVyR2PAV1643Jbf7a1VmosPnapIXjA4hwCVTK7yQ+ibazXOez6Q==
X-Received: by 2002:a05:6a20:7f8d:b0:11d:162d:bb7 with SMTP id
 d13-20020a056a207f8d00b0011d162d0bb7mr4674915pzj.41.1688221867436; 
 Sat, 01 Jul 2023 07:31:07 -0700 (PDT)
Received: from smtpclient.apple ([115.96.117.132])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001b69303db65sm12471155plh.26.2023.07.01.07.31.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 01 Jul 2023 07:31:07 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH 1/4] docs: Fix next function numbers in SR/IOV
 documentation
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230701070133.24877-2-akihiko.odaki@daynix.com>
Date: Sat, 1 Jul 2023 20:01:01 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F9B87AA5-617E-4AD7-A2F8-92C54819F875@redhat.com>
References: <20230701070133.24877-1-akihiko.odaki@daynix.com>
 <20230701070133.24877-2-akihiko.odaki@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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



> On 01-Jul-2023, at 12:31 PM, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>=20
> The next function numbers are expected to form a linked list ending =
with
> 0.
>=20
> Fixes: 2503461691 ("pcie: Add some SR/IOV API documentation in =
docs/pcie_sriov.txt")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> docs/pcie_sriov.txt | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt
> index 7eff7f2703..cc4232e49a 100644
> --- a/docs/pcie_sriov.txt
> +++ b/docs/pcie_sriov.txt
> @@ -48,7 +48,7 @@ setting up a BAR for a VF.
>       ...
>       int ret =3D pcie_endpoint_cap_init(d, 0x70);
>       ...
> -      pcie_ari_init(d, 0x100, 1);
> +      pcie_ari_init(d, 0x100, fun_offset);
>       ...
>=20
>       /* Add and initialize the SR/IOV capability */
> @@ -76,9 +76,10 @@ setting up a BAR for a VF.
>    pci_your_vf_dev_realize( ... )
>    {
>       ...
> +      uint16_t nextvfn =3D pcie_sriov_vf_number(dev) + 1;
>       int ret =3D pcie_endpoint_cap_init(d, 0x60);
>       ...
> -      pcie_ari_init(d, 0x100, 1);
> +      pcie_ari_init(d, 0x100, nextvfn < total_vfs ? fun_offset + =
nextvfn * stride : 0);
                                                                         =
                                                                         =
  ^^^^
I think this will be fun_offset and not just 0
Same with the other patches ..

>       ...
>       memory_region_init(mr, ... )
>       pcie_sriov_vf_register_bar(d, bar_nr, mr);
> --=20
> 2.41.0
>=20


