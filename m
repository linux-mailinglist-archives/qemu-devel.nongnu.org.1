Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E3C73AB24
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 23:05:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCRUY-0006oN-Hc; Thu, 22 Jun 2023 17:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCRUS-0006ko-3I
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:05:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCRUQ-0007HN-G0
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687467913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Lp+SCrnT3303TfNo+zm3cEcP6B9Gn4KgYO8v5nO6w4=;
 b=iAGdhleJB0izSVUXSd+UepKQldskyFHy7Lf9Us7EdT6rHCA1aagCdnD0skbcl/lzlKpReX
 PLCYEn+FIrfjPR6hCVUUGa6gJQSU7C0gYR898MBtnvipT9AaCd4gl+6809WndFKMGKWEIX
 9xoHtZTayURpcQ9PtcjTnuCnn3X3TpA=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-dRCWdz7aO4u3XGuPoh__yg-1; Thu, 22 Jun 2023 17:05:11 -0400
X-MC-Unique: dRCWdz7aO4u3XGuPoh__yg-1
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-440c248e703so1308933137.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 14:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687467910; x=1690059910;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Lp+SCrnT3303TfNo+zm3cEcP6B9Gn4KgYO8v5nO6w4=;
 b=ZYNxm+thkYkyCR8Tv9RUMn5lNz0BlYyDBPomQ5aCFSZu1OlWpaTuPKCcpI+i90s0CG
 bqx2xEfa4tj8/8jH64/D9PYxn1pGjjdHDMxV1i9pTwp/MDn/AKMJDv1WxysnktsK3lei
 1bM5uIWVDbWTVaUaIX+6IxcTUYtdl382dIhuEmbuBMEugnG3kEXLp3Dj+JmAQiv9GUcQ
 MV70P8wXghHRQ1etuqCcaHAMRr8nukAdl/o1Zj1ggdV+gS2xY7ayj1JLRtEe9NXnSHn3
 gdWW6H4u68KYkcB4t5FxhNn9W/z4OVUfeZly2e2JRiSJl3UCJfqQd9SpRolemN3REnJ5
 kG1w==
X-Gm-Message-State: AC+VfDwgC0DhekXhhin425BZR5aB0In6/jF9TFOmSt3iNHIKzNmQ3RRj
 6rnG3xiK/ecn14PYtLq60FgVZn2RzDkKGF93JwnbrTAIydZ6cLmXMnxpT1mVChvvXSQ66ejhtXf
 Jb5W2WDA0QERohCTeHaTv0L8BJtlcwBk=
X-Received: by 2002:a67:bb12:0:b0:43b:3cab:23a8 with SMTP id
 m18-20020a67bb12000000b0043b3cab23a8mr7816720vsn.20.1687467910532; 
 Thu, 22 Jun 2023 14:05:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4zIqNDb1Gyix1XMXOs5Wr6FGlBR4yeGT3vn/prNwfTIm+pfvsn8kbPWVYfXQXKD6tb5QsRUJ4/0BFEumMzUUI=
X-Received: by 2002:a67:bb12:0:b0:43b:3cab:23a8 with SMTP id
 m18-20020a67bb12000000b0043b3cab23a8mr7816713vsn.20.1687467910274; Thu, 22
 Jun 2023 14:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230621002121.1609612-1-jsnow@redhat.com>
 <CABgObfahSN4eQ65nu9Dy_7bkWmxfERiJ-ZEM729futMFuGWwPw@mail.gmail.com>
 <CABgObfYKK+eU56iP2O+O7s=dcfWxmpXrB3EuNj=CkUw-XEjSnA@mail.gmail.com>
 <CAFn=p-a1Lz=FdrAYcB8Ua3AK=C5674Lyg5vRyxNjaybNXgvQ0w@mail.gmail.com>
In-Reply-To: <CAFn=p-a1Lz=FdrAYcB8Ua3AK=C5674Lyg5vRyxNjaybNXgvQ0w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Jun 2023 23:04:57 +0200
Message-ID: <CABgObfYo34ZOqAGdf9jEEQUtTztcwDUF+N9JGSsbBw8z1FOoWQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] Switch iotests to pyvenv
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Beraldo Leal <bleal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On Thu, Jun 22, 2023 at 11:03=E2=80=AFPM John Snow <jsnow@redhat.com> wrote=
:
> If we always install it in editable mode, and the path where it is
> "installed" is what we expect it to be, it shouldn't have any problems
> with being out of date.... I think. We could conceivably use the
> "faux" package version the internal package has to signal when the
> script needs to re-install it.

Stupid question, why not treat it just like avocado?


