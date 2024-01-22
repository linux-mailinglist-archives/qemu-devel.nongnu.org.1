Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ABA836539
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 15:20:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRv9p-0001kI-Fn; Mon, 22 Jan 2024 09:20:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rRv9n-0001hI-Gv
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 09:20:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rRv9h-0000uw-Un
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 09:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705933203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jW1U0GH9wrs0a5He/haktS00pR/EGLiZF35/v2tjUJc=;
 b=ERK37GZZ+csHn0Uh2lhFILHtw8Tbb+V5+qK0AyagXMbkCzAONG/Ee30dMRTSwEi/bmn2lU
 dTwepgcqeMNJhmDGwPy5wfYbtLt4Nqss2m1zPTopRx4ToFKD7cJUDuS3nPaocTDOgywKPk
 x2AjGxwB5mX3KUMKoR5+4+hLgJRw0Tc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-GWpGM0nIN0OdEi_rFPcRgQ-1; Mon, 22 Jan 2024 09:20:01 -0500
X-MC-Unique: GWpGM0nIN0OdEi_rFPcRgQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-68694f9e037so7091006d6.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 06:20:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705933201; x=1706538001;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jW1U0GH9wrs0a5He/haktS00pR/EGLiZF35/v2tjUJc=;
 b=mSUywtY0OBiKNM6BBuf9Zq3xgRurb26G2J2cZ9G9Qf+PfyLXJSP+z+p7MIf945Fplz
 JYtyYM4P3xUQbFpeAFw9iG7WpKEOBVDx2ptyedf5bC/V1gEYRG0R7Zcg9A1G+ysSiY0u
 lTmekfnxU1OAFXiHliNHMR03qluZ92n9OoQqWoAEMOFZZ+2Rxl2wUB+G4S05eQBKfy8e
 dPDfBrhzWeR6lQ2jkm8XXif6TvbLy3Huqvb5AU01DWU9Hi2syF2ubhZKnwneqfhTatxN
 pzpFi5Aa3xoTwn6TbWptdjpTbDWTdGogNjgExBkFNCk5wTn77h2QcIXFgWfJjUXNqojd
 lFAQ==
X-Gm-Message-State: AOJu0YxjQ/JG7azI9Qp5akZo0QzNfH1Pa/bW66vFKPbFwQFs5ZCODAB0
 k+i6wYwiPh419VL6WpQ/0+b4q38zN+0iLhaLVXNHJxCuGZpMgay0/hHy25P3C5BtaQ1i3O0ieQe
 VAUG4stPFQN3/CvcYrAEgWnmm8el2NcTb5A0GVkVN0VB5dFWnalSh
X-Received: by 2002:a05:6214:ac1:b0:684:dc67:4834 with SMTP id
 g1-20020a0562140ac100b00684dc674834mr7302011qvi.98.1705933201265; 
 Mon, 22 Jan 2024 06:20:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmJBZxj2nvi1n5PkBt45QFo3hpP6l7RwIB/pBlsx/kF+VN/a0iKwwkucSuXNvn59ynbfRGbQ==
X-Received: by 2002:a05:6214:ac1:b0:684:dc67:4834 with SMTP id
 g1-20020a0562140ac100b00684dc674834mr7301999qvi.98.1705933201021; 
 Mon, 22 Jan 2024 06:20:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 lx13-20020a0562145f0d00b00685be94b4d2sm2162598qvb.18.2024.01.22.06.19.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 06:20:00 -0800 (PST)
Message-ID: <a90cdc45-34bc-46fd-b9d6-4b13b6cfbe78@redhat.com>
Date: Mon, 22 Jan 2024 15:19:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] buses: switch to 3-phase-reset
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240119163512.3810301-1-peter.maydell@linaro.org>
 <Za3NqdR2w_4bdIew@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <Za3NqdR2w_4bdIew@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello,

On 1/22/24 03:06, Peter Xu wrote:
> Hi, Peter,
> 
> On Fri, Jan 19, 2024 at 04:35:07PM +0000, Peter Maydell wrote:
>> I wrote this ages ago and recently picked it back up because of a
>> recent PCI related reset ordering problem noted by Peter Xu.  I'm not
>> sure if this patchset is necessary as a part of fixing that ordering
>> problem (it might even be possible now to have the intel_iommu device
>> use 3-phase reset and put the relevant parts of its reset into the
>> 'exit' phase), but either way we really ought to do this cleanup
>> to reduce the amount of legacy/transitional handling we have.
> 
> The VFIO issue I was working on may not directly benefit from this series
> iiuc, as it's more of an special ordering on both (1) VFIO special case
> reset path using qemu_register_reset(), and (2) VT-d device is not put at
> the right place in the QOM hierachy [1].
> 
> Said that, thanks a lot for posting the patches; they all look reasonable
> and good cleanups to the reset infrastructure, afaict.


Yes. I took the series in my vfio testing environment (x86_64 and s390x) and
didn't see any issue. I will keep it for further testing.

Thanks,

C.




