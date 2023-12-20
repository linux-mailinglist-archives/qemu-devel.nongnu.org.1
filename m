Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D510D81A649
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 18:27:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG0LX-0002rO-1d; Wed, 20 Dec 2023 12:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rG0LT-0002rG-Sa
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 12:26:59 -0500
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rG0LS-0000X8-AH
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 12:26:59 -0500
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1efabc436e4so3759017fac.1
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 09:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703093217; x=1703698017; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zAiF5hYSs3F8RSRZwP6gTZyy98v0WJH72DlAju5SHk4=;
 b=LSpdat0fTp0YNMlQi5ZXn1QfkEAbheDapPjenYxLD9ogzFuh4Ty7rPX2nIZfnNkqBS
 UYYEBxtYMsl8hEW+UJqb0y+RyaZe3mH9Wy3Jf/f9ajmWp/phaD6dLCm+qRIo2DltdiY4
 S76vOeXtWrM1l4TCsJW4c91yKPQsMxWCsxtMKHK1APWARbRGHS2OcRqTRCtq00ZhrqEB
 kFZ3htYjdmgMr8k3oy9CPUqdcCZE9Bry+sFHDJ+lQ02vmD07gNmf/XZBWj//bfy+owFv
 cebaO3tfmDLiYalafxEeYwuCCfC7j2R7hKPnZsOVqAWcoWioUb0MkqbTiFzjchxrQnrz
 xjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703093217; x=1703698017;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zAiF5hYSs3F8RSRZwP6gTZyy98v0WJH72DlAju5SHk4=;
 b=luTrR67OyD4Y+L+wbUW//9afqBN5iNztSwWGVeqzOsbbDNy2+v++MwXUnfzPPoXHTY
 /431k4dq5Rt5FZPTloSrRma4UeotxyIVIYhkNSp2XGsQv0Eb0Mzix3psTw405snex4BT
 ZIRM3CYssEp4sExNL61yR8oSvA42TvCI1wsoHA7uB8Pn6Gvkt0mwC5iWyOCT7u1CrPA4
 UjZQsL9PrvrqhetMNolfBIaKYd3m14pykf6xRGkdQ/DGO3K5Lss437E4f9h/nzECK8I9
 xTYMSJhwR/R6Gtr440ZB/pi/3UZFm4xw2Lk8DZH0vZjCymkSiyCTx7FfYLfhAO2zkPKR
 IGhA==
X-Gm-Message-State: AOJu0Yxi9p3wcJ2kxxHs1oNoYbWXPD79rzHPQng1jSVUTr6ual+3/DbE
 eWLXJR5C+Jgl9DYhYrEUN7xB0sjEgO2oy3LJyG8=
X-Google-Smtp-Source: AGHT+IH7p6r8CD0HX4pikL4GOuArHyOjYhm79wYE1NgpbI62zx1tmhSg0YNKsPCGTlKdMOBf9m/Hz2mvrkExCtcdmmQ=
X-Received: by 2002:a05:6870:8a09:b0:1fa:1d14:2a43 with SMTP id
 p9-20020a0568708a0900b001fa1d142a43mr76857oaq.24.1703093216912; Wed, 20 Dec
 2023 09:26:56 -0800 (PST)
MIME-Version: 1.0
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
 <20231220160340.GA843272@fedora>
 <CAFEAcA8+Cw5NcH36GSydLyYf9_=CmP5qeyRsTHYyxYXKLEth_A@mail.gmail.com>
In-Reply-To: <CAFEAcA8+Cw5NcH36GSydLyYf9_=CmP5qeyRsTHYyxYXKLEth_A@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 20 Dec 2023 12:26:45 -0500
Message-ID: <CAJSP0QVT=euMVjU4eF+3XmkX+1XBPTUCBAypqyRDL+B-51nO9w@mail.gmail.com>
Subject: Re: [PULL 00/43] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x2b.google.com
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

On Wed, 20 Dec 2023 at 12:24, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 20 Dec 2023 at 16:03, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > Applied, thanks.
> >
> > Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.
>
> Should be https://wiki.qemu.org/ChangeLog/9.0 :-)
>
> (I have just created that page and the accompanying gitlab milestone.)

Thanks, I'll update my reply script :).

Stefan

