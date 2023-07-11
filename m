Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6F674E8C1
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 10:14:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ8UL-000492-M8; Tue, 11 Jul 2023 04:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qJ8UD-00048Z-CW
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 04:12:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qJ8U8-0005Py-V3
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 04:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689063155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y5AshYkVmou9bv7BwDwL+TK+v/pijFw3cffWnbowyqw=;
 b=GXwjK5EZVwjreJa+XBHYGqqqubIfNseRMzxheDBXZd3thZffVlIStBV9kC1Y0Ys6NzzJga
 uQtPHggoOeOjmv6lNwGoArU+BQqHIKeHR+CABRHAeyU43GyhHReRm4bcqCKN3FbM6mCSAw
 RQGTItPjZr3x2kz1Yu23H/w6BYUbncQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-ZXXpW0VdOP-Uuko8mbmP-g-1; Tue, 11 Jul 2023 04:12:34 -0400
X-MC-Unique: ZXXpW0VdOP-Uuko8mbmP-g-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-57320c10635so60696347b3.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 01:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689063154; x=1691655154;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y5AshYkVmou9bv7BwDwL+TK+v/pijFw3cffWnbowyqw=;
 b=VmdN9jl8ZTSkZi1J6tkZ0ZYRCQggLGFYx2QVwHaOKHImJsIo/cG4dn2EVrRzRIa7xz
 rwNVbx8SZL+mQdCTVu7fv8hkNUe9tQEM8xUdxkOsCiCMuCK7nIWATSsdXcRa5Hvb7vlX
 FVFqYNPVVNxrb9uB6GSyIVbiM4hIO/6sBHEu/5ZA7C0ykZRia2kVVXrP2roZsk5QYx1x
 HOe6TfrRqn2l/dZ3oAwlBh+pkUvWE3pPBSZDXWYsa39dZ6W5tI+pZ12lY5GmULRVGqWb
 ZMN25DlfBAOJs0jbQ3bfHUUCXxhdZ+ybEfL/wO7PcsruZqS1TcVdzjBDL969zxnn7vri
 kegw==
X-Gm-Message-State: ABy/qLY3QpAXelg8PODsayZ3SURtjpodeYyctszTm0waHBVT8Hd41r8F
 eAt2oUp4zZzKVvFOn4S8L7Sy+Hq0C5K97yydLLR8ponjuj85FpY0NGWl4yOY1y2dFHpWBiHC5IN
 2J+lQvD7gI8fONB9UFmX3COXurpwYrG4=
X-Received: by 2002:a81:a103:0:b0:579:f5e3:ad07 with SMTP id
 y3-20020a81a103000000b00579f5e3ad07mr15206621ywg.14.1689063153893; 
 Tue, 11 Jul 2023 01:12:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFEKDzBGMwGlWS3AG1FOB+fGIxU1xC6fkoqmLi3EJCzBoEOPtJvO20s5j+DPDxFLwXGphIaoAFxihlG1brBdHc=
X-Received: by 2002:a81:a103:0:b0:579:f5e3:ad07 with SMTP id
 y3-20020a81a103000000b00579f5e3ad07mr15206613ywg.14.1689063153622; Tue, 11
 Jul 2023 01:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <3adcc3c3-c0ba-0810-10b6-b13ac36a5de9@oracle.com>
 <ujzth6z2w5cha3h4hbw6jufgux3phaaqc67zdn6obypwnmbxd2@qqssco2tgvwk>
 <0e79c985-32a2-4d43-17d9-abed49b553f8@oracle.com>
In-Reply-To: <0e79c985-32a2-4d43-17d9-abed49b553f8@oracle.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 11 Jul 2023 10:12:21 +0200
Message-ID: <CAGxU2F45Fpov_dn5Wb-1XDKDDBA2cBHhS-bRaBhb=VaONpCj8Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
To: Mark Kanda <mark.kanda@oracle.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

Hi Mark

On Fri, Jul 7, 2023 at 5:58=E2=80=AFPM Mark Kanda <mark.kanda@oracle.com> w=
rote:

[...]

> >> On 7/5/2023 2:15 AM, Stefano Garzarella wrote:
> >>> This reverts commit 8cc5583abe6419e7faaebc9fbd109f34f4c850f2.
> >>>
> >>> That commit causes several problems in Linux as described in the BZ.
> >>> In particular, after a while, other devices on the bus are no longer
> >>> usable even if those devices are not affected by the hotunplug.
> >>> This may be a problem in Linux, but we have not been able to identify
> >>> it so far. So better to revert this patch until we find a solution.
> >>>
> >>> Also, Oracle, which initially proposed this patch for a problem with
> >>> Solaris, seems to have already reversed it downstream:
> >>>     https://linux.oracle.com/errata/ELSA-2023-12065.html
> >>>
> >>> Suggested-by: Thomas Huth <thuth@redhat.com>
> >>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D2176702
> >>> Cc: qemu-stable@nongnu.org
> >>> Cc: Mark Kanda <mark.kanda@oracle.com>
> >>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >>
> >> Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
> >>
> >
> > Thanks for the review.
> >
> > By any chance do you have any information you can share regarding
> > [Orabug: 34905939] mentioned in the errata?
> >
> > I'd like to better understand why this patch created problems in Linux,
> > but solved others in Solaris.
>
> Apologies for the delay. I unfortunately can't provide any useful details=
. We
> had a brief internal discussion about whether the Solaris or Linux driver=
 was
> technically correct per SCSI spec (I'm not sure we came to a conclusion).=
 In any
> case, we ultimately decided it didn't matter because we cannot tolerate a=
 Linux
> regression, and therefore Solaris should change to behave like Linux.

Okay, thanks for the update.

We'll try to figure out what goes wrong in Linux, but if we can't we
should merge this before the next release.

Thanks,
Stefano


