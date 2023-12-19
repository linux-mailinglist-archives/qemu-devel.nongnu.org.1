Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47473818C76
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 17:40:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFd7z-00043U-NH; Tue, 19 Dec 2023 11:39:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFd7x-000419-3p
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 11:39:29 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFd7v-0000xD-LI
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 11:39:28 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5533ca9cc00so3928930a12.2
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 08:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703003965; x=1703608765; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zNyVUwo9s2DMl7y4XkvCvSPyuJ1m5Py0Vme19chLdcw=;
 b=qFzyF6/85dnfs2CL/+E7h89CO4kV+O1HFdjBPEEYqan3U6ilRivexzLULUMYWl5YCr
 +UX8x1jUigPpiBvARXFka6QDfykqtycPLXFWYDPwsfKJS6Y3jcoUb0kVfFkkDeDuEJbp
 Qm1BdkMMjdvG5qOFayFrIlKCY1EdXnY+3EAhvJynL3AHoZdEMy7QzJSrFnD6EOkaTGKd
 1LG4V5QsFdRuzz9s1nEFzkDbz2xG0kGnSyjqDBOz9jIrendVhWQ6Jomobx8nWzKmE3Ur
 6dXJuXv3w9TpnNvsrshJpIBvE7VMQwe58yT07XFSTjhOBRZTlHmJbiDCsfdGHa2CD6la
 D00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703003965; x=1703608765;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zNyVUwo9s2DMl7y4XkvCvSPyuJ1m5Py0Vme19chLdcw=;
 b=psJIrz8BrKWubKr3PJidhdSRG3V9MEum/QK9heMCLdy3Jvb0zwNXEHxKxeFzeqGVpL
 AHctOcA5PIVdQDBZt0Z3nr+1EPXfrpPHe/JUKr5H9bZ2UjH4aHN/tKmGT34xY9n6KXrn
 hkTGp5FuMcOUvz9n1klx/bnLcXsaOD/X5fsCAj+KY0Kh8MO971chShRN+nnADxqxADm7
 m9JI7kmnuFaPyulkBtuiqSp0LtKEpbgmQJh7Qr/wRHiQLT4LWBtXaqRluLt54HX4mclQ
 /2ld5b6sVA+0KDr6oDQfO3mrwVivh7aIF0SN1IomAQWnMIeZaOT6hdiskwcnqh0troNg
 /VSg==
X-Gm-Message-State: AOJu0YytMirvm/P7KHjN0BQRikkrzFpXiNC2JIzNgZKPuDetrpmZ/2yG
 EW03Z2u60k4kGDnZWgR3T1k7l1aLbPrX+wYB76xCUA==
X-Google-Smtp-Source: AGHT+IHCyrbCO5m8k6rvvaaz5BC6j/n4dlzgbpnnCJnrJnYkJGBBZNR4BTBcuzYEDwrUG9PX5CfYtreZpWa0OtH/SKg=
X-Received: by 2002:a50:d6d8:0:b0:553:37e1:a5a with SMTP id
 l24-20020a50d6d8000000b0055337e10a5amr2527035edj.40.1703003964875; Tue, 19
 Dec 2023 08:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <CAFEAcA_9yO8kY=fnT8+vn2AFtjyoJN25B4o2tcegaOxS41qhmg@mail.gmail.com>
 <431b825b51524907a3168007fada20e1@auriga.com>
In-Reply-To: <431b825b51524907a3168007fada20e1@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Dec 2023 16:39:13 +0000
Message-ID: <CAFEAcA8QHVy2xYYMxxO3TzLeUWk5AGcq4y6mKvXun02UayBzpw@mail.gmail.com>
Subject: Re: [PATCH v4 00/45] Raspberry Pi 4B machine
To: "Kambalin, Sergey" <sergey.kambalin@auriga.com>
Cc: Sergey Kambalin <serg.oker@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 19 Dec 2023 at 16:18, Kambalin, Sergey
<sergey.kambalin@auriga.com> wrote:
>
> Thank you a lot for the review Peter!
>
>
> May I kindly ask you to take just a brief look at the first patches of GENET? I'd like to know if I've chosen the right way to replace bitfields with  QEMU REG32/FIELD32 macros.

The FIELD and REG32 uses look mostly OK, but the
second argument to REG32() should not be 0 each time:

REG32(GENET_SYS_REV_CTRL,              0)
REG32(GENET_INTRL_0,                0)

etc. The idea is that that second argument is the offset
in the register file of the register; then the macro
defines you an A_GENET_SYS_REV_CTRL which is that value,
and you can use it as a case label in the "switch (offset) {"
in the read/write function.

I'm a also a bit confused about the use of offsetof() in patch 27.

In patch 28 the implementation of bcm2838_genet_read() and
bcm2838_genet_write() use a memcpy() between a local variable
and memory which I'm assuming is an index into one of these
register structs, which won't do the right thing if the host
is big-endian. If you need a "load/store N bytes to memory in
host order", we have ldn_he_p() and stn_he_p(); also available
in _le_ and _be_ flavours for load/store in specific endianness.

thanks
-- PMM

