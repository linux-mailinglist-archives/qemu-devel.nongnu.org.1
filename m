Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 510CB764A5B
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 10:09:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOvPm-0004v8-3k; Thu, 27 Jul 2023 03:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeshrz063@gmail.com>)
 id 1qOvPh-0004v0-Br
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:27:57 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeshrz063@gmail.com>)
 id 1qOvPe-0002W7-Ta
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:27:56 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-267fabc8465so393807a91.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 00:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690442872; x=1691047672;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=10BuacSMCdSo4fXfmWxV4jflAuE2jN0MQMF6t0q9I2M=;
 b=JKevHz2mSsc8eSBDaD4eFMDjnkVshhAPacAA7VxuvCO6U1C5FNnCAc8HtwlXYLsz6A
 nQNz4w5aWH5ixBVAVPk3+W3g4xy5izv3Sgj2f5E2mtTKUYWIyMgHId6TFbSf3hDGuiz0
 p9dX3yyaGfw57djYXrV3BL2RScLv8wRz4KKO+RtHePY39iYn+0MohPFWR5M1T6estkO5
 1e91oenWQd7pTC8NGEzzit9w2heWL056CwH5fqOGm+OV5Oxsd59LvaoDEZ2pr10Z99op
 HW8EdNWCJ1/BfLq3eNd6S42tGP/6yF7ce+qPoqRGjEX1hcMUlgUuIl+PP8iqOAkB4F69
 gzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690442872; x=1691047672;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=10BuacSMCdSo4fXfmWxV4jflAuE2jN0MQMF6t0q9I2M=;
 b=fW2F4/lXsy4EK3yFykZ3RyIh7IqF8/BmYPBwAdgwsYhKBi0oOa7GB1ebALnj952tR7
 uHRJy5cjtt5bCPncz+lUKWWSvYa6XyeNqO2gtmbEeTDFRhI3j5vfgjSE38fTGBb/zLIP
 pREbGMOiwvvAGNcbled2jCNhjlVx7Nzoq++MZ2GpdTxfs3L5uRJDYfenXOvEPP2cIxO1
 Hpvb+Yrc5OJgu1vr8rVJNXu51C+nWXTKd6nP0DWNTAntA55eUTpajQsjg8OCeYwwK0h/
 2y6M8ihyxxiZi/lqK+Zq0ocwCGlKYg8SEwGQ4IHLhsrat155qTTaBt7kR81C/QGoVOSO
 UW5Q==
X-Gm-Message-State: ABy/qLa7hg2emKAPs7Ba9b6cekBzYlZ8MaJ7kSIeWI+b8n6Pwrsc68od
 o8axKOhNg0Ed6R9ta83qCvDlcgivZPxGhKAff7Ea3R45kvcj2sEBdGc=
X-Google-Smtp-Source: APBJJlGPC7+UM7kwY9NC7G8gUy9/rTjVNpcoSsSe+gzSS0vgro1nqyElrgI+A6rfPF7vPAj2vCOTzulZGQfDF8kQmho=
X-Received: by 2002:a17:90a:7e08:b0:263:e133:b9c9 with SMTP id
 i8-20020a17090a7e0800b00263e133b9c9mr3430214pjl.34.1690442872491; Thu, 27 Jul
 2023 00:27:52 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?6buE55Ge5ZOy?= <jeshrz063@gmail.com>
Date: Thu, 27 Jul 2023 15:27:41 +0800
Message-ID: <CAHwH=FpikRsa3GiX9MA2_UiYybfTCuVTtz9tBOom9bOuFb3wAQ@mail.gmail.com>
Subject: Sending data from host to guest via VirtIO
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ed92f4060172e669"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=jeshrz063@gmail.com; helo=mail-pj1-x1030.google.com
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

--000000000000ed92f4060172e669
Content-Type: text/plain; charset="UTF-8"

Hi, All:

I'd like to send data and requests from the host kernel to the guest OS
through virtio, and I have read current virtio-driver implementations both
backend and frontend. All these implementations start sending requests from
the guest. Is there any way sending requests starts from the host?

Thanks.

--000000000000ed92f4060172e669
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, All:<div><br></div><div>I&#39;d like to send data and =
requests from the host kernel to the guest OS through virtio, and I have re=
ad current virtio-driver implementations both backend and frontend. All the=
se implementations start sending requests from the guest. Is there any way =
sending requests starts from the host?</div><div><br></div><div>Thanks.</di=
v></div>

--000000000000ed92f4060172e669--

