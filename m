Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 904E480E365
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 05:40:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCuXn-0003zY-CI; Mon, 11 Dec 2023 23:38:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1rCuXm-0003zP-3a
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 23:38:54 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1rCuXk-0000CJ-Gl
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 23:38:53 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6d089bc4e1aso1345324b3a.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 20:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702355931; x=1702960731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k0BkpYo4LiWPnAd4aId4Wk27+tXLAp0PwmjpZLLLEdU=;
 b=GxYmedFQj1k6GJeYYBJChfwiz/OE6MMoIRlmMsuU2zYG/vkrmvOcOmQ9YTLkNb8Aby
 mzZDAXxFsFWqQ5QRT9ziHQjoJndjeAv6eV2M1lj13lBuCNoISOTaPj6j7nw0/oHFjkpa
 eoKPAJ4Q7m8xUU5ZfFQcf0nWqTVEtTXh5rbpbjxbLiXaH7dPc8MXU3twLFnA9k91WMaG
 boggezv4y96IfJD0gfYgS50gY/i178TnWt1sZjhiOMBHpXFZIP+HgQzefcJ9aEwHB/Ke
 5cKA2x4unoRttsqJpR9mFmQEuquThK1Y02w8muIsnAORxWVZDQ9OWyabOMjwWRh8qwf7
 2H1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702355931; x=1702960731;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k0BkpYo4LiWPnAd4aId4Wk27+tXLAp0PwmjpZLLLEdU=;
 b=az8oxxBKFtzvhvY+PabsY3vF5/jf7qZiXgqc1o/27NMpMglume9bkhb9SYKonqHDlG
 Fnuw2eP0xb8HCC7jf6+fIIZnHHyqlU0xMGKJoKOYfve0aEd66WS9Jn1Y/p2auIBPomnH
 82k8ft+bfAW91cjZGsj7o3jmAXMgGPo6HuYV+OPoq/HHpvqttKdMJ9nptnAvVmdO3fVr
 tGZ9dK4kAtZfLRcqlWxXgAQIBE23Gg2k6DAbnhiR8wwRDCs+50zphE2FanRRj/AZeoCF
 /mG+nnL4KjLu03zNiCJm+NsAAk1aFI1yFbpmUDHkCh6IaCWJ5tQXJZe7JzTfCnp14CRv
 XORQ==
X-Gm-Message-State: AOJu0Yw3SfiqccuRkXqJ+X4uWpSNYcGJQzSNXee6mnHrlgNpTLxqimxz
 BnALERexBrtQ4YIfkMdLijA=
X-Google-Smtp-Source: AGHT+IGzaWrRtTYY2kPiwWnCygOykl553sRVt/7vCC0lOVUiuysAkvPa4xKzKg2KOs0m2k1dWfWh+g==
X-Received: by 2002:a05:6a20:6a08:b0:18b:826d:1e89 with SMTP id
 p8-20020a056a206a0800b0018b826d1e89mr6584231pzk.12.1702355930640; 
 Mon, 11 Dec 2023 20:38:50 -0800 (PST)
Received: from [192.168.0.22] ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 q20-20020a656854000000b005b7dd356f75sm6206291pgt.32.2023.12.11.20.38.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 20:38:49 -0800 (PST)
Message-ID: <9c2dc260-8c3a-486f-a70f-b7ee238fe097@gmail.com>
Date: Tue, 12 Dec 2023 13:38:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/ufs: Support for Zoned UFS
Content-Language: ko
To: daejun7.park@samsung.com, Jeuk Kim <jeuk20.kim@samsung.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "fam@euphon.net"
 <fam@euphon.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: JinHwan Park <jh.i.park@samsung.com>, Seokhwan Kim
 <sukka.kim@samsung.com>, Yonggil Song <yonggil.song@samsung.com>
References: <20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba@epcms2p3>
 <CGME20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba@epcms2p2>
 <20231208061330epcms2p2f742a2d517b6836eca695a9b59bd109c@epcms2p2>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20231208061330epcms2p2f742a2d517b6836eca695a9b59bd109c@epcms2p2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 12/8/2023 3:13 PM, Daejun Park wrote:
> This patch enables zoned ufs support.
>
> By setting the LU parameter, each LU can be a host-managed zoned device.
> This patch manages the zone condition and write pointer of each zone for
> a zoned LU. It supports the report zones and reset write pointer commands
> for Zoned LUs.
>
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>

Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>



