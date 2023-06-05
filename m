Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AC172208E
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 10:07:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q65FB-00016U-7q; Mon, 05 Jun 2023 04:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1q65F6-00012u-JS
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:07:10 -0400
Received: from esa10.hc2706-39.iphmx.com ([216.71.140.198])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1q65F4-0002pk-IT
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:07:08 -0400
X-IronPort-RemoteIP: 209.85.219.198
X-IronPort-MID: 285175985
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:fZMyYqAoJM35CRVW/5fhw5YqxClBgxIJ4kV8jS/XYbTApDp0hT0Cy
 TYfWz/VM/iLZzOkLohzaoXkpkpU757UzIJlTANkpHpgcSl2pJueD7x1DKtR0wB+jCHnZBg6h
 ynLQoCYdKjYdleF+lH2dOCn9SImvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYctitWia++3k
 YqaT/b3Zhn9g1aYDkpOs/jY8E034Kyr0N8llgdWic5j7Qe2e0Y9Ucp3yZGZdxPQXoRSF+imc
 OfPpJnRErTxpkpF5nuNy94XQ2VTKlLgFVHmZkl+AsBOtiN/Shkaic7XAha9hXB/0F1ll/gpo
 DlEWAfZpQ0BZ8Ugk8xEO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFPP6O9rC0ELLbY4xcRlBUFht
 tdCMj8kO0Xra+KemNpXS8Fpj8UnadjhZcYR4yAwiz7eCvkiTNbIRKCiCd1whm9hwJATW6yHN
 oxAOGoHgBfoOnWjPn8eDII4kP2AjGS5fjFFwL6QjfBnvjGMkV0hjdABNvLyYfCDee9QoHy6+
 FP9+jv2DAoIGNuQnG/tHnWEw7WncTnAcJsfEaD9+vN0jVm7wGsVBxsLE1yhrpGEZlWWXtteL
 wkF8HNro/FjpAqkSd7yWxD+q3mB1vIBZ+dt/yQBwFnl4sLpD8yxXADokhYphAQaifIL
IronPort-HdrOrdr: A9a23:+5C1e6D9hOvMTLLlHel655DYdb4zR+YMi2TDGXoBLiC9Vvbo6v
 xG/c5rryMc7Qx6ZJhOo6HjBEDtewK4yXcx2/hsAV7AZnichILLFvAa0WKK+VSJcFycygce79
 YZT0EXMr3N5DNB/KDHCWeDYrId6ejC2oyTwcnl81dRYTdDV5xAhj0JdTpz0XcbeOCFP/cE/V
 aniPavbgDOGEgqUg==
X-Talos-CUID: 9a23:MplR0W068etk8AyEuG9G47xfOes/d3rd8WfrA3CaG2JJZ/6+E0Wf0fYx
X-Talos-MUID: 9a23:DDAh2gUoTVbamLzq/Bj3qDheHsJW2YbwOXsIzpoIoNuoMiMlbg==
Received: from mail-yb1-f198.google.com ([209.85.219.198])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 05 Jun 2023 04:07:04 -0400
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-bb2202e0108so5467924276.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 01:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1685952423; x=1688544423;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nBsE6ZSAQNXrqj2aXIdHreYcEOPnXGm8mY8CFnppvpI=;
 b=IvQ9vEr6WpZq4NElD8pacuNJ7DlM9WTZT+XePmlRut+X7NZDHnEkW8zmZ98jm4anRo
 A0YsWcLVMn8FcmYC0jbqLdFFml3r06c2pNNTwMo56vBWoE8DBllLI6COeH0IH7SapRfR
 3XhX4K3uB/tUClvhvJcuQAwUmNnGvtIqxOlm6zoo2tby2FkFMuITRHkjfkio8+oGlFbn
 iMv63ln7BUlFnpjOPoWjChPGvQDgHRs8hs3bUVW2HiiYyB6W60xY7q1FrkIvM5OwbWor
 d0m7MnYiAdE7iGA6rAgrzVQfVGUgvlMhBhvDAL+8A7uRg8j47vZ0oQLQev6WxTZsjQx6
 3u7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685952423; x=1688544423;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nBsE6ZSAQNXrqj2aXIdHreYcEOPnXGm8mY8CFnppvpI=;
 b=cm7zav6rtI2cYclEt+h8jsBNYY0+6wNB96Dg4gj4e4udYQ9G0C1QHEF6hUqnknMQdU
 nkGWmnQgIVa5Qs652KOx0DuNCci1xqWZ0W5lEGFQBXn1ZTM5TS8mIsrSmlcTuQcqk1/d
 UAtWEDhXrdmqJAdlF69G7qRncmKdFLdiROUTrtl/HN6X8uUjns2XYacu6syAJrn+Bt2Q
 z+DsDD2DDv8Z2lpanuI+aucjOSGQWviWNrepechnl+zibZK5S5GsfDooOANdmPV69acW
 Ggq6nYaEkvvNcQ49OgTRiGH1LYBmfahtjMNZHLyPP4gpncb2BcmT0LcqHOW6Ea10v21E
 s9ag==
