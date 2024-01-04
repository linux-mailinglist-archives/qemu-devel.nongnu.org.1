Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F9F8240C2
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 12:37:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLM1Q-00015V-Ka; Thu, 04 Jan 2024 06:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLM1N-000148-6n
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 06:36:22 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLM1L-0006Zb-Hh
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 06:36:20 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55559e26ccfso523368a12.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 03:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704368178; x=1704972978; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JiqQFbCtgVfu5KxzxBNsgCQ4UrsbDGzvfy3R3hTLeQg=;
 b=rmqSPoPTAqbKJIFwDC5MgkYMr/iwgOWVqoV4cozO5YUAONRpt8QlzG6KhO8kaJH/O1
 QqOygdjNt0tYgvZtdysj8xMBcbjTQwxZED+Nw9uOkKF7dP39im8CQLAQ1pJng6eXdr3j
 BX52wiLEDitPCD1CbeNXwXwvMjK3WL1aLkPyyOD2Jrt+llfrna5PDh0F2mQtr+RQryxJ
 7VczhvjCQQVfcBmaJKSsndPG4WPN/ldfnkuS56cWrEWMUlkqxmb3PX97giHupeqSfFNW
 Np11q4eOvpcGWFOSY2Q5AgXUgn0FMQ8DB8W4mD5w1jn4AwxT75WV3xC+XJ9OoGuCQY1v
 gZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704368178; x=1704972978;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JiqQFbCtgVfu5KxzxBNsgCQ4UrsbDGzvfy3R3hTLeQg=;
 b=H/ZUH0psNbkDCeyFcKfDjqZHbOuFrp3K3GsVaGBxP/adbR8tShLETwqkZBO4TKWRI+
 +jQYXhoMdZJtK5hL7p8Q+TfpsVBWWoldpc7uXuCig9YN6vTLpRnaGtx+CrmCSLjSNW9g
 ZndrdSL2Iu7RQCrMe05bojeFah5AprJe/Ek6T7aPRRKlUP1f5U9/fFSKyCswb4zrJiTN
 OSpWbw5ijGucrBTHfVK8QOyN1NWKFhsIfb/E0K65dgUvrV7irI+F3WvHVFQl1rXWEzO6
 tlOF8/1SgE6vBCdc9byYT9yhWjC51CfrdibVdhU5Y4c+CSIcU8cvP0yy+6nc3lLCdgpV
 Kpuw==
X-Gm-Message-State: AOJu0Yw9bZ1pZIKEihXhhAn4mpDJ0m6JVQQ54WTslzAifxWDADoR+jgJ
 DHZQt48K1TveJ7kds1nadiM3PUVucZuL+89nz+ymL1r2vfdNTg==
X-Google-Smtp-Source: AGHT+IE8a+4QXwpP6g/nRtw2HRXo5RtOA0MVIpVl7zrXTpYktgbhXLmmRASPeW6Sku25UF5z9oFvPNlD+QEn9diJY3c=
X-Received: by 2002:a50:ab5a:0:b0:553:83ca:60c5 with SMTP id
 t26-20020a50ab5a000000b0055383ca60c5mr189382edc.3.1704368177873; Thu, 04 Jan
 2024 03:36:17 -0800 (PST)
MIME-Version: 1.0
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-22-peter.maydell@linaro.org>
 <b411a3d8-9ae9-4f99-8a5f-4b3f29b10bce@linaro.org>
In-Reply-To: <b411a3d8-9ae9-4f99-8a5f-4b3f29b10bce@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jan 2024 11:36:06 +0000
Message-ID: <CAFEAcA-9-EnybYA-hZ=kzeauRFcS6eB9VDD8DSGqUiN=9NZprg@mail.gmail.com>
Subject: Re: [PATCH 21/35] target/arm: Add FEAT_NV to max, neoverse-n2,
 neoverse-v1 CPUs
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Fri, 29 Dec 2023 at 11:37, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> W dniu 18.12.2023 o 12:32, Peter Maydell pisze:
>
> > Enable FEAT_NV on the 'max' CPU, and stop filtering it out for the
> > Neoverse N2 and Neoverse V1 CPUs.  We continue to downgrade FEAT_NV2
> > support to FEAT_NV for the latter two CPU types.
>
> According to Neoverse-V1 TRM r1p2 it has FEAT_NV2. Similar with Neoverse-N2.

I'm not sure what you're trying to say here ? Yes, the V1 has
NV2, that's why we have to downgrade it to FEAT_NV for the moment
when we're emulating, because at this point in the series we
don't have FEAT_NV2 emulation. At the end of the series this downgrade
goes away, because at that point we can emulate FEAT_NV2.

>
> You wrote already:
>
> > in practice hypervisors such as KVM are going to require FEAT_NV2
> > and not bother to support the FEAT_NV-only case, so I have
> > implemented them one after the other in this single patchset.
> So maybe they both should be FEAT_NV2 and FEAT_NV will be left unused.
> Or enable FEAT_NV for V1 (as being older) and FEAT_NV2 on N2.

As usual, we emulate what the actual hardware has, to the extent
that we are able to. For both of these CPUs that's both FEAT_NV
and FEAT_NV2, and we enable emulation of each at the point in the
series when we've implemented it.

> This way if someone wants to test nested virtualization then both
> versions will be available without use of 'max' cpu.

In theory it might be nice to be able to emulate a pure FEAT_NV
CPU, but in practice I don't expect anybody to want to do that.
If anybody has a real use case for it we can add a -cpu suboption
later.

thanks
-- PMM

