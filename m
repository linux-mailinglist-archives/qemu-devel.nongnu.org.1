Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C24567BCD64
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 10:55:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpPZX-0003FH-Sx; Sun, 08 Oct 2023 04:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpPZT-0003Cv-1d
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 04:55:31 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpPZR-0005RH-8t
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 04:55:30 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so783123666b.0
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 01:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1696755208; x=1697360008;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nCTq/K0aaofU9sy6iasjS/FzgPzrK+nMFKLX08rP6Ao=;
 b=NxMqzxm1dsCyJR3uyjzlUbIxmuvaXCETeQSYzFY+v+Mxp19NTNJLnNh2i5me+fvcbc
 VT+wKfgHLG85b7QsBNcIqkLXHTBSEJCFfk1ZB3j1y7KNcRqUTLpNsC1oBKET9Xak8h6v
 RpYwp9hSrTBxoMgxa3YPWrO7mLoRxwmoM1agl0jUT9Rob3PLa+edH15s/KlQqyU7y6p0
 YXGHdqr9/h+GPqLsg8eZtPpxy1Sn2WB3gdA9seKpsNoqGecjzniNHqJvmG1MEBKZg0nP
 4D1EtRvzlkNh0+NaKHyAgUSqjpnWncwt0e0dloL//nT9eQQdzJDsgBw0Q1LIqkCf+1R6
 +4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696755208; x=1697360008;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nCTq/K0aaofU9sy6iasjS/FzgPzrK+nMFKLX08rP6Ao=;
 b=TIk8HeSg0sRXx6OBSv8AxNhPMPeWZrjkDKlksBVfPL2KKiqFOcsq7TVnGWOEb/OS4n
 6Qk+v5G/D4DBMfgE/Ju1a2UClxJeH9wKf7nhnXtUR1AyKmRSsJKryguQSxCkeKwuWB6r
 ocEvcww2WToFhe5svfWPYxHl51k4MA9rWDLBBgzrhqqcnaMkYtEsvnXmAaApoHIEq0xZ
 oWD6i3HTswQR/UfpwV1xJaQdsPa1fYIYQ+293qnScl0jR9FTnvRmnUwEgz6Xf/b66euL
 SlpmSKBYjk/pPLMMk1hd5vtmS3v5Hy41SnqNdtCyhCxFOlIEBvPW3ch/P2imFbuGZ+4O
 iotg==
X-Gm-Message-State: AOJu0YwO3jXs1krAUcER/lgjuhoQNzky7nTCdSOf9Hd0iHjzFGQxiW+l
 mbFMPKoiacyXBJ3i4HK3JkLl3Mi7szxYCdufSLweuA==
X-Google-Smtp-Source: AGHT+IFwJ22oCsQ0salv8Adza2qJfQRBMnsDPj7/Ex/YL6KeHxDCGfWTwc4J/GKa9BqhalfC8FkdV062HTywwBQiU8M=
X-Received: by 2002:a17:907:9616:b0:9a4:11a3:c32b with SMTP id
 gb22-20020a170907961600b009a411a3c32bmr6698049ejc.29.1696755207753; Sun, 08
 Oct 2023 01:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230922114625.5786-1-fengli@smartx.com>
 <20231008044854-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231008044854-mutt-send-email-mst@kernel.org>
From: Li Feng <fengli@smartx.com>
Date: Sun, 8 Oct 2023 16:53:29 +0800
Message-ID: <CAHckoCzmwoB__Z50vLg==dtsVzzVrthxEkr8idOdgjBMEYWrEw@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Implement reconnect for vhost-user-scsi
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::633;
 envelope-from=fengli@smartx.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Sun, Oct 8, 2023 at 4:49=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Fri, Sep 22, 2023 at 07:46:10PM +0800, Li Feng wrote:
> > Changes for v6:
> > - [PATCH] vhost-user: fix lost reconnect
> >   - Fix missing assign event_cb.
>
>
> Pls don't make vN+1 a reply to vN - start a new thread
> with each version please.
OK.

>
> > Changes for v5:
> > - No logic has been changed, just move part of the code from patch 4 to=
 patch 5.
> >
> > Changes for v4:
> > - Merge
> >   https://lore.kernel.org/all/20230830045722.611224-1-fengli@smartx.com=
/ to
> >   this series.
> > - Add ERRP_GUARD in vhost_user_scsi_realize;
> > - Reword the commit messages.
> >
> > Changes for v3:
> > - Split the vhost_user_scsi_handle_output to a separate patch;
> > - Move the started_vu from vhost scsi common header to vhost-user-scsi =
header;
> > - Fix a log print error;
> >
> > Changes for v2:
> > - Split the v1 patch to small separate patchset;
> > - New patch for fixing fd leak, which has sent to reviewers in another
> >   mail;
> > - Implement the `vhost_user_scsi_handle_output`;
> > - Add the started_vu safe check;
> > - Fix error handler;
> > - Check the inflight before set/get inflight fd.
> >
> > Li Feng (5):
> >   vhost-user-common: send get_inflight_fd once
> >   vhost: move and rename the conn retry times
> >   vhost-user-scsi: support reconnect to backend
> >   vhost-user-scsi: start vhost when guest kicks
> >   vhost-user: fix lost reconnect
> >
> >  hw/block/vhost-user-blk.c             |   6 +-
> >  hw/scsi/vhost-scsi-common.c           |  47 ++---
> >  hw/scsi/vhost-scsi.c                  |   5 +-
> >  hw/scsi/vhost-user-scsi.c             | 253 +++++++++++++++++++++++---
> >  hw/virtio/vhost-user-gpio.c           |   5 +-
> >  hw/virtio/vhost-user.c                |  10 +-
> >  include/hw/virtio/vhost-scsi-common.h |   2 +-
> >  include/hw/virtio/vhost-user-scsi.h   |   4 +
> >  include/hw/virtio/vhost-user.h        |   3 +-
> >  include/hw/virtio/vhost.h             |   2 +
> >  10 files changed, 277 insertions(+), 60 deletions(-)
> >
> > --
> > 2.41.0
>

