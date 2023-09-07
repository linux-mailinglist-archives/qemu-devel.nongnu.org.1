Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE01797111
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 10:56:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeAo1-0004zF-RZ; Thu, 07 Sep 2023 04:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qeAny-0004yl-EO
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qeAnw-0007qB-30
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694076959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YPxgTtfLXqbO1/g0SIcEAN+1IBBd8rgODf4Pyp1hS+k=;
 b=HKruhV2udroksvUOPLS9jEGIHQBxkVvriTAUVrZUNESHMcYSew8ZNWrg+ZYkAOtJmqNNhf
 quQzSNpmz91zJo0MCHELGTnJ3SnUQ3YggSpzPLy65QjNfn50gwtBlE+Bakxe4ZWUTYXGta
 stNAHeGMHAJ1NMTiLweUVSwewHt38RY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-_nzbNzzPP6GCb6QLBSapVA-1; Thu, 07 Sep 2023 04:55:57 -0400
X-MC-Unique: _nzbNzzPP6GCb6QLBSapVA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-64f3be16f48so8591956d6.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 01:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694076957; x=1694681757;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YPxgTtfLXqbO1/g0SIcEAN+1IBBd8rgODf4Pyp1hS+k=;
 b=ZHoxqlUy1JIOsXPOnAVDnHFwsfULjTtzdD9Gq3ijKGFp5LPMqtVG8KMvAxx+fNLMgK
 rQHpCKcy9jsJltAT+vVbHq6tVHKoIyByOYrkDt0U+4nC5GexRecZWAOOouMQmgRZoOZT
 n4DZu98ZJUdWgM7Dotmz3vAN0DOKyjw/JbEMwo9CPRl/vpqe1TWhwLFl9/cSVuMGGo39
 ERPKZikOjPO0tp08PhrGwHHd4GTh/ldCGN9KfrsvRqqao5FxuUY3DDqBbYCpEL1lUBbu
 VZycwyI3/S2JQzLpntfp4F1ZQCpzySiY2ghLtYTWarMuIctWz4wY9f8SORAU3Uciv+Nv
 lzgA==
X-Gm-Message-State: AOJu0YwGWFsolIhEtdQLpMUXw6nUWtCEGGL9Pv/iHmA30L5e6wkqQ0A1
 MgFTBCsbpopVGZToJocWp/YvNIMCfC8n9y0rAz76+NMAjtgT88sp6yEy0NLf/W7scYz/eMMH7OY
 /zzXDeHi8lXUZai4=
X-Received: by 2002:a0c:e885:0:b0:641:8df1:79e2 with SMTP id
 b5-20020a0ce885000000b006418df179e2mr16517171qvo.30.1694076957381; 
 Thu, 07 Sep 2023 01:55:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9Y9tsEvOmK6TG/AJExZNbaXMkpmhcmnHfk6/1+9g2AgujXzJobpVF6EjUZLZyAxIJfLN/CA==
X-Received: by 2002:a0c:e885:0:b0:641:8df1:79e2 with SMTP id
 b5-20020a0ce885000000b006418df179e2mr16517161qvo.30.1694076957145; 
 Thu, 07 Sep 2023 01:55:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a0ce2cb000000b0062fffa42cc5sm6117933qvl.79.2023.09.07.01.55.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 01:55:56 -0700 (PDT)
Message-ID: <9a962af2-1748-017b-9ab3-fdf7d9f84b4b@redhat.com>
Date: Thu, 7 Sep 2023 10:55:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/6] vfio/migration: Block VFIO migration with postcopy
 and background snapshot
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>
References: <20230906150853.22176-1-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230906150853.22176-1-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/6/23 17:08, Avihai Horon wrote:
> Hello,
> 
> Recently added VFIO migration is not compatible with some of the
> pre-existing migration features. This was overlooked and today these
> combinations are not blocked by QEMU. This series fixes it.
> 
> Postcopy migration:
> VFIO migration is not compatible with postcopy migration. A VFIO device
> in the destination can't handle page faults for pages that have not been
> sent yet. Doing such migration will cause the VM to crash in the
> destination.
> 
> Background snapshot:
> Background snapshot allows creating a snapshot of the VM while it's
> running and keeping it small by not including dirty RAM pages.
> 
> The way it works is by first stopping the VM, saving the non-iterable
> devices' state and then starting the VM and saving the RAM while write
> protecting it with UFFD. The resulting snapshot represents the VM state
> at snapshot start.
> 
> VFIO migration is not compatible with background snapshot.
> First of all, VFIO device state is not even saved in background snapshot
> because only non-iterable device state is saved. But even if it was
> saved, after starting the VM, a VFIO device could dirty pages without it
> being detected by UFFD write protection. This would corrupt the
> snapshot, as the RAM in it would not represent the RAM at snapshot
> start.
> 
> This series fixes it by blocking these combinations. This is done by
> adding a .save_prepare() handler to struct SaveVMHandler. The
> .save_prepare() handler is called early, even before migration starts,
> and allows VFIO migration to check the migration capabilities and fail
> migration if needed.
> 
> Note that this series is based on the P2P series [1] sent a few weeks
> ago.
> 
> Comments and suggestions will be greatly appreciated.

Applied to vfio-next.

Thanks,

C.



