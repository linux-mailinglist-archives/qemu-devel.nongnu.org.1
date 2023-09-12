Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6023679D178
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 14:57:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg2vO-0004Fs-8A; Tue, 12 Sep 2023 08:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pencegl@gmail.com>) id 1qfthU-0007CX-CO
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 23:04:28 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pencegl@gmail.com>) id 1qfthS-0000ZA-4W
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 23:04:28 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-48faba23f51so1915063e0c.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 20:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694487864; x=1695092664; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lFh/MVmuLnVNaiRKeyQqCa6qgvjpjVNTzgoHWpJ0NPs=;
 b=EwyJ78E+eJYuEZIngxjtBK8MeJCntzZvQKq7sf+5n7RI/h7n1SOUtLmmmRlGVAgSUg
 cD5umtJs5qclxxEklxR3dTvo4R3Wf9IvUWK7C48brS4XD/NDXG5zhGT4S3AuNX8ZNGo7
 PrnwM5fmknURWH5400GH2015P2mWE5tKS8+NqYa5pQNrVVrq0XIrN5+evdcphMM8cORG
 97YfWjavLPGsD4bWkcyGiWbYGOJl7EgPtNua6kPKcnmC1rnlMe8aLB0B36MNA7PqDke8
 G2fxe0hctHhW1YsgflVV8WkQce5QyPin50PxDMqJ7oJyv8Wsx8eqV9Sjm/qNO/Hcv8JI
 6yBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694487864; x=1695092664;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lFh/MVmuLnVNaiRKeyQqCa6qgvjpjVNTzgoHWpJ0NPs=;
 b=F3DDs9LDOAH4jlPXfIouCTBZHu9eS0SW7KPS7hJBr0biJejiuUT1/nKI8Dd2s/54JL
 vxcqwj8Sv0LwumXLVUPr5FT7khHw58+sLy0NnJJgxj6r6xWvKACErL9G0lk5Znp0FQ/o
 pqjAb15d8+ildn6AU6ECKhoWc4BXf/xjJS1MGUeFM5zXPXtUTCL5ucriMnWC6fv+op5a
 jHvSCpmfhE86LnQd5fp0ijLX2Fd2t5K5rsKJFFuTnQvuOBdKGfEK8WK+eXJQO59rjv8D
 Fpxgpj0Nufyj3WDZPaTcQ9gv+U91nrq5EmLOZfPqsW0Hf5y64gotNAq94A+AA/x1fJsG
 uDIQ==
X-Gm-Message-State: AOJu0Yz59XSt5DrLmkoLwF9zMOd+Ar3QKdBal/UTscfk0xinhV8nxewM
 a0lWrx3N96XA/J28eTyk59M7eASnUOlSEMsnHJ+qWkVa8eA=
X-Google-Smtp-Source: AGHT+IGv8Bwb4Muw2gGrzdzODMIUOalLnHpSt0gjubxVHLqkiQQP/vvMVEBzzSX8OGKZTz8ldmNNx/DhrN8tuyleM7I=
X-Received: by 2002:a1f:da03:0:b0:495:c362:94c1 with SMTP id
 r3-20020a1fda03000000b00495c36294c1mr8183942vkg.7.1694487864472; Mon, 11 Sep
 2023 20:04:24 -0700 (PDT)
MIME-Version: 1.0
From: George Pence <pencegl@gmail.com>
Date: Mon, 11 Sep 2023 22:04:12 -0500
Message-ID: <CAFF=amRzAFxdV-UBvy5Z+yN-g_4YRpxefDUA_A2LT8T7sjxpDw@mail.gmail.com>
Subject: Request for information on QEmu code architecture
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003cfb34060520b3c1"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=pencegl@gmail.com; helo=mail-vk1-xa29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Sep 2023 08:55:22 -0400
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

--0000000000003cfb34060520b3c1
Content-Type: text/plain; charset="UTF-8"

Hello,

I'm working on a college project where the goal is supposed to be an
experiment in OS instrumentation. What we decided to try is to modify the
QEmu source code to be able to acquire some info about a VM we launch with
it. We've forked the repository and successfully built from source, but the
codebase is so massive, we don't know how to find entry points in the code
for where it's initializing/launching our VM.

We found this e-mail in the contact section of the repository readme, and
was just wondering if anyone might have some advice, or could refer us to
some other resources that could help us learn more about this aspect of
QEmu.

Ideally we would like to be able to find places in the code that run every
time a VM is initialized and launched, and be able to acquire some data
from those functions for logging/printing/etc.

Thank you in advance,
George

--0000000000003cfb34060520b3c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">Hello,</div><div class=3D"gmail_default" style=3D"font-family:ta=
homa,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-famil=
y:tahoma,sans-serif">I&#39;m working on a college project where the goal is=
 supposed to be an experiment in OS instrumentation. What we decided to try=
 is to modify the QEmu source code to be able to acquire some info about a =
VM we launch with it. We&#39;ve forked the repository and successfully buil=
t from source, but the codebase is so massive, we don&#39;t know how to fin=
d entry points in the code for where it&#39;s initializing/launching our VM=
.</div><div><br></div><div><div style=3D"font-family:tahoma,sans-serif" cla=
ss=3D"gmail_default">We found this e-mail in the contact section of the rep=
ository readme, and was just wondering if anyone might have some advice, or=
 could refer us to some other resources that could help us learn more about=
 this aspect of QEmu.</div><div style=3D"font-family:tahoma,sans-serif" cla=
ss=3D"gmail_default"><br></div><div style=3D"font-family:tahoma,sans-serif"=
 class=3D"gmail_default">Ideally we would like to be able to find places in=
 the code that run every time a VM is initialized and launched, and be able=
 to acquire some data from those functions for logging/printing/etc.</div><=
div style=3D"font-family:tahoma,sans-serif" class=3D"gmail_default"><br></d=
iv><div style=3D"font-family:tahoma,sans-serif" class=3D"gmail_default">Tha=
nk you in advance,</div><div style=3D"font-family:tahoma,sans-serif" class=
=3D"gmail_default">George<br></div><br></div></div>

--0000000000003cfb34060520b3c1--

