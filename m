Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2751579223C
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 13:43:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdUSK-00065i-34; Tue, 05 Sep 2023 07:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdUSH-0005yA-9h
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 07:42:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdUS7-0000ZV-GV
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 07:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693914158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=blzzYsC5C98IBbEx3ALS+F8aaCWxEwOi5CXml9KFgIo=;
 b=RH1K2KGnx/gw3nmRognBSj/o66yiXMNzg04/3Z56lCsOCRjZiTBgENR9G9RUkpW0uQ8+xn
 NMlLanUAwwQ29Ax48WO+ojOjXIT4iaq10+11tk3M1Q5bj67VWjpAyPKzhVicMY39nLvOYy
 5zBcNmux6thHlFMuXEyR1CEwHMGJP5k=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-BOrUIVKwNHqhFphl3GXLHw-1; Tue, 05 Sep 2023 07:42:37 -0400
X-MC-Unique: BOrUIVKwNHqhFphl3GXLHw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2be35b7b51aso26427401fa.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 04:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693914155; x=1694518955;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=blzzYsC5C98IBbEx3ALS+F8aaCWxEwOi5CXml9KFgIo=;
 b=PVV/QuqDkbLHDgZm2+fTGvQfgNFgKcfZwZqOv1U8Sq1Cjp3+cV8mbyboTIcvtDi9pe
 E5l+fSWJMfpRxO667AK4cDgPXug3bvQHhH+H4HK5lH3JZS//AGD3xlXQTgnbPy7G6GYW
 uPLxPYOYFv4lgmgR0uNccOpYYAeAWOhQHhOz3CYqR6ku/eW3RmaJ2kVO1xy40H/ECGHq
 jZ2mQ4PHi7t6+I8azRC6It67XU5MaRm7hsdmRSJeAnKuxOwlu7KppBc6Yk2BZNuAAf6K
 fsETm3wZm7dQrhqCDT6GmojQCgyG6XiA+mDo/65IFxZuLHer1FsAUM8v4OGEE9515tpj
 9aYw==
X-Gm-Message-State: AOJu0YykZaBmHTuVhKbNDoH61x8pKegOV0Um1/N1Fxszmf2F0jJk4iFV
 pJZ67vgk0/3Ofg5pfhsFYE0Nrzw4xU5QdlVf5Jgruu3UFBZXNAfaW6dQBxOAwxCrGDk/bsP2EO5
 s72o8ktM4ozg1dfA=
X-Received: by 2002:a05:6512:3d0e:b0:4ff:9a75:211e with SMTP id
 d14-20020a0565123d0e00b004ff9a75211emr11059250lfv.42.1693914155638; 
 Tue, 05 Sep 2023 04:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNq7pfGnYOk5sCMeegkJS3oZg7WMyK8rqdLiLT0G0mEkz7IgcJHizphnyD2bqy0n5URi28tQ==
X-Received: by 2002:a05:6512:3d0e:b0:4ff:9a75:211e with SMTP id
 d14-20020a0565123d0e00b004ff9a75211emr11059239lfv.42.1693914155328; 
 Tue, 05 Sep 2023 04:42:35 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.googlemail.com with ESMTPSA id
 n5-20020a05600c294500b003fa96fe2bd9sm19826057wmd.22.2023.09.05.04.42.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 04:42:34 -0700 (PDT)
Message-ID: <dd12f39d-a364-b186-2ad7-04343ea85e3f@redhat.com>
Date: Tue, 5 Sep 2023 13:42:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: deadlock when using iothread during backup_clean()
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <bcbd48da-e4cc-f9c9-000c-6a9f98ca156f@proxmox.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <bcbd48da-e4cc-f9c9-000c-6a9f98ca156f@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/5/23 12:01, Fiona Ebner wrote:
> Can we assume block_job_remove_all_bdrv() to always hold the job's
> AioContext?

I think so, see job_unref_locked(), job_prepare_locked() and 
job_finalize_single_locked().  These call the callbacks that ultimately 
get to block_job_remove_all_bdrv().
	
> And if yes, can we just tell bdrv_graph_wrlock() that it
> needs to release that before polling to fix the deadlock?

No, but I think it should be released and re-acquired in 
block_job_remove_all_bdrv() itself.

mirror_exit_common() however holds _two_ AioContext locks at the time it 
calls block_job_remove_all_bdrv(), qemu_get_aio_context() has to be 
released and reacquired in mirror_exit_common() itself.

Paolo


