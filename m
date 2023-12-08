Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 326F9809F9F
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 10:41:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBXL9-0000cG-9f; Fri, 08 Dec 2023 04:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rBXL6-0000bl-QU
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 04:40:08 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rBXL5-0001ik-5E
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 04:40:08 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40c0e7b8a9bso25110215e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 01:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702028405; x=1702633205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnY1KmQtCtb4p8xCEBL0H/kkULZwzc0gZk6nZphu4ww=;
 b=Dqq+k6GR0ghRcAp+iSw++bCc90jlyp0B1W+0uGF7VDgGm8oA7j/1SJknivmslENDHG
 4gkQdS0YcMOy6iXewKZJOb2WyqIsQl0Oy1wUa0ldpb56vO1eweGIA8q+wfki1F6ZYclP
 XsT1WWamMRzPq2RHIp5K2drQYsTnZxafmtSXs1z3sNljyrsnJdcOqmo8a8dZPd4DTfmt
 o5tKaj9QEnGVMxmwkvwHg5CQ671nkakmaIW25fkeSzkHzPFIZIEBon8PSx4a4quv4ZVP
 tV/Yjha2Xdadukc+i40A63PKK1IiMv7v2mfM26ziybY+PlOVbuLaFUMaaNwnkHU5cJ6e
 A8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702028405; x=1702633205;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZnY1KmQtCtb4p8xCEBL0H/kkULZwzc0gZk6nZphu4ww=;
 b=i6rvI04+jhtDmx3H9NJqrjcrKwZGjGJ/s2gSeUqWpwXPXBLHGPzA5NuObMr2R3/G/Z
 /mjRzEZUK8iBreMx0qWmyipAxN7ghLxTxMadAJtAQPkugVp6Y4iITGMaa/aoUaxM18ap
 zz/w+Le9ch29FjXqHfapU5smA6FKUFS152rf6lkbF0XVxFn8kyeItgNgolc0AEBILL05
 Dpx0QEpurfXvh/bjpONq6MlyOUIcsmYsB2LFAPBEnBJH2nYzggX8qvPeVPpVJiL14fw/
 YFQ7f0q0EktEJbmULuu7QoT7HUBOP6Zy5SIvts+slnqFqRpPlcqW5/ClbtljcWVvh2Y4
 7ovQ==
X-Gm-Message-State: AOJu0Yxozo+omAgU18N4eThCVZ3FYh8TkrPfwtTNjoJ/+RXSDtg1Tmy5
 rQRu8+5eo54r/Gs2BYMn11wxzrdhN/cJ7F7VjfM=
X-Google-Smtp-Source: AGHT+IEqeT33fJwOhJTeKJ2yyAYVGinvD7BE1aTfGTHgl4qD2uEJJ1FklGSGPVsKF2nXuwndJ4XADA==
X-Received: by 2002:a05:600c:a007:b0:40c:27a2:ea90 with SMTP id
 jg7-20020a05600ca00700b0040c27a2ea90mr1613101wmb.136.1702028405031; 
 Fri, 08 Dec 2023 01:40:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 r20-20020a05600c35d400b0040b538047b4sm4617943wmq.3.2023.12.08.01.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 01:40:04 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6A3045FB61;
 Fri,  8 Dec 2023 09:40:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: aziz tlili <aziztlili2222@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: Kext files for VirtIO
In-Reply-To: <CAHwHw5DtWyaxFJYNC2ygQc+ubJNGHqrdGgAwgRr+8tPhea+DEA@mail.gmail.com>
 (aziz tlili's message of "Fri, 8 Dec 2023 08:41:35 +0100")
References: <CAHwHw5DtWyaxFJYNC2ygQc+ubJNGHqrdGgAwgRr+8tPhea+DEA@mail.gmail.com>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Fri, 08 Dec 2023 09:40:04 +0000
Message-ID: <87jzppxcaz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

aziz tlili <aziztlili2222@gmail.com> writes:

> Do u guys have some free time to develop kext files "drivers" for VirtIO =
devices (like virtio-gpu-pci and virtio-blk-pci and
> virtio-net-pci) for PowerPC MacOS X Tiger (10.4.11) and later (till
> Leopard 10.5)? Please, I need them as soon as possible!

I don't think open source maintenance and "free time" go together very
well. QEMU developers are either volunteers scratching their own itches
or paid by their respective organisations to advance their particular
areas of interest.

Developing VirtIO drivers for operating systems is really something for
the OS vendor to deal with. However considering Apple has already
transitioned architecture *twice* I suspect they have no interest
drivers for something already out of support.

If you really need something that urgently I think you'll only get it by
hiring someone familiar the OS to write one for you.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

