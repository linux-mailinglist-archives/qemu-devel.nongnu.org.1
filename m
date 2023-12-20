Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EE381AADB
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 00:12:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG5iv-00047f-5q; Wed, 20 Dec 2023 18:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rG5is-00047I-LK
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 18:11:30 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rG5iq-0003bp-NY
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 18:11:30 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3364c9ff8e1so773673f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 15:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703113885; x=1703718685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JR9Or84VI/iArODtrgjkhnO35mWfqnmv/m3z4Sr74T0=;
 b=bK9WvLjNQMeco1NDs5oOPOvohATKoAeXbS3s12VwrAeWiGd2QXWJ+88VFNG7SELmG9
 1hW0oTj6YxHcuHpgpV4wuqvyeuCXWiINivsHAfIpIIZ6HyCm9rIrw07IBtk5s+oUb0cf
 0Kj1FBAgdgq33R+dGrw+6zJ0a+qZREZVz8mAjVxh+n6D6dhNstpdO3iYQ+9wbpeKyFog
 VrLHK1pL6prEFBe5+ndkDFCPgb25Nm0sShkR6ArODYVIiMmvRalPF2An0m4deP9e7Lzj
 5/kORNkxk/WlHJ8h7U/Xxkea7ESFSil9QyDW02Fab5AELDgVmUo9sne1MErs7I37S3Y3
 ks0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703113885; x=1703718685;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JR9Or84VI/iArODtrgjkhnO35mWfqnmv/m3z4Sr74T0=;
 b=hhd07PIKApnUXpev3Y7MgJVwiYRGW8shHKgRR17u4Awe1T1P8fKAgwokA2qW3kHadQ
 G4i58zifaLoJ0j7GeUqb48A7xgZ3VSAx4SjHAkaee+sW2JLJqKsNijb46JvleKUoxWve
 p5rUheIa+HOQwLTHqfKC31g4HlX4O7JxxW4EY6DNTKFhYDJO+hzBnvUSqCRIgGMJTGc5
 llacBJUdhmdwfo1PGgOzQfzgCD0YgeKnLqk6iZlDS5Doolv5pDq69vvfrFLZoHcpwi+P
 KuuYajCpnElOTdzs8DAxcYOmetn/9P3256RkKLIrA19XbO3fBaVfvJqI0JWNYiH4IZ/C
 AkGw==
X-Gm-Message-State: AOJu0Yz77Y9wBsr8tzV2ux6wvGjY/+hUoCEeM83xAn8hr+WUbgxyQEDq
 63IcK6oqLYw8l5sicrb8m3k+Rg==
X-Google-Smtp-Source: AGHT+IFYVOh0hE0UYFt88mJsOAcphBUzgmoXiDDhmi7hlSLD/s9k100mbyJdn2s8lWvpwNUMvYHMqQ==
X-Received: by 2002:a05:600c:3056:b0:40d:28fe:aab2 with SMTP id
 n22-20020a05600c305600b0040d28feaab2mr181778wmh.81.1703113885606; 
 Wed, 20 Dec 2023 15:11:25 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h7-20020a05600c350700b0040d2e37c06dsm1038386wmq.20.2023.12.20.15.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 15:11:25 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F17D85F8BD;
 Wed, 20 Dec 2023 23:11:24 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,  qemu-devel@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PULL 00/19] First batch of misc patches for QEMU 9.0
In-Reply-To: <20231220160349.GA843298@fedora> (Stefan Hajnoczi's message of
 "Wed, 20 Dec 2023 11:03:49 -0500")
References: <20231220094105.6588-1-thuth@redhat.com>
 <20231220160349.GA843298@fedora>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Wed, 20 Dec 2023 23:11:24 +0000
Message-ID: <87msu41nc3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

Stefan Hajnoczi <stefanha@redhat.com> writes:

> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for
> any user-visible changes.

might need to change the template for that ;-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

