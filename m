Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ABE70EFEB
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 09:52:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1jHC-0001hH-So; Wed, 24 May 2023 03:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1jH9-0001gz-DQ
 for qemu-devel@nongnu.org; Wed, 24 May 2023 03:51:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1jH7-0004XY-UW
 for qemu-devel@nongnu.org; Wed, 24 May 2023 03:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684914672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZRD/7r4gmCZWu2ZRSEfG8TTygVEKEQeNeOqmzxlJQI=;
 b=fcVt44t+/cDE664YZIZwEITPXXA4/GRfF0bE9UrFx1TwPLjd0Qxr3/UXPO5e6fL0p3ZtAF
 ftTXeVnvQhImLh3fZcsO0QzuoZpNvOCKmKMbuH0RpvlLM9U87ulMRL5G747UN61NRQJ2kt
 xRA+u2S1Jzo4MxwoQl9P+YBb2oKaw8I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-hL6IxZGhN6CRjYW9WyF94w-1; Wed, 24 May 2023 03:51:11 -0400
X-MC-Unique: hL6IxZGhN6CRjYW9WyF94w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so2479865e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 00:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684914670; x=1687506670;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IZRD/7r4gmCZWu2ZRSEfG8TTygVEKEQeNeOqmzxlJQI=;
 b=fGD0sSpf6tii7GW2vg/G8B1xop7No64rRVALwEDVDgPmksnz29H6P25//HboNFyDWn
 Rt17YCgnwpwPVl083L0aB3cIRpvfaxzW52wrc/HJUgMvH9KIllx/4ssdRwpPM+VSYa2F
 CuVTgxXxS9d6o4OIBcdDrBNHTGWRMiq5uC3BWR66NFNnfEQHY0TnDC6nTvtrzYK5PZXc
 veXE5Fof8Yl85Z2dzR1FeeBo4RF5pB+SXao4KjF2vSc3cL1kEMxBu4Xm4L03MCgt+w48
 3hfS+f7Ba1keRKnDEPTZdY0aVfL68qtTNEEpkmO0U8LJ7KM4cEhtMlpu/93fY8/QnH6g
 nyiQ==
X-Gm-Message-State: AC+VfDzh736ci4aMwWL6zAOlygggaWeXjySxna1KIeqazQOnzY8w6BpX
 IAFyWFVCHWIpO0K3KKigBRSACZWI0K07szS1mTdKqOl44vLbQH3xYSYwCLT7z7iy/9yHl6+J/MY
 BtQZhV+0vSC1H19s3xXHEbbo=
X-Received: by 2002:a05:600c:20c:b0:3f4:2266:8cf0 with SMTP id
 12-20020a05600c020c00b003f422668cf0mr12236967wmi.10.1684914670275; 
 Wed, 24 May 2023 00:51:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7pyR/EeMa9XKiY4wPmzLfJ/JVIdVDMWKa2uM+hICwPSZ53SLT4n/HDeXXSbnGFAHRD9t4xBQ==
X-Received: by 2002:a05:600c:20c:b0:3f4:2266:8cf0 with SMTP id
 12-20020a05600c020c00b003f422668cf0mr12236948wmi.10.1684914669984; 
 Wed, 24 May 2023 00:51:09 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-64.web.vodafone.de.
 [109.43.176.64]) by smtp.gmail.com with ESMTPSA id
 17-20020a05600c231100b003f31d44f0cbsm1357941wmo.29.2023.05.24.00.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 00:51:09 -0700 (PDT)
Message-ID: <3930f337-53b3-075f-a518-0c25bd75e21f@redhat.com>
Date: Wed, 24 May 2023 09:51:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/6] meson: use subprojects for bundled projects
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 richard.henderson@linaro.org, qemu-s390x <qemu-s390x@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>
References: <20230519085647.1104775-1-pbonzini@redhat.com>
 <CAFEAcA-nMG_5u4pADASoQNF_MCCXHMCB3APTtVLohzTzCmJ3cQ@mail.gmail.com>
 <ZGdCL3Ka2JSeo+XD@redhat.com>
 <8c5c87b0-79e3-02c1-b093-3d636a9853b0@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <8c5c87b0-79e3-02c1-b093-3d636a9853b0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 19/05/2023 13.48, Paolo Bonzini wrote:
> On 5/19/23 11:32, Daniel P. Berrangé wrote:
>> Feels like we should be able to figure out some way to get rid of all
>> the submodules though, except for the roms, which are special and ok to
>> leave IMHO
> 
> Hmm, almost.  roms/SLOF is used to build pc-bios/s390-ccw/s390-netboot.img, 
> so right now GIT_SUBMODULE and GIT_SUBMODULE_ACTION could not be removed 
> even without counting the tests/fp submodules.  That's about 10,000 lines of 
> code, or about 20% of all of SLOF; it might be a bit too much for vendoring.
> 
> Adding Thomas for ideas...

Sorry, I also don't have any good ideas here. We could maybe copy the libs 
from the SLOF repository over into the s390-ccw folder, but that's kind of 
ugly, too (there aren't many updates in SLOF anymore, so it wouldn't at 
least hurt too much from a synchronization point of view) ... CC:-ing 
qemu-s390x mailing list, maybe somebody else there has a better idea.

  Thomas


