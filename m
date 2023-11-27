Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1897E7F96D7
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 01:30:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7PVj-000823-Pl; Sun, 26 Nov 2023 19:30:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7PVS-0007m5-M6
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:29:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7PVR-0001Kv-6V
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701044983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MgRhQFyR9B0t9NkPJobP/zNe3X4Ln4TBq2Kx0B8Es7g=;
 b=atVgsGmmKqYX6xYkxkDjUzT3N7Mn18P4RgeGLzgspB6OTGHfiYoajNu85m8SydT3+jx0Au
 kpZrr71fPUxQ86GvUVn9SM89merBVsTr26pG43I/9P3DWcxlAYkdYXO9EJj0o0dKO86CC0
 LdDEiek8Mdmt23KC2b8wbp7E+BssO5o=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-8nCqBaGWOUa8IIt1D6GDEw-1; Sun, 26 Nov 2023 19:29:41 -0500
X-MC-Unique: 8nCqBaGWOUa8IIt1D6GDEw-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1cfcf1e9442so4848195ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 16:29:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701044980; x=1701649780;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MgRhQFyR9B0t9NkPJobP/zNe3X4Ln4TBq2Kx0B8Es7g=;
 b=qKUGYJnTTIU74mZY7NrOeYYlW2+p+RHQj5x3x608VzK7/F1NeZ0Cq47kcpb/4FzPpA
 2VfwitKvzHtcFSf01Grap4MNMzfvc2OCH5zJH0Zo3I5wYW9bZH7G6H0z34s2DOCwfFsC
 F7qBkhWNQtZa3s68wF2QP0b20QMNU8S4i0rcVDMhqwNEBF6gh85gfHY/L33QSgAJOfyu
 aesgee2XADlnz7bpbr2aZst2wvqf+JmXIe3JM0meJuJW91+ybg1gBsMYypLxNOpT0Jp5
 BZmODrcqvNBOO1RB6RHpP4IX2Zmi2FRbyN6IUgJ8fwlc7TdZlDLEqZXg/a0QdwFc/9AP
 nFPw==
X-Gm-Message-State: AOJu0YziVODpyMjfqFKVt+fPV6RKs/4MlvwffqfztsV2er+Z0G+xPMzF
 s6vRm7RAoJDCzIWbN8TVjLS408wi9qiGGkMKXAeBpbaZu/UsKVQu2Kq9iIqnczxJ/gHYX7x32wK
 d1CbYCDrG2K5Kgxw=
X-Received: by 2002:a17:902:bc85:b0:1cf:6f1a:33be with SMTP id
 bb5-20020a170902bc8500b001cf6f1a33bemr11259712plb.51.1701044980705; 
 Sun, 26 Nov 2023 16:29:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGftttaL9hvwCTQSgrHurr/7LhyZHZ8QoFXwpwXnoaPgir0fx3SCzBnrIHDfzRNHCWJa5QF4g==
X-Received: by 2002:a17:902:bc85:b0:1cf:6f1a:33be with SMTP id
 bb5-20020a170902bc8500b001cf6f1a33bemr11259698plb.51.1701044980339; 
 Sun, 26 Nov 2023 16:29:40 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 2-20020a170902c14200b001c755810f89sm6915410plj.181.2023.11.26.16.29.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 16:29:40 -0800 (PST)
Message-ID: <91f4dc0f-2cf4-4a1d-b36f-2fe1cfeb8dbc@redhat.com>
Date: Mon, 27 Nov 2023 11:29:38 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/21] target/arm/kvm: Unexport kvm_arm_vm_state_change
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-22-richard.henderson@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123044219.896776-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
>   target/arm/kvm_arm.h | 2 --
>   target/arm/kvm.c     | 2 +-
>   2 files changed, 1 insertion(+), 3 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


