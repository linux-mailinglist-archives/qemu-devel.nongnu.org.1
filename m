Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E20763DDC
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 19:44:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOiPc-0002DY-8k; Wed, 26 Jul 2023 13:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOiPa-0002D7-0k
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 13:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOiPY-00057v-G9
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 13:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690392895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Ip2/x/q2lJyYD6YYWPNN5Ux8K5jdhKc/H64m77LsoE=;
 b=aPyoVwtcuWXWzNySIZy/QlnZAmA3Uuj9mH/FSTIxgjiAm+tzKK8F1MElP/Y2srur2Wx4Gm
 lPw8lamtw+Pt2tL9j6Am1OnmFVaTVjAK32FQgMrRhXxfNMiVka2ClSkzqCQGxzZdr7YI3R
 3RjuNNKx/TQiEzZuHLyRbgDFDYmIBqM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-HkXXm0qyOBeqfzmD1IwtHA-1; Wed, 26 Jul 2023 13:34:50 -0400
X-MC-Unique: HkXXm0qyOBeqfzmD1IwtHA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-767edbf73cbso979285a.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 10:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690392890; x=1690997690;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Ip2/x/q2lJyYD6YYWPNN5Ux8K5jdhKc/H64m77LsoE=;
 b=ibp1qJJW22hE6gvQtk+ZX7GROzyKuXkqcRNPBs6H4fyCZXvgQ+YxNs3EAEyNJr/gSO
 +Y3OYBNOAhdWYwzyKArrJ2G9OIAohi3MoyRkylWX5gyuLTC7KzK1/8ygqZ2/G9cLKXTQ
 EwIFuElK/yUckFSM/Is2uSmGiRWSxb8o/HDC+EEjesLo5birNB0ROZzCY9dODMR3D0/8
 JiLbQKmxcwosAe29EciTSPpANpzzKhMuQqgy29Bh/KpUTCQW10EGGqxwGX+H/pQ+omQ7
 HNkxOggKmockhgEM33G+UkUCjR/evb9XkzTteUeXXJYho8cM+he7DVj5ocaqsJywKRJN
 /Cpg==
X-Gm-Message-State: ABy/qLbPQGyeDHT6Yre5Jq7upV/u4sSWEpL+emfim1ssj2z5JpmSbV76
 XwZGzZohpsJRn336cHj2lDn0rwVozr+SmL1R7kU14qfzP7DYYHjnuy9GllpKWTwyyZWenioQYpz
 47gTVRtAyC+xxlmI=
X-Received: by 2002:a05:620a:4482:b0:768:1cb7:4514 with SMTP id
 x2-20020a05620a448200b007681cb74514mr3306699qkp.2.1690392890273; 
 Wed, 26 Jul 2023 10:34:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE+2Uf48hAgNUFBiKvQD2iPCfBkHQ+aR/dihh3OETqfr+QWjx/gctEQywkXNCB8ypG/dbM9vg==
X-Received: by 2002:a05:620a:4482:b0:768:1cb7:4514 with SMTP id
 x2-20020a05620a448200b007681cb74514mr3306683qkp.2.1690392889998; 
 Wed, 26 Jul 2023 10:34:49 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 bn9-20020a05620a2ac900b00767dcf6f4adsm4465281qkb.51.2023.07.26.10.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 10:34:49 -0700 (PDT)
Date: Wed, 26 Jul 2023 13:34:47 -0400
From: Peter Xu <peterx@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: intel-iommu: Report interrupt remapping faults, fix return value
Message-ID: <ZMFZN4OehyKVDTbp@x1n>
References: <d6e586699117542f9aeb3018cd5985834d727b44.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d6e586699117542f9aeb3018cd5985834d727b44.camel@infradead.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 25, 2023 at 11:01:16AM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> A generic X86IOMMUClass->int_remap function should not return VT-d
> specific values; fix it to return 0 if the interrupt was successfully
> translated or -EINVAL if not.
> 
> The VTD_FR_IR_xxx values are supposed to be used to actually raise
> faults through the fault reporting mechanism, so do that instead for
> the case where the IRQ is actually being injected.
> 
> There is more work to be done here, as pretranslations for the KVM IRQ
> routing table can't fault; an untranslatable IRQ should be handled in
> userspace and the fault raised only when the IRQ actually happens (if
> indeed the IRTE is still not valid at that time). But we can work on
> that later; we can at least raise faults for the direct case.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Mostly good to me, only still a few trivial comments..

[...]

> @@ -3320,17 +3342,33 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
>                          entry, sizeof(*entry), MEMTXATTRS_UNSPECIFIED)) {
>          error_report_once("%s: read failed: ind=0x%x addr=0x%" PRIx64,
>                            __func__, index, addr);
> -        return -VTD_FR_IR_ROOT_INVAL;
> +        if (do_fault) {
> +            vtd_report_ir_fault(iommu, sid, VTD_FR_IR_ROOT_INVAL, index);
> +        }
> +        return false;
>      }
>  
>      trace_vtd_ir_irte_get(index, le64_to_cpu(entry->data[1]),
>                            le64_to_cpu(entry->data[0]));
>  
> +	/*
> +	 * The remaining potential fault conditions are "qualified" by the
> +	 * Fault Processing Disable bit in the IRTE. Even "not present".
> +	 * So just clear the do_fault flag if PFD is set, which will
> +	 * prevent faults being raised.
> +	 */
> +	if (entry->irte.fault_disable) {
> +		do_fault = false;

Wrong indent on these lines..

> +    }
> +
>      if (!entry->irte.present) {
>          error_report_once("%s: detected non-present IRTE "
>                            "(index=%u, high=0x%" PRIx64 ", low=0x%" PRIx64 ")",
>                            __func__, index, le64_to_cpu(entry->data[1]),
>                            le64_to_cpu(entry->data[0]));
> +        if (do_fault) {
> +            vtd_report_ir_fault(iommu, sid, VTD_FR_IR_ENTRY_P, index);
> +        }
>          return -VTD_FR_IR_ENTRY_P;

Forgot to change retval?

>      }

Thanks,

-- 
Peter Xu


