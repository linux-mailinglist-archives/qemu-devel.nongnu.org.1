Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB16F744D53
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 12:41:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFuVs-0000H5-It; Sun, 02 Jul 2023 06:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFuVr-0000Gj-0f
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 06:41:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFuVp-0001nt-LC
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 06:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688294460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2ERtwGcI/yq6azkW5w1YVpqGO+qSczR8udnUwg/vvlY=;
 b=B9IvftUz0ayBqTsF8PNeIzvJCB07vrvz1Hwa0r5zeM+UyTvd73Al6BCyy6T2pLtXOVQSAz
 an8uvPC8fSEFs9KyljOq71ZhZtYbUcrloaBjjyz0oZz35WEsXSJGfI90MCXikyYRllFLj3
 /sZ3lXeFW8pENx7U/8dNbCPs+TvLmII=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-cWaKM-wuOzuhEK5d-6PLyw-1; Sun, 02 Jul 2023 06:40:59 -0400
X-MC-Unique: cWaKM-wuOzuhEK5d-6PLyw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-51d981149b5so1503566a12.3
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 03:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688294457; x=1690886457;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ERtwGcI/yq6azkW5w1YVpqGO+qSczR8udnUwg/vvlY=;
 b=fTGQgwqC74GLkEdzdoEl1UHumuFVqZwl87dHjHIjCLeJ640qN92GPJ5NgCp3ofbfQD
 Y2lTmg1JV9V3YweZs19rsi9+0c+tWf4Yurla9aWpISzQy89CIBxMLDTa3nTSeOoNbdMf
 KVh5XdjsMXC5G+Q1JuaXyWiInscZldc0MUK2vl6LvwqXkuT1aZEu1OcXdHTJ0qbT78Ro
 vRT8yY0RyDqapH+AsjXmbzPgyk7H37AsZptSkE3dB1/JoAvBclkxaTCKEu0Ev28l9LKM
 Z4qCBhYXeQtxTMSu+PeB1MMG/a3D/6eS/FG7V7lUzx4UdgD+p0wIPLJED77m//8UhO/W
 XT9Q==
X-Gm-Message-State: ABy/qLZb52tTbyuG5VRma5YsG/eOACI9Y+h4Ie2vTf+LD1Oc7n9ZWGaQ
 0xldxzjx2e441TEfNiJGg1+BlmZaklDaiTbPqmzHbCOSbV+HC3IiEzUVuFSSgBwmaQMxfKBDUzW
 MsNedlFrzDm0yyhY=
X-Received: by 2002:aa7:d9d7:0:b0:51d:acda:2f4a with SMTP id
 v23-20020aa7d9d7000000b0051dacda2f4amr4921829eds.37.1688294457017; 
 Sun, 02 Jul 2023 03:40:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEzvbnsAXOc8+zcz8d7SACZeRAJw0OyoAGs1BUinZ5TgdnkGdrHMXlPYTh17asogiBtgZs44A==
X-Received: by 2002:aa7:d9d7:0:b0:51d:acda:2f4a with SMTP id
 v23-20020aa7d9d7000000b0051dacda2f4amr4921816eds.37.1688294456739; 
 Sun, 02 Jul 2023 03:40:56 -0700 (PDT)
Received: from redhat.com ([2.52.134.224]) by smtp.gmail.com with ESMTPSA id
 w1-20020a50fa81000000b0051df67eaf62sm2489635edr.42.2023.07.02.03.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 03:40:56 -0700 (PDT)
Date: Sun, 2 Jul 2023 06:40:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v2 1/4] docs: Fix next function numbers in SR/IOV
 documentation
Message-ID: <20230702064038-mutt-send-email-mst@kernel.org>
References: <20230702094631.39111-1-akihiko.odaki@daynix.com>
 <20230702094631.39111-2-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230702094631.39111-2-akihiko.odaki@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Sun, Jul 02, 2023 at 06:46:25PM +0900, Akihiko Odaki wrote:
> The ARI next function number field is undefined for VF so the PF should
> end the linked list formed with the field by specifying 0.
> 
> This also changes the value of the field for VF; it seems to imply the
> value has some meaning if it differs from one of the PF, but it doesn't.
> 
> Fixes: 2503461691 ("pcie: Add some SR/IOV API documentation in docs/pcie_sriov.txt")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  docs/pcie_sriov.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt
> index 7eff7f2703..2b7094dc47 100644
> --- a/docs/pcie_sriov.txt
> +++ b/docs/pcie_sriov.txt
> @@ -48,7 +48,7 @@ setting up a BAR for a VF.
>        ...
>        int ret = pcie_endpoint_cap_init(d, 0x70);
>        ...
> -      pcie_ari_init(d, 0x100, 1);
> +      pcie_ari_init(d, 0x100, 0);
>        ...
>  
>        /* Add and initialize the SR/IOV capability */
> @@ -78,7 +78,7 @@ setting up a BAR for a VF.
>        ...
>        int ret = pcie_endpoint_cap_init(d, 0x60);
>        ...
> -      pcie_ari_init(d, 0x100, 1);
> +      pcie_ari_init(d, 0x100, 0);
>        ...
>        memory_region_init(mr, ... )
>        pcie_sriov_vf_register_bar(d, bar_nr, mr);


So now code does not match docs.


> -- 
> 2.41.0


