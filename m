Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 989CB7657CD
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 17:36:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP2qB-0002kG-Ou; Thu, 27 Jul 2023 11:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qP2q9-0002jq-Ko
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:23:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qP2q8-0006xd-9B
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690471423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PUq69Lph25CZGYLZGqWYrLqpHVvJZ6Y2FDyu5wgQobs=;
 b=I+pzoAM9Kypr0CQ8yPbwL/8ASBOeVOh3HsX1W6UotbI1ZXFut5bmV96N7X5G2/n+efUb93
 tSfkupbE+p4IatBbFv6fsRafldUSH2e1gUo9IhiPUc++IFwUNPkPAdNchp4H7BGJncAbH0
 SHSWRh9tbqU2ndgeBbzSGm9klOImhKA=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-DrEaHEUfNlOz8G0Hgk4t6A-1; Thu, 27 Jul 2023 11:23:42 -0400
X-MC-Unique: DrEaHEUfNlOz8G0Hgk4t6A-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-d06d36b49f9so1039272276.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 08:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690471422; x=1691076222;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PUq69Lph25CZGYLZGqWYrLqpHVvJZ6Y2FDyu5wgQobs=;
 b=RDH7tX3ydryPI2XlyOYS0bR6S90vsKL41TACa7dfCzTH+oJATpU0+Tut8kBDSF+Tpy
 8ZpjLkB+q1/9VT2VfVCtBE66fOj/w7YuXShiihi1diEglMKg3MgochY0sIup+CLExQU2
 WswVJwb6sbJTd/6hbbSM1JHbw/LoAqEuklsqxw3EwSMdQsZ+DWGR7RKaAi4Fl2B3WJ0s
 ZEZFgi+3cdplof+Ch2Tacl2FpVByqKaAExEHojwsyx4Bzs5CPvKB8Papas2fyA2ce55p
 cgu3PEua0A2mGmLpuAfsZp9ZSOIaYdbcVU9HF0Lai5JSkr01WddiW6Y1vV3ZmHeVIcP5
 ZWQA==
X-Gm-Message-State: ABy/qLZNqYgz078wbbnsvxE3DUE8gCFtf2Qiz4SYgbKwc3dWtieLGJQk
 nbd6OZ2Y4IV8iP+oqlb19qXXQPUFM2lmGi+t2sLDO0o33YcHYOIG3VOaDII8nIj1WuJLbpZpSn7
 WoUo4eqgFb7S/kVxrMa66Kbhpjmoi2ek=
X-Received: by 2002:a25:ad0e:0:b0:ced:abcd:62e5 with SMTP id
 y14-20020a25ad0e000000b00cedabcd62e5mr5039921ybi.7.1690471421786; 
 Thu, 27 Jul 2023 08:23:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFa1ogSt2ypUlb/x99IZUL41UrwIei8Smi0KeTvhrAhw0fEAXBDl56GXo5Oos9iDNqkVuB6BQ0RwoBAkfOmyA0=
X-Received: by 2002:a25:ad0e:0:b0:ced:abcd:62e5 with SMTP id
 y14-20020a25ad0e000000b00cedabcd62e5mr5039912ybi.7.1690471421560; Thu, 27 Jul
 2023 08:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230720181459.607008-1-eperezma@redhat.com>
 <CAJaqyWdkyX9Ha-kd+haqEpfXfpVhSLmRa5hkZZGkvZjrD4Ketg@mail.gmail.com>
 <20230727090312-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230727090312-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 27 Jul 2023 17:23:05 +0200
Message-ID: <CAJaqyWeB4E=1QOPP-Sa3zcL+GW+Jnm4zJGf-9Nm72XtEA9xmXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] Prefer to use SVQ to stall dataplane at NIC
 state restore through CVQ
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, yvugenfi@redhat.com, si-wei.liu@oracle.com, 
 Jason Wang <jasowang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Shannon Nelson <snelson@pensando.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Thu, Jul 27, 2023 at 3:06=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Jul 21, 2023 at 08:48:02AM +0200, Eugenio Perez Martin wrote:
> > * Leave _F_RING_RESET to be added on top, as the semantics are not
> > implemented in vDPA at the moment.
>
> We really need _F_RING_RESET in vdpa too though.
> You did code it up already - why do you want to leave
> it out?
>

I don't want to leave it out, sorry if it sounded that way.

I'd like to merge the late enable part first, as it has been already
validated and it works with current HW. The _F_RING_RESET part needs
more time regarding vhost vDPA API for Linux >=3D6.5, HW support, etc.

I can start working on the _F_RING_RESET kernel part needed changes
with a dedicated ioctl if this version looks good enough.

Thanks!


