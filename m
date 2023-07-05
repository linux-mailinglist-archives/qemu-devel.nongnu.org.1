Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 334CC7482A6
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 13:04:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH0Ia-0006tt-Fg; Wed, 05 Jul 2023 07:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qH0IU-0006sy-AR; Wed, 05 Jul 2023 07:03:47 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qH0IS-00017r-0O; Wed, 05 Jul 2023 07:03:45 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2b69f71a7easo107091331fa.1; 
 Wed, 05 Jul 2023 04:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688555022; x=1691147022;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jF7Taa/FOZ/9nzSl0yPqTEHVeR3NA1UoR2aW/kmWn5M=;
 b=Y6ewpPk19CmAfXBIoGme05QzwC39HTRvaKp8AO9GR1nUfQQmegDwATGwFUREKrUl2n
 8LVw3GFMUnmz52q3T51EPFwVo2sWBrQ1UqSTEBx0ArVPF6YHtASAhZdg/RZ+TOJj7PPH
 qHGsfiVx7DuGAe6rBRqe3bMOAzC4bVzenzBnPcu7sSIKDXq8xEt3sWAel1UghSmrRigZ
 6/8LxNPAKgnnl1uGOCCE4siGe47YWKfVjl6MlF1Q5cJEWyZLv6IZqFkAsL2Twfu269WF
 J4pP0QNyJzj9OiYSajJJh3Rw6l76XQFA6tuMbyn7WsydWlZ4l/piWNBiN9htjQ0GujIE
 MuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688555022; x=1691147022;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jF7Taa/FOZ/9nzSl0yPqTEHVeR3NA1UoR2aW/kmWn5M=;
 b=Pv5yViW+c+PvJfizdPHsii30+3DS97S5NKyB6/VDHSQ/S0APaBot6rRJU1oSGhazqo
 FRWpaH6MW5cR3dQxSaQLdvDbNdFw0FSZzp/6EFDXkNq4l6n4TW0Y6RfBFmQgPACTkzXB
 +IXbMtJpjXzV751ZiL9EDb4hAkKwoXaYiC0cmKHU8GBUfk2oJpU8b4ZnduBHrzlcf33c
 9JVqjQTEOpwBhMsy1jsrF5FlK66Mh7TqqHuH3CraVSNn50LW+mrSiXmKhA2QldzIMmyh
 YEOy/adZXkJjUkUHjY5xDXFZMGFDJUtfAHy/uccOwvv+9aJX0neGc81nOsPe+gqYXSwM
 LuSw==
X-Gm-Message-State: ABy/qLaoEryb8ycgHt9Em+bs0fQ6wq/QccXlNVjKWuUYnwZfAoLA+OXn
 Sng5XJgYF2shV/D9ddMAMlnhcJjAR8A1gSQKR7w=
X-Google-Smtp-Source: APBJJlHgXSADeMpKgsH7uKj8tnihIFYIftyC0sJSyJR2qCROmOHciWn8qBK2pk+i+VrXKxZfmk2GnFgXQTXkgAh7JmQ=
X-Received: by 2002:a2e:9cda:0:b0:2b6:cdfb:f1d7 with SMTP id
 g26-20020a2e9cda000000b002b6cdfbf1d7mr10236804ljj.0.1688555021549; Wed, 05
 Jul 2023 04:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688438055.git.yin31149@gmail.com>
 <CAPpAL=z6+Jhoy3w=itO7JEpkijJPZSZNyLVUQ1qS08gqnjN6hQ@mail.gmail.com>
In-Reply-To: <CAPpAL=z6+Jhoy3w=itO7JEpkijJPZSZNyLVUQ1qS08gqnjN6hQ@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Wed, 5 Jul 2023 19:03:29 +0800
Message-ID: <CAKrof1P8dRN+fXAX47iiu892kmCjoq-xcUmXrcChHUUh4hRYKA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] vdpa: Return -EIO if device ack is VIRTIO_NET_ERR
To: Lei Yang <leiyang@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com, 
 qemu-stable@nongnu.org, qemu-devel@nongnu.org, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On 2023/7/5 15:59, Lei Yang wrote:
> Hello Hawkins
>
> QE can help test this series before  it is merged into master, I would
> like to know what test steps can cover this series related scenario?
>

Hi, I would like to suggest the following steps to test this patch series:

1.  Modify the QEMU source code to make the device return a
VIRTIO_NET_ERR for the CVQ command. Please apply the patch
provided below:

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 373609216f..58ade6d4e0 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -642,7 +642,7 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState
*s, const VirtIONet *n)
      if (virtio_vdev_has_feature(&n->parent_obj,
VIRTIO_NET_F_CTRL_MAC_ADDR)) {
          ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s,
VIRTIO_NET_CTRL_MAC,

VIRTIO_NET_CTRL_MAC_ADDR_SET,
-                                                  n->mac, sizeof(n->mac));
+                                                  n->mac,
sizeof(n->mac) - 1);
          if (unlikely(dev_written < 0)) {
              return dev_written;
          }

2. Start QEMU with the vdpa device in default state.
Without the patch series, QEMU should not trigger any errors or warnings.
With the series applied, QEMU should trigger the warning like
"qemu-system-x86_64: unable to start vhost net: 5: falling back on
userspace virtio".

Thanks!


> Thanks
> Lei
>
> On Tue, Jul 4, 2023 at 11:36=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
>>
>> According to VirtIO standard, "The class, command and
>> command-specific-data are set by the driver,
>> and the device sets the ack byte.
>> There is little it can do except issue a diagnostic
>> if ack is not VIRTIO_NET_OK."
>>
>> Therefore, QEMU should stop sending the queued SVQ commands and
>> cancel the device startup if the device's ack is not VIRTIO_NET_OK.
>>
>> Yet the problem is that, vhost_vdpa_net_load_x() returns 1 based on
>> `*s->status !=3D VIRTIO_NET_OK` when the device's ack is VIRTIO_NET_ERR.
>> As a result, net->nc->info->load() also returns 1, this makes
>> vhost_net_start_one() incorrectly assume the device state is
>> successfully loaded by vhost_vdpa_net_load() and return 0, instead of
>> goto `fail` label to cancel the device startup, as vhost_net_start_one()
>> only cancels the device startup when net->nc->info->load() returns a
>> negative value.
>>
>> This patchset fixes this problem by returning -EIO when the device's
>> ack is not VIRTIO_NET_OK.
>>
>> Changelog
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>> v3:
>>   - split the fixes suggested by Eugenio
>>   - return -EIO suggested by Michael
>>
>> v2: https://lore.kernel.org/all/69010e9ebb5e3729aef595ed92840f43e48e53e5=
.1687875592.git.yin31149@gmail.com/
>>   - fix the same bug in vhost_vdpa_net_load_offloads()
>>
>> v1: https://lore.kernel.org/all/cover.1686746406.git.yin31149@gmail.com/
>>
>> Hawkins Jiawei (3):
>>    vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mac()
>>    vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mq()
>>    vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_offloads()
>>
>>   net/vhost-vdpa.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> --
>> 2.25.1
>>
>>
>

