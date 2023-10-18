Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC737CE255
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:09:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt970-0003QE-37; Wed, 18 Oct 2023 12:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qt96w-00034e-Kz
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:09:30 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qt96u-0001Zj-PN
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:09:30 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c54c8934abso5669881fa.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697645366; x=1698250166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VRl5e8mjRDJIeb/o79NTWlLleGw1AVu8K59VxhRz54k=;
 b=CA+k1pxzqEPWrdDQaPrPagXDaon+p6HfppehHrmgT8kjEWuvWWX6gGs3qNk3d8IW10
 Lf0y0ViKftIrcc2f4bL3hlXOowJHGYvMUDuo5iGuqul8BwWQCnOqUmbAqRFecMbpSigw
 3vl8BXo5noqyXi3SMO/4q3uiLrEUzG51EsAh1QudWOQ5YkT038LDbntUnLYj1mmp0d7T
 LHZ03x6noXF+ag8ZmGmBPCmRzkIGW912IFKmPyFg/2eeFFDujPXZaVuYRZKr92RQ9kOl
 WqcQdow9TGS8Np2ch5aNiY/+gQDgfsiNWMoZYcoTwZp7jOKPPXXjt4HcoOo5mFf9h1jk
 GFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697645366; x=1698250166;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VRl5e8mjRDJIeb/o79NTWlLleGw1AVu8K59VxhRz54k=;
 b=OttmytAqTfOxxhHoHrXY6IExrQc74MVrEoUmT6MLmF4m40dIujpSqmUY0aEiA7+P6D
 K8Tv9exbt30g2CLj19ZGrLbtXln5sAZ2QfdZ2d1MIJEyJkDGJ9oPM8wrdbUIhAEvzBvt
 199tOOt7l0g3aL0qPRh1bTDNW1dRf57jXqWoHzKmLfNMqlOKkuBl2WbBUKMl8GiGayTA
 piFVd6mdx9BGYnVyToOplU24AhbqxKYxCeSNmFo2pBPn15qm2P1/i7Ta0CG8z1BfdJVm
 btjgvr9SqsdOdRq2RJHYucIlgL0f3tN2Kdm8Z/nwQGMj+YNziTwUym3XQKAhLmnY+0EZ
 jgkQ==
X-Gm-Message-State: AOJu0YynL3qVsJWwSGCGXG9yw7sp5Dv5YQ/K1IN9K8KWxybbEzT4D43Q
 5uRMNNEuP53OSoNJZ2W+U+OkIQ==
X-Google-Smtp-Source: AGHT+IE2VotWtoTYwUEhtW2M8zJTtW/CYFnbVTG2ulm/HRaaPnFHyvssyPG14KrZDPqR5ncBBYOeDA==
X-Received: by 2002:a2e:2e19:0:b0:2c5:2df8:d321 with SMTP id
 u25-20020a2e2e19000000b002c52df8d321mr3938462lju.36.1697645366516; 
 Wed, 18 Oct 2023 09:09:26 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c12-20020adfe70c000000b0031c6e1ea4c7sm2389298wrm.90.2023.10.18.09.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 09:09:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ACF4B1FFBB;
 Wed, 18 Oct 2023 17:09:25 +0100 (BST)
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
 <20231011165234.1323725-13-quic_svaddagi@quicinc.com>
 <31ae6951-2f32-ab86-4ddc-aa70364a89ce@linaro.org>
 <20231012123338.GF1130358@quicinc.com> <87ttqvnazo.fsf@linaro.org>
 <20231017092152.GA689217@quicinc.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Cc: Philippe Mathieu-Daud? <philmd@linaro.org>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, quic_tsoni@quicinc.com,
 quic_pheragu@quicinc.com, quic_eberman@quicinc.com,
 quic_yvasi@quicinc.com, quic_cvanscha@quicinc.com,
 quic_mnalajal@quicinc.com, Brian Cain <bcain@quicinc.com>, Mark Burton
 <mburton@qti.qualcomm.com>, Michael S. Tsirkin <mst@redhat.com>
Subject: Re: [RFC/PATCH v0 12/12] gunyah: Documentation
Date: Wed, 18 Oct 2023 16:54:08 +0100
In-reply-to: <20231017092152.GA689217@quicinc.com>
Message-ID: <87jzrjap56.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x233.google.com
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


Srivatsa Vaddagiri <quic_svaddagi@quicinc.com> writes:

(add VirtIO maintainer MST to CC)

> * Alex Benn?e <alex.bennee@linaro.org> [2023-10-12 15:55:59]:
>
>> > Hi Phil,
>> > 	We do want to see Gunyah support merged in Qemu at the earliest (as s=
oon
>> > as the kernel driver is merged upstream that is), so any dependent cha=
nge in
>> > Qemu for Gunyah would be of much interest to us! I am not sure though =
if Quic
>> > can sign up for the entire "make cpustate accel agnostic" work. Can yo=
u point
>> > to your ongoing work that I could take a look at? Would that address v=
irtio-pci
>> > becoming accelerator agnostic?
>>=20
>> Why wouldn't virtio-pci be accelerator agnostic?
>
> I checked usage of few KVM APIs in virtio-pci.c. I think most of them are=
 to do
> with use of MSI and IRQFD. If lets say we are not supporting MSI, then I =
*think*
> current virtio-pci should work just fine. It would use virtio_pci_notify =
->
> pci_set_irq -> .. -> qemu_set_irq, which should land in
> gunyah_arm_gicv3_set_irq [Patch 7/12] AFAICT. Let me try getting virtio-p=
ci
> working and then I can update this thread again!

Hmm yeah looking at the file the relationship between KVM and virtio-pci
is a bit tangled up. Fundamentally the reason I say virtio-pci should be
accelerator agnostic is that we use virtio-pci under TCG emulation with
no KVM at all. IOW if all of the PCI emulation is done within QEMU there
should be no limit to which accelerators support it.

(warning! potentially incomplete understanding ahead)

However as you have seen there is an optimisation where KVM can take
over some of the PCI bus emulation and instead of synchronous
trap-and-exit to QEMU simply queues MSIs on irqfd which QEMU can then
consume the events and behave appropriately. I'm not sure what happens
with real PCI buses and pass-through sitting alongside virtual PCI
devices.

I suspect other hypervisors might want to support a similar thing and
even might end up re-using the irqfd mechanism for signalling events
from the hypervisor to the VMM. So Philippe's suggestion to fix this
would be to properly abstract whats needed to set this up and then clean
up the hardwired case with a generalised class representing the
in-[kernel|hypervisor] interface. Gunyah could then provide an
implementation of that interface if it ever supports injecting MSIs
directly.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

