Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D6379E86C
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 14:57:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPQ8-0002Or-M3; Wed, 13 Sep 2023 08:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen@brennan.io>)
 id 1qgK3W-00030W-NB
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:12:58 -0400
Received: from sender3-of-o59.zoho.com ([136.143.184.59])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen@brennan.io>)
 id 1qgK3S-0000V0-US
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:12:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1694589160; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ML4k+KNr34PeOi6vSbSME9LqkLMsGJSkN0nVEavPxh9ipTANwk6pizuTjjvjuR5PoA99cLudTcJUMyA+shOOZxEhA2bAiI1i2zKpSwf6qRueRIfapnqinqefHP5taN2N9CNnXUB+RMmNT4Kh9elt8gRSAplY3RBjMzhPU0/hNeM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1694589160;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=R9jx7h7Wlp8SjmQ2bQ0XZYmEG41I9nmnbkm7VbqtqVQ=; 
 b=GXLzdtURIdYc7cCGNCOIm6WSSkn/R/Qx/gwPJ1dZ//htwQj7lsB7n+fj6t0yFBVrKJqDXkZjpBuM1sbp97mJJph3K3KYvLJdM1iHA6WQOW1EqlL6TfnnfPbbzmks+Uu1HmnSsSpSU8jODZGq5810nFbjdNhYMrtxgmG6kcqVtc0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=brennan.io;
 spf=pass  smtp.mailfrom=stephen@brennan.io;
 dmarc=pass header.from=<stephen@brennan.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1694589160; 
 s=selector01; d=brennan.io; i=stephen@brennan.io;
 h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=R9jx7h7Wlp8SjmQ2bQ0XZYmEG41I9nmnbkm7VbqtqVQ=;
 b=fqn72z6wEtgYpSHxqPdvQAvPrivWcTKScxVo4b7CQq64Jgpn/9Ke3au2lm9Eb1IZ
 ygYqFCvBISPtqenOKLoe2ZqRgkLAQnAQDQcFW0UfutYXRRSlLgmtqUhDxnaU7RLgeDU
 K5IvNSaVsa2LvtrM+xcCNavbQDy1Hq3ZioinIRgM=
Received: from localhost (136.24.52.195 [136.24.52.195]) by mx.zohomail.com
 with SMTPS id 1694589158185197.96495829829678;
 Wed, 13 Sep 2023 00:12:38 -0700 (PDT)
From: Stephen Brennan <stephen@brennan.io>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 linux-debuggers@vger.kernel.org, joao.m.martins@oracle.com, Richard
 Henderson <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH qemu 2/2] dump: Only use the makedumpfile flattened
 format when necessary
In-Reply-To: <ZQAgsmXRYFqRx7dI@redhat.com>
References: <20230717163855.7383-1-stephen.s.brennan@oracle.com>
 <20230717163855.7383-3-stephen.s.brennan@oracle.com>
 <CAJ+F1C+VFpU=xpqOPjJU1VLt4kofVqV8EN4pj5MjkkwWvVuxZw@mail.gmail.com>
 <87edl4d9wi.fsf@oracle.com> <87fs4aha4t.fsf@oracle.com>
 <CAJ+F1CKCdy3J8AD9EGvVO+CU6-yFPrLZ2Lum1SDgdj_kghFdQw@mail.gmail.com>
 <CAJ+F1CK0PTM-wHaK90EiuvvsG5OBVXQ4X8iV-AbBxdc6_=RvPQ@mail.gmail.com>
 <ZQAgsmXRYFqRx7dI@redhat.com>
