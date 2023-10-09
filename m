Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7667BD430
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 09:22:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpkZk-0000C1-Pe; Mon, 09 Oct 2023 03:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qpkZi-0000Bg-7V
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 03:21:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qpkZg-0003wm-LW
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 03:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696836066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BJdTTBhwqs4is/zlpV0dt+Ku2NOnJ3G66EHykzide1Y=;
 b=hDcGK2rH+Eg01OGrDD6g/SXDQpq7UyZQHQoWbNmeUJJmfPBkTx7w83k/O+86sPNyN8MZr2
 Hy0mHMn1r4umK0NyQyLnuW+I/vGlexiGWjGjZXnX6L6ruR783HSA+UXk+YbFNS/wOuHiLJ
 trp9mjR3lq1/ZBCjgsLdOMoVdRNcHxk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-FotMGuzmOxy1hbr50ZEx5Q-1; Mon, 09 Oct 2023 03:21:05 -0400
X-MC-Unique: FotMGuzmOxy1hbr50ZEx5Q-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66885ff2a0dso52786666d6.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 00:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696836065; x=1697440865;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BJdTTBhwqs4is/zlpV0dt+Ku2NOnJ3G66EHykzide1Y=;
 b=WAPmuazJVejKeZOKR53kBfjS2D+gXhZDqT4A0Q0YYDQUtXVAQPPCNcHPUKRxCWmOUV
 qNW/pk9lv+xUXizV8R+iXMmLHPJynol525GsfBV8dMw+E8JbnXdkbSKSwXZyowVE1aik
 +wdvPbfxbC9MM4I7G85G0m49GGx5ym2HQGoIxtH5B3f6ZDBmC9LZSGWx4fnWmFSzVgiA
 m9XoO8f1NiNKp/yxlJFyo5xbvy1N9FoC+E8km2GCUDzF+jwYYGJKcdQ26u1pZOYljgw/
 k8ISimrXP7/1JKo2oXkz5B7PbpA9WMCuvRJZHBquNhmYlXCOAc493qVSHgfXIHovVXF+
 okhw==
X-Gm-Message-State: AOJu0YzPKb26uQoihA3xZ7z0ZWG5MjXbAHDQHZdBsKFCdI1msv8ZQy+G
 KmNZYS5lCVpSikOJVr0CfXLCmp2N7/7FSgrhgj6wokjYjPKsPJ8EXiCZrob5sR2QVD2bWXpC15y
 YyE3H5Lj40J/UFxs=
X-Received: by 2002:a05:6214:5585:b0:668:ef6a:7664 with SMTP id
 mi5-20020a056214558500b00668ef6a7664mr14760514qvb.33.1696836064821; 
 Mon, 09 Oct 2023 00:21:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYQD8sK2m5dGmjs2QIpfU+GyJRqPXlTk7botm48l4okr9VHK6yoiNFlOmihZHSsMgxegDVxw==
X-Received: by 2002:a05:6214:5585:b0:668:ef6a:7664 with SMTP id
 mi5-20020a056214558500b00668ef6a7664mr14760504qvb.33.1696836064593; 
 Mon, 09 Oct 2023 00:21:04 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-27.web.vodafone.de.
 [109.43.176.27]) by smtp.gmail.com with ESMTPSA id
 u14-20020a0cf1ce000000b006560eea8a7esm3606303qvl.132.2023.10.09.00.21.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 00:21:04 -0700 (PDT)
Message-ID: <62196cb3-72e4-5db2-c0c4-ec1e74c8d432@redhat.com>
Date: Mon, 9 Oct 2023 09:21:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/2] topic: meson: add more compiler hardening flags
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20231005173812.966264-1-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20231005173812.966264-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.818, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 05/10/2023 19.38, Daniel P. Berrangé wrote:
...
> 
> I also tested enabling -ftrapv, to change signed integer
> overflow from wrapping, to trapping instead. This exposed a
> bug in the string-input-visitor which overflows when parsing
> ranges, and exposed the test-int128 code as (harmlessly)
> overflowing during its testing. Both can be fixed, but I'm
> not entirely sure whether -ftrapv is viable or not. I was
> wondering about TCG and whether it has a need to intentionally
> allow integer overflow for any of its instruction emulation
> requirements ?
I'm not an expert when it comes to this question, but as far as I 
understood, we are using -fwrapv (with "w", not "t") on purpose, see 
meson.build:

# We use -fwrapv to tell the compiler that we require a C dialect where
# left shift of signed integers is well defined and has the expected
# 2s-complement style results. (Both clang and gcc agree that it
# provides these semantics.)

And according to the man-page of gcc:

  The options -ftrapv and -fwrapv override each other,
  so using -ftrapv -fwrapv on the command-line results
  in -fwrapv being effective.

If I got that right, this means you cannot use -ftrapv with QEMU.

  Thomas


