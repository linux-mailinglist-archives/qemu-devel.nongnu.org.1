Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5A973B5DE
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 13:10:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCefK-0005yW-Vc; Fri, 23 Jun 2023 07:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qCefH-0005y8-NX
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 07:09:19 -0400
Received: from collins.uni-paderborn.de ([2001:638:502:c003::14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qCefE-0006H4-KE
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 07:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mfpe2GQB+QX8jp4PZQhxZ76JJR+FPEvKYnPDBLB/Bfs=; b=uCVkkoGTfE3DWBCm5TG/QYAOlf
 f87MvsJtrvZKO65zBrJOUVN7hk5N1uDqH58eZDMG+hrEmPDNDq4cvm6+A/VSEhr4rsbyT29smZHav
 dAgFe2F+Ygs8LplXHqA0nUpY/dz4Nt0llFVO+QdCUDdO8XxBfQwIg/V0yNkVb2WhCEys=;
Date: Fri, 23 Jun 2023 13:09:02 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Siqi Chen <coc.cyqh@gmail.com>
Subject: Re: [PULL 09/20] target/tricore: Fix out-of-bounds index in imask
 instruction
Message-ID: <kvoqsipnaikzgovgjzfmtko6znek3jw7yra3angl6tmeowr7ow@54kbrpvxdfyw>
References: <20230621161422.1652151-1-kbastian@mail.uni-paderborn.de>
 <20230621161422.1652151-10-kbastian@mail.uni-paderborn.de>
 <c41c4ee2-29ae-78e8-612f-2d951f359540@tls.msk.ru>
 <yury4wdzf434fmo6ty2mjmtc7u5bzg7bwak62s6us2a755tui5@5kwkzemwb6xl>
 <e2a2fb5c-906a-9c42-e120-93651d548efd@tls.msk.ru>
 <e77777fcuuipjbqhvj5u3fcix4gex55bpbo4fmg5u7j4i27ybg@hkylkdjknanz>
 <7122632b-1628-8ebf-34b6-06e4c8b1c51c@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7122632b-1628-8ebf-34b6-06e4c8b1c51c@tls.msk.ru>
X-IMT-Source: Extern
X-IMT-Spam-Score: 0.0 ()
X-IMT-rspamd-score: 4
X-IMT-rspamd-bar: /
X-Sophos-SenderHistory: ip=79.202.219.6, fs=1363435, da=175127608, mc=185, sc=0,
 hc=185, sp=0, fso=1363435, re=0, sd=0, hd=0
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.23.110017, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::14;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=collins.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Jun 23, 2023 at 01:29:23PM +0300, Michael Tokarev wrote:
> 23.06.2023 12:51, Bastian Koppelmann wrote:
> 
> Here we go:
>  https://www.qemu.org/docs/master/devel/stable-process.html
> 
> Basically, any bugfix you, as a subsystem maintainer, think is good for stable,
> is good for stable :)  Usual tradeoff applies: more complex stuff with potential
> to break something vs seriousness of an issue.

That helps a lot!

Thanks,
Bastian

