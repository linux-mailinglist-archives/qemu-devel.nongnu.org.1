Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B03D73AB34
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 23:09:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCRXT-000889-Fa; Thu, 22 Jun 2023 17:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qCRXJ-00087g-L3
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:08:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qCRXH-0001A0-KK
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687468090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4BEuKRqJK99EpRlO+xd0ib8HBz6f0klZzaQbuKMkewg=;
 b=AxHoh96DYixf0TckluiEx5WEF/Wt/xTVtXAvSNv0RryCCRM5vx1q7hsn07wMs9D8vNMl+E
 DhJ0AwPNWfiz83Hz7CEttWxYAtIT9y7rBHqDuOmHhYrqvt9np0/6znmydX5reFWr6sQsff
 HCc8Ay33w9oZN9OF4tTiLZ8UYAqiqyw=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-ih72GSwZM6mTTO2fEks27w-1; Thu, 22 Jun 2023 17:08:08 -0400
X-MC-Unique: ih72GSwZM6mTTO2fEks27w-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3a057df5833so1487434b6e.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 14:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687468088; x=1690060088;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4BEuKRqJK99EpRlO+xd0ib8HBz6f0klZzaQbuKMkewg=;
 b=Zwck9nfRs/S4Tn99628wacpfE5FdN0ywxu8eDltb3RqPqnW9BR+ex/NPtWNilJMfXM
 f8qTz7yEO/Hg/BjJUIk4Ao0i/SEze19kezSc2Y/bZc8nTW84z6fSsGUevISVz6dID/NE
 6UZneIKWQEYVJDL3/MRJAX6NGusZx0H6huH4pIuYyYZhxpkuRGWiEmLch4ib/ZEo1nHT
 kdy1KOV+u5q5JorPgu/u52gwXls/vMNJDACGxQZgK0E/sHsLqYwziFstZp4hhSpot1qw
 LislpmfPOS4ikzMXFMS3Y/oQR5UjLQTlWt+67zncIOAC3I0lZMy4SA5OMpr9nvaev8/8
 bugg==
X-Gm-Message-State: AC+VfDzJD1WYSEnWrj/YsXg/DRxOTIXeJBEmRIxVikUSlBRenO8xBdSG
 uSEUvxOgoxP22d5Kf4D1JX8CVNLGZaBDWkocR4DWG/hnyv8dXBrWBnmrClduf88MrihrGdUMveO
 pYJu1pHBfPF9Gz9xGBgXhJoyydgDDUnY=
X-Received: by 2002:a05:6808:188a:b0:3a1:7985:d0d2 with SMTP id
 bi10-20020a056808188a00b003a17985d0d2mr1500969oib.43.1687468087908; 
 Thu, 22 Jun 2023 14:08:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7BuY4wWnP+dW7cRaCL4WHlFroFcs0Ju1Xv1d0N086BS20kRxLh4pxutyl44C0PA6/5z5x9aSiV1CWEHsjap9I=
X-Received: by 2002:a05:6808:188a:b0:3a1:7985:d0d2 with SMTP id
 bi10-20020a056808188a00b003a17985d0d2mr1500950oib.43.1687468087563; Thu, 22
 Jun 2023 14:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230621002121.1609612-1-jsnow@redhat.com>
 <CABgObfahSN4eQ65nu9Dy_7bkWmxfERiJ-ZEM729futMFuGWwPw@mail.gmail.com>
 <CABgObfYKK+eU56iP2O+O7s=dcfWxmpXrB3EuNj=CkUw-XEjSnA@mail.gmail.com>
 <CAFn=p-a1Lz=FdrAYcB8Ua3AK=C5674Lyg5vRyxNjaybNXgvQ0w@mail.gmail.com>
 <CABgObfYo34ZOqAGdf9jEEQUtTztcwDUF+N9JGSsbBw8z1FOoWQ@mail.gmail.com>
In-Reply-To: <CABgObfYo34ZOqAGdf9jEEQUtTztcwDUF+N9JGSsbBw8z1FOoWQ@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 22 Jun 2023 17:07:56 -0400
Message-ID: <CAFn=p-YnhA=FGPbPifY9vR=skpV=8dVvtmgdivJGw0cNjR6ouw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] Switch iotests to pyvenv
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Beraldo Leal <bleal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 22, 2023 at 5:05=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On Thu, Jun 22, 2023 at 11:03=E2=80=AFPM John Snow <jsnow@redhat.com> wro=
te:
> > If we always install it in editable mode, and the path where it is
> > "installed" is what we expect it to be, it shouldn't have any problems
> > with being out of date.... I think. We could conceivably use the
> > "faux" package version the internal package has to signal when the
> > script needs to re-install it.
>
> Stupid question, why not treat it just like avocado?
>

How do you mean? (i.e. installing it on-demand in reaction to "make
check-avocado"?)


