Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C0E7F96C4
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 01:21:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7PMT-0004E8-LM; Sun, 26 Nov 2023 19:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7PMJ-0004DZ-8D
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:20:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7PMH-0008Fe-Q8
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701044417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wxMh/sdy5y9/QnCn8h9Cb7wT7P5pIJUK2yIt1wYKoX4=;
 b=L7AbIkLmxS8xauI+UpWfhakhFxVjbblxfOrCtcta9HCgK6g8wmtxoiDV4wlrlHsQR9d34E
 bDgWL1ZF0yYa2YAhHrH7EdktiuRwI+uOkEmGyixBe0dJKgrwEbbNg4B1TKQrbzSUokMHI9
 RQKnleCxXx97M6Hrs30nk8DcpNh++JA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-ZaDccwL6Oo-hDrpaYrDPhg-1; Sun, 26 Nov 2023 19:20:15 -0500
X-MC-Unique: ZaDccwL6Oo-hDrpaYrDPhg-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6cc021f658bso1728838b3a.1
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 16:20:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701044414; x=1701649214;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wxMh/sdy5y9/QnCn8h9Cb7wT7P5pIJUK2yIt1wYKoX4=;
 b=lLuRuTxsZSGjiFaFm+7vlRaV6Hf4QFMTZaRXDlqxoE5NBCDqywnCD7ahaZ7JYwW+Aj
 WxcMHsLwTzu4jEd+tOHo9VyYhwl4znVU7R2r0yXiP91olqhpjLxR8h6FuO2GspgH6nVq
 G5F2CvSiMv9GknLPGPbCnmOsEpQHV7sOTRAsctepFeUtgmZrFnyuITOaCvxrbQSWkCE9
 p7ptmOyq4wub8g7jEju2ieUpWSHZGbOBrOS8b2QV35svZdeP15Yh7UShdT/hF3LmkIIA
 OJ7v1CKqSjNc6kZypUl3P01vPB8B631pFSayf3TwBdPPw6YthnIgs5pgmM9kA12nvMNY
 cnDQ==
X-Gm-Message-State: AOJu0YxweHchMBmg3iOHAarBeKrChVZ7FbFX/w1ap/8tyzw9KWQP2xv2
 jrjdbz/Cq+EKa9A13D/qVTvKLnm0ilkGHrg+wc9s62N40687XHZ+jrR+48b93k20jyPkbB0Lk4i
 WYxXZsz3AS0mCHYE=
X-Received: by 2002:a05:6a00:244c:b0:6b7:18c1:c09a with SMTP id
 d12-20020a056a00244c00b006b718c1c09amr8825789pfj.5.1701044414227; 
 Sun, 26 Nov 2023 16:20:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGW7Uu/iPKW85gUw9MpGXL/cdc6m+imw7Cgf6EnvTjr0s0yavqbLNkcRI3o03skF7hUnNISuQ==
X-Received: by 2002:a05:6a00:244c:b0:6b7:18c1:c09a with SMTP id
 d12-20020a056a00244c00b006b718c1c09amr8825775pfj.5.1701044413964; 
 Sun, 26 Nov 2023 16:20:13 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 b14-20020aa7870e000000b006cbfbb3635bsm3943379pfo.161.2023.11.26.16.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 16:20:13 -0800 (PST)
Message-ID: <4bf7a242-49b1-4a27-aa68-99a811ae784c@redhat.com>
Date: Mon, 27 Nov 2023 11:20:10 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/21] target/arm/kvm: Unexport kvm_arm_init_cpreg_list
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-18-richard.henderson@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123044219.896776-18-richard.henderson@linaro.org>
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
>   target/arm/kvm_arm.h | 12 ------------
>   target/arm/kvm.c     | 10 ++++++++--
>   2 files changed, 8 insertions(+), 14 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


