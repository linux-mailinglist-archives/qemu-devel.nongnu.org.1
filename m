Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CD5A9C921
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Apr 2025 14:43:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8INu-0005HD-R7; Fri, 25 Apr 2025 08:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1u8INs-0005Gx-0I
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:42:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1u8INq-0006NB-4k
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745584938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pXNNqoi19Ba69uwcAj3Kv/k/r4tm7gG4ENXbwT+pfM0=;
 b=Y81uExZSFYgqefuN8uZsslEgmHAeTN9q+udPv5QFso+elHNa2qdlIoqOwsMM/85zAx4leT
 rkt/FkHZtybv27WKAgqpW7lGtN0m5i0JkF8w8eOHkGGefTwO3vwIRKeH0BluBHF3IopUTa
 kQ4sEssaXdumweNiASXxd0oG/et5RlI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-1b2k9yG4P7G3saKIvh65qg-1; Fri, 25 Apr 2025 08:42:15 -0400
X-MC-Unique: 1b2k9yG4P7G3saKIvh65qg-1
X-Mimecast-MFC-AGG-ID: 1b2k9yG4P7G3saKIvh65qg_1745584934
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39c184b20a2so888807f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 05:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745584934; x=1746189734;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pXNNqoi19Ba69uwcAj3Kv/k/r4tm7gG4ENXbwT+pfM0=;
 b=ancLuFTlYB+ee6nXDVAuehE33V5f50EyUMpetY0nvfic4NbILQCvKh5a6lt99AnPXK
 U1Fpbm815CDlFXmAPSLOf4pTUOyNRyZJVsdIw8I0tkuUcky4wf3ef7zRhd+JVG6g9U0L
 kcgNynd9KHbNTgn5Q9e3slXWnbSRK54T3YslQQPzZmimUwaduFgWzbuhoza8ffSxhYtd
 5wPqdwpZz+laLm/1IhCjmPVnLdy/hSu/nmqDuaQjZD7JeH8KPMMfOChUC54bBOTOpPNh
 htO8+SxGas6MNRMPNzGbbOOfxJrg/AeaKBnfMJnqCOe9PJmAT4AGYX4/OtrnCI1x+hMf
 TIYQ==
X-Gm-Message-State: AOJu0YxhvJEJ28JcS73pYkrV429g0eYn6jIOuHhcR+GSYCMXOfCFahYL
 jWfuKvDM33TFZCAVGMeVS6FY0CPHUMu9ddxTQ4FiBFlJ9ZdrMLO06bCT3AMoktvmcnnJ1y8WFbX
 tzAzlPMHjnqF5zGZpKrQJQ6Q54W5L+qU4Aao30A2b08EOCS7sQLP9
X-Gm-Gg: ASbGncuGZT3qdKPYSv3TOp7ZmxY600+qPtefd4rtttrAeLViMUBAA6ypvumyInZ4hhc
 9LzHe3ip4cf+Gxw2FjhP3RrnDbesdyQPcMpGhNpkktjqVbRWqdFlk2chRvcjbLkWonZ8BPPEpqj
 vsHfgX2RJNpJX2YCC8aJpIJy+MsV5c5mJhG7bpp4KC4nlim8dclnlg9VZjr2wRdBd/jo9uN+eV2
 FFe1hZhTifZQWHuTA9w0XEORZszt2LcArq2XM/HuFT4MGh8VwpGHwSNMD7OYyneP2KE7hTnvDJG
 8O+nNwakqjm3xWQERndaxw19ftX5gP9jLxSJeoDcrZQM0JNYayTVkouFU8wszMxFmF+2fVftnak
 IDuRTIwt7l1U1hdRNlEETfh8jQQZ6Nti1sZBH
