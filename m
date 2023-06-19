Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBB1734CE5
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 09:59:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB9nB-0004jH-P3; Mon, 19 Jun 2023 03:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qB9nA-0004j1-5h
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qB9n8-000864-Ih
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687161552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GwnRNGRevx3kIcn3teovrFBQ8nFXzTE8Lti8Y2fbH+M=;
 b=H0Qya8BuF4uDrfQ12bxHHaXxeznTKPxOVFqcwwA9Oyryumotb0MgqCw9yzmzHB9/JRw1gS
 siJAUzcnXMvDK0FdP8+ZYl+ikZNyPh2PlwLkQ1/r0Tav9uwu1jchPwEZGWe2t3uaypj0x3
 e25LSJb8SoWIR6xkP0sjW/G0zLumlUA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271--yNwtEjAOxaze8bxIQYoKg-1; Mon, 19 Jun 2023 03:59:10 -0400
X-MC-Unique: -yNwtEjAOxaze8bxIQYoKg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so11572655e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 00:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687161550; x=1689753550;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GwnRNGRevx3kIcn3teovrFBQ8nFXzTE8Lti8Y2fbH+M=;
 b=WYgB04K4v/1TOzBi7f51EpxE4Vd/AMEcF99PpPzfp0mo8U45Y8x42SrpZ2mb4qobRw
 UoF/1W3CvJnRfO+cOWYps0eX4ceMqjLMUNPwMGWw6ajiL9KFnacwwCBxTfOO9I7NeAG+
 7FHzDE+DvyNOwkeP0kICNb9ERb2DCb5XGvtqZNFug8JVkzFL6hsvFWiL9YHHkJTO5tkh
 h7lfp6hij9F6vULTdLoOCHco13DBItbnXQiGCbVNe4u+z8FR7MMPlKIDeRP73txhQ991
 uz5QLJ9Mv/dGCAFnXt+GAIlKTd8E50i1Nrr3GWjuKyeNvQ0vpoCn0o1Y4kNAUyHzFKbU
 FY6w==
X-Gm-Message-State: AC+VfDzJ6o59RIeZWjgkcb6CBua1vwCSsnL/ZCNPFaLXmjGttLJO+my1
 lFwPlR/qcFTaSHrRzxpuhzuy7dHHWRCCzDwy5kJSHUZpyceK+eaBzVZz6RQZwRNA87woiasYwKg
 NmyXhlSisiqSPUeg=
X-Received: by 2002:a1c:7c11:0:b0:3f9:70f:8b99 with SMTP id
 x17-20020a1c7c11000000b003f9070f8b99mr3368347wmc.7.1687161549930; 
 Mon, 19 Jun 2023 00:59:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ74Q1sGPssczfvMmRkLmV418PjdkCeSMUhuiBCTwliaVfcFhWuui1QHXbjNrC4OVRyr8TgUAA==
X-Received: by 2002:a1c:7c11:0:b0:3f9:70f:8b99 with SMTP id
 x17-20020a1c7c11000000b003f9070f8b99mr3368337wmc.7.1687161549657; 
 Mon, 19 Jun 2023 00:59:09 -0700 (PDT)
Received: from [192.168.100.30] ([82.142.8.70])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a056000108500b00311339f5b06sm4600486wrw.57.2023.06.19.00.59.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 00:59:09 -0700 (PDT)
Message-ID: <ff81983b-56f0-f27b-b2b3-66b4b5010801@redhat.com>
Date: Mon, 19 Jun 2023 09:59:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] vhost_net: add an assertion for TAP client backends
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: imammedo@redhat.com, qemu-devel@nongnu.org
References: <20230619041501.111655-1-anisinha@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20230619041501.111655-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 6/19/23 06:15, Ani Sinha wrote:
> An assertion was missing for tap vhost backends that enforces a non-null
> reference from get_vhost_net(). Both vhost-net-user and vhost-net-vdpa
> enforces this. Enforce the same for tap. Unit tests pass with this change.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   hw/net/vhost_net.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index c4eecc6f36..6db23ca323 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -507,6 +507,7 @@ VHostNetState *get_vhost_net(NetClientState *nc)
>       switch (nc->info->type) {
>       case NET_CLIENT_DRIVER_TAP:
>           vhost_net = tap_get_vhost_net(nc);
> +        assert(vhost_net);
>           break;
>   #ifdef CONFIG_VHOST_NET_USER
>       case NET_CLIENT_DRIVER_VHOST_USER:

Reviewed-by: Laurent Vivier <lvivier@redhat.com>


