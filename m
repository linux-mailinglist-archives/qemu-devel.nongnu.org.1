Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A764F7F5F05
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 13:29:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r68oe-0006z7-VW; Thu, 23 Nov 2023 07:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+39fc1edcc778f4c9f1e2+7396+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1r68od-0006yr-CX
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 07:28:19 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+39fc1edcc778f4c9f1e2+7396+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1r68oX-00069A-Jf
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 07:28:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=VWAK5xRltuUBYASYt9N56sGcUspu6GohkiBafufHCA0=; b=EiBAOkdFLOJ1usJy9AlhHcl2sM
 Ta/5PJj91vLX5+bH5MXaGjle+lRV/jAShyvmu/i8I35lhzusJ+2Sc/O/DCi5kFkY3G53OnSId0xa+
 P5B+wYJczBuLDkCZyzkm+oxkTTF2rapRawGWikVcHNqAYZlyLEv1UM4/am95yWycJgJdJuAhfKkla
 TAbBp7q4TlyZAoOqrgN7DhUH9Bo3OY3BLkWZKHS0setC0zL6Q67Hky4Rqrqx7Nj1KlfeuGQrRlCsI
 qwgwZclYE+W3lNuWSFNR/r+W2Hw+NDHeIZYOnANn5BM8Y19BPR9wWaR9N+xKBtVuc4t7xKpNSPypY
 LGwVMR0w==;
Received: from [154.49.97.70] (helo=[127.0.0.1])
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1r68oO-00D1r7-1U; Thu, 23 Nov 2023 12:28:04 +0000
Date: Thu, 23 Nov 2023 12:27:58 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
CC: "paul@xen.org" <paul@xen.org>, Stefano Stabellini <sstabellini@kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Julien Grall <julien@xen.org>,
 Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_4/6=5D_xen=5Fpvdev=3A_Do_not_?=
 =?US-ASCII?Q?assume_Dom0_when_creating_a_directory?=
User-Agent: K-9 Mail for Android
In-Reply-To: <87v89swtmz.fsf@epam.com>
References: <20231121221023.419901-1-volodymyr_babchuk@epam.com>
 <20231121221023.419901-5-volodymyr_babchuk@epam.com>
 <b04daedc-ba6a-4109-8e23-fbcd023bcfec@xen.org>
 <alpine.DEB.2.22.394.2311221428570.2053963@ubuntu-linux-20-04-desktop>
 <ce719f35e72a9387fc04af098e6d688f9bbdca4e.camel@infradead.org>
 <alpine.DEB.2.22.394.2311221508270.2424505@ubuntu-linux-20-04-desktop>
 <a4e6a62a7cfe756344a1efcb8b2c3cfb1e50817e.camel@infradead.org>
 <alpine.DEB.2.22.394.2311221515010.2424505@ubuntu-linux-20-04-desktop>
 <87r0khz6zj.fsf@epam.com> <87cyw1z61i.fsf@epam.com>
 <dce4efb0-4fdc-404c-8e5d-c90ed732eb8a@xen.org> <87bkbky9bb.fsf@epam.com>
 <5941AF2D-71E7-4A5B-A519-25F87F90DC05@infradead.org>
 <87v89swtmz.fsf@epam.com>
Message-ID: <C2DEE963-41CB-4377-93FD-BD9FB500926F@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+39fc1edcc778f4c9f1e2+7396+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 23 November 2023 12:17:57 GMT, Volodymyr Babchuk <Volodymyr_Babchuk@epam=
=2Ecom> wrote:
>
>Hi David,
>
>David Woodhouse <dwmw2@infradead=2Eorg> writes:
>> Which PV backends do you care about? We already have net, block and con=
sole converted=2E
>
>Well, this is all what we need, actually=2E Even console only will be
>sufficient, as we are using QEMU to provide virtio-pci backends, so both
>storage and networking should be provided by virtio=2E Are you proposing
>to just drop this patch at all? I believe we can live without it, yes=2E

Yeah, I think you can drop anything that's only needed for the legacy back=
ends=2E I'm tempted to make a separate config option to compile those out=
=2E


