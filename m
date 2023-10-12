Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C257C70D5
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:59:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqx9i-0001Qq-52; Thu, 12 Oct 2023 10:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqx9B-0000wV-MI
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:58:47 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqx96-00011J-Pr
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:58:45 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40572aeb73cso11560885e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 07:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697122716; x=1697727516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZW5OE/reskpBesRlO9JCGXFrKIePysu77mJRX5Ed/qw=;
 b=Kc5GV7qt8fUfg3OOPWW8uqGuqqEUxv+6UBCI2bG5GbWDGvddkUEoZN0/lufc4EU3Uw
 XYm0I6zYzoFp89qKPDqRrcXLtSphUTiTl7jYkN/4omobDWRGQ87qAJiwbM2iONGSmgDB
 p244ZvUsEsE3Zw3F390VFykHIWuY/SZFMiGzUxI0bttodyvrpkLPVzBjIK6YLnEc+z7+
 FRvXS8SRI1otCxRQKi2M0S3UhNqSud1RHnI/byNY49srOVH678qBpeJK/IJXEg8GHlZk
 cDwpNteGZ+X6wfbYdnbmP83woYbyoyCC+BbOi4gquzm3URIyvRUCXP5c87tF8+gvOmy5
 TO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697122716; x=1697727516;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZW5OE/reskpBesRlO9JCGXFrKIePysu77mJRX5Ed/qw=;
 b=Cpo6WgQmLSXI96oDQM/+u8eslDT26yGQNMyN+BRuPnvKq1wX7KEf34Azl1rFmkAUPb
 aeVhJsloIcYcuQ+vqLJMftPYFz1FGdY6OUMULrA5WuN2nPbqNcYCg9NoATX1uI881vHr
 6ksr4WPzvMo60iZLjd5cHG3zJDZFVsZ9+XbJMdp+yIr0je9CHSDfCb8rqIYm0/b2ltbN
 ksPj2aCnbOaD9wUckE/pLrAkqYNSDR2WOJLlNSzrBf5UunigXnsLJY6aHG5YM8cuhCRH
 RcELIqrSAYlEsTmm7lBXDIjZzkaC/f7AA0xoq3XQOLX97BRYEHixOxoAd70P3U42Z3TZ
 OWfA==
X-Gm-Message-State: AOJu0YzOX3Jxa4f5lrcxg4jborXk5A9YAkxZTfa7L3j+JjTkDOdR0/3i
 1xQmyjLASllJVlMOFYAl7FT7gQ==
X-Google-Smtp-Source: AGHT+IHvdl6MROZbZb2hNitMDmDKUF2gSGrbb6pI3hL1FBBD5KD/j0py+TMQ6XkHLRxFle0Zb2+2Wg==
X-Received: by 2002:a5d:6483:0:b0:32d:87c9:1181 with SMTP id
 o3-20020a5d6483000000b0032d87c91181mr4987588wri.48.1697122716352; 
 Thu, 12 Oct 2023 07:58:36 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a5d68c4000000b003232f167df5sm18617137wrw.108.2023.10.12.07.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 07:58:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7FE501FFBB;
 Thu, 12 Oct 2023 15:58:35 +0100 (BST)
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
 <20231011165234.1323725-13-quic_svaddagi@quicinc.com>
 <31ae6951-2f32-ab86-4ddc-aa70364a89ce@linaro.org>
 <20231012123338.GF1130358@quicinc.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Cc: Philippe Mathieu-Daud? <philmd@linaro.org>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, quic_tsoni@quicinc.com,
 quic_pheragu@quicinc.com, quic_eberman@quicinc.com,
 quic_yvasi@quicinc.com, quic_cvanscha@quicinc.com,
 quic_mnalajal@quicinc.com, Brian Cain <bcain@quicinc.com>, Mark Burton
 <mburton@qti.qualcomm.com>
Subject: Re: [RFC/PATCH v0 12/12] gunyah: Documentation
Date: Thu, 12 Oct 2023 15:55:59 +0100
In-reply-to: <20231012123338.GF1130358@quicinc.com>
Message-ID: <87ttqvnazo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> * Philippe Mathieu-Daud? <philmd@linaro.org> [2023-10-12 06:52:04]:
>
>> > +Limitations
>> > +-----------
>> > +
>> > +Below features are not yet supported.
>> > +
>> > +* virtio-pci (support for which in Qemu seems to rely heavily on KVM,=
 which
>> > +  needs to be made multi-hypervisor friendly).
>>=20
>> Is QUIC interested in working on that? My work introducing
>> AccelCPUState to make CPUState accel-agnostic was done in that
>> direction, but I didn't notice much interest in the community
>> so I unprioritized it.
>
> Hi Phil,
> 	We do want to see Gunyah support merged in Qemu at the earliest (as soon
> as the kernel driver is merged upstream that is), so any dependent change=
 in
> Qemu for Gunyah would be of much interest to us! I am not sure though if =
Quic
> can sign up for the entire "make cpustate accel agnostic" work. Can you p=
oint
> to your ongoing work that I could take a look at? Would that address virt=
io-pci
> becoming accelerator agnostic?

Why wouldn't virtio-pci be accelerator agnostic?

It works with KVM and TCG for example. There are I suppose complications
if you want to share emulated devices with a real PCI bus rather than
emulating it all within QEMU.

>
> Thanks!
> vatsa


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

