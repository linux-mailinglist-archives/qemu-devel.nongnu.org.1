Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3090821AF2
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 12:29:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKcxf-0002Sg-LN; Tue, 02 Jan 2024 06:29:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rKcxe-0002SV-35
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 06:29:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rKcxc-0003Q0-HG
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 06:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704194966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qlcwmHCw4XG7hEcVZMxj3EW39wo6HjTOhdpCpdHKi98=;
 b=a11fzNFjeBPE19N8rIH9x+QuN6wsAHi/y0vTrMQcL99meWAkDy4DZaeCxCNZ6wNkoq5WSn
 RHznH7xgSkNto39eIozqOBNXd4RwwC5TfliDr8AT8xvo8b1EO5c7r6pU4Du1f4pCGRs3If
 fvU0Nakq6IgGts2SD1c0dC3xCHWKV2U=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-Y6XdFVJsP8a2mn6kcXiYjg-1; Tue, 02 Jan 2024 06:29:25 -0500
X-MC-Unique: Y6XdFVJsP8a2mn6kcXiYjg-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dbdc1d8025cso10026390276.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 03:29:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704194964; x=1704799764;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qlcwmHCw4XG7hEcVZMxj3EW39wo6HjTOhdpCpdHKi98=;
 b=rNBG9yKhbwBoIVoZ0h05N1plwxY9g/WPTQl3D3q2RmavFXfR0UBn2CiXX832hHvjOt
 ImyY55xz6LhpTtonQ8m/rzSJgv9gpTAPO47k8DrqLsRLFcqzgAhLb7PfZdMclq5Bt7sV
 doZ92MZIeDkYUSn8QZUKzMqbEZUKZYFbKzoMrlnUB16dQ78d/DqBrE7gRj74TMawQX3/
 jIJ4I4pIMcDPDoUZJ4Q4Rm/awoieE0ich0oGdEQ8203wKuZ5L6jDmcmTB0H3XGv7pYDT
 9SSqit/XwY7zBI4ABv87hKH22I1C3Hy7sErIqSgfuXZ17verpQh600LcvV+RL2qJKRjP
 yIVA==
X-Gm-Message-State: AOJu0YwjiY9g2ERXk/KwK7fyX81PzXBETsBrZvJDiRXA/bbJFlRr9NP6
 4t9+/OgIWw392enq9gLckjzi1Zz1H4iNPqWcXx9jx0So9UpjujLYX25JuQJvLajraNI9+3+CbyA
 vwJXafTFeznPcg0P40Ez8SlJgVxBqBCrdZ3khStc=
X-Received: by 2002:a25:ef4c:0:b0:dbc:e80b:7103 with SMTP id
 w12-20020a25ef4c000000b00dbce80b7103mr7965125ybm.80.1704194964701; 
 Tue, 02 Jan 2024 03:29:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECRZSvOXVtbneCa8cE3Jq3yuDUM7oe1DdD95JAb4MgGkgYhdAegAKV7ah2+FSOv/cW3pRvtVOBHhRetz7J8mo=
X-Received: by 2002:a25:ef4c:0:b0:dbc:e80b:7103 with SMTP id
 w12-20020a25ef4c000000b00dbce80b7103mr7965117ybm.80.1704194964380; Tue, 02
 Jan 2024 03:29:24 -0800 (PST)
MIME-Version: 1.0
References: <20231215172830.2540987-1-eperezma@redhat.com>
 <20231215172830.2540987-9-eperezma@redhat.com>
 <CACGkMEvH=uU4QxMHVHTo5tQiuML2+NTE3gZssfz84-+4kGHa1Q@mail.gmail.com>
 <CAJaqyWczW+uwYBsWas97JY6OgiSurnvNQnnTYPFWv5La55GOOg@mail.gmail.com>
 <CACGkMEukZNUnXRSwpVAROe7U7GzkubP9i37ev+qOSQvWxLEK_Q@mail.gmail.com>
 <CAJaqyWfGkboB4sN0PSukKx1kAV-QQ_YSWXWvksPScBD9OgHRsQ@mail.gmail.com>
 <ZZOgGmpNT_zi2eat@x1n>
In-Reply-To: <ZZOgGmpNT_zi2eat@x1n>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 2 Jan 2024 12:28:48 +0100
Message-ID: <CAJaqyWcajuV12tV0aguBO1qpa95pK0qUEHjsNh2+VpMR3fCVyg@mail.gmail.com>
Subject: Re: [PATCH for 9.0 08/12] vdpa: add vhost_vdpa_load_setup
To: Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, si-wei.liu@oracle.com,
 Lei Yang <leiyang@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>, 
 Parav Pandit <parav@mellanox.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.246,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jan 2, 2024 at 6:33=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> Jason, Eugenio,
>
> Apologies for a late reply; just back from the long holiday.
>
> On Thu, Dec 21, 2023 at 09:20:40AM +0100, Eugenio Perez Martin wrote:
> > Si-Wei did the actual profiling as he is the one with the 128G guests,
> > but most of the time was spent in the memory pinning. Si-Wei, please
> > correct me if I'm wrong.
>
> IIUC we're talking about no-vIOMMU use case.  The pinning should indeed
> take a lot of time if it's similar to what VFIO does.
>
> >
> > I didn't check VFIO, but I think it just maps at realize phase with
> > vfio_realize -> vfio_attach_device -> vfio_connect_container(). In
> > previous testings, this delayed the VM initialization by a lot, as
> > we're moving that 20s of blocking to every VM start.
> >
> > Investigating a way to do it only in the case of being the destination
> > of a live migration, I think the right place is .load_setup migration
> > handler. But I'm ok to move it for sure.
>
> If it's destined to map the 128G, it does sound sensible to me to do it
> when VM starts, rather than anytime afterwards.
>

Just for completion, it is not 100% sure the driver will start the
device. But it is likely for sure.

> Could anyone help to explain what's the problem if vDPA maps 128G at VM
> init just like what VFIO does?
>

The main problem was the delay of VM start. In the master branch, the
pinning is done when the driver starts the device. While it takes the
BQL, the rest of the vCPUs can move work forward while the host is
pinning. So the impact of it is not so evident.

To move it to initialization time made it very noticeable. To make
things worse, QEMU did not respond to QMP commands and similar. That's
why it was done only if the VM was the destination of a LM.

However, we've added the memory map thread in this version, so this
might not be a problem anymore. We could move the spawn of the thread
to initialization time.

But how to undo this pinning in the case the guest does not start the
device? In this series, this is done at the destination with
vhost_vdpa_load_cleanup. Or is it ok to just keep the memory mapped as
long as QEMU has the vDPA device?

Thanks!


