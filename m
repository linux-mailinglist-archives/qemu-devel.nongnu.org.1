Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B03802AF9
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 05:44:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA0oY-0004Z2-3k; Sun, 03 Dec 2023 23:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0oW-0004Yb-8p
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:44:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0oU-00084r-Sa
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701665049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kPMY8kUBOqsmrcelUNCga90ds67VGvp1W/qFKpR9kQs=;
 b=NNea7et/GaTy0eHuq+uOKOCFpCRApfO+q+wLnba3VmIr8PCiwGHlwg7s4upv/KQtaMgeCk
 pZfM0MUI25IGPL9QxGup1wxpxjs8yGzEL1O+peLzgoxaReodIHk6HsgsS6YR+VjIUwsT+l
 7mLt6yuSmn1kPNOm/g24lCC+g3d9i74=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-lHIMeTF6Nm2B3t3q_-vOPg-1; Sun, 03 Dec 2023 23:44:07 -0500
X-MC-Unique: lHIMeTF6Nm2B3t3q_-vOPg-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1d08acaab7fso2244265ad.1
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 20:44:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701665047; x=1702269847;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kPMY8kUBOqsmrcelUNCga90ds67VGvp1W/qFKpR9kQs=;
 b=EA9uo/JOniDDjisjvrMb5dftcT7LwiJxYn2P4S9l1WdxiJzaeHOFmbUF3BaWkdA06/
 Z7kJXtqc/K1kDdRGEteSqDesgKyzclYhO4eq/C5QEAUd8jPSHyTZH+VRmpcc+jXChCub
 qKUT9qs/mSoT4vzHK/cWsvjtI6KF2TIsnZu9aBt6mmww1ejrIYOkNxGVfKoz7psDj6M4
 nFBgVt2szkQZVa9jKZEx7Srs9XNNyBaNeCMoajrWwxqbjyPp5I5dIiKcQkQ6811cGwxb
 GHWjFbuFlUpnmGVpg9ZAv9KkGF19QDVxwekKh1+uNLEV+EJ2/QAEPL9h/c8P5Qh3tf1O
 hCIw==
X-Gm-Message-State: AOJu0Yzw6dJHqYD3Pv4wruvpEgUP0UqxQtyRmsIeoeAhOS7evsLGPrru
 jmZI0Of5slkCdFRGjkaMOSJI/LwZtsATPK1wHx1NYt7pZTjxrSF7IZxtomTDfwhU53XTcesm7fT
 fn0lAwHxrwY6BJ3Q=
X-Received: by 2002:a17:902:d5cb:b0:1cc:5a1c:3d94 with SMTP id
 g11-20020a170902d5cb00b001cc5a1c3d94mr1266892plh.18.1701665046939; 
 Sun, 03 Dec 2023 20:44:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfCMnpmkUD/J+LgtNwM66+fgdTINYhyaXDlICnyKdkVzxyY2QxMPxYwx/fLi+/ryz/jvXwFg==
X-Received: by 2002:a17:902:d5cb:b0:1cc:5a1c:3d94 with SMTP id
 g11-20020a170902d5cb00b001cc5a1c3d94mr1266884plh.18.1701665046682; 
 Sun, 03 Dec 2023 20:44:06 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001d058ad8770sm5298193plw.306.2023.12.03.20.44.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 20:44:06 -0800 (PST)
Message-ID: <ee2c30ff-0220-4204-821f-73e77520bc46@redhat.com>
Date: Mon, 4 Dec 2023 14:44:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 02/25] memory: Have
 memory_region_init_ram_nomigrate() handler return a boolean
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Xu <peterx@redhat.com>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-3-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120213301.24349-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/21/23 07:32, Philippe Mathieu-Daudé wrote:
> Following the example documented since commit e3fe3988d7 ("error:
> Document Error API usage rules"), have cpu_exec_realizefn()
> return a boolean indicating whether an error is set or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/memory.h | 4 +++-
>   system/memory.c       | 5 +++--
>   2 files changed, 6 insertions(+), 3 deletions(-)
>

s/cpu_exec_realizefn()/memory_region_init_ram_nomigrate() for the commit
message, as mentioned by Peter Xu.

Reviewed-by: Gavin Shan <gshan@redhat.com>


