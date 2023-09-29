Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A244D7B2C79
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 08:40:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm78v-0003Sg-Tv; Fri, 29 Sep 2023 02:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qm78t-0003S2-D6
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:38:27 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qm78q-0006ij-U5
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ooyzdWDgFqKunR7HCSZthCue+KddL4Yf+vQC6mFVL9Y=; b=KAmvTnM2TVhZk8Bb1MnaIk12v2
 czo/xZXkpS8yBVr9jajjvHFh1axCLWTQ/GoWMkKqwKhNE10KTfT/XbHv2nCKVNwvoXk6r35CYTzW4
 QFM1TMWjnq8htlyVJ5Q98pyhe2oUUN2ZPOMIBph7m9wCWhnPuVlSdN2XSA85YFuoG6p8=;
Date: Fri, 29 Sep 2023 08:38:08 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v2 00/21] tricore queue
Message-ID: <7yjmx6eiybypd4tqiw3li75woblbkfgrk23nrauflhnsva6iiv@fptg5exu4ct7>
References: <20230928085303.511518-1-kbastian@mail.uni-paderborn.de>
 <CAJSP0QVgH+9-ethHt5vWDraS+dpQssrbzkuxu95FONhWCNKOog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QVgH+9-ethHt5vWDraS+dpQssrbzkuxu95FONhWCNKOog@mail.gmail.com>
X-IMT-Source: Extern
X-IMT-rspamd-score: -17
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.29.62717, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.24.602001
X-Sophos-SenderHistory: ip=79.202.213.239, fs=162132, da=183578561, mc=43, sc=0,
 hc=43, sp=0, fso=162132, re=0, sd=0, hd=0
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::17;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=zuban.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

Hi,

On Thu, Sep 28, 2023 at 10:26:18AM -0400, Stefan Hajnoczi wrote:
> Please take a look at these CI test failures:
> https://gitlab.com/qemu-project/qemu/-/jobs/5185201978
> https://gitlab.com/qemu-project/qemu/-/jobs/5185202098

I'll fix the build failure and drop the patches that fail the TriCore asm tests.

Cheers,
Bastian

