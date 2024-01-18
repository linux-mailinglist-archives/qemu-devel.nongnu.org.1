Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E98868312F1
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:04:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQMS6-0003UH-VS; Thu, 18 Jan 2024 02:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQMRx-0003RF-Es
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 02:04:30 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQMRt-00046O-LG
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 02:04:28 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5cdbc4334edso5630927a12.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 23:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705561464; x=1706166264; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e0WRgfKWH5G+t02Fa3r0NxLK/63l63BN4MeJhltSpRU=;
 b=IC7PHvSieYQ71wP+IHd7HInkmVhMBrvQBSn8qHtbN2epbCOp60nAZhP4Q2P9zQmtv4
 rvMNt85+W41LdKDkRx/SEYBoCh+pPWEaEWoK8Q82q9ceWccnnaQWdHy5f7Qe03VdDcpr
 3Dx3wKUUcs9d8rApuzVk4ML1SXl/rKL7S4zLpuCI0Hlmrm5/OAxl4iSkYEoOO0prN5xA
 /WchaQBnCCZ6ZbNtna7Lmnsn3ZLS1Q+oPLdtXEtKRftNbxVlAAVaAtmRe/7P+fLg7Osn
 xkt8H6WMM6W+kRCv7v3XSNsEZPbfhp5CAtcsISwc8LwYz+wYF44lH3a0KqDGKVxdfqN8
 bsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705561464; x=1706166264;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e0WRgfKWH5G+t02Fa3r0NxLK/63l63BN4MeJhltSpRU=;
 b=pjqeZ7tJwI8Kc4QkZKDalG+p1nUbN3eRhfJOmykHcD216V1hxXU48BLzDM3VWgUhEb
 rkXMn/rYUrX3bRgXYFE0uuuTbpO2vkoSGvUfp3en6xuJpSTMdQHQL8kTEPqxaLUkka7Q
 l8IEbRsA351od7oxGmaiEUVPR9QA2q1/jjfIFU0HQ8qNveHRa9D2W4q57+7BuKsCTBw3
 0hYjSN9ZurJscc6FqSSScq8MdQDipBQp5OvNW/yXH4M5B/+pDKSpzy9FIYa0a83VE2jc
 1CGz5+t4kXQ1eIrxEdJfWwbeZQaj8qf3jT3k3Ddd0bciacNGmCS1SXTT0YvnMZVw/OkH
 QG9w==
X-Gm-Message-State: AOJu0YzqAWDAUYcEP3RQa4loua6+M7sCegR0VJ3+2PCx8bX0LEcs8cOW
 zwQUMYl4p2leLgDzwGzjWTtB7hKnoKTYHnoHKeqVZpcwbkmOOFBPfn5rOYULXWs=
X-Google-Smtp-Source: AGHT+IEG9mIsgueKC9I8+4V83oHBEGHUTkCGeSJPXJlH5cwVDTfLR5V9+bUl8Mimk4c0XSJzZqn6XQ==
X-Received: by 2002:a05:6a20:20c8:b0:19a:2432:e487 with SMTP id
 t8-20020a056a2020c800b0019a2432e487mr204976pza.121.1705561463868; 
 Wed, 17 Jan 2024 23:04:23 -0800 (PST)
Received: from [192.168.1.13] ([43.252.112.244])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a170902f25100b001d70e83f9c3sm110669plc.242.2024.01.17.23.04.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 23:04:23 -0800 (PST)
Message-ID: <7b88b76d-ee41-4f92-a7cc-ef395e18bf6e@linaro.org>
Date: Thu, 18 Jan 2024 18:04:19 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tcg/s390x: Fix encoding of VRIc, VRSa, VRSc insns
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, david@redhat.com, philmd@linaro.org,
 mjt@tls.msk.ru, qemu-stable@nongnu.org
References: <20240117213646.159697-1-richard.henderson@linaro.org>
 <20240117213646.159697-2-richard.henderson@linaro.org>
 <463db12c-cb2c-495c-8dc8-5b0d2085c4bc@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <463db12c-cb2c-495c-8dc8-5b0d2085c4bc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/18/24 17:50, Thomas Huth wrote:
> Do you want to take it through our TCG branch or shall I pick it up for my s390x branch?

I can take it through tcg.


r~


