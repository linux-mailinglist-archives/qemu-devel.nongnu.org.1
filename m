Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AB2720960
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 20:48:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q59nW-0001sT-Pp; Fri, 02 Jun 2023 14:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q59nA-0001s7-RM; Fri, 02 Jun 2023 14:46:28 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q59n8-0006Uk-UP; Fri, 02 Jun 2023 14:46:28 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-97460240863so161719966b.0; 
 Fri, 02 Jun 2023 11:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685731585; x=1688323585;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gcMbFM1KZ0fWjQ5u5YqOge5c5db55RI/e4TXcTuJU+4=;
 b=m26h9HJl4/Hi+sQUV3crL1mH8JT1NXlbnXTT27FM2w9akWJfgCkELak9VpHuAMc0Uo
 9j2xEPsXNCwTn8BPX5xNvGt63qtniCft0QGZDSycYW9KQoIloKAQKjHo/liqkccjpOuN
 oh+qR6o1vrxQRfccVhn6yDCXZUz9s+vXzYrnKT5Y4HphLNOEBssB1qDYfdVhnmNx4s6W
 XFOtmz3zIzVSeVKg1TOJXsYrhbc2M5pVG2OxxeCkCy//3Opomwj65Knd3O38znyCWnIA
 eowJ4juq2QUH7PJehtAR128z8cpqPl4gRPBBPRcU3eNxxZV7TmoF6CKC7hLmMzEygX8s
 EC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685731585; x=1688323585;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gcMbFM1KZ0fWjQ5u5YqOge5c5db55RI/e4TXcTuJU+4=;
 b=TkvTvBcg7WFeTm8uDyxd5Ulc02wU8DiysiE3gf4ML5MkR/WeR8vBbqeCj0GZFigyT1
 msS58uNCoqpr9CTC43zArLLDEvjMx1ZBqAuQLtRhp3wfKjGHOVQshQbQo2m0VzZ+6lLx
 /v6l5cZFyDdNt82O32dZfB8qMrkTKPviCLQnHncoiek6HphaclNkBTrntet31iTmYEAb
 uSasEeqIeS03Kmf9W93vIF6cOUxFQhINV1zyftq7r/3iTQ5G6BbSRxW00UMaWVVO64hx
 zVU7Pz5FjlWqNvUKVtW7WZDUq6LnnwdguNNkDex95jHxhkT0ZNUMbw7CaZJJLZ7Qe0V8
 03Lg==
X-Gm-Message-State: AC+VfDzyGb+SUqdYoCPccAcNllG9257HCoU+dKvX6rR/2Xc1yA9SMet0
 FGc4W7pIu2HJ1CyhjAKxvcjHwLv7ByyycyLSl14=
X-Google-Smtp-Source: ACHHUZ5URTJBxPBlyNic36Y6ggfMsax6eUizwkvnxwoIykktv5r48r1z3B0jUMTPKz/8GC4Zbsi11eHb9B+CDk+3xRg=
X-Received: by 2002:a17:906:6a0c:b0:973:daa0:2f6 with SMTP id
 qw12-20020a1709066a0c00b00973daa002f6mr12535244ejc.3.1685731584596; Fri, 02
 Jun 2023 11:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230515160506.1776883-1-stefanha@redhat.com>
 <20230515160506.1776883-3-stefanha@redhat.com>
 <8b0ced3c-2fb5-2479-fe78-f4956ac037a6@linux.ibm.com>
 <CAAAx-8Km7J8dfz_63y1W5wE8MH7hJXo04ajY1A-ctv--x9CpGA@mail.gmail.com>
 <638895f7-78b8-6e15-bbf8-916fc1513287@linux.ibm.com>
