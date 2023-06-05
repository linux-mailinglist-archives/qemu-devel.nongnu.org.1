Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D3F722078
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 10:05:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q65D3-0007pg-2w; Mon, 05 Jun 2023 04:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1q65D0-0007pX-R5
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:04:58 -0400
Received: from esa14.hc2706-39.iphmx.com ([216.71.140.199])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1q65Cy-0002K3-Oq
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:04:58 -0400
X-IronPort-RemoteIP: 209.85.219.72
X-IronPort-MID: 307796642
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:IrN5c6BZLpH5FhVW/5Thw5YqxClBgxIJ4kV8jS/XYbTApDtw1jUGy
 zEdUG6Da/7eN2X9fNBwbInkoR9SsJOEyoQ2TANkpHpgcSl2pJueD7x1DKtR0wB+jCHnZBg6h
 ynLQoCYdKjYdleF+lH2dOCn9SImvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYctitWia++3k
 YqaT/b3Zhn9g1aYDkpOs/jY8E034Kyr0N8llgdWic5j7Qe2e0Y9Ucp3yZGZdxPQXoRSF+imc
 OfPpJnRErTxpkpF5nuNy94XQ2VTKlLgFVHmZkl+AsBOtiN/Shkaic7XAha9hXB/0F1ll/gpo
 DlEWAfZpQ0BZ8Ugk8xEO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFP2kvJuDhgqPbcJ0d1vCGdB0
 +IDMQ4kO0Xra+KemNpXS8Fpj8UnadD1ZcYR5SsmwjbeAvIrB5vERs0m5/cChGZ21p0IR6+PI
 ZVDAdZsRE2ojxlnM1MHDp4ktO21wHTzblW0rXrO/fVosjaNkFYZPL7FK9vKZsDbG8hsoG24v
 HjAvEb0PgMYHYnKodaC2jf27gPVpgviVYcPUbG16PNuqFuUwGMVFVsRT1TTnBWioku3WtYaM
 lJNvyRx9+4980ukStS7VBq9yJKZgiMhtxNrO7VSwGmwJmD8um512kBsouZ9VeEb
IronPort-HdrOrdr: A9a23:LKicWqC8XmUBlAHlHemO55DYdb4zR+YMi2TDsHoBKiC9E/bo9f
 xG+c566faaskdpZJhNo6H7BEDiewK4yXcW2/h0AV7KZmCP01dASrsSlrcKqAeQfREWmNQtrZ
 uJdMBFZuEZWjBB4foTO2GDYrEdKMvuysGVbfS39RhQpREDUctdBx0QMGumLnE=
X-Talos-CUID: 9a23:6upx2m7Udb9b46C8ktss7h8TGsJ8bn3n3VzrO0a+BkB3U6SrYArF
X-Talos-MUID: 9a23:rLfTXgjdNE9da+t2cPMXYcMpL8Z3/7j/Vk00r74modOCdg59ByWfpWHi
Received: from mail-qv1-f72.google.com ([209.85.219.72])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 05 Jun 2023 04:04:49 -0400
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6260a1ecf37so52211756d6.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 01:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1685952289; x=1688544289;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=w4A3jYCjeUqlQ62V5urF7yBovv+nvp0YeMEm8/LTD4Y=;
 b=IbMBN+vAcgK+aAFD29t1o/yfaumyrZlp4ewTvq96ZZQOXhdv75UQR+RD1v+hU8Qgn5
 T5Mx3YqU7U6354/hUsjKfa+olIYA8kn5Fckwqr6MaCuInDLfuxGosJJmUd9Vx8aDOtpr
 MV4thWNQaKDI7GGZpbxgOdKD1kRSDf190eNqHKhKs99JRTzYxgko1wDk4sxpQN2CsdtM
 AjK9svvdgZ0qEZb9o3YOjwSZ4uOoa4vciQLTNsJMBVuZSpBsibG2V5zY/R5soRUtQXek
 cCCIPXs7KV/2Yh6v6QibjKjK8pbJqPf6Cx/z5cs5FpkvO5oQs3enBFOW43bPGhpCoaPh
 QJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685952289; x=1688544289;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w4A3jYCjeUqlQ62V5urF7yBovv+nvp0YeMEm8/LTD4Y=;
 b=E4qCP/IR4K5ivWiP5H7KcBjJXAvKzTzigecpHIhSr3T3QVHxNDtU93Z2cki7Kw266I
 QctKsEkf+e1ZHPismX6TK0dnfqJ64tduK9HPepBp+6V5cpxxScYDmBK2rN75itoI3rNP
 CnR5csGXHnNUTeZnOju3O6fs81xmtqLPfBvouVBKcTtnLAWUtTH5ZY3qs9dplCdIV8Io
 uFSrV+YH0PxX+oJpS77I4r+lLlOd8t1Bp3plAJQl/EvTsscNtIJeG3U5vNxNmpK6f1qo
 BZewgzAuADROofEmo+icTjPyxnhmZHSUDxdr4G8+mLTJhfirsWE7PH2ULuN4VElwBN9L
 V7lg==
