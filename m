Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CB57E6C45
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:14:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15lb-0003p1-FG; Thu, 09 Nov 2023 09:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1r15lY-0003e4-FG
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 09:12:16 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1r15lW-0001hz-Le
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 09:12:16 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3b52360cdf0so480166b6e.2
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 06:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699539132; x=1700143932; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XdPMy5GCblk2oZj7BPm0Mv+JTZ3/O3d7uW7WH8URlD4=;
 b=He1gyX5SWjGIT8PuijupR0iVD1bGMQxmJyNIVANyx6VuLmNqWQkRCGeDUa3pORaJDg
 xd69wUjXzjRlR30rv4q018oMNfvjauDus0zkYTGkSvhYQ0F5jsxcwELw9TRbJHmGMFFE
 EfuQwn1+pXMqBjTVJgXivpZ/bxIScK6P5jjkuV7Ww4YW6kqsFLzMCFjYsyYoVEKjaErt
 +OYshtgeNCoX+DQg4JmgkAlXsaQDmgl6hHZccFhwWURmNKplYe72LWuWrIdDH3V4Y19f
 FnmKdz4JF96WZuEwvXeiCpPqom9IXCVFQ/Ic8Hs80+RdYVimmZt1bMdnIhvVpuzQEdyd
 CbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699539132; x=1700143932;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XdPMy5GCblk2oZj7BPm0Mv+JTZ3/O3d7uW7WH8URlD4=;
 b=BRO++O+40pnrZvmvPALo8vy+yrxbjzufdeqIExk9RlHSnXwzvTQ2+1ua3LcGPu36GF
 URW1z8lf+YK2WqjlAk+jCInti6tbNTQColN3bdyOEQzQW4rd/+czzOsiCZvhi9FazF55
 +imYcxg0e5nwDpt49z2zXG7mbDydW7LelNwEMtfDWcsQKeHm4ClIC76bEoeALu3dnA1+
 a0thtALBmkrNAyPz9FhBfj9VGpBFi7s0bwTS//eUKeSS+9kPVRXyqAbNipopZfOMlc/Z
 R0zFkEYrvtWcLcA2tT+MSd7KxIhklNvv8sIlbAr0DAfCh/FCo6HsakEmwFl6fyBw3fKh
 A6gw==
X-Gm-Message-State: AOJu0Yx4PLaOOYSBX0CnIo2qE4rbzosOimm3JxDjcKbjX4NjmWCRSzmt
 JHG5/dzp2efnbtSOTjnWJEo=
X-Google-Smtp-Source: AGHT+IFgL2Hsfaj5GedTvogJ0gi30Yt7gd3BFaz5BAIS7OJVZAskZN8HEQq97xHt9wOoItEmCZDKYg==
X-Received: by 2002:a05:6808:2009:b0:3ab:9afd:8efd with SMTP id
 q9-20020a056808200900b003ab9afd8efdmr1839976oiw.40.1699539132305; 
 Thu, 09 Nov 2023 06:12:12 -0800 (PST)
Received: from ?IPV6:2001:ee0:50f4:9050:3366:c285:960c:ac78?
 ([2001:ee0:50f4:9050:3366:c285:960c:ac78])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a63d407000000b005742092c211sm4846189pgh.64.2023.11.09.06.12.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 06:12:11 -0800 (PST)
Message-ID: <2992a952-a444-411e-bdde-4de89498af23@gmail.com>
Date: Thu, 9 Nov 2023 21:12:07 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/5] amd_iommu: report x2APIC support to the operating
 system
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Joao Martins <joao.m.martins@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <lists@philjordan.eu>
References: <20231024152105.35942-1-minhquangbui99@gmail.com>
 <20231024152105.35942-6-minhquangbui99@gmail.com>
 <20231106193841-mutt-send-email-mst@kernel.org>
 <34300309-aa29-4a78-9e6b-aa91b05ff4af@gmail.com>
 <20231108144325-mutt-send-email-mst@kernel.org>
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20231108144325-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=minhquangbui99@gmail.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/9/23 02:44, Michael S. Tsirkin wrote:
> On Wed, Nov 08, 2023 at 09:22:18PM +0700, Bui Quang Minh wrote:
>> On 11/7/23 07:39, Michael S. Tsirkin wrote:
>>> On Tue, Oct 24, 2023 at 10:21:05PM +0700, Bui Quang Minh wrote:
>>>> This commit adds XTSup configuration to let user choose to whether enable
>>>> this feature or not. When XTSup is enabled, additional bytes in IRTE with
>>>> enabled guest virtual VAPIC are used to support 32-bit destination id.
>>>>
>>>> Additionally, this commit exports IVHD type 0x11 besides the old IVHD type
>>>> 0x10 in ACPI table. IVHD type 0x10 does not report full set of IOMMU
>>>> features only the legacy ones, so operating system (e.g. Linux) may only
>>>> detects x2APIC support if IVHD type 0x11 is available. The IVHD type 0x10
>>>> is kept so that old operating system that only parses type 0x10 can detect
>>>> the IOMMU device.
>>>>
>>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>>
>>>
>>> changes IVRS without updating expected files for tests.
>>> result seems to be CI failures:
>>> https://gitlab.com/mstredhat/qemu/-/jobs/5470533834
>>
>>
>> Thanks Michael, I am preparing the fix in the next version. I've read the
>> instructions to update the test data in bios-tables-test.c. It says I need
>> to create some separate patches to update the test data. Are there any
>> reasons for this? I intend to change the binary and include the ASL diff
>> into the commit message. Is it enough?
> 
> No, not enough.  No, do not ignore the rules please.  Yes, there's a
> reason.  The reason is that I need to be able to rebase your patches.  I
> then regenerate the binaries. If the patch includes binaries it won't
> rebase.

Okay, I got it. I will prepare the fix in the next version.

Thanks,
Quang Minh.

