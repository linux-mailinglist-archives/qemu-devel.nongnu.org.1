Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9301E832CFB
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 17:15:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQrVA-0001qQ-Rw; Fri, 19 Jan 2024 11:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQrUv-0001pu-2F
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:13:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQrUt-0001Lp-B9
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705680814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/D8C7Bwsl1YkC1ZagOApFugrNMHw0vxYuiQvBwCRkEs=;
 b=CTcV3BN3i9DgL0XbXWB87ObQYYz3jI/tXgj11D0x6JOzI9BIZFeB7Ox4HPD3o0zd2uciv0
 QsagJbHZ42ZOsnLrGXEpHRf+7Jexi5uvzypaYR3Cirf5CzVPEO0Tog233zNKF5Gvc6CiVl
 HXwviNgm7uh5hiyNwQEGH7KiAnZKwtU=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-1YOErJc3NyidDlQOHk6EiA-1; Fri, 19 Jan 2024 11:13:31 -0500
X-MC-Unique: 1YOErJc3NyidDlQOHk6EiA-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3bd3eb9643dso1663120b6e.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 08:13:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680810; x=1706285610;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/D8C7Bwsl1YkC1ZagOApFugrNMHw0vxYuiQvBwCRkEs=;
 b=ZBxH58t+BF7zRK3Cl4ukNpFDfz9GJAiZk7rg6EPKTtpBWRLCEM04Wbo6s/mn70B8+2
 rpqKRe4O1yAivz5027RrRZWJKwIH9zkUwwXEGvXHWJlQzzEpoFwdQZig3DdTcOAu/d+u
 sYagoUgcZ9AzattzN2HLKSw3ZOlWj3gHVjDgncLvJpwWPYXUUA+YVwX9wr1o9ryOwFDs
 GSHoA0RrMZyRGUOTouffATOxZMet27HnSSDoPogBJ3JFTwbzRbpVefgnw1nemaHrQUh+
 CrPT/IlYNa/H2ReW+8SJ3mGEibjqWQAQInt+R74u9iH7Nz1xzWvCdr81RRSBQOWcJAtz
 xufw==
X-Gm-Message-State: AOJu0YxmmDQRJwJ+xaj/sj+JXrVi2j1c7zlZCCPttQ9c91OvLhqbIubD
 u1/ozkclYuIp21JhQ77x+ojPOXwToGxCy53Qdb2SZ6g5CdFT19y8E3x+8itFtk7WirLaYBA5vHB
 17h0/Tg+FCuUNFc3dfOWmuBMNuiFuuur8ywnPwmTjtiW/ZQK7Zrvt
X-Received: by 2002:a05:6808:1184:b0:3bd:90c3:20e9 with SMTP id
 j4-20020a056808118400b003bd90c320e9mr2631666oil.106.1705680810312; 
 Fri, 19 Jan 2024 08:13:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtLqzT5Qm1IdB9LAXOFcyTU1viZIj324AmjhYK0/uG/oD2aRmX0TC7jjKRGXC5FVboSNC1wg==
X-Received: by 2002:a05:6808:1184:b0:3bd:90c3:20e9 with SMTP id
 j4-20020a056808118400b003bd90c320e9mr2631661oil.106.1705680810057; 
 Fri, 19 Jan 2024 08:13:30 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-179-227.web.vodafone.de.
 [109.43.179.227]) by smtp.gmail.com with ESMTPSA id
 h27-20020a05620a10bb00b0076db5b792basm6152900qkk.75.2024.01.19.08.13.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jan 2024 08:13:29 -0800 (PST)
Message-ID: <b851a8f8-228f-45db-a636-5321f6a41f1e@redhat.com>
Date: Fri, 19 Jan 2024 17:13:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU's tests/unit/test-iov times out on NetBSD and OpenBSD
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <th.huth@posteo.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Tokarev
 <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>,
 Brad Smith <brad@comstyle.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <f4bug@amsat.org>
References: <4e802a6d-fb97-4e49-ab78-2a75371e464d@posteo.de>
 <ZaqeLbJ1YQIhuvJH@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZaqeLbJ1YQIhuvJH@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 19/01/2024 17.07, Daniel P. Berrangé wrote:
> On Fri, Jan 19, 2024 at 03:55:49PM +0000, Thomas Huth wrote:
>>
>>   Hi,
>>
>> since we recently introduced test timouts in QEMU's meson set up, I noticed
>> that the tests/unit/test-iov times out when doing "make vm-build-netbsd
>> BUILD_TARGET=check-unit" (or vm-build-openbsd).
>>
>> And indeed, when increasing the timeout, you can see that the test-iov runs
>> for multiple minutes on these BSDs while it finishes within few seconds on
>> Linux.
>>
>> I had a closer look at the test, and the problem seems to be the
>>
>>   usleep(g_test_rand_int_range(0, 30));
>>
>> in the test_io() function. If I get that right, the usleep() seems to be
>> more or less precise on (modern) Linux, but it seems like it sleeps for
>> multiple milliseconds (not microseconds) on the BSDs. Since it is used in a
>> nested loop, these milliseconds add up to a long time in total during the
>> test.
>>
>> Does anybody have an idea how to fix that? Is there a more precise (but stil
>> portable) way to sleep less long here? Or could we maybe remove the usleep()
>> here completely (it does not seem to have a real benefit for testing as far
>> as I can see)?
> 
> 'g_usleep' has the same API contract, but is implemented in terms
> of 'nanosleep' on *NIX. So as a quick test, try switching usleep
> to g_usleep and see if we get lucky.

No, that seems to behave the same way, unfortunately.

Do you see a reason why we'd really need the usleep() here at all? 
Otherwise, I think I'll send a patch to simply remove it...

  Thomas




