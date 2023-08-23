Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8638E78587C
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 15:06:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYnXb-0006Qs-6v; Wed, 23 Aug 2023 09:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYnXY-0006Qc-AG
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 09:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYnXW-0002WJ-8j
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 09:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692795889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DZOghYIeCswZ53mrvOu7KAoEltPo8o/7OgWIqY2dkLg=;
 b=KqWZktJyCB6ahQOAyjTNQOydXhwtosZCJw/X+aAMScmWZRjFwal5OMofmyvD/Oy5mJZEwY
 Bqjzr+6lR71+3MOgdzo3NrrLQS6u2ocNQ6Mv2iPb1Va76+aN+c7jwQEVFTd/v4Vaxay89o
 Y0LuWMvIUjm7YIqZzMoOMSLl/ESNyJA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-gJgolEBiN_qjJ1UDwCX1PQ-1; Wed, 23 Aug 2023 09:04:47 -0400
X-MC-Unique: gJgolEBiN_qjJ1UDwCX1PQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fee53cd697so27700085e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 06:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692795886; x=1693400686;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DZOghYIeCswZ53mrvOu7KAoEltPo8o/7OgWIqY2dkLg=;
 b=XBi62YdjMH4CqqMACMknCVdKoHZSKgXOipdi4LL+mJY2vFqQdEsdkM4Bkq/Uccix16
 0ni6lVWBapGyKxCkvFGb+oQNpvIfpqemEWjoTpExSOygsLPtaBKcG84On8507pEOdDpB
 7/IaU+m+t4vO+4pJggPpUPdaCJSDUeXvmSAHRZLqsR4nthvIEQOQs3AQ5KH1tEG3wtHI
 WvzTWlCb8sx8P3P1xCHoQZnYgsISjSy6qwabM2omTX6/Isy5Wf7sBr5v/rShl/csuSjJ
 LBv+Bl2KPf7ASlexA3m2GM/fFUouRvfmK62UmmzPi2TqXiq6yxxnbVW9Vo1Hw2t8UlUT
 HEHQ==
X-Gm-Message-State: AOJu0YzFXkIFPbrzbxv0fDXN9+dCYTRfCHRD38IBls+KI9ezNJbCbwPD
 4sgtkXu80GYJrtkRu0OrDZwreKtitjfZm1QE8W4KnhDYYcUeowY+b1PKSBkbwTEacHJOnICfaKR
 I9zf9ukuFJFvZXNo=
X-Received: by 2002:a05:600c:3486:b0:3fb:c9f4:1506 with SMTP id
 a6-20020a05600c348600b003fbc9f41506mr9797748wmq.1.1692795886631; 
 Wed, 23 Aug 2023 06:04:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERKUToGJv9TmEBM3MeIvM+1qkrgHmzOr0LjlgdMzj9NGI9BSEQTpZRvfOcI5zCq2lCTT77Dg==
X-Received: by 2002:a05:600c:3486:b0:3fb:c9f4:1506 with SMTP id
 a6-20020a05600c348600b003fbc9f41506mr9797730wmq.1.1692795886334; 
 Wed, 23 Aug 2023 06:04:46 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-178.web.vodafone.de.
 [109.43.177.178]) by smtp.gmail.com with ESMTPSA id
 v21-20020a1cf715000000b003fe29dc0ff2sm18778215wmh.21.2023.08.23.06.04.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 06:04:45 -0700 (PDT)
Message-ID: <772eb951-8a43-902b-3737-e52b44f7dcdb@redhat.com>
Date: Wed, 23 Aug 2023 15:04:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Failing avocado tests in CI (was: Re: [PULL 00/24] tcg + linux-user
 queue for 8.1-rc3)
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230806033715.244648-1-richard.henderson@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230806033715.244648-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 06/08/2023 05.36, Richard Henderson wrote:
> The following changes since commit 6db03ccc7f4ca33c99debaac290066f4500a2dfb:
> 
>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-08-04 14:47:00 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230805
> 
> for you to fetch changes up to 843246699425adfb6b81f927c16c9c6249b51e1d:
> 
>    linux-user/elfload: Set V in ELF_HWCAP for RISC-V (2023-08-05 18:17:20 +0000)
> 
> ----------------------------------------------------------------
> accel/tcg: Do not issue misaligned i/o
> accel/tcg: Call save_iotlb_data from io_readx
> gdbstub: use 0 ("any process") on packets with no PID
> linux-user: Fixes for MAP_FIXED_NOREPLACE
> linux-user: Fixes for brk
> linux-user: Adjust task_unmapped_base for reserved_va
> linux-user: Use ELF_ET_DYN_BASE for ET_DYN with interpreter
> linux-user: Remove host != guest page size workarounds in brk and image load
> linux-user: Set V in ELF_HWCAP for RISC-V
> *-user: Remove last_brk as unused

  Hi Richard,

I noticed that we currently have two failing Avocado jobs in our CI, 
avocado-system-centos and avocado-system-opensuse, where the 
boot_linux.py:BootLinuxX8664.test_pc_i440fx_tcg and the 
boot_linux.py:BootLinuxX8664.test_pc_q35_tcg are now apparently crashing. If 
I've got the history right, it started with your pull request here, in the 
preceeding one from Paolo, everything is still green:

  https://gitlab.com/qemu-project/qemu/-/pipelines/956543770

But here the jobs started failing:

  https://gitlab.com/qemu-project/qemu/-/pipelines/957458385

Could you please have a look?

  Thanks,
   Thomas