In-Reply-To: <638895f7-78b8-6e15-bbf8-916fc1513287@linux.ibm.com>
From: Sam Li <faithilikerun@gmail.com>
Date: Sat, 3 Jun 2023 02:45:58 +0800
Message-ID: <CAAAx-8LvRc73G0q30VZW8EFdZE_WNiPkWwgMxAmaLdJ-o_v2bw@mail.gmail.com>
Subject: Re: [PULL v2 02/16] block/file-posix: introduce helper functions for
 sysfs attributes
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Julia Suvorova <jusual@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>, 
 Kevin Wolf <kwolf@redhat.com>, kvm@vger.kernel.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Raphael Norwitz <raphael.norwitz@nutanix.com>, qemu-block@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hannes Reinecke <hare@suse.de>, 
 Damien Le Moal <damien.lemoal@opensource.wdc.com>, 
 Dmitry Fomichev <dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=faithilikerun@gmail.com; helo=mail-ej1-x632.google.com
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

Matthew Rosato <mjrosato@linux.ibm.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=883=
=E6=97=A5=E5=91=A8=E5=85=AD 02:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On 6/2/23 2:18 PM, Sam Li wrote:
> > Matthew Rosato <mjrosato@linux.ibm.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=
=881=E6=97=A5=E5=91=A8=E5=9B=9B 02:21=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 5/15/23 12:04 PM, Stefan Hajnoczi wrote:
> >>> From: Sam Li <faithilikerun@gmail.com>
> >>>
> >>> Use get_sysfs_str_val() to get the string value of device
> >>> zoned model. Then get_sysfs_zoned_model() can convert it to
> >>> BlockZoneModel type of QEMU.
> >>>
> >>> Use get_sysfs_long_val() to get the long value of zoned device
> >>> information.
> >>
> >> Hi Stefan, Sam,
> >>
> >> I am having an issue on s390x using virtio-blk-{pci,ccw} backed by an =
NVMe partition, and I've bisected the root cause to this commit.
> >>
> >> I noticed that tests which use the partition e.g. /dev/nvme0n1p1 as a =
backing device would fail, but those that use the namespace e.g. /dev/nvme0=
n1 would still succeed.  The root issue appears to be that the block device=
 associated with the partition does not have a "max_segments" attribute, an=
d prior to this patch hdev_get_max_segment() would return -ENOENT in this c=
ase.  After this patch, however, QEMU is instead crashing.  It looks like g=
_file_get_contents is returning 0 with a len =3D=3D 0 if the specified sysf=
s path does not exist.  The following diff on top seems to resolve the issu=
e for me:
> >>
> >>
> >> diff --git a/block/file-posix.c b/block/file-posix.c
> >> index 0ab158efba2..eeb0247c74e 100644
> >> --- a/block/file-posix.c
> >> +++ b/block/file-posix.c
> >> @@ -1243,7 +1243,7 @@ static int get_sysfs_str_val(struct stat *st, co=
nst char *attribute,
> >>                                  major(st->st_rdev), minor(st->st_rdev=
),
> >>                                  attribute);
> >>      ret =3D g_file_get_contents(sysfspath, val, &len, NULL);
> >> -    if (ret =3D=3D -1) {
> >> +    if (ret =3D=3D -1 || len =3D=3D 0) {
> >>          return -ENOENT;
> >>      }
> >>
> >
> > Hi Matthew,
> >
> > Thanks for the information. After some checking, I think the bug here
> > is that g_file_get_contens returns g_boolean value and the error case
> > will return 0 instead of -1 in my previous code. Can the following
> > line fix your issue on the s390x device?
> >
> > + if (ret =3D=3D FALSE) {
> >
> > https://docs.gtk.org/glib/func.file_get_contents.html
>
> Hi Sam,
>
> Ah, good point, I didn't notice file_get_contents was meant to be a bool =
return and wondered why I was getting a return of 0 in the failing case, he=
nce the check for len =3D=3D 0.
>
> Anyway, yes, I verified that checking for ret =3D=3D FALSE fixes the issu=
e.  FWIW, along the same line I also checked that this works:
>
>     if (!g_file_get_contents(sysfspath, val, &len, NULL)) {
>         return -ENOENT;
>     }
>
> which I personally think looks cleaner and matches the other uses of g_fi=
le_get_contents in QEMU.  Could also get rid of ret and just return 0 at th=
e bottom of the function.

Indeed. I will fix this. Thanks!

Sam

