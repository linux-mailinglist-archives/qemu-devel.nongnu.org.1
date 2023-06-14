Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D2F72F3B9
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 06:46:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9IOl-0007Dg-3Z; Wed, 14 Jun 2023 00:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivamvijay543@gmail.com>)
 id 1q9IOj-0007DW-0g
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:46:21 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shivamvijay543@gmail.com>)
 id 1q9IOh-0003hr-Dq
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:46:20 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-97454836448so43236766b.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 21:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686717976; x=1689309976;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=h2KHN6NqPlhKM3foE4/pD2p26P/ak1DI6Bm08RWkE68=;
 b=suhvOEL3fhYvcnOWk4WVkdjIBZy8y9IPDxAb9H524jMiFpR91doTZMk9bF6MtrdXEB
 +bXXlb2BnteyaM4ar9X+OjOovIt1g8GI5o2BWD+VV9TGJdZKcLifAwbAlGMuc2l7bWPl
 MCEwz6Zx4quXclJ8hcnTHcFK/aoEsk+20KIjW5IuPvkkuBbJ1IzDlfzZISU4pT42xo/l
 7z0+ymRnCzryE8/hYDp3kBaqsbMeCjQZ5uMYe4/wM1gvWR0Yx/iWN0Vsh2HQXWJRR04J
 hY2ZFiZUaUR03nJ8d0Jqz9hOoAVgrF8yuNDhROBcUirOZ23aOA57z+goCJ0KgOG2O1+b
 PmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686717976; x=1689309976;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h2KHN6NqPlhKM3foE4/pD2p26P/ak1DI6Bm08RWkE68=;
 b=R8DWKlOSeN8vwITU1h3yT8VxezIcK9SkOEA9dPfezKJx1ALrcKRY0Zxgmj9sXJgetN
 +zTE2OgZL6egYOJPfzaODJkgM5hwXZnAduh2xsbG9HGxKNPCTqQTUdDv1Jgt8LhFLaBc
 R/S5AyfcJXucpvgbWu+ttkaFXRXIc5CrHNmskUaWu+oYPJqrJWlIa1SVEEa/0mO6oLu9
 +ES0JYEZnYs0MXmagE9QLPXll7lo6v6fO/WbO3i1g+ONoaKMfbs1+fN01Wrd2K0RMH8F
 gmRFxoHPNvnG1FY3aWNI+rijikfbZ7MSj0CZSz/hu3TvKUxoLnWsX9vL6uGwFRK3dfdv
 VdKg==
X-Gm-Message-State: AC+VfDzaF3hPIX1XOse1/wXAB/5koCMTsiWChi4MLtQzaB+q5z9XxJ+C
 we9lGSJotVpryASGr3ONdQcTS6yoXNsvpk6+kjTgH1Gtjm0=
X-Google-Smtp-Source: ACHHUZ6wH3GOqtxUAy8OBk+TwH5yXJ25d6WxRgrK0jp0oQQh2e9Y4QjiKo6axI/+M/fesuGDBsiqqdi/+eHKJkSiUt4=
X-Received: by 2002:a17:907:60cd:b0:982:66e5:64fc with SMTP id
 hv13-20020a17090760cd00b0098266e564fcmr574198ejc.44.1686717975862; Tue, 13
 Jun 2023 21:46:15 -0700 (PDT)
MIME-Version: 1.0
From: Shivam <shivamvijay543@gmail.com>
Date: Wed, 14 Jun 2023 10:16:04 +0530
Message-ID: <CAC583hFC3qQp8a3ueFkjFVYDEq=hsp8V7GonTyHBChX4qH+mdQ@mail.gmail.com>
Subject: Support for ACK and PWR Leds in Raspberry Pi
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c9a0c505fe0fa1ec"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shivamvijay543@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000c9a0c505fe0fa1ec
Content-Type: text/plain; charset="UTF-8"

Hi, I want to add ACK and PWR leds support in the qemu raspi machine so
from the terminal of emulated raspi I should able to control these leds, I
coudn't able to understand the hardware level controlling of this leds , so
if any can help me to start on that then it would be great .

Thanks & Regards
Shivam Vijay

--000000000000c9a0c505fe0fa1ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_sig=
nature" data-smartmail=3D"gmail_signature"><div>Hi, I want to add ACK and P=
WR leds support in the qemu raspi machine so from the terminal of emulated =
raspi I should able to control these leds, I coudn&#39;t able to understand=
 the hardware level controlling=C2=A0of this leds , so if any can help me t=
o start on that then it would be great .</div><div><br></div><div>Thanks &a=
mp; Regards</div><div>Shivam Vijay</div></div></div></div>

--000000000000c9a0c505fe0fa1ec--

