Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A56C4823836
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 23:30:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL9jY-0003RB-HE; Wed, 03 Jan 2024 17:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rL9jW-0003QZ-IL; Wed, 03 Jan 2024 17:29:06 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rL9jV-0002ps-2M; Wed, 03 Jan 2024 17:29:06 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40d5a41143fso70442605e9.3; 
 Wed, 03 Jan 2024 14:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704320941; x=1704925741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yFtmu+/SLVoSwA0M6bICIlut2qL+mspFLhB5Gr3ix5M=;
 b=K1dO69DIaUosuWXGHucWVlAJGNYu85DEiGaD2ovCdzGq432YptFE+IhOh+wMXxfx5q
 AYk4okTeXSpsVLiUxBAvnS7QynGXnAzFFqYswWdAjkZakmbRbxOLXOl+acTGOfqBJmED
 QxJaeaEGpLpbURA4sVd3EBDJSdrKdYAZ5x+Qw8dlOgR5ze8RdKKCajGLr7+Z1nT/wNuH
 DHqB56AYoZPM/W7gYm7RXO6cN7qBRL6vol6GsmkRIYG4LQvGFA99OalHGtghC5HcvbXc
 vPQfV0wGkGDpkXFtan95vfXkGw22gnvVG56zo0nnlV/L22Y94+potMOkmKsw9AKTAuMe
 qBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704320941; x=1704925741;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yFtmu+/SLVoSwA0M6bICIlut2qL+mspFLhB5Gr3ix5M=;
 b=pw14eiQ3cxJecD+nOX47Wdcx+FoaCXOyYcp/q7cfAG9hiM2ttMFyFc8GWhVtsrvXAX
 YoTbmD6rQlQqb/rTbIvP7ONSEeUsrKVhdqQ+vX2vJWxHZgOoqvanJq8SK5V0N16Qh3Ow
 5QjDBkpFN7gDzckb84G7hRPFdAYEQbv/obwx6wJO8Mw7aPLv49JbBfqx+8ZkU9ZMRpJg
 pNQ+eNAQAMHmeEwNZZZ7tz4jbI27x/mmlvpO6qnwE076zVTzsAkGJstr38wRh6Gd+cfF
 lj1ciVMPxisT/weIHXDNcMJ1kLyww4ll8F08IEOsQPuEN4ZWSBvHMG06fZN3x07EmTSh
 dXdg==
X-Gm-Message-State: AOJu0YyummWMtLT4BDwsXzLuELTeVb+SzzSFvRUulF6CbBt7PKuPy/Ts
 ZL5kDzJUaKNYoNGWSH5z/RSCRSsErYI=
X-Google-Smtp-Source: AGHT+IHrA0bAk5PLY09HUAO4fkG6MxIi0TUGpejcEc9TJGLmbSBNR5j38EA/UCseHw6LBYex0bBuxg==
X-Received: by 2002:a05:600c:1f0a:b0:40d:8fcb:af54 with SMTP id
 bd10-20020a05600c1f0a00b0040d8fcbaf54mr923936wmb.145.1704320940461; 
 Wed, 03 Jan 2024 14:29:00 -0800 (PST)
Received: from [127.0.0.1] (dynamic-078-054-089-148.78.54.pool.telefonica.de.
 [78.54.89.148]) by smtp.gmail.com with ESMTPSA id
 fa24-20020a05600c519800b0040d94c31fdbsm355498wmb.0.2024.01.03.14.28.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 14:29:00 -0800 (PST)
Date: Wed, 03 Jan 2024 22:28:54 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Pavel Pisa <pisa@fel.cvut.cz>,
 Philippe Mathieu-Daude <philmd@redhat.com>,
 Grant Ramsay <gramsay@enphaseenergy.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Jin-Yang <jinyang.sia@gmail.com>, qemu-stable@nongnu.org,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hw/net/can/sja1000=3A_fix_bug_for?=
 =?US-ASCII?Q?_single_acceptance_filer_and_standard_frame?=
In-Reply-To: <20231214104623.31147-1-pisa@fel.cvut.cz>
References: <20231214104623.31147-1-pisa@fel.cvut.cz>
Message-ID: <F6A326B6-0CA1-4FDE-AABC-D88280F2D607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
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

Typo in commit subject: s/filer/filter/

Am 14=2E Dezember 2023 10:46:23 UTC schrieb Pavel Pisa <pisa@fel=2Ecvut=2E=
cz>:
>From: Pavel Pisa <pisa@cmp=2Efelk=2Ecvut=2Ecz>
>
>A CAN sja1000 standard frame filter mask has been computed and applied
>incorrectly for standard frames when single Acceptance Filter Mode
>(MOD_AFM =3D 1) has been selected=2E The problem has not been found
>by Linux kernel testing because it uses dual filter mode (MOD_AFM =3D 0)
>and leaves falters fully open=2E
>
>The problem has been noticed by Grant Ramsay when testing with Zephyr
>RTOS which uses single filter mode=2E
>
>Signed-off-by: Pavel Pisa <pisa@cmp=2Efelk=2Ecvut=2Ecz>
>Reported-by: Grant Ramsay <gramsay@enphaseenergy=2Ecom>
>---
> hw/net/can/can_sja1000=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/net/can/can_sja1000=2Ec b/hw/net/can/can_sja1000=2Ec
>index 73201f9139=2E=2E575df7d2f8 100644
>--- a/hw/net/can/can_sja1000=2Ec
>+++ b/hw/net/can/can_sja1000=2Ec
>@@ -108,7 +108,7 @@ void can_sja_single_filter(struct qemu_can_filter *fi=
lter,
>         }
>=20
>         filter->can_mask =3D (uint32_t)amr[0] << 3;
>-        filter->can_mask |=3D (uint32_t)amr[1] << 5;
>+        filter->can_mask |=3D (uint32_t)amr[1] >> 5;
>         filter->can_mask =3D ~filter->can_mask & QEMU_CAN_SFF_MASK;
>         if (!(amr[1] & 0x10)) {
>             filter->can_mask |=3D QEMU_CAN_RTR_FLAG;

