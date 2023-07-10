Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D2874D208
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:45:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInS1-0008Ug-7B; Mon, 10 Jul 2023 05:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qInRk-0008Tt-IU
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:44:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qInRi-00023i-SA
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688982282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2M+q/Tlbu2gT7CS8TKMeQ+riCC+Uep6n1TBO9k3J6Jo=;
 b=JcntfJZhLVyBmQSptyOz4VqupnPPDuhdWtaN+LarhPMCVwA9t7C+zmFif2uNShYsBCb3KF
 EzKGMvXdVv+N01IkUcrH1LehS1K1QBe6d71vVmYCB/U+BnZwSPQzCmroSZJPIAh9kd0PJJ
 +MereXfphJ0mpXL/Muim7O8JuiVTWYk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-Q4HqjC3rNySo9C94qfeTLQ-1; Mon, 10 Jul 2023 05:44:40 -0400
X-MC-Unique: Q4HqjC3rNySo9C94qfeTLQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-315a03cae87so186966f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 02:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688982277; x=1691574277;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2M+q/Tlbu2gT7CS8TKMeQ+riCC+Uep6n1TBO9k3J6Jo=;
 b=JbP47IWrCPYT4fb+zJvciUfMvDrLP2PD9oUXNEmQ9hqtr8Q5x4aTIZCnz7qrKoOJ36
 Y2c6QGRkcR1iIlkvIg/HUT92yuNb5v3Jn6ybRDOTMKi4WVaYsj+FDQiYu74mHOJ5Cxeu
 JdRVp+dnmReYFurIURVQ4zWADbTEU4iw4lNTh4bwIqUwmVowXq8b5YoTDUpKFtDPejJ3
 ZGJnXMnEeLew0UxM8bYBUpI6q9IWFhONAJg4u2J39HA+6QSEF1uCwNLCdr+ShHwEiG4e
 /Wmv5urv5Lc7bIS8gI8hH2u/Hi+l4Tuy3jlMF+DWXMFhMD4dRzRDSomfr6Z7O3oWbdKk
 zYoQ==
X-Gm-Message-State: ABy/qLZDYbEmlpK/FH/ln9bwrJl5AwnM30XyeXySO6dpB6ovTMGQaO0P
 azR4kLWj7qAigyirtTQnDYmMyWFBHf9EPaaY3dDWPHZ22ac3qXnls+MtPdJlRFyKBalFWvfeNzP
 kKGw16JtkCx348Gs=
X-Received: by 2002:a5d:5142:0:b0:313:ee8b:8489 with SMTP id
 u2-20020a5d5142000000b00313ee8b8489mr14178709wrt.10.1688982277602; 
 Mon, 10 Jul 2023 02:44:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEAuDSDF/9m/59MWyY2FYklF9ssqNG8wG9zkSb5dccbJzn24TTBqSSzjjb6tzc4//kCKfL0WQ==
X-Received: by 2002:a5d:5142:0:b0:313:ee8b:8489 with SMTP id
 u2-20020a5d5142000000b00313ee8b8489mr14178695wrt.10.1688982277294; 
 Mon, 10 Jul 2023 02:44:37 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 d8-20020adff848000000b0031128382ed0sm11183044wrq.83.2023.07.10.02.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 02:44:36 -0700 (PDT)
Date: Mon, 10 Jul 2023 05:44:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v5 2/2] pcie: Specify 0 for ARI next function numbers
Message-ID: <20230710054117-mutt-send-email-mst@kernel.org>
References: <20230705022421.13115-1-akihiko.odaki@daynix.com>
 <20230705022421.13115-3-akihiko.odaki@daynix.com>
 <E8241AB3-F645-4697-A5AC-9B6BC897B432@redhat.com>
 <20230710051539-mutt-send-email-mst@kernel.org>
 <B82575EB-132B-4B15-B9EC-89B947826367@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B82575EB-132B-4B15-B9EC-89B947826367@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jul 10, 2023 at 02:49:55PM +0530, Ani Sinha wrote:
