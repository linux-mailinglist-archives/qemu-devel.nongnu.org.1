Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD9374BC76
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 09:01:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI1wf-0006LH-9v; Sat, 08 Jul 2023 03:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qI1wc-0006Fg-2X
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 03:01:26 -0400
Received: from collins.uni-paderborn.de ([2001:638:502:c003::14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qI1wZ-0003li-FG
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 03:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qF+npiQP+E+XfTS7OLreNCTZoOPYSA4lvsEdg1B/HsE=; b=h3IJHHZSC4xnws5cYJ6hI4gnsF
 9ogQUmotKAg7bp4oy23oSgusXrCCrcS5xak27yM32nX2qZB6rQ1eiOWjw8gtjlZZCY0Ki/IKLHzPn
 5ibDFe2eQO85swckJOf0Y5uhEEZO4JccgadtrZ5J6J6UZK1Ng3QrOshe1+KyotSwEI1g=;
Date: Sat, 8 Jul 2023 09:01:14 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Rui Chen <chenrui333@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] chore: rename `tricore_feature` to
 `is_tricore_feature_enabled`
Message-ID: <f2inrfp4qdtp6za6gpvkwopw36fqsatla3p3jawizcmtk3kivq@dv5trkjll4c2>
References: <CA+PgxXVxVKpT0SZ3N+Fc1YvXCiwkkbqm0FmLKqLTbgcDpYCNgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+PgxXVxVKpT0SZ3N+Fc1YvXCiwkkbqm0FmLKqLTbgcDpYCNgg@mail.gmail.com>
X-IMT-Source: Extern
X-IMT-Spam-Score: 0.0 ()
X-IMT-rspamd-score: 9
X-IMT-rspamd-bar: /
X-Sophos-SenderHistory: ip=79.202.219.6, fs=2644568, da=176408741, mc=186, sc=0,
 hc=186, sp=0, fso=2644568, re=0, sd=0, hd=0
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.7.8.64816, AntiVirus-Engine: 6.0.0,
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

Hi Rui,

On Thu, Jul 06, 2023 at 12:59:55PM -0400, Rui Chen wrote:
> While upgrading capstone to v5, there was some name clash with the
> tricore_feature in capstone (which was introduced in this PR), thus rename
> tricore_feature to is_tricore_feature_enabled.
> 
> Build error log is below
> 
> /opt/homebrew/Cellar/capstone/5.0/include/capstone/tricore.h:561:3: error:
> redefinition of 'tricore_feature' as different kind of symbol
> } tricore_feature;
>   ^
> ../target/tricore/cpu.h:261:19: note: previous definition is here
> static inline int tricore_feature(CPUTriCoreState *env, int feature)
>                   ^
> 1 error generated.

I ran into the same problem when trying out capstone. I think a better name
would be tricore_has_feature() to match has_feature() in
target/tricore/translate.c.

P.S. if you CC me it helps my mail filter to find your patch :). Also we have
the rule for qemu-devel to not send a patch as a attachment. See
(https://www.qemu.org/docs/master/devel/submitting-a-patch.html)

Cheers,
Bastian

