Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8067473D6
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:15:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGgnw-0006Lz-IS; Tue, 04 Jul 2023 10:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qGgnu-0006Kf-1K
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qGgns-0003WP-8G
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688480091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=amwTdhh53ODGrm/xGRz3pQF+JIxdj14iCj/60LYs0bE=;
 b=L1xNzT41K1CBWAw7cSGiKZWUFKsfphIQIYa8mM6ppDg8KWtWNnMTPu1hz7MklLw5KRL4a6
 zFEGFS9i9LQhn0vXiX8W+rsoHlaiBj8ZSXmG8ye10FONBPfXPSpqjXQNksovDcBfvSj5zY
 oavrelhEt9XwMcCQ+z4CW9j1quogqeo=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-YvmOiZeLO4-KxEfSyT5lKw-1; Tue, 04 Jul 2023 10:14:50 -0400
X-MC-Unique: YvmOiZeLO4-KxEfSyT5lKw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-57320c10635so59078767b3.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688480089; x=1691072089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=amwTdhh53ODGrm/xGRz3pQF+JIxdj14iCj/60LYs0bE=;
 b=G7TB2Y8FHG5awoXEy7YXU4dEf4VgNdYyn3jnAN19HSZdTARF1SEsORgdu/s61NXjGa
 WmQtGDeOpLjygJrb1mHyE7z1/aNgq7frfss2+uGxGV9L64Y4IaWRtJi7nStdZJEq3Gr3
 H8V9GQzDRxfF8CraHEObl5wWS4aMxeGlmyIuzhH/iKBknUk0aUbmUu+JgbVzuYfelQ73
 HpjHKu+LBC4MOiJVaUP96id9e+SIbJodL8Ur71GOYJRHRUN3aXmVAacIeSZI+7whsytx
 nlaph3XHKcDb0kHziKdYWlhjnegWbfBsQnZhZ1xZcC/x/yPO6Mu7XC7aNfhCIHUGfCOn
 JojQ==
X-Gm-Message-State: ABy/qLYUTlgkAOTnIsKChwmZj1kIY+zA5X2dBqYsVomtm3X+H0dL0R1l
 w7hqSv/T0YwBP1VROh+QcObB5FnUGt0juD/04UuTFokmwwgaVBzSHn5udTw+3JWOIxtQ7fk6fXh
 BPgJqjrNWGWelE88d9mtMOoMn6tRn5RE=
X-Received: by 2002:a81:6c07:0:b0:56f:ecdd:ded7 with SMTP id
 h7-20020a816c07000000b0056fecddded7mr10691850ywc.10.1688480089644; 
 Tue, 04 Jul 2023 07:14:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGosHVk6IO+3K/VzvEcQMYTaWGmmbZycxHWGPfTJe+OPV6YYSxscBesu21/LNKsDCUTN01nlCBBl9QcZWHVOPo=
X-Received: by 2002:a81:6c07:0:b0:56f:ecdd:ded7 with SMTP id
 h7-20020a816c07000000b0056fecddded7mr10691827ywc.10.1688480089355; Tue, 04
 Jul 2023 07:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221006194946.24134-1-venu.busireddy@oracle.com>
In-Reply-To: <20221006194946.24134-1-venu.busireddy@oracle.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 4 Jul 2023 16:14:37 +0200
Message-ID: <CAGxU2F6rMpUAeKm=gnFYwaVrGPj7ykPFR+_BEC_tLw_JgnnWyw@mail.gmail.com>
Subject: Re: [PATCH v4] virtio-scsi: Send "REPORTED LUNS CHANGED" sense data
 upon disk hotplug events.
To: Mark Kanda <mark.kanda@oracle.com>
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Venu Busireddy <venu.busireddy@oracle.com>, 
 qemu devel list <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

Hi Mark,
we have a bug [1] possibly related to this patch.

I saw this Oracle Linux errata [2] where you reverted this patch, but
there are no details.

Do you think we should revert it upstream as well?
Do you have any details about the problem it causes in Linux?

