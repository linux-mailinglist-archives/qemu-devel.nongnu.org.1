Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2041E75BC5B
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 04:40:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMg22-0002Bu-6v; Thu, 20 Jul 2023 22:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qMg1z-0002AW-9M; Thu, 20 Jul 2023 22:38:11 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qMg1x-00089b-OT; Thu, 20 Jul 2023 22:38:10 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b89b75dc1cso17603555ad.1; 
 Thu, 20 Jul 2023 19:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689907087; x=1690511887;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=22iOZWbqkY0fMtxqMk/un3xve+/Xn6gFKzq79D4sUKM=;
 b=bsSI0pH2yLePDmW7l0w0zAK3sB3zLuLTn+EoKtT7gLle3ozBarZOLmRNZ38laN0OS9
 S3A31z3aUMP8iKb90QvtK6tNyTlkLy4FZGkXCK0Zcd9AOrbMxmTrOqMZ4p36mnmC/AwW
 YC2WuUaaViobUL1dxnO0+0adBWvuGzSevUenQgb1G0GZ1vzV6mGirZ5fSiIIWvpQ8qRr
 IjA2KBxqhTOqBl437NFao76q6ugP8F6enoTc128yPxRHjTC3xGE/2nMoAARJBTFofu69
 7huTyAB8pzAAAzBvoyTCwy1txwYYb4e/FLIEd4Wo6XcrxxspJ+7geer2uzZgUUh6Bj0M
 vKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689907087; x=1690511887;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=22iOZWbqkY0fMtxqMk/un3xve+/Xn6gFKzq79D4sUKM=;
 b=j4ypTRyELzIOT7Lolaw46qGOThHpdUbIQajvICPIIGChYvmsphTAVx4iGCsFMPmtt5
 WKhDUIfKJlQuKLMOvFqiLdYlkZxGMODDJLfWYz3MITqAqVWXsnrhpBO56ZtrTFdOUJbQ
 tVSMF+8YUleknoL4aAC7V6uDG9R6oIT7nwkIFY654P6EZceYDPgG90yC35St3NZjJtBZ
 4l47a4xpwa8gsqDVjSSiVtDnpknYDob6XdaBNACe6P8mwNc9+r0TWbDVinhuYdg0A3/S
 piHVQi7H0FyDWoaVfIqH8oT7ABX5G1FbyMkRHQD3UGjzwtj9m3CJWfvi54rwBmX8+bHU
 EVaQ==
X-Gm-Message-State: ABy/qLbtInb+XTCHYSPH7uc87rTkog+2HknGUE6vUqpwdkDjzop2XHhQ
 S9q0g/2WPqraKWkB3/CIVBc=
X-Google-Smtp-Source: APBJJlGDqMHYLdFxNfCZWoy67zuqi7t0C07oPtpMqbRGntbiF7q4Dn4ao/vPkmwap5oBACH4M+atPw==
X-Received: by 2002:a17:902:d2c7:b0:1b8:5a42:5145 with SMTP id
 n7-20020a170902d2c700b001b85a425145mr1715591plc.31.1689907087412; 
 Thu, 20 Jul 2023 19:38:07 -0700 (PDT)
Received: from localhost (193-116-195-56.tpgi.com.au. [193.116.195.56])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a170902ecd100b001ba066c589dsm2128799plh.137.2023.07.20.19.38.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jul 2023 19:38:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Jul 2023 12:38:01 +1000
Message-Id: <CU7I2BT516P3.1NJPQWALJTVR@wheely>
Subject: Re: [PATCH v2] target/ppc: Generate storage interrupts for radix RC
 changes
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Shawn Anastasio" <sanastasio@raptorengineering.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, "Greg Kurz" <groug@kaod.org>, "David Gibson"
 <david@gibson.dropbear.id.au>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Timothy Pearson"
 <tpearson@raptorengineering.com>, "Frederic Barrat" <fbarrat@linux.ibm.com>
X-Mailer: aerc 0.15.2
References: <20230712161322.2729950-1-sanastasio@raptorengineering.com>
 <c76c0d05-4c69-aa4f-5d20-3dfdb165a765@kaod.org>
 <1004ffbe-8855-75d1-45e7-65360bfd1807@raptorengineering.com>
In-Reply-To: <1004ffbe-8855-75d1-45e7-65360bfd1807@raptorengineering.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

On Thu Jul 13, 2023 at 3:35 AM AEST, Shawn Anastasio wrote:
> On 7/12/23 11:56 AM, C=C3=A9dric Le Goater wrote:
> > Hello Shawn,
> >=20
> > On 7/12/23 18:13, Shawn Anastasio wrote:
> >> Change radix model to always generate a storage interrupt when the R/C
> >> bits are not set appropriately in a PTE instead of setting the bits
> >> itself.  According to the ISA both behaviors are valid, but in practic=
e
> >> this change more closely matches behavior observed on the POWER9 CPU.
> >=20
> > How did you spotted this dark corner case in emulation ? Do you have
> > MMU unit tests ?
>
> I'm currently porting Xen to Power and have been using QEMU's powernv
> model extensively for early bring up. I noticed the issue when my radix
> implementation worked in QEMU but failed on actual hardware since I
> didn't have a proper storage interrupt handler implemented.

Cool. This was on my todo list because we rely on it for nested HV
KVM too.

I actually didn't know about that odd effLIPD=3D0 exception, but it
looks right. How did you test that, by running with MSR[HV]=3D0 and
LPIDR=3D0 ?

For the patch,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick

