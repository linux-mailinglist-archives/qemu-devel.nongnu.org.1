Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBB779A9B6
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:30:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfiD3-0001ED-QS; Mon, 11 Sep 2023 10:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfiD0-0001DS-Az
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 10:48:15 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfiCw-00081H-Og
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 10:48:13 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-401b393df02so53139955e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 07:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694443689; x=1695048489; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3mYMtC+nwrsIQDp8hBIbh7xm9Oy4/Hsx2RjFdXqQh4c=;
 b=zXhhx0WGAaREDF3/b76bkcT0Wrt81+dkRwdXEVf9jF4VuTyM4g+jdyZezI7x4GDHfv
 VAnJkHgVgl+Dh5ywDgByUhDC5YyiWYBvn0KyK2g1IPCIJRJ2gWJ/tjpRPwcVf8YZtW0W
 9Di9Ewl1wIin1XrZgWPBxHirOkKJraeNow6bH1QrG/yoI/1cqdqOxbDTm3xf+KcfMxXw
 ay1Jg8UAEJDUvhnwJUX4VmiXH9icKbvjXYLH+W//A62PFUJoomGydGH6Ad2UUwZJtWts
 5Bb/qaqlT8/xjoGV2R2E4bgTsI4P9NrkDNNLlMnaJM8aE5IAkxGXtGybYzNtlgDwuyML
 I7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694443689; x=1695048489;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3mYMtC+nwrsIQDp8hBIbh7xm9Oy4/Hsx2RjFdXqQh4c=;
 b=wd6mE17mJwCPJGT0HMxNZz/L/jrK5/1VpcBa0Y77AdR64QgEI0S9KjblfJ5IybexZu
 ZqD2TtPlFvrsNUaDuLn/1zuwoY5gOu7oNJqJBO42IUmcce0WsfP3L+Ms+6TkqhsrOQpB
 2ME97j5trZIQjtlw7J9fOPC6OrzBX1d9soLwb8oUdUypGDgxiCspgGoM7bwTi8qY6esV
 qEilsnIADLNS7qs+ikxXnQjol5CEdPI9RgeMJzr6Wm6y8D7xFzPEG6adX2rueHUo50cq
 rBQta6RyCTCcQ8gIyexCVqb4nbVDEdWBVCu0vWFyZv4ENiEaIm81A6kA9OhnYlRkkTv2
 ps6A==
X-Gm-Message-State: AOJu0Yxd7ge8xlMisS2+nRaq1ZRq2ZeDJeeraZJvSDIxNHUqyOQrcP8G
 jy33mFsT/yhYy38Y4w7yF+DzHA==
X-Google-Smtp-Source: AGHT+IHpKpUBdUsrooXmOMJJhqZghhm+N4emH1Sp0NtbeNDUSDUuiHjbaiGrQjTJeaHYxImONJ8Xxg==
X-Received: by 2002:a05:600c:214d:b0:401:cbf6:e5cc with SMTP id
 v13-20020a05600c214d00b00401cbf6e5ccmr8679334wml.22.1694443688882; 
 Mon, 11 Sep 2023 07:48:08 -0700 (PDT)
Received: from [192.168.69.115] (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr.
 [176.171.221.76]) by smtp.gmail.com with ESMTPSA id
 m7-20020a7bce07000000b003fee8793911sm10195516wmc.44.2023.09.11.07.48.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 07:48:08 -0700 (PDT)
Message-ID: <8fe804a1-39b5-6dd7-755b-fe65da3126f9@linaro.org>
Date: Mon, 11 Sep 2023 16:48:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PULL 24/51] meson: compile bundled device trees
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, Michael Tokarev <mjt@tls.msk.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>, qemu-ppc <qemu-ppc@nongnu.org>
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907130004.500601-25-pbonzini@redhat.com>
 <fee31724-3b75-95d6-f4d6-2e7b8f17bf96@linaro.org>
 <8cab2217-b989-2be2-421c-c495e19dab87@tls.msk.ru>
 <a95e38d6-d968-9799-9c86-fa592b0feda7@eik.bme.hu>
 <9e9421ef-ecdb-5490-5c4f-3151e6ea23b3@tls.msk.ru>
 <11a4985d-6b60-e639-c855-6c0982dd8a03@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <11a4985d-6b60-e639-c855-6c0982dd8a03@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 8/9/23 22:07, BALATON Zoltan wrote:
