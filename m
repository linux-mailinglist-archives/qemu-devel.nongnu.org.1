Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 416E17F96B4
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 01:02:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7P4j-0004Vv-4c; Sun, 26 Nov 2023 19:02:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7P4h-0004VV-6N
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:02:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7P4f-0005QT-Nw
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:02:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701043325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7CLodloYwHa6YsUToJZ+tqR2jbA2IBsvL3NuDje0Q0A=;
 b=EWoVefibVOB/mYtQzf3khcgyjUj+bBcyEGjG8GtAWM1uZUgdvgFM/uBizkv7xQrgbMXsY/
 UXIcq1ZtVrCJq5fgLLwa2mX7/TzGzamRlssB+rNJB5Tnuf2g+XP6dvskemWXrtpPUq/x5M
 YwLNDraZGVC/G9+L1EoAyJo6B9f9HoA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-aC0dnfNuOjCbEJ0yvJJmqg-1; Sun, 26 Nov 2023 19:02:02 -0500
X-MC-Unique: aC0dnfNuOjCbEJ0yvJJmqg-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6cbcd3e9758so4241972b3a.2
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 16:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701043321; x=1701648121;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7CLodloYwHa6YsUToJZ+tqR2jbA2IBsvL3NuDje0Q0A=;
 b=sbfN+9U/Qiz7SzNXnFsxDc/uqwoh7pfbEx6xAlrDYr91xUQNZUnpEgjI3Dt58JnQE2
 dRUwuuMPTQJSPS+0mAtwCoGEX1jRDnpp1C7DnZBuHPs7YgiA3UemoPG3SUxKjFtsN90H
 LtcVnsKrmQYVVp/21QWonUMHd5oflyxthvic0H+KYLIupG9AoyShWgdsL+gt+6tUS3ZK
 bBK1BAbQpxhy1JPRX+5RnSvE8HnqKLY+jWjEja8svUdax8ZHauwuhuZUBoq7atf71gUp
 eISrIn8qtxNUeR2BlQugp8HEn3HXc5eDTqSFzplkle3Q45ru+iBDoYwfLtRq0T5mbUUX
 TIKw==
X-Gm-Message-State: AOJu0YwdyqCncpa++xLRTBRVxTx4q6T2inirzYSlMQkUEvOUmpfInU8i
 iU+YcU+Uvp03AoL+2zEtOhT6Agks4LTtc06nuEeoxzwxerLUMCqq9+bau476MB810fKdOVjjJnW
 Q5fHClJ0lZD38D5c=
X-Received: by 2002:a05:6a20:3caa:b0:189:ca96:aa1b with SMTP id
 b42-20020a056a203caa00b00189ca96aa1bmr10725527pzj.53.1701043321602; 
 Sun, 26 Nov 2023 16:02:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1kRtqpV6GCk9tGDC/oFbGkqjiT/yEBxzWFW5NHS6duxmuEBQTvBQsZih/AnauNnKCL5zUTg==
X-Received: by 2002:a05:6a20:3caa:b0:189:ca96:aa1b with SMTP id
 b42-20020a056a203caa00b00189ca96aa1bmr10725501pzj.53.1701043321256; 
 Sun, 26 Nov 2023 16:02:01 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 e3-20020a170902744300b001cf5d324817sm5355651plt.188.2023.11.26.16.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 16:02:00 -0800 (PST)
Message-ID: <37ee28b5-c634-4d35-a46b-73fd128b6083@redhat.com>
Date: Mon, 27 Nov 2023 11:01:57 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] target/arm/kvm: Move kvm_arm_get_host_cpu_features
 and unexport
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-11-richard.henderson@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123044219.896776-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
>   target/arm/kvm_arm.h |  22 ----
>   target/arm/kvm.c     | 265 +++++++++++++++++++++++++++++++++++++++++++
>   target/arm/kvm64.c   | 254 -----------------------------------------
>   3 files changed, 265 insertions(+), 276 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


