Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE8782A4BB
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 00:09:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhfg-0004M9-SV; Wed, 10 Jan 2024 18:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rNhfa-0004Lh-Lk
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 18:07:34 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rNhfX-0005fP-GD
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 18:07:34 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e5508ecb9so20127715e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 15:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704928049; x=1705532849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqpXrTRIeK8JXn7lhDVOTpT/7SBAHmdcUakxyikZOD0=;
 b=xQILay+tbjqOF400XGhJJNU/mJ3OcHMaRON5Mjg3hK7WnPpnMwVqtnuw+0sy0BpeCg
 pXs68x1dvsC5kWBf/N2CfdqYHZ6q28SrSKZZVyAjib4oTe7ZEWHqvSIy3y6o9rszmlx5
 Cj8uHpIky7kBL1Yhqx6lHtFbu5ZtZ5JCZuxf62fjvRydhzAoCPONA3sTtG0ZbE05aS30
 KbbuBl/unqtaHsy3cc+XATcnPzk38Z/PjKqh6KFZayTt38RDtrECdUsmCbPn/54lNlF8
 DBWgpwqFGt2MQQSorv4vaWFPOfCcSkJiaJmk1StPmt6Tk60MGIEQHs3cTCQPdhAzEyzj
 JTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704928049; x=1705532849;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QqpXrTRIeK8JXn7lhDVOTpT/7SBAHmdcUakxyikZOD0=;
 b=nCjJUi8FFBRQ8OdXBQOxs7kqlgitCv/aE+8ZmPd15Z8lzzFBxN4MBXGF9JCBQtPfNa
 kYSCO4NLWu/aPLG99fy/mIoRrdDbb2gY90dG2Y6Kqx+pXvBRAJ2LwyTPVboaP11Sv2Pe
 /KOnqw4b5a0uOEeMUUZGTngebC0BwFIKqBSzU0QLBC/778iSc6opgbErKvOHk57aTiO+
 WRzS8ipu0vkQgCWm2N1s1gav+1CC/llhHDkX6erRrF3RnsSyXa7E/ZvyS+ue3N8ODwh1
 f1CsdZhhp62gbJhi5X796xanBkCqNCWmZcyNFSrBIKnTKAtJTC4dVn/FZMBnwWpsd6o/
 6dtw==
X-Gm-Message-State: AOJu0YwqPdjr12vU0qAusEisRQ955Dt8zy8QrG4r9yxbQv+zT1uCaflo
 9MUfdZXJ5MbZRoBiT6kRkHrcOVcXTa2+UQ==
X-Google-Smtp-Source: AGHT+IF1lf2p65+S59dmQg7EC4LQO5sXn4Hb4vkS3Il+F23bXz3AzPWve7pNQMSAMxJ48Vb2bqUr6g==
X-Received: by 2002:a05:600c:4513:b0:40d:72b9:4403 with SMTP id
 t19-20020a05600c451300b0040d72b94403mr72228wmo.179.1704928049296; 
 Wed, 10 Jan 2024 15:07:29 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v5-20020a05600c444500b0040d6e07a147sm3594165wmn.23.2024.01.10.15.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 15:07:28 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3B23C5F785;
 Wed, 10 Jan 2024 23:07:28 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Cc: Philippe Mathieu-Daud? <philmd@linaro.org>,  <peter.maydell@linaro.org>,
 <qemu-devel@nongnu.org>,  <qemu-arm@nongnu.org>,
 <quic_tsoni@quicinc.com>,  <quic_pheragu@quicinc.com>,
 <quic_eberman@quicinc.com>,  <quic_yvasi@quicinc.com>,
 <quic_cvanscha@quicinc.com>,  <quic_mnalajal@quicinc.com>
Subject: Re: [RFC/PATCH v1 07/11] gunyah: Specify device-tree location
In-Reply-To: <20240110083445.GB1649721@quicinc.com> (Srivatsa Vaddagiri's
 message of "Wed, 10 Jan 2024 14:04:45 +0530")
References: <20240109090039.1636383-1-quic_svaddagi@quicinc.com>
 <20240109090039.1636383-8-quic_svaddagi@quicinc.com>
 <48ca6b12-6838-4788-8484-90621b46d65f@linaro.org>
 <20240110083445.GB1649721@quicinc.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Wed, 10 Jan 2024 23:07:28 +0000
Message-ID: <87ttnkg53j.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Srivatsa Vaddagiri <quic_svaddagi@quicinc.com> writes:

> * Philippe Mathieu-Daud? <philmd@linaro.org> [2024-01-09 14:31:03]:
>
>> Hi Srivatsa,
>>=20
>> On 9/1/24 10:00, Srivatsa Vaddagiri wrote:
>> > Specify the location of device-tree and its size, as Gunyah requires t=
he
>> > device-tree to be parsed before VM can begin its execution.
>> >=20
>> > Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
>> > ---
>> >   MAINTAINERS               |  1 +
>> >   accel/stubs/gunyah-stub.c |  5 +++++
>> >   hw/arm/virt.c             |  6 ++++++
>> >   include/sysemu/gunyah.h   |  2 ++
>> >   target/arm/gunyah.c       | 45 +++++++++++++++++++++++++++++++++++++=
++
>> >   target/arm/meson.build    |  3 +++
>> >   6 files changed, 62 insertions(+)
>> >   create mode 100644 target/arm/gunyah.c
>>=20
>> (Please enable scripts/git.orderfile)
>
> Sure will do so from the next version!
>
>>=20
>> > diff --git a/include/sysemu/gunyah.h b/include/sysemu/gunyah.h
>> > index 4f26938521..a73d17bfb9 100644
>> > --- a/include/sysemu/gunyah.h
>> > +++ b/include/sysemu/gunyah.h
>> > @@ -27,4 +27,6 @@ typedef struct GUNYAHState GUNYAHState;
>> >   DECLARE_INSTANCE_CHECKER(GUNYAHState, GUNYAH_STATE,
>> >                            TYPE_GUNYAH_ACCEL)
>> > +int gunyah_arm_set_dtb(__u64 dtb_start, __u64 dtb_size);
>> I'm getting:
>>=20
>> In file included from hw/intc/arm_gicv3_common.c:35:
>> include/sysemu/gunyah.h:30:24: error: unknown type name '__u64'
>> int gunyah_arm_set_dtb(__u64 dtb_start, __u64 dtb_size);
>>                        ^
>> include/sysemu/gunyah.h:30:41: error: unknown type name '__u64'
>> int gunyah_arm_set_dtb(__u64 dtb_start, __u64 dtb_size);
>>                                         ^
>> 2 errors generated.
>
> Hmm I don't get that error when compiling on Linux. I think uint64_t will=
 work
> better for all platforms where Qemu can get compiled?

Yes, aside from imported headers we state:

  In the event that you require a specific width, use a standard type
  like int32_t, uint32_t, uint64_t, etc.  The specific types are
  mandatory for VMState fields.

  Don't use Linux kernel internal types like u32, __u32 or __le32.

in style.rst

>
> - vatsa

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

