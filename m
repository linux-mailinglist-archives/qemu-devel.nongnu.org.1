Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D082B7F96BA
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 01:09:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7PAd-0007zc-17; Sun, 26 Nov 2023 19:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7PAZ-0007yQ-4z
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:08:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7PAV-000664-Vf
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701043687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=76I+5cwv/DofG0W4/FDlxwbCQEIVFc0V//udwOa7evs=;
 b=XK5Zmo1UdVmoqhOd7OwBP3qYtl1xmqaA6V6z/+K4wh2HRy26TA3iQc9BriD0B2YBR76KPK
 SV/ooKyAGjg01FBpb56HokCgw9UGxUyqF2IBvwbDvePP36zJXy8B4E768DOaO4wfnwGqpW
 mR+2d9T+F9kCCg2UFVtnuUobS5RacME=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-r-UNkDZJN1aohhHFVeiJsA-1; Sun, 26 Nov 2023 19:08:05 -0500
X-MC-Unique: r-UNkDZJN1aohhHFVeiJsA-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6d6480cf2a4so4172514a34.0
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 16:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701043685; x=1701648485;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=76I+5cwv/DofG0W4/FDlxwbCQEIVFc0V//udwOa7evs=;
 b=MeB7WI06vufm26c/UsGYcXPCmt/u8XSiGnl7MmxGLV4xEagbYDuMA5lVAJUo7MJhyy
 GEek1c8yrRdKqTH5b1A804OWz05+9EK+x/XbZXU3aZou76hjSo6v4ykuV1mpiPhJhsNk
 gBarv0PiS9llCUaO8KM1XOyTHz7hfqmJMtoOp+96qDqGVNNYYdMZEFfQqcVKg5SMuD9I
 hd9ns9eZjGteqBqiemQ04as99vkAp+tkAa1ips3VO4+o8e05MzTKtROyRtS+Py2Upyzs
 bcr43cuEHGm0qvDCbfp5w91/sC8TaZvi2wS6a/hPpUzdZy4oRnCxkrtMjiJt1uDYq6Rj
 z7ew==
X-Gm-Message-State: AOJu0YzpB+g0/jEPJe87iYQOlIW1VwNvT40f9uFNpUrTT1q3Xd4kSROT
 XnzeguKIpc7xP2lvxs+g7aO8EUl+avHkVUyu2olGJtngB+ETHb/VZbvslOwAm6sxFkJBsO7U+vJ
 /2xqoJ8wAlRcAtYI=
X-Received: by 2002:a05:6830:1319:b0:6d8:1e67:d756 with SMTP id
 p25-20020a056830131900b006d81e67d756mr3620057otq.21.1701043684999; 
 Sun, 26 Nov 2023 16:08:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbX7FgBBw6wzF1vt8kjcSvCWt1SMiNPYCQHU15ZikNS75336Gaxd49rsGTzCRo13bJSa/g6A==
X-Received: by 2002:a05:6830:1319:b0:6d8:1e67:d756 with SMTP id
 p25-20020a056830131900b006d81e67d756mr3620044otq.21.1701043684805; 
 Sun, 26 Nov 2023 16:08:04 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a632d03000000b005897bfc2ed3sm6390025pgt.93.2023.11.26.16.08.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 16:08:04 -0800 (PST)
Message-ID: <9f613dd3-d0aa-492c-b0ee-7da9173fe132@redhat.com>
Date: Mon, 27 Nov 2023 11:08:02 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/21] target/arm/kvm: Move kvm_arm_cpreg_level and
 unexport
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-13-richard.henderson@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123044219.896776-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/23/23 15:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h |  9 ---------
>   target/arm/kvm.c     | 22 ++++++++++++++++++++++
>   target/arm/kvm64.c   | 15 ---------------
>   3 files changed, 22 insertions(+), 24 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


