Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 475847EE70F
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 19:58:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3hYC-0005td-TD; Thu, 16 Nov 2023 13:57:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+0547470b7b70d81452c7+7389+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1r3hYA-0005tV-Vk
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:57:14 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+0547470b7b70d81452c7+7389+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1r3hY5-0002Ip-Pj
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:57:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=WmEXYsKGmKNQw51vviAPrneH8YnuKGEUgfTeS7n4L6U=; b=beZ53cEcla0C1aEDQU0bSDaYP2
 fiV2wWE6ST95kKalnTkhGz5/cYkEnKfNfXfOFAizq2TOo+IKqP/1yXB7pFhHq9wFGXZ38hmJ4XLg1
 Xy05Lir5Wl0t94tR+KPdulwlh1I0fjHOSNpyh+cEq47vpK/q21KTR3J9ho25XztCY7P2/BKv17+O0
 yLho3xw0Xk1S7SKuvFNyEal3N3xJ+rKdI0Rntf3DeT1YlCSUxTYC2AjUtPLIW9hMAf2ARWmzca5kJ
 mwXgkM5YMLRr2Sy7o4pDqYFQWaiOM4dAUu2D9nbjmVrS0qt40zpeRpgRvIPc8sxuJTQTtizu5VzUb
 Sw4yagjA==;
Received: from [50.201.115.146] (helo=[127.0.0.1])
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1r3hY1-004jO5-42; Thu, 16 Nov 2023 18:57:05 +0000
Date: Thu, 16 Nov 2023 13:56:55 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
CC: =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_for-8=2E2=5D_Revert_=22ui/conso?=
 =?US-ASCII?Q?le=3A_allow_to_override_the_default_VC=22?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20231116182228.3062796-1-peter.maydell@linaro.org>
References: <20231116182228.3062796-1-peter.maydell@linaro.org>
Message-ID: <1A6C710D-57B1-423D-BA55-3E4D30019203@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+0547470b7b70d81452c7+7389+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 16 November 2023 13:22:28 GMT-05:00, Peter Maydell <peter=2Emaydell@lina=
ro=2Eorg> wrote:
>This reverts commit 1bec1cc0da497e55c16e2a7b50f94cdb2a02197f=2E  This
>commit changed the behaviour of the "-display none" option, so that
>it now creates a QEMU monitor on the terminal=2E  "-display none"
>should not be tangled up with whether we create a monitor or a serial
>terminal; it should purely and only disable the graphical window=2E
>Changing its behaviour like this breaks command lines which, for
>example, use semihosting for their output and don't want a graphical
>window, as they now get a monitor they never asked for=2E
>
>It also breaks the command line we document for Xen in
>docs/system/i386/xen=2Ehtml:
>
> $ =2E/qemu-system-x86_64 --accel kvm,xen-version=3D0x40011,kernel-irqchi=
p=3Dsplit \
>    -display none -chardev stdio,mux=3Don,id=3Dchar0,signal=3Doff -mon ch=
ar0 \
>    -device xen-console,chardev=3Dchar0  -drive file=3D${GUEST_IMAGE},if=
=3Dxen
>
>qemu-system-x86_64: cannot use stdio by multiple character devices
>qemu-system-x86_64: could not connect serial device to character backend =
'stdio'
>
>Revert the commit to restore the previous handling of "-display
>none"=2E
>
>Resolves: https://gitlab=2Ecom/qemu-project/qemu/-/issues/1974
>Signed-off-by: Peter Maydell <peter=2Emaydell@linaro=2Eorg>

Reviewed-by: <dwmw@amazon=2Eco=2Euk>


