Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4992075FEDD
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 20:14:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qO03T-0008F0-Ps; Mon, 24 Jul 2023 14:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qO03S-0008Eg-10
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 14:13:10 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qO03M-0003rZ-H0
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 14:13:09 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-522382c4840so1319458a12.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 11:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690222382; x=1690827182;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+227PViN0ug7YVxtVos43701aiOw82RZN1byFUnHUPA=;
 b=RyFP1JKSfkRH7+il55ZuR61vkEka2jYtItaeLyejRikUsD2kh8V9bhEXaub5e9ssnH
 A3q3KyRfcsU1bvP2Trxw/HeFzh3SfRarc1vr1Bucl51rB49f4OqJt88bYhbirJNbyu6q
 gjh8z3Rd4pw8sxpjRNHumh4F5FGAlnAQI/Uo5m9YCLW9qjGHC2I1outxMMF37iZM1IRI
 VCVOcGdkvV/DBjs2+fDChNWt0iwk7D31d580FVUGfhaWHWvr/AdFeK9n9BQ0VI6TY/y9
 ByTdA9Uax+EXgdT6tq0E1NBycdE7W9S9ZdI2pFsyO5Y/auEL8CdzgMgynyHh+p5v/h6I
 l/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690222382; x=1690827182;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+227PViN0ug7YVxtVos43701aiOw82RZN1byFUnHUPA=;
 b=OIJP/YL/OW4XTWbhFqDtz8rRMWhnhBYs2KXeDVYaAoTtGNSh4P1CNgTW8LogG9Y7pN
 acwA4Ou0VCCoNSsrlM/JnXduBVRYynnY6ILYmvsDvGWrS05FwFjZMbH8rTvizMQblEOt
 nLuuAZGtq1NOqH1sSPN7Me8zniChcPr7JStM17J0loAtOnnialZT8t+DHydH5WzS0nHP
 nWj0+O6FsnaHf6OJUw4gmXuDc9KrJ/OomtKjFLHmdY484a3G6WfYaUnaZOF6f8FDCuR+
 c13boFnVMjJ20wcdeUZOdRmASd3UP8koMuYUDl8trTTyxkclCDfFqWuYpbPiDtkcrR+v
 CXXQ==
X-Gm-Message-State: ABy/qLa0RO+coTIDHsjixNrT02uEhQEUhcm2GLtmUYbx1okQ4pl+dcRL
 PDQCWyv0Y5zzyPuESizS5xGxC+al/bsaYgFUBUb7FA==
X-Google-Smtp-Source: APBJJlH65wWoCG67XOxBh6tO39dzAYpOYzp4YE2rdJSN3NJAjExl5+ah1eOm+g9xnfpvEALaFOQmApjM9G6jOBGWOkY=
X-Received: by 2002:aa7:d453:0:b0:51d:e3d2:f5eb with SMTP id
 q19-20020aa7d453000000b0051de3d2f5ebmr10495757edr.5.1690222382454; Mon, 24
 Jul 2023 11:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230724170755.1114519-1-peterx@redhat.com>
 <ZL69LTVHhNzEjqGM@redhat.com>
In-Reply-To: <ZL69LTVHhNzEjqGM@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2023 19:12:51 +0100
Message-ID: <CAFEAcA99vSMPLLJQ-2C52cnwMznyRTCfTk+HpiA1w1cASWWLMg@mail.gmail.com>
Subject: Re: [PATCH] migration: Allow user to specify migration available
 bandwidth
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Chensheng Dong <chdong@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 24 Jul 2023 at 19:05, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> I feel like rather than "available-bandwidth", we should call
> it "max-convergance-bandwidth".

"convergence" (I mention only since it's a proposed
user-visible bit of API :-)

-- PMM

