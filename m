Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6418C9BB3E5
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Nov 2024 12:52:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7vbx-0003jP-AB; Mon, 04 Nov 2024 06:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t7vbu-0003j5-21
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:51:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t7vbp-0002m2-3M
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:51:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730721056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/fgR7sMErAw+e4iakqchgE+9PN6puFMeqMIHs7xgnVQ=;
 b=ZHwbeydxDAvx/VPAdxcl/MSv3IPfdIgklNwSWjIaqmn0rceFfz7vWoZSGdhgvbDRiTaX35
 TRO58c/5rOY+K2gd0Fp2VhIRR20l6A1rmpTIOtyItXlrlwkDgOvePgHC104uGyrVFXCThg
 q7xpudZfZhQ9uLcOgtBLehnWJhZvdNc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-d7g7xj6JN6atM4AZ7G4NUg-1; Mon, 04 Nov 2024 06:50:55 -0500
X-MC-Unique: d7g7xj6JN6atM4AZ7G4NUg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2fb58d1da8eso22326831fa.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 03:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730721054; x=1731325854;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/fgR7sMErAw+e4iakqchgE+9PN6puFMeqMIHs7xgnVQ=;
 b=hndiSyi+uZXr8bHk3ehm3hKZJqNb0wdI9KpEERQ+UgfMvaFldLmU8V6P7bajBRj2rF
 THK4yLkVcyQ5g0KX+Dn5mmQnzWjzOBk5D59IIAzuNCbrIytXaB4e7s5DRUxBEXBVp+P6
 Poi6sAiegjwC4YDpexPLU8biLrboMwVImv+TmRMQqZW7PcY3OrhKTYVvySxsuFTePuWT
 Ax/kdu52DVKZ6ynNtwWgqCYmdIJWbZMiDp4fYKyCqKGQfTBRi1LLNnCiDBxTVLkAPC2r
 xr0QYZDfgu5+h+mmMV+PUdPYqxav4bjQjAtu9kN4BCQovtsFzHgPcA54oqyVE1oUzzKc
 JIrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgmaHcmO0rqX3yqYdi+mbh+xdZkfFr7cSeT/4A9j6jouxD3WgwrnJzE69l1aAO/6vrGCYifGeyOcdT@nongnu.org
X-Gm-Message-State: AOJu0YwyRSbjVSNGrwEAV8uPl2N61qOK3JEeEFrn3r/9z/oxMz4xpcfA
 HaP0VV9RcOShGFvD8RVxgyR/FJQiGy0lPICK9KjCJ6dWSlvE9q9hMaEiXJPuA15/t6wX0eybyR/
 2gV+E+kaG+pk0pMSnEhIMMih0n/DiUWehw8e9vHG1BDoyX45bjPLA
X-Received: by 2002:ac2:4857:0:b0:539:d428:fbd1 with SMTP id
 2adb3069b0e04-53d65e176fcmr4674797e87.55.1730721053873; 
 Mon, 04 Nov 2024 03:50:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7DnRjo3M+mPxHB3BW/I+nPrcSxXhVdjIJHx/BEwGX22qHsLpxeUMosD/7WzhBR2NubpobFA==
X-Received: by 2002:ac2:4857:0:b0:539:d428:fbd1 with SMTP id
 2adb3069b0e04-53d65e176fcmr4674763e87.55.1730721053036; 
 Mon, 04 Nov 2024 03:50:53 -0800 (PST)
Received: from redhat.com ([2a02:14f:177:aecb:5a54:cf63:d69d:19ea])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5c6623sm150353785e9.20.2024.11.04.03.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 03:50:52 -0800 (PST)
Date: Mon, 4 Nov 2024 06:50:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v4 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Message-ID: <20241104065029-mutt-send-email-mst@kernel.org>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-5-zhenzhong.duan@intel.com>
 <3bb9da3b-f1de-4a3a-bdd8-37937ed15d50@intel.com>
 <14799ff1-8da4-4b42-921a-ad1198de1bdb@eviden.com>
 <119078eb-81f0-47a7-81b0-aaf6b7878581@intel.com>
 <SJ0PR11MB674422638A5915D608E9A80992512@SJ0PR11MB6744.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ0PR11MB674422638A5915D608E9A80992512@SJ0PR11MB6744.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Nov 04, 2024 at 11:46:00AM +0000, Duan, Zhenzhong wrote:
