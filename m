Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7427F71979A
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:48:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4etm-0005By-Jt; Thu, 01 Jun 2023 05:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q4ete-00051l-06
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:47:06 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q4etb-0004MR-OM
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:47:05 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-568928af8f5so10824197b3.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 02:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685612822; x=1688204822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5bnPVCo2bIG5oNB5Qm57u1zkOjkXBPcKVD+O/r6uWzc=;
 b=mVEdneuGaNSM5A+c8ZP3N4N0JOmFzIXPRuYrPiwa0HHXfGJXe88DDaUdGTpkhkjqMo
 /gLpvGHaxM4PhQyXnfrd6bCIsnA+Zjxc0PmDgY+oYjcZuP3Hyl8aPASKccfSZCGMSYKb
 6kH8+dD0EFRYvOXYQ9AFXllWBgt73ZV02zmVfIFxI9HyfnQMMRiu5ypDMXWGnHoDLBlB
 cP6k/PgiinDQZ2xsVPmxJrVVvEs/5ze6GXgAWCS1Cf0R8hPaXGYaBUrFBKTtQPuSPV0c
 6/5MT/IXMZ+wItSRrr0XV6rm1JI1Vl1omfFv5KCv+GWwQeriXIhQLxHVJhrnvI3pYi5T
 7vBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685612822; x=1688204822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5bnPVCo2bIG5oNB5Qm57u1zkOjkXBPcKVD+O/r6uWzc=;
 b=alJPO0fyPnc2wBgnsmOAXhRft1Nzb/e8fnTJP6BAwVH3Kfxv6c2rc5cK+s3o8Shtpv
 ZssjVNF6PIAtfiPWk4lyT2+jVhj5MXPcpyBr6Rt8aU3A8Ty8OrO1PMU68GSYI+YHsblq
 0bNbkZFQsKKYf0dLIoBke1gRBb2EAm+PqJ4ArP72NYTrqRXjD2wg1lTRzYRO0kWB5H6e
 VDTVma3uRMFpYpnpMqEKIBFJSbymEw5UvlXHKd83EzKeFCKGJ/F9yRc8UlwfE/dnhlSM
 KvGyF8GUjqpF6rHeUGP0h2vnS55VKFqmeR90c9Bq+ndjjkY/jV6nHA3u3psIbIeDuCB6
 F6Bg==
X-Gm-Message-State: AC+VfDwhDqiud6FjkCmIt529lzzeWUvWxRex6ujfoP5rT6gDVi5RLUiZ
 nfQFHiz/3rnaP+zsJKALlyj8MkkBVUbS/IXqWps=
X-Google-Smtp-Source: ACHHUZ4Zt7hpyNLwDBrND2/qYXViUygq/WNX8+eLlwQvbEMm5iUZOWGthTd14Rcm41U9CvdctraInGsDdYv78x+4UoY=
X-Received: by 2002:a0d:fe85:0:b0:561:b53d:d1f1 with SMTP id
 o127-20020a0dfe85000000b00561b53dd1f1mr1206676ywf.19.1685612822258; Thu, 01
 Jun 2023 02:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QX5XFw81XrHHn9p1pX+1y7tc+xMJLVx9YgRsMCkUwjW7Q@mail.gmail.com>
 <ZHhW5Qff1p2x0oB+@redhat.com>
In-Reply-To: <ZHhW5Qff1p2x0oB+@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 1 Jun 2023 05:46:51 -0400
Message-ID: <CAJSP0QXQouMgshcPwrnq4WUDZT0N8eVs19R9zqeA6vh0fB+N=g@mail.gmail.com>
Subject: Re: Using json: in common.rc's TEST_IMG
To: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000007fe85405fd0e51a7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=stefanha@gmail.com; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000007fe85405fd0e51a7
Content-Type: text/plain; charset="UTF-8"

Thanks, Hanna and Kevin!

I didn't implement bdrv_parse_filename() because I didn't want to invent
more legacy syntax. But maybe that legacy syntax does have a use and I just
didn't realize it :).

It's easy for io_uring, we can just take the filename and not worry about
other parameters (they can largely be set via existing QEMU command-line
syntax already).

I'll give it a try.

Stefan

--0000000000007fe85405fd0e51a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks, Hanna and Kevin!<div dir=3D"auto"><br></div><div =
dir=3D"auto">I didn&#39;t implement bdrv_parse_filename() because I didn&#3=
9;t want to invent more legacy syntax. But maybe that legacy syntax does ha=
ve a use and I just didn&#39;t realize it :).</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">It&#39;s easy for io_uring, we can just take the file=
name and not worry about other parameters (they can largely be set via exis=
ting QEMU command-line syntax already).<br><div dir=3D"auto"><br></div><div=
 dir=3D"auto">I&#39;ll give it a try.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Stefan</div></div></div>

--0000000000007fe85405fd0e51a7--

