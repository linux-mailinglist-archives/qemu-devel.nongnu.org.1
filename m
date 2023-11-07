Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 775E07E36D3
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 09:39:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Haq-0002s7-Ue; Tue, 07 Nov 2023 03:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0Han-0002ro-FS
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 03:37:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0Hal-0000pF-Kc
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 03:37:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699346266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+IhDEAt/uO9COEgvQWHXEHuQh+Y/1qZXxqLJKsQSbk=;
 b=E5ogKIKwjFEEWb6NQ9eRNvXFF5id8GCT0hphx9Uhb2+jcRbQPTg0SQK3VsG2Xh/oZv/FsD
 6pKNeHsfidbsun4JgmaI1O9NLZzlh19LtsuottWh4FlLZuDHLu2WL9ma3oC7efIuSe1XJP
 PpaTGmJi/YWyay9j6DnT7i2k/JbWEiA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-FaAhowuXOcOuUuQVAg0JFw-1; Tue, 07 Nov 2023 03:37:44 -0500
X-MC-Unique: FaAhowuXOcOuUuQVAg0JFw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c6f33ee403so49892711fa.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 00:37:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699346263; x=1699951063;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I+IhDEAt/uO9COEgvQWHXEHuQh+Y/1qZXxqLJKsQSbk=;
 b=DlsiaBzVor4M2gyzDeeycUdGhBmOqnxDhmJC6ErUQqTPq64vMc2rxYPui23CKrODFz
 e0b3xJsY134rAIQDiEs8TwrhLpwOfwhRjJt93BI7mdDdUYQFjRI4H2jHk2apxNtoyu9E
 UbP70IekzfCayNMwSyZ7X/n0mXSfhkAcr2sVUdbrUeJSb6MKo3BPxRSQyunwd0Vy5zBb
 bV0TuIVOJ/S0eki5dat+Ets9dCxc8fNPget2lQoznDodR5v8RjGzw43tkHgos27R64R+
 4gLcRD7IUF0kp1RASjKHOuQAQmb0HaNP98Z4xyGSfPds/L0u2Q8uFoLG1ZYB7dJ+BpCy
 OtTA==
X-Gm-Message-State: AOJu0YyA4OCPNHj93hFW2+zo8SwkTPVu+xrMpB2nm4LaorJ3uBK46msw
 y1jZWQ5b/luz+CDMHbxnHIS58aG23MlNAKbSHGaPKxZhU9bST8NYcx5MDq9MiwUsg3+d9Tk+ndv
 V89NLnBo5L5v7xu4=
X-Received: by 2002:a2e:8443:0:b0:2c5:56b:cbcb with SMTP id
 u3-20020a2e8443000000b002c5056bcbcbmr26513478ljh.9.1699346262910; 
 Tue, 07 Nov 2023 00:37:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgil+tLxtfBoSKO+NKfZTezICiPQjdvNtvUFtVc8WE7cWTO9ZkzplNjRJ47L5+9puHojOBaQ==
X-Received: by 2002:a2e:8443:0:b0:2c5:56b:cbcb with SMTP id
 u3-20020a2e8443000000b002c5056bcbcbmr26513461ljh.9.1699346262570; 
 Tue, 07 Nov 2023 00:37:42 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 x14-20020adff0ce000000b0032fb17c65desm1691645wro.19.2023.11.07.00.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 00:37:41 -0800 (PST)
Date: Tue, 7 Nov 2023 03:37:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, virtio-fs@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Erik Schilling <erik.schilling@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v6 0/6] virtio: cleanup vhost-user-generic and reduce c&p
Message-ID: <20231107033550-mutt-send-email-mst@kernel.org>
References: <20231106191515.2801863-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231106191515.2801863-1-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Mon, Nov 06, 2023 at 07:15:09PM +0000, Alex Bennée wrote:
> A lot of our vhost-user stubs are large chunks of boilerplate that do
> (mostly) the same thing. This series continues the cleanups by
> splitting the vhost-user-base and vhost-user-generic implementations.
> After adding a new vq_size property the rng, gpio and i2c vhost-user
> devices become simple specialisations of the common base defining the
> ID, number of queues and potentially the config handling.
> 
> I've also added Manos' vhost-user-sound while I was at it.


Also some checkpatch warnings. Pls fix them too:

https://gitlab.com/mstredhat/qemu/-/jobs/5475281577


> Changes
> -------
> 
> v6
>   - re-base to current master
>   - make vhost-user-device abstract
>   - mention abstractness in docs
> 
> v5
>   - addressing comments and tags
>   - improved the docs
> 
> v4
>   - dropped the F_TRANSPORT work for another series
>   - added vhost-user-sound
> 
> Alex Bennée (5):
>   virtio: split into vhost-user-base and vhost-user-device
>   hw/virtio: derive vhost-user-rng from vhost-user-base
>   hw/virtio: derive vhost-user-gpio from vhost-user-base
>   hw/virtio: derive vhost-user-i2c from vhost-user-base
>   docs/system: add a basic enumeration of vhost-user devices
> 
> Manos Pitsidianakis (1):
>   hw/virtio: add vhost-user-snd and virtio-snd-pci devices
> 
>  docs/system/devices/vhost-user-rng.rst        |   2 +
>  docs/system/devices/vhost-user.rst            |  65 ++-
>  ...{vhost-user-device.h => vhost-user-base.h} |  21 +-
>  include/hw/virtio/vhost-user-gpio.h           |  23 +-
>  include/hw/virtio/vhost-user-i2c.h            |  14 +-
>  include/hw/virtio/vhost-user-rng.h            |  11 +-
>  include/hw/virtio/vhost-user-snd.h            |  26 ++
>  hw/virtio/vhost-user-base.c                   | 345 +++++++++++++++
>  hw/virtio/vhost-user-device-pci.c             |  10 +-
>  hw/virtio/vhost-user-device.c                 | 337 +--------------
>  hw/virtio/vhost-user-gpio.c                   | 406 +-----------------
>  hw/virtio/vhost-user-i2c.c                    | 272 +-----------
>  hw/virtio/vhost-user-rng.c                    | 278 +-----------
>  hw/virtio/vhost-user-snd-pci.c                |  75 ++++
>  hw/virtio/vhost-user-snd.c                    |  67 +++
>  hw/virtio/Kconfig                             |   5 +
>  hw/virtio/meson.build                         |  23 +-
>  17 files changed, 690 insertions(+), 1290 deletions(-)
>  rename include/hw/virtio/{vhost-user-device.h => vhost-user-base.h} (71%)
>  create mode 100644 include/hw/virtio/vhost-user-snd.h
>  create mode 100644 hw/virtio/vhost-user-base.c
>  create mode 100644 hw/virtio/vhost-user-snd-pci.c
>  create mode 100644 hw/virtio/vhost-user-snd.c
> 
> -- 
> 2.39.2


