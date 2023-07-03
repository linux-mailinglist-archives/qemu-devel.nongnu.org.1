Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1793574642D
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 22:34:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGQFQ-00035I-Km; Mon, 03 Jul 2023 16:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qGQFM-00033R-5b; Mon, 03 Jul 2023 16:34:09 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qGQFK-0001Il-7T; Mon, 03 Jul 2023 16:34:07 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbc244d384so45932985e9.0; 
 Mon, 03 Jul 2023 13:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688416444; x=1691008444;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUWl2Iyssy1d60+5HhPMOJF9IPPN2mqiDyzrVG26NIg=;
 b=E+ykazGcUG0GL0LzzxUrKC9Fm/jRJ9cWNJnEcijO1B0A9GoNGMGYCP2sdWtxCcrovP
 f0JJF+lg7C6qhWAlCFqLAnOFLEWjqT6QdS65yLOAX7qs7HaYK9aeXgKIskITierdKD/6
 PlLim/u0LtiDqodTdvz+NRwh5sVX1blD1JewTYNQdNvt/A52jRvodAJdBwtJjmBASFxn
 BiNlMbIZbm+/ByMAe2Zc+QT7IhehaVWxVWUPSRlGBsyUORmO7f5FZoWKBLwvOLZYjtAK
 wMYwoyfVtavSOgypvriEas4K2UWOUKC9Yl0ltjJBhwOvSEFoy7WYB5MbfbBE8SjBSzwe
 TwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688416444; x=1691008444;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RUWl2Iyssy1d60+5HhPMOJF9IPPN2mqiDyzrVG26NIg=;
 b=S9BDUdI8/VL3voXR4/BgfwFNTw4URn8YbY7ehvku/JZ+D8Or5TEFq1E3NDRrFx+pj3
 +7+1ejfwHL6K0XuhAYbgv/AV4xY11hvF0xHyjtJI2P+GDeeNm1dD4jq1f2nUNI9ZqoGd
 R2+BWXSxRnE7JWcf6QYQiMmH+O5EK2v7llBBt3FgDqXCOUSaoFMSHaNXph1R4DwVWCZq
 RKfHKY8MuDOBADhTT9kns9NPXSwArmRHNqyza/w5u3Cv+v9JGFn6P8N8E1bCMd8sYZpl
 ICGXLI7dqr1dPzIyZ6sVrXJoE3F3MDPQEB8XkkCIMqk6wH0uTHBso2155E10pileuFgL
 Pyqw==
X-Gm-Message-State: AC+VfDyo/+IL4f47fwwVga8LaECcPHxnUYklUZ4xSF5VDagJPn/hLrzq
 +m8VZH/7028HUDLaDDeiqGE=
X-Google-Smtp-Source: ACHHUZ4P1SkxcYHiqYPZL2NovVaH4t+DwYsjMucTmWP5QJ4kMrWTY7rLcrg1k7N8w84+ZBBzGym40w==
X-Received: by 2002:a05:600c:d7:b0:3f9:b972:731b with SMTP id
 u23-20020a05600c00d700b003f9b972731bmr9242711wmm.11.1688416444036; 
 Mon, 03 Jul 2023 13:34:04 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-011-232-252.77.11.pool.telefonica.de.
 [77.11.232.252]) by smtp.gmail.com with ESMTPSA id
 v4-20020a05600c214400b003fa95890484sm23346979wml.20.2023.07.03.13.34.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 13:34:03 -0700 (PDT)
Date: Mon, 03 Jul 2023 20:33:58 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Olaf Hering <olaf@aepfle.de>
CC: qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Lev Kujawski <lkujaw@member.fsf.org>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] hw/ide/piix: properly initialize the BMIBA register
In-Reply-To: <20230703095929.6e793dcf.olaf@aepfle.de>
References: <20230701174659.10246-1-olaf@aepfle.de>
 <62EDA748-11A3-473F-913D-F9464335A382@gmail.com>
 <20230703095929.6e793dcf.olaf@aepfle.de>
Message-ID: <93902CB6-7A6E-49E5-A55F-432C6B4BC00F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



Am 3=2E Juli 2023 07:59:29 UTC schrieb Olaf Hering <olaf@aepfle=2Ede>:
>Sun, 02 Jul 2023 22:18:50 +0000 Bernhard Beschow <shentey@gmail=2Ecom>:
>
>> Do you know if that command calls pci_device_reset() (which would event=
ually call piix_ide_reset())?
>
>The function is pci_xen_ide_unplug, which calls device_cold_reset=2E

I think this explains why the BAR isn't reset: Unlike pci_device_reset(), =
device_cold_reset() lacks calling pci_do_device_reset() which would take ca=
re of the BARs=2E

Paolo, Peter: Should we switch to pci_device_reset() in pci_xen_ide_unplug=
()? Or is device_cold_reset() supposed to do everything?

Best regards,
Bernhard

>
>
>Olaf

