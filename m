Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C8B757EF1
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 16:04:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLlIJ-0003Cp-1t; Tue, 18 Jul 2023 10:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=55665d270=anthony.perard@citrix.com>)
 id 1qLlIF-0003CW-9Y
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 10:03:13 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=55665d270=anthony.perard@citrix.com>)
 id 1qLlI9-0004Rg-Pt
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 10:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1689688985;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GOEiTo2SAh1GR9PtyGhW80/2ZGU4IhoAEZyhDXnoX0E=;
 b=CouYSivNwhv/4aAIYpDoHStXBddNbua3GaG+axcMmG4AZpTs7IjFSbfV
 2HMjI4IvbnvicsGmPvVQ/N+Y3PqFagPSwGupEqdRX6JJqls6j7jCEnb4+
 KeUqomdjd3PzNPc9Ox9fGqDU0yRI4Ixyz2BfbqK3dkYtoHZSA9c9etu8W 4=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 119190055
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:rPNhMqOxIyS02XPvrR1sl8FynXyQoLVcMsEvi/4bfWQNrUpx1GQAz
 zcYXDzSOK2NZ2qged0iaovlphkBvZGEy9VmSgto+SlhQUwRpJueD7x1DKtS0wC6dZSfER09v
 63yTvGacajYm1eF/k/F3oDJ9CU6jufQAOKnUoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE/
 Nj/uKUzAnf8s9JPGjxSs/vrRC9H5qyo42tH5wxmP5ingXeF/5UrJMNHTU2OByOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq/0Te5p0TJvsEAXq7vh3S9zxHJ
 HehgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/ZqAJGpfh66wGMa04AWEX0vZzJX0R1
 tgkEgEINSikwMaox+ugZeY506zPLOGzVG8eknRpzDWfBvc6W5HTBa7N4Le03h9p2JoIR6yHI
 ZNEN3w2Nk+ojx5nYz/7DLo3mvuogX/uNSVVsluPqYI84nTJzRw327/oWDbQUoXTFJwExh7F+
 woq+UzCKQkjEM7FkwOM63WqubWMvh2jB6QrQejQGvlC3wTImz175ActfUO2vfSjzEu3St5SL
 0g8/isopLI1skuxQbHVRhC9vTuIswARX/JWFOs17hzLzbDbiy6CHXQNRDNFbN0gtec1SCYs2
 1vPmMnmbRR3uaCRYWKQ8PGTtzzaESQKKHAqbCoNXwwDpdLk5pww5jrGVtt5GbS5psH0Ezr3h
 TuNqUADa6471JBRkf/hpBae3mzq/8KSJuIo2unJdnKhyh8mR6qZXb2tsmD8qtJeK9+CYVbU6
 RDohPOiAPAy4YClzXLdEbtTQu3xuZ5pIxWH3wcxQsBJGyCFvif6INsOuGwWyFJBaJ5sRNP/X
 KPEVeq9Drd3NWDiU6J4apnZ5y8Cnfm5ToSNuhw5g7NzjnlNmOyvpnsGiba4hTyFraTWrYkxO
 I2AbeGnBmsABKJswVKeHrlNgOFyln9nlDyLHPgXKihLN5LEPBZ5rp9cbTOzgh0RtvvY8G05D
 f4EXyd19/mveLKnOXSGmWLiBVsLMWI6FfjLRz9/L4a+zv5dMDh5UZf5mOpxE7GJaowJzo/g5
 G+mYEZExTLX3DufQel8Qiw5OeyHsFcWhS5TABHAyn7zgiZ/MdjytvdCH3b1FJF+nNFeITdPZ
 6FtU6297j5nFlwrJxx1gUHBkbFf
IronPort-HdrOrdr: A9a23:s2zpVqNbR3Gq0sBcTvqjsMiBIKoaSvp037BL7TESdfUxSKalfq
 +V7ZcmPHPP+VEssQgb6Ki90cq7MBbhHPxOkO0s1N6ZNWGM2FdARLsC0WKI+UyYJ8SRzJ866U
 6iScRD4R/LYGSSQfyU3OBwKbgd/OU=
X-Talos-CUID: 9a23:Is6DG271SnbIrSx2mtss5EowBp8GVkHn/XKLG2j/LXhuEaa6RgrF
X-Talos-MUID: 9a23:brzEJwhn+Mq9VEIIgeFlxsMpD+xw2oC8Uho0mIwBvfbedg9OY2i7tWHi
X-IronPort-AV: E=Sophos;i="6.01,214,1684814400"; d="scan'208";a="119190055"
Date: Tue, 18 Jul 2023 15:02:45 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Paul
 Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH for-8.1] xen: Don't pass MemoryListener around by value
Message-ID: <f8dcb293-b340-406d-8bdd-84d919f312be@perard>
References: <20230718101057.1110979-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230718101057.1110979-1-peter.maydell@linaro.org>
Received-SPF: pass client-ip=216.71.155.144;
 envelope-from=prvs=55665d270=anthony.perard@citrix.com;
 helo=esa4.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Jul 18, 2023 at 11:10:57AM +0100, Peter Maydell wrote:
> Coverity points out (CID 1513106, 1513107) that MemoryListener is a
> 192 byte struct which we are passing around by value.  Switch to
> passing a const pointer into xen_register_ioreq() and then to
> xen_do_ioreq_register().  We can also make the file-scope
> MemoryListener variables const, since nothing changes them.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

