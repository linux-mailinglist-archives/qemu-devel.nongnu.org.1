Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4317E6E50
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 17:11:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r17c0-0006Zi-I8; Thu, 09 Nov 2023 11:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r17bs-0006X5-Nt
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:10:24 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r17bq-0002ji-2h
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:10:24 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-507a55302e0so1326328e87.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 08:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699546219; x=1700151019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CcBV65mUoMGbNa0qsMDzRgf6NgQayGO1Kv7UbVtWKMk=;
 b=gK5RBr2q539aWLiiGcB1gPsXd/t/PqAby/YW30C3tTJAFDFG5MOIzW/x4VEkoHjw5J
 2ArzSnmiYX0LapHAwgPaDX97lotJcMhlOKNwb/WYzhJMwfiJhBJkIXAI7liQ16npHUd8
 OSWIRpKYz8OmVxbw9dy+0l7ggYLKnyUwOqRoqyaAzBgFchXAROduBYGCLuYZGWJfNVii
 uAz9Q+9NUU04CJ73SxuY4R1bHoOLGTvgsYf8C0tDjGYCofsLQbuJ6ZeqmI0bFsk66N4l
 qbVOOb0kdAlzTe/NcnEAOS35jvaggd8SOgTa6cUinXjGYqTzFIxf8ZXa3eoxLL1+sJFu
 Pg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699546219; x=1700151019;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CcBV65mUoMGbNa0qsMDzRgf6NgQayGO1Kv7UbVtWKMk=;
 b=o2JKYlpHeIJ3t/vCzZpgNCMx+e4EJL8+qHhjg+QGa0vUH34u/p9QTRZKP/9gqzqRcE
 FhuEHUNR2MNIYXblOPe1x7EyyNIzBGdaoYnFD6gLKWN6H0HBBKvfKFpLL+BhXr0B4nbh
 7MExb7LH7f3IHW0qWx4A498Bze2GV9OWhgbgGEhiYG1nlQGvrXEKUR/1EovWxFsWD6Td
 rf2EllJFCE+g1LOV80wfKF8NWmtugOUp9X2HR0tyELt2ta45PYUZBXp0AhW57ZvAxTMN
 azYVNET9DZWvKCc7eZ0ozkY6b2XjGQNlOB29oKjOkPQsWapPFo/3FAW/8/nRA6W3v95R
 eB6g==
X-Gm-Message-State: AOJu0YyjkIE+0eFcWGV8/9XNr213OIX8jEFq1NxzgIeFMFxvbvNBkOIj
 Vmq9A60H0Czjy/+j1C720c1Zxw==
X-Google-Smtp-Source: AGHT+IHsZ+Ol52ZqqeaofKp9esP7qZJfYL44US1IqoBPe3Jp7vGhokh2tsmiF2i1klZFWaSYSc4eCg==
X-Received: by 2002:ac2:5238:0:b0:507:9a49:3f23 with SMTP id
 i24-20020ac25238000000b005079a493f23mr1674739lfl.18.1699546218922; 
 Thu, 09 Nov 2023 08:10:18 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n7-20020a5d6607000000b0032db1d741a6sm7624222wru.99.2023.11.09.08.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 08:10:18 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 10BBF5F756;
 Thu,  9 Nov 2023 16:10:18 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  qemu-devel@nongnu.org,  Igor Skalkin
 <Igor.Skalkin@opensynergy.com>,  Anton Yakovlev
 <Anton.Yakovlev@opensynergy.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PULL 08/63] Add virtio-sound device stub
In-Reply-To: <CAAjaMXYV8DVZhzFi-EH-iNdB8bYYQoF2bgM_ACjJTM7Lz3=EPQ@mail.gmail.com>
 (Manos Pitsidianakis's message of "Thu, 9 Nov 2023 17:50:53 +0200 (18
 minutes, 55 seconds ago)")
References: <cover.1699351720.git.mst@redhat.com>
 <2880e676c000a62828d3d9ece7b2ec7a513560a2.1699351720.git.mst@redhat.com>
 <CAFEAcA_TS-B0gc-DUYT6BaKnm8Uauhsx3rW2dmVNUgTToVjSJg@mail.gmail.com>
 <CAAjaMXYV8DVZhzFi-EH-iNdB8bYYQoF2bgM_ACjJTM7Lz3=EPQ@mail.gmail.com>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Thu, 09 Nov 2023 16:10:18 +0000
Message-ID: <87h6lu7vrp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12d.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Hello Peter,
>
> If you want me to, I can roll a new version, otherwise I have attached
> an updated version of just this patch, adding an if check.

You need to do a diff patch as coverity only runs on stuff once its
merged.

>
> Thanks,
> Manos
>
> [2. text/x-diff; v14-0001-Add-virtio-sound-device-stub.patch]...

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

