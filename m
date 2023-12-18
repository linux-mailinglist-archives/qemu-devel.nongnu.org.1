Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8C881650A
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 03:49:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF3ge-0002ow-RB; Sun, 17 Dec 2023 21:48:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rF3gb-0002on-Nb
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 21:48:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rF3ga-0001Zc-8G
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 21:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702867729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/6rFOTlKHHkejqhF+6ydzRGGtHUyGgQmeeWgPf8Q014=;
 b=iuC7i1vyQV022ZMnN0oUI0P0W7/VTWyR+uWajO/w2bwYoTXfqEWyQ6pHjsfTCzRIx4FAbY
 Gj7Gl4GTqfVKsW18OiB8nX03xb4Z+LD/RDawYE2QReSeC1y3/ni/saJ/AsAbkStueB1duI
 Q+dsJGxmsKiK/Tte4Ee0QUAT3AeKpY4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-aJoP9NzmPBGzx0Y-hXcmtA-1; Sun, 17 Dec 2023 21:48:47 -0500
X-MC-Unique: aJoP9NzmPBGzx0Y-hXcmtA-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6d7e5d286a1so247312b3a.1
 for <qemu-devel@nongnu.org>; Sun, 17 Dec 2023 18:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702867726; x=1703472526;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/6rFOTlKHHkejqhF+6ydzRGGtHUyGgQmeeWgPf8Q014=;
 b=OU96kXPjvLRzNIm8LR9urLDtBEh6oFVifuqmtVADoxMaH6ZLuMJTXEO5b2mWj2GNL4
 sqxA8M86Zmuy3bHT+XgV2KFQA29qeEFTR6Cv9s2By6uAL2db1hmrZi/oEm1l5Ll35saM
 LfngMDqxb6UVpJhAO88u3XFZ4VWKKO5UTO+5TNGyo1DjPvqFJm+oZiLLuotMXLBiD+yr
 iDRRtD0jucPKVFkakTLA8VHCKw70YYPf7NHpyGFMyYpaCr1so1V8zGjB3U2FuLu5DsX8
 6ISP5gOUlEjwdlk2XqFDqu6xlB0zJAEU/Q3KR1pNmWS72cXL+1/k2Bp2yPM8HvHHamrJ
 8aSw==
X-Gm-Message-State: AOJu0YyMVzXUfdu8WJA1ZTG5lgL4+zrMa4AzN1YU+VJG5uWtacnL9MYG
 YTLx/Z6HX1ciNPFiBxQr/s3lGjax31IBXaJPI2Sb0c4vDTCYI04fGSJpywwAlkQrh/6yXDAmajG
 EoF/fXpxkb++bklKXmfoqi3DwWaxhhD8=
X-Received: by 2002:aa7:8ecd:0:b0:6d4:fa2:9e7e with SMTP id
 b13-20020aa78ecd000000b006d40fa29e7emr2546339pfr.6.1702867726089; 
 Sun, 17 Dec 2023 18:48:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmuCwovWZklaSxgVQkRAl6k8DL5IqsBgkwnIrFQMTj2DCgz8h2elW0V0Xts/gw5l0lvso3LCm5eNKWWzhzuOA=
X-Received: by 2002:aa7:8ecd:0:b0:6d4:fa2:9e7e with SMTP id
 b13-20020aa78ecd000000b006d40fa29e7emr2546327pfr.6.1702867725776; Sun, 17 Dec
 2023 18:48:45 -0800 (PST)
MIME-Version: 1.0
References: <20230831065140.496485-1-andrew@daynix.com>
 <20230831065140.496485-6-andrew@daynix.com>
 <CABcq3pHyiO4AWSzxwWKfUnULfqPGQs1g12MCn14Ms4FqupZAzg@mail.gmail.com>
 <CACGkMEvBEdV1+uxE00hbXuFWmT2+nqgT9JxBezLXBwEX0b9Vbw@mail.gmail.com>
 <CAOEp5OcMo+eZ=k4m7ZKvSLWfngzzaZ6eHMLaiTmZ3CQ_yE2aKw@mail.gmail.com>
 <CACGkMEtFKJovdfi6690uoqH_qJ3mP6K8KDFcOamvC1yOow-Drg@mail.gmail.com>
 <CAOEp5OfrsExfBF4QvxtP7KCVS9tGQMNxZq5kh4j9bwxqYQmjBw@mail.gmail.com>
 <CAOEp5OchOVu7YSeHG2Au_S4HHf0U0H8Jdit-U+X_VcAP0z=7GA@mail.gmail.com>
In-Reply-To: <CAOEp5OchOVu7YSeHG2Au_S4HHf0U0H8Jdit-U+X_VcAP0z=7GA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Dec 2023 10:48:34 +0800
Message-ID: <CACGkMEsuOhO0ENTYh_qx=gHDLDqLXSj7HWGwv3gw=3beK=fUjA@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] ebpf: Updated eBPF program and skeleton.
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Andrew Melnichenko <andrew@daynix.com>, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, 
 qemu-devel@nongnu.org, berrange@redhat.com, yan@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.086,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Dec 14, 2023 at 6:18=E2=80=AFPM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> Hi Jason,
> As we anyway missed the timeframe of 8.2 please remove this v7 series fro=
m the pull, we will send v8 in which we want to take in account most of Aki=
hiko comments (especially DEFINE_PROP_ARRAY and naming of the properties).

Fine, I've dropped it.

Thanks

>
> Thank you very much
>
> Yuri
>
> On Wed, Dec 13, 2023 at 9:23=E2=80=AFAM Yuri Benditovich <yuri.benditovic=
h@daynix.com> wrote:
>>
>>
>> On Tue, Dec 12, 2023 at 5:33=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
>>>
>>> On Mon, Dec 11, 2023 at 7:51=E2=80=AFPM Yuri Benditovich
>>> <yuri.benditovich@daynix.com> wrote:
>>> >
>>> > Hello Jason,
>>> > Can you please let us know what happens with this series?
>>>
>>> It should be my bad, it is in V1 of the pull request but missed
>>> accidentally in V2 of the pull.
>>>
>>> I've merged it here,
>>>
>>> https://gitlab.com/jasowang/qemu.git
>>
>>
>> Yes, the merged tree is OK. I see you changed the target version to 8.3
>>  It looks like no more changes required for the PULL,
>>  Please let us know if something is needed.
>>
>> Thanks,
>> Yuri
>>
>>
>>>
>>>
>>> Please check if it's correct.
>>>
>>> Thanks
>>>
>>> >
>>> > Thanks
>>> > Yuri
>>> >
>>> > On Fri, Sep 8, 2023 at 9:43=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
>>> >>
>>> >> On Mon, Sep 4, 2023 at 7:23=E2=80=AFPM Andrew Melnichenko <andrew@da=
ynix.com> wrote:
>>> >> >
>>> >> > Hi Jason,
>>> >> > According to our previous conversation, I've added checks to the m=
eson script.
>>> >> > Please confirm that everything is correct
>>> >>
>>> >> I've queued this series.
>>> >>
>>> >> Thanks
>>> >>
>>>


