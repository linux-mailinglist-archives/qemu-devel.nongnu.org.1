Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 312427E9CB2
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 14:03:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Waz-0002D0-Aa; Mon, 13 Nov 2023 08:03:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hoo.linux@gmail.com>)
 id 1r2Wax-0002Az-0h
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 08:03:15 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.hoo.linux@gmail.com>)
 id 1r2Wav-0007IG-6L
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 08:03:14 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cc5916d578so38390395ad.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 05:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699880591; x=1700485391; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QkdreoDyLw+6lBZYPgsGNR1ljfVy3eOmzVipN41KzmE=;
 b=PXdkJybijilkchyj0SYj3D0zuqXmJJwkgTke1OwaPCK17fmJfFIOXU5emqn55SAC52
 vPUDkQEUeGaTKHz2Kh4P73LLFF82WHZkYpRlQVAUOjCv6kTVJEdPPnou+GWD7y9eAeXj
 /fOvLwJrezuzFGZur1EGez2FL7PXlvdKRIs3AcAUwj6PBDJn3c0f2elSgsXPePxwV813
 cCqRzWT2FEHbJtS/SdzkvRDw7Qmkppz0JpPR9597xknGwOasmVwBnRuiYk/DXezQ8dRD
 VCW2GAIK5yYSC3zFfB6RhaQL/yiPCVbk262RpStuLA8qyOWgdiHCq9Vkcxsq7xOvpL82
 Vkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699880591; x=1700485391;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QkdreoDyLw+6lBZYPgsGNR1ljfVy3eOmzVipN41KzmE=;
 b=utmGFcZFcL2rvl5HO9NbTdELeWbInWb3Wl3za2imKA10yT3db7YTDI4xHkn0ZlUeb5
 7oTgJx/b7CqbcFJie6jaMGqgBNZpqvyWYjZF3yLFOvHj3Nxy8UR+jYtoh831n6vR2u4Z
 uDgHut1qRzVJdLWQtnIyOsRvENYrap1K1tTSlsyMuxvMZG59JrcZQ8cO4JaUYXFnhfO4
 +aAT/Y2UAOawWIPmh4hLn2ntIqPB3yFr6LZOWWGMYCZGCBs/bHCGsg7L+pPZNbISYf4W
 Gcw3zn6ebFpwMHzgJMFX80yKOSkSSDwJOUtffu/tCS17rXTl3vRUg4WkmqYWch+i60RI
 L/1w==
X-Gm-Message-State: AOJu0YwOG/FqZBNylNJ9jsPckvURLr6zjYNVK2ryyNcrR84zsZQAr7Nz
 IcmLGtisS5HQ9EtC6Iex/znrRI4IcvY=
X-Google-Smtp-Source: AGHT+IHVoDCZfkZ+DhCQ4oW39HWuVpvrg5Y1FyQpsRBZE/RxNrIvbVg0yNyTmb3QrZ6urSQRI8dRzg==
X-Received: by 2002:a17:902:e5ca:b0:1cc:4eb0:64cf with SMTP id
 u10-20020a170902e5ca00b001cc4eb064cfmr7692228plf.52.1699880591069; 
 Mon, 13 Nov 2023 05:03:11 -0800 (PST)
Received: from [172.27.236.153]
 (ec2-16-163-40-128.ap-east-1.compute.amazonaws.com. [16.163.40.128])
 by smtp.gmail.com with ESMTPSA id
 b20-20020a170902b61400b001c582de968dsm3971898pls.72.2023.11.13.05.03.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 05:03:10 -0800 (PST)
Message-ID: <8cff6965-5f45-76d0-1b56-4f9a53474ec7@gmail.com>
Date: Mon, 13 Nov 2023 21:03:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] msix: unset PCIDevice::msix_vector_poll_notifier in
 rollback
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20231113081349.1307-1-robert.hoo.linux@gmail.com>
 <53512cf6-b595-4cff-a1f2-6f1dd2c6621a@linaro.org>
From: Robert Hoo <robert.hoo.linux@gmail.com>
In-Reply-To: <53512cf6-b595-4cff-a1f2-6f1dd2c6621a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=robert.hoo.linux@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-3.971, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11/13/2023 6:05 PM, Philippe Mathieu-Daudé wrote:
> Hi Robert,
> 
> On 13/11/23 09:13, Robert Hoo wrote:
>> In the rollback in msix_set_vector_notifiers(), original patch forgot to
>> undo msix_vector_poll_notifier pointer.
> 
> Out of curiosity, nobody complained during 11 years, so in which
> use case did you notice this?
> 

Hi Philippe,

I stumbled upon this when looking into another issue.

I think, thanks to the caller's very standardized use, the omission has never 
been exposed.


