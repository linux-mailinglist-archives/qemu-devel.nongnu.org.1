Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1EB722171
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 10:52:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q65wA-0003lD-VB; Mon, 05 Jun 2023 04:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q65w2-0003kh-Gw
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q65w0-0003Pk-Ra
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685955087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4+UiCI52ndpHDbgGz74Z9sQjTSb0SyBjRVfThiC9Ox4=;
 b=grEBF0JGtEDxlV4yF6GqI7CmA10ajfwhzHNKiVQVVzaa4MP18YxoFCAEAf+T37MhxXMr40
 3f/G9/ag79PwIVwUQI9y6I1aPO/QQhLyB78cq769yL9ruSy5NBNn0kFB1fAMR3y5iRPuM+
 onw0I1lK58O3R0aP3RqGOARPszjOVDc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-wlO_4GHKNweIuxdLCgRbBw-1; Mon, 05 Jun 2023 04:51:27 -0400
X-MC-Unique: wlO_4GHKNweIuxdLCgRbBw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9744659b7b5so366719166b.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 01:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685955085; x=1688547085;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4+UiCI52ndpHDbgGz74Z9sQjTSb0SyBjRVfThiC9Ox4=;
 b=fIkfLMTleZ4cYws7dHeFwcFL5mpFaVR2t/Ity6hkmco+nJDBhY5guVA4SwaO0jUtC6
 xwzxqTPNNM7n2Bc5e1oZhr9G4O9PUo5ZjNb+2Jc4RtCIEP+q1U4sC+vbvztzf1Yu2dAm
 qgGhTIP+tC5Xn1qtUgVRpEHbDR/so6J5juQCzgi40Cyg1CewWmJr/vQYkzqmdgOBxh0c
 ThRyF/A4NnSXn/PR5a4Hlx7M1e5N6ch1LjUQsjH+zMYxJyJJT0oI81/RfV3GQdFM70c0
 jBHQBwhB3vbHQ/TRXpxO3x4xhGNQzpm4s9GVsBWIAsMFF+1sPswUXNmMqVXuR5QnlISc
 RGDg==
X-Gm-Message-State: AC+VfDyLLXAnliZEhY9/ic8LfIroEmgmhFtWh4e9uwkgPOp+469YcSTH
 yK5CVs+APPP3pBvms6MyHULepSMJ2NWTMqEiEdL+k36EDwkpiDixlnB1Yww2tr7VLLUSbULgSu9
 hAiZbo6bDSVMpJtUvTdmtiFE=
X-Received: by 2002:a17:907:d04:b0:932:7f5c:4bb2 with SMTP id
 gn4-20020a1709070d0400b009327f5c4bb2mr6569724ejc.75.1685955085310; 
 Mon, 05 Jun 2023 01:51:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4frMoNORUWgQwdCFLACrfZjhBoXpRPcUi28+av7GPXyHZlAP5HcQtMfSKuhnGT5jEgsyHY+w==
X-Received: by 2002:a17:907:d04:b0:932:7f5c:4bb2 with SMTP id
 gn4-20020a1709070d0400b009327f5c4bb2mr6569713ejc.75.1685955084973; 
 Mon, 05 Jun 2023 01:51:24 -0700 (PDT)
Received: from ?IPV6:2003:cf:d740:9017:191d:265b:b68c:4fa4?
 (p200300cfd7409017191d265bb68c4fa4.dip0.t-ipconnect.de.
 [2003:cf:d740:9017:191d:265b:b68c:4fa4])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a170906bc5400b009745b0cb326sm3948879ejv.109.2023.06.05.01.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 01:51:24 -0700 (PDT)
Message-ID: <d27bee66-8d23-bee7-57ab-27f59ac26812@redhat.com>
Date: Mon, 5 Jun 2023 10:51:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] qcow2: add discard-no-unref option
Content-Language: en-US
To: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-devel@nongnu.org,
 kwolf@redhat.com
References: <20230605084523.34134-2-jean-louis@dupond.be>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230605084523.34134-2-jean-louis@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 05.06.23 10:45, Jean-Louis Dupond wrote:
> When we for example have a sparse qcow2 image and discard: unmap is enabled,
> there can be a lot of fragmentation in the image after some time. Especially on VM's
> that do a lot of writes/deletes.
> This causes the qcow2 image to grow even over 110% of its virtual size,
> because the free gaps in the image get too small to allocate new
> continuous clusters. So it allocates new space at the end of the image.
>
> Disabling discard is not an option, as discard is needed to keep the
> incremental backup size as low as possible. Without discard, the
> incremental backups would become large, as qemu thinks it's just dirty
> blocks but it doesn't know the blocks are unneeded.
> So we need to avoid fragmentation but also 'empty' the unneeded blocks in
> the image to have a small incremental backup.
>
> In addition, we also want to send the discards further down the stack, so
> the underlying blocks are still discarded.
>
> Therefor we introduce a new qcow2 option "discard-no-unref".
> When setting this option to true, discards will no longer have the qcow2
> driver relinquish cluster allocations. Other than that, the request is
> handled as normal: All clusters in range are marked as zero, and, if
> pass-discard-request is true, it is passed further down the stack.
> The only difference is that the now-zero clusters are preallocated
> instead of being unallocated.
> This will avoid fragmentation on the qcow2 image.
>
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1621
> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
> ---
>   block/qcow2-cluster.c | 32 ++++++++++++++++++++++++++++----
>   block/qcow2.c         | 18 ++++++++++++++++++
>   block/qcow2.h         |  3 +++
>   qapi/block-core.json  | 12 ++++++++++++
>   qemu-options.hx       | 12 ++++++++++++
>   5 files changed, 73 insertions(+), 4 deletions(-)

Thanks!

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