X-Received: by 2002:a5d:64a3:0:b0:39a:c467:a095 with SMTP id
 ffacd0b85a97d-3a074e1f72emr1656242f8f.24.1745584934394; 
 Fri, 25 Apr 2025 05:42:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0dQmSUnE83lfcUweDIFLTRC1sLPiRsqAP2bvMHN9DAFRKWHykYVNejLYQ7r8QtFrIL6ZU8A==
X-Received: by 2002:a5d:64a3:0:b0:39a:c467:a095 with SMTP id
 ffacd0b85a97d-3a074e1f72emr1656216f8f.24.1745584934001; 
 Fri, 25 Apr 2025 05:42:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70f:6900:6c56:80f8:c14:6d2a?
 (p200300cbc70f69006c5680f80c146d2a.dip0.t-ipconnect.de.
 [2003:cb:c70f:6900:6c56:80f8:c14:6d2a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5d264sm2295556f8f.95.2025.04.25.05.42.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 05:42:13 -0700 (PDT)
Message-ID: <37cace3c-942e-457d-8a1a-fa37050428a7@redhat.com>
Date: Fri, 25 Apr 2025 14:42:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/13] memory: Unify the definiton of
 ReplayRamPopulate() and ReplayRamDiscard()
To: Chenyi Qiang <chenyi.qiang@intel.com>, Alexey Kardashevskiy
 <aik@amd.com>, Peter Xu <peterx@redhat.com>,
 Gupta Pankaj <pankaj.gupta@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
 <20250407074939.18657-4-chenyi.qiang@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250407074939.18657-4-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 07.04.25 09:49, Chenyi Qiang wrote:
> Update ReplayRamDiscard() function to return the result and unify the
> ReplayRamPopulate() and ReplayRamDiscard() to ReplayStateChange() at
> the same time due to their identical definitions. This unification
> simplifies related structures, such as VirtIOMEMReplayData, which makes
> it more cleaner and maintainable.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
> Changes in v4:
>      - Modify the commit message. We won't use Replay() operation when
>        doing the attribute change like v3.
> 
> Changes in v3:
>      - Newly added.
> ---

[...]

>   
> -typedef int (*ReplayRamPopulate)(MemoryRegionSection *section, void *opaque);
> -typedef void (*ReplayRamDiscard)(MemoryRegionSection *section, void *opaque);
> +typedef int (*ReplayStateChange)(MemoryRegionSection *section, void *opaque);
>   

But it's not a state change.

ReplayRamState maybe?

[...]
>   /*
> diff --git a/system/memory.c b/system/memory.c
> index 62d6b410f0..b5ab729e13 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2147,7 +2147,7 @@ bool ram_discard_manager_is_populated(const RamDiscardManager *rdm,
>   
>   int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
>                                            MemoryRegionSection *section,
> -                                         ReplayRamPopulate replay_fn,
> +                                         ReplayStateChange replay_fn,
>                                            void *opaque)
>   {
>       RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_GET_CLASS(rdm);
> @@ -2156,15 +2156,15 @@ int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
>       return rdmc->replay_populated(rdm, section, replay_fn, opaque);
>   }
>   
> -void ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
> -                                          MemoryRegionSection *section,
> -                                          ReplayRamDiscard replay_fn,
> -                                          void *opaque)
> +int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
> +                                         MemoryRegionSection *section,
> +                                         ReplayStateChange replay_fn,
> +                                         void *opaque)
>   {
>       RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_GET_CLASS(rdm);
>   
>       g_assert(rdmc->replay_discarded);
> -    rdmc->replay_discarded(rdm, section, replay_fn, opaque);
> +    return rdmc->replay_discarded(rdm, section, replay_fn, opaque);
>   }

The idea was that ram_discard_manager_replay_discarded() would never be 
able to fail. But I don't think this really matters, because the 
function is provided by the caller, that can just always return 0 -- 
like we do in dirty_bitmap_clear_section() now.

So yeah, this looks fine to me, given that we don't call it a "state 
change" when we are merely replaying a selected state.

-- 
Cheers,

David / dhildenb


