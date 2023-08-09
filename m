Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F3E776295
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 16:35:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTkG4-00021g-Ll; Wed, 09 Aug 2023 10:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTkG2-000213-3J
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 10:33:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTkG0-0008SJ-Bt
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 10:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691591631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DMQPZZe7Gyvht16fOAZ/QWMdNA669oDXIaGUEX2gqlE=;
 b=DOFwcOvNgNyMBvXbxrPFnxu4D/vm5vmGIKbxsaldsC8GTnro7xdIEOQsB/615rHlWq2GZr
 IsSwHwwIqUMbFyNNsEt2dgayRAFty0t51TKeMlMCw+YUOmMcqw0jvIMeznw4mYRrzxxgM4
 Pb04Xo3yG2XD8OoIZHT+m6h3Y3Svzms=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-84_KYBZoNXSkuDxq6ELTXw-1; Wed, 09 Aug 2023 10:33:49 -0400
X-MC-Unique: 84_KYBZoNXSkuDxq6ELTXw-1
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-447783b6c09so1481230137.3
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 07:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691591629; x=1692196429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DMQPZZe7Gyvht16fOAZ/QWMdNA669oDXIaGUEX2gqlE=;
 b=WNmXcUHNHrAm/5ipaHLiKdRgP2dxHFqb3r/tROwTxvwUfr8Xq9+j6DZ+5RmPKP8kXD
 kkdLvBSD9ugvqofEKSpxgYVrK+6bQL1N81kdusb096XvTMeOQCbdzu43tc1JOEPCF+Rs
 QASdVRBGMmhI/j6WCEddhrQ5yuJUlSwHONpSWrZ+iyo1kuGDrC7PQS4TWNNhV1qsq2Na
 KVqleJzsx26D05tIbDehgOvwHJkJkHrMDTelkSPJNbFJ4LP8Ns25fysc5smJNkuG9Rdn
 VfEfP2djY6BsMBpzMjaK9nSLJP89wsDf/kPkeBsq4Y0eiM/kMf35pNszo3yOLbI4CvJe
 AiSw==
X-Gm-Message-State: AOJu0Yxqm86HNFe55YXyKyHt+WYrLXEnd/WlErrwznh+gDkpgZ15yz+D
 y5j1+rKyv7XZwK5BW5S5SUHwzJANgyMWlVvtwZqtkJ3yLKHWRRQqoCStY3xPplH3AR2S6IvMGA0
 I7uXgiS0kA8GheUX1sHgB0a7sclLUDzU=
X-Received: by 2002:a67:fa58:0:b0:443:6052:43ae with SMTP id
 j24-20020a67fa58000000b00443605243aemr2852314vsq.24.1691591629249; 
 Wed, 09 Aug 2023 07:33:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy+DlJcbtgo/agArJ0Yg38DqBk6kNe8ZQEhbvuq6DMG7LUg1Or5igtx+AflAyAEDZ3ApisLICCdbJ3/a+az/Y=
X-Received: by 2002:a67:fa58:0:b0:443:6052:43ae with SMTP id
 j24-20020a67fa58000000b00443605243aemr2852301vsq.24.1691591628995; Wed, 09
 Aug 2023 07:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230809082946.747668-2-pbonzini@redhat.com>
 <ydnxvhzqxdnijglqo2tpeopfl6m7gqep2ovw2znll4aaner7lv@cx73n3cit6uu>
In-Reply-To: <ydnxvhzqxdnijglqo2tpeopfl6m7gqep2ovw2znll4aaner7lv@cx73n3cit6uu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 9 Aug 2023 16:33:37 +0200
Message-ID: <CABgObfYGPsK8HWMQzbEbzy2JJX5p9jXeru9J5PjBJ1_Pfv1dCA@mail.gmail.com>
Subject: Re: [PATCH for-8.2] dockerfiles: bump tricore cross compiler
 container to Debian 11
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On Wed, Aug 9, 2023 at 3:53=E2=80=AFPM Bastian Koppelmann
<kbastian@mail.uni-paderborn.de> wrote:
> > diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tes=
ts/docker/dockerfiles/debian-tricore-cross.docker
> > index 269bfa8d423..5bd1963fb55 100644
> > --- a/tests/docker/dockerfiles/debian-tricore-cross.docker
> > +++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
> > @@ -9,7 +9,7 @@
> >  #
> >  # SPDX-License-Identifier: GPL-2.0-or-later
> >  #
> > -FROM docker.io/library/debian:buster-slim
> > +FROM docker.io/library/debian:11-slim
>
> I think it would be better to skip debian-11 and use 12 instead.

I picked 11 in order to keep the container in sync with the
lcitool-generated dockerfiles. Once we switch lcitool from 11 to
12, it is easier to see what the changes are and replicate them in
debian-tricore-cross and friends.

lcitool support for Debian 12 has already landed, but usually we
try to keep the containers on the oldest supported release of a
distro, and that is currently Debian 11.

Paolo


