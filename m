Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5DF92E9D7
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jul 2024 15:49:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRu9S-00087S-4o; Thu, 11 Jul 2024 09:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sRu9G-0007cH-QC
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:47:52 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sRu9C-0000B9-W5
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:47:49 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a689ad8d1f6so107924966b.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720705663; x=1721310463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kUrSSPRlly26tyRho86q2Z88VFLS7LA7muzi/OiTP5E=;
 b=uCq74hQb4aWgy9WPDvLtKpJd7xaCdALGpfx/pfSUYhUYIvKsh5jSgvqylcN1Eel1Wk
 Er2tMDQ6Vmw14+iLwdEFQavkw5nJUkGOEf0n7rQRFLgQHyiuyFex6I1ffBBMIGbSwy/g
 4t7+CQEdHVm8JFyqhZwY/QhSu2A0P01uMv6pJOSI11e33yN2i4octHSMqXT9SDchy3iH
 AvoSQRRlEM72Zv38Pp2FLqcyen+qeTZCr+X+roL/nBUcdwDq+OPbUAskS7Vvbqo5f9us
 906lkt9XBqOeFBa4wjzgrMVn/4gprrPgVyY1S2mRx8rJl1srtex+FrpVdRIrns8Ygg3Z
 SBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720705663; x=1721310463;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kUrSSPRlly26tyRho86q2Z88VFLS7LA7muzi/OiTP5E=;
 b=tTKj5pknrkcm4XbXZyHF2HNkZE9DpHLxJLYrEy4MXSrG3AgILi/qqwnqYMpNLCY+pU
 7hPfM4PwpZITyQS+iMaa69GJlUiCULTVfo7NVrgBpSB/vECBUIeCF8l38EVukag6WYpP
 nUQvvcST6zHZaCmpfl4Kj8rC7H3bTXXTVFJEFT2JKFLc6y8IZOWGJCL/Jlu8yB97Dyhh
 1NK1gYyB1mAzehZEV24t3z3zJdvs4pPUX8yp2VZTKJKwyYemg4Te5zcRRKZd/zi/ezLk
 4M8TFMtjTuO4r0F2g3KH6f+ML/6K2F0UFjdXHQc6ajmHsGEAz9t22QUhoX57o9tnNuNH
 g39w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJdxlVoiUfhrZqAH++Nv57dgWCYAFbeEBC7vPXW8ATsKWppwfoXWpRxetxqAk+LbBYj1vWNNBceksXoXvpjHPL//WHdx8=
X-Gm-Message-State: AOJu0YxobThY8N3vRHCqWXvkmXVi83pb0kzQgmQBseSbKkOXiaULJakc
 P8zHO71xSf49wsY8wRtym/4v459ZkMuP6isBqHlebCHwYfs6m6b5J0PYnSlXK20=
X-Google-Smtp-Source: AGHT+IFMpqSyVesc23BvgOk3++QP5kSHZ4FVF/On67VZbK8Nde/HdIpOkexnk2d8c1NQDssEh9iA4g==
X-Received: by 2002:a17:906:5ad9:b0:a77:cf09:9c5f with SMTP id
 a640c23a62f3a-a780b6fe88emr602436566b.37.1720705662772; 
 Thu, 11 Jul 2024 06:47:42 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a6bc57csm255255166b.1.2024.07.11.06.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:47:42 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 642775F79A;
 Thu, 11 Jul 2024 14:47:41 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH] tests/avocado: Remove non-working sparc leon3 test
In-Reply-To: <20240710111755.60584-1-thuth@redhat.com> (Thomas Huth's message
 of "Wed, 10 Jul 2024 13:17:49 +0200")
References: <20240710111755.60584-1-thuth@redhat.com>
Date: Thu, 11 Jul 2024 14:47:41 +0100
Message-ID: <87bk34qbuq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> The test has been marked as broken more than 4 years ago, and
> so far nobody ever cared to fix it. Thus let's simply remove it
> now ... if somebody ever needs it again, they can restore the
> file from an older version of QEMU.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