> 
> 
> > On 10-Jul-2023, at 2:46 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Mon, Jul 10, 2023 at 01:21:50PM +0530, Ani Sinha wrote:
> >> 
> >> 
> >>> On 05-Jul-2023, at 7:54 AM, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >>> 
> >>> The current implementers of ARI are all SR-IOV devices. The ARI next
> >>> function number field is undefined for VF according to PCI Express Base
> >>> Specification Revision 5.0 Version 1.0 section 9.3.7.7. The PF should
> >>> end the linked list formed with the field by specifying 0 according to
> >>> section 7.8.7.2.
> >> 
> >> Section 7.8.7.2 ARI Capability Register (Offset 04h), I see only this
> >> 
> >> Next Function Number - This field indicates the Function Number of the next higher numbered Function in the Device, or 00h if there are no higher numbered Functions. Function 0 starts this linked list of Functions.
> >> 
> >> I do not see anything specifically for PF. What am I missing?
> > 
> > This is *only* for PFs.
> 
> I think this covers both SRIOV and non SRIOV cases both. This is a
> general case for all devices, PF or other non-SRIOV capable devices.

"this" being what? I'm talking about the pci spec text
you quoted.

check out the sriov spec:
Next Function Number – VFs are located using First
VF Offset (see Section 3.3.9) and VF Stride (see
Section 3.3.10).



> > There's separate text explaining that
> > VFs use NumVFs VFOffset and VFStride.
> > 
> > 
> >>> 
> >>> For migration, the field will keep having 1 as its value on the old
> >>> virt models.
> >>> 
> >>> Fixes: 2503461691 ("pcie: Add some SR/IOV API documentation in docs/pcie_sriov.txt")
> >>> Fixes: 44c2c09488 ("hw/nvme: Add support for SR-IOV")
> >>> Fixes: 3a977deebe ("Intrdocue igb device emulation")
> >>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>> ---
> >>> include/hw/pci/pci.h | 2 ++
> >>> hw/core/machine.c    | 1 +
> >>> hw/pci/pci.c         | 2 ++
> >>> hw/pci/pcie.c        | 2 +-
> >>> 4 files changed, 6 insertions(+), 1 deletion(-)
> >>> 
> >>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> >>> index e6d0574a29..9c5b5eb206 100644
> >>> --- a/include/hw/pci/pci.h
> >>> +++ b/include/hw/pci/pci.h
> >>> @@ -209,6 +209,8 @@ enum {
> >>>    QEMU_PCIE_CAP_CXL = (1 << QEMU_PCIE_CXL_BITNR),
> >>> #define QEMU_PCIE_ERR_UNC_MASK_BITNR 11
> >>>    QEMU_PCIE_ERR_UNC_MASK = (1 << QEMU_PCIE_ERR_UNC_MASK_BITNR),
> >>> +#define QEMU_PCIE_ARI_NEXTFN_1_BITNR 12
> >>> +    QEMU_PCIE_ARI_NEXTFN_1 = (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
> >>> };
> >>> 
> >>> typedef struct PCIINTxRoute {
> >>> diff --git a/hw/core/machine.c b/hw/core/machine.c
> >>> index 46f8f9a2b0..f0d35c6401 100644
> >>> --- a/hw/core/machine.c
> >>> +++ b/hw/core/machine.c
> >>> @@ -41,6 +41,7 @@
> >>> 
> >>> GlobalProperty hw_compat_8_0[] = {
> >>>    { "migration", "multifd-flush-after-each-section", "on"},
> >>> +    { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
> >>> };
> >>> const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
> >>> 
> >>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >>> index e2eb4c3b4a..45a9bc0da8 100644
> >>> --- a/hw/pci/pci.c
> >>> +++ b/hw/pci/pci.c
> >>> @@ -82,6 +82,8 @@ static Property pci_props[] = {
> >>>    DEFINE_PROP_UINT32("acpi-index",  PCIDevice, acpi_index, 0),
> >>>    DEFINE_PROP_BIT("x-pcie-err-unc-mask", PCIDevice, cap_present,
> >>>                    QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> >>> +    DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
> >>> +                    QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> >>>    DEFINE_PROP_END_OF_LIST()
> >>> };
> >>> 
> >>> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> >>> index 9a3f6430e8..cf09e03a10 100644
> >>> --- a/hw/pci/pcie.c
> >>> +++ b/hw/pci/pcie.c
> >>> @@ -1030,7 +1030,7 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
> >>> /* ARI */
> >>> void pcie_ari_init(PCIDevice *dev, uint16_t offset)
> >>> {
> >>> -    uint16_t nextfn = 1;
> >>> +    uint16_t nextfn = dev->cap_present & QEMU_PCIE_ARI_NEXTFN_1 ? 1 : 0;
> >>> 
> >>>    pcie_add_capability(dev, PCI_EXT_CAP_ID_ARI, PCI_ARI_VER,
> >>>                        offset, PCI_ARI_SIZEOF);
> >>> -- 
> >>> 2.41.0
> >>> 
> > 


