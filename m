Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6187E7F980C
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 04:56:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7Si2-0007B7-Sd; Sun, 26 Nov 2023 22:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7Si0-0007AJ-L1
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 22:54:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7Shy-0002MF-KW
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 22:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701057293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n/B2oeugV7rvsBl26QiNw/HUulmxvWDTO/1LAtO/5B4=;
 b=TQ3gl1xKKx1bFoVpKKo1sNL1alQITSBqf+e9Cs4SHmbQmFhC3CyrhMWBRC1dT1aYnsIzge
 LMwqb0+3Vx6FzBgagurwlfU7/9Flu1KYJ2NRU/TmlJaum4Eg4Jixx5YbHCQDMnyMG4pv24
 md0RAVoKMh2iU/3z64437q3CZMrtOas=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-Q-ny-G60MEuDsgNHZatHjg-1; Sun, 26 Nov 2023 22:54:49 -0500
X-MC-Unique: Q-ny-G60MEuDsgNHZatHjg-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1cc41aed6a5so42511705ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 19:54:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701057288; x=1701662088;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n/B2oeugV7rvsBl26QiNw/HUulmxvWDTO/1LAtO/5B4=;
 b=wfT/kCz+alIN15qmfdQZG92DuirZhSTliP+VAfMNn/AlFbtB/n0z2xCqS3XbMAZrID
 dqhVmnWvV7uC08qISWIi03Re4oWktbluRKijYFwGqb+oo/JNcm1WcnXxWlVe5VECOWnV
 Tg/lnHpUedvu31Hc5bJRVGeigd8fCWacVUyn7GRsy0iNFHydRaDRYljA+U+VUgXWJGOU
 RnGyFKawHQjorIkTamukIPbqZBfK3McDPRfBqEb5rjJ7A3GfY40hI6jw9iSpdDTOs9nj
 Zh+zzGFP+bKnEiTLSZmX4hoXLjBbR5HnYWB4bOGPNuSpstagB6cSPotuoseFWjpxif99
 Nb9g==
X-Gm-Message-State: AOJu0Yyzswc+BnyhKN6iC8P6UZiYFKiR/NZUPwhQ57y2pjCKLIlDCALQ
 s4w6f2Pi9yTWh2cnprdDoTBze3ArcdrTMTnN8YoljsOj9sRURclyl3el4C6sVyGWTX8EReN+NIA
 1msA5v/hvSyjpPcw=
X-Received: by 2002:a17:902:6946:b0:1cc:4fbe:9278 with SMTP id
 k6-20020a170902694600b001cc4fbe9278mr8703244plt.50.1701057288533; 
 Sun, 26 Nov 2023 19:54:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbVGuXlFhscebc296SQxZkjGJOTVtO8/tW/4/UC9LRQVEKcwKp2SqH21GWO8ErPdmfwEPtiA==
X-Received: by 2002:a17:902:6946:b0:1cc:4fbe:9278 with SMTP id
 k6-20020a170902694600b001cc4fbe9278mr8703235plt.50.1701057288243; 
 Sun, 26 Nov 2023 19:54:48 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 r4-20020a170902be0400b001bb99e188fcsm7129948pls.194.2023.11.26.19.54.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 19:54:47 -0800 (PST)
Message-ID: <f8e7ff04-dfb5-4bdb-8bce-ce34b9539c7d@redhat.com>
Date: Mon, 27 Nov 2023 14:54:42 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 01/16] hw/intc/arm_gicv3: Include missing
 'qemu/error-report.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231123183518.64569-1-philmd@linaro.org>
 <20231123183518.64569-2-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123183518.64569-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 11/24/23 05:35, Philippe Mathieu-Daudé wrote:
> kvm_arm_its_reset_hold() calls warn_report(), itself declared
> in "qemu/error-report.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/intc/arm_gicv3_its_kvm.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


