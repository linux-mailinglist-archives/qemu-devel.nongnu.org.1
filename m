Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A747F969A
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 00:43:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7Om8-0006LM-V1; Sun, 26 Nov 2023 18:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7Om7-0006Kq-25
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 18:42:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7Om5-0002Kd-Dd
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 18:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701042172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HVFAy9VNZXC2aV4IMzP9Qwquvw3/aKmGLC+APvriCn8=;
 b=Jj8MKjGQ2W9JpH0SVASw5srxFP20mzclexhN7ZBWJ4Kb8Jq3nDDOAa5XO+Pi0I5hikBOpN
 RB1d1vYeJW/IpgBl3oLSt27anWJpV6VT+51zh7rXyIzsL7S/PGpjgzEHeZ1NkTwnQoQbB7
 ees9LZAGq+jcSOsHoWPfwwvgK3GO38k=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-QbfgAtAJN-azLXO5eYYZHw-1; Sun, 26 Nov 2023 18:42:50 -0500
X-MC-Unique: QbfgAtAJN-azLXO5eYYZHw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-285a1155076so2265823a91.1
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 15:42:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701042168; x=1701646968;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HVFAy9VNZXC2aV4IMzP9Qwquvw3/aKmGLC+APvriCn8=;
 b=Wg16v5Fwvf2gllBnvE51qegnkJkFoZttGeK5LmORBrTngi1pu3eGzC/VO9RenzPqrN
 PStg0cg86LEjgJbiSzGRoG6CNub034MbnUXq0IN7laYA2C+fro3av+EHzfILE4h/2KAN
 6w7GatxiYVSDy4+HB1A6lV2jShIWH+1FcGmQ4HEQC9j77i7z+1ex8i5b+hCuxUFpl1UN
 sNtsYuI7ARnlDpFYishTMnyLO01b/7IXRp3Mkwub+hY4OoAhBzs1WQYsQnzDLqa47edP
 PUj37YuZTnY0LmCiQV0XRQHzw+ZlnJwg4FxQfe7nuLrkH6zycDDfpewG7Ovr+B/bqrx8
 pdKQ==
X-Gm-Message-State: AOJu0YyxfU/KKeTOMQPnIoMZ1+QA6sa9rvBjlKoh4JgqneF2vOQFX5Cl
 6RG2Nt4pdfnqAlWGNDc9W3iymka00OLcBTSMcrp37yzcK+zfQhm3aZ7Tya+l78eYxhG2hCXl3KC
 k/uTTmghrD8xyRmQ=
X-Received: by 2002:a17:902:db0d:b0:1cf:cb80:3f75 with SMTP id
 m13-20020a170902db0d00b001cfcb803f75mr1744905plx.69.1701042168635; 
 Sun, 26 Nov 2023 15:42:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJZG/8RyuZXXKDs0r8cfQp9ad6oj5rcyxNP6OC9eOVe5arCjNB4GspJuiafKnG1/2ZzeS1ww==
X-Received: by 2002:a17:902:db0d:b0:1cf:cb80:3f75 with SMTP id
 m13-20020a170902db0d00b001cfcb803f75mr1744894plx.69.1701042168374; 
 Sun, 26 Nov 2023 15:42:48 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 ij30-20020a170902ab5e00b001cf68c0db08sm7073596plb.49.2023.11.26.15.42.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 15:42:47 -0800 (PST)
Message-ID: <82dc4be0-e515-435f-9f81-b6865bac414c@redhat.com>
Date: Mon, 27 Nov 2023 10:42:43 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/21] target/arm/kvm: Merge kvm_arm_init_debug into
 kvm_arch_init
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-4-richard.henderson@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123044219.896776-4-richard.henderson@linaro.org>
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h |  8 --------
>   target/arm/kvm.c     |  8 +++++++-
>   target/arm/kvm64.c   | 12 ------------
>   3 files changed, 7 insertions(+), 21 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


