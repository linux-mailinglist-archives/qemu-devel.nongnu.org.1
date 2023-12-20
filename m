Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF253819BA6
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 10:49:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFtC0-0006bm-TF; Wed, 20 Dec 2023 04:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rFtBz-0006bT-9Y
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:48:43 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rFtBx-0007py-IQ
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:48:43 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50e34a72660so4389239e87.1
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 01:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703065719; x=1703670519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+tk5sjQ+gQfKZy1g6HomQw1bfuRHAVA99xMCqz1YOo=;
 b=prS+vuKt7SUacRXJi9HQZM8lvYxFJrSTTFih/vCyoF/fRm1FfQUrsbQ4bPp3Kw7w6N
 ADsvwtgnuIF/0oG8blhgFkMu0AvIvqG/XfTJ6jcgB5KuhqKxYjk1Pq+OydADzA+Mnvx+
 GAACpHHwYxNxvMXoneJzAEydNoL8MeDM33pY33hs4bt37LBOc30ZuC3HC2CRsJRmnpBg
 64aU7K7e4cdIsSAPLF9uG/X5S+1gXX2VhyQK5RUZWZA9OVVlWa9MElvR8EkyCvypwWtm
 3W8opFzTZcUsTTffkQKOGbsTW1eB+KlmnYSm109pl1WItoAxLq+uUuaw8eRndzmOyxC2
 3AMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703065719; x=1703670519;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X+tk5sjQ+gQfKZy1g6HomQw1bfuRHAVA99xMCqz1YOo=;
 b=FwCIMqjHYzo8AFOfudgbnXK7VMDzn3qSzbuRVBLmxprKhJ7C8FqKXKgL/oFYn/ucZr
 rWf5rHF6VIwTdOtrlKvQ4LJFEGFZb6sPcNES2eZiMLm6mbnKHL31m/Cgcn0fb59C6S0V
 aNuQ34rPl36JX/Suddr+6JdS/8AaJbrFHp8bl6ecf+4SYsyd+WD7klNqIR7QVCzLmJP8
 xaPlgmXrea7W8FL5r+Q2evOAVDF2w6onqk+UQjJ1+A9dcSOcnaeWRv0D2ZVGT+C2vT2R
 dHVWbxEpuVJiOeDCkQapKQU4w6f6D5Hxdz993lqhI+KGdicDysIN644ImFU3WbYYGZ5O
 IbgQ==
X-Gm-Message-State: AOJu0YxlgVKsfdjodaALYzAeU+zz5K99pG/yisQ39qg4lOiTxRSrSe11
 r4XHzyi+VGJ8UjCBX/STEMBmtHY1yIUJru1a9KY=
X-Google-Smtp-Source: AGHT+IFzR63JeZ1CvHRspbXdzuzisfU1pL1A+1bTotAHal3lIdDP0FEyz6Vt7HjvUkloR9GZe/wzMg==
X-Received: by 2002:a05:6512:3f0d:b0:50b:f51b:91f7 with SMTP id
 y13-20020a0565123f0d00b0050bf51b91f7mr8950724lfa.103.1703065719094; 
 Wed, 20 Dec 2023 01:48:39 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o20-20020a05600c4fd400b0040b37f1079dsm6635534wmq.29.2023.12.20.01.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 01:48:38 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1ACD95F8BD;
 Wed, 20 Dec 2023 09:48:38 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dave Blanchard <dave@killthe.net>
Cc: qemu-devel@nongnu.org
Subject: Re: TCP/telnet serial port not working in QEMU 8.1.3
In-Reply-To: <20231219164443.a644c86555f55e694563dbaa@killthe.net> (Dave
 Blanchard's message of "Tue, 19 Dec 2023 16:44:43 -0600")
References: <20231219164443.a644c86555f55e694563dbaa@killthe.net>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Wed, 20 Dec 2023 09:48:38 +0000
Message-ID: <87le9p2oi1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12a.google.com
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

Dave Blanchard <dave@killthe.net> writes:

> I just "upgraded" from QEMU 6.1.0 to 8.1.3 only to find that the
> -serial telnet/tcp option is no longer working. The following message
> is printed, and there's a 'connection refused' with the telnet
> program. Nmap shows no ports open.
>
> qemu-system-x86_64: -serial telnet:127.0.0.1:1800,server=3Don:=20
> info: QEMU waiting for connection on:
> disconnected:telnet:127.0.0.1:1800,server=3Don

Works for me:

  ./qemu-system-x86_64 -serial telnet:127.0.0.1:1800,server=3Don -s -S
  qemu-system-x86_64: -serial telnet:127.0.0.1:1800,server=3Don: info: QEMU=
 waiting for connection on: disconnected:telnet:127.0.0.1:1800,server=3Don

port is open:

  netstat -lptn | grep qemu
  (Not all processes could be identified, non-owned process info
   will not be shown, you would have to be root to see it all.)
  tcp        0      0 127.0.0.1:1800          0.0.0.0:*               LISTE=
N      547152/./qemu-syste=20

and connecting:

 nc 127.0.0.1 1800

starts QEMU as expected.

>
> What gives?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

