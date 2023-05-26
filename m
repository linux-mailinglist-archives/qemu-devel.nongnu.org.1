Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDA87124B6
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 12:32:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2UjL-00051h-IU; Fri, 26 May 2023 06:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2UjI-00051F-6f
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2UjG-0006f3-OM
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685097085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58d9cCEvt+hEjfd8PZfzT5/z1/DJnGNb6QOOSya4s2M=;
 b=fRPXk9uGlcuCwvsQcV8CXtYxKQ6nQDS0U6KPRP6YNLNJ2M5qTkjEr+Ak+BZ7pODUZNI0uH
 MSBSs6Km8FYPF2TqDB2E+5vJDkkFInr9AHBNQrsTfjFYpQdoofVJNgAX2FM6tDXH97+nb/
 e1sufY4aWOTIX/Tiy3vg1Q2yEHnuiW8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-OuUpYtVMP9mZzpBmij5Isw-1; Fri, 26 May 2023 06:31:24 -0400
X-MC-Unique: OuUpYtVMP9mZzpBmij5Isw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30ac5fb0920so362755f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 03:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685097083; x=1687689083;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=58d9cCEvt+hEjfd8PZfzT5/z1/DJnGNb6QOOSya4s2M=;
 b=ah4lgZNAaXftJEfxmGcwc7HJIyobKrb8tyALAZDwqcAchQHHPUO1nE0kNYTuFA5ofZ
 glLy/HmpEshkCbkhGMkyA0fMc9Fbdxxs019awCf0lXbdRC2fEt5KGDghoh1QaXAFQpQX
 9/fpxRWw8myiExnLEGzBH+Nk07JwmXFIs3i0qz5istj4ebDG8FAPsudGaKE/t6O7jjIn
 CIyBmDAI463+M1uhlmL3RhvNQCUGX2fluxdnNKIy6QVDo+7wRsJl7RqdVJM0kOqcikV/
 nlK5lNVJCsj7PJfBL/sULpLEESk/NnvvSTBsNyOIEUpKGZh8U+ZTJ1UGcXyaK3AP8erJ
 Z54w==
X-Gm-Message-State: AC+VfDxsxloCSNF0c4N6erH7eV1IEUPDpxLG6aBXscXdeH/YY+MR+TWW
 JZNQK5/na6UZGP7+h6Xwug4lT89eJtGn6cNQBZqKehI8LFqqdNYmEiJ+92yIG5gbV+E4lJHbytE
 gG7OUjSyFF4Ll3Y8=
X-Received: by 2002:adf:d84c:0:b0:2cf:e517:c138 with SMTP id
 k12-20020adfd84c000000b002cfe517c138mr880725wrl.66.1685097083538; 
 Fri, 26 May 2023 03:31:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5krlqkBCH+liopJWOU2FrIYDA/e+QViYCBphgvFhotLY+jyABUcGcLb8ha321GM8qpwn6ACA==
X-Received: by 2002:adf:d84c:0:b0:2cf:e517:c138 with SMTP id
 k12-20020adfd84c000000b002cfe517c138mr880709wrl.66.1685097083228; 
 Fri, 26 May 2023 03:31:23 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-189.web.vodafone.de.
 [109.43.176.189]) by smtp.gmail.com with ESMTPSA id
 e18-20020a5d5312000000b0030922ba6d0csm4760223wrv.45.2023.05.26.03.31.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 03:31:22 -0700 (PDT)
Message-ID: <6a3e792e-757e-61f5-ca2d-c1933c0cf0ee@redhat.com>
Date: Fri, 26 May 2023 12:31:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/5] gitlab: centralize the container tag name
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
References: <20230517135448.262483-1-berrange@redhat.com>
 <20230517135448.262483-2-berrange@redhat.com>
 <0626bd64-581b-0324-a1d7-8eee741fc08f@redhat.com>
 <ZHCH577CiN67vla5@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <ZHCH577CiN67vla5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 26/05/2023 12.20, Daniel P. Berrangé wrote:
> On Fri, May 26, 2023 at 09:25:39AM +0200, Thomas Huth wrote:
>> On 17/05/2023 15.54, Daniel P. Berrangé wrote:
>>> We use a fixed container tag of 'latest' so that contributors' forks
>>> don't end up with an ever growing number of containers as they work
>>> on throwaway feature branches.
>>>
>>> This fixed tag causes problems running CI upstream in stable staging
>>> branches, however, because the stable staging branch will publish old
>>> container content that clashes with that needed by primary staging
>>> branch. This makes it impossible to reliably run CI pipelines in
>>> parallel in upstream for different staging branches.
>>>
>>> This introduces $QEMU_CI_CONTAINER_TAG global variable as a way to
>>> change which tag container publishing uses. Initially it can be set
>>> by contributors as a git push option if they want to override the
>>> default use of 'latest' eg
>>>
>>>     git push gitlab <branch> -o ci.variable=QEMU_CONTAINER_TAG=fish
>>>
>>> this is useful if contributors need to run pipelines for different
>>> branches concurrently in their forks.
> 
>>
>> This patch no longer applies ... could you please rebase and resend a v2?
>> Thanks!
> 
> I've rebased and sent a v2, but I didn't get any conflits when
> rebasing, so v1 should have applied OK.

git-am is sometimes more picky than git-rebase ... I think there were some 
contextual conflicts with the patches from Camilla (commit 5f63a67adb5847 
and b105ce60ca8bdee3) ... I should have maybe tried with "--3way" first 
before complaining, sorry.

  Thomas


