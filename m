Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 361AD7867E0
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 08:54:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ4Cv-0002LZ-K9; Thu, 24 Aug 2023 02:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qZ4Cs-0002LA-DI
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 02:52:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qZ4Cp-0003XW-Kd
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 02:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692859953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=frqIRTe9MHbdnRrD5hDxOns4CjHsVod24clb8fadTog=;
 b=HwXB6m2pZxjlC+O7n9/C6sJHLqdZBgx7y/ZyNJ4LwFpGs6xl/n4uZEAc2kf8nKyuUGUBbE
 nuf7zDo0gwvdaBWB4NHOuvXKsjgvlzUubY6Lh32z2PVZ/vCFOzCLaD0F7WvXHffQH/0oyi
 jYwq+BPUqJ+HA/RcZc2L/MWug5Xu9Is=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-WtHahTOwPnKx-Jn0yIws7Q-1; Thu, 24 Aug 2023 02:52:31 -0400
X-MC-Unique: WtHahTOwPnKx-Jn0yIws7Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4011fa32e99so4563105e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 23:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692859950; x=1693464750;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=frqIRTe9MHbdnRrD5hDxOns4CjHsVod24clb8fadTog=;
 b=hWddB5qL8qQrT495yHvd9/KvJQkqowy94G2s5hLgZhSlRaRoeaEoxFlbT/aMh+3KSx
 QI98OebKtGfucuIyoinzgl/ix1BwpR8zwBQJXMdWfOb4DWZXcDFVLvobWlRBBHNHk2x6
 m1MUMOyn7y0ixbpHGs4d020ffDTs3JTPqlppxjgqKnCM1uf2H2zLe+Vwa+EgEIfHggcj
 u+Xz/+Y4r333i0rpIfWDqV6WPgpzVKXsfYXzcKaAH5PqjX79y6clrv38C96bBGrig9dj
 aIDkGrbgvsiOBsyaLpbocJjLre7oiSG75LxkaUmfY6fK61NyJY0fBbRjzMzQdmLcILLl
 oTKQ==
X-Gm-Message-State: AOJu0YyDp61Pa4aVkUTcGlKG6wiyLxAV8c3gRyXGWNy4RGW08GSBSkkD
 gEZh/ynUATeJFIn3zjXy4rQhB72JMZt6wQtu9wSdvMZKYFvi1UNoiCcDeXRZaGXz06Dfk2laMAS
 hCCvHg75DkgzCFZY=
X-Received: by 2002:a5d:54c1:0:b0:31c:65aa:b15a with SMTP id
 x1-20020a5d54c1000000b0031c65aab15amr4551984wrv.65.1692859950176; 
 Wed, 23 Aug 2023 23:52:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlxtI7NavsDEW6pePlAQrhKiCQWzCmkQkfXE+ub+hBqk/xwAWNOdqZDE5Y/EVgoLWX3IWJnw==
X-Received: by 2002:a5d:54c1:0:b0:31c:65aa:b15a with SMTP id
 x1-20020a5d54c1000000b0031c65aab15amr4551976wrv.65.1692859949898; 
 Wed, 23 Aug 2023 23:52:29 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-61.web.vodafone.de.
 [109.43.176.61]) by smtp.gmail.com with ESMTPSA id
 x9-20020adfffc9000000b00319756d5b80sm21430047wrs.29.2023.08.23.23.52.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 23:52:29 -0700 (PDT)
Message-ID: <aee5829f-37a4-4169-1a70-8f9a40b4f45d@redhat.com>
Date: Thu, 24 Aug 2023 08:52:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 00/12] First batch of s390x patches for QEMU 8.2
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>
References: <20230823114544.216520-1-thuth@redhat.com>
 <20230823163440.GA851545@fedora>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230823163440.GA851545@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.684, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 23/08/2023 18.34, Stefan Hajnoczi wrote:
> On Wed, Aug 23, 2023 at 01:45:32PM +0200, Thomas Huth wrote:
>> The following changes since commit b0dd9a7d6dd15a6898e9c585b521e6bec79b25aa:
>>
>>    Open 8.2 development tree (2023-08-22 07:14:07 -0700)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/thuth/qemu.git tags/pull-request-2023-08-23
>>
>> for you to fetch changes up to 6c49f685d30ffe81cfa47da2c258904ad28ac368:
>>
>>    tests/tcg/s390x: Test VSTRS (2023-08-23 12:07:30 +0200)
> 
> Hi Thomas,
> Please take a look at the following ubuntu-20.04-s390x-all CI failure:
> https://gitlab.com/qemu-project/qemu/-/jobs/4931341536

It says: "TimeoutError: Timeout waiting for job to pause" ... could you 
please check the load on that host? ... I think that s390x runner is known 
for being too slow some times, so I assume that problem should go away if 
you re-run the job when it is less loaded.

  Thomas



