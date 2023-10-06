Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D98197BC0CA
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 22:54:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qorpK-0005UY-NT; Fri, 06 Oct 2023 16:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qorpI-0005UC-TW
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 16:53:36 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qorpF-0005I8-2s
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 16:53:35 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3214cdb4b27so2449818f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 13:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696625611; x=1697230411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuLACqjs8ut0bAk+buG0eQ4Qk0kx2QAaHMPo4L8iR4E=;
 b=XtG5/GVNWmpCkcWcMxotOMsdbWKmtW+0Erbp8dgcvC4Ex/p3hLwuhs6Ig3f9e6+jqf
 Qdz2KsPiZFOvNPzzBQCvpP7Wg2kJZD7gGR3HrmlCSF2WfrCF6ePC8HuHCZ+JpZ4/CP9Q
 ggpUe/Y6NiWuOrJ1ZajtqTqdYVmjxkQzTEoOJorJJLFici4+LYcHjR5SnwXnf9kHkgj6
 nzNdnNK5KxB+/Ch8zn802s8PmKgSjeOppAlytEeJyIAMgG1/H3sfMNWDWgmh0qT84arL
 enm6aU7Esv52grzYqjVikTt2FP6YtWkcTlq68Ibtd23rz8Mb1cKrQtUBML83qJJP9M4W
 2nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696625611; x=1697230411;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kuLACqjs8ut0bAk+buG0eQ4Qk0kx2QAaHMPo4L8iR4E=;
 b=i42Nuk/FIKkmsWUYElPausWcihHkTuvMHR1cQX3iFwcSs9KBVgdVaorOs2y8SNIhkW
 ZNuG6nnDWsLYJD9O/toK1LcUlBkCErivon/jIMQcArnyUupeJP0KGwBCzCHxXXtp3txw
 5CLLswmR+fzFg9BXkoYWtkJTxDM4kIK7V4kOA6JOCfo42uU7MTVf4Mu0MOMmBtmADeGX
 7lSmf3KnmJsVsejRUn25KNwmjCITAXqFPGuYmPk4dL9J2cHo/pFhjcwhxDceed5wOtjX
 ENSqxM+hoLzoz2a/P4HxHAW4s18Z1V6Dynpdo/0nPbAr2x0Xq913FLoQM7GwwaCzVNa5
 Miyw==
X-Gm-Message-State: AOJu0YzolwaXi3rV9kufn433tIB1kGdQhS2NM1+shZEXVaX09ZE01ckH
 Ckb0lTO0DU59le+UPl1WPDln3bnHhsCbWH+YBuY=
X-Google-Smtp-Source: AGHT+IF/d/UJ1gDgG2dN1JSXCu3VEypWRa1ItysOiNjOhIsyPxwuyNrpOu3eYZPdbYi+E4CGF5Ykbg==
X-Received: by 2002:a5d:4c50:0:b0:31f:dc60:13b5 with SMTP id
 n16-20020a5d4c50000000b0031fdc6013b5mr8374806wrt.25.1696625610950; 
 Fri, 06 Oct 2023 13:53:30 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v7-20020adfedc7000000b003197efd1e7bsm2375432wro.114.2023.10.06.13.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 13:53:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2D0371FFBB;
 Fri,  6 Oct 2023 21:53:30 +0100 (BST)
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-2-hreitz@redhat.com>
 <20231005170852.GB1342722@fedora>
 <20231005131352-mutt-send-email-mst@kernel.org>
 <00272da3-0a48-5544-6ba8-5dfde00be241@redhat.com>
 <20231006043518-mutt-send-email-mst@kernel.org>
 <a8b9d842-0925-38d0-2f0d-f2560bab251b@redhat.com>
 <20231006051802-mutt-send-email-mst@kernel.org>
 <a4af0357-12ee-fc7f-e249-239da34409b0@redhat.com>
 <20231006055229-mutt-send-email-mst@kernel.org>
 <d9c2d2c4-5ab3-a3f3-8925-155e1c4ff73a@redhat.com>
 <87il7jg4oe.fsf@linaro.org>
 <2ba3ef6b-4af1-9c65-f542-bfcc8412e99c@redhat.com>