Date: Wed, 13 Sep 2023 00:12:37 -0700
Message-ID: <875y4e8s2i.fsf@brennan.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.184.59; envelope-from=stephen@brennan.io;
 helo=sender3-of-o59.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 13 Sep 2023 08:56:20 -0400
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> On Tue, Sep 12, 2023 at 10:34:04AM +0400, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>=20
>> On Wed, Aug 23, 2023 at 2:03=E2=80=AFPM Marc-Andr=C3=A9 Lureau
>> <marcandre.lureau@gmail.com> wrote:
>> >
>> > Hi
>> >
>> > On Wed, Aug 23, 2023 at 4:31=E2=80=AFAM Stephen Brennan
>> > <stephen.s.brennan@oracle.com> wrote:
>> > >
>> > > Stephen Brennan <stephen.s.brennan@oracle.com> writes:
>> > > > Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>> > > >> I am a bit reluctant to change the dump format by default. But si=
nce the
>> > > >> flatten format is more "complicated" than the "normal" format, pe=
rhaps we
>> > > >> can assume all users will handle it.
>> > > >>
>> > > >> The change is probably late for 8.1 though..
>> > > >
>> > > > Thank you for your review and testing!
>> > > >
>> > > > I totally understand the concern about making the change by defaul=
t. I
>> > > > do believe that nobody should notice too much because the normal f=
ormat
>> > > > should be easier to work with, and more broadly compatible. I don'=
t know
>> > > > of any tool which deals with the flattened format that can't handl=
e the
>> > > > normal format, except for "makedumpfile -R" itself.
>> > > >
>> > > > If it's a blocker, I can go ahead and add a new flag to the comman=
d to
>> > > > enable the behavior. However there are a few good justifications n=
ot to
>> > > > add a new flag. I think it's going to be difficult to explain the
>> > > > difference between the two formats in documentation, as the
>> > > > implementation of the formats is a bit "into the weeds". The libvi=
rt API
>> > > > also specifies each format separately (kdump-zlib, kdump-lzo,
>> > > > kdump-snappy) and so adding several new options there would be
>> > > > unfortunate for end-users as well.
>> > > >
>> > > > At the end of the day, it's your judgment call, and I'll implement=
 it
>> > > > how you prefer.
>> > >
>> > > I just wanted to check back on this to clarify the next step. Are you
>> > > satisfied with this and waiting to apply it until the right time? Or
>> > > would you prefer me to send a new version making this opt-in?
>> > >
>> >
>> > Nobody seems to raise concerns. If it would be just me, I would change
>> > it. But we should rather be safe, so let's make it this opt-in please.
>>=20
>> Alex, Daniel, Thomas .. Do you have an opinion on changing the dump form=
at?
>
> I think it is a bad idea for the command to output data in a different
> format, silently switching based on whether it is passed a pipe or and
> file FD.

You say that, but this exactly describes the default behavior of
makedumpfile. That may not make it *good* design, but it's at least a
point in favor of consistency =3D)

> Libvirt may pass either a plain file FD or a pipe FD, depending on
> whether the user set the VIR_DUMP_BYPASS_CACHE API flag. IMHO it
> is unacceptable for that to result in a change of data format as a
> silent side effect.
>
> Looking back at the history, the patches originally did NOT use the
> flatten makedumpfile format, but to ensure it was able to work with
> non-seekable files, it jumped through hoops to write to a temporary
> file first process it and then write to the real file. Switching to
> makedumpfile format was to enable it to avoid temp files and always
> be compatible with non-seekable FDs.

Thanks for taking a look at the history, this is something I should have
done. The patches need some historical footing for context. My next
series will include better investigation on the history.

That said, the flattened format is quite a compromise for users, given
that it is far less compatible, and users are given absolutely no
warning that the advertised "kdump" format is actually a format in need
of repair by way of "makedumpfile -R". As it is, we are sacrificing the
common case (writing a broadly compatible, non-flattened core dump) on
the altar of what seems like a special case (using pipes to avoid the
page cache).

I don't have the experience with the Qemu project to say what is the
best for the project, so I leave it in your capable hands. And
ultimately, relitigating the past is irrelevant. There are existing
users who will be broken if we silently change the format based on
seekability, so I can see why it is a non-starter. It's just frustrating
that now, users will need to opt-in to enable the broadly compatible
option which should have been the default in the first place.

Rgeardless, it sounds like the way forward will be to use a flag to opt
into the "non-flattened" format behavior. I'll try to get that out
tomorrow!

Thanks,
Stephen

> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

