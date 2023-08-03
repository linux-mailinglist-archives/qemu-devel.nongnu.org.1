Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 237AA76F49C
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 23:28:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRfqc-0005bc-ON; Thu, 03 Aug 2023 17:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qRfqa-0005Y8-Sx
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 17:27:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qRfqZ-0002RN-2M
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 17:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691098021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dmimAJVIDox/WwTs6Q8PIL+BZOXo483HsvUL+2/WTWk=;
 b=f9av3PRB4T8TSxwoD3pH8uwv0ZrLJV3MI30Zye+rRgCj0hdnu5YC1M5pdXjD88BAIA7rw4
 r3dyHcTEjaProSESKSrrzQ85B9y2q3u+rYibF2aiWj3LLEpNr65nYuS3UWdTOuuhDM41F4
 Q5By7qUErrDXG8umYOkS0jtwCQuLuuY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-BiZwkmQGMlyjofjmRBpyew-1; Thu, 03 Aug 2023 17:27:00 -0400
X-MC-Unique: BiZwkmQGMlyjofjmRBpyew-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-583a89cccf6so15331607b3.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 14:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691098020; x=1691702820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dmimAJVIDox/WwTs6Q8PIL+BZOXo483HsvUL+2/WTWk=;
 b=ho00VatLgGBQa2eJcWtdFky1Fr+9Kl5kXdTK792btWMUJ61n6083IyAZBKqTLY5R1h
 pOh33iQtOXFjUjyzRNkygbk+BKLzjJDYlp/hC1E6QOkxqq4lgsKgyuzP4kwPFwqCRZEl
 mtSPI6UOPZRwePKVHpxOO8rvGAuGJn8T1Cn3smeM9ft0uQ+AYyySE8OvAn+J/KyqwAZc
 RUz/e1LRuW7qHAYPfuS/Ad4p6kg9t7MKBxSkFJ6am3zGQqw6nYHSyVakV7D9SQswG8w6
 y/c1iVev8wv+gPdpoccy35GN0f5TLRiqL1au+XdSv99+NWllbOa03Y+AKwzFgLAaL0dE
 cNCg==
X-Gm-Message-State: ABy/qLbARl1LbgJW9oxxvGWfomKVDNkApDveksXzvRIBCUynxfTuCMup
 CrbseKklNgYTtDov/j/rzL0CdzFgSCnyo3ZWQDUqNzqfM0JQDK63VlBq8cIDo8BCKob+BDE7L52
 N53/xaYsK2fE2sd+JAdFvbL59cNSdJSE=
X-Received: by 2002:a81:a141:0:b0:57a:2e83:4daf with SMTP id
 y62-20020a81a141000000b0057a2e834dafmr18954514ywg.32.1691098019835; 
 Thu, 03 Aug 2023 14:26:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFwJOgLORoiAO33KDwPFlueR4KsWhQGMzq/Cqrxj61FIy670KgNhsr1RtWw92MQRJSFATprjTx3seKSd6z8mNs=
X-Received: by 2002:a81:a141:0:b0:57a:2e83:4daf with SMTP id
 y62-20020a81a141000000b0057a2e834dafmr18954504ywg.32.1691098019615; Thu, 03
 Aug 2023 14:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <20230803160101-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230803160101-mutt-send-email-mst@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 3 Aug 2023 23:26:47 +0200
Message-ID: <CAGxU2F7jiz++0GBO=BEXo7z9AP5vS7xCm_GKHi=8nA6THSzURA@mail.gmail.com>
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 Thomas Huth <thuth@redhat.com>, qemu-stable@nongnu.org, 
 Mark Kanda <mark.kanda@oracle.com>
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

Hi Michael,

On Thu, Aug 3, 2023 at 10:02=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jul 05, 2023 at 09:15:23AM +0200, Stefano Garzarella wrote:
> > This reverts commit 8cc5583abe6419e7faaebc9fbd109f34f4c850f2.
> >
> > That commit causes several problems in Linux as described in the BZ.
> > In particular, after a while, other devices on the bus are no longer
> > usable even if those devices are not affected by the hotunplug.
> > This may be a problem in Linux, but we have not been able to identify
> > it so far. So better to revert this patch until we find a solution.
> >
> > Also, Oracle, which initially proposed this patch for a problem with
> > Solaris, seems to have already reversed it downstream:
> >     https://linux.oracle.com/errata/ELSA-2023-12065.html
> >
> > Suggested-by: Thomas Huth <thuth@redhat.com>
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D2176702
> > Cc: qemu-stable@nongnu.org
> > Cc: Mark Kanda <mark.kanda@oracle.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
> scsi maintainers, what should be done about this patch?
> we don't want a regression in the release ...
> revert for now and think what's the right thing to do is
> after the release?

We found the issue and fixed it in this release with commit 9472083e64
("scsi: fetch unit attention when creating the request").

So we don't need to revert it anymore.

Thanks,
Stefano


