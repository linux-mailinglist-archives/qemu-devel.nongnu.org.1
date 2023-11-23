Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2665B7F5606
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 02:47:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5ynh-0000bA-Ar; Wed, 22 Nov 2023 20:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r5ynb-0000ag-Qf; Wed, 22 Nov 2023 20:46:37 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r5yna-0006Zs-8k; Wed, 22 Nov 2023 20:46:35 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ce656b9780so2815795ad.2; 
 Wed, 22 Nov 2023 17:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700703992; x=1701308792; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6phOSnyb8Nn7gEcfJK+tXWoRgAfrkXZ62NIbyHnHTPM=;
 b=Wgd0CFIbyj+07AXUOq2H2poLJLmWWWAycZNyWCL7uEqGuX6+soNfW4/3zorUlM+Ci5
 hlxiyGcERtbFvxfI6KhGKNBZ5k27AGJfBHTNealNH48kdbrAeFJ98Z3zU8i2kHLqZ3dB
 F8fx7S4SOVI0KBDNKZE95lNB5MLINi7z+XSNLYYZBbLy1DGaIKFDB9PKI7PlOETbtTNk
 d6nEzmGCAJYlOQjqCFB9RN3+H//Q5hQho87ZtPAzdRdqnVSBl/JyjStjE5ceOWpt5jo2
 W81VUnBM33z0on1c+i829TQBg3+Eear3y/NoZ39KP6E82Bsme6j4WRZvzJQ5/MZSNdhN
 WPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700703992; x=1701308792;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6phOSnyb8Nn7gEcfJK+tXWoRgAfrkXZ62NIbyHnHTPM=;
 b=UuHOlRMgfS/vkbnwIPY8YwpRZmeQptb9MbLqB9/nkfQIFfb5NXV78m3nnI/cIpVp9e
 e2+0zqUzAckvXfyPorPiCTAp49aZryj3DP6lhnsGH2ncRTGUpmKsBShO/TXwYqU71jFH
 w3psBbW5P4N5255nN6D2Mec497K9ja9R+lchJDDHBDbWT3fS1Evv8E/tJq6/nRgHQlOx
 DnFN3RVWYeFzN9jJpPEpxrS+npwegcTmUzYllYr9XpuP8ghnSJLqt8G1RH+8heRjfg7a
 Lsw1N6wT4eAGKzeZrQvZV2q3ZlXlkBcduwNCQHIYOhwWjcfYO2QfDWzn5RmQw+tpQHUn
 P0jw==
X-Gm-Message-State: AOJu0YwxeiKShQEI9ASzaPJPus8Me+CLnaPsNyFBmdKQTxuT+RgGu+Rp
 dQMzkQwllcX89ApqvPZh9S8rkimvwkw=
X-Google-Smtp-Source: AGHT+IHjM+bG97PD5VzcD5lbGcPByrVdznY+M57t6uim/D2kaotI9jAsaDhf0WmfuMS8h1TecE0IUQ==
X-Received: by 2002:a17:903:41c7:b0:1cf:6f1a:33b0 with SMTP id
 u7-20020a17090341c700b001cf6f1a33b0mr4503898ple.59.1700703992299; 
 Wed, 22 Nov 2023 17:46:32 -0800 (PST)
Received: from localhost (60-240-124-93.tpgi.com.au. [60.240.124.93])
 by smtp.gmail.com with ESMTPSA id
 w4-20020a170902e88400b001c452f827casm70230plg.257.2023.11.22.17.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 17:46:31 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Nov 2023 11:46:26 +1000
Message-Id: <CX5T8XIYBV15.2UGSWRFYQBHW3@wheely>
Cc: =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>
Subject: Re: [PATCH v4 03/11] ppc/pnv: New powernv10-rainier machine type
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Glenn Miles"
 <milesg@linux.vnet.ibm.com>, <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20231120235112.1951342-1-milesg@linux.vnet.ibm.com>
 <20231120235112.1951342-4-milesg@linux.vnet.ibm.com>
 <CX43Q4CXT43G.16NTWUAWGGXCB@wheely>
 <31af40b3-a6c8-467c-8ef0-63e370465a9a@kaod.org>
In-Reply-To: <31af40b3-a6c8-467c-8ef0-63e370465a9a@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

On Tue Nov 21, 2023 at 5:29 PM AEST, C=C3=A9dric Le Goater wrote:
> On 11/21/23 02:33, Nicholas Piggin wrote:
> > On Tue Nov 21, 2023 at 9:51 AM AEST, Glenn Miles wrote:
> >> Create a new powernv machine type, powernv10-rainier, that
> >> will contain rainier-specific devices.
> >=20
> > Is the plan to have a base powernv10 common to all and then
> > powernv10-rainier looks like a Rainier? Or would powernv10
> > just be a rainier?
> >=20
> > It's fine to structure code this way, I'm just wondering about
> > the machine types available to user. Is a base powernv10 machine
> > useful to run?
>
> There are multiple P10 boards defined in Linux :
>
>    aspeed-bmc-ibm-bonnell.dts
>    aspeed-bmc-ibm-everest.dts
>    aspeed-bmc-ibm-rainier-1s4u.dts
>    aspeed-bmc-ibm-rainier-4u.dts
>    aspeed-bmc-ibm-rainier.dts
>
> and we could model the machines above with a fixed number of sockets.
> The "powernv10" would be the generic system that can be customized
> at will on the command line, even I2C devices.

If a bare qemu machine could be useful, I don't have a problem with
it. I'm more thinking of what an average OPAL/PowerNV Linux user
developer would want, they (I) would probably want to use powernv,
powernv9, or powernv10, and just get a reasonable "realistic" machine.

The bare system could be powernv10-generic or powernv10-minimal for
those who know what they're doing.

> There is also the
> P10 Denali which is FSP based. This QEMU machine would certainly be
> very different. I thought of doing the same for P9 with a -zaius
> and include NPU2 models for it. I lacked time and the interest was
> small at the time of OpenPOWER.
>
> Anyhow, adding a new machine makes sense and it prepares ground for
> possible new ones. I am OK with or without. As primary users, you are
> the ones that can tell if there will be a second machine.

Yeah we will want to add other machines at some point, I think
this does make sense, my only real concern is what we call them.

Thanks,
Nick

