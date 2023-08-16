Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A520177E887
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:17:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWL5R-0007LN-81; Wed, 16 Aug 2023 14:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qWL5O-0007Kx-Ck
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:17:38 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qWL5M-0004Ce-99
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:17:38 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fe4a89e7efso62305445e9.3
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 11:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692209854; x=1692814654;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ohArc9A1+RkvCY4OZl0EEMRxWq0811rboNHmbcG4MU=;
 b=kDh/1GMCmEK/DEjB7l+Oq6w3v2A9ZEVFVXDkPFcIWm3240w78X17tEHL7A+NtDD2x3
 xXpaPa6mh3OCNDBo1hhnW/CxQcOmCm/mg3XwUjMHXjg8LYp+R4M5AnTgD1ULaa4tD4XC
 Yd6RHtfmMdSoNBrzIBHFl4TQps/hquaKX2/9SFZZrUb3P/BIJtyORj7VPsGS28nYi3Ys
 gTLosb2kaGyCKI18k/tSGUJmkfEaPSF9ZTB/5+jfcXnmjj6jmSagGxMc2rIedJsSWzSG
 6fDKfOw1qw9yBQ9q0ucwcdQnKqIGkCzCfII6ALc1ZugqJXpBI2x0ZYJ1EKaZ/THeXHs4
 Ok9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692209854; x=1692814654;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:to:from:user-agent:references:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ohArc9A1+RkvCY4OZl0EEMRxWq0811rboNHmbcG4MU=;
 b=PcJIbYUHIEZDEBDAlsusVwlPA7llyKWOYibVkr0nCMD6wO5ge3z6y60P6mdBtKvV/7
 ERLKBCID80Pc+yxRdzRqpVPcreALwNm70f2drcyc5h/eCSlMuaR18y3nI6XmmLFZ/onS
 WlMNWZ49xfMZyR/NZDMgUPx03Xs8AWs52Toxrt1X6QNmUSWzTq2EqbiYyewM31L9AF5a
 bZDVduPtq1VHFSdRXbt2mA7MgerjL++GLomM1QVqnL83Bd8REeGtgktn/aUII5CX1qpb
 /TyD9hEgaxYcv5VA5t4Jj1sPsRh16ccGQYp5+3wr30Ixzu7awoKcbqY31HiLw49ZJ1Op
 QBNg==
X-Gm-Message-State: AOJu0YymIQ8mgdiuh9ahdhXK7yfMErU1lA9lB7W45GoP/x1x8g/A6vQq
 kywCFO41mRwl81x1FjeXdoYZrg==
X-Google-Smtp-Source: AGHT+IGeiZJzeUa/vkxhgWkK7kWhIa2W8HfCwCD6qkZjqiFdsGzyduIsSEtSuLJ6eD0VkmeP1U9CjA==
X-Received: by 2002:a7b:c45a:0:b0:3f9:c8b2:dfbd with SMTP id
 l26-20020a7bc45a000000b003f9c8b2dfbdmr2062937wmi.19.1692209854370; 
 Wed, 16 Aug 2023 11:17:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a7bce10000000b003fba6a0c881sm128349wmc.43.2023.08.16.11.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 11:17:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 982401FFBB;
 Wed, 16 Aug 2023 19:17:33 +0100 (BST)
References: <SN7PR15MB6086D1B0ECEE5ADBD07F8847C315A@SN7PR15MB6086.namprd15.prod.outlook.com>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Igor Lesik
 <lesikigor@meta.com>
Subject: Re: How to synchronize CPUs on MMIO read?
Date: Wed, 16 Aug 2023 19:16:55 +0100
In-reply-to: <SN7PR15MB6086D1B0ECEE5ADBD07F8847C315A@SN7PR15MB6086.namprd15.prod.outlook.com>
Message-ID: <87edk2onr6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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


Igor Lesik <lesikigor@meta.com> writes:

> Hi.
>
> I need to model some custom HW that synchronizes CPUs when they read MMIO=
 register N: MMIO read does not
> return until another CPU writes to MMIO register M. I modeled this behavi=
or with a) on MMIO read of N, save CPU into
> a list of waiting CPUs and put it asleep with cpu_interrupt(current_cpu, =
CPU_INTERRUPT_HALT) and b) on MMIO write
> to M, wake all waiting CPUs with cpu->halted =3D 0; qemu_cpu_kick(cpu). I=
t seems to work fine. However, this HW has a
> twist: MMIO read of N returns a value that was written by MMIO write to M=
. Can anyone please advise how this could
> be done?

Under TCG all MMIO accesses should be serialised by the BQL so no other
MMIO access can be taking place until you finish the operation.

>
>=20=20
>
> Thanks!
>
> Igor


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