> 
> 
> >-----Original Message-----
> >From: Liu, Yi L <yi.l.liu@intel.com>
> >Sent: Monday, November 4, 2024 4:45 PM
> >Subject: Re: [PATCH v4 04/17] intel_iommu: Flush stage-2 cache in PASID-
> >selective PASID-based iotlb invalidation
> >
> >On 2024/11/4 15:37, CLEMENT MATHIEU--DRIF wrote:
> >>
> >>
> >> On 04/11/2024 03:49, Yi Liu wrote:
> >>> Caution: External email. Do not open attachments or click links, unless
> >>> this email comes from a known sender and you know the content is safe.
> >>>
> >>>
> >>> On 2024/9/30 17:26, Zhenzhong Duan wrote:
> >>>> Per spec 6.5.2.4, PADID-selective PASID-based iotlb invalidation will
> >>>> flush stage-2 iotlb entries with matching domain id and pasid.
> >>>
> >>> Also, call out it's per table Table 21. PASID-based-IOTLB Invalidation of
> >>> VT-d spec 4.1.
> >>>
> >>>> With scalable modern mode introduced, guest could send PASID-selective
> >>>> PASID-based iotlb invalidation to flush both stage-1 and stage-2 entries.
> >>>>
> >>>> By this chance, remove old IOTLB related definitions which were unused.
> >>>
> >>>
> >>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >>>> Reviewed-by: Cl�ment Mathieu--Drif<clement.mathieu--drif@eviden.com>
> >>>> Acked-by: Jason Wang <jasowang@redhat.com>
> >>>> ---
> >>>>  � hw/i386/intel_iommu_internal.h | 14 ++++--
> >>>>  � hw/i386/intel_iommu.c��������� | 88 +++++++++++++++++++++++++++++++++-
> >>>>  � 2 files changed, 96 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/
> >>>> intel_iommu_internal.h
> >>>> index d0f9d4589d..eec8090190 100644
> >>>> --- a/hw/i386/intel_iommu_internal.h
> >>>> +++ b/hw/i386/intel_iommu_internal.h
> >>>> @@ -403,11 +403,6 @@ typedef union VTDInvDesc VTDInvDesc;
> >>>>  � #define VTD_INV_DESC_IOTLB_AM(val)����� ((val) & 0x3fULL)
> >>>>  � #define VTD_INV_DESC_IOTLB_RSVD_LO����� 0xffffffff0000f100ULL
> >>>>  � #define VTD_INV_DESC_IOTLB_RSVD_HI����� 0xf80ULL
> >>>> -#define VTD_INV_DESC_IOTLB_PASID_PASID� (2ULL << 4)
> >>>> -#define VTD_INV_DESC_IOTLB_PASID_PAGE�� (3ULL << 4)
> >>>> -#define VTD_INV_DESC_IOTLB_PASID(val)�� (((val) >> 32) &
> >>>> VTD_PASID_ID_MASK)
> >>>> -#define VTD_INV_DESC_IOTLB_PASID_RSVD_LO����� 0xfff00000000001c0ULL
> >>>> -#define VTD_INV_DESC_IOTLB_PASID_RSVD_HI����� 0xf80ULL
> >>>>
> >>>>  � /* Mask for Device IOTLB Invalidate Descriptor */
> >>>>  � #define VTD_INV_DESC_DEVICE_IOTLB_ADDR(val) ((val) &
> >>>> 0xfffffffffffff000ULL)
> >>>> @@ -433,6 +428,15 @@ typedef union VTDInvDesc VTDInvDesc;
> >>>>  � #define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw) \
> >>>>  ��������� (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> >>>>
> >>>> +/* Masks for PIOTLB Invalidate Descriptor */
> >>>> +#define VTD_INV_DESC_PIOTLB_G������������ (3ULL << 4)
> >>>> +#define VTD_INV_DESC_PIOTLB_ALL_IN_PASID� (2ULL << 4)
> >>>> +#define VTD_INV_DESC_PIOTLB_PSI_IN_PASID� (3ULL << 4)
> >>>> +#define VTD_INV_DESC_PIOTLB_DID(val)����� (((val) >> 16) &
> >>>> VTD_DOMAIN_ID_MASK)
> >>>> +#define VTD_INV_DESC_PIOTLB_PASID(val)��� (((val) >> 32) & 0xfffffULL)
> >>>> +#define VTD_INV_DESC_PIOTLB_RSVD_VAL0���� 0xfff000000000f1c0ULL
> >>>> +#define VTD_INV_DESC_PIOTLB_RSVD_VAL1���� 0xf80ULL
> >>>> +
> >>>>  � /* Information about page-selective IOTLB invalidate */
> >>>>  � struct VTDIOTLBPageInvInfo {
> >>>>  ����� uint16_t domain_id;
> >>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >>>> index 9e6ef0cb99..72c9c91d4f 100644
> >>>> --- a/hw/i386/intel_iommu.c
> >>>> +++ b/hw/i386/intel_iommu.c
> >>>> @@ -2656,6 +2656,86 @@ static bool
> >>>> vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
> >>>>  ����� return true;
> >>>>  � }
> >>>>
> >>>> +static gboolean vtd_hash_remove_by_pasid(gpointer key, gpointer value,
> >>>> +���������������������������������������� gpointer user_data)
> >>>> +{
> >>>> +��� VTDIOTLBEntry *entry = (VTDIOTLBEntry *)value;
> >>>> +��� VTDIOTLBPageInvInfo *info = (VTDIOTLBPageInvInfo *)user_data;
> >>>> +
> >>>> +��� return ((entry->domain_id == info->domain_id) &&
> >>>> +����������� (entry->pasid == info->pasid));
> >>>> +}
> >>>> +
> >>>> +static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
> >>>> +��������������������������������������� uint16_t domain_id, uint32_t
> >>>> pasid)
> >>>> +{
> >>>> +��� VTDIOTLBPageInvInfo info;
> >>>> +��� VTDAddressSpace *vtd_as;
> >>>> +��� VTDContextEntry ce;
> >>>> +
> >>>> +��� info.domain_id = domain_id;
> >>>> +��� info.pasid = pasid;
> >>>> +
> >>>> +��� vtd_iommu_lock(s);
> >>>> +��� g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pasid,
> >>>> +������������������������������� &info);
> >>>> +��� vtd_iommu_unlock(s);
> >>>> +
> >>>> +��� QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> >>>> +������� if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> >>>> +������������������������������������� vtd_as->devfn, &ce) &&
> >>>> +����������� domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
> >>>> +����������� uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
> >>>> +
> >>>> +����������� if ((vtd_as->pasid != PCI_NO_PASID || pasid != rid2pasid) &&
> >>>> +��������������� vtd_as->pasid != pasid) {
> >>>> +��������������� continue;
> >>>> +����������� }
> >>>> +
> >>>> +����������� if (!s->scalable_modern) {
> >>>> +��������������� vtd_address_space_sync(vtd_as);
> >>>> +����������� }
> >>>> +������� }
> >>>> +��� }
> >>>> +}
> >>>> +
> >>>> +static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
> >>>> +����������������������������������� VTDInvDesc *inv_desc)
> >>>> +{
> >>>> +��� uint16_t domain_id;
> >>>> +��� uint32_t pasid;
> >>>> +
> >>>> +��� if ((inv_desc->val[0] & VTD_INV_DESC_PIOTLB_RSVD_VAL0) ||
> >>>> +������� (inv_desc->val[1] & VTD_INV_DESC_PIOTLB_RSVD_VAL1) ||
> >>>> +������� inv_desc->val[2] || inv_desc->val[3]) {
> >>>> +������� error_report_once("%s: invalid piotlb inv desc val[3]=0x%"PRIx64
> >>>> +������������������������� " val[2]=0x%"PRIx64" val[1]=0x%"PRIx64
> >>>> +������������������������� " val[0]=0x%"PRIx64" (reserved bits unzero)",
> >>>> +������������������������� __func__, inv_desc->val[3], inv_desc->val[2],
> >>>> +������������������������� inv_desc->val[1], inv_desc->val[0]);
> >>>> +������� return false;
> >>>> +��� }
> >>>
> >>> Need to consider the below behaviour as well.
> >>>
> >>> "
> >>> This
> >>> descriptor is a 256-bit descriptor and will result in an invalid descriptor
> >>> error if submitted in an IQ that
> >>> is setup to provide hardware with 128-bit descriptors (IQA_REG.DW=0)
> >>> "
> >>>
> >>> Also there are descriptions about the old inv desc types (e.g.
> >>> iotlb_inv_desc) that can be either 128bits or 256bits.
> >>>
> >>> "If a 128-bit
> >>> version of this descriptor is submitted into an IQ that is setup to provide
> >>> hardware with 256-bit
> >>> descriptors or vice-versa it will result in an invalid descriptor error.
> >>> "
> >>>
> >>> If DW==1, vIOMMU fetches 32 bytes per desc. In such case, if the guest
> >>> submits 128bits desc, then the high 128bits would be non-zero if there is
> >>> more than one desc. But if there is only one desc in the queue, then the
> >>> high 128bits would be zero as well. While, it may be captured by the
> >>> tail register update. Bit4 is reserved when DW==1, and guest would use
> >>> bit4 when it only submits one desc.
> >>>
> >>> If DW==0, vIOMMU fetchs 16bytes per desc. If guest submits 256bits desc,
> >>> it would appear to be two descs from vIOMMU p.o.v. The first 128bits
> >>> can be identified as valid except for the types that does not requires
> >>> 256bits. The higher 128bits would be subjected to the desc sanity check
> >>> as well.
> >>>
> >>> Based on the above, I think you may need to add two more checks. If DW==0,
> >>> vIOMMU should fail the inv types that requires 256bits; If DW==1, you
> >>> should check the inv_desc->val[2] and inv_desc->val[3]. You've already
> >>> done it in this patch.
> >>>
> >>> Thoughts are welcomed here.
> >>
> >> Good catch,
> >> I think we should write the check in vtd_process_inv_desc
> >> rather than updating the handlers.
> >>
> >> What are your thoughts?
> >
> >the first check can be done in vtd_process_inv_desc(). The second may
> >be better in the handlers as the handlers have the reserved bits check.
> >But given that none of the inv types use the high 128bits, so it is also
> >acceptable to do it in vtd_process_inv_desc(). Do add proper comment.
> 
> Thanks Yi and Clement's suggestion, I'll send a small series to fix that
> for upstream.
> 
> BRs.
> Zhenzhong

Ok so you will send v5?


