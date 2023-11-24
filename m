Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 545FC7F6BE1
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 07:03:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6PHF-0001MB-Fs; Fri, 24 Nov 2023 01:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6PHB-0001LW-TL; Fri, 24 Nov 2023 01:02:53 -0500
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6PHA-00021m-CO; Fri, 24 Nov 2023 01:02:53 -0500
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3580b94ac2eso5040995ab.0; 
 Thu, 23 Nov 2023 22:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700805769; x=1701410569; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p16//vOgTg9wG6a18KQzvB15PSmyUw7oDkLLNz8n8pc=;
 b=dGX8a8BQlt6I31Dqkhm8+yWvOSblREinxM18HXxR+VevQOOUXNfToagfucNYECjS9a
 VZRvEl6rkZVxfH3JwzSS9ATxNw2HA+0owBvhvhnQIVSCGa/w4QntpEXfxHaHeIycsQ0m
 2ZsFHhRZi3L4cQ5Tt3tTBQ/muRJM3/BNtWJJBw+hiFxgI61kIvRHYRoyMQzKynH4OxaH
 GQaXImT+ZCZRZIUQ4sXfLMt4NCAnZZ9E4cMM0qnEFoTS21X0w/tTTtDb39+5EjSjh/92
 6LuEymvovm6jnS+/czD/VnCl4VdQwp0E2kmzO9bSYJcF1csrS9bBo/y5mww4gVSzwlxx
 bPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700805769; x=1701410569;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p16//vOgTg9wG6a18KQzvB15PSmyUw7oDkLLNz8n8pc=;
 b=u+Op7Ed8UfBuO3AmbQvuH9GFT4bqE3W6eGAL453j/KK1G1dygnIaxuU+baiGaYccnC
 uHUQsVepsWPkfOOcozS9FsuCWaqpmaN9WF2KUCimKxWb8DSrHq3hJVgguq61ZTPFVtfZ
 U2fOdJmtOLmY0Zm9JSUEnk7Hz6Wud/vrvRyV6dJqFwjgt2F/nOTM91AHkmJyvEdEaz4B
 7G79i5yPWva6c7yOERXP1WwWHKo3pO1DV6T8YUHWtdlhNDZTBaeet3KUBJ5wA+tmPsTq
 3plkmq0DjtWES1Gu3Apzagio2byZ1sVjE7mfh42LKMmFCgP64MhQ0KUdL65BA8aUhV2L
 pPlw==
X-Gm-Message-State: AOJu0YzdajMN2RmGqCzvSwOsVP+CritYCbOF3ezD5XMKRSDVe1TUtkLA
 GM0Xlv+5+eEF54s28AjnLcI=
X-Google-Smtp-Source: AGHT+IHG9X4nzjeNKMkCQ5+mKKLNsXqqhudya1M9r7faUgZM7vENgZ9PQfx0ntRc2mdVXyXq8Pl6Yg==
X-Received: by 2002:a05:6e02:1564:b0:35a:ee9d:eb4b with SMTP id
 k4-20020a056e02156400b0035aee9deb4bmr2340890ilu.5.1700805769319; 
 Thu, 23 Nov 2023 22:02:49 -0800 (PST)
Received: from localhost ([1.145.239.154]) by smtp.gmail.com with ESMTPSA id
 fa33-20020a056a002d2100b006c320b9897fsm2120474pfb.126.2023.11.23.22.02.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 22:02:46 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Nov 2023 16:02:27 +1000
Message-Id: <CX6TBI32PC8G.2Z0K1IX0G01OL@wheely>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 0/7] ppc: pnv ChipTOD and various timebase fixes
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20231123103018.172383-1-npiggin@gmail.com>
 <18517c0b-f928-4bbc-b31c-8dfdfefdea31@kaod.org>
In-Reply-To: <18517c0b-f928-4bbc-b31c-8dfdfefdea31@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri Nov 24, 2023 at 3:09 AM AEST, C=C3=A9dric Le Goater wrote:
> On 11/23/23 11:30, Nicholas Piggin wrote:
> > The chiptod/TFMR/state machine is not really tied to the other
> > time register fixes, but they touch some of the same code, and
> > logically same facility.
> >=20
> > Changes since v1 of chiptod patches:
> > - Split hackish ChipTOD<->TFMR/TBST interface into its own patch
> > - Fix multi-socket addressing on P9 / chip ID mode (P10 works)
> > - Change chiptod primary/secondary setting to use class properties
> > - Add more comments to explain TOD overview and timebase state
> >    machine.
> > - SMT support for TFMR, some functionality is limited to thread 0.
> > - FIRMWARE_CONTROL_ERROR bit implemented in TFMR.
> > - Misc cleanups and bug fixes.
> >=20
> > The hacky part, addressing core from chiptod, is still hacky. Is
> > there strong objection to it?
>
> Dunno yet :)

Thanks for the nice review!

> > This successfully runs skiboot chiptod initialisation code with
> > POWER9 and POWER10 multi-socket, multi-core, SMT. That requires
> > skiboot 7.1 (not in-tree), otherwise chiptod init is skipped on
> > QEMU machines.
>
> Let's update skiboot at the same time then.

Yeah, I'll update skiboot ahead of adding merging this.

Thanks,
Nick

