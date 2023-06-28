Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A0E74103E
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:42:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETZL-0007hz-N3; Wed, 28 Jun 2023 07:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qETZ7-0007U9-Tr
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:42:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qETZ6-0002CY-0h
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687952547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vzxrtqH0iCdzJSpTbvki53JUH5RyFcqVcg5zssfnXDw=;
 b=a5yltv7jvQDDJIgjwTMfmA77kI8hPbKiJ8waOlBszRBFb4EB3Zy2BZNYOx51keu1F+0AoV
 TVk3dGGBgQKjm2PZbpB/P/mB12//nzvu6DBh6QRI2EYzmCsvV9L8+3RDQPPld0UWQYPpPV
 Nq8IjCCO9uTKLTZNJ+bBg8AcHRm7y4E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-vpajFgs5NQqpX_mo8PE1Wg-1; Wed, 28 Jun 2023 07:42:25 -0400
X-MC-Unique: vpajFgs5NQqpX_mo8PE1Wg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30793c16c78so6270670f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 04:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687952544; x=1690544544;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzxrtqH0iCdzJSpTbvki53JUH5RyFcqVcg5zssfnXDw=;
 b=B2bsY0i25UDZWFQ1JZ6Il2uTA8uQQebifnkHB8ryfioc7FfSPZWtcVGsVDoKnWejMI
 h6XByV0dWBnTu1/2sR6RjcjV03j7w6XpPJgbL4f64fRCZ8xJNjYAuxgIra8IUIrhMu/C
 NLt0KfEbYhHf81DP4WhsN6E4zonarjHoS+guY8ejjcSXVA+Xjy2K8xR9EbBgAG6e732q
 wUBg1OMMWXWEUWdCI0tqdNmJxGIu8quFIUV8N2i5SvzHVy9we4/6dQCeUwu+GcjTq7kz
 eR9mMybts03I3aYchcKUsuaYThCK3WyLOgtoYGTz0NWS27x1Gl7inEyNSLWDTMp/hXPw
 6I9Q==
X-Gm-Message-State: AC+VfDz8sQdkpzZB2c5+7ForLKzOeRh4bYNGK90hQRDnYwesFA52zEJX
 IghywbORyGICoDp8NEsaOdxH+5xSbQdlFnuQ5hdONIQwgCZ4YBR50KH6nzdXLS6627R8hNkUkXW
 CWExAX6SxxvJitR0=
X-Received: by 2002:a5d:484e:0:b0:314:145:2d47 with SMTP id
 n14-20020a5d484e000000b0031401452d47mr4594817wrs.19.1687952544666; 
 Wed, 28 Jun 2023 04:42:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7WqOi8erqVii6jTWm6PxHDahl2HSHrxCTn2EmKESsbYmbVzGalO/T5qIT4vK4zQergzu71BQ==
X-Received: by 2002:a5d:484e:0:b0:314:145:2d47 with SMTP id
 n14-20020a5d484e000000b0031401452d47mr4594801wrs.19.1687952544354; 
 Wed, 28 Jun 2023 04:42:24 -0700 (PDT)
Received: from redhat.com ([176.12.183.225]) by smtp.gmail.com with ESMTPSA id
 a11-20020a056000050b00b003110dc7f408sm13257005wrf.41.2023.06.28.04.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 04:42:23 -0700 (PDT)
Date: Wed, 28 Jun 2023 07:42:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, peter.maydell@linaro.org,
 lvivier@redhat.com, clg@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] net/vhost-net: do not assert on null pointer return from
 tap_get_vhost_net()
Message-ID: <20230628074144-mutt-send-email-mst@kernel.org>
References: <20230628112804.36676-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628112804.36676-1-anisinha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Wed, Jun 28, 2023 at 04:58:04PM +0530, Ani Sinha wrote:
> When 'vhost=off' or no vhost specific options at all are passed for the tap
> net-device backend, tap_get_vhost_net() can return NULL. The function
> net_init_tap_one() does not call vhost_net_init() on such cases and therefore
> vhost_net pointer within the tap device state structure remains NULL. Hence,
> assertion here on a NULL pointer return from tap_get_vhost_net() would not be
> correct. Remove it and fix the crash generated by qemu upon initialization in
> the following call chain :
> 
> qdev_realize() -> pci_qdev_realize() -> virtio_device_realize() ->
> virtio_bus_device_plugged() -> virtio_net_get_features() -> get_vhost_net()
> 
> fixes: 0e994668d00c9c ("vhost_net: add an assertion for TAP client backends")
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

I added a bunch of tags and sent it upstream. Take a look
at the pull request so you can do it yourself going
forward, pls.

> ---
>  hw/net/vhost_net.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 6db23ca323..6b958d6363 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -507,7 +507,12 @@ VHostNetState *get_vhost_net(NetClientState *nc)
>      switch (nc->info->type) {
>      case NET_CLIENT_DRIVER_TAP:
>          vhost_net = tap_get_vhost_net(nc);
> -        assert(vhost_net);
> +        /*
> +         * tap_get_vhost_net() can return NULL if a tap net-device backend is
> +         * created with 'vhost=off' option, 'vhostforce=off' or no vhost or
> +         * vhostforce or vhostfd options at all. Please see net_init_tap_one().
> +         * Hence, we omit the assertion here.
> +         */
>          break;
>  #ifdef CONFIG_VHOST_NET_USER
>      case NET_CLIENT_DRIVER_VHOST_USER:
> -- 
> 2.39.1


