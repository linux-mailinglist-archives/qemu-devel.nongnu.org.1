Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA087AE6CF
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 09:28:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql2Sj-0006Xq-Nx; Tue, 26 Sep 2023 03:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+2a2c9b7848046cbd39dd+7338+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1ql2Sf-0006W4-5T
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 03:26:25 -0400
Received: from bombadil.infradead.org ([2607:7c80:54:3::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+2a2c9b7848046cbd39dd+7338+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1ql2SZ-0000Ri-Jp
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 03:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=NznSBD2uteqB9qxa+hTMt7JkHTRzuMUHjjRchlfeKyg=; b=G7bzPPhTZKVUlgbOowLdMfh/WB
 A4eCYjDlDRP6tO7FUtuNHGSvEtsgZokP3NWpYBEdnape2papZwgcJt1Lza12XveBTwAcfsF8DnrjQ
 JjWf4X1ePyTmIhod9yExdhzkMCEOlkF7hXx5iOPtJHjDTDp6GmuPrCVtxmX5GYEJc5BhJSVKoZees
 3HZtooXsPnNVTS9mBTyrWrhAHvZrWYkJj+iLjaygtE4EWx1L+hOpvoWkNz3j+n8Gw3uQjhkt0BNwl
 wEF/IItGRkgjPtbVJ3rqR2F97yhP8ZtowC0H56ISriZw3zpMKkLUkCHa2OVQqdpAKR82VRla6TdnW
 bi176l4g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1ql2SG-00FnBM-1p; Tue, 26 Sep 2023 07:26:00 +0000
Date: Tue, 26 Sep 2023 00:26:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kishon Vijay Abraham I <kvijayab@amd.com>
Cc: Shunsuke Mie <mie@igel.co.jp>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, vaishnav.a@ti.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC] Proposal of QEMU PCI Endpoint test environment
Message-ID: <ZRKHiE9iFuHGUkHV@infradead.org>
References: <CANXvt5oKt=AKdqv24LT079e+6URnfqJcfTJh0ajGA17paJUEKw@mail.gmail.com>
 <d096e88e-aec5-9920-8d5a-bd8200560c2c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d096e88e-aec5-9920-8d5a-bd8200560c2c@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2607:7c80:54:3::133;
 envelope-from=BATV+2a2c9b7848046cbd39dd+7338+infradead.org+hch@bombadil.srs.infradead.org;
 helo=bombadil.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 21, 2023 at 02:41:54PM +0530, Kishon Vijay Abraham I wrote:
> > PCI Endpoint function driver is implemented using the PCIe Endpoint
> > framework, but it requires physical boards for testing, and it is difficult
> > to test sufficiently. In order to find bugs and hardware-dependent
> > implementations early, continuous testing is required. Since it is
> > difficult to automate tests that require hardware, this RFC proposes a
> > virtual environment for testing PCI endpoint function drivers.
> 
> This would be quite useful and thank you for attempting it! I would like to
> compare other mechanisms available in-addition to QEMU before going with the
> QEMU approach.

Well, the point of PCIe endpoint subsystem in vhost or similar is that
you can use one and the same endpoint implementation.  So you can debug
it using qemu and the use it with a physical port, which would be really
amazing.


