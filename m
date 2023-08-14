Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BED7F77B5CC
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 11:55:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVUGt-00032d-2G; Mon, 14 Aug 2023 05:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVUGq-00030b-Hx
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 05:53:56 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVUGo-0003xM-Uc
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 05:53:56 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fe426b86a8so38064585e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 02:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692006833; x=1692611633;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p9654rdgmxYD8SeMeQ7eQVPFacLBInmAZMAtsX7kgQE=;
 b=Wk5S3PopbeFAg+F8NIFYcgoMJKnpVINFdjz5p6edQLESQA1vcgcv9kYIUf9/826oX/
 6kuMmq6TTdz3DjRummoht8TM1+b7VJ6SXGqFS8+/pDrObie+EByvCdMU5Qjx7EYkvua9
 0IPvjU3z/llMTidfKC/r4YJZukJ9S6E1f1NSQeTen5OrQnAFOHdsA1uiUbM9KxT3SYHV
 80v6KMmyZDhyHt5S9Zu00VDTUkX/Sd3Ztjx/QZskDycWZhlynbxQEosflwRaigwXU0Tt
 jA14fLVtm1n7bG3SvkS3ZXPREeayCwQKIQKGP+NwqpadCR2cTBL+FwXyfysbqdSVh44L
 lLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692006833; x=1692611633;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p9654rdgmxYD8SeMeQ7eQVPFacLBInmAZMAtsX7kgQE=;
 b=akOtMj52qSw5AOMxEIHoxf0sPnCR2lPrjpANnR7D+JyqSTvudFjLWOtQ1nY2yxC1Az
 HjE+y7pAx7p+tB2NxBvMUwWZ2pKFysJL/0hmuxi6s1GyO2f4ENPvlHjzfBrYz7cpJgkf
 l3KS4OvFJhzX/cmwZKfcGpDLbbE4ecTgvOfPrDEnzo9E8yeKFF2hnkOdKFs+ssZCCC9o
 Xu3t56Y8ozTWgcPi/KOJ0abi1OL1mmFgWzsSFuuR9UuAY7JFBBu21mtQ4EVxB32Y0/b2
 10j/xxHQaa6NjrTzxJBxidMFPwr/zBc6QCYwwfetPnpwzPGVxcil8mnPXMwKcHiYMxfo
 Rxcw==
X-Gm-Message-State: AOJu0YzOp2DXSBl5BbUEtLWGdH4sP8gEA8ql/fIVO/IhB//7525g+aQl
 5KhMNWjrytN7v6ERuptkCYczsg==
X-Google-Smtp-Source: AGHT+IEYsP+jZllE2SoltK9CPfd/fOX35w0+KbEAYgQE/3yR9X0sdqvrta1Wk1L2lKwhb9Xzol4XtQ==
X-Received: by 2002:a1c:7419:0:b0:3fe:1f2c:df1a with SMTP id
 p25-20020a1c7419000000b003fe1f2cdf1amr7105848wmc.24.1692006832945; 
 Mon, 14 Aug 2023 02:53:52 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k13-20020a5d428d000000b0030ada01ca78sm13975506wrq.10.2023.08.14.02.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 02:53:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DE0891FFBB;
 Mon, 14 Aug 2023 10:53:51 +0100 (BST)
References: <20230811165052.161080-1-richard.henderson@linaro.org>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: pbonzini@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v3 00/15] linux-user: Implement VDSOs
Date: Mon, 14 Aug 2023 10:52:50 +0100
In-reply-to: <20230811165052.161080-1-richard.henderson@linaro.org>
Message-ID: <87350mt0eo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> It's time for another round on implementing the VDSO for linux-user.
> We are now seeing applications built that absolutely require it,=20
> and have no fallback for the VDSO to be absent.

Something broke configure for me:

  ../../configure --disable-docs --disable-system


Gave:

  Dependency glib-2.0 found: YES 2.74.6 (overridden)
  Program indent found: NO

  ../../linux-user/hppa/meson.build:7:0: ERROR: File vdso.so does not exist.

  A full log can be found at /home/alex/lsrc/qemu.git/builds/user/meson-log=
s/meson-log.txt
  FAILED: build.ninja=20
  /home/alex/lsrc/qemu.git/builds/user/pyvenv/bin/meson --internal regenera=
te /home/alex/lsrc/qemu.git /home/alex/lsrc/qemu.git/builds/user
  ninja: error: rebuilding 'build.ninja': subcommand failed
  make: Nothing to be done for 'all'.

Will there be linux-user targets that never support vdso?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

