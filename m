Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B867E4939
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 20:34:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Rp8-0000A6-PO; Tue, 07 Nov 2023 14:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Rp6-0008S9-MU
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 14:33:16 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Rp3-0001cD-8E
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 14:33:16 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2c518a1d83fso79980821fa.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 11:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699385590; x=1699990390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8r4KKu3OhUI+tOiGHep7NTaG61Ad43KXEEqu7xNh1wk=;
 b=hbWx6FzdoyUeRrosTJBj6/fJZptkQb2lu2P8Zss/ss5ZsV5DfWRYg5rdH1pVzvSYjM
 I0q9CWFjr/nIWWAeW+zWoDhsROQB2K3bUdJUYbEbCen3Soe6Za0in9ewoN3ycGuqW7jG
 yIZdo3t3b2tIhuh9V46QkL9zicf6KkkIRQ4NElWuh/XNmJmZ+UvPEHi61ydOV2GEaJDS
 fwRgBDqQKpbLTa/WtbvGsMXVUWQdAqxVKLF0zyI/m2Iu9S/Q8SQdEEwz/cLQ2h9wtlAo
 xPRdiVP471QDRrsYM+05sEauFFKkXM/ULSSjaMzY+B0EiT4rRasLSPgEYMdrOcFw2SVL
 NneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699385590; x=1699990390;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8r4KKu3OhUI+tOiGHep7NTaG61Ad43KXEEqu7xNh1wk=;
 b=l+kMY/TUFftZDPKgHkKFtjwInovBO9WlamtQgA/8hgb4bkBzOQHzkYXZGEMLk1V389
 nsHfMzvN8FLCkWE7R+9cbWKiPoiIccFaGyMBgqe3FLeO1bCglmLs8AEAGzo8Qyn1jzQK
 Smjm98s5579KAnq0lF3eyx2gyfc1VTbZU1Ww53jEtq38OayBvlE1IUWUl8werA/L+h7F
 Ph0KekKeSPMuE47d8LhAtcrMmK+IkWQD9LR8E+NFkqO3Wu3dE+poGOdnHUFEF7uVsY7b
 FBrl39mMwLeIkChYSNmz67ztYQPv/txr7bneZafAbjL2JdsvMeRPr3BuQa6ONPAIxhp5
 usKQ==
X-Gm-Message-State: AOJu0Yz50h/hovoY4RYXoUKuozSMWDAc6fygzD7LbsXfqssvwip5DaH4
 0AtMf5RVQXw1GXevYu89wEKUkg==
X-Google-Smtp-Source: AGHT+IGQIC8uvG17NWVzcPpTkgArLqw81b+D+hUb/IGVVrF7eMEAOAdNRLiDXjxY3j66VQ0CtN6a2A==
X-Received: by 2002:a2e:9992:0:b0:2c5:4718:5d45 with SMTP id
 w18-20020a2e9992000000b002c547185d45mr23585883lji.52.1699385589999; 
 Tue, 07 Nov 2023 11:33:09 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 k8-20020a05600c1c8800b004081a011c0esm16757425wms.12.2023.11.07.11.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 11:33:09 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 258F45F792;
 Tue,  7 Nov 2023 19:33:09 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/audio/virtio-snd-pci: fix the PCI class code
In-Reply-To: <20231107185034.6434-1-vr_qemu@t-online.de> ("Volker
 =?utf-8?Q?R=C3=BCmelin=22's?=
 message of "Tue, 7 Nov 2023 19:50:34 +0100 (42 minutes, 23 seconds
 ago)")
References: <20231107185034.6434-1-vr_qemu@t-online.de>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Tue, 07 Nov 2023 19:33:09 +0000
Message-ID: <871qd1bbpm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x236.google.com
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

Volker R=C3=BCmelin <vr_qemu@t-online.de> writes:

> The virtio sound device is currently an unclassified PCI device.
>
> ~> sudo lspci -s '00:02.0' -v -nn | head -n 2
> 00:02.0 Unclassified device [00ff]:
>  Red Hat, Inc. Device [1af4:1059] (rev 01)
>         Subsystem: Red Hat, Inc. Device [1af4:1100]
>
> Set the correct PCI class code to change the device to a
> multimedia audio controller.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

