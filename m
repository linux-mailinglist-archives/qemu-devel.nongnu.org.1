Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C534784AE5
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:59:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYXWF-0007Qm-0a; Tue, 22 Aug 2023 15:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qYXWA-0007Pk-9k
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qYXW7-0004qD-Ve
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692734299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JrGcOWvOwZLXJoLuTHTB3L/JHGZfTlkXEYij/vmmYMc=;
 b=PUvZiJD984E2hSzLwGu/7WnzCMuSyDiMOK+YFRq4LEveFe5vdLmzGtxlPAb3WaZ/Jdsrqa
 7kqh+W5DalB0FILkGM+OplbJq+KpPJNrel8CQqLhM8tv85FUGuMQ4MRlC+h2YSNQ8NC1pf
 U6ZAYHye8Iwa5D4CQk4ELXHXjFgjODA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-KNR9jHy_NJ-DEFZQlL8tOw-1; Tue, 22 Aug 2023 15:58:17 -0400
X-MC-Unique: KNR9jHy_NJ-DEFZQlL8tOw-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-68a3cdf000cso3832179b3a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 12:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692734296; x=1693339096;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JrGcOWvOwZLXJoLuTHTB3L/JHGZfTlkXEYij/vmmYMc=;
 b=lind3D0dLnB2WRHnpKL2njLbWWjuyOmMsldwPSt0AI9HSUxU5ZjXEf2RS8GDA2O9i9
 cTVg353HW7i2bEuwR2uTi8Fk7K7z923ipxNXxxm4aCoPI28iOJulZgUDOVn4hFck8ct0
 T0ttWqv5a32upuFHuu6AlhWqYw19yrxxkOp1Wh1G4XZf31B/u/+vwaBDquSWORjFnWgZ
 V2YTA05IkpQchkmng6rSTJlW45RRzW1bxySXhncNBPzXx2dEoaEF7vAO806IuTVaPRmF
 Jgw+EztoA3HLK1hANWSofOQqf9hASRSswbRROYhP5Dhd8OKq+iaChGtj/bvC1hMrPVqD
 Ar3g==
X-Gm-Message-State: AOJu0YxlUd7It+x9BgyrDcu/y1ZVmI5K8ZmHchuB6wpWhg9m9T1kgsHH
 mqJ43CyZHGOrJwQ31UZK5RdS3LtLnSpAHZSTlULzLioTJqWMamxoT70QeYCjhDwq2bpSdaqquq4
 nEXaphxBAZU8W4BecmReN0JXZLWHdWb4=
X-Received: by 2002:a05:6a00:1a15:b0:68a:5937:eaa2 with SMTP id
 g21-20020a056a001a1500b0068a5937eaa2mr6757973pfv.12.1692734296459; 
 Tue, 22 Aug 2023 12:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELtRYdzKdhb+9iogxHW5F1EIMTu9D/LJF1LmDdqyqxVooe7lAxjbHT8EekVb/u6zsmxasZrqxT/RgIU2VQKGw=
X-Received: by 2002:a05:6a00:1a15:b0:68a:5937:eaa2 with SMTP id
 g21-20020a056a001a1500b0068a5937eaa2mr6757953pfv.12.1692734296104; Tue, 22
 Aug 2023 12:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
 <c49fd209-9a6a-9e0d-752f-30a5178d855b@virtuozzo.com>
 <85e0a9bb-8e8f-e414-70ad-528e45a803e4@virtuozzo.com>
 <60354ae2-d394-49b8-8289-787b4e02e2a6@virtuozzo.com>
 <577e81f0-1479-41b2-9e97-ad6678cf7216@virtuozzo.com>
In-Reply-To: <577e81f0-1479-41b2-9e97-ad6678cf7216@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 22 Aug 2023 15:58:05 -0400
Message-ID: <CAFn=p-bz35mcXgG81Dk70u4u8A8cqERot2=fJjYAcweThE0fVQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] block: align CoR requests to subclusters
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, qemu-devel@nongnu.org, 
 kwolf@redhat.com, hreitz@redhat.com, vsementsov@yandex-team.ru, 
 eblake@redhat.com, den@openvz.org, stefanha@redhat.com, fam@euphon.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

On Tue, Aug 22, 2023 at 1:33=E2=80=AFPM Andrey Drobyshev
<andrey.drobyshev@virtuozzo.com> wrote:
>
> On 8/16/23 12:22, Andrey Drobyshev wrote:
> > On 7/31/23 17:51, Andrey Drobyshev wrote:
> >> On 7/24/23 16:11, Andrey Drobyshev wrote:
> >>> On 7/11/23 20:25, Andrey Drobyshev wrote:
> >>>> v1 --> v2:
> >>>>  * Fixed line indentation;
> >>>>  * Fixed wording in a comment;
> >>>>  * Added R-b.
> >>>>
> >>>> v1: https://lists.nongnu.org/archive/html/qemu-block/2023-06/msg0060=
6.html
> >>>>
> >>>> Andrey Drobyshev (3):
> >>>>   block: add subcluster_size field to BlockDriverInfo
> >>>>   block/io: align requests to subcluster_size
> >>>>   tests/qemu-iotests/197: add testcase for CoR with subclusters
> >>>>
> >>>>  block.c                      |  7 +++++
> >>>>  block/io.c                   | 50 ++++++++++++++++++---------------=
---
> >>>>  block/mirror.c               |  8 +++---
> >>>>  block/qcow2.c                |  1 +
> >>>>  include/block/block-common.h |  5 ++++
> >>>>  include/block/block-io.h     |  8 +++---
> >>>>  tests/qemu-iotests/197       | 29 +++++++++++++++++++++
> >>>>  tests/qemu-iotests/197.out   | 24 +++++++++++++++++
> >>>>  8 files changed, 99 insertions(+), 33 deletions(-)
> >>>>
> >>>
> >>> Ping
> >>
> >> Another ping
> >
> > Yet another friendly ping
>
> One more friendly ping

Looks like Stefan gave you an R-B for the series; do we just need an
ACK by the block maintainers at this point or is there someone
specific you're hoping will review this?

--js


