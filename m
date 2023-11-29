Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2092F7FD7D2
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 14:21:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8KTz-0005ss-Hm; Wed, 29 Nov 2023 08:20:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8KTx-0005sY-CE
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 08:20:01 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8KTv-0004Ah-KJ
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 08:20:01 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c887d1fb8fso83764741fa.0
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 05:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701263997; x=1701868797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HnGABKaT0j4TfCEVtfZKMREgy3clicc9tsASt8d8Gi0=;
 b=o1y6R7LNlPwwWVPNa+25Gm4cFuYuZXKMdU6OkJXstmCHO75bTsZJTC6+sNg+Ujy1oC
 5ZL+gnKqS0kzVlY10O0Kx6pxPJIzXXt+1a5CnF5Rrev0UHDBrW9WW9Yl1qFK1wDJE3Zt
 VUMfJawZVS0LPI4EtYQtKe96mLb932qrflafuQUep0xsVEsLIgZiE4H2O5TBewEtVLRB
 HMUQfO55kqY7sUIfNyHD1rS+Ymomwl/hGP+sEKfEJVwbF+svdLLUdyh3+5/9EHnnvAlK
 GfxbFRJ3vdr8Kyg/bJB0h7S5LzbKrEH06jQdhK8FWz2dS0SpT0WGc5OhBIdLTikOG2GK
 bmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701263997; x=1701868797;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HnGABKaT0j4TfCEVtfZKMREgy3clicc9tsASt8d8Gi0=;
 b=W5N+X58deCViQcHhcBvAkp5t3vkNN4PjDKMyAh4dwypqdUd5okagCjzNG4WaK3H8Fw
 4tXsKTPKTulxZEAOfAxI0E0lSI+r2vYzzt37v3B/J5MNyxa8vS1CUl1ge0g0ZlguKXLL
 Ia8j3jkuDtp24Zfs3WBF/mpWuOEbeTua1c7hNCoh2vq5kDawrtpDZKOsB3e6CGlqnJhx
 4i94ciIvz1HjZOKOG3oyRIQv2MiWXg+ZRz26qiR37XAgT3MUzj81kWZAAuvtn5jc0RoL
 bf1dLwUw058FlHc92WRjvlbfFjrHBrKW1EAzNgexiLmrRdi4gKlB6sywYhawwnlAPzVR
 gbwQ==
X-Gm-Message-State: AOJu0YwWIojxrRMnwsZIeUCy6DaQ0i9xgWmacoPSJa60CDzIvxDgOLgn
 99fR54mYIK6ZUyxXDJKzxLUbow==
X-Google-Smtp-Source: AGHT+IEUFzj/b/bI9iOQudbhsKCnT5gjjc8JVgboZf7UKYk7y7zuxdDZX4CsvfTh7TTxgERGNWjpCA==
X-Received: by 2002:a2e:954f:0:b0:2c5:13e8:e6d5 with SMTP id
 t15-20020a2e954f000000b002c513e8e6d5mr11356689ljh.23.1701263997194; 
 Wed, 29 Nov 2023 05:19:57 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 e25-20020a5d5959000000b00332eb96cb73sm14477019wri.73.2023.11.29.05.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 05:19:56 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7EA665F7AF;
 Wed, 29 Nov 2023 13:19:56 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luis Machado <luis.machado@arm.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH] gdbstub: use a better signal when we halt for IO
 reasons
In-Reply-To: <20231123131905.2640498-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Thu, 23 Nov 2023 13:19:05 +0000")
References: <20231123131905.2640498-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Wed, 29 Nov 2023 13:19:56 +0000
Message-ID: <87fs0obssj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22c.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> The gdb description GDB_SIGNAL_IO is "I/O possible" and by default gdb
> will try and restart the guest, getting us nowhere. Report
> GDB_SIGNAL_STOP instead which should at least halt the session at the
> failure point.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Luis Machado <luis.machado@arm.com>

ping?

This has been broken for awhile so I don't know if its worth putting it
in 8.2 (I have nothing else in my queue right now). However I suspect
people only get confused when they have disks filling up and debugging
stops working.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

