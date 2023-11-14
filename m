Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDA07EB342
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 16:15:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2v7Z-000208-PC; Tue, 14 Nov 2023 10:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+a8e905033730cff805ca+7387+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1r2v7U-0001vF-OE; Tue, 14 Nov 2023 10:14:28 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+a8e905033730cff805ca+7387+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1r2v7O-00070X-0U; Tue, 14 Nov 2023 10:14:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=zLWRl6fuh+QlAq2JcSTCgSqOD3rW63ZP4Laj6regjn0=; b=CDbCkxBOGqoE0okEs41cvDk5fY
 avC36PbcnvrY2oGlWB+RQPF4liPIPZGR3EmI5Av83WCkoqFq/6JecFkFY7vUWsvo7/8BmYzi44D1g
 Ws5geOrtzOEM5Q+9dgkqYhjuO8CCj0m7FwKXRyGH/otFSxezkrYf7thCJcuan3UovTroWWy1VVTp0
 pnd+C2RYiX9iD91nqIjI4v94iVedb61DZAmiijnR8rGW40PapOik1v9uw6WmF0h27udRo7vUsUI+/
 CdQBeD4lSkTeDsX/DqpzXtj+VzppGTN+wtPUM4BmDuIgnKf9HDMxmYUNaj5vpn46oYHJTmkvPF/K5
 uuDkjPBA==;
Received: from [12.186.190.2] (helo=[127.0.0.1])
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1r2v73-008dEf-2f; Tue, 14 Nov 2023 15:14:01 +0000
Date: Tue, 14 Nov 2023 10:13:58 -0500
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
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH-for-9=2E0_v2_06/19=5D_hw/pci/msi?=
 =?US-ASCII?Q?=3A_Restrict_xen=5Fis=5Fpirq=5Fmsi=28=29_call_to_Xen?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20231114143816.71079-7-philmd@linaro.org>
References: <20231114143816.71079-1-philmd@linaro.org>
 <20231114143816.71079-7-philmd@linaro.org>
Message-ID: <EEC18CA6-88F2-4F18-BDE5-5E9AAE5778A7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+a8e905033730cff805ca+7387+infradead.org+dwmw2@casper.srs.infradead.org;
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

On 14 November 2023 09:38:02 GMT-05:00, "Philippe Mathieu-Daud=C3=A9" <phil=
md@linaro=2Eorg> wrote:
>Similarly to the restriction in hw/pci/msix=2Ec (see commit
>e1e4bf2252 "msix: fix msix_vector_masked"), restrict the
>xen_is_pirq_msi() call in msi_is_masked() to Xen=2E
>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>

Hm, we do also support the Xen abomination of snooping on MSI table writes=
 to see if they're targeted at a Xen PIRQ, then actually unmasking the MSI =
from QEMU when the guest binds the corresponding event channel to that PIRQ=
=2E

I think this is going to break in CI as kvm_xen_guest=2Epy does deliberate=
ly exercise that use case, doesn't it?

I deliberately *didn't* switch to testing the Xen PV net device, with a co=
mment that testing MSI and irqchip permutations was far more entertaining=
=2E So I hope it should catch this?


