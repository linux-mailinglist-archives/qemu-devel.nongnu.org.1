Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9C182D057
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 11:53:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOy6a-0000my-4x; Sun, 14 Jan 2024 05:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rOy6X-0000mm-SF
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 05:52:37 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rOy6W-0006xd-9E
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 05:52:37 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-554fe147ddeso8743762a12.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 02:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705229553; x=1705834353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sGNBpnTFc8hHRWCGgRbLGdjDZ2LU8XMYjAgGGiMjVwY=;
 b=NPWI8qq1EzFwp1IhOczUo3onx4PFeTSu354cHndBACixZcMqdtyEow9zuBz1DFFIJg
 1n2papY5bYsi59wLl1X/bbtmGwUCKpdxpmE+hZIF7eAN8jpsMv4oiMAhDPYMKpUI/5Fi
 g82aAnqM84lW4A5C+MOpzCCNz97jCSC1WjGUcnNlkSqtUnlQHn8fwHIhK80kWZD3+tia
 o2hDY0Ug1BESgKusLkCAZMA1HfkgTHj5dz6kB+Gw9AgPFXQEY33/s8PPaaFot3BzejSk
 9V8oVk6DIDp1vg2K+G8ZUrBJ2o77iCy/xzLN+L7Oli+lpMkeFM06GGo2GVfqQRiJuzzV
 KYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705229553; x=1705834353;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sGNBpnTFc8hHRWCGgRbLGdjDZ2LU8XMYjAgGGiMjVwY=;
 b=U5HTL3ac6uvzIcKfMLhq4Cse5QK1fF/2pVNr48oMcNoGCKu8O/D282evoi3ShUFCj3
 x6rYvbIaVGJ0FtbVIdA7Hd3pP/SIqEZk1XduuKm0mEGIhvwXnp+7KWSJL8E46akpFSK8
 DyXWkrF/mhe6n/+TSnQpFM8CLPWPMBbwMqFQ9YKiLW9eNxotYT9U3y2SoJ7rkEnFNJId
 KxWpBFA2wovF/js2bjQiywtNm9lle6NM+0UcDLSwlc2VK9tXAG+/+Gdy3u52GLmONsQd
 JbYi9du+POEM5vQUeaMrFYSSd+jU+t4TDF0PX4zEHS1zev/FEw7vGYxmBfEgynxhM/kC
 fFVA==
X-Gm-Message-State: AOJu0YwfcAGlUQml0XWDf3Q0R798JwpckzfoME+/Asn1/UsznDhw+qbe
 Ied4i41pmqJ95PcJalOuaAbjdc6VzWU=
X-Google-Smtp-Source: AGHT+IEnyebH+wh7nLubXUWjSIQEYT9+czx2UqvY6LgBRmeqpDmxbIMoi8QGbNAnFz7SrjXmVWOkRg==
X-Received: by 2002:aa7:c34c:0:b0:558:2241:a6a3 with SMTP id
 j12-20020aa7c34c000000b005582241a6a3mr950095edr.140.1705229553173; 
 Sun, 14 Jan 2024 02:52:33 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-183-249-018.77.183.pool.telefonica.de.
 [77.183.249.18]) by smtp.gmail.com with ESMTPSA id
 cs8-20020a0564020c4800b005579dbd7c4csm4069974edb.35.2024.01.14.02.52.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jan 2024 02:52:32 -0800 (PST)
Date: Sun, 14 Jan 2024 10:52:28 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_0/3=5D_Fix_PIC_interrupt_handli?=
 =?US-ASCII?Q?ng_of_x86_CPUs_if_APIC_is_globally_disabled?=
In-Reply-To: <20240106132546.21248-1-shentey@gmail.com>
References: <20240106132546.21248-1-shentey@gmail.com>
Message-ID: <2744F3E2-D8F5-42F1-8520-7FE8C202C341@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x534.google.com
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



Am 6=2E Januar 2024 13:25:43 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>This series is part of my work emulating the VIA Apollo Pro 133T chipset =
in QEMU
>
>[1] and testing it by running real-world BIOSes on it=2E The first two pa=
tches fix
>
>an issue regarding PIC interrupt handling, the third one just fixes a typ=
o in a
>
>comment=2E
>
>
>
>During testing, I've found that the boot process gets stuck for some BIOS=
es that
>
>disable the LAPIC globally (by disabling the enable bit in the base addre=
ss
>
>register)=2E QEMU seems to emulate PIC interrupt handling only if a CPU d=
oesn't
>
>have a LAPIC, and always emulates LAPIC interrupt handling if one is pres=
ent=2E
>
>According to the Intel documentation, a CPU should resort to PIC interrup=
t
>
>handling if its LAPIC is globally didabled=2E This series fixes this corn=
er case
>
>which makes the boot process succeed=2E More details can be found in the =
commit
>
>message=2E
>
>
>
>Testing done:
>
>* `make check`
>
>* `make check-avocado`
>
>
>
>v2:
>
>* Pick up R-b tag
>
>* Split and rework interrupt handling patch to consider i486 SMP systems=
=2E This
>
>    required dropping Alex' R-b tag=2E
>

Ping

>
>
>[1] https://github=2Ecom/shentok/qemu/tree/via-apollo-pro-133t
>
>
>
>Bernhard Beschow (3):
>
>  hw/i386/x86: Reverse if statement
>
>  hw/i386/x86: Fix PIC interrupt handling if APIC is globally disabled
>
>  target/i386/cpu: Fix typo in comment
>
>
>
> include/hw/i386/apic=2Eh |  1 +
>
> hw/i386/x86=2Ec          |  8 ++++----
>
> hw/intc/apic_common=2Ec  | 13 +++++++++++++
>
> target/i386/cpu=2Ec      |  2 +-
>
> 4 files changed, 19 insertions(+), 5 deletions(-)
>
>
>
>-- >
>2=2E43=2E0
>
>
>

