Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF02472DBF1
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 10:03:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8yyK-0000TX-Ik; Tue, 13 Jun 2023 04:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q8yyI-0000Sw-QB; Tue, 13 Jun 2023 04:01:46 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q8yyH-0004HS-0i; Tue, 13 Jun 2023 04:01:46 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-977e7d6945aso933647866b.2; 
 Tue, 13 Jun 2023 01:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686643299; x=1689235299;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8qjWlw4VIddJByF4ISR8Or1dZy9LWJRppqOpvTAYqOk=;
 b=QuHf0jSvpRSXTG+puM7zR5LxvD/ukesAFomgS5Xpxkw7gLDEwwAw341Gi7D3zJQV2V
 jY2J0/llf0xDYiKMXisf8x+jWLfT7iyxYxH6NAkZCXlBlj+6vKAcUdr9V/+/4KhPTLsz
 eMnd3gcux4MUWGdcKPIjNJ5ny8VE2pHLHOsvNCfLYZRgwm3JsSPgO9JOHJ35qOpdV+Io
 4EPLCnhLRDrEqaRhY5ZQeuTjkejpgL/HMDJcUO4r2Sb1Yt6ZhluOOeaUOMm9DpBENYmA
 4DZxsrdPJidZT+J1SQKjMGkDJCpZv46rYaiv8bX5Tm0e5L2rgF/2E2cJKSf92LWVtwWW
 PlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686643299; x=1689235299;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8qjWlw4VIddJByF4ISR8Or1dZy9LWJRppqOpvTAYqOk=;
 b=bMRZKSuPjZJtJZt12OUW7by3fFhEhC/dpfW4vQMhxZ7LEBT1Efhcj8I8JD+M716Ip4
 eTe2ax/wkcbkWpXz475GRrujwnUpsR1KvnAAsUy9HSmFg/Gvm7yRgsGQFVjTTSKftJD6
 ++OL57uK4A7DE8v+ZxvZzI/gkspckahDBB7OC+04EqE0YKUX1wkJGi8Dlp4e/Kz0b/tH
 fE8XjNtyRD7+eui+gkvJoS6TUvqi4QMK2DEVyOufsm9MzmA9o67QFrLSgbk2vOlchtMB
 kaDLGL6HujZk1mmsozDG1t7AxW6hTlklabdO0uRPcZdAX9rePVBpCoFP6OQEflv31g4P
 focg==
X-Gm-Message-State: AC+VfDwfYDcg76QkGFpIY8KQBTWolimiVix051I8kDCcb+bX/HLGDNzt
 Hcbz84f3EN4IjpwtBGZ0lvUExegSnaFKTFt2wTs=
X-Google-Smtp-Source: ACHHUZ6BoUufz2pAzXvAl51/UMkit4SSMmF4eZfYv0CNzzqgF+PF369aydchcNvWR2SU3o5ms/asp53ddNlluUXkIWQ=
X-Received: by 2002:a17:906:ef0b:b0:965:ff38:2fbb with SMTP id
 f11-20020a170906ef0b00b00965ff382fbbmr12698129ejs.1.1686643298854; Tue, 13
 Jun 2023 01:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230605104108.125270-1-faithilikerun@gmail.com>
 <20230605104108.125270-2-faithilikerun@gmail.com>
 <20230612041016.GA2446610@fedora>
In-Reply-To: <20230612041016.GA2446610@fedora>
From: Sam Li <faithilikerun@gmail.com>
Date: Tue, 13 Jun 2023 16:01:12 +0800
Message-ID: <CAAAx-8J2wBu6iCTiJ8hgoijWrSVgorcD92_Nhfsf=HxrMh0jxg@mail.gmail.com>
Subject: Re: [RFC 1/4] docs/qcow2: add the zoned format feature
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, dlemoal@kernel.org, dmitry.fomichev@wdc.com, 
 hare@suse.de, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=faithilikerun@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=8813=E6=
=97=A5=E5=91=A8=E4=BA=8C 15:04=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jun 05, 2023 at 06:41:05PM +0800, Sam Li wrote:
> > Add the specs for the zoned format feature of the qcow2 driver. Once
> > the zoned_profile is set to `zbc`, then the qcow2 file can be taken
> > as zoned devices and passed through by virtio-blk device to the guest.
> >
> > Signed-off-by: Sam Li <faithilikerun@gmail.com>
> > ---
> >  docs/system/qemu-block-drivers.rst.inc | 31 ++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-=
block-drivers.rst.inc
> > index 105cb9679c..fdcf343652 100644
> > --- a/docs/system/qemu-block-drivers.rst.inc
> > +++ b/docs/system/qemu-block-drivers.rst.inc
> > @@ -172,6 +172,37 @@ This section describes each format and the options=
 that are supported for it.
> >      filename`` to check if the NOCOW flag is set or not (Capital 'C' i=
s
> >      NOCOW flag).
> >
> > +  .. option:: zoned_profile
> > +
> > +    The option configures the zoned format feature on the qcow2 driver=
. If
> > +    this is set to ``zbc``, then it follows the basics of ZBC/ZAC prot=
ocol.
>
> What about virtio-blk? NVMe ZNS? Please indicate what effect the profile
> has and whether it works with all emulated storage controllers that
> support zoned storage.

The ZNS profile hasn't been included in this patch series yet.

Both ZNS and ZBC profiles can be used as the backing file for
virtio-blk passthrough. Though the NVMe controller with ZNS can only
use the ZNS profile. The ZNS profile can have a smaller size of
zoned_capacity than zone_size and only allows sequential write
required zoned type.

>
> > +
> > +  .. option:: zone_size
> > +
> > +    The size of a zone of the zoned device. The zoned device have the =
same
>
> "in bytes"? Please document the units.
>
> > +    size of zones with an optional smaller last zone.
>
> "The device is divided into zones of this size with the exception of the
> last zone, which may be smaller."
>
> > +
> > +  .. option:: zone_capacity
> > +
> > +    The capacity of a zone of the zoned device.
>
> This can be expanded:
>
>   The initial capacity value for all zones. The capacity must be less
>   than or equal to zone size. If the last zone is smaller, then its
>   capacity is capped.
>
> > The zoned device follows the
> > +    ZBC protocol tends to have the same size as its zone.
> > +
> > +  .. option:: zone_nr_conv
> > +
> > +    The number of conventional zones of the zoned device.
> > +
> > +  .. option:: max_open_zones
> > +
> > +    The maximal allowed open zones.
> > +
> > +  .. option:: max_active_zones
> > +
> > +    The limit of the zones with implicit open, explicit open or closed=
 state.
> > +
> > +  .. option:: max_append_sectors
> > +
> > +    The maximal sectors that is allowed to append to zones while writi=
ng.
>
> Does "sectors" mean 512B blocks or logical block size?

According to virtio spec, it means 512B blocks.

Thanks!

>
> > +
> >  .. program:: image-formats
> >  .. option:: qed
> >
> > --
> > 2.40.1
> >

