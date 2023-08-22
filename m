Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 791F8783C63
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 11:01:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYNG9-0002QR-Iy; Tue, 22 Aug 2023 05:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qYNG7-0002Q3-HC
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:01:07 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qYNG5-0002Th-BH
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:01:07 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-319559fd67dso3951378f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 02:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692694863; x=1693299663;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q2dURGTUoTOyo2PilMfzl8Py4+8dcNQrfoZYGfPP9vk=;
 b=nBSr391iaUdYu/ivraI7qZPfSXx8HWEHxWZlu2f7dN1OhOfSGz+XWccIiUUvp1mS9A
 56IKJG/KcsSzJEICXzCwWsOFjW28BfNFTr1k5SXCuz6/rGr6S5EKtSN2DFwaalD3wyP5
 6Qs/bPivhcGsRDbkVL5gwx6O1zzPQkn9gkRh1xrgt8KLDHXkazwCxQ9huQ91QuDstHUM
 WPmJd6duxEJyFyt6VJZDRPEcUBKCEGiY0TfhuNWxC8GjUO1stFwz7yZUM0D2lTtkWCyz
 v6yr8GBv/vEcf9jRbo8MfYz1g+7sofymI+KoPjeMd7KYezP5tUoOTr7Ub49P8FsxeJ5s
 3LMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692694863; x=1693299663;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:to:from:user-agent:references:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q2dURGTUoTOyo2PilMfzl8Py4+8dcNQrfoZYGfPP9vk=;
 b=iErsvCdTb1e1arXf+SAM3//oyZcWZv1nScP90DTBdhH/EJ6HY/dGeL0/h62twubAUr
 Hihu6q+nDWZaaOf4PYiblqmRErVbw0QPa2CQJ4grGAor7LiO9r8xnGZk79VP8g0aZ3Mn
 jcnItPAe3XKJAxd2yKoxUdERwlJ9dMzRhvCHUX4/+iEQKxHngg6x9tqcDFBUlF2nefj8
 EeURca2TrHUfFfOLPtv4zyHSGvpMfQkdyA0+oY2r+8E/IumWvu/SkET8qkp9O/QZdrEc
 K535iaXgUUJsj/xTGyjBsO12v3Qvue9YD2Oef5bB8VMS2rrnBkVd6eIT1DE5FdejPxfk
 SP/A==
X-Gm-Message-State: AOJu0Yzn4GGdtvOoPcwv0abiBulniMjgULLZoCZb9cDSYOdptQMSCOMN
 xZe5JM2RrOSZr14TApv22EkvAQ==
X-Google-Smtp-Source: AGHT+IHDVfKmwBaeglf6Ke/pjcrGyIJIz1JigXQiJCGQNOiwgK/dgN73ESolwIaV/UeR8mVNMXjeMQ==
X-Received: by 2002:a5d:69c7:0:b0:319:83e4:bbbf with SMTP id
 s7-20020a5d69c7000000b0031983e4bbbfmr6126059wrw.20.1692694863511; 
 Tue, 22 Aug 2023 02:01:03 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 w1-20020a05600c014100b003fee53feab5sm10982928wmm.10.2023.08.22.02.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 02:01:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A6A5D1FFBB;
 Tue, 22 Aug 2023 10:01:02 +0100 (BST)
References: <SN7PR15MB6086C79340695F5915F00F20C31EA@SN7PR15MB6086.namprd15.prod.outlook.com>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Igor Lesik
 <lesikigor@meta.com>
Subject: Re: trace_exec_tb(tb, pc) does not have cpu index
Date: Tue, 22 Aug 2023 09:55:39 +0100
In-reply-to: <SN7PR15MB6086C79340695F5915F00F20C31EA@SN7PR15MB6086.namprd15.prod.outlook.com>
Message-ID: <874jkrih81.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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
> I am wondering why trace events like trace_exec_tb(tb, pc) do not have
> cpu index, how to make sense of the trace in case of multiple vCPUs?
> I have changed it to trace_exec_tb(tb, pc, cpu->cpu_index) to read my
> trace, and now wondering should not it be there by default? Am I
> missing something?

Not necessarily but be aware trace_exec_tb won't catch every execution
of a TB without -d nochain anyway. There are other trace points/logging
methods you could use (-d cpu) which follow the executed PC more closely
although without the TB associated with it, although again needing
nochain for completeness.

It really depends on what your overall aim is? If you really want to
closely follow what a guest is doing then build an experiment using TCG
plugins where you can flexibly instrument and trace execution. If you
are debugging TB execution does the vCPU it runs on really matter?


>
> I am using "simple" trace backend.
>
> Thanks,
> Igor


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

