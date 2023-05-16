Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FBA70513E
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 16:51:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyw14-0005nP-8e; Tue, 16 May 2023 10:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pyw0r-0005hp-KJ
 for qemu-devel@nongnu.org; Tue, 16 May 2023 10:50:58 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pyw0p-0007Pl-8g
 for qemu-devel@nongnu.org; Tue, 16 May 2023 10:50:53 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f4ec041fc3so38352905e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 07:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684248649; x=1686840649;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vi+6HiC1ygZzbI9/qGin5aPnGvztVjO2vZKJU6r6EP8=;
 b=Rrm7ARF+RT3IuTDFeOQsnLh0f7MLsdVD7GLdgrZ8FT9d22wzmgPBe2TNKYYbZCKB1O
 UVIkiijcIXG+WqHmrHfo8FG60jsii27rwQh/wNJjgNe9Pv7VcCaLyhh2P3ZpO/ePbDoB
 lPdIIw4Vh9XG/xq4V0veMOdiR/O8RYC4eT4GAmOGckjD1dnLVA11WQfWknM6UZoUQGtJ
 drfnNmhdQ8vHfGoEMsI6zdQ14YC9LT+N+3Eo9zzGT2n9RTD6mx9z0y+dOtYe8YIvR/kB
 zUUcfn5yKY9b3e7HQdvfik1gkCix0Efy2fdoOdXv03DVAsKfCKqQaw09dZEzN1pRNOAl
 IrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684248649; x=1686840649;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Vi+6HiC1ygZzbI9/qGin5aPnGvztVjO2vZKJU6r6EP8=;
 b=X6z3HMEjqyhrMFUpRfM/fY0EjR+KV1XhA3UJSrJLy4xnVVhxofOkB71BORq6ppftgE
 D+MZudqDkqy69MjvrNeno8YQmxa2ZzK1zRhb+DmCMDad6g/kNtYJVFVPG0FiUbdUcXvD
 eCBRquIxK76pEeBoUnVLOlYJiOXCQlwyF8PbbmLVxrJWz/Smpb4ziOLNEElLh7tVEVb0
 zVVeIoQBTHHrxsOrPoT6JN4Xmm/lt38eSFMxs66c6jyMdAavDUHWdQy4iBdD3t9LLYM6
 hclU5hnCzXa1ZJUOnJ6XsHR3Q3NgYX0o9/4Up78atmg349S5SUkP8TD2USk6y+DMxjxC
 fVYg==
X-Gm-Message-State: AC+VfDyugopW/RdNwhTFHCjs33MlVNtfRnP0l9w9Iwa+JguOZrhM0ipY
 YBdsrOLrXMKqYrCqQ2z5SplwqB2O7gD4Ob8xupSHvw==
X-Google-Smtp-Source: ACHHUZ6qIN0OVr0p3Gyg3912zoku2cuoSyrnqkgmrEKSxEFznR6m24ueuJOWuM0xSOeyzY5y9yfrBw==
X-Received: by 2002:adf:de8d:0:b0:2f5:3fa1:6226 with SMTP id
 w13-20020adfde8d000000b002f53fa16226mr28327033wrl.14.1684248649646; 
 Tue, 16 May 2023 07:50:49 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l13-20020adfe58d000000b0030903d44dbcsm2870346wrm.33.2023.05.16.07.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 07:50:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7BD471FFBB;
 Tue, 16 May 2023 15:50:48 +0100 (BST)
References: <CADfM=uvE+DdOAVU-WZmNgiAPom0isN9OFUeky0pPqPbtFmvyRw@mail.gmail.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Sidhartha Reddy Kaliki <sidhartha@drut.io>
Cc: openbmc@lists.ozlabs.org, qemu-devel@nongnu.org
Subject: Re: How to communicate 2 guest machines over serial in qemu?
Date: Tue, 16 May 2023 15:48:10 +0100
In-reply-to: <CADfM=uvE+DdOAVU-WZmNgiAPom0isN9OFUeky0pPqPbtFmvyRw@mail.gmail.com>
Message-ID: <87y1lonxdj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


Sidhartha Reddy Kaliki <sidhartha@drut.io> writes:

> Hi,
>
> We have 2 independent devices running openbmc software on each of
> them. These devices can communicate with each other over a serial line
> using SLIP protocol. Now we would like to emulate the same using qemu.
>
> Do we have any provision to communicate 2 guest machines over a serial
> interface using SLIP protocol?

You can connect the two chardev backends to each other. One will want to
be a server, the other a client. You can use pipe, socket or network
backends to do this.

> We have tried a few options which are not helpful to solve our purpose.
> It will be really helpful if you can provide us some guidance on this.

What have you tried so far?

>
> Thanks


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

