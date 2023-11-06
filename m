Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B3D7E2F5B
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 22:59:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r07cL-0005Mk-F9; Mon, 06 Nov 2023 16:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r07cJ-0005Ls-2i
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 16:58:43 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r07cG-0004xb-SX
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 16:58:42 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9d10972e63eso735308966b.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 13:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1699307917; x=1699912717; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZJ2l0i3c+P09WvyF0etgoXcaHkJTy7FuU6IyDiV68r0=;
 b=iB4rbBERpE9Zte/DqJfw87eGcbCxeaqQqvGzi3jV556fqQN77OGaNn9JjhLZtmsrJE
 xrY2siEJg3ethlYiokOtux0Fd7aH6edVTwH9pxb8AXJSpNbj1ifSAQgWd/Lr/jxMPo7W
 Gg0+UDl7nfnqFHTK1GF6E3Ox0J7HHBIyj/Z943QXYtxxXEYaNHbaTSIibU8ia+If+lT/
 PbEqQ3oIijZ6rrcRz3neMg90chFpETYN8UnAKm3alD4+5gIIM6J3CCxv0X+0xz+sWjxi
 /zYrIXVLtEyQ44j3dt/yQgiyCoWoaoqH5Tlvlkfx2isX6v/+aY34T9wOIryYILau4tYt
 Lotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699307917; x=1699912717;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZJ2l0i3c+P09WvyF0etgoXcaHkJTy7FuU6IyDiV68r0=;
 b=Da5YkKlS4s7zA+FvcapsIRHUCn/KqG1/so00hnaDRICH9h7pH98+y71MfpaJ/x5tow
 6HDZnCZUuMYZuGpayq0om6tTW/acgCa43FIKbSWSfu3EnCvUfWMqiKiU8vhFe34oWW2K
 1QuPkBT1vHQTuPjg6dAZDBYR1pOQ3VHcV/Ck785jAckLAJF1g2no0T77UAGa+57MymYO
 95kZqnsUM3S6C03dKA6qioXQsk5E8g87AcfCqYZBYVsTPEZAFchnrSm4n+L6GcnxW7rp
 9TEpSwz/tW4G9+DeITGHWNx7PTUaIu1R6yPJ+q1z5lUkb/G7bVRjYOb6SbyJ+zBh4//N
 Rxyw==
X-Gm-Message-State: AOJu0YyO5u9rMXgGSy3vVcQSURrp5kVZBIub385ILqC3o9bnFu/AldDf
 WbOAVfnAmRQD7LzZe3G1kB01m1pJTddxYSYSAedHkw==
X-Google-Smtp-Source: AGHT+IGOs/tjy3IB0ztGx2qb5nYh47EpeaZmchLYdHr39CBhX0HAbURxa/289XWfuLweZJALZ4KWkOYH06qXTtMJsTk=
X-Received: by 2002:a17:907:934c:b0:9d3:8d1e:ced with SMTP id
 bv12-20020a170907934c00b009d38d1e0cedmr15239500ejc.34.1699307917420; Mon, 06
 Nov 2023 13:58:37 -0800 (PST)
MIME-Version: 1.0
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
 <20231025193822.2813204-10-hao.xiang@bytedance.com> <87fs1snpf0.fsf@suse.de>
In-Reply-To: <87fs1snpf0.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Mon, 6 Nov 2023 13:58:26 -0800
Message-ID: <CAAYibXgOhot3gHfgddspOz-jC3WZK7LqR8C-3fXeXZ6s7VFyig@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 09/16] migration/multifd: Add new migration
 option for multifd DSA offloading.
To: Fabiano Rosas <farosas@suse.de>
Cc: quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com, 
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x62e.google.com
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

On Mon, Oct 30, 2023 at 7:41=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > Intel DSA offloading is an optional feature that turns on if
> > proper hardware and software stack is available. To turn on
> > DSA offloading in multifd live migration:
> >
> > multifd-dsa-accel=3D"[dsa_dev_path1] ] [dsa_dev_path2] ... [dsa_dev_pat=
hX]"
> >
> > This feature is turned off by default.
>
> This patch looks fine. However I wonder if wouldn't it be better to not
> couple dsa with multifd in the capability name? I.e. we could add just a
> dsa capability and have a check saying that it currently only works with
> multifd.
>

I will keep that option open. Right now, it's only used in multifd
migration. If we want to use DSA offloading in other scenarios, we can
add new switches for those scenarios.

