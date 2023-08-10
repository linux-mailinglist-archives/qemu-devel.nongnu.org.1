Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBBC777FB8
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 20:00:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU9wW-0007xk-QX; Thu, 10 Aug 2023 13:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU9wN-0007vC-Nm
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:59:20 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU9wL-0007jC-Kq
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:59:19 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fe426b8583so11466025e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691690356; x=1692295156;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gp8oa2zOrfadjkcCAnmrhE41pDNjnkYNRFQKBUlc0Us=;
 b=aC/oO443/MBmjFQtt3yhpUJdes4jToq7isC6y+x24QFEp36DQvusV7IrXwYyqmYtG4
 2mubW4avXifqN4P+gpVmKtsSEXsCzToDfmOynsiN15rXDbl0ebzieSSsiSH2C/HczFlH
 ecdcs3Ut+bhaZTI8jSiCk8Jdv+96GW39g1N7v/Mts0YoEtp4lVL8CAgGQoQ4u8y5sNC1
 GyTekkWPIbifmQ09Hexx5/50shOW0eHc9MYXcVG2loCKH/6keEONlGQY3yO+6f5/D8XP
 Pb33HzCES962txinlKdp0xFmNPKo4o7EdHkMXBNfdJDjMjxGCanIWu6R9hIs7MqZaz+a
 Co0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691690356; x=1692295156;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gp8oa2zOrfadjkcCAnmrhE41pDNjnkYNRFQKBUlc0Us=;
 b=LO6z2MCbsypNlnam3azp3q+qflgvY8X2Bp84OydXQ0Vj139JyXqkkZaPDy6U2fpHAf
 Y3cHw26aKpjZ8YO43kUi3X9VYEtBU+NOkxxmwQOJUf0DtdNITGAlVoaubmJKUMU6vajt
 ZbHgxWVLyAYzdgEFmOUgZnhHCTANDa+QwGJwWykUmzhaQ6sUrKbGF3Pf9tNzazJ0Qlbn
 ykizH//g68kVbd9Mww0IZlwXjJHgVyFWcrTkRu4EjoTOn2j0jsHlhE4DoY+5BltVvEpj
 8+hl6vm4Nurx/Yxpfglue/SL9EPI31cgBX94yPIzjt8PwyhBQntJety5wtJR7Hx+rSVn
 9ClA==
X-Gm-Message-State: AOJu0YzSyraou9To8Z3cMAPP0fIhhm/RbX1ihKQSLgyKhEDeTcR6ZSss
 JmYUlAaieE0/h+k7jTqJeQ37hQ==
X-Google-Smtp-Source: AGHT+IFeHxkb1Ib6upUPKFbA9XLk2ex0e7NjBUeROR/8V2SzJ3lkiLEKhIuaKpDuCxFjW+iR317ipA==
X-Received: by 2002:a05:600c:2196:b0:3fe:2e0d:b715 with SMTP id
 e22-20020a05600c219600b003fe2e0db715mr2660045wme.18.1691690355668; 
 Thu, 10 Aug 2023 10:59:15 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a05600001d000b00317b5c8a4f1sm2847281wrx.60.2023.08.10.10.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 10:59:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DA05D1FFBB;
 Thu, 10 Aug 2023 18:59:14 +0100 (BST)
References: <87y1k5yxiy.fsf@linaro.org>
 <20230804182633.47300-2-dark.ryu.550@gmail.com>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Matheus Branco Borella <dark.ryu.550@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] gdbstub: fixes cases where wrong threads were
 reported to GDB on SIGINT
Date: Thu, 10 Aug 2023 18:30:10 +0100
In-reply-to: <20230804182633.47300-2-dark.ryu.550@gmail.com>
Message-ID: <87a5uy3hjh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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


Matheus Branco Borella <dark.ryu.550@gmail.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>> Can gdb switch which packet sequence it uses to halt and restart
>> threads?
>
> Yes, but the way it does it does not trigger the behavior I was concerned=
=20
> about. GDB falls back to the old sequence when either (1) the target does=
 not
> support the vCont command it's trying to send or (2) you step backwards. =
In both
> cases, though, whenever it does fall back, it will first send an Hc packe=
t=20
> before continuing or stepping, which means we won't ever see a sequence s=
uch as
> ["Hc", "vCont;c:*", "c"]. This means, in short, that, while the shortcomi=
ng does
> exist in the code, GDB never actually triggers it.
>
>> The test I would like see is pretty much your test case
>>=20
>>  - load a multi-threaded program
>>  - wait until threads running
>>  - pause
>>  - resume thread
>>  - check resumed thread was the right one
>
> What I have here should be pretty much that.=20
>
> Is there something else you think I'm missing?
>
> ---
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1725
>
> This fix is implemented by having the vCont handler set the value of
> `gdbserver_state.c_cpu` if any threads are to be resumed. The specific CPU
> picked is arbitrarily from the ones to be resumed, but it should be okay,=
 as all
> GDB cares about is that it is a resumed thread.
>
> Signed-off-by: Matheus Branco Borella <dark.ryu.550@gmail.com>

Arg the commit message is in the --- discard section.

Queued to for-8.1/misc-fixes, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

