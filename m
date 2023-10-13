Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E20767C8BD5
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 18:55:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLQQ-0003wy-9w; Fri, 13 Oct 2023 12:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrLQN-0003vB-Cl
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:54:07 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrLQL-0001hj-Mb
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:54:07 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-405361bb94eso27723575e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 09:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697216044; x=1697820844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ihyLHWiW0YjfrL9ZkVPdX5JNGJfTqegzSQEctN0A7M=;
 b=BezSgWoZ0wudmflQUysb66mfQ2ZDzCN7jOoJiTa5UpzrUGusd+Rmcz7I59mr8Kc/Od
 wLPLHDKaELSNVrwgDqnI9pYBSJJW8w2v9ihXv6TCghtSCEG0HcEgdDUFfV5r+RR9hqta
 wPVILDwbKzP9VuR0xdNgrQPCkufSzxt3YMQTBERA06NKpDScxz4tVc8bK47x7VRwNLSr
 KsSnAjMoQTk4tlreO+bsesvYzKvq/QtuVnESzxxOWqZ9WKcxdwGvykTDX600uTc/1ROc
 fGd6ghUIkk4FcEzvSrIry49B2uxLhCP3RGWdermZy51ODguy2cbZt3neZ6Des5bMiNeg
 Gedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697216044; x=1697820844;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4ihyLHWiW0YjfrL9ZkVPdX5JNGJfTqegzSQEctN0A7M=;
 b=ZGTyIgm9t1uZ2bMWptdYyjL0oUhX3sIn8CzLo11wNnTcYGl5Ak7rLVttbZ4GYmsngJ
 KrKGJfs1soH0DrXU8hyexYviXtlJwO3/FmHNzuj1kJ4yUCVbWTrohqAVoVsEPLhAuW32
 iJAmdFEWMhlPbNoGua7ZIh4jSuxYPIVgMd5gC5ywNWkMMAjOfkGlTj/lMIYw/LLYzSoP
 PuD9twfQZLPbAAf3l+wg/bkC0AteWEsYyxxvZA9L0sY0Ns5Y9jnkS0l3Emhl0p+nWFf1
 CLqdisN3N99ePmY6rpLGHpMIzDRnoRZ68Xw7B9wgExKgL0ef8RJNL3icuVjMwKegQFrw
 E4pw==
X-Gm-Message-State: AOJu0YxHtBetV8nhITWI5WNwKQpOjVncUQzVUdsD+/HTc8SITXZhLClB
 jEuXsrB8k0joGw9Z4my4ZKO44QbqrPqrEAkGSI0=
X-Google-Smtp-Source: AGHT+IHpGqkVZt9Ino6uHKhh6PcY4ultCRWZknEDuX23RpPY8pWJvkDfVWff78DOFN47aGI641IdvQ==
X-Received: by 2002:a05:600c:296:b0:405:3d04:5f4c with SMTP id
 22-20020a05600c029600b004053d045f4cmr25242783wmk.38.1697216043671; 
 Fri, 13 Oct 2023 09:54:03 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 ay32-20020a05600c1e2000b0040588d85b3asm622632wmb.15.2023.10.13.09.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 09:54:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DEF7F1FFBB;
 Fri, 13 Oct 2023 17:54:02 +0100 (BST)
References: <20231006090610.26171-1-nicolas.eder@lauterbach.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicolas Eder <nicolas.eder@lauterbach.com>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Christian.Boenig@lauterbach.com
Subject: Re: [PATCH v2 00/29] first version of mcdstub
Date: Fri, 13 Oct 2023 17:47:25 +0100
In-reply-to: <20231006090610.26171-1-nicolas.eder@lauterbach.com>
Message-ID: <87mswmlaz9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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


Nicolas Eder <nicolas.eder@lauterbach.com> writes:

<snip>
> Signed-off-by: Nicolas Eder <nicolas.eder@lauterbach.com>
>
> neder (29):

I think you need to fix your author attribution here.

>   mcdstub initial commit, mcdstub file structure added
>   TCP chardev added, handshake with TRACE32 working
>   TCP packet handling added
>   queries for resets and triggers added
>   queries for memory spaces and register groups added
>   query for registers added
>   query data preparation improved
>   shared header file added, used for TCP packet data
>   memory and register query data now stored per core
>   handler for resets added
>   query for the VM state added
>   handler for reading registers added
>   handler for reading memory added
>   handler for single step added
>   adapting to the qemu coding style
>   deleting the mcdd startup option
>   handler for breakpoints and watchpoints added
>   making step and go handlers core-specific
>   adding trigger ID handling for TRACE32
>   cp register read/write added
>   switching between secure and non-secure memory added
>   transitioning to unsinged integers in TCP packets and removing
>     MCD-API-specific terms
>   moved all ARM code to the ARM mcdstub and added now commom header file
>   step and go handlers now propperly perform global operations
>   Doxygen documentation added
>   moved all mcd related header files into include/mcdstub
>   MCD stub entry added to maintainers file
>   added description to out-commented gdb function
>   introducing the DebugClass. It is used to abstract the gdb/mcd
>     set_stop_cpu function.

As you need to re-base anyway for this to apply cleanly I'm going to
wait until v3 for another pass. However I have noticed these patches are
quite noisy with a number of issues:

  - commented out code
  - code introduced then deleted
  - code motion after introduction
  - random white space changes

All of which makes it hard to review. A lot of this stems from the c&p
scaffolding from gdbstub which I understand as an approach to write the
initial version. However this should be squashed and merged away in the
final patches presented for review. Also please make sure:

  - commit messages match changes
  - each patch compiles cleanly on its own
  - you run through checkpatch.pl

Thanks,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

