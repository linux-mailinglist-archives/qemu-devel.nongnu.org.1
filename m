Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 915B3719C47
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:38:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hZ0-0001PY-OZ; Thu, 01 Jun 2023 08:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4hYy-0001PP-G9
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:37:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4hYk-0003Kx-66
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685623061;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmIt+C0dDH3sX5cdWo3F95ZZjmAb/HZpmXY+Hk4VNUg=;
 b=cE78foSSm85VFYb+K2vbOCkc/NY5a5yRgphBW/K953YTV02YmZMbPBIte7ILypAVvH8ubZ
 JDRWqRkF46rpZKK/ymiLiYHceB7QE1GAFh5MQUEkcCJPh8RVGH0avOdNQcj5d3egzPSLsx
 Tj3+P5o675VBarP/rqBYg7E9WyoNIDw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-pYGVKtSiM_-4ZddThsDVvg-1; Thu, 01 Jun 2023 08:37:39 -0400
X-MC-Unique: pYGVKtSiM_-4ZddThsDVvg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so5093455e9.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 05:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685623059; x=1688215059;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rmIt+C0dDH3sX5cdWo3F95ZZjmAb/HZpmXY+Hk4VNUg=;
 b=K6X40VY2MsAmA0UWQV/GhmccQJJkh86KIgVuPyokWJ6b9mADH+gtTKkawnnkZcU5L1
 +w8QVjeTZV87TQ4rLRRiOWFtahHY5kr5OZInYdMmuTA7He3Kfrk+TEVRmh+wEPByDZ3I
 OdSaZHDltpjD/crcIEcLg4mk9laMkMsro2n7o5oOoKTFq+YmJf9s4+PKlHVcJYbEE/Wf
 m00/vSTOiC3/Pk/R9aOdXee1Gq+WO1fEoLozDkovbh0hRHTwfCDq/Py+RRhNvVMsBwXY
 otZGHGd4qXUMPtLktUVantNTAfhCGGNo6O6OgthcWqfkg7OrvfqDn8vg8o7TlKe9RffH
 LtQA==
X-Gm-Message-State: AC+VfDxaO5anQXMHgKyYImDXUSorpd203L/Hkxx1b1U6Rixw6AueLJu1
 jOYR3cr+owVxI0t/UDou77ljzU02tSBy3GVvxGHk46xdaUs/OorTyyMlkHD4F+J1KzB/KLuBAqf
 X5zfpPtpcfS+sYkE=
X-Received: by 2002:a7b:cd98:0:b0:3f6:834:d33f with SMTP id
 y24-20020a7bcd98000000b003f60834d33fmr1924049wmj.24.1685623058858; 
 Thu, 01 Jun 2023 05:37:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6esMUoQ2G1okA3Ton/9O46AtIxlQ9USX/mMxWGAHE/yaXWnZQe03CbT981mWLciOKFguXN5g==
X-Received: by 2002:a7b:cd98:0:b0:3f6:834:d33f with SMTP id
 y24-20020a7bcd98000000b003f60834d33fmr1924028wmj.24.1685623058589; 
 Thu, 01 Jun 2023 05:37:38 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 m24-20020a7bca58000000b003f4dde07956sm2254899wml.42.2023.06.01.05.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 05:37:38 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <lvivier@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 7/9] tests/qtest: capture RESUME events during migration
In-Reply-To: <ZHiQWcv2xeVPte1d@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 1 Jun 2023 13:34:33 +0100")
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-8-berrange@redhat.com>
 <87edmvs6su.fsf@secure.mitica> <ZHiQWcv2xeVPte1d@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 01 Jun 2023 14:37:37 +0200
Message-ID: <875y87s6i6.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Thu, Jun 01, 2023 at 02:31:13PM +0200, Juan Quintela wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>> > When running migration tests we monitor for a STOP event so we can skip
>> > redundant waits. This will be needed for the RESUME event too shortly.
>> >
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > ---
>> >  tests/qtest/migration-helpers.c | 12 ++++++++++++
>> >  tests/qtest/migration-helpers.h |  2 ++
>> >  tests/qtest/migration-test.c    |  5 +++++
>> >  3 files changed, 19 insertions(+)
>> >
>> > diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-h=
elpers.c
>> > index 884d8a2e07..d50b565967 100644
>> > --- a/tests/qtest/migration-helpers.c
>> > +++ b/tests/qtest/migration-helpers.c
>> > @@ -35,6 +35,18 @@ bool migrate_watch_for_stop(QTestState *who, const =
char *name,
>> >      return false;
>> >  }
>> >=20=20
>> > +bool migrate_watch_for_resume(QTestState *who, const char *name,
>> > +                              QDict *event, void *opaque)
>> > +{
>> > +    bool *seen =3D opaque;
>> > +
>> > +    if (g_str_equal(name, "RESUME")) {
>> > +        *seen =3D true;
>> > +    }
>> > +
>> > +    return false;
>> > +}
>> > +
>>=20
>> I think I am not understanding this.
>>=20
>> Can we wait for both RESUME and STOP events?
>>=20
>> Or do you want an implementation that can only look for one event?
>
> For the purpose of the migration test we only need the STOP event
> on the src and the RESUME event on the dst. While I could have made
> it track both STOP and RESUME events on both src & dst, I figured
> it was overkill.

Fair enough.


