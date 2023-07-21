Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B6275C36C
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 11:47:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMmj5-00053M-IA; Fri, 21 Jul 2023 05:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMmj3-000539-67
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:47:05 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMmj1-0006Vu-O1
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:47:04 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-51e48e1f6d1so2314037a12.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 02:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689932822; x=1690537622;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0LkB4qAbX8qD6aPTIgZcKWZkBkaMQgVISUYSs7eRc+g=;
 b=f6K03DGWQORR3Q7W5DdiZ9NzvfT5brywfi3kpsivMcuqhBiDRQPJX3zlbs1W5LS4xJ
 HUQTkT9yq0ZGr1gHN3aRvx287Wr5wVjG5FFtK7RS0qmmr1tNKiTv1DUAg8jaZS5lzr7/
 X8ScBEtKUOb7PGejxb1yy2mJ0qd/akuzZy3d0tDe6hQBTEJm1nxhCr/WVIQTbvlWUwSE
 KBKUIhtbcgeoWiB2MOM5Q+9gSq4g2Koyf19cLcCNAQqxX8K3bnzq/+N41JZ5n986JzCF
 0YWiMFIzy5MhMCNM+GPOodhZjPfcyq03Tu0ZFc8ISoo15t+fPr90lMbF6Y4Hzr+S/I1L
 AUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689932822; x=1690537622;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0LkB4qAbX8qD6aPTIgZcKWZkBkaMQgVISUYSs7eRc+g=;
 b=angC/GRxYdXxo+F5XqN3yGYW2kZI5K5sPwgXkkDeI6b6jgov4llXFaJbc9HsGk5qN0
 giBpHLlaGGvkVHB65RChQoAwPRJYxsdvgnli/jf8RcYAwuDRrXu2Hw5T1FBPvXRx3/in
 5XGI/cxZL9DW8Qtx0fUd27ig/EHAuqaqaMAC0ZgYQ9+N5BCU+9VW2e3lW4tdnhMej99x
 t/NquQRa0MItJ9vZ9QPy4SWSw9Zt1sK6v4en1764l6ck1CDqLd1gj985xtM4uePNi2DJ
 lplXAOxmGWTc3z7082ozLVmogm77RgsejX+ffGZAivYTob8xZqMoJBlX9mQCcQvk5oOx
 qe5w==
X-Gm-Message-State: ABy/qLZiP6HSA1njQmXbu782PgwaO32Z6M7HkbQgDCLBk4FgmBQ+RBRT
 /Kbw0eOYTGcX75IUuBTtTh98tNh87lH7HIqonF4X8w==
X-Google-Smtp-Source: APBJJlH17VaE2892AeDjVINmTckUjHMVJ7c9h8zvP9SQx3lRLoQcQzRfR0XPNgXCag48hhkpSV4z+UBM8xAbr3jLo6s=
X-Received: by 2002:aa7:d80b:0:b0:51e:5ec8:d2f6 with SMTP id
 v11-20020aa7d80b000000b0051e5ec8d2f6mr1059350edq.25.1689932822192; Fri, 21
 Jul 2023 02:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230720155902.1590362-1-peter.maydell@linaro.org>
 <1d7fc618-fb10-4990-dbda-5fd610655a66@linaro.org>
In-Reply-To: <1d7fc618-fb10-4990-dbda-5fd610655a66@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2023 10:46:51 +0100
Message-ID: <CAFEAcA8MuzfV2cREitZ4uJGQVAQut-8r_M_xd4cpmUdv+HZjVw@mail.gmail.com>
Subject: Re: [PATCH for-8.2 0/4] rtc devices: Avoid putting time_t in 32-bit
 variables
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Fri, 21 Jul 2023 at 10:16, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Peter,
>
> On 20/7/23 17:58, Peter Maydell wrote:
> > This patchset was prompted by a couple of Coverity warnings
> > (CID 1507157, 1517772) which note that in the m48t59 RTC device model
> > we keep an offset in a time_t variable but then truncate it by
> > passing it to qemu_get_timedate(), which currently uses an 'int'
> > argument for its offset parameter.
> >
> > We can fix the Coverity complaint by making qemu_get_timedate()
> > take a time_t; we should also correspondingly make the
> > qemu_timedate_diff() function return a time_t. However this
> > will only push the issue out to callers of qemu_timedate_diff()
> > if they are putting the result in a 32-bit variable or doing
> > 32-bit arithmetic on it.
> >
> > Luckily there aren't that many callers of qemu_timedate_diff()
> > and most of them already use either time_t or int64_t for the
> > calculations they do on its return value. The first three
> > patches fix devices which weren't doing that; patch four then
> > fixes the rtc.c functions. If I missed any callsites in devices
> > then hopefully Coverity will point them out.
>
> PL031State::tick_offset is uint32_t, and pl031_get_count() also
> returns that type. Is that expected?

I think those fall into the category of "the device we are
modelling does not support 64-bit timestamps" -- the PL031
RTC_DR register is only 32 bits.

thanks
-- PMM

