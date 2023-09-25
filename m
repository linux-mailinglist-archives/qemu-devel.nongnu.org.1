Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D1E7AE03A
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 22:14:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkrxL-0004X6-Af; Mon, 25 Sep 2023 16:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <linux+qemu-devel=nongnu.org@armlinux.org.uk>)
 id 1qkrxI-0004Wh-8u
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 16:13:20 -0400
Received: from pandora.armlinux.org.uk ([2001:4d48:ad52:32c8:5054:ff:fe00:142])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <linux+qemu-devel=nongnu.org@armlinux.org.uk>)
 id 1qkrxF-0002PP-GQ
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 16:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=00Vye0AwWLIPBMODYPNFehasw86ZiZYbsbuGrJxr2N8=; b=P/010aGDqRn81i7BeyzDbwnBFp
 1Acvh+eQ1re3F9NX/J7wuI40gFCaLDNr9gTfe0zDzlAcZ2c3x+M3fy1J1LzTUtp77NCsFFBvtuyqy
 dwv18vHqnYIfl2y6tXgjXCZOh2MhRHL+uImGT+5RqL2ycX1j+4l8Jnep7ADL7qOxHRlbdVULbgwqB
 tUL7SdwWV5Um5ZHumJrfTmSYIuifmKkXgK+OyXwZup1DEmpIIVb8Xcc55l+L7pUeoP1m/YWNPyZ5N
 SdyWC69YeSbwb1p4bZFpSgESiEP9ZhrWAuzXC6Uii/sDHxgarj8Uw1pdyMCQ5MxW0EAywS2KqntSy
 YJbXDDtw==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42842)
 by pandora.armlinux.org.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <linux@armlinux.org.uk>) id 1qkrx1-0001Xs-0q;
 Mon, 25 Sep 2023 21:13:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1qkrwx-000875-Gn; Mon, 25 Sep 2023 21:12:59 +0100
Date: Mon, 25 Sep 2023 21:12:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lorenzo.pieralisi@linaro.com" <lorenzo.pieralisi@linaro.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "will@kernel.org" <will@kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "ardb@kernel.org" <ardb@kernel.org>,
 "justin.he@arm.com" <justin.he@arm.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>
Subject: Re: [PATCH RFC V2 00/37] Support of Virtual CPU Hotplug for ARMv8 Arch
Message-ID: <ZRHpyxCe8ybsxKck@shell.armlinux.org.uk>
References: <20230925194333.18244-1-salil.mehta@huawei.com>
 <1ba2e69bf0a94c1498ab5863b365559b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ba2e69bf0a94c1498ab5863b365559b@huawei.com>
Received-SPF: none client-ip=2001:4d48:ad52:32c8:5054:ff:fe00:142;
 envelope-from=linux+qemu-devel=nongnu.org@armlinux.org.uk;
 helo=pandora.armlinux.org.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 25, 2023 at 08:03:56PM +0000, Salil Mehta wrote:
> Looks like some problem with Huawei's mail server server. No patches
> except the cover letter are reaching the qemu-devel mailing-list.

I haven't seen any of the actual patches - just the cover letters.
Was that intentional?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