X-Gm-Message-State: AC+VfDxchIxVD2CA/qKQ76Kw/xGqWTlSJ3Mh+Zy+tRNY6j5xRrWBzOQd
 fj/xmQWXUPFYQH05fPAL/14DmZZvo0g8CG7ldNUC+nj1jOfvqlXP4jfwSS6C4nlAk65Bbz2rgKS
 hgB2SeQ9Tsw+y5yB161Zxfy69Pb54vA==
X-Received: by 2002:a05:620a:608a:b0:75b:23a0:deba with SMTP id
 dx10-20020a05620a608a00b0075b23a0debamr28828623qkb.56.1685952403364; 
 Mon, 05 Jun 2023 01:06:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ54WffJVAgziK1v5fGXGcEP6ZhKkhUM5WL01CapRdgLlA4i3sV9HcqJ6zPjS6RJdIDOenz0Jw==
X-Received: by 2002:a05:620a:608a:b0:75b:23a0:deba with SMTP id
 dx10-20020a05620a608a00b0075b23a0debamr28828575qkb.56.1685952403068; 
 Mon, 05 Jun 2023 01:06:43 -0700 (PDT)
Received: from mozz.bu.edu (mozz.bu.edu. [128.197.127.33])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a05620a16af00b00746b2ca65edsm3985583qkj.75.2023.06.05.01.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 01:06:42 -0700 (PDT)
Date: Mon, 5 Jun 2023 04:06:38 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mauro Matteo Cascella <mcascell@redhat.com>, P J P <pj.pandit@yahoo.co.in>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Stefan Weil <sw@weilnetz.de>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sven Schnelle <svens@stackframe.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <paul@xen.org>, Rob Herring <robh@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 1/2] net: Provide MemReentrancyGuard * to qemu_new_nic()
Message-ID: <20230605080616.ooanu5pk2pvs57yi@mozz.bu.edu>
References: <20230601031859.7115-1-akihiko.odaki@daynix.com>
 <20230601031859.7115-2-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601031859.7115-2-akihiko.odaki@daynix.com>
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.140.198; envelope-from=alxndr@bu.edu;
 helo=esa10.hc2706-39.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001,
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

On 230601 1218, Akihiko Odaki wrote:
> Recently MemReentrancyGuard was added to DeviceState to record that the
> device is engaging in I/O. The network device backend needs to update it
> when delivering a packet to a device.
> 
> In preparation for such a change, add MemReentrancyGuard * as a
> parameter of qemu_new_nic().
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>


Reviewed-by: Alexander Bulekov <alxndr@bu.edu>

One minor comment below.

> ---
>  include/net/net.h             | 1 +
>  hw/net/allwinner-sun8i-emac.c | 3 ++-
>  hw/net/allwinner_emac.c       | 3 ++-
>  hw/net/cadence_gem.c          | 3 ++-
>  hw/net/dp8393x.c              | 3 ++-
>  hw/net/e1000.c                | 3 ++-
>  hw/net/e1000e.c               | 2 +-
>  hw/net/eepro100.c             | 4 +++-
>  hw/net/etraxfs_eth.c          | 3 ++-
>  hw/net/fsl_etsec/etsec.c      | 3 ++-
>  hw/net/ftgmac100.c            | 3 ++-
>  hw/net/i82596.c               | 2 +-
>  hw/net/igb.c                  | 2 +-
>  hw/net/imx_fec.c              | 2 +-
>  hw/net/lan9118.c              | 3 ++-
>  hw/net/mcf_fec.c              | 3 ++-
>  hw/net/mipsnet.c              | 3 ++-
>  hw/net/msf2-emac.c            | 3 ++-
>  hw/net/mv88w8618_eth.c        | 3 ++-
>  hw/net/ne2000-isa.c           | 3 ++-
>  hw/net/ne2000-pci.c           | 3 ++-
>  hw/net/npcm7xx_emc.c          | 3 ++-
>  hw/net/opencores_eth.c        | 3 ++-
>  hw/net/pcnet.c                | 3 ++-
>  hw/net/rocker/rocker_fp.c     | 4 ++--
>  hw/net/rtl8139.c              | 3 ++-
>  hw/net/smc91c111.c            | 3 ++-
>  hw/net/spapr_llan.c           | 3 ++-
>  hw/net/stellaris_enet.c       | 3 ++-
>  hw/net/sungem.c               | 2 +-
>  hw/net/sunhme.c               | 3 ++-
>  hw/net/tulip.c                | 3 ++-
>  hw/net/virtio-net.c           | 6 ++++--
>  hw/net/vmxnet3.c              | 2 +-
>  hw/net/xen_nic.c              | 4 ++--
>  hw/net/xgmac.c                | 3 ++-
>  hw/net/xilinx_axienet.c       | 3 ++-
>  hw/net/xilinx_ethlite.c       | 3 ++-
>  hw/usb/dev-network.c          | 3 ++-
>  net/net.c                     | 1 +
>  40 files changed, 75 insertions(+), 41 deletions(-)
> 
> diff --git a/include/net/net.h b/include/net/net.h
> index 1448d00afb..a7d8deaccb 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -157,6 +157,7 @@ NICState *qemu_new_nic(NetClientInfo *info,
>                         NICConf *conf,
>                         const char *model,
>                         const char *name,
> +                       MemReentrancyGuard *reentrancy_guard,
>                         void *opaque);

Does it make sense to roll *reentrancy_guard into NICConf here?