> On Fri, 8 Sep 2023, Michael Tokarev wrote:
>> 08.09.2023 22:21, BALATON Zoltan:
>>> I was about to ask, since when but probably nobody knows then. AFAIR 
>>> I had no such errors for the canyonlands one when I've added it but 
>>> that was quite some years ago and things in dtc for example could 
>>> have changed so it now gives these warnings.
>>
>> I think it can be said based on debian build logs. Lemme see..
>>
>> https://buildd.debian.org/status/logs.php?pkg=qemu&arch=all
>>
>> The first log entry there is from 2018-12-12, for qemu 3.1, dtc 1.4.7.
>> It has:
>>
>> dtc -o b/qemu/pc-bios/bamboo.dtb pc-bios/bamboo.dts
>> b/qemu/pc-bios/bamboo.dtb: Warning (unit_address_vs_reg): /memory: 
>> node has a reg or ranges property, but no unit name
>> b/qemu/pc-bios/bamboo.dtb: Warning (unit_address_vs_reg): /plb/opb: 
>> node has a reg or ranges property, but no unit name
>> b/qemu/pc-bios/bamboo.dtb: Warning (chosen_node_stdout_path): 
>> /chosen:linux,stdout-path: Use 'stdout-path' instead
>> b/qemu/pc-bios/bamboo.dtb: Warning (interrupts_property): /plb/opb: 
>> Missing interrupt-parent
>> b/qemu/pc-bios/bamboo.dtb: Warning (interrupts_property): 
>> /plb/opb/ebc: Missing interrupt-parent
> 
> 
> OK so bamboo was likely always like that. Sam460ex (aka canyonlands 
> which is the devel board it is based on) was added in February 2018 so 
> that was OK back then but later dtc versions may have become pickier 
> somewhere between 1.4.7 and 1.6.0.
> 
>> next it was moved to one of the subpackages, and moved back to
>> arch-independent package in 6.2 (2022-01-09, dtc 1.6.0), which has:
>>
>> dtc -o b/misc/bamboo.dtb pc-bios/bamboo.dts
>> pc-bios/bamboo.dts:45.9-48.4: Warning (unit_address_vs_reg): /memory: 
>> node has a reg or ranges property, but no unit name
>> pc-bios/bamboo.dts:87.13-154.5: Warning (unit_address_vs_reg): 
>> /plb/opb: node has a reg or ranges property, but no unit name
>> pc-bios/bamboo.dts:198.3-50: Warning (chosen_node_stdout_path): 
>> /chosen:linux,stdout-path: Use 'stdout-path' instead
>> pc-bios/bamboo.dts:87.13-154.5: Warning (interrupts_property): 
>> /plb/opb: Missing interrupt-parent
>> pc-bios/bamboo.dts:100.14-108.6: Warning (interrupts_property): 
>> /plb/opb/ebc: Missing interrupt-parent
>> dtc -o b/misc/canyonlands.dtb pc-bios/canyonlands.dts
>> pc-bios/canyonlands.dts:47.9-50.4: Warning (unit_address_vs_reg): 
>> /memory: node has a reg or ranges property, but no unit name
>> pc-bios/canyonlands.dts:210.13-429.5: Warning (unit_address_vs_reg): 
>> /plb/opb: node has a reg or ranges property, but no unit name
>> pc-bios/canyonlands.dts:464.26-504.5: Warning (pci_bridge): 
>> /plb/pciex@d00000000: node name is not "pci" or "pcie"
>> pc-bios/canyonlands.dts:506.26-546.5: Warning (pci_bridge): 
>> /plb/pciex@d20000000: node name is not "pci" or "pcie"
> 
> Linux has this in arch/powerpc/boot/dts/canyonlands.dts and at least had 
> a change of the pciex names to pcie that should fix some of these but if 
> the u-boot still uses older names then could updating this result in 
> different results between using -kernel and without that? I don't know 
> how guests use the dtb so can't tell what to do but keeping it 
> consistent with the older u-boot this board has seems like a safer option.

Maybe we can use '-W no-pci_bridge' for this particular one.