X-Gm-Message-State: AC+VfDzKtp1GDDVL48a0jJCaHXGKJjeS5aUb5oMzqfTvnqTrJNM1ZABi
 uJS2ZnTiwPPQCN0OvgZVsZpC5KMXtGmKXiiTu0kOr4orgtx/IMbWDQ48xh7eLfa8nj4zh1pCHpS
 qVdC6c2yIjjyW3312O8hlA0wY9E0hPQ==
X-Received: by 2002:a05:6214:234c:b0:625:e039:5af1 with SMTP id
 hu12-20020a056214234c00b00625e0395af1mr6631336qvb.42.1685952288850; 
 Mon, 05 Jun 2023 01:04:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5qig5w/RKth5j5e7VsoG6Ro3qRwBgFDwzIc+OfuDgKuMNwubkMjommwJhKjlPapm8pNARfmA==
X-Received: by 2002:a05:6214:234c:b0:625:e039:5af1 with SMTP id
 hu12-20020a056214234c00b00625e0395af1mr6631314qvb.42.1685952288574; 
 Mon, 05 Jun 2023 01:04:48 -0700 (PDT)
Received: from mozz.bu.edu (mozz.bu.edu. [128.197.127.33])
 by smtp.gmail.com with ESMTPSA id
 c9-20020ac80549000000b003f4a76d4981sm4435084qth.66.2023.06.05.01.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 01:04:48 -0700 (PDT)
Date: Mon, 5 Jun 2023 04:04:40 -0400
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
Subject: Re: [PATCH v2 2/2] net: Update MemReentrancyGuard for NIC
Message-ID: <20230605080440.ljfqlc7u6f7ipdty@mozz.bu.edu>
References: <20230601031859.7115-1-akihiko.odaki@daynix.com>
 <20230601031859.7115-3-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601031859.7115-3-akihiko.odaki@daynix.com>
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.140.199; envelope-from=alxndr@bu.edu;
 helo=esa14.hc2706-39.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> This implementation follows what bottom half does, but it does not add
> a tracepoint for the case that the network device backend started
> delivering a packet to a device which is already engaging in I/O. This
> is because such reentrancy frequently happens for
> qemu_flush_queued_packets() and is insignificant.
> 
> Fixes: CVE-2023-3019
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Acked-by: Alexander Bulekov <alxndr@bu.edu>

> ---
>  include/net/net.h |  1 +
>  net/net.c         | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/include/net/net.h b/include/net/net.h
> index a7d8deaccb..685ec58318 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -124,6 +124,7 @@ typedef QTAILQ_HEAD(NetClientStateList, NetClientState) NetClientStateList;
>  typedef struct NICState {
>      NetClientState *ncs;
>      NICConf *conf;
> +    MemReentrancyGuard *reentrancy_guard;
>      void *opaque;
>      bool peer_deleted;
>  } NICState;
> diff --git a/net/net.c b/net/net.c
> index 982df2479f..3523cceafc 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -332,6 +332,7 @@ NICState *qemu_new_nic(NetClientInfo *info,
>      nic = g_malloc0(info->size + sizeof(NetClientState) * queues);
>      nic->ncs = (void *)nic + info->size;
>      nic->conf = conf;
> +    nic->reentrancy_guard = reentrancy_guard,
>      nic->opaque = opaque;
>  
>      for (i = 0; i < queues; i++) {
> @@ -805,6 +806,7 @@ static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
>                                         int iovcnt,
>                                         void *opaque)
>  {
> +    MemReentrancyGuard *owned_reentrancy_guard;
>      NetClientState *nc = opaque;
>      int ret;
>  
> @@ -817,12 +819,24 @@ static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
>          return 0;
>      }
>  
> +    if (nc->info->type != NET_CLIENT_DRIVER_NIC ||
> +        qemu_get_nic(nc)->reentrancy_guard->engaged_in_io) {
> +        owned_reentrancy_guard = NULL;
> +    } else {
> +        owned_reentrancy_guard = qemu_get_nic(nc)->reentrancy_guard;
> +        owned_reentrancy_guard->engaged_in_io = true;
> +    }
> +
>      if (nc->info->receive_iov && !(flags & QEMU_NET_PACKET_FLAG_RAW)) {
>          ret = nc->info->receive_iov(nc, iov, iovcnt);
>      } else {
>          ret = nc_sendv_compat(nc, iov, iovcnt, flags);
>      }
>  
> +    if (owned_reentrancy_guard) {
> +        owned_reentrancy_guard->engaged_in_io = false;
> +    }
> +
>      if (ret == 0) {
>          nc->receive_disabled = 1;
>      }
> -- 
> 2.40.1
> 

