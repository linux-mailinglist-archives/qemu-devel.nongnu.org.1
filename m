Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F6270E55F
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 21:29:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Xgh-00043P-1K; Tue, 23 May 2023 15:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q1Xge-00042d-VW
 for qemu-devel@nongnu.org; Tue, 23 May 2023 15:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q1Xgd-0008SP-8Q
 for qemu-devel@nongnu.org; Tue, 23 May 2023 15:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684870125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8mahOeZ621MwfiJ25V0WdcbjZlEdFHhjb0riRinjZKY=;
 b=Y0EOuqhfGKs1TxYDVnliib83O7pBCBExUew+ghY4wjvXxr6YAhkzJ975IqkP1zq8kTDWy9
 eRXY2M7k3grygWqwaeVv0O1Okct3HvP8W87IK7bDNh3NwdOm2CdlvvpLKmiPQdXlnlhHmV
 EwZoOzdAP7ECIbaBHpopzJe8NtMrJQo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-ROdpFCVqOYyQfoM9sxmqew-1; Tue, 23 May 2023 15:28:44 -0400
X-MC-Unique: ROdpFCVqOYyQfoM9sxmqew-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-75b1224f63aso3758085a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 12:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684870124; x=1687462124;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mahOeZ621MwfiJ25V0WdcbjZlEdFHhjb0riRinjZKY=;
 b=dbHFejY31+ClDbEfHJmqtYDdid6udkMWCkFuog4e+K4Y4YdoPRUUvoIWICyVN5Q+ny
 Y3VEsINZtgqm6GyL7WJN4H/MlYtbgnixu0NSRATXUcaXhLBQuhnCZ3IQ+icfhB47mHT2
 ZJYYnaSKoKHrCZuZfpAkmTtauhHgiiwP5YtFCziPbNjMBY81yT7yjsfwmQP9M2iki5k5
 nQiCVRqjcBA0rPUnNa9X9n9aPODdotfbWOHdeFRr3WMHRzdvkGqOblBVrFhdK7JEvyKl
 PiphfVlKiW+2mOrkGXa2EFsCV5peRxrYNtZxAcaRagQLpsR+psV4aXevoNCEsEHRHw9k
 meUA==
X-Gm-Message-State: AC+VfDxoFeKzGqyVEyoFoi5PrRf8IibtN0n4hKE/l2SDWwyaV9YeAjPX
 d06nS3pBpeEw4D58RVQGG2H78xYhrJfrazMJ1VjY8FFFqjqlrTNvQ2DIFLn3cjwkl76YkeGXDmp
 5/XvXmQues9E/Yrc=
X-Received: by 2002:a05:620a:8dc:b0:75b:23a1:1de5 with SMTP id
 z28-20020a05620a08dc00b0075b23a11de5mr5109257qkz.2.1684870123844; 
 Tue, 23 May 2023 12:28:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6AEd1+vSvLnSsbB5S9kY5bnv93GeTv1pYYr2QBw/IlTZk/EIb3dud7JiIecWokOBxcqk90Wg==
X-Received: by 2002:a05:620a:8dc:b0:75b:23a1:1de5 with SMTP id
 z28-20020a05620a08dc00b0075b23a11de5mr5109242qkz.2.1684870123588; 
 Tue, 23 May 2023 12:28:43 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 pe25-20020a05620a851900b00758fef02a08sm1230093qkn.6.2023.05.23.12.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 12:28:43 -0700 (PDT)
Date: Tue, 23 May 2023 15:28:41 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [PATCH v4 1/3] vhost: Rework memslot filtering and fix
 "used_memslot" tracking
Message-ID: <ZG0T6QxM/y95FwmH@x1n>
References: <20230523185915.540373-1-david@redhat.com>
 <20230523185915.540373-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230523185915.540373-2-david@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, May 23, 2023 at 08:59:13PM +0200, David Hildenbrand wrote:
> Having multiple vhost devices, some filtering out fd-less memslots and
> some not, can mess up the "used_memslot" accounting. Consequently our
> "free memslot" checks become unreliable and we might run out of free
> memslots at runtime later.
> 
> An example sequence which can trigger a potential issue that involves
> different vhost backends (vhost-kernel and vhost-user) and hotplugged
> memory devices can be found at [1].
> 
> Let's make the filtering mechanism less generic and distinguish between
> backends that support private memslots (without a fd) and ones that only
> support shared memslots (with a fd). Track the used_memslots for both
> cases separately and use the corresponding value when required.
> 
> Note: Most probably we should filter out MAP_PRIVATE fd-based RAM regions
> (for example, via memory-backend-memfd,...,shared=off or as default with
>  memory-backend-file) as well. When not using MAP_SHARED, it might not work
> as expected. Add a TODO for now.
> 
> [1] https://lkml.kernel.org/r/fad9136f-08d3-3fd9-71a1-502069c000cf@redhat.com
> 
> Fixes: 988a27754bbb ("vhost: allow backends to filter memory sections")
> Cc: Tiwei Bie <tiwei.bie@intel.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


