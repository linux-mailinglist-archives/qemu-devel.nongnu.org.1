Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D6D7D954C
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 12:34:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwK90-0005Dr-IK; Fri, 27 Oct 2023 06:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwK8s-0005DW-QI; Fri, 27 Oct 2023 06:32:40 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwK8q-00004t-TT; Fri, 27 Oct 2023 06:32:38 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40838915cecso15259525e9.2; 
 Fri, 27 Oct 2023 03:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698402755; x=1699007555; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=EnKvJtLdMM1klAtGShdO3PmXCUUiIZMF8/1aPxmDPfI=;
 b=V7YK6JO30+xTzeDNXUbhWYVbVRczvPv/xAJthAkC2HsWltenh5CkxqTJUzMgNTy63f
 +QQiT5HCxvhEdGFU1Mg+/gBDf8BPfX8kYV5tDP+Ya2oIyZVR5HOMRJ5SUNq63EH0h+EX
 oCJ/5X9uA+32c7Up1z5n50e2nd0xLAYSX4mxo7hx3ESUzsEYtL9OzHrW3jx98cHwYMfk
 Hk29Peu2n5lOrwrrfoAq+1krGD+NbHPklGYY2ALLBF+koRDmEBIhPpaymmhF3OO0JT4L
 ZobDvwugOmNo0B6v+G961Pm0Rj0L+Dy6fu8r3jQkYk2BRqhP/+azxlEVw5kz+MrV6kJd
 UF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698402755; x=1699007555;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EnKvJtLdMM1klAtGShdO3PmXCUUiIZMF8/1aPxmDPfI=;
 b=EOoc27LMw7ftfRkI99CSWnetBUcSpKkqtM9uyHUxNaS2R9OrADw4AtnGjuL5sbQz7B
 cqumWWbjWboQae3OINCRefTZGVU9L4veUeFLd0GsivyY+PyrOpSxybvtb9IhZvi61WJ1
 9J7AZzjhlAKS4zxiyMCMpN6VYty/3txEpy8sEMGtCYbgAA/yWoG5jTeQWdQMcJMb7xVi
 9i1655GxeI1JyNU/y+NTEhSnQLIisDyKDjkFGOePNtja3hEx1ieY7ydPQ7ouvrcieJOQ
 cnl/UgC4ZNR4QjH4ZTV63js8SMcG3AiSkn71zwhtdTdaSXG0rITCzm73vmTnznTnzfac
 knyQ==
X-Gm-Message-State: AOJu0Yxm8Cf0F+gK78ea8QcWWLhoJGJv07qLEbnx5Kp/I531po7YPodp
 OEUXUHky67evZsog/i0Jr9A=
X-Google-Smtp-Source: AGHT+IGWDabcILZvppndibIT+VlcAXisSRXRTOoY9Ub291eXsQSLS1cJV/CaQEshHMvzRuA7gSjyGg==
X-Received: by 2002:a05:600c:1f94:b0:406:7232:1431 with SMTP id
 je20-20020a05600c1f9400b0040672321431mr2033254wmb.33.1698402754916; 
 Fri, 27 Oct 2023 03:32:34 -0700 (PDT)
Received: from [192.168.10.177] (54-240-197-227.amazon.com. [54.240.197.227])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a05600c4fce00b0040775501256sm1300940wmq.16.2023.10.27.03.32.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 03:32:34 -0700 (PDT)
Message-ID: <c538ea45-dac7-49f3-ad50-8c3a59755dee@gmail.com>
Date: Fri, 27 Oct 2023 11:32:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/28] hw/xen: automatically assign device index to
 block devices
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, paul@xen.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
References: <20231025145042.627381-1-dwmw2@infradead.org>
 <20231025145042.627381-14-dwmw2@infradead.org>
 <74e54da5-9c35-485d-a13c-efac3f81dec2@gmail.com>
 <f72e2e7feed3ecf17af8ab8442c359eea329ef17.camel@infradead.org>
 <9fb67e52-f262-4cf4-91c2-a42411ba21c4@gmail.com>
 <b6458e730fd861243f534e33a48a857122e77ed5.camel@infradead.org>
From: "Durrant, Paul" <xadimgnik@gmail.com>
In-Reply-To: <b6458e730fd861243f534e33a48a857122e77ed5.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 27/10/2023 11:25, David Woodhouse wrote:
> On Fri, 2023-10-27 at 10:01 +0100, Durrant, Paul wrote:
>>
>> This code is allocating a name automatically so I think the onus is on
>> it not create a needless clash which is likely to have unpredictable
>> results depending on what the guest is. Just avoid any aliasing in the
>> first place and things will be fine.
> 
> 
> Yeah, fair enough. In which case I'll probably switch to using
> xs_directory() and then processing those results to find a free slot,
> instead of going out to XenStore for every existence check.
> 
> This isn't exactly fast path and I'm prepared to tolerate a little bit
> of O(n²), but only within reason :)

Yes, doing an xs_directory() and then using the code 
xen_block_get_vdev() to populate a list of existent disks will be neater.


