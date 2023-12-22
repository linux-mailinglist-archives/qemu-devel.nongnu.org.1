Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B980781CEA9
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 20:09:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGks6-00074C-1s; Fri, 22 Dec 2023 14:07:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rGks4-00072x-PO
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 14:07:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rGks3-0003Su-8F
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 14:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703272061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3DQa1syTPVDtDdi5/vkHgqPw58Hc89eRISvCfQ34skA=;
 b=Sii8sywGHGiV9RXaMEcoalavNoWIF/ZTONll6DqUMnesZObxBMXPtbsxea15CoWXPaFVJK
 IBRfwhsG+S+RZKm4OVV8Le5Qv4r29+hvdgs96zcNUtWZ658vLcArzEJCVxpug2IYFPS0eU
 2qeLPxCSdfKqOVDfu5a1F0PcnbArfQQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-cwRT0BDGOXuwvnVAWSYW4w-1; Fri, 22 Dec 2023 14:07:40 -0500
X-MC-Unique: cwRT0BDGOXuwvnVAWSYW4w-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-5e9a02c6d49so28797767b3.2
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 11:07:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703272059; x=1703876859;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3DQa1syTPVDtDdi5/vkHgqPw58Hc89eRISvCfQ34skA=;
 b=KAjXgFkl0DhyxKbV1Jv0g3AtwTtaY8Iy+e33Rb+Nuu6tiN+eN4vvXKcmBsDQyBInQT
 Gs43A6sRQL5b7ycffQ06Zr+DWkce/eL1XY39LDtTfHyeDvSdvDbeYFLwda5asx7cl05D
 SyKEgeCIay+jL0f6ukyA6Yyua6XEsvDtTDXGOE/ZkOSAk1hpns4svQbodjNQwot4NX2r
 OdKbVMRtkoVzGlsBZ6rH2iQyh6vvpFX1uVD9wuFDrk6bb5/yuooEOewBuuApbbR2t7wj
 LjfO+KNDKozXKdnzwm3diFjfe+CzIKte3rW8mI6bH8HR/NsfQ9ICCiR+ECQu/QGuJB86
 HweA==
X-Gm-Message-State: AOJu0YwvrXuF/snnZ4vFmZNCfbpQ4rBh0bRYejlTB6lIQEZHWuJ8n4k0
 LlmLdVFnJlNNP5/nTZtNLDskA5/f6EAZyIjLLY1LhrHfFow4OHAghqgZS0pn1W7cbyHBObgAwZq
 hUpkuez27hBf6uIEy+hgBmXtZXcNo5goSjyu7wM4=
X-Received: by 2002:a0d:d708:0:b0:5e9:4438:4f56 with SMTP id
 z8-20020a0dd708000000b005e944384f56mr1700524ywd.20.1703272058919; 
 Fri, 22 Dec 2023 11:07:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtj6MViq1hr3QbcrI7EpB0Hlh1iHZTN4OCE6Xs3Npie0aFkzzBnFhq0l+rTGlHoJ+uph/6ER2V32ErxAnaLHY=
X-Received: by 2002:a0d:d708:0:b0:5e9:4438:4f56 with SMTP id
 z8-20020a0dd708000000b005e944384f56mr1700515ywd.20.1703272058663; Fri, 22 Dec
 2023 11:07:38 -0800 (PST)
MIME-Version: 1.0
References: <20230918044932.1433744-1-yajunw@nvidia.com>
 <CAJaqyWfuXDY7jBSQsS=0Ws7mpZLcsed6bpQbM+eZGLU5AzCw1Q@mail.gmail.com>
 <6d9b034f-fe16-7ed8-6156-9c404a860489@nvidia.com>
 <CAJaqyWdLHdXpTdnxdMn6SbvKywFB7oD=m806TebUcR23u7iokg@mail.gmail.com>
In-Reply-To: <CAJaqyWdLHdXpTdnxdMn6SbvKywFB7oD=m806TebUcR23u7iokg@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 22 Dec 2023 20:07:02 +0100
Message-ID: <CAJaqyWdc6cb1H4UxNw2Go04pe9NAt9F0GQ8c1Gf8xyYCQ-+cUQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] virtio-net: Introduce LM early load
To: Yajun Wu <yajunw@nvidia.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>, 
 "mst@redhat.com" <mst@redhat.com>, parav@nvidia.com, jiri@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
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

Hi Yajun,

Sorry for the late reply.

Apart from the few nitpicks commented, I think it is valid to start
from this series and then add the capability to re-send the
configuration in case the source changes it by another series on top.
That would allow us to keep both series small.

Not sure if all can be done before the next release, so we don't have
to change the virtio-net migration format twice...

Please let me know what you think about the comments.

Thanks!

On Thu, Oct 19, 2023 at 5:00=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Oct 18, 2023 at 8:41=E2=80=AFAM Yajun Wu <yajunw@nvidia.com> wrot=
e:
> >
> >
> > On 10/18/2023 12:47 AM, Eugenio Perez Martin wrote:
...


