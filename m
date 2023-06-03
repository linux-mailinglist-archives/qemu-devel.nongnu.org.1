Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C653720E76
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 09:20:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5LXH-0005om-8Z; Sat, 03 Jun 2023 03:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q5LXE-0005od-LO
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 03:18:49 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q5LXC-000165-Ou
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 03:18:48 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2b1b084620dso17807381fa.0
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 00:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685776724; x=1688368724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gPJMKgxWotnWOeuAgZXs2VWNgVVcTbQaxLggT0OxUjE=;
 b=CE1tHt8Vb3gveRLwTYy/+RHGMYFW7sC4SeupzW3BLhk0pkmPE+S9OgfGa51UDBZ3Px
 /kV6ZgcDkXidbXJTq96t2qRDC0o8di2fbxWLNRVDnj1zu0VzMvlK3cLvfxtii86uNd8E
 yisiYpiTBSMjCTHEo0Vrv5akpZLNl0cZ6aoRLHf6U/9P0pJWxWcOX20Q6nFPn0waSmjx
 ec0BzaglBw7M8Peeu2m/UYIyNqWNUz/p/mVPfIwDuO96SgUpBiIkS6gEYrWv580rzjWV
 tcD1Ivheega969wyQMZz/qoLWVpTOSahrBNR2v4kfDavYMsEfy7t4kBdIBUsxJDOVolz
 IHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685776724; x=1688368724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gPJMKgxWotnWOeuAgZXs2VWNgVVcTbQaxLggT0OxUjE=;
 b=SFgYBoTKFCnDYVNPgcx1ig8GfFEQnVNRUjRr++XOpvwyeRF9Ff5mUMJIp2DOqi2NXE
 2jx2LHxiwVQubiLxyvfNHlvof+YwhnpHERCWkV2uQ0Un8blnDT0997EIaF5STk4r6HsQ
 +L7ftl22blfvztX0YPwqBW8uVT6WDN/1cXicCd6IQkyPcvWSwJpI9wR7f+JTXgTaAGIR
 2KxmT+9mYTAt44FndOOzpGKg/Siw20TI9kCoKEdU2rcCJXnfZFH+AOO8sIJWJjKYFGAE
 h8djE0x/5+zjPt8olNiVZqceirw1Pt2CI6GIF+e2SUSQuARFBizUb2WdsPsv6eibr7Ue
 wjIw==
X-Gm-Message-State: AC+VfDzITJn/zXZ6EwZ467K7bQtX5lC7Gfxa1ZrDc1NPlvX74D1jfzyx
 fdYTmJQE7at2f/xocE3dMgMAEqz7VEAxHNQ8tmc=
X-Google-Smtp-Source: ACHHUZ4bG2o7JCxwu4IvasIXNytsashNlyQyjmmazJWDrEIA45iW3SOUZR6/rIRDZGXLrGRHrEEbJGrT7sizYrz7d/g=
X-Received: by 2002:a2e:9f4f:0:b0:299:a7be:5775 with SMTP id
 v15-20020a2e9f4f000000b00299a7be5775mr1238756ljk.35.1685776724049; Sat, 03
 Jun 2023 00:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685704856.git.yin31149@gmail.com>
 <CAJaqyWc9P9P0izwF9bk-vN7VnNC3UTjHt55gdJB9qXVfOmgUMA@mail.gmail.com>
In-Reply-To: <CAJaqyWc9P9P0izwF9bk-vN7VnNC3UTjHt55gdJB9qXVfOmgUMA@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Sat, 3 Jun 2023 15:18:32 +0800
Message-ID: <CAKrof1NEqCURiraLXz44oK++6MK--qtvVZHUu6xoPTC2m7p1dA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Vhost-vdpa Shadow Virtqueue Offloads support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x22e.google.com
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

On 2023/6/3 1:47, Eugenio Perez Martin wrote:
> On Fri, Jun 2, 2023 at 1:52=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com=
> wrote:
>>
>> This series enables shadowed CVQ to intercept Offloads commands
>> through shadowed CVQ, update the virtio NIC device model so qemu
>> send it in a migration, and the restore of that Offloads state
>> in the destination.
>>
>> Changelog
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>> v4:
>>    - refactor the commit message suggested by Eugenio in patch#4
>> "virtio-net: expose virtio_net_supported_guest_offloads()"
>>    - fix the wrong "cpu_to_le64()" pointed out by Eugenio in patch$5
>> "vdpa: Add vhost_vdpa_net_load_offloads()"
>>    - refactor the comment in patch#5
>> "vdpa: Add vhost_vdpa_net_load_offloads()"
>>
>> v3: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg00206.ht=
ml
>>
>> v2: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg00044.ht=
ml
>>
>> v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-05/msg07198.ht=
ml
>>
>
> Please keep all the v2, v3 etc changes here too. A reviewer may see
> this newly from an older revision.

Thank you for the reminder, I will include all change log in the
upcoming patches.

>
> Apart from that,
> Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Tested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> I tested it by tracing the value it sends at destination when the
> guest enable or disable hw GRO offloads with:
> ethtool -K rx-gro-hw off.
>
> As you point in previous series, a migration blocker needs to be
> conditionally added. This is done in [1].
>
> While investigating this I discovered two related issues, it might be
> in handy if other reviewer wants to test the changes [2][3].
>
> Thanks!
>
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg00512.htm=
l
> [2] https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg00601.htm=
l
> [3] https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg00604.htm=
l

Thanks for your explanation!


>
>> Hawkins Jiawei (6):
>>    include/hw/virtio: make some VirtIODevice const
>>    vdpa: reuse virtio_vdev_has_feature()
>>    hw/net/virtio-net: make some VirtIONet const
>>    virtio-net: expose virtio_net_supported_guest_offloads()
>>    vdpa: Add vhost_vdpa_net_load_offloads()
>>    vdpa: Allow VIRTIO_NET_F_CTRL_GUEST_OFFLOADS in SVQ
>>
>>   hw/net/virtio-net.c            |  2 +-
>>   include/hw/virtio/virtio-net.h |  1 +
>>   include/hw/virtio/virtio.h     |  2 +-
>>   net/vhost-vdpa.c               | 49 +++++++++++++++++++++++++++++++---
>>   4 files changed, 48 insertions(+), 6 deletions(-)
>>
>> --
>> 2.25.1
>>
>

