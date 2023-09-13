Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB2479E86B
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 14:57:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPQ8-0002Nq-Li; Wed, 13 Sep 2023 08:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen@brennan.io>)
 id 1qgJWd-0006cz-0U
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 02:38:59 -0400
Received: from sender3-of-o57.zoho.com ([136.143.184.57])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen@brennan.io>)
 id 1qgJWX-0003kl-HN
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 02:38:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1694587121; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DZzWWErpsiCQU8WLD5pvqu/JgfR9qZAja4dzed8+NeIls5RwzR6ayfJ9ufOmQs1MKIoQMETfb4+VU9zeXkkxMrTk+k9dlVfqmid3vb3Ugtnq9NF7g7clN1Vst+NZQcHpSnGq5EwxsucqTC2IOolPnTUiaK4tVDK2kSFBM4sCUcE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1694587121;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=dypCVOF/KKl70MOToLdCJ/V8ZHQzOGX4MdOyUG6jOUI=; 
 b=by9nW3dcxwSZfs0Pe+f8AAKaig9yJQtmP9kUFeMEouXALjpLxAF3VRnmrF78nGxLmZZ4mIfhLJBJxKK2dLPKfpTv4UcSRWNwYXiUpQVj2osjeka66iQ9IoJ0CmkmO/mC4Cr5jC6Vgbcol5gSHVpaNJykkL+Mdfx00hLTegVvdoQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=brennan.io;
 spf=pass  smtp.mailfrom=stephen@brennan.io;
 dmarc=pass header.from=<stephen@brennan.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1694587121; 
 s=selector01; d=brennan.io; i=stephen@brennan.io;
 h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=dypCVOF/KKl70MOToLdCJ/V8ZHQzOGX4MdOyUG6jOUI=;
 b=NfHssmDVmW191vVcrVzp8r38oXTZUl0wOh8EkrK4h85cd+5+zXCYZJUmOphEKBDR
 r7zZkznFNokDRUBe4AA1GIB7wYSMPWlOpcDByehSBf4nzZ1NPOhELWAGIiCC69KCAwd
 ZfNHRkwTKMm163m7/Cfh9JhNJ88qQMqVPt1DotIE=
Received: from localhost (136.24.52.195 [136.24.52.195]) by mx.zohomail.com
 with SMTPS id 1694587118513156.9937277734624;
 Tue, 12 Sep 2023 23:38:38 -0700 (PDT)
From: Stephen Brennan <stephen@brennan.io>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org,
 joao.m.martins@oracle.com, Richard Henderson
 <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH qemu 2/2] dump: Only use the makedumpfile flattened
 format when necessary
In-Reply-To: <CAJ+F1CK0PTM-wHaK90EiuvvsG5OBVXQ4X8iV-AbBxdc6_=RvPQ@mail.gmail.com>
References: <20230717163855.7383-1-stephen.s.brennan@oracle.com>
 <20230717163855.7383-3-stephen.s.brennan@oracle.com>
 <CAJ+F1C+VFpU=xpqOPjJU1VLt4kofVqV8EN4pj5MjkkwWvVuxZw@mail.gmail.com>
 <87edl4d9wi.fsf@oracle.com> <87fs4aha4t.fsf@oracle.com>
 <CAJ+F1CKCdy3J8AD9EGvVO+CU6-yFPrLZ2Lum1SDgdj_kghFdQw@mail.gmail.com>
 <CAJ+F1CK0PTM-wHaK90EiuvvsG5OBVXQ4X8iV-AbBxdc6_=RvPQ@mail.gmail.com>
Date: Tue, 12 Sep 2023 23:38:38 -0700
Message-ID: <87a5tq8tn5.fsf@brennan.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.184.57; envelope-from=stephen@brennan.io;
 helo=sender3-of-o57.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Wed, Aug 23, 2023 at 2:03=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
>>
>> Hi
>>
>> On Wed, Aug 23, 2023 at 4:31=E2=80=AFAM Stephen Brennan
>> <stephen.s.brennan@oracle.com> wrote:
>> >
>> > Stephen Brennan <stephen.s.brennan@oracle.com> writes:
>> > > Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>> > >> I am a bit reluctant to change the dump format by default. But sinc=
e the
>> > >> flatten format is more "complicated" than the "normal" format, perh=
aps we
>> > >> can assume all users will handle it.
>> > >>
>> > >> The change is probably late for 8.1 though..
>> > >
>> > > Thank you for your review and testing!
>> > >
>> > > I totally understand the concern about making the change by default.=
 I
>> > > do believe that nobody should notice too much because the normal for=
mat
>> > > should be easier to work with, and more broadly compatible. I don't =
know
>> > > of any tool which deals with the flattened format that can't handle =
the
>> > > normal format, except for "makedumpfile -R" itself.
>> > >
>> > > If it's a blocker, I can go ahead and add a new flag to the command =
to
>> > > enable the behavior. However there are a few good justifications not=
 to
>> > > add a new flag. I think it's going to be difficult to explain the
>> > > difference between the two formats in documentation, as the
>> > > implementation of the formats is a bit "into the weeds". The libvirt=
 API
>> > > also specifies each format separately (kdump-zlib, kdump-lzo,
>> > > kdump-snappy) and so adding several new options there would be
>> > > unfortunate for end-users as well.
>> > >
>> > > At the end of the day, it's your judgment call, and I'll implement it
>> > > how you prefer.
>> >
>> > I just wanted to check back on this to clarify the next step. Are you
>> > satisfied with this and waiting to apply it until the right time? Or
>> > would you prefer me to send a new version making this opt-in?
>> >
>>
>> Nobody seems to raise concerns. If it would be just me, I would change
>> it. But we should rather be safe, so let's make it this opt-in please.
>>
>>
>
> Alex, Daniel, Thomas .. Do you have an opinion on changing the dump forma=
t?
>
> Stephen, do you have a new version of the patches to make it opt-in?

Thanks for the reminder, I did have a start on the patches, but they're
not quite ready to share just yet. I'm learning about the QMP command
JSON schemas, which I'll need to update. I ended up receiving a new work
laptop which disrupted my work. I'll try to get a new patch series out
during my Wednesday (US Pacific time) workday.

Thanks,
Stephen

