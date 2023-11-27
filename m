Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B417F96D1
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 01:29:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7PUe-00075t-R9; Sun, 26 Nov 2023 19:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7PUb-000753-DH
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:28:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7PUY-0001G7-Ua
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701044928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dgmdDmB1jso0M7OXy8breYAnCXyxma8tD9eD3m8W6G4=;
 b=eA5wX2V4mj0g+h0ySkXYXgeeeXkPXfLBsJEs58IKY2Cy6S2bMMY42g+ZVcu+J63JXoHRiy
 T7g64we4ffKquLRA72NzCpYbGbFMoChMbOzs3DJbRu753tK2/MBEP3/W6krrXFa+MA5WES
 SkJoSYOGlBcSW4/R8040dCTuCr1IuQc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-dxs3wO5_NNW0phcDDgXobQ-1; Sun, 26 Nov 2023 19:28:46 -0500
X-MC-Unique: dxs3wO5_NNW0phcDDgXobQ-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1cc41aed6a5so41016985ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 16:28:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701044925; x=1701649725;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dgmdDmB1jso0M7OXy8breYAnCXyxma8tD9eD3m8W6G4=;
 b=TI8ctkLxfFhvhkPEMVeSj/kZEIa2it7uD/U3Yr/YR7p2eajrD/aWWAfbVgZZ4GGutV
 runulzdx0+j7OdU3H424NKLb8KFPeyQMGPMTPYNQZa/jsDZ1CYE/ZZHWcIRmB45jNWRJ
 2ac4d4ACUhv2fw6DvUJggyeaUyBfD3lkB1bJgiEHyqs3FAzeTckEhApGeERnoPOll2aD
 hETiRp5CGXEVW/DmLqCQ0hRuBlVi9IEDzWFMDUaEWPPo8HZ9jnsP2lOESHCv0VFEwJIm
 OBwt3viPx5OaKgpxxP2ffvKkT0oZoi2RCeYgTlfs7UeGWdVji1Sanj9VsjX7p47VwzqH
 /R4Q==
X-Gm-Message-State: AOJu0YzlgIHkG4dwGxQLLaaELE/Q+4CYL6b1S+I2KnhKuFP7Mk8T2b/G
 /dFSztAaGv7Q5oa8mEzwHxTx3fHOxhhf4tQE8ZawT1n3brOs/72rbPBt24tu7PrT0sx9Qvo/sxK
 FzKrYEAz+U+iIPWc=
X-Received: by 2002:a17:902:e88a:b0:1cf:cf34:d4df with SMTP id
 w10-20020a170902e88a00b001cfcf34d4dfmr1467255plg.22.1701044925572; 
 Sun, 26 Nov 2023 16:28:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuQOUGK/7eVw3Bjzt5oUCs9EcFhpsB7y+Blr/n+HJ7LuGk8LtHJv42+mIeYsHO4eekUkMNxA==
X-Received: by 2002:a17:902:e88a:b0:1cf:cf34:d4df with SMTP id
 w10-20020a170902e88a00b001cfcf34d4dfmr1467242plg.22.1701044925222; 
 Sun, 26 Nov 2023 16:28:45 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 2-20020a170902c14200b001c755810f89sm6915410plj.181.2023.11.26.16.28.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 16:28:44 -0800 (PST)
Message-ID: <21f01b4f-9a4d-4995-bd38-a8fbeeffcc59@redhat.com>
Date: Mon, 27 Nov 2023 11:28:41 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/21] target/arm/kvm: Unexport and tidy
 kvm_arm_sync_mpstate_to_{kvm, qemu}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-21-richard.henderson@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123044219.896776-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/23/23 15:42, Richard Henderson wrote:
> Drop fprintfs and actually use the return values in the callers.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h | 20 --------------------
>   target/arm/kvm.c     | 23 ++++++-----------------
>   2 files changed, 6 insertions(+), 37 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


