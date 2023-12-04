Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C326A802AA6
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 04:57:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA03S-00055l-Ke; Sun, 03 Dec 2023 22:55:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA03F-00054q-1q
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 22:55:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA039-0003iB-T0
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 22:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701662115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D5lLOORfRcCNxVRCcAK4ye/0pShLDh//TEXCyUwt7Ho=;
 b=WFHRbC+JeE6txdZ3IIjnHw7wwxEgMrBULYTTFF4GvF7h4iuHDVAHMb1Zszru+OTUiD4h1b
 dd1nr80O+ADqGT46s7rJqGCUgqo0W2bUpvyDNbWoFi92Hysuc8gjftk3CSbA9QYfJi7EC4
 5rJ126WEbEPi5zJqDsOLACOx5ewE2tg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-Oqtgo7S_PQ-p7xHOtH6CnQ-1; Sun, 03 Dec 2023 22:55:13 -0500
X-MC-Unique: Oqtgo7S_PQ-p7xHOtH6CnQ-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1d03cf821e3so13367735ad.3
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 19:55:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701662112; x=1702266912;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D5lLOORfRcCNxVRCcAK4ye/0pShLDh//TEXCyUwt7Ho=;
 b=m+q1XNcLY2BiYDuzmzwkt92gz3OSaPqyixu67yUR1sOFZhRSXKMmtV1yNs5jTi6+Rp
 hMMdXIEji+qGs6pE8Muy9OhZPop1maYSUVsJS/kCB7XJ8FKKW5tOads9Y3xU33++L4QH
 V/nXP9BXazZ+TjV/LrfO0Vj5KkcmeYibyxV3fzGFEEndmq2FyF6CNUKTYvYkdidUUAMf
 rM87IoPNeZ0b8pH2rxUc4q8s42VFdeXmbZiVy3K1gzvWtC/xAlpNO1kSbXYJ4zVsSgpN
 Wh4k2dzy3pPQRQrKSTWMwQ5/DyYdFU3Lvzm3wSdqMJPq8EwpkaSKakj9pNJdjlmtQ9Xo
 m+cg==
X-Gm-Message-State: AOJu0YyCV1zkNEM06tBeBugoy7N9J5TOqWR2pE5VHRMloh52I5pMhOmU
 bGImDL5WxDEhp2sMcBI+r/fOMtiIR3gj6zzcHx8I7wAAq2a14j8PLgy8xgWaxVpj49/jB5jyHhk
 VPIpJCmBiOyNnrDw=
X-Received: by 2002:a17:902:a50e:b0:1d0:6ffd:6e60 with SMTP id
 s14-20020a170902a50e00b001d06ffd6e60mr997570plq.88.1701662112545; 
 Sun, 03 Dec 2023 19:55:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGl0xpifpIDP0JZxNBTa0wVIODcQ6AaZvqFQddOTQ80Unt2jlibel8DU7jAMPosKF+HmOaaDQ==
X-Received: by 2002:a17:902:a50e:b0:1d0:6ffd:6e60 with SMTP id
 s14-20020a170902a50e00b001d06ffd6e60mr997561plq.88.1701662112105; 
 Sun, 03 Dec 2023 19:55:12 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a170902ea1000b001d0855ce7c8sm2105952plg.252.2023.12.03.19.55.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 19:55:11 -0800 (PST)
Message-ID: <d4e5fc82-48b9-4e20-b395-d8ebb9391e1c@redhat.com>
Date: Mon, 4 Dec 2023 13:55:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 1/2] accel/kvm: Expose kvm_supports_guest_debug()
 prototype
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
References: <20231201143201.40182-1-philmd@linaro.org>
 <20231201143201.40182-2-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231201143201.40182-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 12/2/23 00:32, Philippe Mathieu-Daudé wrote:
> kvm_supports_guest_debug() should be accessible by KVM
> implementations.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/kvm/kvm-cpus.h | 1 -
>   include/sysemu/kvm.h | 1 +
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


