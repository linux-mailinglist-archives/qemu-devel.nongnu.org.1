Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6AAA95F1A
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Apr 2025 09:18:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u77tX-0006e2-It; Tue, 22 Apr 2025 03:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@proxmox.com>)
 id 1u77tE-0006cg-Oi
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:17:56 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@proxmox.com>)
 id 1u77tC-0003Av-T2
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:17:56 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 29AEA49878;
 Tue, 22 Apr 2025 09:17:50 +0200 (CEST)
Date: Tue, 22 Apr 2025 09:17:49 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
Message-ID: <1637773751.3835.1745306269519@webmail.proxmox.com>
In-Reply-To: <CAJ+F1C+0ZQFafr4zYSAc6AGTxvFf+QoH5D7bw4S0FL4WZKFTYg@mail.gmail.com>
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-10-dietmar@proxmox.com>
 <CAMxuvaxniAvsag=UT9xWjU5f17ec6ua9hFBDB72iTnh4jiH4vg@mail.gmail.com>
 <300596504.3803.1745303752280@webmail.proxmox.com>
 <CAJ+F1CL1hrK=-6eJLYo9qkBmMCogcMGYBtaKF4EmNjNZxQZe7A@mail.gmail.com>
 <525848936.3820.1745305437863@webmail.proxmox.com>
 <CAJ+F1C+0ZQFafr4zYSAc6AGTxvFf+QoH5D7bw4S0FL4WZKFTYg@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] h264: register shutdown notifiers, stop pipeline
 in destroy_encoder_context
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev75
X-Originating-Client: open-xchange-appsuite
Received-SPF: pass client-ip=94.136.29.106; envelope-from=dietmar@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


> On 22.4.2025 09:07 CEST Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.co=
m> wrote:
> > >
> > > Given that h264 code depends on VNC state, can you make VNC
> > > close/clean the connection instead?
> >
> > For all open VNC connections?
> >
>=20
> Yes, we should have a cleanup path instead of shutdown notifiers.

I am finally confused. How do I close/clean the VNC connection without a sh=
utdown notifier?


