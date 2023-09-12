Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4BF79C81C
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 09:22:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxih-0007LO-Pb; Tue, 12 Sep 2023 03:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qfxig-0007LG-F7
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:21:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qfxie-0001TI-4z
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694503314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7BvHu4veckrfz6KuzpbP7HjPDSNgySXMvrxCBE5h/HI=;
 b=T455IqLFuJiVjWJM4KrxfIKl8kUk28KBkZkRFMRArjY94bLEjW5HGqNYob7vgL4QuM8/Xm
 oKzXpcBvdLvtbtKzIZI01CEPnwxyJjVIChSnUMkAG8aX3FyGPNyGqP1TJSXH1wEe4WYhVV
 YSObWFmwYFW+SDTQY4EdTiMrogB6BpY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-vkAsVNFTNyiDD7Z83W_EUw-1; Tue, 12 Sep 2023 03:21:52 -0400
X-MC-Unique: vkAsVNFTNyiDD7Z83W_EUw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso3502871f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 00:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694503311; x=1695108111;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7BvHu4veckrfz6KuzpbP7HjPDSNgySXMvrxCBE5h/HI=;
 b=CHiSBeQyKaUFRcLDQs80uy5WOeKNQe5wq8TR0DDgbXvy/6iMhQXnfjfnQ1r6zOJJkI
 t7HBF1JWeL2zBxxf3Z/K12ZDFLe5CWWqJOdhR0btJoxPNFZj1Ni1pmLsbt/3JhX2eQ7n
 4P2ieX0INAPrkjq46R6NFbUVYA8Ji34O/Fll9MdmAw6k77ooP+lbgPMTJSpb3qbGN1SS
 NRP5/8CPLUd5phkBNo0S5kqspAJzh9i8KvukjBmpCoOE54jgevqadb4xXExCXNufN31L
 eqSNBnWS80X9QXC9lOaerz0wDjcBDNIXZopgICuaUNERSsRxKvA4Ocf37tjTITMO2f77
 GoAg==
X-Gm-Message-State: AOJu0Yzt1brUuWPQhrB8N17C+n2dCNZhenXNLK5C3d6bup3sKhx4cDP1
 CmCwPKrZn6//gppVzrUwU+eUBfF/836Zt30uWMKCXW0jRDuZN94vEudPZNTy6NHYU2lnkoNm89O
 UHs4ZMzfIB1iL3Js=
X-Received: by 2002:a5d:560d:0:b0:313:f1c8:a968 with SMTP id
 l13-20020a5d560d000000b00313f1c8a968mr9698786wrv.2.1694503310925; 
 Tue, 12 Sep 2023 00:21:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExPMGW5JeNv0plxANul4UmSCGkcVkAYBI6a0kzV65U4Gnwp0uyItKr5o8r5UsXS9UU/zZwIA==
X-Received: by 2002:a5d:560d:0:b0:313:f1c8:a968 with SMTP id
 l13-20020a5d560d000000b00313f1c8a968mr9698773wrv.2.1694503310569; 
 Tue, 12 Sep 2023 00:21:50 -0700 (PDT)
Received: from [192.168.0.2] (ip-109-43-179-28.web.vodafone.de.
 [109.43.179.28]) by smtp.gmail.com with ESMTPSA id
 x5-20020a5d54c5000000b0031773a8e5c4sm11985034wrv.37.2023.09.12.00.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 00:21:50 -0700 (PDT)
Message-ID: <b614f33c9fcc461f8099a11b97af4340ceb4cf1a.camel@redhat.com>
Subject: Re: [PATCH qemu 2/2] dump: Only use the makedumpfile flattened
 format when necessary
From: Thomas Huth <thuth@redhat.com>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, 
 Stephen Brennan <stephen.s.brennan@oracle.com>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,  "Daniel P. Berrange"
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org, 
 joao.m.martins@oracle.com, Richard Henderson
 <richard.henderson@linaro.org>,  Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 12 Sep 2023 09:21:49 +0200
In-Reply-To: <CAJ+F1CK0PTM-wHaK90EiuvvsG5OBVXQ4X8iV-AbBxdc6_=RvPQ@mail.gmail.com>
References: <20230717163855.7383-1-stephen.s.brennan@oracle.com>
 <20230717163855.7383-3-stephen.s.brennan@oracle.com>
 <CAJ+F1C+VFpU=xpqOPjJU1VLt4kofVqV8EN4pj5MjkkwWvVuxZw@mail.gmail.com>
 <87edl4d9wi.fsf@oracle.com> <87fs4aha4t.fsf@oracle.com>
 <CAJ+F1CKCdy3J8AD9EGvVO+CU6-yFPrLZ2Lum1SDgdj_kghFdQw@mail.gmail.com>
 <CAJ+F1CK0PTM-wHaK90EiuvvsG5OBVXQ4X8iV-AbBxdc6_=RvPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 2023-09-12 at 10:34 +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Aug 23, 2023 at 2:03=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
> >=20
> > Hi
> >=20
> > On Wed, Aug 23, 2023 at 4:31=E2=80=AFAM Stephen Brennan
> > <stephen.s.brennan@oracle.com> wrote:
> > >=20
> > > Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> > > > Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
> > > > > I am a bit reluctant to change the dump format by default.
> > > > > But since the
> > > > > flatten format is more "complicated" than the "normal"
> > > > > format, perhaps we
> > > > > can assume all users will handle it.
> > > > >=20
> > > > > The change is probably late for 8.1 though..
> > > >=20
> > > > Thank you for your review and testing!
> > > >=20
> > > > I totally understand the concern about making the change by
> > > > default. I
> > > > do believe that nobody should notice too much because the
> > > > normal format
> > > > should be easier to work with, and more broadly compatible. I
> > > > don't know
> > > > of any tool which deals with the flattened format that can't
> > > > handle the
> > > > normal format, except for "makedumpfile -R" itself.
> > > >=20
> > > > If it's a blocker, I can go ahead and add a new flag to the
> > > > command to
> > > > enable the behavior. However there are a few good
> > > > justifications not to
> > > > add a new flag. I think it's going to be difficult to explain
> > > > the
> > > > difference between the two formats in documentation, as the
> > > > implementation of the formats is a bit "into the weeds". The
> > > > libvirt API
> > > > also specifies each format separately (kdump-zlib, kdump-lzo,
> > > > kdump-snappy) and so adding several new options there would be
> > > > unfortunate for end-users as well.
> > > >=20
> > > > At the end of the day, it's your judgment call, and I'll
> > > > implement it
> > > > how you prefer.
> > >=20
> > > I just wanted to check back on this to clarify the next step. Are
> > > you
> > > satisfied with this and waiting to apply it until the right time?
> > > Or
> > > would you prefer me to send a new version making this opt-in?
> > >=20
> >=20
> > Nobody seems to raise concerns. If it would be just me, I would
> > change
> > it. But we should rather be safe, so let's make it this opt-in
> > please.
> >=20
> >=20
>=20
> Alex, Daniel, Thomas .. Do you have an opinion on changing the dump
> format?

I just double-checked with Janosch Frank, and from s390x perspective
we're mostly interested in the ELF dump format, so from the s390x side
of view: =C2=AF\_(=E3=83=84)_/=C2=AF

 Thomas


