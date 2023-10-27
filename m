Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B5D7D8E3B
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 07:41:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwFZz-0005PL-IH; Fri, 27 Oct 2023 01:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qwFZm-0005O0-Ft
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 01:40:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qwFZk-00008F-DC
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 01:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698385198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wjtZTG2Rnmx2hFIhfrtgcIu95XQXZ3W9J6Io7uqCACU=;
 b=dLXtfZUIJt+mObRs9ukuDvzzKfo2D7CNpJEnSRV8d/Om4ZjIFdoCCggu7OF/KJtq/CC6BZ
 WtAqj2rFb3TZPM4uaHBO0icRbO1+RW2LVDEYREbcFTNC8mONI/AiSrjJSzVGh2DXNYzrna
 yJbpxFS500EQmV/BT/Zx6ZWBRMVNIf4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-lPeMqCRdN8uv0r7TGblqiA-1; Fri, 27 Oct 2023 01:39:56 -0400
X-MC-Unique: lPeMqCRdN8uv0r7TGblqiA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-507d208be33so1688543e87.3
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 22:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698385195; x=1698989995;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wjtZTG2Rnmx2hFIhfrtgcIu95XQXZ3W9J6Io7uqCACU=;
 b=F7qZEeLi5odZELMXZKx7ftB3Ja6TRTJnTv/cR9wcaUAhww68qCGshMBgGRNJDL5O0I
 izr+0YZv3iEO+/tZohOwwexSlRxA9WnDFzD38osUGwbZeReDUSrA25PJQAt0e3f//GYw
 +70noSEO+sCMrhCLMFpLaA44B1a6xU4XVkj9uPWj+gRQqtJ/Bq9CFXmBQqjEbIqmys0q
 9rUmxdHF6XU1goOcSToquQ1oCHx/CviFkqOqTgV7wC8yM7a7fgeOMhpb+ox/Snj5jiz6
 P4JZzxH4od6JZ9Wp3LUTWv4I3BA8q8O+ZC7rJZDz2F+jVK3Bae2UohvDV0OMSIGAZICA
 gXfw==
X-Gm-Message-State: AOJu0Yw1C8NQM952mDp5f9yqlqnInSPr+CrK5MLUd3YX9JOcjK4XWvKW
 Qt6VJP6Mc2Gv6UU/0q8gKA1+6PCvHbNY5Qo3ePkPPvllRu+CNOaocl9b7ZRlcqE32kBsmjPf/xq
 fUos7g5z4SH6ZwGNz5M4skxLSG6+PNKY=
X-Received: by 2002:a05:6512:238c:b0:503:261d:eab8 with SMTP id
 c12-20020a056512238c00b00503261deab8mr1258475lfv.28.1698385195264; 
 Thu, 26 Oct 2023 22:39:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEVes61MpduCrCDUmBKwpOT9wvQ97FunnizFW+n6dtYz27XgcD/g4DFn2RwV1ZUe04ab+2dC9TeoBOxehiXT0=
X-Received: by 2002:a05:6512:238c:b0:503:261d:eab8 with SMTP id
 c12-20020a056512238c00b00503261deab8mr1258472lfv.28.1698385194917; Thu, 26
 Oct 2023 22:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231023154507.253641-1-clg@kaod.org>
 <7ce1c530-1ba3-4b9c-84ef-2fae5e217cb0@daynix.com>
In-Reply-To: <7ce1c530-1ba3-4b9c-84ef-2fae5e217cb0@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Oct 2023 13:39:43 +0800
Message-ID: <CACGkMEuEo1vb401S99LdFN1_LWM=QhCDRBHnZ4YHFSqLfj+H=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] igb: Add FLR support
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 24, 2023 at 11:30=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> On 2023/10/24 0:45, C=C3=A9dric Le Goater wrote:
> > From: C=C3=A9dric Le Goater <clg@redhat.com>
> >
> > Hello,
> >
> > Here is a little series adding FLR to the new IGB models.
> >
> > Thanks,
> >
> > C.
> >
> > Changes in v2:
> >
> > - add a "x-pcie-flr-init" compat property for pre 8.2 machines
> >
> > C=C3=A9dric Le Goater (2):
> >    igb: Add a VF reset handler
> >    igb: Add Function Level Reset to PF and VF
> >
> >   hw/net/igb_common.h |  1 +
> >   hw/net/igb_core.h   |  3 +++
> >   hw/core/machine.c   |  3 ++-
> >   hw/net/igb.c        | 15 +++++++++++++++
> >   hw/net/igb_core.c   |  6 ++++--
> >   hw/net/igbvf.c      | 19 +++++++++++++++++++
> >   hw/net/trace-events |  1 +
> >   7 files changed, 45 insertions(+), 3 deletions(-)
> >
>
> For the whole series:
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>

Queued.

Thanks


