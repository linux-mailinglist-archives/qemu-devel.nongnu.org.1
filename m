Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAD5835A49
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 06:35:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRmwP-0001uf-9d; Mon, 22 Jan 2024 00:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junho920219@gmail.com>)
 id 1rRlfQ-0008GM-T0
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 23:12:12 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junho920219@gmail.com>)
 id 1rRlfP-0003AC-Aq
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 23:12:12 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a2c375d2430so303085066b.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jan 2024 20:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705896729; x=1706501529; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=oC57M8MS8kQFeD2AL0wDqV0/Btayug4t4G425kfPSCQ=;
 b=LqBIa1uhsYk739PbJ0ax7iTzqeDaHEJuvEhKUa2x20nTvTKbJBRmzZfTBSQP/RIn2Q
 S0JVKjNMQDO4jidkiM5uEZJhLwL5oPj/5S/bfxOnBBM4XywXxcKSGsrb4xhWOCDY0LMT
 9Jg/VirWfCwGltH0bhsfNFIc5FTpTo6w4xzITxlP8LUaFZoaOP/4Dj03rVdG6xoUiLBD
 xH84hHck8e57XFdm6s4kw9mQn0ZwSyFDIKC8zarUU7PIH9lfES/80JqjHh0VYyU3GtnC
 tmRtGf34A9hvIVJr09uRgDTaG9VJLHprzwjo34qTYUq3uqCtKcKkF+ok6nx+AjI49Y6k
 yDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705896729; x=1706501529;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oC57M8MS8kQFeD2AL0wDqV0/Btayug4t4G425kfPSCQ=;
 b=o6nz0TAJcjehOgQrfakGYeIZCix6AQRSF0a1eQz4yvcSNbmmA/WdPc6MfR9+2WzK/+
 bCNt36krCWtARJ3CIrBPBqupwxUFPC6kxzz4mGC3x/Bvr1SPO6YboNh3QmHDTXVlCT48
 z6hN4DMGqxLg0w11X8DaS5HvcsvJDPOVXjIxl6s5nLNvk78Z1yWm6vV78C+gmkcN+buh
 faho7cBQmhnGL9w2lolWyGFCGmlct79buReTw8nYNhKKXllLoB0ir75c1PkS7bzZk5lu
 0FUklYMQKGR7ADHW7NWvmptxQYlxZ9V2pSbTT39e/BNqiUUNG4t/BYp7rXa+Tl2QXA6C
 f9RQ==
X-Gm-Message-State: AOJu0YxHiotI2/7iAT+2fREdJlI9KgdtWL7tMT4lXV6EjqLIivIO6lVr
 VqqDpxYroLn8BDNbeIoHKCruB/yypocoXti9L94ILUUAi4MuArVqr4SLn70tSt2tDKfPfPAK5D/
 mxORTKO18f9F0mo8SByaSSda1HuwN/VocKxw=
X-Google-Smtp-Source: AGHT+IHtwsgDL1PMtywebkzAbt6Qj1js75gC1QlvCvDRV/94qSsNITwZtz4f6fkRx/LmZX4/ijbvKmgoiFkLByu1B68=
X-Received: by 2002:a17:907:a786:b0:a2d:bcdc:da6d with SMTP id
 vx6-20020a170907a78600b00a2dbcdcda6dmr1973313ejc.0.1705896729041; Sun, 21 Jan
 2024 20:12:09 -0800 (PST)
MIME-Version: 1.0
From: Junho <junho920219@gmail.com>
Date: Mon, 22 Jan 2024 13:11:58 +0900
Message-ID: <CACrrvNSKQ1du+f40RvcDCvhjojvvDSsHi0FyWoJMMBtt8R+Q3A@mail.gmail.com>
Subject: How can I know Page Table address on RAM?
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000008ede4f060f8108a3"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=junho920219@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 22 Jan 2024 00:33:46 -0500
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

--0000000000008ede4f060f8108a3
Content-Type: text/plain; charset="UTF-8"

Hello,

I'm a QEMU user with PowerPc target architecture.
I have some personal modifications related to tb jmp cache and chaining
logic to improve the performance of a specific guest code. To verify the
safety, I have to guarantee that the page table on RAM does not change
after initialization. Do you have any information related to this work?
Currently, what I need to find is the page table start address on the RAM
so that I can test with the range detected.

I look forward to your response.

Thank you
Junho

--0000000000008ede4f060f8108a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>I&#39;m a QEMU user with PowerPc=
 target architecture.</div><div>I have some personal modifications related =
to tb jmp cache and chaining logic to improve the performance of a specific=
 guest code. To verify the safety, I have to guarantee that the page table =
on RAM does not change after initialization. Do you have any information re=
lated to this work? Currently, what I need to find is the page table start =
address on the RAM so that I can test with the range detected.</div><div><b=
r></div><div>I look forward to your response.</div><div><br></div><div>Than=
k you<br>Junho</div></div>

--0000000000008ede4f060f8108a3--

