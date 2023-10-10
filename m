Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D82B07BF8F1
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 12:46:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqAET-0001ul-SO; Tue, 10 Oct 2023 06:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqAES-0001uP-Bp
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 06:44:56 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqAEQ-0006gn-Kw
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 06:44:56 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40666aa674fso51923865e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 03:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696934692; x=1697539492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0LS++g/ohxxCYPIIdcs8Jo1hYEcLEdbQjh4C7ZkjUuU=;
 b=LJSW9V4sxlpszcjfvISY8Wd8g0RyvytOedmu9rjoAzANyO44AXVKf+ijVh03Iu3lSJ
 7/EVWDi20sLINk5UMrDjhlsOXvllPSZ2tFfxqKO/CZIOJUJGSQ3mx+HFBJFj7ohD01qi
 aWlDn03ZAac2iMPjFRuzL52xZQctfUGXLvRuoGQhXx8eR7lMDbxVkRrP9PXnVBe9X3d4
 evBydbgTL9amygdHVXhR4Lb4LO+JR9/Y04Pc/TcyL3j/9bSCHc2ZEVzKSst9Cmf/xp1U
 NOsAYZQf80DET/LY9Evo78cWjc3zneJMDpXcO5nehBUsAlAcNo7h5Mg49Cv2stPigSJw
 CRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696934692; x=1697539492;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0LS++g/ohxxCYPIIdcs8Jo1hYEcLEdbQjh4C7ZkjUuU=;
 b=hndr2xuCFXRfvdkO2EsSwlN2mE6xobJS/G6idck3Y4aKAfEl5v7+AAQTlXXUJjrWSz
 2WfVidfrzL/KK0QA68sIXAXetYsolG7mg/NByzSFlSMwpkY9EnRCWp96p6JOLPLFwjga
 QRWC9wuMqpM7NTFFtmCTFeJMQ/FvtHxnA5kmb/r7pVVKzJhwkqRB58Z4V+btMhlT1NC1
 mDYQs/GkNmkDyNfhKMZtnlvUa0WVBkxh9l5UJxpKXxGz+oSZsUBH0hd7KIKqdRG4kS0L
 KkZUIG1AgnTudqQ2SF4XBpRLZaSzNd1uQBnsb9H96o3mQ1Tk2b8rv+U3LxLA9GmYo+i/
 OKWw==
X-Gm-Message-State: AOJu0YwkU1c6vHsFsUXMdyP+OAfiCtEzh2Zj3/IDjVUt+xQL80wSEId5
 f6tygfImgkMriCT9g+kMi6ObA2bKd1dSoYMR18U=
X-Google-Smtp-Source: AGHT+IHczfBpYos5umCuV0ZctxA1U1z6Ji35y0rohn/E2y8ntnjhTGQFRXL+PH8zSxcLLKU1qk94vw==
X-Received: by 2002:a7b:c393:0:b0:401:bd2e:49fc with SMTP id
 s19-20020a7bc393000000b00401bd2e49fcmr16507750wmj.24.1696934692386; 
 Tue, 10 Oct 2023 03:44:52 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n22-20020a7bcbd6000000b004060f0a0fdbsm16115908wmi.41.2023.10.10.03.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 03:44:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8985D1FFBB;
 Tue, 10 Oct 2023 11:44:51 +0100 (BST)
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
 <e35f9f71-8d9d-6250-cbaa-70412b5a1149@nvidia.com>
 <3f28b1a4-d618-39df-57e6-6152f61cac6e@redhat.com>
 <8f3694c1-48d4-f34b-8f91-3bc217182ffa@redhat.com>
 <e19eb113-89b1-92ed-3375-8bc93c1ff39c@redhat.com>
 <8f51f02b-4676-c566-7304-f63e76df74ba@nvidia.com>
 <9a36a319-4567-f297-f14a-2025792ae93f@redhat.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Yajun Wu <yajunw@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-fs@redhat.com"
 <virtio-fs@redhat.com>, Eugenio =?utf-8?Q?P=C3=A9rez?=
 <eperezma@redhat.com>, Anton Kuchin
 <antonkuchin@yandex-team.ru>, Parav Pandit <parav@nvidia.com>,
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>
Subject: Re: [Virtio-fs] (no subject)
Date: Tue, 10 Oct 2023 11:36:31 +0100
In-reply-to: <9a36a319-4567-f297-f14a-2025792ae93f@redhat.com>
Message-ID: <87lecapxi4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

> On 10.10.23 06:00, Yajun Wu wrote:
>>
>> On 10/9/2023 5:13 PM, Hanna Czenczek wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 09.10.23 11:07, Hanna Czenczek wrote:
>>>> On 09.10.23 10:21, Hanna Czenczek wrote:
>>>>> On 07.10.23 04:22, Yajun Wu wrote:
>>>> [...]
>>>>
<snip>
> So as far as I understand, the feature is supposed to rely on
> implementation-specific behavior between specifically qemu as a
> front-end and dpdk as a back-end, nothing else.=C2=A0 Honestly, that to me
> is a very good reason to deprecate it.=C2=A0 That would make it clear that
> any implementation that implements it does so because it relies on
> implementation-specific behavior from other implementations.
>
> Option 2 is to fix it.=C2=A0 It is not right to use this broadly defined
> feature with its clear protocol as given in the virtio specification
> just to set and clear a single bit (DRIVER_OK).=C2=A0 The vhost-user
> specification points to that virtio protocol.=C2=A0 We must adhere to the
> protocol.=C2=A0 And note that we must not reset devices just because the =
VM
> is paused/resumed.=C2=A0 (That is why I wanted to deprecate SET_STATUS, so
> that Stefan=E2=80=99s series would introduce RESET_DEVICE where we need i=
t,
> and we can (for now) ignore the SET_STATUS 0 in vhost_dev_stop().)
>
> Option 3 would be to just be honest in the specification, and limit
> the scope of F_STATUS to say the only bit that matters is DRIVER_OK.=C2=A0
> I would say this is not really different from deprecating, though it
> wouldn=E2=80=99t affect your case.=C2=A0 However, I understand Alex relie=
s on a
> full status byte.=C2=A0 I=E2=80=99m still interested to know why that is.

For an F_TRANSPORT backend (or whatever the final name ends up being) we
need the backend to have full control of the status byte because all the
handling of VirtIO is deferred to it. Therefor it has to handle all the
feature negotiation and indicate when the device needs resetting.

(side note: feature negotiation is another slippery area when QEMU gets
involved in gating which feature bits may or may not be exposed to the
backend. The only one it should ever mask is F_UNUSED which is used
(sic) to trigger the vhost protocol negotiation)

> Option 4 is of course not to do anything, and leave everything as-is,
> waiting for the next person to stir the hornet=E2=80=99s nest.
>
>>>> Cc-ing Alex on this mail, because to me, this seems like an important
>>>> detail when he plans on using the byte in the future. If we need a
>>>> virtio status byte, I can=E2=80=99t see how we could use the existing =
F_STATUS
>>>> for it.

What would we use instead of F_STATUS to query the Device Status field?

>>>>
>>>> Hanna
>>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

