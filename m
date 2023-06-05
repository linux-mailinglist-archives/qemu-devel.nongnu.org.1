Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B39722EDA
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 20:42:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6F9k-00027W-C2; Mon, 05 Jun 2023 14:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6F9h-00027E-2x
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 14:42:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6F9c-00035v-Q5
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 14:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685990526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TsMJwptDmWRrW0lI8U9KHPbPNZvxqsS7XeMpEypXolg=;
 b=jTAt5HTCA1uAwIsu1aj7yB1cpUfRNJUFMfJFF57KkkHWBSYneD4b5Ky3dHlXm/YNVPsd1t
 LfmGfQd5Q7c18HIzpJFg6LVkDtS5NoTj1OA2dklaloRyXU51Yx6J0tNAmju8FdQFAAxOWc
 q7i2qMk07/QCWDi/SzogSaogWiZseUY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-X1UKVDglOmqB7Y5VXOETfQ-1; Mon, 05 Jun 2023 14:42:05 -0400
X-MC-Unique: X1UKVDglOmqB7Y5VXOETfQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-75b147a2548so101908385a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 11:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685990525; x=1688582525;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TsMJwptDmWRrW0lI8U9KHPbPNZvxqsS7XeMpEypXolg=;
 b=VO9KIRsm6mfXjOjiD44XdGti1PKkMMPeKTDHXCCd3/hP1UPLfgkn+r8SOHhXfxWNYG
 5J3/s+2LrrZYpIM59zp/lXDUipTCSkbYeU/kpafb0t72xSZvQGNsPLkFCyU4MgHnfP8i
 jy8Q73ESbWAtILuSPytu/aGxqBrLLY9kVXGFTX6dM3MLhiDSNrKP9IE/kfIRaYfjfVwz
 7LhZ8sKVkEvUCNJRVkrIQBMdO38pgfoHY0kQq4V2yOCHV2zCs4ML3/EYl2QJF7zTPqtp
 0BENQrhKPY+c6gXz4QSW0PdkDxtIGcuM9PqMYAB9SCX27i6k58kuaf6JYiPIPrN7wgme
 hKsA==
X-Gm-Message-State: AC+VfDwb4bL+/XNoqswED0NoQnk4K8wHyTXPdf0Pjcrbs6ggnGRpPeDg
 lohY29O+ELsUJlqhQVWfgguNvH8BHywA1sRd+tHeplc+mvggsdALm2Zo5ARhWDiwUOejLRDrs+j
 rXH/aS4CZeRd712I=
X-Received: by 2002:a05:620a:6608:b0:75b:23a1:69ea with SMTP id
 qf8-20020a05620a660800b0075b23a169eamr17541103qkn.1.1685990525119; 
 Mon, 05 Jun 2023 11:42:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ58mjEmwVCvjHdzG5NTabWxadCU4B4LfMhr/wcSmQJctasKfsMaiwKO6UIkdhfwmTdinRUnsQ==
X-Received: by 2002:a05:620a:6608:b0:75b:23a1:69ea with SMTP id
 qf8-20020a05620a660800b0075b23a169eamr17541080qkn.1.1685990524913; 
 Mon, 05 Jun 2023 11:42:04 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c28-20020a05620a135c00b0075cb8a7c83fsm3811808qkl.76.2023.06.05.11.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 11:42:04 -0700 (PDT)
Date: Mon, 5 Jun 2023 14:42:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, clg@redhat.com, david@redhat.com,
 philmd@linaro.org, kwankhede@nvidia.com, cjia@nvidia.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v2 3/4] memory: Document update on replay()
Message-ID: <ZH4seudPfm2Dhhsg@x1n>
References: <20230601063320.139308-1-zhenzhong.duan@intel.com>
 <20230601063320.139308-4-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230601063320.139308-4-zhenzhong.duan@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 01, 2023 at 02:33:19PM +0800, Zhenzhong Duan wrote:
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index eecc3eec6702..9a523ef62a94 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -441,9 +441,9 @@ struct IOMMUMemoryRegionClass {
>       * call the IOMMU translate method for every page in the address space
>       * with flag == IOMMU_NONE and then call the notifier if translate
>       * returns a valid mapping. If this method is implemented then it
> -     * overrides the default behaviour, and must provide the full semantics
> -     * of memory_region_iommu_replay(), by calling @notifier for every
> -     * translation present in the IOMMU.
> +     * overrides the default behavior, and must provide corresponding
> +     * semantics depending on notifier's type, e.g. IOMMU_NOTIFIER_MAP,
> +     * notify changed entries; IOMMU_NOTIFIER_FULL_MAP, notify full entries.

IIUC it was always trying to notify all existing entries only, rather than
changed entries.  VT-d used to unmap all so it was also true.

-- 
Peter Xu