[1] https://bugzilla.redhat.com/show_bug.cgi?id=3D2176702
[2] https://linux.oracle.com/errata/ELSA-2023-12065.html

Thanks,
Stefano

On Thu, Oct 6, 2022 at 9:53=E2=80=AFPM Venu Busireddy <venu.busireddy@oracl=
e.com> wrote:
>
> Section 5.6.6.3 of VirtIO specification states, "Events will also
> be reported via sense codes..." However, no sense data is sent when
> VIRTIO_SCSI_EVT_RESET_RESCAN or VIRTIO_SCSI_EVT_RESET_REMOVED events
> are reported (when disk hotplug/hotunplug events occur). SCSI layer
> on Solaris depends on this sense data, and hence does not handle disk
> hotplug/hotunplug events.
>
> When the disk inventory changes, use the bus unit attention mechanism
> to return a CHECK_CONDITION status with sense data of 0x06/0x3F/0x0E
> (sense code REPORTED_LUNS_CHANGED).
>
> Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
>
> v3 -> v4:
>     - As suggested by Paolo Bonzini, use the bus unit attention mechanism
>       instead of the device unit attention mechanism.
>
> v2 -> v3:
>     - Implement the suggestion from Paolo Bonzini <pbonzini@redhat.com>.
>
> v1 -> v2:
>     - Send the sense data for VIRTIO_SCSI_EVT_RESET_REMOVED event too.
> ---
>  hw/scsi/scsi-bus.c     | 18 ++++++++++++++++++
>  hw/scsi/virtio-scsi.c  |  2 ++
>  include/hw/scsi/scsi.h |  1 +
>  3 files changed, 21 insertions(+)
>
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index 4403717c4aaf..ceceafb2cdf3 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -1616,6 +1616,24 @@ static int scsi_ua_precedence(SCSISense sense)
>      return (sense.asc << 8) | sense.ascq;
>  }
>
> +void scsi_bus_set_ua(SCSIBus *bus, SCSISense sense)
> +{
> +    int prec1, prec2;
> +    if (sense.key !=3D UNIT_ATTENTION) {
> +        return;
> +    }
> +
> +    /*
> +     * Override a pre-existing unit attention condition, except for a mo=
re
> +     * important reset condition.
> +     */
> +    prec1 =3D scsi_ua_precedence(bus->unit_attention);
> +    prec2 =3D scsi_ua_precedence(sense);
> +    if (prec2 < prec1) {
> +        bus->unit_attention =3D sense;
> +    }
> +}
> +
>  void scsi_device_set_ua(SCSIDevice *sdev, SCSISense sense)
>  {
>      int prec1, prec2;
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 41f2a5630173..cf2721aa46c0 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -956,6 +956,7 @@ static void virtio_scsi_hotplug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
>          virtio_scsi_push_event(s, sd,
>                                 VIRTIO_SCSI_T_TRANSPORT_RESET,
>                                 VIRTIO_SCSI_EVT_RESET_RESCAN);
> +        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
>          virtio_scsi_release(s);
>      }
>  }
> @@ -973,6 +974,7 @@ static void virtio_scsi_hotunplug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
>          virtio_scsi_push_event(s, sd,
>                                 VIRTIO_SCSI_T_TRANSPORT_RESET,
>                                 VIRTIO_SCSI_EVT_RESET_REMOVED);
> +        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
>          virtio_scsi_release(s);
>      }
>
> diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
> index 001103488c23..3b1b3d278ee8 100644
> --- a/include/hw/scsi/scsi.h
> +++ b/include/hw/scsi/scsi.h
> @@ -186,6 +186,7 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, B=
lockBackend *blk,
>                                        BlockdevOnError rerror,
>                                        BlockdevOnError werror,
>                                        const char *serial, Error **errp);
> +void scsi_bus_set_ua(SCSIBus *bus, SCSISense sense);
>  void scsi_bus_legacy_handle_cmdline(SCSIBus *bus);
>  void scsi_legacy_handle_cmdline(void);
>
>


