Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92192706334
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:43:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzCjJ-0007VD-SM; Wed, 17 May 2023 04:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pzCjH-0007UI-B9
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:41:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pzCjF-0000AX-Qw
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684312909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2IBjC821QU8CyAUp4GOY70sgoWFrxosLsjD2dpTJ4nw=;
 b=deT5WfXCGTzvDXMZtxaZIHCAm7r036mJU+AH4rjKpsTHiZ4C17LF9OOQS4XbX07+ar7dL+
 ughT759gqDa7NybAZBgmrXkkHRGlkVEQihmyOA6URbYaCd3OXJjsKSGgsqLfq1owjQ4ty8
 XZtsqx5QenKy028zHA/fY1EY18KmPbk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-sU_CbPPLOjqnaQXN7QxlKg-1; Wed, 17 May 2023 04:41:47 -0400
X-MC-Unique: sU_CbPPLOjqnaQXN7QxlKg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f42b36733aso1898625e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 01:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684312906; x=1686904906;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2IBjC821QU8CyAUp4GOY70sgoWFrxosLsjD2dpTJ4nw=;
 b=SnSc/yGaOHpnKAOK6C8PCcmSxq1upZSbZ+c2ikGJpKfncQhIYAOmDX8hHe9LNUft6i
 Q5S1ahxqqK+H1VlA/H8A0LLlIntgjirKbDh88DBLe6k5M2Fgd6SmzUNpwk1Yomjh/u3y
 WMPeOMuxuuWCXSrH/eyP6e7RPMzAZ+00SxD17QwbLzEIHZAqf7sb1QnbdvO4I0pRQ77u
 HwgUotETeWNEx6TIcoand1JHfGnPooS4jrdfpq3GcInSDK34FW+WawzFE5uG3KRnagkg
 /ZJkfmFxdm+MbdJfrCBr0V/WQMyQbsi5/g2MlJxMoArcl80ijRq+Zk18aO8hzjkaIbhW
 Dvsg==
X-Gm-Message-State: AC+VfDxJ1iKRDTqnu7x5CUfuI8qGyDXH3PLPwKjYJNFzhd962LGt5mGD
 ZNV7BqEKhR0RAaeuGCgL7pNSwQeLujXUTVLKHuHTvEEWmtDaFARtrbadzD94P27Uql/4K7fmMLX
 nUsAdnf4Uaur452M=
X-Received: by 2002:a05:600c:2055:b0:3f1:9b85:e305 with SMTP id
 p21-20020a05600c205500b003f19b85e305mr29538783wmg.34.1684312906577; 
 Wed, 17 May 2023 01:41:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ61qmPmhKYPSwU/c1qaSVdzaZKO+rUBL+wuwPo7uMcoOpCv/Ys18MXmnrMiQxp9UdT0Tvi3LQ==
X-Received: by 2002:a05:600c:2055:b0:3f1:9b85:e305 with SMTP id
 p21-20020a05600c205500b003f19b85e305mr29538767wmg.34.1684312906307; 
 Wed, 17 May 2023 01:41:46 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-218.web.vodafone.de.
 [109.43.177.218]) by smtp.gmail.com with ESMTPSA id
 s22-20020a1cf216000000b003f080b2f9f4sm1518947wmc.27.2023.05.17.01.41.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 01:41:45 -0700 (PDT)
Message-ID: <62a36798-0088-720a-698a-31394b9c25aa@redhat.com>
Date: Wed, 17 May 2023 10:41:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
References: <20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v8.0.1 00/36] Patch Round-up for stable 8.0.1, freeze on
 2023-05-27
In-Reply-To: <20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.666, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 17/05/2023 10.00, Michael Tokarev wrote:
> Hi everyone,
> 
> The following new patches are queued for QEMU stable v8.0.1:
> 
>    https://gitlab.com/qemu-project/qemu/-/commits/staging-8.0
> 
> Patch freeze is 2023-05-27, and the release is planned for 2023-06-29:
> 
>    https://wiki.qemu.org/Planning/8.0
> 
> Please respond here or CC qemu-stable@nongnu.org on any additional patches
> you think should (or shouldn't) be included in the release.

I'd like to suggest:

  970641de01908dd09 s390x/tcg: Fix LDER instruction format

  c70bb9a771d467302 docs/about/emulation: fix typo

  88693ab2a53f2f3d2 s390x/pv: Fix spurious warning with asynchronous teardown

  80bd81cadd127c1e2 util/async-teardown: wire up query-command-line-options
  (only if it is not too cumbersome to pick, but without this the option is
  useless for libvirt)

Thanks,
  Thomas


