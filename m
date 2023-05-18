Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6E4708929
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:11:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjuM-00039z-28; Thu, 18 May 2023 16:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzjta-0002ZM-L8
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:06:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzjtW-0005tv-U2
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684440397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XEjB5iZ4x2ugDdBuzX/xOZLYL03OM0Ot88hBwjCNznE=;
 b=a5tqMa9jaYadi6wqAiGvJUudHv2fnLzibqd0EiCCkwPJfxQJdO0NY6zaBS8NXGNap2QyHO
 sNW1qmcUDTroi3e8X7BxVzLdgQuzmmIuIMC+uMfJnEZdFuub10i/QWpOpZiu1PuVo41oBS
 KNxTPMr50SGzMdSb41SjwC9rVTUAFBM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-4t10IcrNOaC1rrf_PCPmkg-1; Thu, 18 May 2023 16:06:36 -0400
X-MC-Unique: 4t10IcrNOaC1rrf_PCPmkg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f13b1c06aaso1745732e87.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 13:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684440395; x=1687032395;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XEjB5iZ4x2ugDdBuzX/xOZLYL03OM0Ot88hBwjCNznE=;
 b=SnxWGl+dipNvfqgXq3228dqwGaeSHErt4U45v1z0h+ZV6qTsFzBAR5H9RjjmSmMUb6
 UKHoj62JOKheo0qC1dh404gX0RA6AD1s/gUscPHsKKUUtZy6SeV9cXqB7+A4Y3odhSeC
 m9ENBr/Z2CdP+z2hEdnRJjYcy9FNUeKlQYdhjR1iAE8rYPWaJL2G5R1b9B2BsRpKKEqq
 SWiIrlUN7AMzoUgr/eZJQM7IdFW7+KbOh9B9ZcV8n2IEH53vCFmbwuIHzs0uNgtAqOGP
 QwHrNgkLois4ZL3zOL8FUPsmn4+iZbPmxZ+18dNHyYMVwirthWWy3DkGOC/WZiyElmjN
 98Pg==
X-Gm-Message-State: AC+VfDzmEjTd0KDqoXYbVbvIWqIl6Ge0ElUjB/RHiwCfPaWy1tXlfQWt
 LBLShUqi9jBr5z2xuw8VpbGhtW4T6NPG/1qCyni43BjrJNOvlB+j5ykApSetaifrKXrgI6I30XZ
 Oym2/0NsnYfPURM4=
X-Received: by 2002:a19:a416:0:b0:4e8:4a21:9c92 with SMTP id
 q22-20020a19a416000000b004e84a219c92mr54817lfc.4.1684440394817; 
 Thu, 18 May 2023 13:06:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6pHXuUKrQUrSjKMkWpbLUd3ZySh7sQt0DwYkWfKGqWgwGG96HBXgnJCX4c7FtO9+G27n6dEA==
X-Received: by 2002:a19:a416:0:b0:4e8:4a21:9c92 with SMTP id
 q22-20020a19a416000000b004e84a219c92mr54808lfc.4.1684440394483; 
 Thu, 18 May 2023 13:06:34 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:3e4d:6703:27b9:6f74:5282])
 by smtp.gmail.com with ESMTPSA id
 j15-20020ac2550f000000b004ec8de8ab43sm348328lfk.139.2023.05.18.13.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 13:06:33 -0700 (PDT)
Date: Thu, 18 May 2023 16:06:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, berrange@redhat.com, pbonzini@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 antonkuchin@yandex-team.ru, den-plotnikov@yandex-team.ru
Subject: Re: [PATCH v7 1/4] qapi/qdev.json: unite DEVICE_* event data into
 single structure
Message-ID: <20230518160434-mutt-send-email-mst@kernel.org>
References: <20230421103207.845847-1-vsementsov@yandex-team.ru>
 <20230421103207.845847-2-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421103207.845847-2-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Fri, Apr 21, 2023 at 01:32:04PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> DEVICE_DELETED and DEVICE_UNPLUG_GUEST_ERROR has equal data, let's
> refactor it to one structure. That also helps to add new events
> consistently.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Can QAPI maintainers please review this patchset?
It's been a month.

> ---
>  qapi/qdev.json | 39 +++++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/qapi/qdev.json b/qapi/qdev.json
> index 2708fb4e99..135cd81586 100644
> --- a/qapi/qdev.json
> +++ b/qapi/qdev.json
> @@ -114,16 +114,37 @@
>  { 'command': 'device_del', 'data': {'id': 'str'} }
>  
>  ##
> -# @DEVICE_DELETED:
> +# @DeviceAndPath:
>  #
> -# Emitted whenever the device removal completion is acknowledged by the guest.
> -# At this point, it's safe to reuse the specified device ID. Device removal can
> -# be initiated by the guest or by HMP/QMP commands.
> +# In events we designate devices by both their ID (if the device has one)
> +# and QOM path.
> +#
> +# Why we need ID? User specify ID in device_add command and in command line
> +# and expects same identifier in the event data.
> +#
> +# Why we need QOM path? Some devices don't have ID and we still want to emit
> +# events for them.
> +#
> +# So, we have a bit of redundancy, as QOM path for device that has ID is
> +# always /machine/peripheral/ID. But that's hard to change keeping both
> +# simple interface for most users and universality for the generic case.
>  #
>  # @device: the device's ID if it has one
>  #
>  # @path: the device's QOM path
>  #
> +# Since: 8.0
> +##
> +{ 'struct': 'DeviceAndPath',
> +  'data': { '*device': 'str', 'path': 'str' } }
> +

Should be Since: 8.1 no?


> +##
> +# @DEVICE_DELETED:
> +#
> +# Emitted whenever the device removal completion is acknowledged by the guest.
> +# At this point, it's safe to reuse the specified device ID. Device removal can
> +# be initiated by the guest or by HMP/QMP commands.
> +#
>  # Since: 1.5
>  #
>  # Example:
> @@ -134,18 +155,13 @@
>  #      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
>  #
>  ##
> -{ 'event': 'DEVICE_DELETED',
> -  'data': { '*device': 'str', 'path': 'str' } }
> +{ 'event': 'DEVICE_DELETED', 'data': 'DeviceAndPath' }
>  
>  ##
>  # @DEVICE_UNPLUG_GUEST_ERROR:
>  #
>  # Emitted when a device hot unplug fails due to a guest reported error.
>  #
> -# @device: the device's ID if it has one
> -#
> -# @path: the device's QOM path
> -#
>  # Since: 6.2
>  #
>  # Example:
> @@ -156,5 +172,4 @@
>  #      "timestamp": { "seconds": 1615570772, "microseconds": 202844 } }
>  #
>  ##
> -{ 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
> -  'data': { '*device': 'str', 'path': 'str' } }
> +{ 'event': 'DEVICE_UNPLUG_GUEST_ERROR', 'data': 'DeviceAndPath' }
> -- 
> 2.34.1


