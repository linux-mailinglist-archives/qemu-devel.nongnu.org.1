Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4677EB39A
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 16:31:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2vNx-0005W4-Bi; Tue, 14 Nov 2023 10:31:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+c0bb53cb81094deeb936+7387+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1r2vNr-0005Mo-Dg; Tue, 14 Nov 2023 10:31:26 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+c0bb53cb81094deeb936+7387+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1r2vNc-0001tl-7w; Tue, 14 Nov 2023 10:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=kI8asQVhOaGuY/UltcD2EIrkJh3iOIJyA9g6wBOXluk=; b=R37YxD+21q3rf7xOFOp0slG+f9
 +xj/jKvNgv2ak6vgeuM+oEd2TkBIrpwWMJy0gnQcercjtVz0+mTVGvTGDNWhjq4sdt8mS8vT2l7kc
 cCVXqCeU4NDM74DxDlIgJqP/GLCUxRQSTOl+PT+Z35apucO6sEy7bPEf49aVglTMc2pLE3I+kOydB
 J4App7NzjOK0V0Snxpc2LLxYHcNIJDg0zhJ6Coc8TLNESIe2d73wUUsvlMLbUNqirlTy35l/Zljmx
 PjXYgavZnBmkovcuK4k/jZK6a20DhrEPQC04p8avEnhGf2OC45ZjGUXflE0pqgHzZwBJEKOjwrhXB
 zZOQGefw==;
Received: from [31.94.7.206] (helo=[127.0.0.1])
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1r2vNT-002WtI-0X; Tue, 14 Nov 2023 15:30:59 +0000
Date: Tue, 14 Nov 2023 10:30:48 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>, qemu-devel@nongnu.org
CC: =?ISO-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>, kvm@vger.kernel.org,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH-for-9=2E0_v2_?=
 =?US-ASCII?Q?09/19=5D_hw/block/xen=5Fblkif=3A?=
 =?US-ASCII?Q?_Align_structs_with_QEMU=5FA?=
 =?US-ASCII?Q?LIGNED=28=29_instead_of_=23pragma?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20231114143816.71079-10-philmd@linaro.org>
References: <20231114143816.71079-1-philmd@linaro.org>
 <20231114143816.71079-10-philmd@linaro.org>
Message-ID: <292FEC54-80CC-4C17-8027-F1CB3609FDF5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+c0bb53cb81094deeb936+7387+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
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

On 14 November 2023 09:38:05 GMT-05:00, "Philippe Mathieu-Daud=C3=A9" <phil=
md@linaro=2Eorg> wrote:
>Except imported source files, QEMU code base uses
>the QEMU_ALIGNED() macro to align its structures=2E
>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>

Can we have a BUILD_BUG_ON(sizeof=3D=3D) for these please?



