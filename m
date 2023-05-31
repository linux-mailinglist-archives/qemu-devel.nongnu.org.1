Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C015F7187C6
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 18:51:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4P1e-0004Mw-SC; Wed, 31 May 2023 12:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q4P1J-0004Ha-NM
 for qemu-devel@nongnu.org; Wed, 31 May 2023 12:49:59 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q4P1I-0001KV-6D
 for qemu-devel@nongnu.org; Wed, 31 May 2023 12:49:57 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2af1822b710so66032581fa.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 09:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685551794; x=1688143794;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qeVUxHhJUoMvN//JSF/0qLTCfXgdwXXHdn6/R9WVoAk=;
 b=EiuupOFQKC2aQ/Je8RyRN9OmA6OqAKyfo+FJ92VBYOUt/hETzwVEvAvKRv2kisrUQL
 SqVLr86zEKLX15MuYgyMSonA13zoxQdwLegnM63q0ZdPqQ2v5CxWeer8wQb0W5MbOL7O
 79rqnZJv0zW+9Di+Jii6+i1/JlD8Gg2wuWgEFkqJDJTiJevI3eXcBLlvMT8O9xIDDYSv
 qIyt/EPQ9ERmAbv9QnIRrwGF1NgGM6x3Qc8cMpmZkfEQ+APleKlYpMFWEEUZYkAfn8fz
 pjdoH47+Q9WgWhkbIezasXDiNqUGHMFrRwQAK9qQXSkI6l7/AK+MN7aOTc/AJc0KB+vL
 YAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685551794; x=1688143794;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qeVUxHhJUoMvN//JSF/0qLTCfXgdwXXHdn6/R9WVoAk=;
 b=l29pS1+OMkKtWiFojyb8yrN/AYMnvVd30VMe4Tvedv6opnulRxAdXf/GlDO6fS88WD
 c8Be8hCgYGEg2KBuMT/HmuJwTvo+szDN8mit7aeEt1rMUgBLeKgVHGFrbW4btMygTFFe
 eBoypCSkqfkm2hjRKS1TaMakz+Vyg4B7NqV9S69+oXZxjdhzpNkCSqi7JLs6YUmAHzAO
 qPMqtMJVbfAwkXG9GHiHhUyc0441OA8S3zngNJk5kSx++WTAcvVpq4xcWni0TuQuxft9
 6PqrL/D7jlosrixokuYZv2uQDXLc748lu8CciPcEH58WnW+GaySD67Qq0yEcs/N2yVPl
 zhpQ==
X-Gm-Message-State: AC+VfDz/oGK/7yxiuVCIGOw3aoq6110rG57qeX3O8uqhnAY4bue0kISi
 uECx2kEQQnWmwVPIldNexytz5KJ/wqsuvR0phbUEew==
X-Google-Smtp-Source: ACHHUZ6c3p5b0O5ZQbDxyluPYd5iY/QER3xWHgbSFIld/Ff+SriO6mNv1X+hQDXa7klFLiniDA/De0N9Mh5WLIaGSBw=
X-Received: by 2002:a2e:9614:0:b0:2b0:626e:e90 with SMTP id
 v20-20020a2e9614000000b002b0626e0e90mr2932525ljh.36.1685551794212; Wed, 31
 May 2023 09:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230524191438.172019-1-sergey.kambalin@auriga.com>
 <CAFEAcA_PH8yAT28s3p7_0rqK9NodJ6gTXxv63J+98XoMQ_nJTg@mail.gmail.com>
 <15c444063e114814807551c36ea3389b@auriga.com>
 <29192acf-0876-e14e-1331-45260cb179c3@linaro.org>
 <49b0ba578bfb45f1be23f7608845d823@auriga.com>
In-Reply-To: <49b0ba578bfb45f1be23f7608845d823@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 May 2023 17:49:23 +0100
Message-ID: <CAFEAcA9NkQ_nTEaxiFfKHpV_Td7TQrPc50ysd8g-u=0m7J9Smw@mail.gmail.com>
Subject: Re: [PATCH] Prepare bcm properties for videocore 4
To: "Kambalin, Sergey" <sergey.kambalin@auriga.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Sergey Kambalin <serg.oker@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
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

On Wed, 31 May 2023 at 16:47, Kambalin, Sergey
<sergey.kambalin@auriga.com> wrote:
>
> Hello!
>
> Thank you guys for clarifications!
>
>
> > Are the VC4 properties supposed to be present on
> > all our existing raspi models? (i.e. is this a bug
> > fix for our existing models rather than stuff we only
> > want on the new raspi4b?)
>
>
> Yes, they're needed to support RPI4 work. And I think cannot be considered as a bug fix.
>
> So I'm going to send one patch to replace the magic values with named constants.
>
> And then I'm going to spend some time to slice the entire rpi4 machine to series of small patches.
>
> Am I understand it right that each patch in the set must pass all the tests?

Yes, that's right -- every patch has to compile and pass
'make check'. The usual way to arrange this is "put the new
tests last".

thanks
-- PMM

