Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C98077A91FB
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:18:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjDve-0006ac-CO; Thu, 21 Sep 2023 03:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjDvZ-0006a2-UO
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:16:45 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjDvN-0002Gn-VS
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:16:37 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c3d8fb23d9so5116555ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 00:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695280580; x=1695885380;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:to:references:cc
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gtZnJWNLETty86cmt5G3BLku52AJOJobMcOTxivz8yE=;
 b=zeBNc3TJsL3Ih0FwdM3iInlYIpMh2H4SI8cEP3OBJcjxZvJ7qfooqZfhZs63vV/p1C
 LJDbOOoUv2OTE2R3mfx7gV0zszxNyrx4VR62v01voWFr0TzxhywT8INcCzlo43FJKuT/
 J1mUSSilCpW4gn0EAmGxSJRp4v2U1U2j8Ry2Ppf4OCVV93DKMnjL4B2z9m4cfOa38FbK
 FoLSENCg1FvQEBlMRksqZm1zjJ7eg0aL0aI+9BXEpciSkIEcKHoku0W6KGcnSDm++6M9
 oJ+Vpr7Dn2zRs10lWwgYFwaaWDxEgvCtMw14GGzyQPn99f0CxujhPShOKXSZYOdoKzL3
 kjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695280580; x=1695885380;
 h=content-transfer-encoding:in-reply-to:from:to:references:cc
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gtZnJWNLETty86cmt5G3BLku52AJOJobMcOTxivz8yE=;
 b=XNU7dkmmm7ssyREyS71owC6BIuNNTsrUYunNaU14xGg8OldKyrgcJ63e3K1MIQ6Rgb
 MPGHbzZsFJni6fcOupg9yHMfIIo7x2DlmBrhXK0cwXd58sy54qqZG/Z89BlYcCQx/36L
 6QwYwTOt2eGHsud/5DNqhbqVhQ6l0RlQbrKKrNDITf6r/utUpd8TooDanw8Vtl/9ru2N
 S0NfFG5zlofvpTsq/XW+Dl31/3LAmLmZQtrKd3mMALWZ+rkL3VD7L2Nb9OLLOCKkzfFR
 0M0FC3lP8owlvHCVZMWcTUvnRc+r1m7lHhwIK+11TcPDT3FIWlJC5+fpbsOF/kMcglXE
 b0tQ==
X-Gm-Message-State: AOJu0Yy7H2TkZELBHimYEsQr/ULIaJT1KWNhtwzpCywTCXBmIMjYw2fK
 m+GKsTbQ6MXpsR21jOfBBrQQ0A==
X-Google-Smtp-Source: AGHT+IFp8SmlgBP8c+mRMAyR0w6VTD2Eh6KSEGcXkimXFn/Frnpi2Y+TlrFoKGccEOT8tgcZe9KSJQ==
X-Received: by 2002:a17:902:dac4:b0:1c3:fa9a:1e41 with SMTP id
 q4-20020a170902dac400b001c3fa9a1e41mr5409577plx.45.1695280580336; 
 Thu, 21 Sep 2023 00:16:20 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 jk12-20020a170903330c00b001bc930d4517sm688691plb.42.2023.09.21.00.16.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 00:16:20 -0700 (PDT)
Message-ID: <a2cb6356-18b1-44d1-90a8-d137e8a25227@daynix.com>
Date: Thu, 21 Sep 2023 16:16:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] net: Update MemReentrancyGuard for NIC
Content-Language: en-US
Cc: Mauro Matteo Cascella <mcascell@redhat.com>, P J P
 <pj.pandit@yahoo.co.in>, Alexander Bulekov <alxndr@bu.edu>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Sriram Yagnaraman
 <sriram.yagnaraman@est.tech>, Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Jan Kiszka <jan.kiszka@web.de>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sven Schnelle <svens@stackframe.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Rob Herring <robh@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 xen-devel@lists.xenproject.org
References: <20230601031859.7115-1-akihiko.odaki@daynix.com>
To: Jason Wang <jasowang@redhat.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230601031859.7115-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/06/01 12:18, Akihiko Odaki wrote:
> Recently MemReentrancyGuard was added to DeviceState to record that the
> device is engaging in I/O. The network device backend needs to update it
> when delivering a packet to a device.
> 
> This implementation follows what bottom half does, but it does not add
> a tracepoint for the case that the network device backend started
> delivering a packet to a device which is already engaging in I/O. This
> is because such reentrancy frequently happens for
> qemu_flush_queued_packets() and is insignificant.
> 
> This series consists of two patches. The first patch makes a bulk change to
> add a new parameter to qemu_new_nic() and does not contain behavioral changes.
> The second patch actually implements MemReentrancyGuard update.
> 
> V1 -> V2: Added the 'Fixes: CVE-2023-3019' tag
> 
> Akihiko Odaki (2):
>    net: Provide MemReentrancyGuard * to qemu_new_nic()
>    net: Update MemReentrancyGuard for NIC
> 
>   include/net/net.h             |  2 ++
>   hw/net/allwinner-sun8i-emac.c |  3 ++-
>   hw/net/allwinner_emac.c       |  3 ++-
>   hw/net/cadence_gem.c          |  3 ++-
>   hw/net/dp8393x.c              |  3 ++-
>   hw/net/e1000.c                |  3 ++-
>   hw/net/e1000e.c               |  2 +-
>   hw/net/eepro100.c             |  4 +++-
>   hw/net/etraxfs_eth.c          |  3 ++-
>   hw/net/fsl_etsec/etsec.c      |  3 ++-
>   hw/net/ftgmac100.c            |  3 ++-
>   hw/net/i82596.c               |  2 +-
>   hw/net/igb.c                  |  2 +-
>   hw/net/imx_fec.c              |  2 +-
>   hw/net/lan9118.c              |  3 ++-
>   hw/net/mcf_fec.c              |  3 ++-
>   hw/net/mipsnet.c              |  3 ++-
>   hw/net/msf2-emac.c            |  3 ++-
>   hw/net/mv88w8618_eth.c        |  3 ++-
>   hw/net/ne2000-isa.c           |  3 ++-
>   hw/net/ne2000-pci.c           |  3 ++-
>   hw/net/npcm7xx_emc.c          |  3 ++-
>   hw/net/opencores_eth.c        |  3 ++-
>   hw/net/pcnet.c                |  3 ++-
>   hw/net/rocker/rocker_fp.c     |  4 ++--
>   hw/net/rtl8139.c              |  3 ++-
>   hw/net/smc91c111.c            |  3 ++-
>   hw/net/spapr_llan.c           |  3 ++-
>   hw/net/stellaris_enet.c       |  3 ++-
>   hw/net/sungem.c               |  2 +-
>   hw/net/sunhme.c               |  3 ++-
>   hw/net/tulip.c                |  3 ++-
>   hw/net/virtio-net.c           |  6 ++++--
>   hw/net/vmxnet3.c              |  2 +-
>   hw/net/xen_nic.c              |  4 ++--
>   hw/net/xgmac.c                |  3 ++-
>   hw/net/xilinx_axienet.c       |  3 ++-
>   hw/net/xilinx_ethlite.c       |  3 ++-
>   hw/usb/dev-network.c          |  3 ++-
>   net/net.c                     | 15 +++++++++++++++
>   40 files changed, 90 insertions(+), 41 deletions(-)
> 

Hi Jason,

Can you review this series?

Regards,
Akihiko Odaki

