Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A0E7C48B4
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 06:12:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqQYE-0004vg-Op; Wed, 11 Oct 2023 00:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amit251098@gmail.com>)
 id 1qqQYC-0004vR-9J
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 00:10:24 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amit251098@gmail.com>)
 id 1qqQYA-0008An-S9
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 00:10:24 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-77575233633so431615785a.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 21:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696997421; x=1697602221; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=09tGNNp72cO2MDUBxFyQcwa3xhSPEwypeSrgMk5fPMk=;
 b=NevSZcinGIo4RJ+EZkdbKnwkT//ffem8KiuLWeK46D/VW/syl+F/KP2H879JCW0ZvJ
 sO9TYHhQl6fsKizOV1eR+vBryB7Bt8SvMqFBUwOsH+U8ubq+u80sOmTkvHTMfx6UfxOs
 Iu6yAMe/Al5CycRnU+vBkxBUWHeysqFzTGG4eGcYHr+UuagJeLMSmEjBg/bp3hfU3UdF
 +rJVMea5aFLBWvwBlQWNbkA7NZMKF3xRrvHB74S3TiBZv5DzBLJhWqQT/aoHT5FQijaH
 U/NcI4w9I84FThnHNjKW/V+Zfkk6dEjnC+ajVwK0pBl7XjSM6Sg2O5h+Tkw28/C/2UEV
 ndPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696997421; x=1697602221;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=09tGNNp72cO2MDUBxFyQcwa3xhSPEwypeSrgMk5fPMk=;
 b=vF0PnpZ17KSjpdafVc6PbRn2dK2KAq9Ah0ck2f2Qu+1A5UybrEZi0YMBzzaEgOWVww
 frkXu6PsYFpUJ421lYaKA8rdBYTG5TtG+dBXW5bCJVrolByMfATDQRGug3EbzuOz/U/1
 bCF2Tx3g4PqiFTipBkbNLF5mB1wKEFrD9VGowO7xwH5rL7FsxbZvvxSZeeHV3IbAmWMy
 6lxuB8aqmPY2YLMxZjvdFHrIsNJHxgLD589qyfdy8OYt5hAOTZg27kIIZGhIwBKPrnyS
 30lZ4iA88FTtuyAHbfheXwTK4lRSuS36yuAhTeD5AaG1jRk7mBy8+C5jKMgC1VO3tTkB
 VuWw==
X-Gm-Message-State: AOJu0Yz32t04yoPUktHzYKjJyphE/hSf7BAHsydD1o40DBXi5U7x+Wc1
 vd7Z3mob7z+/gzb+fQcnKGSpWMiDmyP9Ahx6BBWVZXhg
X-Google-Smtp-Source: AGHT+IF9WXAbKpB/X5xWiOjr+/ISIY3FGhJysk2CMYLBAuH0Wrif/plaQuG1kL0nAuWd8SXXjFH7ftBUU+44sAsT2FU=
X-Received: by 2002:a0c:cc04:0:b0:66a:c297:c239 with SMTP id
 r4-20020a0ccc04000000b0066ac297c239mr19921921qvk.20.1696997420597; Tue, 10
 Oct 2023 21:10:20 -0700 (PDT)
MIME-Version: 1.0
From: Amit Kumar <amit251098@gmail.com>
Date: Wed, 11 Oct 2023 09:40:09 +0530
Message-ID: <CAHhcV8-HHG36Ndv7Y-K5FrUTb-WwVoRW3PPzaiM4hEesGA-iWw@mail.gmail.com>
Subject: [Beginner-Help] Help understanding the migration Code
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000007087c506076900b0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=amit251098@gmail.com; helo=mail-qk1-x734.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--0000000000007087c506076900b0
Content-Type: text/plain; charset="UTF-8"

Hi
I am trying to understand how migration, more specifically live-migration
works in QEMU. I've tried going through the source code but didn't
understand much, and couldn't find documentation either. I want to work on
live migration and need help getting to know the code.
More specifically I want to understand
- where the pre/post copy algorithms are implemented
- which files/data-structures that I should look at
- should I need to make changes, where and how should I start?

I am new to working with such large code bases, hence need some guidance.

Thanks

Amit Kumar

--0000000000007087c506076900b0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><div>I am trying to understand how migration,=
 more specifically live-migration works in QEMU. I&#39;ve tried going throu=
gh the source code but didn&#39;t understand much, and couldn&#39;t find do=
cumentation either. I want to work on live migration and need help getting =
to know the code. <br></div><div>More specifically I want to understand</di=
v><div>- where the pre/post copy algorithms are implemented</div><div>- whi=
ch files/data-structures that I should look at</div><div>- should I need to=
 make changes, where and how should I start?</div><div><br></div><div>I am =
new to working with such large code bases, hence need some=C2=A0guidance.</=
div><div><br></div><div>Thanks</div><div><br></div><div>Amit Kumar<br></div=
></div>

--0000000000007087c506076900b0--