User-agent: mu4e 1.11.21; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-fs@redhat.com, Eugenio
 =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>, Anton Kuchin
 <antonkuchin@yandex-team.ru>,
 Yajun Wu <yajunw@nvidia.com>, qemu-devel@nongnu.org
Subject: Re: [Virtio-fs] (no subject)
Date: Fri, 06 Oct 2023 21:49:30 +0100
In-reply-to: <2ba3ef6b-4af1-9c65-f542-bfcc8412e99c@redhat.com>
Message-ID: <875y3j4gmu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Hanna Czenczek <hreitz@redhat.com> writes:

> On 06.10.23 17:17, Alex Benn=C3=A9e wrote:
>> Hanna Czenczek <hreitz@redhat.com> writes:
>>
>>> On 06.10.23 12:34, Michael S. Tsirkin wrote:
>>>> On Fri, Oct 06, 2023 at 11:47:55AM +0200, Hanna Czenczek wrote:
>>>>> On 06.10.23 11:26, Michael S. Tsirkin wrote:
>>>>>> On Fri, Oct 06, 2023 at 11:15:55AM +0200, Hanna Czenczek wrote:
>>>>>>> On 06.10.23 10:45, Michael S. Tsirkin wrote:
>>>>>>>> On Fri, Oct 06, 2023 at 09:48:14AM +0200, Hanna Czenczek wrote:
>>>>>>>>> On 05.10.23 19:15, Michael S. Tsirkin wrote:
>>>>>>>>>> On Thu, Oct 05, 2023 at 01:08:52PM -0400, Stefan Hajnoczi wrote:
>>>>>>>>>>> On Wed, Oct 04, 2023 at 02:58:57PM +0200, Hanna Czenczek wrote:
>> <snip>
>>>>> What I=E2=80=99m saying is, 923b8921d21 introduced SET_STATUS calls t=
hat broke all
>>>>> devices that would implement them as per virtio spec, and even today =
it=E2=80=99s
>>>>> broken for stateful devices.=C2=A0 The mentioned performance issue is=
 likely
>>>>> real, but we can=E2=80=99t address it by making up SET_STATUS calls t=
hat are wrong.
>>>>>
>>>>> I concede that I didn=E2=80=99t think about DRIVER_OK.=C2=A0 Personal=
ly, I would do all
>>>>> final configuration that would happen upon a DRIVER_OK once the first=
 vring
>>>>> is started (i.e. receives a kick).=C2=A0 That has the added benefit o=
f being
>>>>> asynchronous because it doesn=E2=80=99t block any vhost-user messages=
 (which are
>>>>> synchronous, and thus block downtime).
>>>>>
>>>>> Hanna
>>>> For better or worse kick is per ring. It's out of spec to start rings
>>>> that were not kicked but I guess you could do configuration ...
>>>> Seems somewhat asymmetrical though.
>>> I meant to take the first ring being started as the signal to do the
>>> global configuration, i.e. not do this once per vring, but once
>>> globally.
>>>
>>>> Let's wait until next week, hopefully Yajun Wu will answer.
>>> I mean, personally I don=E2=80=99t really care about the whole SET_STAT=
US
>>> thing.=C2=A0 It=E2=80=99s clear that it=E2=80=99s broken for stateful d=
evices.=C2=A0 The fact
>>> that it took until 6f8be29ec17d to fix it for just any device that
>>> would implement it according to spec to me is a strong indication that
>>> nobody does implement it according to spec, and is currently only used
>>> to signal to some specific back-end that all rings have been set up
>>> and should be configured in a single block.
>> I'm certainly using [GS]ET_STATUS for the proposed F_TRANSPORT
>> extensions where everything is off-loaded to the vhost-user backend.
>
> How do these back-ends work with the fact that qemu uses SET_STATUS
> incorrectly when not offloading?=C2=A0 Do you plan on fixing that?

Mainly having a common base implementation which does it right and
having very lightweight derivations for legacy stubs using it. The
aim is to eliminate the need for QEMU stubs entirely by fully specifying
the device from the vhost-user API.=20

> (I.e. that we send SET_STATUS 0 when the VM is paused, potentially
> resetting state that is not recoverable, and that we set DRIVER and
> DRIVER_OK simultaneously.)

This is QEMU simulating a SET_STATUS rather than the guest triggering
it?

>
> Hanna


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

